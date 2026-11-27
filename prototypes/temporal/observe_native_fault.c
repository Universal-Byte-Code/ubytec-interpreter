#define _GNU_SOURCE
#include <elf.h>
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/ptrace.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <sys/user.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

/* Linux x86-64, trusted single-threaded test executable only. Not a sandbox. */
static int wait_bounded(pid_t pid, int *status) {
    struct timespec start, now, delay = {0, 1000000};
    if (clock_gettime(CLOCK_MONOTONIC, &start)) return -1;
    for (;;) {
        pid_t result = waitpid(pid, status, WNOHANG);
        if (result == pid) return 0;
        if (result < 0 && errno != EINTR) return -1;
        if (clock_gettime(CLOCK_MONOTONIC, &now)) return -1;
        if (now.tv_sec - start.tv_sec >= 5) return -1;
        nanosleep(&delay, NULL);
    }
}

static int read_at(int fd, void *out, size_t size, uint64_t off) {
    return off <= INT64_MAX && pread(fd, out, size, (off_t)off) == (ssize_t)size;
}

/* Return an image-relative PC only for a file-backed executable mapping of the
   exact inode opened before exec, and a unique executable PT_LOAD translation. */
static int image_offset(pid_t pid, int fd, uint64_t rip, uint64_t *out) {
    struct stat file, running;
    char path[64], line[4096];
    if (fstat(fd, &file)) return 0;
    snprintf(path, sizeof(path), "/proc/%ld/exe", (long)pid);
    if (stat(path, &running) || file.st_dev != running.st_dev || file.st_ino != running.st_ino) return 0;
    snprintf(path, sizeof(path), "/proc/%ld/maps", (long)pid);
    FILE *maps = fopen(path, "r");
    if (!maps) return 0;
    uint64_t fileoff = 0, lo, hi, off, inode;
    unsigned maj, min;
    char perms[5];
    int matched = 0;
    while (fgets(line, sizeof(line), maps)) {
        if (sscanf(line, "%" SCNx64 "-%" SCNx64 " %4s %" SCNx64 " %x:%x %" SCNu64,
                   &lo, &hi, perms, &off, &maj, &min, &inode) != 7) continue;
        if (rip >= lo && rip < hi && perms[2] == 'x' && inode == (uint64_t)file.st_ino &&
            maj == major(file.st_dev) && min == minor(file.st_dev) && off <= UINT64_MAX - (rip - lo)) {
            fileoff = off + (rip - lo);
            matched++;
        }
    }
    fclose(maps);
    if (matched != 1) return 0;
    Elf64_Ehdr eh;
    if (!read_at(fd, &eh, sizeof(eh), 0) || eh.e_ident[0] != ELFMAG0 || eh.e_ident[1] != ELFMAG1 ||
        eh.e_ident[2] != ELFMAG2 || eh.e_ident[3] != ELFMAG3 || eh.e_ident[EI_CLASS] != ELFCLASS64 ||
        eh.e_ident[EI_DATA] != ELFDATA2LSB || eh.e_machine != EM_X86_64 ||
        (eh.e_type != ET_EXEC && eh.e_type != ET_DYN) || eh.e_phentsize != sizeof(Elf64_Phdr) ||
        !eh.e_phnum || eh.e_phnum == PN_XNUM) return 0;
    uint64_t base = UINT64_MAX, va = 0;
    matched = 0;
    for (unsigned i = 0; i < eh.e_phnum; ++i) {
        Elf64_Phdr ph;
        uint64_t delta = (uint64_t)i * sizeof(ph);
        if (eh.e_phoff > UINT64_MAX - delta || !read_at(fd, &ph, sizeof(ph), eh.e_phoff + delta)) return 0;
        if (ph.p_type != PT_LOAD) continue;
        if (ph.p_vaddr < base) base = ph.p_vaddr;
        if ((ph.p_flags & PF_X) && fileoff >= ph.p_offset && fileoff - ph.p_offset < ph.p_filesz &&
            ph.p_vaddr <= UINT64_MAX - (fileoff - ph.p_offset)) {
            va = ph.p_vaddr + (fileoff - ph.p_offset);
            matched++;
        }
    }
    if (matched != 1 || va < base) return 0;
    *out = va - base;
    return 1;
}

int main(int argc, char **argv) {
    if (argc != 2) return 2;
    int fd = open(argv[1], O_RDONLY | O_CLOEXEC);
    if (fd < 0) return 2;
    pid_t pid = fork();
    if (pid < 0) { close(fd); return 2; }
    if (pid == 0) {
        int nullfd = open("/dev/null", O_RDWR);
        if (nullfd < 0 || dup2(nullfd, STDIN_FILENO) < 0 || dup2(nullfd, STDOUT_FILENO) < 0 ||
            dup2(nullfd, STDERR_FILENO) < 0) _exit(125);
        if (nullfd > STDERR_FILENO) close(nullfd);
        if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) < 0) _exit(125);
        char *const args[] = {argv[1], NULL};
        char *const env[] = {NULL};
        fexecve(fd, args, env);
        _exit(126);
    }
    int status, rc = 2;
    if (wait_bounded(pid, &status)) goto cleanup;
    if (WIFEXITED(status) || WIFSIGNALED(status)) goto reaped;
    if (!WIFSTOPPED(status) || WSTOPSIG(status) != SIGTRAP) goto cleanup;
    if (ptrace(PTRACE_SETOPTIONS, pid, NULL, (void *)(uintptr_t)PTRACE_O_EXITKILL) < 0 ||
        ptrace(PTRACE_CONT, pid, NULL, NULL) < 0 || wait_bounded(pid, &status)) goto cleanup;
    if (WIFEXITED(status)) {
        printf("{\"kind\":\"exit\",\"code\":%d}\n", WEXITSTATUS(status));
        rc = 0; goto reaped;
    }
    if (WIFSIGNALED(status)) goto reaped;
    if (!WIFSTOPPED(status)) goto cleanup;
    int sig = WSTOPSIG(status);
    if (sig != SIGILL && sig != SIGFPE && sig != SIGSEGV && sig != SIGBUS) goto cleanup;
    siginfo_t info;
    struct user_regs_struct regs;
    if (ptrace(PTRACE_GETSIGINFO, pid, NULL, &info) < 0 || info.si_signo != sig || info.si_code <= 0 ||
        ptrace(PTRACE_GETREGS, pid, NULL, &regs) < 0) goto cleanup;
    uint64_t rip = regs.rip, relative;
    printf("{\"kind\":\"fault\",\"signal\":%d,\"code\":%d,\"rip\":%" PRIu64 ",\"image_offset\":", sig, info.si_code, rip);
    if (image_offset(pid, fd, rip, &relative)) printf("%" PRIu64, relative);
    else printf("null");
    puts("}");
    rc = 0;
cleanup:
    kill(pid, SIGKILL);
    while (waitpid(pid, &status, 0) < 0 && errno == EINTR) {}
reaped:
    close(fd);
    if (rc != 0) fputs("unsupported trace, exec failure, or timeout\n", stderr);
    return rc;
}
