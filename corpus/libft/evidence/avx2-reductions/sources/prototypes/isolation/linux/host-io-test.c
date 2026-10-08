#define _GNU_SOURCE
#define UBYTEC_HOST_IO 1
#define PROGRAM_LOADER_EMBEDDED 1
#include "program.c"
#undef main
static unsigned checks;
static void check_io(int ok){checks++;if(!ok){fprintf(stderr,"host io check %u\n",checks);exit(1);}}
static struct message request(unsigned handle,unsigned direction,unsigned length,uint64_t offset){return (struct message){6,handle,direction,0,length,0x5542494f,offset,0};}
static struct message execute(struct message req,const void *payload){
    int channels[2];check_io(socketpair(AF_UNIX,SOCK_STREAM,0,channels)==0);
    if(req.invocation==2&&req.length)check_io(write(channels[1],payload,req.length)==(ssize_t)req.length);
    check_io(service_host_io(channels[0],&req,0)==1);
    struct message reply;check_io(read(channels[1],&reply,sizeof reply)==sizeof reply);
    check_io(reply.operation==7&&reply.region==req.region&&reply.invocation==req.invocation&&reply.length==req.length&&!reply.rights&&!reply.ticks);
    if(!reply.checksum&&req.invocation==1&&reply.value){unsigned char bytes[8]={0};check_io(reply.value<=8);check_io(read(channels[1],bytes,(size_t)reply.value)==reply.value);check_io(!memcmp(bytes,&"abc"[req.ticks],(size_t)reply.value));}
    close(channels[0]);close(channels[1]);return reply;
}
int main(void){
    int input=memfd_create("input",MFD_CLOEXEC),output=memfd_create("output",MFD_CLOEXEC);check_io(input>=0&&output>=0);
    check_io(write(input,"abc",3)==3);host_resource_count=2;
    host_resources[0]=(struct host_io_resource){10,1,8,input,3};host_resources[1]=(struct host_io_resource){11,2,8,output,8};
    struct message reply=execute(request(10,1,8,0),NULL);check_io(!reply.checksum&&reply.value==3);
    reply=execute(request(10,1,8,2),NULL);check_io(!reply.checksum&&reply.value==1);
    reply=execute(request(10,1,8,3),NULL);check_io(!reply.checksum&&!reply.value);
    reply=execute(request(10,1,0,0),NULL);check_io(!reply.checksum&&!reply.value);
    reply=execute(request(11,2,3,0),"xyz");check_io(!reply.checksum&&reply.value==3);
    struct message bads[]={request(99,1,1,0),request(11,1,1,0),request(10,2,1,0),request(10,1,9,0),request(10,1,1,4),request(10,1,1,UINT64_MAX),request(11,2,8,1)};
    unsigned char payload[9]={0};
    for(unsigned i=0;i<sizeof bads/sizeof *bads;i++){reply=execute(bads[i],payload);check_io(reply.checksum==1&&!reply.value);}
    unsigned before_requests=serviced_calls;uint64_t before_reads=host_reads,before_writes=host_writes;
    struct message malformed=request(10,1,1,0);
    check_io(service_host_io(-1,&malformed,1)==0);
    malformed.rights=1;check_io(service_host_io(-1,&malformed,0)==0);malformed.rights=0;
    malformed.checksum=0;check_io(service_host_io(-1,&malformed,0)==0);malformed.checksum=0x5542494f;
    malformed.length=65537;check_io(service_host_io(-1,&malformed,0)==0);
    check_io(serviced_calls==before_requests&&host_reads==before_reads&&host_writes==before_writes);
    unsigned char bytes[8]={0};check_io(pread(input,bytes,3,0)==3&&!memcmp(bytes,"abc",3));
    check_io(pread(output,bytes,8,0)==3&&!memcmp(bytes,"xyz",3));
    host_resources[1].fd=-1;reply=execute(request(11,2,1,0),"z");check_io(reply.checksum==2&&!reply.value);
    close(input);close(output);
    printf("{\"accepted\":true,\"checks\":%u,\"denials\":%llu}\n",checks,(unsigned long long)host_denials);return 0;
}
