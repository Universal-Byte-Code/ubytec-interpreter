#define _GNU_SOURCE
#include "../common/contract.h"
#include <errno.h>
#include <fcntl.h>
#include <linux/audit.h>
#include <linux/filter.h>
#include <linux/seccomp.h>
#include <poll.h>
#include <signal.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#if !defined(__x86_64__)
#error Linux prototype requires x86-64
#endif
#ifndef SYS_close_range
#define SYS_close_range 436
#endif
#define LOAN_BASE ((uintptr_t)0x600000000000ULL)
#define HOST_BASE ((uintptr_t)0x500000000000ULL)
#define STACK_SIZE (64u * 1024u)
#define MAX_PAYLOAD (64u * 1024u)
#define DEADLINE_NS 1000000000ULL
struct message { uint32_t operation, region, invocation, rights, length, checksum; uint64_t ticks; int64_t value; };
struct region { struct region_descriptor descriptor; int fd; unsigned char *data; };
struct domain { uint32_t id; int closed; struct export_descriptor exported; };
struct outcome { int signal, timed_out, setup_error, protocol_error, cancelled; uint32_t checksum; uint64_t ticks; int64_t value; long rss_kib; };

#ifdef UBYTEC_ENABLED
extern int64_t ubytec_host_read(uint64_t, uint64_t, uint64_t, uint64_t);
extern int64_t ubytec_host_write(uint64_t, uint64_t, uint64_t, uint64_t);
extern int64_t ubytec_host_read_only_write(uint64_t, uint64_t, uint64_t, uint64_t);
extern int64_t ubytec_host_foreign(uint64_t, uint64_t, uint64_t, uint64_t);
extern int64_t ubytec_host_monitor(uint64_t, uint64_t, uint64_t, uint64_t);
extern int64_t ubytec_host_neighbor(uint64_t, uint64_t, uint64_t, uint64_t);
extern int64_t ubytec_host_stack_overflow(uint64_t, uint64_t, uint64_t, uint64_t);
extern int64_t ubytec_host_loop(uint64_t, uint64_t, uint64_t, uint64_t);
extern int64_t ubytec_host_stale(uint64_t, uint64_t, uint64_t, uint64_t);
extern int64_t ubytec_host_copy(uint64_t, uint64_t, uint64_t, uint64_t);
#endif
static unsigned char *monitor_secret;
static uint32_t sequence;

static void die(const char *what) { perror(what); exit(2); }
static uint64_t now_ns(void) {
    struct timespec t; if (clock_gettime(CLOCK_MONOTONIC, &t)) die("clock");
    return (uint64_t)t.tv_sec * 1000000000ULL + (uint64_t)t.tv_nsec;
}
static struct region create_region(uint32_t owner, uint32_t length) {
    if (!length || length > MAX_PAYLOAD) { errno = EINVAL; die("region size"); }
    size_t page = (size_t)sysconf(_SC_PAGESIZE);
    struct region r = { .descriptor = { ++sequence, owner, length, (uint32_t)((length + page - 1) & ~(page - 1)) } };
    r.fd = memfd_create("ubytec-loan", MFD_CLOEXEC);
    if (r.fd < 0 || ftruncate(r.fd, r.descriptor.mapped_length)) die("memfd");
    r.data = mmap(NULL, r.descriptor.mapped_length, PROT_READ | PROT_WRITE, MAP_SHARED, r.fd, 0);
    if (r.data == MAP_FAILED) die("region map");
    memset(r.data, 0, r.descriptor.mapped_length);
    return r;
}
static void register_export(struct domain *d, enum fixture entry) {
    if (d->closed || entry >= F_COUNT) { errno = EINVAL; die("export"); }
    d->exported = (struct export_descriptor){ ++sequence, d->id, entry };
}
static void close_domain(struct domain *d) { d->closed = 1; }
static void destroy_region(struct region *r) {
    munmap(r->data, r->descriptor.mapped_length); close(r->fd);
}

/* No pointer argument is dereferenced by BPF. Only the one dedicated IPC fd is
   readable/writable. Arch and upper descriptor word are checked; x32 is denied. */
