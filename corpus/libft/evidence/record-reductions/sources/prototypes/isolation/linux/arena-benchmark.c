/* Trusted same-process workload harness for compiled Ubytec allocators.
 * Measures allocator/client computation, not process/seccomp boundaries. */
#define _POSIX_C_SOURCE 200809L
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define DECLARE(prefix) \
extern uint64_t prefix##ArenaInit(uint64_t,uint64_t); \
extern uint64_t prefix##ArenaAlloc(uint64_t,uint64_t); \
extern uint64_t prefix##ArenaFree(uint64_t,uint64_t); \
extern uint64_t prefix##ArenaResize(uint64_t,uint64_t,uint64_t); \
extern uint64_t prefix##ArenaAppendUpper(uint64_t,uint64_t,uint64_t,uint64_t,uint64_t);
DECLARE(ubytec_host_contract_)
DECLARE(baseline_ubytec_host_contract_)
struct api {
 uint64_t (*init)(uint64_t,uint64_t),(*alloc)(uint64_t,uint64_t),(*free)(uint64_t,uint64_t);
 uint64_t (*resize)(uint64_t,uint64_t,uint64_t),(*append)(uint64_t,uint64_t,uint64_t,uint64_t,uint64_t);
};
#define API(prefix) {prefix##ArenaInit,prefix##ArenaAlloc,prefix##ArenaFree,prefix##ArenaResize,prefix##ArenaAppendUpper}
static struct api apis[2]={API(baseline_ubytec_host_contract_),API(ubytec_host_contract_)};
static _Alignas(16) unsigned char memory[65536+32];
static volatile uint64_t sink;
struct metrics {uint64_t peak_used,copied_bytes,moves,failures,calls,completed,checksum;};
static uint64_t read64(uint64_t pointer) {uint64_t n;memcpy(&n,(void *)(uintptr_t)pointer,8);return n;}
static void sample(struct metrics *m,uint64_t arena) {if(m){uint64_t n=read64(arena+8);if(n>m->peak_used)m->peak_used=n;}}
static uint64_t alloc(struct api *a,uint64_t arena,uint64_t n,struct metrics *m){uint64_t p=a->alloc(arena,n);if(m){++m->calls;if(!p)++m->failures;}sample(m,arena);return p;}
static void release(struct api *a,uint64_t arena,uint64_t p,struct metrics *m){if(p){if(!a->free(arena,p)){fputs("free failed\n",stderr);exit(2);}if(m)++m->calls;sample(m,arena);}}
static uint64_t resize(struct api *a,uint64_t arena,uint64_t p,uint64_t n,struct metrics *m){uint64_t old=read64(p-24),fresh=a->resize(arena,p,n);if(m){++m->calls;if(!fresh)++m->failures;else if(fresh!=p){++m->moves;m->copied_bytes+=old;}}sample(m,arena);return fresh;}
static void verify(int yes){if(!yes){fputs("workload corruption\n",stderr);exit(2);}}
static void workload(unsigned kind,struct api *a,struct metrics *m){
 uint64_t capacity=(kind==0||kind==1)?16384:(kind==2?512:kind==3?384:8192),arena=(uint64_t)(uintptr_t)memory;
 memset(memory+16+capacity,0xa5,16);verify(a->init(arena,capacity)==1);if(m)++m->calls;
 uint64_t checksum=0,completed=0;
 if(kind==0||kind==4){
   unsigned char text[64];for(unsigned j=0;j<64;j++)text[j]=(unsigned char)('a'+j%26);
   uint64_t p=0,used=0;
   while(used<4095){uint64_t n=4095-used;if(n>64)n=64;uint64_t old=p?read64(p-24):0;
     uint64_t fresh=a->append(arena,p,used,(uint64_t)(uintptr_t)text,n);
     if(m){++m->calls;if(!fresh)++m->failures;else if(p&&fresh!=p){++m->moves;m->copied_bytes+=old;}}sample(m,arena);
     if(!fresh)break;
     p=fresh;for(uint64_t j=0;j<n;j++)verify(((unsigned char *)(uintptr_t)p)[used+j]==(unsigned char)(text[j]-32));used+=n;verify(((unsigned char *)(uintptr_t)p)[used]==0);
   }
   for(uint64_t j=0;j<used;j++)verify(((unsigned char *)(uintptr_t)p)[j]==(unsigned char)(text[j%64]-32));
   completed=used;checksum=used;release(a,arena,p,m);
 } else if(kind==1||kind==5){
   uint64_t p=alloc(a,arena,16,m),reserved=16,depth=0;verify(p!=0);
   for(uint64_t i=0;i<256;i++){
     uint64_t need=(i+1)*16;if(need>reserved){uint64_t fresh=resize(a,arena,p,reserved*2,m);if(!fresh)break;p=fresh;reserved*=2;}
     uint64_t values[2]={i,i*3+5};memcpy((void *)(uintptr_t)(p+i*16),values,16);++depth;
   }
   completed=depth;
   while(depth){--depth;verify(read64(p+depth*16)==depth);verify(read64(p+depth*16+8)==depth*3+5);checksum+=read64(p+depth*16+8);
     if(depth)verify(resize(a,arena,p,depth*16,m)==p);
   }
   release(a,arena,p,m);
 } else if(kind==2){
   uint64_t left=alloc(a,arena,16,m),hole=alloc(a,arena,256,m),right=alloc(a,arena,16,m);verify(left&&hole&&right);
   *(unsigned char *)(uintptr_t)left=71;*(unsigned char *)(uintptr_t)right=72;release(a,arena,hole,m);
   for(unsigned round=0;round<8;round++){
     uint64_t p[3];for(unsigned j=0;j<3;j++){p[j]=alloc(a,arena,80,m);if(p[j]){++completed;memset((void *)(uintptr_t)p[j],(int)(j+1),80);}}
     for(unsigned j=0;j<3;j++)if(p[j])for(unsigned k=0;k<80;k++)verify(((unsigned char *)(uintptr_t)p[j])[k]==j+1);
     for(unsigned j=3;j>0;j--)release(a,arena,p[j-1],m);
   }
   verify(*(unsigned char *)(uintptr_t)left==71&&*(unsigned char *)(uintptr_t)right==72);checksum=completed;release(a,arena,right,m);release(a,arena,left,m);
 } else {
   uint64_t left=alloc(a,arena,16,m),one=alloc(a,arena,64,m),two=alloc(a,arena,64,m),right=alloc(a,arena,16,m);verify(left&&one&&two&&right);
   *(unsigned char *)(uintptr_t)left=73;*(unsigned char *)(uintptr_t)right=74;release(a,arena,one,m);release(a,arena,two,m);
   uint64_t p=alloc(a,arena,128,m);if(p){memset((void *)(uintptr_t)p,75,128);for(unsigned k=0;k<128;k++)verify(((unsigned char *)(uintptr_t)p)[k]==75);completed=128;}
   verify(*(unsigned char *)(uintptr_t)left==73&&*(unsigned char *)(uintptr_t)right==74);checksum=completed;release(a,arena,p,m);release(a,arena,right,m);release(a,arena,left,m);
 }
 verify(read64(arena+8)==0);for(unsigned i=0;i<16;i++)verify(memory[16+capacity+i]==0xa5);
 if(m){m->completed=completed;m->checksum=checksum;}sink+=checksum;
}
static uint64_t now(void){struct timespec t;verify(!clock_gettime(CLOCK_MONOTONIC,&t));return (uint64_t)t.tv_sec*1000000000u+(uint64_t)t.tv_nsec;}
int main(void){
 static const char *names[]={"text_growth","pending_state","split_churn","coalesce_holes","text_tight","state_tight"};
 const unsigned batch=100,samples=100,warmup=10;
 for(unsigned k=0;k<6;k++){
   for(unsigned v=0;v<2;v++){struct metrics m={0};workload(k,&apis[v],&m);
     printf("{\"event\":\"resources\",\"case\":\"%s\",\"variant\":%u,\"peak_used\":%llu,\"copied_bytes\":%llu,\"moves\":%llu,\"failures\":%llu,\"calls\":%llu,\"completed\":%llu,\"checksum\":%llu}\n",names[k],v,(unsigned long long)m.peak_used,(unsigned long long)m.copied_bytes,(unsigned long long)m.moves,(unsigned long long)m.failures,(unsigned long long)m.calls,(unsigned long long)m.completed,(unsigned long long)m.checksum);
   }
   for(unsigned i=0;i<warmup+samples;i++)for(unsigned order=0;order<2;order++){unsigned v=(i+order)%2;uint64_t begin=now();for(unsigned j=0;j<batch;j++)workload(k,&apis[v],NULL);uint64_t elapsed=now()-begin;
     if(i>=warmup)printf("{\"event\":\"sample\",\"case\":\"%s\",\"variant\":%u,\"batch\":%u,\"ns\":%llu}\n",names[k],v,batch,(unsigned long long)elapsed);
   }
 }
 return 0;
}
