/* Experimental static ELF module loader; no dynamic loader or module code in the supervisor. */
#define main native_fixture_main
#include "isolation.c"
#undef main
#ifdef MODULE_LOADER_EMBEDDED
#define main loader_cli_main
#endif
#include <elf.h>
#include "many-wire.h"
struct many_launch { int parameters_fd, source_fd; };
static const struct many_launch *pending_many;
static int module_profile;
static unsigned pidfd_workers;
static uint64_t module_registration_ns,module_read_ns;
struct module_timing { uint64_t setup_ns, fork_ns, wait_ns, reap_ns; };
static struct module_timing last_module_timing;

#define MODULE_BASE UINT64_C(0x400000000000)
#define MODULE_SPACE (16u * 1024u * 1024u)
#define FILE_LIMIT (4u * 1024u * 1024u)
#define MODULE_LIMIT 8
#define EXPORT_LIMIT 32
#define DEFAULT_CALL_MS 1000u
#define MAX_CALL_MS 3600000u
enum execution_kind { EXEC_FINITE, EXEC_UNBOUNDED };
struct execution_contract { enum execution_kind kind; uint32_t budget_ms; };
static volatile sig_atomic_t execution_cancel, execution_stop;
#ifndef UBYTEC_BRIDGE_REFERENCE
static int wait_broker_events(struct pollfd *fds,nfds_t count,int milliseconds) {
    sigset_t blocked,previous; sigemptyset(&blocked);
    sigaddset(&blocked,SIGUSR1); sigaddset(&blocked,SIGINT); sigaddset(&blocked,SIGTERM);
    if(sigprocmask(SIG_BLOCK,&blocked,&previous)) return -1;
    int result;
    if(execution_cancel || execution_stop) { result=-1; errno=EINTR; }
    else {
        struct timespec timeout={milliseconds/1000,(milliseconds%1000)*1000000L};
        result=ppoll(fds,count,milliseconds<0?NULL:&timeout,&previous);
    }
    int saved=errno; sigprocmask(SIG_SETMASK,&previous,NULL); errno=saved; return result;
}
#endif

static int execution_events;
static uint64_t execution_request;
static int execution_input=-1;
static int valid_execution(struct execution_contract c) {
    return (c.kind==EXEC_FINITE && c.budget_ms && c.budget_ms<=MAX_CALL_MS) ||
           (c.kind==EXEC_UNBOUNDED && !c.budget_ms);
}
struct image { unsigned char *bytes; size_t length; Elf64_Ehdr header; Elf64_Phdr loads[8]; unsigned count; };
struct module_record { char name[64]; int fd, closed; struct image image; };
struct function_record { unsigned module; char name[64]; uint64_t entry; uint32_t rights, maximum; struct execution_contract execution; int input_byte; };
struct registry { struct module_record modules[MODULE_LIMIT]; struct function_record functions[EXPORT_LIMIT]; unsigned modules_count, functions_count, launches; };
struct module_result { struct outcome outcome; int rejected; };
/* Optional root-worker request broker. The callee is never granted this service. */
static int (*module_request_service)(int, const struct message *, unsigned);
typedef int64_t (*module_entry)(uint64_t, uint64_t, uint64_t, uint64_t);
typedef int64_t (*six_entry)(uint64_t,uint64_t,uint64_t,uint64_t,uint64_t,uint64_t);
struct loaded_context { struct module_environment environment; module_entry function; six_entry many_function; int many; uint64_t arguments[6]; };

