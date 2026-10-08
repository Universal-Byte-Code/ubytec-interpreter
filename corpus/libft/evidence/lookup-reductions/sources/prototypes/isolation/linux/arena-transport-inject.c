/* Test-only: fail the first request write, then use the unchanged fd-3 ABI.
 * Linked only into loan-caller-injected.elf, never the normal bridge artifact. */
#include <stdint.h>
long ubytec_bridge_test_io(long op,void *buffer,uint64_t length) {
    static int failed;
    if(op==1 && !failed) { failed=1; return -5; }
    long result;
    __asm__ volatile("syscall" : "=a"(result) : "a"(op),"D"(3L),"S"(buffer),"d"(length) : "rcx","r11","memory");
    return result;
}
