/* Trusted native client of the compiled Ubytec arena. No sandbox timing here. */
#define _POSIX_C_SOURCE 200809L
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define F(n) ubytec_host_contract_##n
extern uint64_t F(ArenaInit)(uint64_t,uint64_t);
extern uint64_t F(ArenaAlloc)(uint64_t,uint64_t);
extern uint64_t F(ArenaResize)(uint64_t,uint64_t,uint64_t);
extern uint64_t F(ArenaFree)(uint64_t,uint64_t);
extern uint64_t F(ArenaFind)(uint64_t,uint64_t);
extern uint64_t F(ArenaPin)(uint64_t,uint64_t);
extern uint64_t F(ArenaUnpin)(uint64_t,uint64_t);
extern uint64_t F(ArenaAppendUpper)(uint64_t,uint64_t,uint64_t,uint64_t,uint64_t);
static _Alignas(16) unsigned char backing[65536+48],snapshot[65536+16];
struct slot {uint64_t p,n,pins;unsigned char bytes[2048];};
static struct slot slots[32];
static uint64_t rng,arena,capacity,failures,operations,peak_used,peak_holes,max_blocks,fragmentation_permille;
static uint64_t get(uint64_t p){uint64_t v;memcpy(&v,(void *)(uintptr_t)p,8);return v;}
static void require(int ok){if(!ok){fprintf(stderr,"stress invariant failed: cap=%llu rng=%llu ops=%llu\n",(unsigned long long)capacity,(unsigned long long)rng,(unsigned long long)operations);exit(2);}}
static uint64_t next(void){rng^=rng<<13;rng^=rng>>7;rng^=rng<<17;return rng;}
static uint64_t now(void){struct timespec t;require(!clock_gettime(CLOCK_MONOTONIC,&t));return (uint64_t)t.tv_sec*1000000000u+(uint64_t)t.tv_nsec;}
static void verify(void){
 uint64_t used=get(arena+8),cursor=0,live=0,holes=0,blocks=0,largest=0;int was_free=0;
 require(get(arena)==capacity&&used<=capacity);
 for(unsigned i=0;i<16;i++)require(backing[i]==0xa5&&backing[32+capacity+i]==0xa5);
 for(unsigned i=0;i<32;i++)if(slots[i].p){struct slot *s=&slots[i];uint64_t h=F(ArenaFind)(arena,s->p);require(h==s->p-32);require(get(h+8)==s->n&&get(h+24)==s->pins);require(!memcmp((void *)(uintptr_t)s->p,s->bytes,s->n));++live;}
 uint64_t found=0;
 while(cursor<used){uint64_t h=arena+16+cursor,cap=get(h),n=get(h+8),active=get(h+16);require(used-cursor>=40&&cap>=8&&cap%8==0&&cap<=used-cursor-32&&n<=cap&&active<=1);++blocks;
   if(active){unsigned matches=0;for(unsigned i=0;i<32;i++)if(slots[i].p==h+32)++matches;require(matches==1&&n);++found;was_free=0;}
   else{require(!was_free&&!n&&!get(h+24));holes+=cap;if(cap>largest)largest=cap;was_free=1;}
   cursor+=32+cap;
 }
 require(cursor==used&&found==live&&!was_free);
 if(used>peak_used)peak_used=used;
 uint64_t tail=capacity-used>=40?capacity-used-32:0,total=holes+tail;if(tail>largest)largest=tail;
 if(total){uint64_t value=(total-largest)*1000/total;if(value>fragmentation_permille)fragmentation_permille=value;}
 if(holes>peak_holes)peak_holes=holes;
 if(blocks>max_blocks)max_blocks=blocks;
}
static void oom(void){
 memcpy(snapshot,(void *)(uintptr_t)arena,capacity+16);
 require(!F(ArenaAlloc)(arena,capacity));++failures;++operations;
 require(!memcmp(snapshot,(void *)(uintptr_t)arena,capacity+16));
 for(unsigned i=0;i<32;i++)if(slots[i].p&&!slots[i].pins){require(!F(ArenaResize)(arena,slots[i].p,capacity));++failures;++operations;require(!memcmp(snapshot,(void *)(uintptr_t)arena,capacity+16));break;}
}
static void action(void){
 struct slot *s=&slots[next()%32];unsigned op=(unsigned)(next()%5);++operations;
 if(!s->p){uint64_t n=1+next()%1536,p=F(ArenaAlloc)(arena,n);if(!p){++failures;return;}s->p=p;s->n=n;s->pins=0;
   for(uint64_t j=0;j<n;j++){require(!((unsigned char *)(uintptr_t)p)[j]);s->bytes[j]=(unsigned char)next();}memcpy((void *)(uintptr_t)p,s->bytes,n);
 }else if(op==0){uint64_t ok=F(ArenaFree)(arena,s->p);require(ok==(s->pins?0:1));if(ok)memset(s,0,sizeof *s);
 }else if(op==1){uint64_t n=1+next()%2048,p=F(ArenaResize)(arena,s->p,n);if(s->pins){require(!p);return;}if(!p){++failures;return;}require(!memcmp((void *)(uintptr_t)p,s->bytes,n<s->n?n:s->n));
   for(uint64_t j=s->n;j<n;j++){require(!((unsigned char *)(uintptr_t)p)[j]);s->bytes[j]=(unsigned char)next();}s->p=p;s->n=n;memcpy((void *)(uintptr_t)p,s->bytes,n);
 }else if(op==2){require(F(ArenaPin)(arena,s->p)==1);++s->pins;
 }else if(op==3){uint64_t ok=F(ArenaUnpin)(arena,s->p);require(ok==(s->pins?1:0));if(ok)--s->pins;
 }else{uint64_t j=next()%s->n;s->bytes[j]=(unsigned char)next();((unsigned char *)(uintptr_t)s->p)[j]=s->bytes[j];}
}
static void drain(void){for(unsigned i=0;i<32;i++){struct slot *s=&slots[i];while(s->pins){require(F(ArenaUnpin)(arena,s->p)==1);--s->pins;}if(s->p){require(F(ArenaFree)(arena,s->p)==1);memset(s,0,sizeof *s);}}verify();require(get(arena+8)==0);}
static void applications(unsigned epoch){
 /* Explicit pending-state records, variable depth, growth and unwind. */
 uint64_t depth=1+next()%96,p=F(ArenaAlloc)(arena,16),reserved=16;require(p!=0);
 for(uint64_t i=0;i<depth;i++){if((i+1)*16>reserved){uint64_t q=F(ArenaResize)(arena,p,reserved*2);require(q!=0);p=q;reserved*=2;}uint64_t pair[2]={i,i*7+epoch};memcpy((void *)(uintptr_t)(p+i*16),pair,16);}
 for(uint64_t i=depth;i>0;i--){require(get(p+(i-1)*16)==i-1&&get(p+(i-1)*16+8)==(i-1)*7+epoch);}
 require(F(ArenaFree)(arena,p)==1&&get(arena+8)==0);
 unsigned char text[31],expected[1536];for(unsigned i=0;i<31;i++)text[i]=(unsigned char)('a'+i%26);
 uint64_t length=1+next()%1536,used=0;p=0;
 while(used<length){uint64_t count=1+next()%31;if(count>length-used)count=length-used;p=F(ArenaAppendUpper)(arena,p,used,(uint64_t)(uintptr_t)text,count);require(p!=0);for(uint64_t i=0;i<count;i++)require(((unsigned char *)(uintptr_t)p)[used+i]==text[i]-32);for(uint64_t i=0;i<count;i++)expected[used+i]=(unsigned char)(text[i]-32);used+=count;require(!memcmp((void *)(uintptr_t)p,expected,used));require(!((unsigned char *)(uintptr_t)p)[used]);}
 require(F(ArenaFree)(arena,p)==1&&get(arena+8)==0);
 /* Recovery: allocate almost the entire backing again, without ArenaInit. */
 p=F(ArenaAlloc)(arena,capacity-32);require(p!=0);memset((void *)(uintptr_t)p,0x3c,capacity-32);require(F(ArenaFree)(arena,p)==1&&get(arena+8)==0);
 for(unsigned i=0;i<16;i++)require(backing[i]==0xa5&&backing[32+capacity+i]==0xa5);
}
int main(void){
 static const uint64_t capacities[]={4096,16384,65536},seeds[]={42045,0x123456789abcdefu};
 for(unsigned c=0;c<3;c++)for(unsigned seed=0;seed<2;seed++){
   capacity=capacities[c];rng=seeds[seed];arena=(uint64_t)(uintptr_t)(backing+16);failures=operations=peak_used=peak_holes=max_blocks=fragmentation_permille=0;memset(backing,0xa5,sizeof backing);memset(slots,0,sizeof slots);require(F(ArenaInit)(arena,capacity)==1);
   for(unsigned epoch=0;epoch<24;epoch++){
     uint64_t begin=now();for(unsigned step=0;step<512;step++){action();verify();if(step%64==0){oom();verify();}}drain();applications(epoch);uint64_t elapsed=now()-begin;
     printf("{\"event\":\"epoch\",\"capacity\":%llu,\"seed\":%u,\"epoch\":%u,\"steps\":512,\"ns\":%llu,\"used_after\":%llu}\n",(unsigned long long)capacity,seed,epoch,(unsigned long long)elapsed,(unsigned long long)get(arena+8));
   }
   printf("{\"event\":\"summary\",\"capacity\":%llu,\"seed\":%u,\"epochs\":24,\"operations\":%llu,\"failures\":%llu,\"peak_used\":%llu,\"peak_hole_payload\":%llu,\"max_blocks\":%llu,\"peak_external_fragmentation_permille\":%llu,\"used_after\":%llu}\n",(unsigned long long)capacity,seed,(unsigned long long)operations,(unsigned long long)failures,(unsigned long long)peak_used,(unsigned long long)peak_holes,(unsigned long long)max_blocks,(unsigned long long)fragmentation_permille,(unsigned long long)get(arena+8));
 }
 return 0;
}
