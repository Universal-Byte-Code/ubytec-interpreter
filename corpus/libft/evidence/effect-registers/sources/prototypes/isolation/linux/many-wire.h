#ifndef UBYTEC_MANY_WIRE_H
#define UBYTEC_MANY_WIRE_H
#include <stdint.h>
#define MANY_SOURCE_BASE UINT64_C(0x600000200000)
struct many_argument { uint64_t kind, value, length; };
struct many_parameters { uint32_t count, loans, length[2], rights[2]; uint32_t kinds[6]; uint64_t values[6]; };
struct many_request { struct many_argument args[6]; };
_Static_assert(sizeof(struct many_argument)==24,"argument format");
#endif
