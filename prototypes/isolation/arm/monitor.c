#include "../common/contract.h"
#define REG(address) (*(volatile uint32_t *)(uintptr_t)(address))
#define MPU_TYPE 0xe000ed90u
#define MPU_CTRL 0xe000ed94u
#define MPU_RNR 0xe000ed98u
#define MPU_RBAR 0xe000ed9cu
#define MPU_RASR 0xe000eda0u
#define SHCSR 0xe000ed24u
#define CFSR 0xe000ed28u
#define HFSR 0xe000ed2cu
#define SYST_CSR 0xe000e010u
#define SYST_RVR 0xe000e014u
#define SYST_CVR 0xe000e018u
#define STACK_BASE 0x20010000u
#define STACK_LENGTH 4096u
#define PRIVATE_BASE 0x20012000u
#define LOAN_BASE 0x20020000u
#define FOREIGN_BASE 0x20040000u
#define MODULE_CODE_BASE 0x00010000u
#define MODULE_CODE_END 0x00020000u
#define ARM_WAIT_EVENT ((enum fixture)F_COUNT)
#define MAX_BUDGET_TICKS 1000000u
#define EVENT_WORD (PRIVATE_BASE+132u)
#define USER __attribute__((section(".module_text"),noinline))
extern void enter_module(struct module_environment *, uintptr_t);
uint32_t supervisor_sp, supervisor_resume;
static volatile uint32_t active, result, ticks, last_fault;
/* Host policy stays in protected monitor RAM. Zero means no deadline. */
static uint32_t budget_ticks, event_announced, control_index, control_invocation, control_command;
static struct region_descriptor region;
static struct export_descriptor exported;
static struct loan_descriptor loan;
static uint32_t sequence;
static volatile uint32_t monitor_secret = 0xa5a55a5au;

static void barrier(void) { __asm__ volatile("dsb\n isb" ::: "memory"); }
static void uart_char(char c) {
    while (REG(0x40004004u) & 1u) {}
    REG(0x40004000u) = (uint32_t)c;
}
static void text(const char *s) { while (*s) uart_char(*s++); }
static void number(uint32_t n) {
    char b[11]; unsigned i=0;
    do { b[i++] = (char)('0' + n % 10); n /= 10; } while (n);
    while (i) uart_char(b[--i]);
}
static void zero(uintptr_t base, uint32_t length) {
    volatile unsigned char *p = (volatile unsigned char *)base;
    for (uint32_t i=0;i<length;i++) p[i]=0;
}
static USER unsigned log2_size(uint32_t n) {
    unsigned bit=5;
    while ((1u<<bit)<n) ++bit;
    return bit;
}
static void mpu_region(unsigned slot, uintptr_t base, unsigned size_bit, unsigned access, int execute) {
    REG(MPU_RNR)=slot; REG(MPU_RBAR)=(uint32_t)base;
    /* Normal SRAM/code, no executable data. AP=3 RW both, AP=6 RO both. */
    REG(MPU_RASR)=(execute?0u:1u<<28) | (access<<24) | (1u<<17) | ((size_bit-1u)<<1) | 1u;
}
static void configure(int grant) {
    REG(MPU_CTRL)=0; barrier();
    for (unsigned i=0;i<8;i++) { REG(MPU_RNR)=i; REG(MPU_RASR)=0; }
    mpu_region(0,MODULE_CODE_BASE,16,6,1);
    mpu_region(1,STACK_BASE,12,3,0);
    mpu_region(2,PRIVATE_BASE,12,3,0);
    if (grant) mpu_region(3,LOAN_BASE,log2_size(region.mapped_length),loan.rights==LOAN_READ_WRITE?3:6,0);
    /* PRIVDEFENA is for the privileged monitor only. Unprivileged misses fault. */
    REG(SHCSR)|=1u<<16;
    REG(MPU_CTRL)=5; barrier();
}
static void create_region(uint32_t length) {
    region=(struct region_descriptor){++sequence,1,length,1u<<log2_size(length)};
    zero(LOAN_BASE,region.mapped_length);
}
static void register_export(enum fixture f) {
    exported=(struct export_descriptor){++sequence,2,f};
}
static void close_domain(void) {
    active=0; REG(SYST_CSR)=0; REG(0xe000ed04u)=1u<<25;
    REG(MPU_RNR)=3; REG(MPU_RASR)=0; barrier();
}

/* An SVC frame is read only after checking the protected active invocation and
   the complete hardware frame lies in this domain's stack, with no arithmetic wrap. */
