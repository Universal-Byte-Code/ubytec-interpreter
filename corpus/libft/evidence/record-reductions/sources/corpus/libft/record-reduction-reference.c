#include <stdint.h>
#include <string.h>
#ifndef REDUCE_NAME
#define REDUCE_NAME c_records
#endif
/* memcpy defines unaligned eight-byte loads without strict-aliasing assumptions. */
uint64_t REDUCE_NAME(uint64_t base,uint64_t count){
 uint64_t sum=0;
 for(uint64_t i=0;i<count;i++){uint64_t v;memcpy(&v,(const void *)(uintptr_t)(base+i*24+16),8);sum+=v;}
 return sum;
}
