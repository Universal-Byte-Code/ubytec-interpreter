#define _GNU_SOURCE
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <ucontext.h>
typedef uint64_t (*lookup)(uint64_t,uint64_t,uint64_t,uint64_t);
extern uint64_t ubytec_host_plain_EffectFault(uint64_t,uint64_t,uint64_t,uint64_t);
extern uint64_t ubytec_host_register_EffectFault(uint64_t,uint64_t,uint64_t,uint64_t);
struct record {uint64_t name,length,count;};
struct observation {uint64_t signal,code,address,index,inner,entry,name,cells[3],rsp_offset;};
static int result_fd;
static void check(int ok){if(!ok){fputs("effect fault contract failed\n",stderr);exit(2);}}
static void fault(int signal,siginfo_t *info,void *context){
 ucontext_t *c=context;uintptr_t bp=c->uc_mcontext.gregs[REG_RBP],sp=c->uc_mcontext.gregs[REG_RSP];
 struct observation o={(uint64_t)signal,(uint64_t)info->si_code,(uintptr_t)info->si_addr,
  *(volatile uint64_t *)(bp-8),*(volatile uint64_t *)(bp-16),*(volatile uint64_t *)(bp-24),*(volatile uint64_t *)(bp-32),
  {*(volatile uint64_t *)(bp-40),*(volatile uint64_t *)(bp-48),*(volatile uint64_t *)(bp-56)},bp-sp};
 if(write(result_fd,&o,sizeof o)!=(ssize_t)sizeof o)_exit(3);
 _exit(0);
}
static struct observation observe(lookup fn,uint64_t records,uint64_t count,uint64_t key,uint64_t length){
 int fds[2];check(!pipe(fds));pid_t child=fork();check(child>=0);
 if(!child){
  close(fds[0]);result_fd=fds[1];stack_t stack={0};stack.ss_size=65536;
  stack.ss_sp=mmap(NULL,stack.ss_size,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
  if(stack.ss_sp==MAP_FAILED||sigaltstack(&stack,NULL))_exit(4);
  struct sigaction a;memset(&a,0,sizeof a);a.sa_sigaction=fault;a.sa_flags=SA_SIGINFO|SA_ONSTACK;sigemptyset(&a.sa_mask);
  if(sigaction(SIGSEGV,&a,NULL)||sigaction(SIGBUS,&a,NULL))_exit(5);
  (void)fn(records,count,key,length);_exit(6);
 }
 close(fds[1]);struct observation o={0};size_t bytes=0;
 while(bytes<sizeof o){ssize_t got=read(fds[0],(char *)&o+bytes,sizeof o-bytes);check(got>0);bytes+=(size_t)got;}
 close(fds[0]);int status=0;check(waitpid(child,&status,0)==child&&WIFEXITED(status)&&WEXITSTATUS(status)==0);return o;
}
static void compare(uint64_t records,uint64_t count,uint64_t key,uint64_t length,
 int signal,uintptr_t address,uint64_t i,uint64_t j,uint64_t entry,uint64_t name,
 uint64_t c0,uint64_t c1,uint64_t c2,uint64_t sp){
 struct observation a=observe(ubytec_host_plain_EffectFault,records,count,key,length);
 struct observation b=observe(ubytec_host_register_EffectFault,records,count,key,length);
 check(!memcmp(&a,&b,sizeof a));check(a.signal==(uint64_t)signal&&a.address==address);
 check(a.index==i&&a.inner==j&&a.entry==entry&&a.name==name);
 check(a.cells[0]==c0&&a.cells[1]==c1&&a.cells[2]==c2&&a.rsp_offset==sp);
}
static void one(uintptr_t base,uint64_t n,unsigned mode,int signal,uintptr_t fault_address,uintptr_t effective){
 if(mode==0)compare(base,n+1,mode,0,signal,fault_address,n,7,0,effective,effective,7,26,32);
 else compare(base,n+1,mode,0,signal,fault_address,0,7,9,11,effective,mode==1?25:7,26,32);
}
static unsigned exercise(unsigned char *boundary,int signal){
 const size_t completed[]={0,1,2,7,16,127};unsigned tests=0;
 for(unsigned mode=0;mode<3;mode++)for(unsigned c=0;c<sizeof completed/sizeof *completed;c++)for(unsigned skew=0;skew<8;skew++){
  uint64_t n=completed[c];uintptr_t effective=(uintptr_t)(boundary-skew);
  one(effective-n*8,n,mode,signal,(uintptr_t)boundary,effective);tests++;
 }
 return tests;
}
int main(void){
 size_t page=sysconf(_SC_PAGESIZE);check(page>=4096);
 unsigned char *m=mmap(NULL,page*3,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);check(m!=MAP_FAILED);
 check(!mprotect(m+page,page,PROT_READ|PROT_WRITE));memset(m+page,0,page);
 unsigned segv=exercise(m+page*2,SIGSEGV);
 check(!mprotect(m+page,page,PROT_READ));
 one((uintptr_t)(m+page),0,0,SIGSEGV,(uintptr_t)(m+page),(uintptr_t)(m+page));segv++;
 one((uintptr_t)(m+page),0,2,SIGSEGV,(uintptr_t)(m+page),(uintptr_t)(m+page));segv++;
 check(!munmap(m,page*3));
 char path[]="/tmp/ubytec-effect-bus-XXXXXX";int fd=mkstemp(path);check(fd>=0);check(!unlink(path));check(!ftruncate(fd,page));
 unsigned char *file=mmap(NULL,page*2,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0);check(file!=MAP_FAILED);check(!close(fd));
 unsigned bus=exercise(file+page,SIGBUS);check(!munmap(file,page*2));
 printf("{\"accepted\":true,\"segv_cases\":%u,\"bus_cases\":%u,\"variants\":2,\"stages\":3,\"observations\":\"signal, code, address, four current locals, three residual cells and RSP\"}\n",segv,bus);return 0;
}
