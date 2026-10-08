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

typedef uint64_t (*reduce)(uint64_t,uint64_t);
extern uint64_t ubytec_host_register_DiagBytes(uint64_t,uint64_t);
extern uint64_t ubytec_host_loop_DiagBytes(uint64_t,uint64_t);
struct observation {uint64_t signal, address, index, sum, live_sum, pending_address, previous_index, rsp_offset;};
static int result_fd;
static void check(int ok){if(!ok){fputs("loop reduction fault contract failed\n",stderr);exit(2);}}
static void fault(int signal,siginfo_t *info,void *context){
 ucontext_t *c=context;
 uintptr_t rbp=(uintptr_t)c->uc_mcontext.gregs[REG_RBP],rsp=(uintptr_t)c->uc_mcontext.gregs[REG_RSP];
 struct observation o={(uint64_t)signal,(uint64_t)(uintptr_t)info->si_addr,
  *(volatile uint64_t *)(rbp-8),*(volatile uint64_t *)(rbp-16),
  *(volatile uint64_t *)rsp,*(volatile uint64_t *)(rsp-8),*(volatile uint64_t *)(rsp-16),rbp-rsp};
 /* An alternate signal stack avoids overwriting the interrupted evaluation cells. */
 if(write(result_fd,&o,sizeof o)!=(ssize_t)sizeof o)_exit(3);
 _exit(0);
}
static struct observation observe(reduce fn,unsigned char *p,size_t n){
 int descriptors[2];check(!pipe(descriptors));
 pid_t child=fork();check(child>=0);
 if(!child){
  close(descriptors[0]);result_fd=descriptors[1];
  stack_t stack={0};stack.ss_size=65536;
  stack.ss_sp=mmap(NULL,stack.ss_size,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
  if(stack.ss_sp==MAP_FAILED||sigaltstack(&stack,NULL))_exit(4);
  struct sigaction action;memset(&action,0,sizeof action);action.sa_sigaction=fault;action.sa_flags=SA_SIGINFO|SA_ONSTACK;
  sigemptyset(&action.sa_mask);
  if(sigaction(SIGSEGV,&action,NULL)||sigaction(SIGBUS,&action,NULL))_exit(5);
  (void)fn((uint64_t)(uintptr_t)p,n);_exit(6);
 }
 close(descriptors[1]);struct observation o={0};size_t bytes=0;
 while(bytes<sizeof o){ssize_t count=read(descriptors[0],(char *)&o+bytes,sizeof o-bytes);check(count>0);bytes+=(size_t)count;}
 close(descriptors[0]);int status=0;check(waitpid(child,&status,0)==child&&WIFEXITED(status)&&WEXITSTATUS(status)==0);
 return o;
}
int main(void){
 size_t page=(size_t)sysconf(_SC_PAGESIZE);check(page>=4096);
 unsigned char *memory=mmap(NULL,page*3,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);check(memory!=MAP_FAILED);
 check(!mprotect(memory+page,page,PROT_READ|PROT_WRITE));
 for(size_t i=0;i<page;i++)memory[page+i]=(unsigned char)(i*17+3);
 const size_t lengths[]={0,1,2,31,256,4095};unsigned checks=0;
 for(unsigned test=0;test<sizeof lengths/sizeof *lengths;test++){
  size_t n=lengths[test];unsigned char *p=memory+page*2-n;uint64_t sum=0;
  for(size_t i=0;i<n;i++)sum+=p[i];
  struct observation reference=observe(ubytec_host_register_DiagBytes,p,n+1);
  struct observation optimized=observe(ubytec_host_loop_DiagBytes,p,n+1);
  check(!memcmp(&reference,&optimized,sizeof reference));
  check(reference.signal==SIGSEGV&&reference.address==(uint64_t)(uintptr_t)(memory+page*2));
  check(reference.index==n&&reference.sum==sum&&reference.live_sum==sum);
  check(reference.pending_address==reference.address&&reference.previous_index==n&&reference.rsp_offset==24);
  checks++;
 }
 check(!munmap(memory,page*3));
 printf("{\"accepted\":true,\"fault_cases\":%u,\"variants\":2,\"observations\":\"signal, address, frame, evaluation bytes and RSP\"}\n",checks);
 return 0;
}