static int file_range(size_t total, uint64_t offset, uint64_t length) {
    return offset <= total && length <= total - offset;
}
static int module_range(uint64_t address, uint64_t length) {
    return address >= MODULE_BASE && length <= MODULE_SPACE && address - MODULE_BASE <= MODULE_SPACE - length;
}
static int executable_address(const struct image *image, uint64_t address) {
    for (unsigned i = 0; i < image->count; ++i) {
        const Elf64_Phdr *p = &image->loads[i];
        if ((p->p_flags & PF_X) && address >= p->p_vaddr && address - p->p_vaddr < p->p_filesz) return 1;
    }
    return 0;
}
/* All offsets/counts are bounded before reading. No casts to potentially unaligned ELF tables. */
static int validate_image(struct image *image) {
    if (image->length < sizeof image->header) return 0;
    memcpy(&image->header, image->bytes, sizeof image->header);
    const Elf64_Ehdr *h = &image->header;
    if (memcmp(h->e_ident, ELFMAG, SELFMAG) || h->e_ident[EI_CLASS] != ELFCLASS64 ||
        h->e_ident[EI_DATA] != ELFDATA2LSB || h->e_ident[EI_VERSION] != EV_CURRENT ||
        (h->e_ident[EI_OSABI] != ELFOSABI_NONE && h->e_ident[EI_OSABI] != ELFOSABI_LINUX) ||
        h->e_type != ET_EXEC || h->e_machine != EM_X86_64 || h->e_version != EV_CURRENT ||
        h->e_ehsize != sizeof *h || h->e_flags ||
        h->e_phentsize != sizeof(Elf64_Phdr) || !h->e_phnum || h->e_phnum > 8 ||
        !file_range(image->length, h->e_phoff, (uint64_t)h->e_phnum * sizeof(Elf64_Phdr)) ||
        h->e_shentsize != sizeof(Elf64_Shdr) || !h->e_shnum || h->e_shnum > 1024 ||
        !file_range(image->length, h->e_shoff, (uint64_t)h->e_shnum * sizeof(Elf64_Shdr))) return 0;
    image->count = 0;
    uint64_t previous_end = MODULE_BASE;
    for (unsigned i = 0; i < h->e_phnum; ++i) {
        Elf64_Phdr p; memcpy(&p, image->bytes + h->e_phoff + i * sizeof p, sizeof p);
        if (p.p_type == PT_NULL) continue;
        if (p.p_type == PT_GNU_STACK) { if (p.p_flags & PF_X) return 0; continue; }
        if (p.p_type != PT_LOAD) return 0; /* No interpreter, TLS, dynamic linking or callbacks. */
        if (!p.p_memsz && !p.p_filesz) continue;
        if (p.p_filesz > p.p_memsz || !file_range(image->length, p.p_offset, p.p_filesz) ||
            !module_range(p.p_vaddr, p.p_memsz) || (p.p_vaddr & 4095) ||
            (p.p_align > 1 && ((p.p_align & (p.p_align-1)) || p.p_align > MODULE_SPACE ||
                              p.p_vaddr % p.p_align != p.p_offset % p.p_align)) ||
            (p.p_flags != PF_R && p.p_flags != (PF_R|PF_X) && p.p_flags != (PF_R|PF_W))) return 0;
        uint64_t rounded = (p.p_memsz + 4095) & ~UINT64_C(4095);
        if (!module_range(p.p_vaddr, rounded) || p.p_vaddr < previous_end) return 0;
        previous_end = p.p_vaddr + rounded;
        image->loads[image->count++] = p;
    }
    if (!image->count || !executable_address(image, h->e_entry)) return 0;
    for (unsigned i = 0; i < h->e_shnum; ++i) {
        Elf64_Shdr s; memcpy(&s, image->bytes + h->e_shoff + i * sizeof s, sizeof s);
        if (s.sh_type != SHT_NOBITS && !file_range(image->length, s.sh_offset, s.sh_size)) return 0;
        if (s.sh_type == SHT_DYNAMIC || s.sh_type == SHT_DYNSYM ||
            ((s.sh_type == SHT_REL || s.sh_type == SHT_RELA) && s.sh_size)) return 0;
    }
    return 1;
}
static int find_export(const struct image *image, const char *name, uint64_t *entry) {
    if (strncmp(name, "ubytec_host_", 12) || strlen(name) >= 64) return 0;
    for (const char *c = name; *c; ++c)
        if (!( (*c >= 'a' && *c <= 'z') || (*c >= 'A' && *c <= 'Z') ||
               (*c >= '0' && *c <= '9') || *c == '_')) return 0;
    unsigned found = 0;
    for (unsigned i = 0; i < image->header.e_shnum; ++i) {
        Elf64_Shdr s; memcpy(&s, image->bytes + image->header.e_shoff + i * sizeof s, sizeof s);
        if (s.sh_type != SHT_SYMTAB) continue;
        if (s.sh_entsize != sizeof(Elf64_Sym) || s.sh_size % sizeof(Elf64_Sym) ||
            s.sh_link >= image->header.e_shnum) return 0;
        Elf64_Shdr strings; memcpy(&strings, image->bytes + image->header.e_shoff + s.sh_link * sizeof strings, sizeof strings);
        if (strings.sh_type != SHT_STRTAB) return 0;
        for (uint64_t off = 0; off < s.sh_size; off += sizeof(Elf64_Sym)) {
            Elf64_Sym sym; memcpy(&sym, image->bytes + s.sh_offset + off, sizeof sym);
            if (sym.st_name >= strings.sh_size) return 0;
            const char *symbol = (const char *)image->bytes + strings.sh_offset + sym.st_name;
            if (!memchr(symbol, 0, strings.sh_size - sym.st_name)) return 0;
            if (strcmp(symbol, name)) continue;
            if (ELF64_ST_BIND(sym.st_info) != STB_GLOBAL ||
                (ELF64_ST_TYPE(sym.st_info) != STT_FUNC && ELF64_ST_TYPE(sym.st_info) != STT_NOTYPE) ||
                !sym.st_shndx || sym.st_shndx >= image->header.e_shnum ||
                !executable_address(image, sym.st_value)) return 0;
            Elf64_Shdr section; memcpy(&section, image->bytes + image->header.e_shoff + sym.st_shndx * sizeof section, sizeof section);
            if ((section.sh_flags & (SHF_ALLOC|SHF_EXECINSTR)) != (SHF_ALLOC|SHF_EXECINSTR) || ++found != 1) return 0;
            *entry = sym.st_value;
        }
    }
    return found == 1;
}
static int read_image(int fd, struct image *image) {
    uint64_t profile_read=module_profile?now_ns():0;
    struct stat stat; memset(image, 0, sizeof *image);
    if (fstat(fd, &stat) || !S_ISREG(stat.st_mode) || stat.st_size < (off_t)sizeof(Elf64_Ehdr) ||
        stat.st_size > FILE_LIMIT) return 0;
    image->length = (size_t)stat.st_size; image->bytes = malloc(image->length);
    if (!image->bytes) return 0;
    size_t done = 0;
    while (done < image->length) {
        ssize_t n = pread(fd, image->bytes + done, image->length - done, (off_t)done);
        if (n < 0 && errno == EINTR) continue;
        if (n <= 0) { free(image->bytes); image->bytes = NULL; return 0; }
        done += (size_t)n;
    }
    if (!validate_image(image)) { free(image->bytes); image->bytes = NULL; return 0; }
    if(module_profile) module_read_ns+=now_ns()-profile_read;
    return 1;
}
static int register_module(struct registry *r, const char *name, const char *path) {
    uint64_t profile_registration=module_profile?now_ns():0;
    if (!*name || strlen(name) >= 64 || r->modules_count >= MODULE_LIMIT) return -1;
    for (unsigned i = 0; i < r->modules_count; ++i) if (!strcmp(r->modules[i].name, name)) return -1;
    int original = open(path, O_RDONLY|O_CLOEXEC|O_NOFOLLOW);
    if (original < 0) return -1;
    struct image image; int valid = read_image(original, &image); close(original);
    if (!valid) return -1;
    int fd = memfd_create("ubytec-module", MFD_CLOEXEC|MFD_ALLOW_SEALING);
    size_t done = 0;
    while (fd >= 0 && done < image.length) {
        ssize_t n = write(fd, image.bytes + done, image.length - done);
        if (n < 0 && errno == EINTR) continue;
        if (n <= 0) break;
        done += (size_t)n;
    }
    if (fd < 0 || done != image.length ||
        fcntl(fd, F_ADD_SEALS, F_SEAL_WRITE|F_SEAL_GROW|F_SEAL_SHRINK|F_SEAL_SEAL) < 0) {
        if (fd >= 0) close(fd);
        free(image.bytes); return -1;
    }
    unsigned id = r->modules_count++;
    struct module_record *module = &r->modules[id];
    memset(module, 0, sizeof *module); strcpy(module->name, name); module->fd = fd; module->image = image;
    if(module_profile) module_registration_ns+=now_ns()-profile_registration;
    return (int)id;
}
static int register_function(struct registry *r, unsigned module, const char *name,
                             const char *symbol, uint32_t rights, uint32_t maximum) {
    if (module >= r->modules_count || r->modules[module].closed || !*name || strlen(name) >= 64 ||
        r->functions_count >= EXPORT_LIMIT || (rights != LOAN_READ && rights != LOAN_READ_WRITE) ||
        !maximum || maximum > MAX_PAYLOAD) return 0;
    for (unsigned i = 0; i < r->functions_count; ++i)
        if (r->functions[i].module == module && !strcmp(r->functions[i].name, name)) return 0;
    uint64_t entry;
    if (!find_export(&r->modules[module].image, symbol, &entry)) return 0;
    struct function_record *fn = &r->functions[r->functions_count++];
    *fn = (struct function_record){ .module=module, .entry=entry, .rights=rights, .maximum=maximum, .execution={EXEC_FINITE,DEFAULT_CALL_MS} };
    strcpy(fn->name, name); return 1;
}
static void close_registered_module(struct registry *r, unsigned module) {
    if (module >= r->modules_count || r->modules[module].closed) return;
    close(r->modules[module].fd); free(r->modules[module].image.bytes);
    r->modules[module].fd=-1; r->modules[module].image.bytes=NULL; r->modules[module].closed=1;
}
static void registry_close(struct registry *r) {
    for (unsigned i = 0; i < r->modules_count; ++i) {
        close_registered_module(r,i);
    }
}
static __attribute__((used,noinline)) void module_payload(struct loaded_context *context) {
    struct module_environment *e = &context->environment;
    uint64_t start = tsc();
    int64_t value = context->many ?
        context->many_function(context->arguments[0],context->arguments[1],context->arguments[2],
                                      context->arguments[3],context->arguments[4],context->arguments[5]) :
        context->function(e->buffer, e->length, e->foreign, e->monitor);
    struct message m = { 1, e->region, e->invocation, e->rights, e->length, (uint32_t)value, tsc()-start, value };
    raw_call(__NR_write, 3, (long)&m, sizeof m);
    raw_call(__NR_exit_group, 0, 0, 0); __builtin_unreachable();
}
extern void launch_module(struct loaded_context *, void *);
__asm__(".text\n.global launch_module\nlaunch_module:\nmov %rsi,%rsp\nand $-16,%rsp\nxor %ebp,%ebp\ncall module_payload\nud2\n");
static void module_worker(int argc, char **argv) {
    if ((argc != 9 && argc!=10) || sysconf(_SC_PAGESIZE) != 4096) _exit(120);
    int seals = fcntl(5, F_GET_SEALS);
    int required = F_SEAL_WRITE|F_SEAL_GROW|F_SEAL_SHRINK|F_SEAL_SEAL;
    struct image image;
    if (seals < 0 || (seals & required) != required || !read_image(5, &image)) _exit(120);
    uint64_t entry = strtoull(argv[7], NULL, 10);
    if (!executable_address(&image, entry)) _exit(120);
    if (mmap((void *)MODULE_BASE, MODULE_SPACE, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0) == MAP_FAILED) _exit(120);
    for (unsigned i = 0; i < image.count; ++i) {
        const Elf64_Phdr *p = &image.loads[i]; size_t mapped = (size_t)((p->p_memsz+4095)&~UINT64_C(4095));
        void *destination = mmap((void *)p->p_vaddr, mapped, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
        if (destination == MAP_FAILED) _exit(120);
        memcpy(destination, image.bytes + p->p_offset, p->p_filesz);
        int prot = PROT_READ | ((p->p_flags & PF_W) ? PROT_WRITE : 0) | ((p->p_flags & PF_X) ? PROT_EXEC : 0);
        if (mprotect(destination, mapped, prot)) _exit(120);
    }
    free(image.bytes); close(5);
    struct loaded_context context = {
        .environment = { .buffer=LOAN_BASE, .foreign=HOST_BASE+4096, .monitor=HOST_BASE,
            .length=(uint32_t)strtoul(argv[2],NULL,10), .region=(uint32_t)strtoul(argv[3],NULL,10),
            .invocation=(uint32_t)strtoul(argv[4],NULL,10), .rights=(uint32_t)strtoul(argv[5],NULL,10) },
        .many_function=(six_entry)(uintptr_t)entry, .function=(module_entry)(uintptr_t)entry
    };
    uint32_t mapped = (uint32_t)strtoul(argv[6],NULL,10);
    int grant = !strcmp(argv[8],"1");
    if (!mapped || mapped > MAX_PAYLOAD || !context.environment.length || context.environment.length > mapped ||
        (context.environment.rights != LOAN_READ && context.environment.rights != LOAN_READ_WRITE)) _exit(120);
    if (mmap((void *)HOST_BASE,8192,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE,-1,0)==MAP_FAILED ||
        mmap((void *)(LOAN_BASE-4096),mapped+8192,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE,-1,0)==MAP_FAILED) _exit(120);
    if (grant && mmap((void *)LOAN_BASE,mapped,PROT_READ | (context.environment.rights==LOAN_READ_WRITE ? PROT_WRITE:0),
                      MAP_SHARED|MAP_FIXED,4,0)==MAP_FAILED) _exit(120);
    close(4);
    if(argc==10) {
        struct many_parameters p;
        int need=F_SEAL_WRITE|F_SEAL_GROW|F_SEAL_SHRINK|F_SEAL_SEAL;
        int seals=fcntl(6,F_GET_SEALS);
        struct stat stat;
        if(strcmp(argv[9],"many") || fstat(6,&stat) || stat.st_size!=sizeof p ||
           seals<0 || (seals&need)!=need || pread(6,&p,sizeof p,0)!=sizeof p ||
           p.count>6 || p.loans>2 || p.length[0]>MAX_PAYLOAD || p.length[1]>MAX_PAYLOAD) _exit(120);
        close(6); unsigned ordinal=0;
        for(unsigned i=0;i<p.count;i++) {
            if(p.kinds[i]==1 || p.kinds[i]==2) {
                if(ordinal>=p.loans || p.rights[ordinal]!=(p.kinds[i]==1?3u:1u)) _exit(120);
                context.arguments[i]=ordinal++?MANY_SOURCE_BASE:LOAN_BASE;
            } else if(p.kinds[i]==3 || p.kinds[i]==4) context.arguments[i]=p.values[i];
            else _exit(120);
        }
        if(ordinal!=p.loans) _exit(120);
        if(p.loans==2) {
            uint32_t second=(p.length[1]+4095u)&~4095u;
            if(mmap((void *)(MANY_SOURCE_BASE-4096),second+8192,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE,-1,0)==MAP_FAILED) _exit(120);
            if(p.length[1] && mmap((void *)MANY_SOURCE_BASE,second,PROT_READ|(p.rights[1]==3?PROT_WRITE:0),
                MAP_SHARED|MAP_FIXED,7,0)==MAP_FAILED) _exit(120);
        }
        close(7); context.many=1;
    }
    struct rlimit limit; if (getrlimit(RLIMIT_NOFILE,&limit)) _exit(120);
    for (int fd=0;fd<3;++fd) close(fd);
    if (syscall(SYS_close_range,4u,~0u,0u)<0)
        for (int fd=4;fd<(int)limit.rlim_cur;++fd) close(fd);
    unsigned char *stack=mmap(NULL,STACK_SIZE+8192,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
    if (stack==MAP_FAILED || mprotect(stack+4096,STACK_SIZE,PROT_READ|PROT_WRITE)) _exit(120);
    struct loaded_context *loaded=(struct loaded_context *)(stack+4096); *loaded=context;
    if (install_filter()) _exit(121);
    launch_module(loaded,stack+4096+STACK_SIZE); _exit(122);
}

static struct outcome execute_module(const struct module_record *module, const struct function_record *function, struct region *r, enum loan_rights rights, int grant) {
    uint64_t profile_start=module_profile?now_ns():0,profile_fork=0,profile_wait=0,profile_reap=0;
    struct loan_descriptor loan = { r->descriptor.id, function->module+2, ++sequence, rights };
    int ipc[2]; if (socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc)) die("socketpair");
    int child_ipc = fcntl(ipc[1], F_DUPFD_CLOEXEC, 10);
    int child_region = fcntl(r->fd, F_DUPFD_CLOEXEC, 10);
    int child_module = fcntl(module->fd, F_DUPFD_CLOEXEC, 10);
    if (child_ipc < 0 || child_region < 0 || child_module < 0) die("duplicate");
    char fixture[24], length[24], region[24], invocation[24], permission[24], mapped[24];
    snprintf(fixture, sizeof fixture, "%llu", (unsigned long long)function->entry);
    snprintf(length, sizeof length, "%u", r->descriptor.length);
    snprintf(region, sizeof region, "%u", loan.region);
    snprintf(invocation, sizeof invocation, "%u", loan.invocation);
    snprintf(permission, sizeof permission, "%u", rights);
    snprintf(mapped, sizeof mapped, "%u", r->descriptor.mapped_length);
    int many=function->module!=0 && pending_many!=NULL;
    int child_parameters=-1,child_source=-1;
    if(many) {
        child_parameters=fcntl(pending_many->parameters_fd,F_DUPFD_CLOEXEC,10);
        child_source=fcntl(pending_many->source_fd,F_DUPFD_CLOEXEC,10);
        if(child_parameters<0 || child_source<0) die("many descriptors");
    }
    profile_fork=module_profile?now_ns():0;
    pid_t supervisor=getpid();
    pid_t pid = fork(); if (pid < 0) die("fork");
    if (!pid) {
        // A cancelled or abruptly lost supervisor must not leave a persistent borrower alive.
        if (prctl(PR_SET_PDEATHSIG,SIGKILL) || getppid()!=supervisor) _exit(120);
        struct rlimit core = {0,0}; setrlimit(RLIMIT_CORE, &core);
        if (dup2(child_ipc, 3) < 0 || dup2(child_region, 4) < 0 || dup2(child_module, 5) < 0) _exit(120);
        if(many && (dup2(child_parameters,6)<0 || dup2(child_source,7)<0)) _exit(120);
        char *const child_arguments[] = { "modules", "--module-worker", length, region, invocation,
            permission, mapped, fixture, grant ? "1" : "0", many?"many":NULL, NULL };
        char *const child_environment[] = { "LANG=C", NULL };
        execve("/proc/self/exe", child_arguments, child_environment);
        _exit(120);
    }
    profile_wait=module_profile?now_ns():0;
    if(many) { close(child_parameters); close(child_source); }
    close(child_ipc); close(child_region); close(child_module); close(ipc[1]);
    int pidfd=-1;
#if !defined(UBYTEC_BRIDGE_REFERENCE) && !defined(UBYTEC_NO_PIDFD) && defined(SYS_pidfd_open)
    pidfd=(int)syscall(SYS_pidfd_open,pid,0);
    if(pidfd>=0) ++pidfd_workers;
#endif
    int flags = fcntl(ipc[0], F_GETFL); fcntl(ipc[0], F_SETFL, flags | O_NONBLOCK);
    struct outcome out = {0};
    struct message message; size_t received = 0;
    int status = 0, reaped = 0; uint64_t started = now_ns();
    if (execution_events) {
        printf("{\"event\":\"started\",\"request\":%llu,\"worker_pid\":%ld,\"mode\":\"%s\",\"budget_ms\":%u}\n",
               (unsigned long long)execution_request,(long)pid,
               function->execution.kind==EXEC_UNBOUNDED ? "unbounded":"finite",function->execution.budget_ms);
        fflush(stdout);
    }
    struct rusage usage = {0}; int input_sent=0;
    while (!reaped) {
        if (received < sizeof message) {
            ssize_t n = read(ipc[0], (unsigned char *)&message + received, sizeof message - received);
            if (n > 0) received += (size_t)n;
        }
        if (received==sizeof message && (message.operation==2 || message.operation==4 || message.operation==6) && module_request_service) {
            if (!module_request_service(ipc[0],&message,function->module)) {
                out.cancelled=!!(execution_cancel || execution_stop);
                out.protocol_error=!out.cancelled;
                kill(pid,SIGKILL);
                pid_t collected;
                do { collected=wait4(pid,&status,0,&usage); } while (collected<0 && errno==EINTR);
                if (collected!=pid) die("reap broker protocol");
                reaped=1; break;
            }
            received=0;
        }
        if (function->input_byte && execution_input>=0 && !input_sent) {
            struct pollfd input = {execution_input,POLLIN,0};
            if (poll(&input,1,0)>0 && (input.revents & (POLLIN|POLLHUP))) {
                unsigned char byte; ssize_t n=read(execution_input,&byte,1);
                if (n==1) {
                    // A bounded data event, never a permission or identity supplied by the worker.
                    if (send(ipc[0],&byte,1,MSG_NOSIGNAL|MSG_DONTWAIT)==1) input_sent=1;
                } else if (!n) input_sent=1;
            }
        }
        pid_t got = wait4(pid, &status, WNOHANG, &usage);
        if (got == pid) { reaped = 1; break; }
        if (got < 0 && errno != EINTR) die("wait");
        int expired=function->execution.kind==EXEC_FINITE &&
                    now_ns()-started >= (uint64_t)function->execution.budget_ms * 1000000ULL;
        if (execution_cancel || execution_stop || expired) {
            out.cancelled = !!(execution_cancel || execution_stop);
            out.timed_out = expired && !out.cancelled;
            kill(pid, SIGKILL);
            pid_t collected;
            do { collected=wait4(pid,&status,0,&usage); } while (collected<0 && errno==EINTR);
            if (collected!=pid) die("reap cancelled worker");
            reaped = 1; break;
        }
#ifdef UBYTEC_BRIDGE_REFERENCE
        struct pollfd poller = { ipc[0], POLLIN, 0 };
        if (received == sizeof message) { struct timespec pause = {0, 1000000}; nanosleep(&pause, NULL); }
        else poll(&poller, 1, 1);
#else
        if(pidfd<0 && received==sizeof message) {
            /* Older kernels: keep bounded cancellation/exit checks without spinning on EOF. */
            wait_broker_events(NULL,0,1);
        } else {
            struct pollfd ready[3]={{received==sizeof message?-1:ipc[0],POLLIN,0},{pidfd,POLLIN,0},{-1,POLLIN,0}};
            if(function->input_byte && execution_input>=0 && !input_sent) ready[2].fd=execution_input;
            int milliseconds=pidfd<0?1:-1;
            if(function->execution.kind==EXEC_FINITE) {
                uint64_t elapsed=now_ns()-started,budget=(uint64_t)function->execution.budget_ms*1000000ULL;
                int remaining=elapsed>=budget?0:(int)((budget-elapsed+999999)/1000000ULL);
                if(milliseconds<0 || remaining<milliseconds) milliseconds=remaining;
            }
            if(wait_broker_events(ready,3,milliseconds)<0 && errno!=EINTR) die("worker readiness");
        }
#endif
    }
    profile_reap=module_profile?now_ns():0;
    while (received < sizeof message) {
        ssize_t n = read(ipc[0], (unsigned char *)&message + received, sizeof message - received);
        if (n <= 0) break;
        received += (size_t)n;
    }
    unsigned char extra; int trailing = read(ipc[0], &extra, 1) > 0;
    if(pidfd>=0) close(pidfd);
    close(ipc[0]); /* The worker is reaped before the loan can be reused. */
    out.rss_kib = usage.ru_maxrss;
    if (WIFSIGNALED(status)) out.signal = WTERMSIG(status);
    else if (!WIFEXITED(status) || WEXITSTATUS(status)) out.setup_error = 1;
    if (!out.signal && !out.timed_out && !out.cancelled && !out.setup_error) {
        out.protocol_error = received != sizeof message || trailing;
        if (!out.protocol_error)
            out.protocol_error = message.operation != 1 || message.region != loan.region ||
                message.invocation != loan.invocation || message.rights != (uint32_t)rights ||
                message.length != r->descriptor.length;
        if (!out.protocol_error) { out.checksum = message.checksum; out.ticks = message.ticks; out.value = message.value; }
    }
    if(module_profile) last_module_timing=(struct module_timing){
        profile_fork-profile_start,profile_wait-profile_fork,profile_reap-profile_wait,now_ns()-profile_reap};
    return out;
}

static struct module_result call_module(struct registry *r, const char *module_name, const char *function_name,
                                        struct region *region, enum loan_rights rights, int grant) {
    struct module_result result = { .rejected=1 };
    unsigned module = r->modules_count;
    for (unsigned i=0;i<r->modules_count;++i)
        if (!strcmp(r->modules[i].name,module_name)) { module=i; break; }
    if (module==r->modules_count || r->modules[module].closed ||
        (rights!=LOAN_READ && rights!=LOAN_READ_WRITE) ||
        !region->descriptor.length || region->descriptor.length>MAX_PAYLOAD || region->descriptor.owner!=1) return result;
    for (unsigned i=0;i<r->functions_count;++i) {
        const struct function_record *fn=&r->functions[i];
        if (fn->module!=module || strcmp(fn->name,function_name)) continue;
        if ((rights & fn->rights)!=rights || region->descriptor.length>fn->maximum || !valid_execution(fn->execution)) return result;
        result.rejected=0; ++r->launches;
        result.outcome=execute_module(&r->modules[module],fn,region,rights,grant); return result;
    }
    return result;
}
static int successful(struct module_result result) {
    const struct outcome *o=&result.outcome;
    return !result.rejected && !o->signal && !o->timed_out && !o->cancelled && !o->setup_error && !o->protocol_error;
}
static int emit_case(const char *name, int pass, struct module_result result) {
    printf("{\"case\":\"%s\",\"pass\":%s,\"rejected\":%d,\"signal\":%d,\"timeout\":%d,\"cancelled\":%d,\"protocol_rejected\":%d,\"value\":%lld}\n",
           name, pass ? "true":"false",result.rejected,result.outcome.signal,result.outcome.timed_out,
           result.outcome.cancelled,result.outcome.protocol_error,(long long)result.outcome.value);
    return !pass;
}
static int module_tests(const char *data, const char *faults, const char *native) {
    struct registry registry={0}; int failed=0;
    int a=register_module(&registry,"data",data), b=register_module(&registry,"faults",faults), c=register_module(&registry,"native",native);
    if (a<0 || b<0 || c<0) { fprintf(stderr,"Module registration failed\n"); return 2; }
    struct test_case { const char *module,*name,*symbol; uint32_t rights,maximum; int signal,timeout,protocol,grant,commit; int64_t value; };
    const struct test_case cases[]={
        {"data","read","ubytec_host_read",LOAN_READ,65536,0,0,0,1,0,256},
        {"data","own_private_data","ubytec_host_own_data",LOAN_READ,256,0,0,0,1,0,INT64_C(1234605616436508552)},
        {"data","tail_infinite","ubytec_host_tail_infinite",LOAN_READ,256,SIGKILL,1,0,1,0,0},
        {"data","tail_self","ubytec_host_tail_self",LOAN_READ,256,0,0,0,1,0,1400000},
        {"data","tail_mutual","ubytec_host_tail_mutual",LOAN_READ,256,0,0,0,1,0,200000},
        {"data","write","ubytec_host_write",LOAN_READ_WRITE,65536,0,0,0,1,1,INT64_C(4294967297)},
        {"data","copy","ubytec_host_copy",LOAN_READ_WRITE,65536,0,0,0,1,1,INT64_C(4294967297)},
        {"faults","read_only_write","ubytec_host_read_only_write",LOAN_READ,256,SIGSEGV,0,0,1,0,0},
        {"faults","foreign_pointer","ubytec_host_foreign",LOAN_READ,256,SIGSEGV,0,0,1,0,0},
        {"faults","monitor_pointer","ubytec_host_monitor",LOAN_READ_WRITE,256,SIGSEGV,0,0,1,0,0},
        {"faults","neighbor_pointer","ubytec_host_neighbor",LOAN_READ_WRITE,256,SIGSEGV,0,0,1,0,0},
        {"faults","stack_overflow","ubytec_host_stack_overflow",LOAN_READ,256,SIGSEGV,0,0,1,0,0},
        {"faults","infinite_loop","ubytec_host_loop",LOAN_READ,256,SIGKILL,1,0,1,0,0},
        {"faults","stale_pointer","ubytec_host_stale",LOAN_READ,256,SIGSEGV,0,0,0,0,0},
        {"faults","partial_write_failure","ubytec_host_partial",LOAN_READ_WRITE,256,SIGSEGV,0,0,1,0,0},
        {"native","forged_request","ubytec_host_forge",LOAN_READ,256,0,0,1,1,0,0},
        {"native","open_resource","ubytec_host_open",LOAN_READ,256,SIGSYS,0,0,1,0,0},
        {"native","fresh_private_state","ubytec_host_state",LOAN_READ,256,0,0,0,1,0,1},
        {"native","write_code","ubytec_host_write_code",LOAN_READ,256,SIGSEGV,0,0,1,0,0},
        {"native","execute_loan","ubytec_host_execute",LOAN_READ,256,SIGSEGV,0,0,1,0,0},
        {"native","read_other_module_data","ubytec_host_other_data",LOAN_READ,256,SIGSEGV,0,0,1,0,0}
    };
    for (unsigned i=0;i<sizeof cases/sizeof cases[0];++i) {
        unsigned id=!strcmp(cases[i].module,"data") ? (unsigned)a : !strcmp(cases[i].module,"faults") ? (unsigned)b : (unsigned)c;
        if (!register_function(&registry,id,cases[i].name,cases[i].symbol,cases[i].rights,cases[i].maximum)) return 2;
    }
    if (!register_function(&registry,(unsigned)c,"small","ubytec_host_state",LOAN_READ,128)) return 2;
    struct region region=create_region(1,256);
    monitor_secret=mmap((void *)HOST_BASE,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE,-1,0);
    if (monitor_secret==MAP_FAILED) die("module monitor canary");
    memset(monitor_secret,0xa5,8192);
    for (unsigned i=0;i<sizeof cases/sizeof cases[0];++i) {
        const struct test_case *test=&cases[i];
        memset(region.data,0,region.descriptor.mapped_length); memset(region.data,1,256);
        if (!strcmp(test->name,"execute_loan")) region.data[0]=0xc3;
        struct module_result result=call_module(&registry,test->module,test->name,&region,test->rights,test->grant);
        const struct outcome *o=&result.outcome;
        int pass=!result.rejected && !o->setup_error && o->signal==test->signal &&
                 o->timed_out==test->timeout && o->protocol_error==test->protocol;
        if (!test->signal && !test->timeout && !test->protocol) pass &= o->value==test->value;
        unsigned char destination[272]; memset(destination,0xa5,sizeof destination);
        if (successful(result) && test->commit) memcpy(destination+8,region.data,256);
        for (unsigned n=0;n<sizeof destination;++n)
            pass &= destination[n]==(test->commit && n>=8 && n<264 ? 0x5a:0xa5);
        if (!strcmp(test->name,"partial_write_failure")) pass &= region.data[0]==90;
        for (unsigned n=256;n<region.descriptor.mapped_length;++n) pass &= region.data[n]==0;
        for (unsigned n=0;n<8192;++n) pass &= monitor_secret[n]==0xa5;
        failed+=emit_case(test->name,pass,result);
        memset(region.data,1,256);
        struct module_result recovery=call_module(&registry,"data","read",&region,LOAN_READ,1);
        char name[96]; snprintf(name,sizeof name,"recovery_after_%s",test->name);
        failed+=emit_case(name,successful(recovery) && recovery.outcome.value==256,recovery);
    }
    unsigned launches=registry.launches;
    struct module_result rejected=call_module(&registry,"data","read",&region,LOAN_READ_WRITE,1);
    failed+=emit_case("rights_ceiling",rejected.rejected && registry.launches==launches,rejected);
    rejected=call_module(&registry,"native","small",&region,LOAN_READ,1);
    failed+=emit_case("size_contract",rejected.rejected && registry.launches==launches,rejected);
    rejected=call_module(&registry,"missing","read",&region,LOAN_READ,1);
    failed+=emit_case("unknown_module",rejected.rejected && registry.launches==launches,rejected);
    rejected=call_module(&registry,"data","foreign_pointer",&region,LOAN_READ,1);
    failed+=emit_case("unregistered_function",rejected.rejected && registry.launches==launches,rejected);
    region.descriptor.owner=999;
    rejected=call_module(&registry,"data","read",&region,LOAN_READ,1);
    failed+=emit_case("wrong_owner",rejected.rejected && registry.launches==launches,rejected);
    region.descriptor.owner=1;
    int pass=!register_function(&registry,(unsigned)a,"read","ubytec_host_read",LOAN_READ,256) &&
             !register_function(&registry,(unsigned)a,"absent","ubytec_host_absent",LOAN_READ,256) &&
             !register_function(&registry,(unsigned)a,"invalid","ubytec_host_read",7,256) &&
             register_module(&registry,"data",data)<0;
    failed+=emit_case("invalid_registration",pass,(struct module_result){0});
    /* The supervisor never grants writes to the immutable executable snapshot. */
    unsigned char byte=0;
    pass=pwrite(registry.modules[c].fd,&byte,1,0)<0 && errno==EPERM;
    failed+=emit_case("sealed_snapshot",pass,(struct module_result){0});
    /* Mutating the original path cannot change the already registered image. */
    int original=open(native,O_WRONLY|O_CLOEXEC);
    pass=original>=0 && pwrite(original,&byte,1,0)==1;
    if (original>=0) close(original);
    struct module_result snapshot=call_module(&registry,"native","fresh_private_state",&region,LOAN_READ,1);
    pass &= successful(snapshot) && snapshot.outcome.value==1;
    failed+=emit_case("source_replaced_after_registration",pass,snapshot);
    close_registered_module(&registry,(unsigned)a); launches=registry.launches;
    rejected=call_module(&registry,"data","read",&region,LOAN_READ,1);
    failed+=emit_case("closed_module",rejected.rejected && registry.launches==launches,rejected);
    registry_close(&registry); destroy_region(&region); munmap(monitor_secret,8192);
    return failed ? 1:0;
}

static int module_benchmark(const char *path) {
    struct registry registry={0};
    int id=register_module(&registry,"data",path);
    if (id<0 || !register_function(&registry,(unsigned)id,"read","ubytec_host_read",LOAN_READ,MAX_PAYLOAD)) return 2;
    const unsigned sizes[]={256,4096,65536};
    for (unsigned j=0;j<3;++j) {
        struct region region=create_region(1,sizes[j]); memset(region.data,1,sizes[j]);
        double times[100],ticks[100]; long peak=0;
        for (unsigned i=0;i<110;++i) {
            uint64_t start=now_ns();
            struct module_result result=call_module(&registry,"data","read",&region,LOAN_READ,1);
            uint64_t end=now_ns();
            if (!successful(result) || result.outcome.value!=sizes[j]) return 1;
            if (result.outcome.rss_kib>peak) peak=result.outcome.rss_kib;
            if (i>=10) { times[i-10]=(end-start)/1000.0; ticks[i-10]=(double)result.outcome.ticks; }
        }
        statistics("module_invocation_and_read",sizes[j],times,100,peak,region.descriptor.mapped_length);
        qsort(ticks,100,sizeof *ticks,compare_double);
        printf("{\"metric\":\"module_worker_byte_read\",\"bytes\":%u,\"samples\":100,\"median_tsc_ticks\":%.0f,\"p95_tsc_ticks\":%.0f,\"module_reserved_bytes\":%u}\n",
               sizes[j],ticks[50],ticks[94],MODULE_SPACE);
        destroy_region(&region);
    }
    registry_close(&registry); return 0;
}
static void execution_signal(int signo) {
    execution_cancel=1;
    if (signo==SIGINT || signo==SIGTERM) execution_stop=1;
}
static int install_execution_signals(void) {
    struct sigaction action={0};
    action.sa_handler=execution_signal;
    sigemptyset(&action.sa_mask);
    return !sigaction(SIGUSR1,&action,NULL) &&
           !sigaction(SIGINT,&action,NULL) && !sigaction(SIGTERM,&action,NULL);
}
static int parse_u32(const char *text, uint32_t *out) {
    char *end; errno=0; unsigned long long value=strtoull(text,&end,10);
    if (!*text || *text<'0' || *text>'9' || *end || errno || value>UINT32_MAX) return 0;
    *out=(uint32_t)value; return 1;
}
int main(int argc,char **argv) {
    if (argc>1 && !strcmp(argv[1],"--module-worker")) module_worker(argc,argv);
    if (argc==3 && !strcmp(argv[1],"--benchmark")) return module_benchmark(argv[2]);
    if (argc==3 && !strcmp(argv[1],"--validate")) {
        struct registry registry={0}; int accepted=register_module(&registry,"validation",argv[2])>=0;
        printf("{\"accepted\":%s}\n",accepted ? "true":"false"); registry_close(&registry); return accepted ? 0:1;
    }
    if (argc==5 && !strcmp(argv[1],"--tests")) return module_tests(argv[2],argv[3],argv[4]);
    if ((argc==7 || argc==8 || argc==9) && !strcmp(argv[1],"--call")) {
        uint32_t ceiling,rights,length;
        if (!parse_u32(argv[4],&ceiling) || !parse_u32(argv[5],&rights) || !parse_u32(argv[6],&length) ||
            !length || length>MAX_PAYLOAD) return 2;
        struct registry registry={0}; int id=register_module(&registry,"module",argv[2]);
        if (id<0 || !register_function(&registry,(unsigned)id,"function",argv[3],ceiling,MAX_PAYLOAD)) {
            registry_close(&registry); puts("{\"accepted\":false,\"registration_rejected\":true}"); return 1;
        }
        struct execution_contract contract={EXEC_FINITE,DEFAULT_CALL_MS};
        if (argc>=8) {
            if (!strcmp(argv[7],"none")) contract=(struct execution_contract){EXEC_UNBOUNDED,0};
            else if (!parse_u32(argv[7],&contract.budget_ms) || !valid_execution(contract)) {
                registry_close(&registry); return 2;
            }
        }
        if (argc==9 && strcmp(argv[8],"--input-byte")) { registry_close(&registry); return 2; }
        registry.functions[0].execution=contract;
        registry.functions[0].input_byte=argc==9;
        execution_input=argc==9 ? STDIN_FILENO:-1;
        if (!install_execution_signals()) { registry_close(&registry); return 2; }
        execution_events=1; execution_request=1;
        struct region region=create_region(1,length); memset(region.data,1,length);
        struct module_result result=call_module(&registry,"module","function",&region,(enum loan_rights)rights,1);
        int ok=successful(result); emit_case("call",ok,result);
        registry_close(&registry); destroy_region(&region); return ok ? 0:1;
    }
    fprintf(stderr,"Usage: modules --call module.elf ubytec_host_symbol contract_rights loan_rights bytes [budget_ms|none] [--input-byte]\n"
                   "       modules --validate module.elf | --tests data.elf faults.elf disposable-native.elf\n");
    return 2;
}
