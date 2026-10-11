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
extern uint64_t ubytec_host_reference_DiagRecords(uint64_t,uint64_t);
extern uint64_t ubytec_host_reduction_DiagRecords(uint64_t,uint64_t);
struct observation { uint64_t signal,code,address,index,sum,live_sum,pending_address,offset,stride,rsp_offset; };
static int result_fd;
static void check(int ok){if(!ok){fputs("record reduction fault contract failed\n",stderr);exit(2);}}
static void fault(int signal,siginfo_t *info,void *context){
 ucontext_t *c=context;uintptr_t rbp=c->uc_mcontext.gregs[REG_RBP],rsp=c->uc_mcontext.gregs[REG_RSP];
 struct observation o={(uint64_t)signal,(uint64_t)info->si_code,(uint64_t)(uintptr_t)info->si_addr,
  *(volatile uint64_t *)(rbp-8),*(volatile uint64_t *)(rbp-16),*(volatile uint64_t *)rsp,
  *(volatile uint64_t *)(rsp-8),*(volatile uint64_t *)(rsp-16),*(volatile uint64_t *)(rsp-24),rbp-rsp};
 if(write(result_fd,&o,sizeof o)!=(ssize_t)sizeof o)_exit(3);
 _exit(0);
}
static struct observation observe(reduce fn,uint64_t p,size_t n){
 int fds[2];check(!pipe(fds));pid_t child=fork();check(child>=0);
 if(!child){
  close(fds[0]);result_fd=fds[1];stack_t stack={0};stack.ss_size=65536;
  stack.ss_sp=mmap(NULL,stack.ss_size,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
  if(stack.ss_sp==MAP_FAILED||sigaltstack(&stack,NULL))_exit(4);
  struct sigaction a;memset(&a,0,sizeof a);a.sa_sigaction=fault;a.sa_flags=SA_SIGINFO|SA_ONSTACK;sigemptyset(&a.sa_mask);
  if(sigaction(SIGSEGV,&a,NULL)||sigaction(SIGBUS,&a,NULL))_exit(5);
  (void)fn(p,n);_exit(6);
 }
 close(fds[1]);struct observation o={0};size_t bytes=0;
 while(bytes<sizeof o){ssize_t got=read(fds[0],(char *)&o+bytes,sizeof o-bytes);check(got>0);bytes+=(size_t)got;}
 close(fds[0]);int status=0;check(waitpid(child,&status,0)==child&&WIFEXITED(status)&&WEXITSTATUS(status)==0);return o;
}
static void compare(uint64_t base,size_t completed,int signal,uintptr_t fault_address){
 uint64_t sum=0;
 for(size_t i=0;i<completed;i++){uint64_t v;memcpy(&v,(void *)(uintptr_t)(base+i*24+16),8);sum+=v;}
 struct observation a=observe(ubytec_host_reference_DiagRecords,base,completed+1);
 struct observation b=observe(ubytec_host_reduction_DiagRecords,base,completed+1);
 check(!memcmp(&a,&b,sizeof a));check(a.signal==(uint64_t)signal&&a.address==fault_address);
 check(a.index==completed&&a.sum==sum&&a.live_sum==sum&&a.pending_address==base+completed*24+16);
 check(a.offset==16&&a.stride==24&&a.rsp_offset==24);
}
int main(void){
 size_t page=sysconf(_SC_PAGESIZE);check(page>=4096);
 unsigned char *m=mmap(NULL,page*5,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);check(m!=MAP_FAILED);
 check(!mprotect(m+page,page*3,PROT_READ|PROT_WRITE));
 for(size_t i=0;i<page*3;i++)m[page+i]=(unsigned char)(i*17+3);
 const size_t counts[]={0,1,2,7,16,127,256,511};unsigned segv=0,bus=0;
 for(unsigned s=0;s<sizeof counts/sizeof *counts;s++)for(unsigned skew=0;skew<8;skew++){
  size_t n=counts[s];compare((uintptr_t)(m+page*4-skew-n*24-16),n,SIGSEGV,(uintptr_t)(m+page*4));segv++;
 }
 compare(0,0,SIGSEGV,16);segv++;compare(UINT64_MAX-14,0,SIGSEGV,1);segv++;
 check(!munmap(m,page*5));
 char name[]="/tmp/ubytec-record-bus-XXXXXX";int fd=mkstemp(name);check(fd>=0);check(!unlink(name));check(!ftruncate(fd,(off_t)page));
 unsigned char *file=mmap(NULL,page*3,PROT_READ,MAP_SHARED,fd,0);check(file!=MAP_FAILED);check(!close(fd));
 const size_t bus_counts[]={0,1,7,16,127};
 for(unsigned s=0;s<sizeof bus_counts/sizeof *bus_counts;s++)for(unsigned skew=0;skew<8;skew++){
  size_t n=bus_counts[s];compare((uintptr_t)(file+page-skew-n*24-16),n,SIGBUS,(uintptr_t)(file+page));bus++;
 }
 check(!munmap(file,page*3));
 printf("{\"accepted\":true,\"segv_cases\":%u,\"bus_cases\":%u,\"variants\":2,\"cross_page_skews\":8,\"observations\":\"signal, code, address, frame, four evaluation cells and RSP\"}\n",segv,bus);return 0;
}
