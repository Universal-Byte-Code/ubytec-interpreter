#define _GNU_SOURCE
/* Trusted file/resource broker for the streaming Ubytec text application. */
#include <stdint.h>
static int64_t text_result;
static int text_completed;
#define UBYTEC_HOST_IO 1
#define PROGRAM_LOADER_EMBEDDED 1
#define UBYTEC_PROGRAM_RESULT_HOOK(r) do {text_result=(r).outcome.value;text_completed=successful(r);} while(0)
#include "program.c"
#undef main

static void text_usage(void){fprintf(stderr,"usage: text-host --caller app.elf --input input --output output [--arena 0..65248] [--chunk 1..4096] [--quota bytes] [--deny-read] [--deny-write]\n");}
static int number(const char *text,uint64_t maximum,uint64_t *value){char *end;errno=0;if(!*text || *text=='-')return 0;unsigned long long n=strtoull(text,&end,10);if(errno || *end || n>maximum)return 0;*value=n;return 1;}
static void cell(unsigned char *packet,unsigned offset,uint64_t value){memcpy(packet+offset,&value,8);}
int main(int argc,char **argv){
    if(argc>1 && !strcmp(argv[1],"--module-worker")) module_worker(argc,argv);
    const char *module=NULL,*input_path=NULL,*output_path=NULL;uint64_t capacity=65248,chunk=4096,quota=8388608;int read_right=1,write_right=2;
    for(int i=1;i<argc;i++){
        if(!strcmp(argv[i],"--deny-read")){read_right=0;continue;}
        if(!strcmp(argv[i],"--deny-write")){write_right=0;continue;}
        if(i+1==argc){text_usage();return 2;}
        const char *key=argv[i],*value=argv[++i];
        if(!strcmp(key,"--caller"))module=value;
        else if(!strcmp(key,"--input"))input_path=value;
        else if(!strcmp(key,"--output"))output_path=value;
        else if(!strcmp(key,"--arena")){if(!number(value,65248,&capacity)){text_usage();return 2;}}
        else if(!strcmp(key,"--chunk")){if(!number(value,4096,&chunk)||!chunk){text_usage();return 2;}}
        else if(!strcmp(key,"--quota")){if(!number(value,INT64_MAX,&quota)){text_usage();return 2;}}
        else {text_usage();return 2;}
    }
    if(!module||!input_path||!output_path||!strcmp(input_path,output_path)){text_usage();return 2;}
    int input=open(input_path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW|O_NONBLOCK);struct stat in_stat,out_stat;
    if(input<0||fstat(input,&in_stat)||!S_ISREG(in_stat.st_mode)||in_stat.st_size<0){if(input>=0)close(input);perror("regular input");return 2;}
    if(!stat(output_path,&out_stat)&&in_stat.st_dev==out_stat.st_dev&&in_stat.st_ino==out_stat.st_ino){close(input);fprintf(stderr,"input/output must be distinct files\n");return 2;}
    char staging[4096];if(snprintf(staging,sizeof staging,"%s.ubytec-XXXXXX",output_path)>=(int)sizeof staging){close(input);return 2;}
    int output=mkstemp(staging);if(output<0){close(input);perror("staged output");return 2;}fcntl(output,F_SETFD,FD_CLOEXEC);
    char config_name[]="/tmp/ubytec-text-config-XXXXXX",result_name[]="/tmp/ubytec-text-result-XXXXXX";
    int config=mkstemp(config_name),result=mkstemp(result_name);int ok=0;
    int config_created=config>=0,result_created=result>=0;
    if(config<0||result<0)goto finish;
    unsigned char packet[65536];memset(packet,0,sizeof packet);memset(packet+65520,0xa5,16);
    cell(packet,40,chunk);cell(packet,48,capacity);cell(packet,56,0x101);cell(packet,64,0x102);
    if(write(config,packet,sizeof packet)!=sizeof packet)goto finish;
    close(config);config=-1;close(result);result=-1;
    host_resources[0]=(struct host_io_resource){0x101,(uint32_t)read_right,4096,input,(uint64_t)in_stat.st_size};
    host_resources[1]=(struct host_io_resource){0x102,(uint32_t)write_right,4096,output,quota};host_resource_count=2;
    char *program_args[]={argv[0],"--contracts",(char *)module,"TextMain","--input",config_name,"--output",result_name,NULL};
    int status=program_cli_main(8,program_args);
    int fd=open(result_name,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);
    ssize_t got=fd<0?-1:read(fd,packet,sizeof packet);if(fd>=0)close(fd);
    uint64_t bytes=0,words=0,unique=0,emitted=0,used=UINT64_MAX;
    if(got==sizeof packet){memcpy(&bytes,packet,8);memcpy(&words,packet+8,8);memcpy(&unique,packet+16,8);memcpy(&emitted,packet+24,8);memcpy(&used,packet+264,8);}
    ok=!status&&text_completed&&text_result==0&&got==sizeof packet&&used==0;
    for(unsigned i=65520;i<65536;i++)ok &= packet[i]==0xa5;
    if(ok&&(fsync(output)||rename(staging,output_path)))ok=0;
    printf("{\"event\":\"text-result\",\"accepted\":%s,\"completed\":%s,\"value\":%lld,\"bytes\":%llu,\"words\":%llu,\"unique\":%llu,\"emitted\":%llu,\"arena_used_after\":%llu,\"read_calls\":%llu,\"write_calls\":%llu,\"denials\":%llu,\"read_bytes\":%llu,\"write_bytes\":%llu}\n",
        ok?"true":"false",text_completed?"true":"false",(long long)text_result,(unsigned long long)bytes,(unsigned long long)words,(unsigned long long)unique,(unsigned long long)emitted,(unsigned long long)used,(unsigned long long)host_reads,(unsigned long long)host_writes,(unsigned long long)host_denials,(unsigned long long)host_read_bytes,(unsigned long long)host_write_bytes);
finish:
    if(config>=0)close(config);
    if(result>=0)close(result);
    if(config_created)unlink(config_name);
    if(result_created)unlink(result_name);
    close(input);close(output);if(!ok)unlink(staging);
    return ok?0:1;
}
