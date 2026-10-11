#include <stdint.h>
struct entry {uint64_t name,length,count;};
extern uint64_t ubytec_host_candidate_DiagLookup(uint64_t,uint64_t,uint64_t,uint64_t);
/* Test-only worker preparation: pointers refer to this worker's loan mappings.
 * Records live in private stack memory; input loans remain read-only. */
uint64_t fixture_lookup(uint64_t data,uint64_t count,uint64_t key,uint64_t length){
 struct entry records[3];
 if(count>3)return 0;
 for(uint64_t i=0;i<count;i++)records[i]=(struct entry){data+i*8,length,0};
 return ubytec_host_candidate_DiagLookup((uintptr_t)records,count,key,length);
}
