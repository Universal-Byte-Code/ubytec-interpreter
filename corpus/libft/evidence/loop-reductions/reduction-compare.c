#define _POSIX_C_SOURCE 200809L
#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/mman.h>
#include <unistd.h>
#include <string.h>

typedef uint64_t (*reduce)(uint64_t,uint64_t);
extern uint64_t c_gcc_scalar_bytes(uint64_t,uint64_t),c_clang_scalar_bytes(uint64_t,uint64_t);
extern uint64_t c_gcc_native_bytes(uint64_t,uint64_t),c_clang_native_bytes(uint64_t,uint64_t);
extern uint64_t ubytec_host_register_DiagBytes(uint64_t,uint64_t);
extern uint64_t c_gcc_intrinsic_bytes(uint64_t,uint64_t),c_clang_intrinsic_bytes(uint64_t,uint64_t);
extern uint64_t candidate_scalar4(uint64_t,uint64_t),candidate_sse2(uint64_t,uint64_t),candidate_avx2(uint64_t,uint64_t);
#ifdef WITH_LOOP_REDUCTION
extern uint64_t ubytec_host_loop_DiagBytes(uint64_t,uint64_t);
#endif
struct variant {const char *name; reduce function;};
static struct variant variants[]={
 {"ubytec_frame_registers",ubytec_host_register_DiagBytes},
#ifdef WITH_LOOP_REDUCTION
 {"ubytec_loop_reductions",ubytec_host_loop_DiagBytes},
#endif
 {"gcc_O2_scalar",c_gcc_scalar_bytes},{"clang_O2_scalar",c_clang_scalar_bytes},
 {"gcc_O3_native",c_gcc_native_bytes},{"clang_O3_native",c_clang_native_bytes},
 {"candidate_scalar4",candidate_scalar4},{"candidate_sse2",candidate_sse2},
 {"candidate_avx2",candidate_avx2},
 {"gcc_intrinsics_avx2",c_gcc_intrinsic_bytes},{"clang_intrinsics_avx2",c_clang_intrinsic_bytes}
};
static volatile uint64_t sink;
static void check(int ok){if(!ok){fputs("reduction comparison failed\n",stderr);exit(2);}}
static uint64_t ns(void){struct timespec t;check(!clock_gettime(CLOCK_MONOTONIC,&t));return (uint64_t)t.tv_sec*1000000000+(uint64_t)t.tv_nsec;}
static uint64_t oracle(const unsigned char *p,size_t n){uint64_t sum=0;for(size_t i=0;i<n;i++)sum+=p[i];return sum;}
static uint64_t rng=420109;
static unsigned char random_byte(void){rng^=rng<<13;rng^=rng>>7;rng^=rng<<17;return (unsigned char)rng;}
int main(void){
 int avx2=!!__builtin_cpu_supports("avx2");
 unsigned nv=avx2?sizeof variants/sizeof *variants:7;
#ifdef WITH_LOOP_REDUCTION
 if(!avx2)nv++;
#endif
 unsigned char *buffer=malloc(65536+64);check(buffer!=NULL);
 for(size_t i=0;i<65536+64;i++)buffer[i]=random_byte();
 const size_t sizes[]={0,1,2,3,4,7,8,15,16,17,31,32,33,63,64,65,127,128,129,255,256,4096,65536};
 unsigned checks=0;
 for(unsigned offset=0;offset<32;offset++)for(unsigned s=0;s<sizeof sizes/sizeof *sizes;s++){
  size_t n=sizes[s];uint64_t expected=oracle(buffer+offset,n);
  for(unsigned v=0;v<nv;v++){check(variants[v].function((uint64_t)(uintptr_t)(buffer+offset),n)==expected);checks++;}
 }
 for(unsigned test=0;test<256;test++){
  size_t n=((size_t)random_byte()<<8)|random_byte();uint64_t expected=oracle(buffer,n);
  for(unsigned v=0;v<nv;v++){check(variants[v].function((uint64_t)(uintptr_t)buffer,n)==expected);checks++;}
 }
 /* Put the byte range immediately below an inaccessible page; no overread is allowed. */
 size_t page=(size_t)sysconf(_SC_PAGESIZE);check(page>=4096);
 unsigned char *guard=mmap(NULL,page*3,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);check(guard!=MAP_FAILED);
 check(!mprotect(guard, page, PROT_NONE));check(!mprotect(guard+page*2,page,PROT_NONE));
 for(size_t i=0;i<page;i++)guard[page+i]=random_byte();
 for(unsigned s=0;s<sizeof sizes/sizeof *sizes;s++)if(sizes[s]<=page){
  size_t n=sizes[s];unsigned char *p=guard+page*2-n;uint64_t expected=oracle(p,n);
  for(unsigned v=0;v<nv;v++){check(variants[v].function((uint64_t)(uintptr_t)p,n)==expected);checks++;}
  p=guard+page;expected=oracle(p,n);
  for(unsigned v=0;v<nv;v++){check(variants[v].function((uint64_t)(uintptr_t)p,n)==expected);checks++;}
 }
 check(!munmap(guard,page*3));
 printf("{\"event\":\"validation\",\"checks\":%u,\"variants\":%u,\"avx2\":%s}\n",checks,nv,avx2?"true":"false");
 const size_t timing_sizes[]={256,4096,65536};
 for(unsigned s=0;s<3;s++){
  size_t n=timing_sizes[s],batch=4194304/n;uint64_t expected=oracle(buffer,n);
  for(unsigned sample=0;sample<45;sample++)for(unsigned order=0;order<nv;order++){
   unsigned v=(sample+order)%nv;reduce function=variants[v].function;uint64_t sum=0,start=ns();
   for(size_t repeat=0;repeat<batch;repeat++)sum+=function((uint64_t)(uintptr_t)buffer,n);
   uint64_t elapsed=ns()-start;sink=sum;check(sum==expected*batch);
   if(sample>=5)printf("{\"event\":\"sample\",\"size\":%zu,\"variant\":\"%s\",\"sample\":%u,\"batch\":%zu,\"ns\":%" PRIu64 ",\"result\":%" PRIu64 "}\n",n,variants[v].name,sample-5,batch,elapsed,expected);
  }
 }
 free(buffer);return sink==123456789?3:0;
}
