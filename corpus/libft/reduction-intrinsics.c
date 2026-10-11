#include <stdint.h>
#include <immintrin.h>
#ifndef REDUCE_NAME
#define REDUCE_NAME c_intrinsic_bytes
#endif
/* Same byte-sum, ordinary RAM, bounded loads. Explicit SIMD is available to C too. */
__attribute__((target("avx2")))
uint64_t REDUCE_NAME(uint64_t data,uint64_t n){
 const unsigned char *p=(const unsigned char *)(uintptr_t)data;
 __m256i zero=_mm256_setzero_si256(),a=zero,b=zero,c=zero,d=zero;
 while(n>=128){
  a=_mm256_add_epi64(a,_mm256_sad_epu8(_mm256_loadu_si256((const __m256i *)(p)),zero));
  b=_mm256_add_epi64(b,_mm256_sad_epu8(_mm256_loadu_si256((const __m256i *)(p+32)),zero));
  c=_mm256_add_epi64(c,_mm256_sad_epu8(_mm256_loadu_si256((const __m256i *)(p+64)),zero));
  d=_mm256_add_epi64(d,_mm256_sad_epu8(_mm256_loadu_si256((const __m256i *)(p+96)),zero));
  p+=128;n-=128;
 }
 while(n>=32){a=_mm256_add_epi64(a,_mm256_sad_epu8(_mm256_loadu_si256((const __m256i *)p),zero));p+=32;n-=32;}
 a=_mm256_add_epi64(_mm256_add_epi64(a,b),_mm256_add_epi64(c,d));
 __m128i sum=_mm_add_epi64(_mm256_castsi256_si128(a),_mm256_extracti128_si256(a,1));
 sum=_mm_add_epi64(sum,_mm_srli_si128(sum,8));
 uint64_t result=(uint64_t)_mm_cvtsi128_si64(sum);
 while(n--)result+=*p++;
 return result;
}