static int install_filter(void) {
    struct sock_filter ins[] = {
        BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, arch)),
        BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, AUDIT_ARCH_X86_64, 1, 0),
        BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
        BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, nr)),
        BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_exit, 8, 0),
        BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_exit_group, 7, 0),
        BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_read, 2, 0),
        BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_write, 1, 0),
        BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
        BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, args[0]) + 4),
        BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0, 0, 3),
        BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, args[0])),
        BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 3, 0, 1),
        BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
        BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS)
    };
    struct sock_fprog filter = { (unsigned short)(sizeof ins / sizeof ins[0]), ins };
    return prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) || prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &filter);
}
static long raw_call(long n, long a, long b, long c) {
    long result;
    __asm__ volatile("syscall" : "=a"(result) : "a"(n), "D"(a), "S"(b), "d"(c) : "rcx", "r11", "memory");
    return result;
}
static inline uint64_t tsc(void) {
    unsigned low, high; __asm__ volatile("lfence; rdtsc" : "=a"(low), "=d"(high) :: "memory");
    return ((uint64_t)high << 32) | low;
}
static __attribute__((noinline,used)) void payload(struct module_environment *e) {
    uint32_t sum = 0; int64_t value = 0; uint64_t start = tsc();
#ifdef UBYTEC_ENABLED
    int64_t (*function)(uint64_t, uint64_t, uint64_t, uint64_t) = NULL;
    switch ((enum fixture)e->fixture) {
    case F_READ: function = ubytec_host_read; break;
    case F_WRITE: function = ubytec_host_write; break;
    case F_READ_ONLY_WRITE: function = ubytec_host_read_only_write; break;
    case F_FOREIGN: function = ubytec_host_foreign; break;
    case F_MONITOR: function = ubytec_host_monitor; break;
    case F_NEIGHBOR: function = ubytec_host_neighbor; break;
    case F_STACK_OVERFLOW: function = ubytec_host_stack_overflow; break;
    case F_LOOP: function = ubytec_host_loop; break;
    case F_STALE: function = ubytec_host_stale; break;
    case F_COPY: function = ubytec_host_copy; break;
    default: raw_call(__NR_exit_group, 123, 0, 0); __builtin_unreachable();
    }
    value = function(e->buffer, e->length, e->foreign, e->monitor);
    sum = (uint32_t)value;
#else
    volatile unsigned char *p = (volatile unsigned char *)e->buffer;
    switch ((enum fixture)e->fixture) {
    case F_READ: for (uint32_t i = 0; i < e->length; ++i) sum += p[i]; break;
    case F_WRITE: case F_COPY: for (uint32_t i = 0; i < e->length; ++i) p[i] = 0x5a; break;
    case F_READ_ONLY_WRITE: p[0] = 0xff; break;
    case F_FOREIGN: sum = *(volatile unsigned char *)e->foreign; break;
    case F_MONITOR: *(volatile unsigned char *)e->monitor = 0xff; break;
    case F_NEIGHBOR: p[(e->length + 4095u) & ~4095u] = 0xff; break;
    case F_STACK_OVERFLOW: __asm__ volatile("sub $131072, %%rsp; movb $1, (%%rsp)" ::: "memory"); __builtin_unreachable();
    case F_PERMISSION: raw_call(__NR_mprotect, (long)p, e->length, PROT_READ | PROT_WRITE | PROT_EXEC); break;
    case F_EXEC_DATA: ((void (*)(void))(uintptr_t)p)(); break;
    case F_LOOP: for (;;) __asm__ volatile("pause"); break;
    case F_STALE: sum = *(volatile unsigned char *)LOAN_BASE; break;
    case F_OPEN: raw_call(__NR_openat, AT_FDCWD, (long)"/etc/passwd", O_RDONLY); break;
    case F_CLONE: raw_call(__NR_clone, SIGCHLD, 0, 0); break;
    case F_PTRACE: raw_call(__NR_ptrace, 0, 0, 0); break;
    case F_MMAP: raw_call(__NR_mmap, 0, 4096, PROT_READ); break;
    case F_X32: raw_call(0x40000000L | __NR_write, 3, (long)p, 0); break;
    default: break;
    }
    value = sum;
#endif
    struct message m = { e->fixture == F_FORGED ? 2u : 1u, e->region, e->invocation, e->rights, e->length, sum, tsc() - start, value };
    if (e->fixture == F_FORGED) { m.region++; m.invocation++; m.rights = LOAN_READ_WRITE; }
    raw_call(__NR_write, 3, (long)&m, sizeof m);
    raw_call(__NR_exit_group, 0, 0, 0);
    __builtin_unreachable();
}
extern void launch_payload(struct module_environment *, void *);
__asm__(".text\n.global launch_payload\nlaunch_payload:\nmov %rsi,%rsp\nand $-16,%rsp\nxor %ebp,%ebp\ncall payload\nud2\n");

