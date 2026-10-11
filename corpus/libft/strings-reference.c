/* Independent libc-based references and guarded native Ubytec execution. */
#define _GNU_SOURCE
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <sys/resource.h>
#include <unistd.h>
#define F(n) ubytec_host_contract_##n
extern uint64_t F(ft_strchr)(uint64_t,int32_t),F(ft_strrchr)(uint64_t,int32_t);
extern uint64_t F(ft_memchr)(uint64_t,int32_t,uint64_t),F(ft_strnlen)(uint64_t,uint64_t);
extern int32_t F(ft_strncmp)(uint64_t,uint64_t,uint64_t);
extern uint64_t F(ft_strlcpy)(uint64_t,uint64_t,uint64_t),F(ft_strlcat)(uint64_t,uint64_t,uint64_t),F(ft_strnstr)(uint64_t,uint64_t,uint64_t);
extern uint64_t F(ft_strdup_arena)(uint64_t,uint64_t),F(ft_substr_arena)(uint64_t,uint64_t,uint64_t,uint64_t),F(ft_strjoin_arena)(uint64_t,uint64_t,uint64_t);
extern uint64_t F(ArenaInit)(uint64_t,uint64_t),F(ArenaAlloc)(uint64_t,uint64_t),F(ArenaFree)(uint64_t,uint64_t),F(ArenaPin)(uint64_t,uint64_t),F(ArenaUnpin)(uint64_t,uint64_t);
extern uint64_t F(UnsignedDiv)(uint64_t,uint64_t),F(UnsignedMod)(uint64_t,uint64_t),F(LogicalShift)(uint64_t,uint64_t);
extern uint64_t F(UnsignedLt)(uint64_t,uint64_t),F(UnsignedLe)(uint64_t,uint64_t),F(UnsignedGt)(uint64_t,uint64_t),F(UnsignedGe)(uint64_t,uint64_t);
static uint64_t checks,rng=42047;
static void check(int ok,int line){++checks;if(!ok){fprintf(stderr,"reference mismatch line %d, check %llu\n",line,(unsigned long long)checks);exit(2);}}
#define CHECK(x) check(!!(x),__LINE__)
static uint64_t addr(const void *p){return (uint64_t)(uintptr_t)p;}
static uint64_t next(void){rng^=rng<<13;rng^=rng>>7;rng^=rng<<17;return rng;}
static int sign(int n){return (n>0)-(n<0);}
struct guard{unsigned char *mapping,*p;size_t page,n;};
static struct guard guarded(const void *bytes,size_t n){size_t page=(size_t)sysconf(_SC_PAGESIZE);CHECK(n<page);unsigned char *m=mmap(NULL,2*page,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);CHECK(m!=MAP_FAILED);CHECK(!mprotect(m+page,page,PROT_NONE));memset(m,0xa5,page);unsigned char *p=m+page-n;if(n)memcpy(p,bytes,n);return (struct guard){m,p,page,n};}
static void destroy(struct guard g){CHECK(g.p[-1]==0xa5);CHECK(!munmap(g.mapping,2*g.page));}
static size_t ref_copy(char *dst,const char *src,size_t capacity){size_t n=strlen(src);if(capacity){size_t k=n<capacity-1?n:capacity-1;memcpy(dst,src,k);dst[k]=0;}return n;}
static size_t ref_cat(char *dst,const char *src,size_t capacity){char *end=memchr(dst,0,capacity);size_t n=strlen(src),used=end?(size_t)(end-dst):capacity;if(end)ref_copy(end,src,capacity-used);return used+n;}
static const char *ref_find(const char *hay,const char *needle,size_t limit){size_t n=strlen(needle);if(!n)return hay;size_t h=strnlen(hay,limit);if(n>h)return NULL;for(size_t i=0;i<=h-n;i++)if(!memcmp(hay+i,needle,n))return hay+i;return NULL;}
static void strings(void){
 for(unsigned round=0;round<512;round++){
   unsigned char h[129],b[129],needle[17];size_t hn=next()%128,bn=next()%128,nn=next()%16;
   for(size_t j=0;j<hn;j++)h[j]=(unsigned char)(1+next()%255);
   for(size_t j=0;j<bn;j++)b[j]=(unsigned char)(1+next()%255);
   for(size_t j=0;j<nn;j++)needle[j]=(unsigned char)(1+next()%255);
   if(round%3==0&&hn){nn=hn<8?hn:8;memcpy(needle,h+hn-nn,nn);}
   h[hn]=b[bn]=needle[nn]=0;
   if(round%11==0&&hn)h[hn/2]=0;
   struct guard hg=guarded(h,hn+1),bg=guarded(b,bn+1),ng=guarded(needle,nn+1);
   int c=(int)(next()%1024)-512;
   CHECK(F(ft_strchr)(addr(hg.p),c)==addr(strchr((char *)hg.p,(unsigned char)c)));
   CHECK(F(ft_strrchr)(addr(hg.p),c)==addr(strrchr((char *)hg.p,(unsigned char)c)));
   CHECK(F(ft_strchr)(addr(hg.p),0)==addr(strchr((char *)hg.p,0)));
   uint64_t limits[]={0,1,next()%140,UINT64_C(1)<<63,UINT64_MAX};
   for(unsigned j=0;j<5;j++){
     CHECK(sign(F(ft_strncmp)(addr(hg.p),addr(bg.p),limits[j]))==sign(strncmp((char *)hg.p,(char *)bg.p,(size_t)limits[j])));
     CHECK(F(ft_strnstr)(addr(hg.p),addr(ng.p),limits[j])==addr(ref_find((char *)hg.p,(char *)ng.p,(size_t)limits[j])));
     CHECK(F(ft_strnlen)(addr(hg.p),limits[j])==strnlen((char *)hg.p,(size_t)limits[j]));
   }
   size_t n=next()%(hn+2);CHECK(F(ft_memchr)(addr(hg.p),c,n)==addr(memchr(hg.p,(unsigned char)c,n)));
   unsigned char initial[160],expected[160];memset(initial,0xa5,sizeof initial);size_t cap=next()%160;struct guard dst=guarded(initial,cap);
   memcpy(expected,initial,sizeof initial);CHECK(F(ft_strlcpy)(addr(dst.p),addr(hg.p),cap)==ref_copy((char *)expected,(char *)hg.p,cap));CHECK(!memcmp(dst.p,expected,cap));destroy(dst);
   size_t used=cap?next()%(cap+1):0;memset(initial,'a',sizeof initial);if(used<cap)initial[used]=0;memcpy(expected,initial,sizeof initial);dst=guarded(initial,cap);
   CHECK(F(ft_strlcat)(addr(dst.p),addr(hg.p),cap)==ref_cat((char *)expected,(char *)hg.p,cap));CHECK(!memcmp(dst.p,expected,cap));destroy(dst);
   CHECK(!memcmp(hg.p,h,hn+1)&&!memcmp(bg.p,b,bn+1)&&!memcmp(ng.p,needle,nn+1));destroy(hg);destroy(bg);destroy(ng);
 }
 /* Exact bounded prefixes without a terminating byte in the readable region. */
 unsigned char prefix[]={65,66,67,255};struct guard h=guarded(prefix,4),needle=guarded("C\xff",3);
 CHECK(F(ft_strnstr)(addr(h.p),addr(needle.p),4)==addr(h.p+2));CHECK(F(ft_strnstr)(addr(h.p),addr(needle.p),3)==0);
 CHECK(F(ft_strnlen)(addr(h.p),4)==4);CHECK(F(ft_memchr)(addr(h.p),0,4)==0);CHECK(F(ft_strncmp)(addr(h.p),addr(h.p),4)==0);destroy(h);destroy(needle);
}
static uint64_t read64(const void *p){uint64_t n;memcpy(&n,p,8);return n;}
static void allocated(void){
 unsigned char backing[4096+48],snapshot[4096+16];memset(backing,0xa5,sizeof backing);uint64_t arena=addr(backing+16);CHECK(F(ArenaInit)(arena,4096)==1);
 for(unsigned round=0;round<256;round++){
   unsigned char a[257],b[257];size_t an=next()%256,bn=next()%256;for(size_t i=0;i<an;i++)a[i]=(unsigned char)(1+next()%255);for(size_t i=0;i<bn;i++)b[i]=(unsigned char)(1+next()%255);a[an]=b[bn]=0;
   struct guard ag=guarded(a,an+1),bg=guarded(b,bn+1);uint64_t q=F(ft_strdup_arena)(arena,addr(ag.p));CHECK(q!=0);CHECK(!memcmp((void *)(uintptr_t)q,a,an+1));CHECK(F(ArenaFree)(arena,q)==1);
   uint64_t starts[]={0,an/2,an,UINT64_MAX},counts[]={0,1,UINT64_MAX};
   for(unsigned i=0;i<4;i++)for(unsigned j=0;j<3;j++){uint64_t start=starts[i],count=counts[j];size_t n=start>=an?0:(count>an-start?(size_t)(an-start):(size_t)count);q=F(ft_substr_arena)(arena,addr(ag.p),start,count);CHECK(q!=0);if(n)CHECK(!memcmp((void *)(uintptr_t)q,a+start,n));CHECK(!((unsigned char *)(uintptr_t)q)[n]);CHECK(F(ArenaFree)(arena,q)==1);}
   unsigned char expected[513];memcpy(expected,a,an);memcpy(expected+an,b,bn+1);q=F(ft_strjoin_arena)(arena,addr(ag.p),addr(bg.p));CHECK(q!=0);CHECK(!memcmp((void *)(uintptr_t)q,expected,an+bn+1));CHECK(F(ArenaFree)(arena,q)==1);
   uint64_t full=F(ArenaAlloc)(arena,4096-32);CHECK(full!=0);CHECK(F(ArenaPin)(arena,full)==1);memcpy(snapshot,backing+16,sizeof snapshot);
   CHECK(!F(ft_strdup_arena)(arena,addr(ag.p)));CHECK(!memcmp(snapshot,backing+16,sizeof snapshot));
   CHECK(!F(ft_substr_arena)(arena,addr(ag.p),0,1));CHECK(!memcmp(snapshot,backing+16,sizeof snapshot));
   CHECK(!F(ft_strjoin_arena)(arena,addr(ag.p),addr(bg.p)));CHECK(!memcmp(snapshot,backing+16,sizeof snapshot));
   CHECK(F(ArenaUnpin)(arena,full)==1&&F(ArenaFree)(arena,full)==1);
   q=F(ft_strdup_arena)(arena,addr(ag.p));CHECK(q!=0);CHECK(!memcmp((void *)(uintptr_t)q,a,an+1));CHECK(F(ArenaFree)(arena,q)==1&&read64(backing+24)==0);
   CHECK(!memcmp(ag.p,a,an+1)&&!memcmp(bg.p,b,bn+1));for(unsigned i=0;i<16;i++)CHECK(backing[i]==0xa5&&backing[4128+i]==0xa5);destroy(ag);destroy(bg);
 }
}
static void allocation_boundaries(void){
 unsigned char *backing=malloc(65536+48),*text=malloc(65537),*snapshot=malloc(65536+16);CHECK(backing&&text&&snapshot);memset(backing,0xa5,65536+48);memset(text,65,65536);text[65536]=0;
 uint64_t arena=addr(backing+16);CHECK(F(ArenaInit)(arena,65536)==1);text[65503]=0;
 uint64_t q=F(ft_strdup_arena)(arena,addr(text));CHECK(q!=0);CHECK(!memcmp((void *)(uintptr_t)q,text,65504));CHECK(read64(backing+24)==65536);CHECK(F(ArenaFree)(arena,q)==1);
 text[65503]=65;text[65504]=0;memcpy(snapshot,backing+16,65536+16);CHECK(!F(ft_strdup_arena)(arena,addr(text)));CHECK(!memcmp(snapshot,backing+16,65536+16));
 text[65504]=65;uint64_t owner=F(ArenaAlloc)(arena,8);CHECK(owner!=0&&F(ArenaPin)(arena,owner)==1);memcpy(snapshot,backing+16,65536+16);
 CHECK(!F(ft_strdup_arena)(arena,addr(text)));CHECK(!F(ft_substr_arena)(arena,addr(text),0,UINT64_MAX));CHECK(!F(ft_strjoin_arena)(arena,addr(text),addr("")));CHECK(!memcmp(snapshot,backing+16,65536+16));
 CHECK(F(ArenaUnpin)(arena,owner)==1&&F(ArenaFree)(arena,owner)==1&&read64(backing+24)==0);for(unsigned i=0;i<16;i++)CHECK(backing[i]==0xa5&&backing[65568+i]==0xa5);free(snapshot);free(text);free(backing);
}
static void unsigned_ops(void){
 uint64_t edges[]={0,1,2,63,64,65,INT64_MAX,UINT64_C(1)<<63,UINT64_MAX-1,UINT64_MAX};
 for(unsigned i=0;i<10100;i++){
   uint64_t a=i<100?edges[i/10]:next(),b=i<100?edges[i%10]:next();
   if(b){CHECK(F(UnsignedDiv)(a,b)==a/b);CHECK(F(UnsignedMod)(a,b)==a%b);}
   CHECK(F(LogicalShift)(a,b)==a>>(b&63));CHECK(F(UnsignedLt)(a,b)==(uint64_t)(a<b));CHECK(F(UnsignedLe)(a,b)==(uint64_t)(a<=b));CHECK(F(UnsignedGt)(a,b)==(uint64_t)(a>b));CHECK(F(UnsignedGe)(a,b)==(uint64_t)(a>=b));
 }
 for(unsigned i=0;i<2;i++){pid_t pid=fork();CHECK(pid>=0);if(!pid){struct rlimit limit={0,0};setrlimit(RLIMIT_CORE,&limit);volatile uint64_t n=i?F(UnsignedMod)(UINT64_MAX,0):F(UnsignedDiv)(UINT64_MAX,0);(void)n;_exit(99);}int status=0;CHECK(waitpid(pid,&status,0)==pid);CHECK(WIFSIGNALED(status)&&WTERMSIG(status)==SIGFPE);}
}
int main(void){unsigned_ops();uint64_t integer_checks=checks;strings();uint64_t string_checks=checks-integer_checks;allocated();allocation_boundaries();printf("{\"accepted\":true,\"unsigned_checks\":%llu,\"string_checks\":%llu,\"allocated_checks\":%llu,\"total_checks\":%llu,\"zero_divisor_signals\":2,\"string_rounds\":512,\"allocation_rounds\":256}\n",(unsigned long long)integer_checks,(unsigned long long)string_checks,(unsigned long long)(checks-integer_checks-string_checks),(unsigned long long)checks);return 0;}
