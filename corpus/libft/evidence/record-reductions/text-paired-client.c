#define _POSIX_C_SOURCE 200809L
/* Trusted in-process timing client. NASM runs without the process sandbox here. */
#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/resource.h>
extern uint64_t ubytec_host_plain_ArenaInit(uint64_t,uint64_t);
extern uint64_t ubytec_host_plain_ArenaAlloc(uint64_t,uint64_t);
extern uint64_t ubytec_host_plain_VectorInit(uint64_t,uint64_t,uint64_t);
extern uint64_t ubytec_host_plain_TextFeed(uint64_t,uint64_t,uint64_t,uint64_t,uint64_t);
extern uint64_t ubytec_host_plain_TextFlush(uint64_t,uint64_t,uint64_t);
extern uint64_t ubytec_host_plain_TextCleanup(uint64_t,uint64_t,uint64_t);
extern uint64_t ubytec_host_plain_BenchSort(uint64_t,uint64_t);
extern uint64_t ubytec_host_plain_BenchEmit(uint64_t,uint64_t,uint64_t,uint64_t);
extern uint64_t ubytec_host_registers_ArenaInit(uint64_t,uint64_t);
extern uint64_t ubytec_host_registers_ArenaAlloc(uint64_t,uint64_t);
extern uint64_t ubytec_host_registers_VectorInit(uint64_t,uint64_t,uint64_t);
extern uint64_t ubytec_host_registers_TextFeed(uint64_t,uint64_t,uint64_t,uint64_t,uint64_t);
extern uint64_t ubytec_host_registers_TextFlush(uint64_t,uint64_t,uint64_t);
extern uint64_t ubytec_host_registers_TextCleanup(uint64_t,uint64_t,uint64_t);
extern uint64_t ubytec_host_registers_BenchSort(uint64_t,uint64_t);
extern uint64_t ubytec_host_registers_BenchEmit(uint64_t,uint64_t,uint64_t,uint64_t);
struct variant {uint64_t (*ArenaInit)(uint64_t,uint64_t);uint64_t (*ArenaAlloc)(uint64_t,uint64_t);uint64_t (*VectorInit)(uint64_t,uint64_t,uint64_t);uint64_t (*TextFeed)(uint64_t,uint64_t,uint64_t,uint64_t,uint64_t);uint64_t (*TextFlush)(uint64_t,uint64_t,uint64_t);uint64_t (*TextCleanup)(uint64_t,uint64_t,uint64_t);uint64_t (*BenchSort)(uint64_t,uint64_t);uint64_t (*BenchEmit)(uint64_t,uint64_t,uint64_t,uint64_t);};
static const struct variant variants[]={{ubytec_host_plain_ArenaInit,ubytec_host_plain_ArenaAlloc,ubytec_host_plain_VectorInit,ubytec_host_plain_TextFeed,ubytec_host_plain_TextFlush,ubytec_host_plain_TextCleanup,ubytec_host_plain_BenchSort,ubytec_host_plain_BenchEmit},{ubytec_host_registers_ArenaInit,ubytec_host_registers_ArenaAlloc,ubytec_host_registers_VectorInit,ubytec_host_registers_TextFeed,ubytec_host_registers_TextFlush,ubytec_host_registers_TextCleanup,ubytec_host_registers_BenchSort,ubytec_host_registers_BenchEmit}};
#define F(n) selected.n
struct vector {uint64_t arena,data,length,capacity,width;};
struct entry {char *text;uint64_t length,count;};
static unsigned char output[65536];static size_t emitted;
static uint64_t ptr(const void *p){return (uint64_t)(uintptr_t)p;}
static void require(int ok){if(!ok){fprintf(stderr,"benchmark validation failed\n");exit(2);}}
static uint64_t clock_ns(void){struct timespec t;require(!clock_gettime(CLOCK_MONOTONIC,&t));return (uint64_t)t.tv_sec*1000000000+(uint64_t)t.tv_nsec;}
int64_t ubytec_bridge_call(uint64_t h,uint64_t data,uint64_t n,uint64_t result,uint64_t timeout){(void)h;(void)data;(void)n;(void)result;(void)timeout;return 1;}
int64_t ubytec_bridge_read(uint64_t h,uint64_t off,uint64_t data,uint64_t n,uint64_t result){(void)h;(void)off;(void)data;(void)n;(void)result;return 1;}
int64_t ubytec_bridge_write(uint64_t h,uint64_t off,uint64_t data,uint64_t n,uint64_t result){
 if(h!=258||off!=emitted||n>sizeof output-emitted)return 1;
 memcpy(output+emitted,(void *)(uintptr_t)data,(size_t)n);emitted+=(size_t)n;memcpy((void *)(uintptr_t)result,&n,8);return 0;
}
static unsigned char *read_file(const char *path,size_t *n){FILE *f=fopen(path,"rb");require(f!=NULL);require(!fseek(f,0,SEEK_END));long end=ftell(f);require(end>=0);*n=(size_t)end;rewind(f);unsigned char *p=malloc(*n+1);require(p!=NULL);require(fread(p,1,*n,f)==*n);require(!fclose(f));return p;}
static int isword(unsigned char c){return (c>=65&&c<=90)||(c>=97&&c<=122)||(c>=48&&c<=57)||c==95;}
static int compare(const struct entry *a,const struct entry *b){size_t n=a->length<b->length?(size_t)a->length:(size_t)b->length;int d=memcmp(a->text,b->text,n);return d?d:(a->length>b->length)-(a->length<b->length);}
struct cstate {struct entry *entries;size_t used,capacity;unsigned char *token;size_t length,token_capacity;};
static void cflush(struct cstate *s){
 if(!s->length)return;
 for(size_t i=0;i<s->used;i++)if(s->entries[i].length==s->length&&!memcmp(s->entries[i].text,s->token,s->length)){s->entries[i].count++;s->length=0;return;}
 if(s->used==s->capacity){s->capacity=s->capacity?s->capacity*2:1;s->entries=realloc(s->entries,s->capacity*sizeof *s->entries);require(s->entries!=NULL);}
 char *name=malloc(s->length);require(name!=NULL);memcpy(name,s->token,s->length);s->entries[s->used++]=(struct entry){name,s->length,1};s->length=0;
}
static void cfeed(struct cstate *s,const unsigned char *data,size_t length){for(size_t i=0;i<length;i++){unsigned char ch=data[i];if(isword(ch)){if(s->length==s->token_capacity){s->token_capacity=s->token_capacity?s->token_capacity*2:1;s->token=realloc(s->token,s->token_capacity);require(s->token!=NULL);}s->token[s->length++]=(unsigned char)(ch>=65&&ch<=90?ch+32:ch);}else cflush(s);}}
static void csort(struct cstate *s){for(size_t i=1;i<s->used;i++){struct entry e=s->entries[i];size_t j=i;while(j&&compare(&s->entries[j-1],&e)>0){s->entries[j]=s->entries[j-1];j--;}s->entries[j]=e;}}
static void cemit(struct cstate *s){for(size_t i=0;i<s->used;i++){struct entry *e=&s->entries[i];require(e->length+32<=sizeof output-emitted);memcpy(output+emitted,e->text,(size_t)e->length);emitted+=(size_t)e->length;int n=snprintf((char *)output+emitted,sizeof output-emitted,"\t%" PRIu64 "\n",e->count);require(n>0);emitted+=(size_t)n;}}
int main(int argc,char **argv){
 if(argc!=7)return 2;
 size_t n,expected_n;unsigned char *input=read_file(argv[2],&n),*expected=read_file(argv[3],&expected_n);
 unsigned chunk=(unsigned)strtoul(argv[4],NULL,10),warm=(unsigned)strtoul(argv[5],NULL,10),samples=(unsigned)strtoul(argv[6],NULL,10);require(chunk&&chunk<=4096&&samples&&samples<=10000);
 int native=1;require(!strcmp(argv[1],"paired"));
 for(unsigned iteration=0;iteration<warm+samples;iteration++) for(unsigned order=0;order<2;order++){
  unsigned variant=(iteration+order)%2; const struct variant selected=variants[variant];
  _Alignas(16) unsigned char arena_storage[65248+56];memset(arena_storage,0xa5,sizeof arena_storage);
  uint64_t arena=ptr(arena_storage+24),scratch[3]={0},digits[4]={0},result=0,offset=0,io=0;memset(arena_storage+16,0,8);
  struct vector words={0},token={0};struct cstate c={0};emitted=0;
  if(native){require(F(ArenaInit)(arena,65248));require(F(VectorInit)(ptr(&words),arena,24));require(F(VectorInit)(ptr(&token),arena,1));io=F(ArenaAlloc)(arena,chunk);require(io!=0);}
  uint64_t start=clock_ns();int ok=1;
  for(size_t cursor=0;cursor<n;cursor+=chunk){size_t length=n-cursor<chunk?n-cursor:chunk;if(native)ok &= !!F(TextFeed)(ptr(&words),ptr(&token),ptr(input+cursor),length,ptr(scratch));else cfeed(&c,input+cursor,length);if(!ok)break;}
  if(native)ok &= !!F(TextFlush)(ptr(&words),ptr(&token),ptr(scratch));else cflush(&c);
  uint64_t feed=clock_ns()-start;require(ok);
  start=clock_ns();if(native)ok=!!F(BenchSort)(ptr(&words),ptr(scratch));else csort(&c);uint64_t sort=clock_ns()-start;require(ok);
  start=clock_ns();if(native)ok=!!F(BenchEmit)(ptr(&words),ptr(digits),ptr(&result),ptr(&offset));else cemit(&c);uint64_t emit=clock_ns()-start;require(ok);
  require(emitted==expected_n&&!memcmp(output,expected,expected_n));uint64_t unique=native?words.length:c.used,peak=0;memcpy(&peak,arena_storage+16,8);
  if(native){require(F(TextCleanup)(ptr(&words),ptr(&token),io));uint64_t used;memcpy(&used,arena_storage+32,8);require(used==0);require(!words.data&&!token.data);for(size_t i=0;i<16;i++)require(arena_storage[i]==0xa5&&arena_storage[65248+40+i]==0xa5);}
  else{for(size_t i=0;i<c.used;i++)free(c.entries[i].text);free(c.entries);free(c.token);}
  struct rusage usage;require(!getrusage(RUSAGE_SELF,&usage));
  if(iteration>=warm)printf("{\"implementation\":\"%s\",\"sample\":%u,\"feed_ns\":%" PRIu64 ",\"sort_ns\":%" PRIu64 ",\"emit_ns\":%" PRIu64 ",\"unique\":%" PRIu64 ",\"arena_peak_extent\":%" PRIu64 ",\"arena_used_after\":0,\"output_matches\":true,\"process_peak_rss_kib\":%ld}\n",variant?"registers":"plain",iteration-warm,feed,sort,emit,unique,peak,usage.ru_maxrss);
 }
 free(input);free(expected);return 0;
}
