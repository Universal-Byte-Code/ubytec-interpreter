/* Scalar reference: same layouts, unsigned wrap, search order and byte comparisons.
 * Separate translation unit, no LTO; no allocations/validation/OS calls in kernels. */
#include <stdint.h>
struct entry {const unsigned char *name;uint64_t length,count;};
uint64_t c_DiagIdentity(uint64_t v){return v;}
uint64_t c_DiagBytes(uint64_t data,uint64_t length){
 const unsigned char *p=(const unsigned char *)(uintptr_t)data;uint64_t sum=0;
 for(uint64_t i=0;i<length;i++)sum+=p[i];
 return sum;
}
uint64_t c_DiagRecords(uint64_t records,uint64_t count){
 const struct entry *p=(const struct entry *)(uintptr_t)records;uint64_t sum=0;
 for(uint64_t i=0;i<count;i++)sum+=p[i].count;
 return sum;
}
uint64_t c_DiagLookup(uint64_t records,uint64_t count,uint64_t key,uint64_t length){
 const struct entry *p=(const struct entry *)(uintptr_t)records;const unsigned char *k=(const unsigned char *)(uintptr_t)key;
 for(uint64_t i=0;i<count;i++)if(p[i].length==length){uint64_t j=0;while(j<length&&p[i].name[j]==k[j])j++;if(j==length)return i+1;}
 return 0;
}
