#ifndef UBYTEC_ISOLATION_CONTRACT_H
#define UBYTEC_ISOLATION_CONTRACT_H
#include <stdint.h>
enum loan_rights { LOAN_READ = 1, LOAN_READ_WRITE = 3 };
enum fixture {
    F_READ, F_WRITE, F_READ_ONLY_WRITE, F_FOREIGN, F_MONITOR, F_NEIGHBOR,
    F_STACK_OVERFLOW, F_PERMISSION, F_FORGED, F_EXEC_DATA, F_LOOP,
    F_STALE, F_COPY, F_OPEN, F_CLONE, F_PTRACE, F_MMAP, F_X32,
    F_BAD_FRAME, F_SEMIHOST, F_PRIVILEGE, F_BITBAND, F_SERVICE_FRAME, F_MASK_IRQ, F_DEVICE, F_COUNT
};
static const char *const fixture_names[F_COUNT] = {
    "read", "write", "read_only_write", "foreign_pointer", "monitor_pointer",
    "neighbor_pointer", "stack_overflow", "alter_permissions", "forged_request",
    "execute_data", "infinite_loop", "stale_pointer", "copy",
    "open_resource", "create_process", "inspect_process", "new_mapping", "x32_syscall",
    "bad_exception_frame", "semihosting", "raise_privilege", "bitband_alias", "invalid_service_frame", "mask_interrupts", "device_access"
};
/* Descriptors belong to the trusted monitor. Addresses are local views, not authority.
   This prototype exposes host services, not new language opcodes or a wire ABI. */
struct region_descriptor { uint32_t id, owner; uint32_t length, mapped_length; };
struct export_descriptor { uint32_t id, domain; enum fixture entry; };
struct loan_descriptor { uint32_t region, receiver, invocation; enum loan_rights rights; };
struct module_environment {
    uintptr_t buffer, foreign, monitor;
    uint32_t length, region, invocation, fixture, rights;
};
#endif
