#define _POSIX_C_SOURCE 200809L
#include <stdint.h>
#include <inttypes.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
struct entry {const unsigned char *name;uint64_t length,count;};
_Static_assert(sizeof(struct entry)==24&&offsetof(struct entry,count)==16,"record layout");
#define DECL(prefix) \
 extern uint64_t prefix##DiagIdentity(uint64_t); \
 extern uint64_t prefix##DiagBytes(uint64_t,uint64_t); \
 extern uint64_t prefix##DiagRecords(uint64_t,uint64_t); \
 extern uint64_t prefix##DiagLookup(uint64_t,uint64_t,uint64_t,uint64_t)
DECL(c_);DECL(ubytec_host_contract_);
static uint64_t address(const void *p){return (uint64_t)(uintptr_t)p;}
static void check(int ok){if(!ok){fprintf(stderr,"diagnostic kernel mismatch\n");exit(2);}}
static uint64_t ns(void){struct timespec t;check(!clock_gettime(CLOCK_MONOTONIC,&t));return (uint64_t)t.tv_sec*1000000000+(uint64_t)t.tv_nsec;}
static volatile uint64_t sink;
int main(void){
 unsigned char bytes[65536],names[256][9];struct entry records[256];uint64_t rng=420107;
 for(size_t i=0;i<sizeof bytes;i++){rng^=rng<<13;rng^=rng>>7;rng^=rng<<17;bytes[i]=(unsigned char)rng;}
 for(unsigned i=0;i<256;i++){check(snprintf((char *)names[i],9,"w%07u",i)==8);records[i]=(struct entry){names[i],8,UINT64_MAX-i};}
 for(unsigned test=0;test<16;test++){
  unsigned kind;uint64_t count,batch,expected=0;const unsigned char *key=NULL;char label[80];
  if(!test){kind=0;count=1;batch=65536;expected=UINT64_MAX;strcpy(label,"identity");}
  else if(test<=3){kind=1;count=test==1?256:test==2?4096:65536;batch=1048576/count;for(uint64_t i=0;i<count;i++)expected+=bytes[i];snprintf(label,sizeof label,"bytes-%" PRIu64,count);}
  else if(test<=6){kind=2;count=test==4?4:test==5?64:256;batch=65536/count;for(uint64_t i=0;i<count;i++)expected+=records[i].count;snprintf(label,sizeof label,"records-%" PRIu64,count);}
  else{kind=3;unsigned k=(test-7)/3,where=(test-7)%3;count=k==0?4:k==1?64:256;batch=65536/count;key=where==0?names[0]:where==1?names[count-1]:(const unsigned char *)"w9999999";expected=where==0?1:where==1?count:0;snprintf(label,sizeof label,"lookup-%" PRIu64 "-%s",count,where==0?"first":where==1?"last":"missing");}
  for(unsigned variant=0;variant<2;variant++){
   uint64_t (*identity)(uint64_t)=variant?c_DiagIdentity:ubytec_host_contract_DiagIdentity;
   uint64_t (*bytes_fn)(uint64_t,uint64_t)=variant?c_DiagBytes:ubytec_host_contract_DiagBytes;
   uint64_t (*records_fn)(uint64_t,uint64_t)=variant?c_DiagRecords:ubytec_host_contract_DiagRecords;
   uint64_t (*lookup)(uint64_t,uint64_t,uint64_t,uint64_t)=variant?c_DiagLookup:ubytec_host_contract_DiagLookup;
   for(unsigned iteration=0;iteration<35;iteration++){
    uint64_t sum=0,start=ns();
    for(uint64_t repeat=0;repeat<batch;repeat++)sum+=kind==0?identity(UINT64_MAX):kind==1?bytes_fn(address(bytes),count):kind==2?records_fn(address(records),count):lookup(address(records),count,address(key),8);
    uint64_t elapsed=ns()-start;sink=sum;check(sum==expected*batch);
    if(iteration>=5)printf("{\"case\":\"%s\",\"implementation\":\"%s\",\"sample\":%u,\"batch\":%" PRIu64 ",\"ns\":%" PRIu64 ",\"result\":%" PRIu64 "}\n",label,variant?"c":"ubytec",iteration-5,batch,elapsed,expected);
   }
  }
 }
 /* Boundary checks outside timings, including empty spans and mismatching lengths. */
 check(c_DiagBytes(address(bytes),0)==ubytec_host_contract_DiagBytes(address(bytes),0));
 check(c_DiagRecords(address(records),0)==ubytec_host_contract_DiagRecords(address(records),0));
 check(c_DiagLookup(address(records),256,address(names[0]),7)==0&&ubytec_host_contract_DiagLookup(address(records),256,address(names[0]),7)==0);
 check(c_DiagLookup(address(records),0,address(names[0]),8)==0&&ubytec_host_contract_DiagLookup(address(records),0,address(names[0]),8)==0);
 return sink==123456789?3:0;
}