int handle_exception(uint32_t *frame, uint32_t exception_return, uint32_t kind) {
    if (!active) { text("FATAL unexpected exception\n"); for (;;) {} }
    if (kind==4) {
        if (ticks!=UINT32_MAX) ++ticks;
        /* Keep interrupts for supervision even when elapsed time has no limit. */
        if (!event_announced && ticks>=12 && (budget_ticks==0 || budget_ticks==10000) && (exported.entry==ARM_WAIT_EVENT ||
            exported.entry==F_LOOP || exported.entry==F_MASK_IRQ)) {
            event_announced=1;
            text("{\"event\":\"arm-await-input\",\"ticks\":");
            number(ticks); text(",\"invocation\":"); number(loan.invocation); text("}\n");
        }
        /* Bounded five-byte control frames: command plus invocation, little endian.
           UART belongs to the trusted fixture controller, never to module code. */
        for (unsigned n=0;n<5 && (REG(0x40004004u)&2u);n++) {
            uint32_t byte=REG(0x40004000u)&0xffu;
            if (!control_index) { control_command=byte; control_invocation=0; control_index=1; }
            else {
                control_invocation |= byte << ((control_index-1u)*8u);
                if (++control_index==5) {
                    control_index=0;
                    if (control_invocation!=loan.invocation) continue;
                    if (control_command=='C') { result=6; active=0; return 1; }
                    if (control_command=='E' && exported.entry==ARM_WAIT_EVENT)
                        *(volatile uint32_t *)EVENT_WORD=42;
                }
            }
        }
        if (!budget_ticks || ticks<budget_ticks) return 0;
        result=4; active=0; return 1;
    }
    last_fault=REG(CFSR);
    if (kind==2 || kind==3) {
        result=kind; REG(CFSR)=0xffffffffu; REG(HFSR)=0xffffffffu;
        REG(SHCSR) &= ~(7u<<13); REG(0xe000ed04u)=1u<<25;
        active=0; return 1;
    }
    uintptr_t address=(uintptr_t)frame;
    if (exception_return!=0xfffffffdu || address<STACK_BASE ||
        address>STACK_BASE+STACK_LENGTH-32 || (address&3u) ||
        frame[6]<MODULE_CODE_BASE+2 || frame[6]>=MODULE_CODE_END ||
        !(frame[7] & (1u<<24))) {
        result=5; active=0; return 1;
    }
    uint16_t instruction=*(const uint16_t *)(uintptr_t)(frame[6]-2);
    if (instruction!=0xdf00u || frame[1]!=loan.region || frame[2]!=loan.invocation ||
        frame[3]!=(uint32_t)loan.rights || frame[0]!=region.length) {
        result=5; active=0; return 1;
    }
    result=1; active=0; return 1;
}
static USER void complete(uint32_t length, uint32_t id, uint32_t invocation, uint32_t rights) {
    register uint32_t r0 __asm__("r0")=length;
    register uint32_t r1 __asm__("r1")=id;
    register uint32_t r2 __asm__("r2")=invocation;
    register uint32_t r3 __asm__("r3")=rights;
    __asm__ volatile("svc #0" : "+r"(r0) : "r"(r1),"r"(r2),"r"(r3) : "memory");
    for (;;) {}
}
USER void module_payload(struct module_environment *e) {
    volatile unsigned char *p=(volatile unsigned char *)e->buffer;
    volatile uint32_t *scratch=(volatile uint32_t *)(PRIVATE_BASE+128);
    *scratch=0;
    switch (e->fixture) {
    case F_COUNT:
        while (!*(volatile uint32_t *)EVENT_WORD) __asm__ volatile("nop");
        *scratch=*(volatile uint32_t *)EVENT_WORD; break;
    case F_READ: for (uint32_t i=0;i<e->length;i++) *scratch+=p[i]; break;
    case F_WRITE: case F_COPY: for (uint32_t i=0;i<e->length;i++) p[i]=0x5a; break;
    case F_READ_ONLY_WRITE: p[0]=0xff; break;
    case F_FOREIGN: *scratch=*(volatile unsigned char *)e->foreign; break;
    case F_MONITOR: *(volatile unsigned char *)e->monitor=0xff; break;
    case F_NEIGHBOR: p[1u<<log2_size(e->length)]=0xff; break;
    case F_STACK_OVERFLOW:
        __asm__ volatile("ldr r0, =0x2000f000\n mov sp, r0\n movs r1,#1\n str r1,[r0]" ::: "r0","r1","memory"); break;
    case F_PERMISSION: REG(MPU_CTRL)=0; break;
    case F_FORGED: complete(e->length,e->region+1,e->invocation+1,LOAN_READ_WRITE); break;
    case F_EXEC_DATA: ((void (*)(void))(e->buffer | 1u))(); break;
    case F_LOOP: for (;;) __asm__ volatile("nop"); break;
    case F_STALE: *scratch=*(volatile unsigned char *)LOAN_BASE; break;
    case F_BAD_FRAME:
        __asm__ volatile("ldr r0, =0x20000000\n mov sp,r0\n svc #0" ::: "r0","memory"); break;
    case F_SEMIHOST:
        __asm__ volatile("movs r0,#4\n ldr r1,=0x20020000\n bkpt #0xab" ::: "r0","r1","memory"); break;
    case F_PRIVILEGE:
        __asm__ volatile("movs r0,#0\n msr control,r0\n isb" ::: "r0","memory");
        *(volatile unsigned char *)e->monitor=0xff; break;
    case F_BITBAND: REG(0x22000000u)=1; break;
    case F_SERVICE_FRAME:
        __asm__ volatile("ldr r0, =0x20013000\n mov sp,r0\n svc #0" ::: "r0","memory"); break;
    case F_MASK_IRQ:
        __asm__ volatile("cpsid i" ::: "memory");
        for (;;) __asm__ volatile("nop");
    case F_DEVICE: REG(0x40004000u)=1; break;
    default: __asm__ volatile("udf #0");
    }
    complete(e->length,e->region,e->invocation,e->rights);
}
static uint32_t invoke_policy(enum fixture f, enum loan_rights rights, uint32_t limit) {
    if (f!=exported.entry || region.owner!=1 || exported.domain!=2 ||
        (rights!=LOAN_READ && rights!=LOAN_READ_WRITE) || limit>MAX_BUDGET_TICKS) return 7;
    budget_ticks=limit; event_announced=0; control_index=0;
    /* Commands queued for an ended invocation cannot affect a new one. */
    while (REG(0x40004004u)&2u) (void)REG(0x40004000u);
    loan=(struct loan_descriptor){region.id,exported.domain,++sequence,rights};
    zero(STACK_BASE,STACK_LENGTH); zero(PRIVATE_BASE,4096);
    struct module_environment *e=(struct module_environment *)PRIVATE_BASE;
    *e=(struct module_environment){LOAN_BASE,FOREIGN_BASE,(uintptr_t)&monitor_secret,
        region.length,region.id,loan.invocation,(uint32_t)f,(uint32_t)rights};
    configure(f!=F_STALE);
    result=0; last_fault=0; ticks=0; active=1;
    REG(0xe000ed04u)=1u<<25;
    REG(SYST_RVR)=100000u-1u; REG(SYST_CVR)=0; REG(SYST_CSR)=7;
    enter_module(e,STACK_BASE+STACK_LENGTH);
    close_domain();
    return result;
}
static uint32_t invoke(enum fixture f, enum loan_rights rights) {
    return invoke_policy(f,rights,10);
}
static void report(enum fixture f,int pass,uint32_t outcome) {
    text("{\"target\":\"arm-mpu\",\"case\":\""); text(fixture_names[f]);
    text("\",\"pass\":"); text(pass?"true":"false");
    text(",\"outcome\":"); number(outcome);
    text(",\"cfsr\":"); number(last_fault);
    text("}\n");
}
static int execution_report(const char *name, int pass, uint32_t outcome) {
    REG(MPU_RNR)=3;
    int revoked=!(REG(MPU_RASR)&1u) && !(REG(SYST_CSR)&1u) && !active;
    pass &= revoked;
    text("{\"target\":\"arm-mpu\",\"case\":\""); text(name);
    text("\",\"pass\":"); text(pass?"true":"false");
    text(",\"outcome\":"); number(outcome);
    text(",\"ticks\":"); number(ticks);
    text(",\"loan_revoked\":"); text(revoked?"true":"false"); text("}\n");
    return !pass;
}
static unsigned execution_tests(void) {
    const enum fixture fixtures[]={ARM_WAIT_EVENT,F_LOOP,F_LOOP,F_READ_ONLY_WRITE,F_MASK_IRQ,F_LOOP};
    const char *names[]={"ordinary_event_after_default","cancel_no_deadline","finite_custom_budget",
                        "unbounded_still_protected","cancel_masked_interrupt_attempt","cancel_finite_call"};
    unsigned failures=0;
    for (unsigned i=0;i<6;i++) {
        enum fixture f=fixtures[i]; create_region(256); register_export(f);
        uint32_t out=invoke_policy(f,LOAN_READ,i==2?3:(i==5?10000:0));
        int pass=monitor_secret==0xa5a55a5au;
        if (!i) pass &= out==1 && ticks>=12 && *(volatile uint32_t *)(PRIVATE_BASE+128)==42;
        else if (i==1 || i==4 || i==5) pass &= out==6 && ticks>=12;
        else if (i==2) pass &= out==4 && ticks==3;
        else pass &= out==2 || out==3;
        failures+=execution_report(names[i],pass,out);
        /* Enter with the previous address but no grant, then start a fresh loan. */
        register_export(F_STALE); out=invoke(F_STALE,LOAN_READ);
        char name[64]; unsigned n=0;
        const char *prefix="stale_after_";
        while (*prefix) name[n++]=*prefix++;
        const char *suffix=names[i]; while (*suffix) name[n++]=*suffix++;
        name[n]=0;
        failures+=execution_report(name,out==2 || out==3,out);
        create_region(256); register_export(F_READ);
        for (unsigned k=0;k<256;k++) ((volatile unsigned char *)LOAN_BASE)[k]=1;
        out=invoke(F_READ,LOAN_READ); n=0; prefix="recovery_after_";
        while (*prefix) name[n++]=*prefix++;
        suffix=names[i]; while (*suffix) name[n++]=*suffix++;
        name[n]=0;
        failures+=execution_report(name,out==1 && *(volatile uint32_t *)(PRIVATE_BASE+128)==256,out);
    }
    register_export(F_LOOP);
    uint32_t out=invoke_policy(F_LOOP,LOAN_READ,MAX_BUDGET_TICKS+1u);
    failures+=execution_report("invalid_execution_budget",out==7,out);
    out=invoke_policy(F_LOOP,(enum loan_rights)7,0);
    failures+=execution_report("invalid_execution_rights",out==7,out);
    out=invoke_policy(F_READ,LOAN_READ,0);
    failures+=execution_report("invalid_execution_export",out==7,out);
    return failures;
}
void monitor_main(void) {
    REG(0x40004008u)=3; /* UART TX/RX controlled by monitor; semihosting is disabled. */
    unsigned regions=(REG(MPU_TYPE)>>8)&0xff;
    if (regions<4) { text("FAIL MPU unavailable\n"); return; }
    text("{\"target\":\"arm-mpu\",\"mpu_regions\":"); number(regions); text("}\n");
    const enum fixture cases[] = { F_READ,F_WRITE,F_READ_ONLY_WRITE,F_FOREIGN,F_MONITOR,
        F_NEIGHBOR,F_STACK_OVERFLOW,F_PERMISSION,F_FORGED,F_EXEC_DATA,F_LOOP,F_STALE,
        F_COPY,F_BAD_FRAME,F_SEMIHOST,F_PRIVILEGE,F_BITBAND,F_SERVICE_FRAME,F_MASK_IRQ,F_DEVICE };
    unsigned failures=0;
    for (unsigned i=0;i<sizeof cases/sizeof cases[0];i++) {
        enum fixture f=cases[i]; create_region(256); register_export(f);
        for (unsigned k=0;k<region.length;k++) ((volatile unsigned char *)LOAN_BASE)[k]=1;
        *(volatile uint32_t *)FOREIGN_BASE=0xa5a55a5au;
        uint32_t out=invoke(f,f==F_READ || f==F_READ_ONLY_WRITE || f==F_EXEC_DATA?LOAN_READ:LOAN_READ_WRITE);
        int pass=monitor_secret==0xa5a55a5au && *(volatile uint32_t *)FOREIGN_BASE==0xa5a55a5au;
        if (f==F_READ || f==F_WRITE || f==F_COPY) pass &= out==1;
        else if (f==F_FORGED || f==F_SERVICE_FRAME) pass &= out==5;
        else if (f==F_LOOP || f==F_MASK_IRQ) pass &= out==4;
        else pass &= out==2 || out==3;
        if (f==F_READ) pass &= *(volatile uint32_t *)(PRIVATE_BASE+128)==256;
        if (f==F_WRITE || f==F_COPY) {
            /* Copy out only on validated completion; canaries represent adjacent source bytes. */
            volatile unsigned char *destination=(volatile unsigned char *)(FOREIGN_BASE+16);
            for (unsigned k=0;k<272;k++) destination[k]=0xa5;
            if (out==1) for (unsigned k=0;k<256;k++) destination[k+8]=((volatile unsigned char *)LOAN_BASE)[k];
            for (unsigned k=0;k<272;k++) pass &= destination[k]==(k>=8 && k<264?0x5a:0xa5);
        }
        report(f,pass,out); failures+=!pass;
    }
    const uint32_t sizes[]={256,4096,65536};
    for (unsigned i=0;i<3;i++) {
        create_region(sizes[i]); register_export(F_WRITE);
        uint32_t out=invoke(F_WRITE,LOAN_READ_WRITE);
        int pass=out==1;
        for (unsigned k=0;k<region.length;k++) pass &= ((volatile unsigned char *)LOAN_BASE)[k]==0x5a;
        text("{\"target\":\"arm-mpu\",\"resource_bytes\":"); number(sizes[i]);
        text(",\"mapped_bytes\":"); number(region.mapped_length);
        text(",\"stack_bytes\":4096,\"private_bytes\":4096,\"pass\":"); text(pass?"true":"false"); text("}\n");
        failures+=!pass;
    }
    failures+=execution_tests();
    text("DONE failures="); number(failures); text("\n");
}
