#define _GNU_SOURCE
/* Independent sequence model. Callbacks themselves are compiled Ubytec functions. */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <sys/wait.h>
#include <unistd.h>
#define DECL(n,...) extern uint64_t ubytec_host_##n(__VA_ARGS__)
DECL(ArenaInit,uint64_t,uint64_t); DECL(ArenaAlloc,uint64_t,uint64_t);
DECL(ArenaFree,uint64_t,uint64_t); DECL(ArenaFind,uint64_t,uint64_t);
DECL(ArenaPin,uint64_t,uint64_t); DECL(ArenaUnpin,uint64_t,uint64_t);
DECL(ft_lstnew_arena,uint64_t,uint64_t); DECL(ft_lstsize,uint64_t);
DECL(ft_lstlast,uint64_t); DECL(ft_lstadd_front_arena,uint64_t,uint64_t,uint64_t);
DECL(ft_lstadd_back_arena,uint64_t,uint64_t,uint64_t);
DECL(ListMap,uint64_t,uint64_t); DECL(ListClear,uint64_t,uint64_t);
DECL(ListDelete,uint64_t,uint64_t); DECL(ListIter,uint64_t);
DECL(ListCheck,uint64_t,uint64_t,uint64_t);
DECL(ListCallRaw,uint64_t,uint64_t);
#define U(n) ubytec_host_##n
static uint64_t checks,steps,maps,failures,pin_rejections;
static void check(int ok,const char *why){checks++;if(!ok){fprintf(stderr,"check %" PRIu64 ": %s\n",checks,why);exit(1);}}
static uint64_t addr(const void *p){return (uint64_t)(uintptr_t)p;}
static uint64_t get(uint64_t p,size_t offset){uint64_t x;memcpy(&x,(void *)(uintptr_t)(p+offset),8);return x;}
static void put(uint64_t p,size_t offset,uint64_t x){memcpy((void *)(uintptr_t)(p+offset),&x,8);}
static uint64_t rng=UINT64_C(0x42c011bac);
static uint64_t random64(void){rng^=rng<<13;rng^=rng>>7;rng^=rng<<17;return rng;}
struct item {uint64_t node,content,value;};
struct fixture {
    unsigned char *storage,*arena;
    size_t capacity;
    uint64_t head,stats[6],expected[6];
    struct item model[16];size_t count;
};
static void initialize(struct fixture *f,size_t cap){memset(f,0,sizeof(*f));f->capacity=cap;f->storage=malloc(cap+48);check(f->storage!=NULL,"allocate fixture");memset(f->storage,0xa5,cap+48);f->arena=f->storage+16;check(U(ArenaInit)(addr(f->arena),cap)==1,"init arena");}
static void release(struct fixture *f){free(f->storage);}
static void expect_destroy(struct fixture *f,uint64_t value){f->expected[1]++;f->expected[5]=f->expected[5]*131+value;}
static void verify(struct fixture *f){
    uint64_t p=f->head,last=0;size_t i;
    check(U(ft_lstsize)(p)==f->count,"sequence length");
    for(i=0;i<f->count;i++){
        check(p==f->model[i].node,"node order");check(get(p,0)==f->model[i].content,"content identity");
        check(get(f->model[i].content,0)==addr(f->arena),"content owner");
        check(get(f->model[i].content,8)==f->model[i].value,"content bytes vs C model");
        check(get(f->model[i].content,16)==addr(f->stats),"callback context");
        uint64_t n=U(ArenaFind)(addr(f->arena),p),c=U(ArenaFind)(addr(f->arena),f->model[i].content);
        check(n!=0&&c!=0,"exact live allocations");check(get(n,8)==16&&get(c,8)==24,"logical allocation lengths");
        check(get(n,24)==0&&get(c,24)==0,"no leaked pins");last=p;p=get(p,8);
    }
    check(p==0,"terminated sequence");check(U(ft_lstlast)(f->head)==last,"last node");
    check(U(ListCheck)(addr(f->arena),f->head,1)==1,"list structurally valid");
    check(memcmp(f->stats,f->expected,sizeof(f->stats))==0,"callback counts and order hashes");
    for(i=0;i<16;i++){check(f->storage[i]==0xa5,"left arena guard");check(f->arena[f->capacity+16+i]==0xa5,"right arena guard");}
    uint64_t used=get(addr(f->arena),8),cursor=0,live=0;
    check(used<=f->capacity,"bounded arena");
    while(cursor<used){uint64_t header=addr(f->arena)+16+cursor,cap=get(header,0);check(cap%8==0&&cap<=used-cursor-32,"block extent");if(get(header,16))live++;cursor+=32+cap;}
    check(cursor==used&&live==f->count*2,"no leaked allocations");
}
static void add(struct fixture *f,uint64_t value,int front){
    uint64_t content=U(ArenaAlloc)(addr(f->arena),24);check(content!=0,"content allocation within bounded workload");
    put(content,0,addr(f->arena));put(content,8,value);put(content,16,addr(f->stats));
    uint64_t node=U(ft_lstnew_arena)(addr(f->arena),content);check(node!=0,"new node");
    uint64_t ok=front?U(ft_lstadd_front_arena)(addr(f->arena),addr(&f->head),node):U(ft_lstadd_back_arena)(addr(f->arena),addr(&f->head),node);
    check(ok==1,"attach detached node");if(front)memmove(f->model+1,f->model,f->count*sizeof(*f->model));
    f->model[front?0:f->count]=(struct item){node,content,value};f->count++;
}
static void clear(struct fixture *f){size_t i;for(i=0;i<f->count;i++)expect_destroy(f,f->model[i].value);check(U(ListClear)(addr(f->arena),addr(&f->head))==1,"clear list");f->count=0;check(f->head==0&&get(addr(f->arena),8)==0,"complete arena recovery");}
static void map(struct fixture *f,size_t fail_at){
    unsigned char originals[16][32];size_t i;
    for(i=0;i<f->count;i++){memcpy(originals[i],(void *)(uintptr_t)f->model[i].node,16);memcpy(originals[i]+16,(void *)(uintptr_t)(f->model[i].content+8),16);}
    uint64_t head=f->head;
    f->stats[3]=f->expected[3]=fail_at?f->expected[0]+fail_at:0;
    uint64_t result=U(ListMap)(addr(f->arena),f->head);maps++;
    f->expected[0]+=fail_at?fail_at:f->count;
    if(fail_at){check(result==0,"failed transform returns no partial list");failures++;for(i=0;i<fail_at-1;i++)expect_destroy(f,f->model[i].value*2+7);}
    else {
        uint64_t p=result;
        check((f->count==0)==(result==0),"nonempty map must succeed with ample memory");
        for(i=0;i<f->count;i++){
            check(p!=0&&p!=f->model[i].node,"independent result node");uint64_t content=get(p,0);
            check(content!=f->model[i].content,"independently owned result content");check(get(content,8)==f->model[i].value*2+7,"map vs C transformation");
            check(get(content,0)==addr(f->arena)&&get(content,16)==addr(f->stats),"mapped context");expect_destroy(f,f->model[i].value*2+7);p=get(p,8);
        }
        check(p==0,"exact mapped length");check(U(ListClear)(addr(f->arena),addr(&result))==1&&result==0,"release mapped ownership");
    }
    check(f->head==head,"map preserves source head");
    for(i=0;i<f->count;i++){check(memcmp(originals[i],(void *)(uintptr_t)f->model[i].node,16)==0,"map preserves source links/content pointer");check(memcmp(originals[i]+16,(void *)(uintptr_t)(f->model[i].content+8),16)==0,"map preserves source content");}
    f->stats[3]=f->expected[3]=0;
}
static void history(size_t cap){struct fixture f;initialize(&f,cap);size_t k,i;
    for(k=0;k<5000;k++){
        unsigned operation=(unsigned)(random64()%8);
        if(operation<2&&f.count<16)add(&f,random64(),operation==0);
        else if(operation==2){
            for(i=0;i<f.count;i++){f.model[i].value+=3;f.expected[2]++;f.expected[4]=f.expected[4]*131+f.model[i].value;}
            check(U(ListIter)(f.head)==1,"iterate callback");
        } else if(operation==3)map(&f,0);
        else if(operation==4&&f.count)map(&f,1+random64()%f.count);
        else if(operation==5)clear(&f);
        else if(operation==6&&f.count){
            struct item first=f.model[0];f.head=get(first.node,8);expect_destroy(&f,first.value);
            check(U(ListDelete)(addr(f.arena),first.node)==1,"delete detached first node");memmove(f.model,f.model+1,--f.count*sizeof(*f.model));
        } else if(operation==7&&f.count){
            uint64_t node=f.model[random64()%f.count].node;check(U(ArenaPin)(addr(f.arena),node)==1,"pin node");
            unsigned char *snapshot=malloc(cap+16);check(snapshot!=NULL,"snapshot");memcpy(snapshot,f.arena,cap+16);uint64_t head=f.head;
            check(U(ListClear)(addr(f.arena),addr(&f.head))==0,"clear pinned list rejected");check(U(ListDelete)(addr(f.arena),node)==0,"delete pinned node rejected");
            check(head==f.head&&memcmp(snapshot,f.arena,cap+16)==0,"rejected cleanup preserves all bytes");free(snapshot);
            check(U(ArenaUnpin)(addr(f.arena),node)==1,"unpin node");pin_rejections+=2;
        }
        verify(&f);steps++;
    }
    clear(&f);verify(&f);release(&f);
}
static void directed_oom(size_t cap,size_t transformed,size_t destroyed){struct fixture f;initialize(&f,cap);add(&f,10,0);add(&f,20,0);uint64_t head=f.head;check(get(addr(f.arena),8)==208,"known OOM layout");
    check(U(ListMap)(addr(f.arena),f.head)==0,"bounded map OOM");f.expected[0]=transformed;
    /* A newly produced content is destroyed before the earlier mapped prefix. */
    if(destroyed==2){expect_destroy(&f,47);expect_destroy(&f,27);}else if(destroyed==1)expect_destroy(&f,27);
    check(f.head==head&&get(addr(f.arena),8)==208,"OOM releases all temporary allocations");verify(&f);clear(&f);verify(&f);release(&f);failures++;
}
static void directed_guards(void){struct fixture f;initialize(&f,4096);add(&f,1,0);add(&f,2,0);
    uint64_t first=f.model[0].node,last=f.model[1].node;unsigned char snapshot[4112];memcpy(snapshot,f.arena,sizeof(snapshot));
    check(U(ft_lstadd_back_arena)(addr(f.arena),addr(&f.head),last)==0,"duplicate last node rejected");check(U(ft_lstadd_front_arena)(addr(f.arena),addr(&f.head),first)==0,"linked first node rejected");
    check(memcmp(snapshot,f.arena,sizeof(snapshot))==0,"rejected attach atomic");
    put(last,8,first);check(U(ListCheck)(addr(f.arena),f.head,0)==0,"cycle detected");check(U(ListClear)(addr(f.arena),addr(&f.head))==0,"cycle cleanup rejected before callbacks");put(last,8,0);verify(&f);
    check(U(ArenaPin)(addr(f.arena),last)==1,"pin read-only source");
    uint64_t result=U(ListMap)(addr(f.arena),f.head);check(result!=0,"map may read pinned nodes");f.expected[0]+=2;expect_destroy(&f,9);expect_destroy(&f,11);check(U(ListClear)(addr(f.arena),addr(&result))==1,"clear mapped result");check(U(ArenaUnpin)(addr(f.arena),last)==1,"unpin read source");verify(&f);clear(&f);verify(&f);release(&f);
}
static void invalid_targets(void){
    void *data=mmap(NULL,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
    check(data!=MAP_FAILED,"allocate NX callback target");((unsigned char *)data)[0]=0xc3;
    uint64_t targets[2]={0,addr(data)};
    for(size_t i=0;i<2;i++){
        pid_t pid=fork();check(pid>=0,"fork invalid callback child");
        if(pid==0){struct rlimit limit={0,0};setrlimit(RLIMIT_CORE,&limit);signal(SIGSEGV,SIG_DFL);signal(SIGBUS,SIG_DFL);U(ListCallRaw)(targets[i],123);_exit(0);}
        int status;check(waitpid(pid,&status,0)==pid,"wait callback child");
        check(WIFSIGNALED(status)&&WTERMSIG(status)==SIGSEGV,"invalid/null/NX callback faults in child");
    }
    check(munmap(data,4096)==0,"release NX page");
}
int main(void){history(8192);history(16384);directed_oom(208,1,0);directed_oom(288,1,1);directed_oom(368,2,2);directed_guards();invalid_targets();
    printf("{\"accepted\":true,\"random_steps\":%" PRIu64 ",\"checks\":%" PRIu64 ",\"maps\":%" PRIu64 ",\"failed_maps\":%" PRIu64 ",\"invalid_target_faults\":2,\"pin_rejections\":%" PRIu64 "}\n",steps,checks,maps,failures,pin_rejections);return 0;}