/* EXEC removes the supervisor heap, mappings, TLS and authority tables before
   payload starts. The anonymous reservation is a deterministic foreign-address test. */
static void worker(int argc, char **argv) {
    if (argc != 8) _exit(120);
    struct module_environment e = {
        .buffer = LOAN_BASE, .foreign = HOST_BASE + 4096, .monitor = HOST_BASE,
        .length = (uint32_t)strtoul(argv[3], NULL, 10), .region = (uint32_t)strtoul(argv[4], NULL, 10),
        .invocation = (uint32_t)strtoul(argv[5], NULL, 10), .fixture = (uint32_t)strtoul(argv[2], NULL, 10),
        .rights = (uint32_t)strtoul(argv[6], NULL, 10)
    };
    uint32_t mapped = (uint32_t)strtoul(argv[7], NULL, 10);
    if (!mapped || mapped > MAX_PAYLOAD || e.length > mapped || e.fixture >= F_COUNT) _exit(120);
    if (mmap((void *)HOST_BASE, 8192, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE, -1, 0) == MAP_FAILED) _exit(120);
    if (mmap((void *)(LOAN_BASE - 4096), mapped + 8192, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE, -1, 0) == MAP_FAILED) _exit(120);
    if (e.fixture != F_STALE) {
        int prot = PROT_READ | (e.rights == LOAN_READ_WRITE ? PROT_WRITE : 0);
        if (mmap((void *)LOAN_BASE, mapped, prot, MAP_SHARED | MAP_FIXED, 4, 0) == MAP_FAILED) _exit(120);
    }
    close(4);
    /* fd 3 is the only inherited channel; close_range is optional on older kernels. */
    struct rlimit limit;
    if (getrlimit(RLIMIT_NOFILE, &limit)) _exit(120);
    for (int fd = 0; fd < 3; ++fd) close(fd);
    if (syscall(SYS_close_range, 4u, ~0u, 0u) < 0)
        for (int fd = 4; fd < (int)limit.rlim_cur; ++fd) close(fd);
    unsigned char *stack = mmap(NULL, STACK_SIZE + 8192, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (stack == MAP_FAILED || mprotect(stack + 4096, STACK_SIZE, PROT_READ | PROT_WRITE)) _exit(120);
    struct module_environment *context = (struct module_environment *)(stack + 4096);
    *context = e;
    if (install_filter()) _exit(121);
    launch_payload(context, stack + 4096 + STACK_SIZE);
    _exit(122);
}
static struct outcome invoke(struct domain *d, struct region *r, enum loan_rights rights) {
    if (d->closed || (rights != LOAN_READ && rights != LOAN_READ_WRITE)) { errno = EINVAL; die("invoke"); }
    struct loan_descriptor loan = { r->descriptor.id, d->id, ++sequence, rights };
    int ipc[2]; if (socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc)) die("socketpair");
    int child_ipc = fcntl(ipc[1], F_DUPFD_CLOEXEC, 10);
    int child_region = fcntl(r->fd, F_DUPFD_CLOEXEC, 10);
    if (child_ipc < 0 || child_region < 0) die("duplicate");
    char fixture[24], length[24], region[24], invocation[24], permission[24], mapped[24];
    snprintf(fixture, sizeof fixture, "%u", d->exported.entry);
    snprintf(length, sizeof length, "%u", r->descriptor.length);
    snprintf(region, sizeof region, "%u", loan.region);
    snprintf(invocation, sizeof invocation, "%u", loan.invocation);
    snprintf(permission, sizeof permission, "%u", rights);
    snprintf(mapped, sizeof mapped, "%u", r->descriptor.mapped_length);
    pid_t pid = fork(); if (pid < 0) die("fork");
    if (!pid) {
        struct rlimit core = {0,0}; setrlimit(RLIMIT_CORE, &core);
        if (dup2(child_ipc, 3) < 0 || dup2(child_region, 4) < 0) _exit(120);
        execl("/proc/self/exe", "isolation", "--worker", fixture, length, region, invocation, permission, mapped, (char *)NULL);
        _exit(120);
    }
    close(child_ipc); close(child_region); close(ipc[1]);
    int flags = fcntl(ipc[0], F_GETFL); fcntl(ipc[0], F_SETFL, flags | O_NONBLOCK);
    struct outcome out = {0};
    struct message message; size_t received = 0;
    int status = 0, reaped = 0; uint64_t deadline = now_ns() + DEADLINE_NS;
    struct rusage usage = {0};
    while (!reaped) {
        if (received < sizeof message) {
            ssize_t n = read(ipc[0], (unsigned char *)&message + received, sizeof message - received);
            if (n > 0) received += (size_t)n;
        }
        pid_t got = wait4(pid, &status, WNOHANG, &usage);
        if (got == pid) { reaped = 1; break; }
        if (got < 0 && errno != EINTR) die("wait");
        if (now_ns() >= deadline) {
            out.timed_out = 1; kill(pid, SIGKILL);
            if (wait4(pid, &status, 0, &usage) != pid) die("reap timeout");
            reaped = 1; break;
        }
        struct pollfd poller = { ipc[0], POLLIN, 0 };
        /* Once the message arrives, wait briefly without spinning on socket EOF. */
        if (received == sizeof message) { struct timespec pause = {0, 1000000}; nanosleep(&pause, NULL); }
        else poll(&poller, 1, 1);
    }
    while (received < sizeof message) {
        ssize_t n = read(ipc[0], (unsigned char *)&message + received, sizeof message - received);
        if (n <= 0) break;
        received += (size_t)n;
    }
    unsigned char extra; int trailing = read(ipc[0], &extra, 1) > 0;
    close(ipc[0]); /* The worker is reaped before the loan can be reused. */
    out.rss_kib = usage.ru_maxrss;
    if (WIFSIGNALED(status)) out.signal = WTERMSIG(status);
    else if (!WIFEXITED(status) || WEXITSTATUS(status)) out.setup_error = 1;
    if (!out.signal && !out.timed_out && !out.setup_error) {
        out.protocol_error = received != sizeof message || trailing;
        if (!out.protocol_error)
            out.protocol_error = message.operation != 1 || message.region != loan.region ||
                message.invocation != loan.invocation || message.rights != (uint32_t)rights ||
                message.length != r->descriptor.length;
        if (!out.protocol_error) { out.checksum = message.checksum; out.ticks = message.ticks; out.value = message.value; }
    }
    return out;
}
static int tests(void) {
    struct region r = create_region(1, 256);
    struct domain d = { .id = 2 };
    monitor_secret = mmap((void *)HOST_BASE, 8192, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE, -1, 0);
    if (monitor_secret == MAP_FAILED) die("monitor fixture");
    memset(monitor_secret, 0xa5, 8192);
    int failed = 0;
    for (enum fixture f = F_READ; f <= F_X32; ++f) {
#ifdef UBYTEC_ENABLED
        if (f == F_PERMISSION || f == F_FORGED || f == F_EXEC_DATA || f >= F_OPEN) continue;
#endif
        memset(r.data, 0, r.descriptor.mapped_length);
        memset(r.data, 1, r.descriptor.length);
        if (f == F_EXEC_DATA) r.data[0] = 0xc3;
        register_export(&d, f);
        enum loan_rights rights = f == F_READ_ONLY_WRITE || f == F_READ || f == F_EXEC_DATA ? LOAN_READ : LOAN_READ_WRITE;
        struct outcome o = invoke(&d, &r, rights);
        int pass = !o.setup_error;
        if (f == F_READ) pass &= !o.signal && !o.protocol_error && o.checksum == 256;
        else if (f == F_WRITE || f == F_COPY) pass &= !o.signal && !o.protocol_error;
        else if (f == F_FORGED) pass &= o.protocol_error;
        else if (f == F_LOOP) pass &= o.timed_out;
        else if (f == F_PERMISSION || f >= F_OPEN) pass &= o.signal == SIGSYS;
        else pass &= o.signal == SIGSEGV;
#ifdef UBYTEC_ENABLED
        if (f == F_WRITE || f == F_COPY) pass &= o.value == INT64_C(4294967297);
        if (f == F_READ) pass &= o.value == 256;
#endif
        for (unsigned i = 0; i < 8192; ++i) pass &= monitor_secret[i] == 0xa5;
        for (unsigned i = r.descriptor.length; i < r.descriptor.mapped_length; ++i) pass &= r.data[i] == 0;
        if (f == F_WRITE || f == F_COPY) {
            unsigned char destination[272]; memset(destination, 0xa5, sizeof destination);
            if (pass) memcpy(destination + 8, r.data, 256);
            for (unsigned i = 0; i < sizeof destination; ++i)
                pass &= destination[i] == (i >= 8 && i < 264 ? 0x5a : 0xa5);
        }
        printf("{\"target\":\"linux-x64\",\"case\":\"%s\",\"pass\":%s,\"signal\":%d,\"timeout\":%d,\"protocol_rejected\":%d,\"rss_kib\":%ld,\"value\":%lld}\n",
            fixture_names[f], pass ? "true" : "false", o.signal, o.timed_out, o.protocol_error, o.rss_kib, (long long)o.value);
        failed += !pass;
#ifdef UBYTEC_ENABLED
        memset(r.data, 1, r.descriptor.length);
        register_export(&d, F_READ);
        struct outcome recovery = invoke(&d, &r, LOAN_READ);
        int recovered = !recovery.signal && !recovery.timed_out && !recovery.setup_error &&
                        !recovery.protocol_error && recovery.value == 256;
        printf("{\"target\":\"linux-x64\",\"case\":\"recovery_after_%s\",\"pass\":%s}\n",
               fixture_names[f], recovered ? "true" : "false");
        failed += !recovered;
#endif
    }
    close_domain(&d); destroy_region(&r); munmap(monitor_secret, 8192);
    return failed ? 1 : 0;
}
static int compare_double(const void *a, const void *b) {
    double x = *(const double *)a, y = *(const double *)b; return (x > y) - (x < y);
}
static void statistics(const char *name, unsigned bytes, double *samples, unsigned count, long rss, unsigned mapped) {
    qsort(samples, count, sizeof *samples, compare_double);
    printf("{\"target\":\"linux-x64\",\"metric\":\"%s\",\"bytes\":%u,\"samples\":%u,\"median_us\":%.3f,\"p95_us\":%.3f,\"worker_rss_kib\":%ld,\"loan_mapped_bytes\":%u,\"private_stack_bytes\":%u}\n",
        name, bytes, count, samples[count/2], samples[(count * 95 + 99)/100 - 1], rss, mapped, STACK_SIZE);
}
static int benchmark(void) {
    const unsigned sizes[] = {256,4096,65536};
    for (unsigned j = 0; j < 3; ++j) {
        struct region r = create_region(1, sizes[j]);
        struct domain d = { .id = 2 }; register_export(&d, F_READ);
        memset(r.data, 1, r.descriptor.length);
        double call[100], copy[100], local[100], ticks[100]; long peak = 0;
        unsigned char *destination = malloc(sizes[j]); if (!destination) die("malloc");
        volatile uint32_t sink = 0;
        for (unsigned i = 0; i < 110; ++i) {
            uint64_t start = now_ns(); struct outcome o = invoke(&d, &r, LOAN_READ); uint64_t stop = now_ns();
            if (o.signal || o.timed_out || o.protocol_error || o.setup_error || o.checksum != sizes[j]) return 1;
            if (o.rss_kib > peak) peak = o.rss_kib;
            if (i >= 10) { call[i-10] = (stop-start)/1000.0; ticks[i-10] = (double)o.ticks; }
            start = now_ns();
            for (unsigned repeat = 0; repeat < 1000; ++repeat) {
                memcpy(destination, r.data, sizes[j]); __asm__ volatile("" ::: "memory");
            }
            stop = now_ns(); if (i >= 10) copy[i-10] = (stop-start)/1000000.0;
            start = now_ns();
            for (unsigned repeat = 0; repeat < 100; ++repeat)
                for (unsigned k = 0; k < sizes[j]; ++k) sink += r.data[k];
            stop = now_ns(); if (i >= 10) local[i-10] = (stop-start)/100000.0;
        }
        statistics("invocation_and_read", sizes[j], call, 100, peak, r.descriptor.mapped_length);
        statistics("copy_only", sizes[j], copy, 100, peak, r.descriptor.mapped_length);
        statistics("local_byte_read_baseline", sizes[j], local, 100, peak, r.descriptor.mapped_length);
        qsort(ticks, 100, sizeof *ticks, compare_double);
        printf("{\"target\":\"linux-x64\",\"metric\":\"worker_byte_read\",\"bytes\":%u,\"samples\":100,\"median_tsc_ticks\":%.0f,\"p95_tsc_ticks\":%.0f}\n", sizes[j], ticks[50], ticks[94]);
        free(destination); close_domain(&d); destroy_region(&r); (void)sink;
    }
    return 0;
}
int main(int argc, char **argv) {
    if (argc > 1 && !strcmp(argv[1], "--worker")) worker(argc, argv);
    if (argc == 2 && !strcmp(argv[1], "--benchmark")) return benchmark();
    return tests();
}
