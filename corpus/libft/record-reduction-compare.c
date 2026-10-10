#define _GNU_SOURCE
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/mman.h>
#include <unistd.h>
typedef uint64_t (*reduce)(uint64_t,uint64_t);
extern uint64_t ubytec_host_reference_DiagRecords(uint64_t,uint64_t),ubytec_host_reduction_DiagRecords(uint64_t,uint64_t);
extern uint64_t c_gcc_scalar(uint64_t,uint64_t),c_clang_scalar(uint64_t,uint64_t),c_gcc_native(uint64_t,uint64_t),c_clang_native(uint64_t,uint64_t);
struct variant {const char *name;reduce fn;};
static const struct variant variants[]={ {"ubytec_frame_registers",ubytec_host_reference_DiagRecords},{"ubytec_record_reductions",ubytec_host_reduction_DiagRecords},
 {"gcc_O2_scalar",c_gcc_scalar},{"clang_O2_scalar",c_clang_scalar},{"gcc_O3_native",c_gcc_native},{"clang_O3_native",c_clang_native} };
static volatile uint64_t sink;
static void check(int ok){if(!ok){fputs("record comparison failed\n",stderr);exit(2);}}
static uint64_t ns(void){struct timespec t;check(!clock_gettime(CLOCK_MONOTONIC,&t));return (uint64_t)t.tv_sec*1000000000+(uint64_t)t.tv_nsec;}
static uint64_t oracle(const unsigned char *p,size_t n){uint64_t sum=0;for(size_t i=0;i<n;i++){uint64_t v=0;for(unsigned j=0;j<8;j++)v|=(uint64_t)p[i*24+16+j]<<(8*j);sum+=v;}return sum;}
static unsigned checks;
static void validate(const unsigned char *p,size_t n){uint64_t expected=oracle(p,n);for(unsigned v=0;v<6;v++){check(variants[v].fn((uintptr_t)p,n)==expected);checks++;}}
int main(int argc,char **argv){
 check(argc==1||(argc==2&&!strcmp(argv[1],"--verify-only")));
 const size_t capacity=65536;unsigned char *p=malloc(capacity*24+64);check(p!=NULL);uint64_t rng=420111;
 for(size_t i=0;i<capacity*24+64;i++){rng^=rng<<13;rng^=rng>>7;rng^=rng<<17;p[i]=(unsigned char)rng;}
 const size_t sizes[]={0,1,2,3,7,8,15,16,17,31,32,33,63,64,65,127,128,129,255,256,4096,65536};
 for(unsigned offset=0;offset<32;offset++)for(unsigned s=0;s<sizeof sizes/sizeof *sizes;s++)validate(p+offset,sizes[s]);
 for(unsigned i=0;i<128;i++){rng^=rng<<13;rng^=rng>>7;rng^=rng<<17;validate(p,(size_t)(rng%4097));}
 size_t page=sysconf(_SC_PAGESIZE);check(page>=4096);
 unsigned char *guard=mmap(NULL,page*3,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);check(guard!=MAP_FAILED);
 check(!mprotect(guard+page,page,PROT_READ|PROT_WRITE));memcpy(guard+page,p,page);
 for(size_t n=0;n<=page/24;n++){validate(guard+page*2-n*24,n);validate(guard+page,n);}
 check(!munmap(guard,page*3));
 printf("{\"event\":\"validation\",\"checks\":%u,\"variants\":6,\"stride\":24,\"offset\":16}\n",checks);
 if(argc==2){free(p);return 0;}
 const size_t timing[]={4,64,256,4096,65536};
 for(unsigned s=0;s<sizeof timing/sizeof *timing;s++){
  size_t n=timing[s],batch=65536/n;uint64_t expected=oracle(p,n);
  for(unsigned sample=0;sample<45;sample++)for(unsigned order=0;order<6;order++){
   unsigned v=(sample+order)%6;uint64_t sum=0,start=ns();
   for(size_t repeat=0;repeat<batch;repeat++)sum+=variants[v].fn((uintptr_t)p,n);
   uint64_t elapsed=ns()-start;sink=sum;check(sum==expected*batch);
   if(sample>=5)printf("{\"event\":\"sample\",\"records\":%zu,\"variant\":\"%s\",\"sample\":%u,\"batch\":%zu,\"ns\":%llu,\"result\":%llu}\n",n,variants[v].name,sample-5,batch,(unsigned long long)elapsed,(unsigned long long)expected);
  }
 }
 free(p);return sink==123456789?3:0;
}
