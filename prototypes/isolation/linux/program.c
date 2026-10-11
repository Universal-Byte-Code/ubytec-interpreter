/* Experimental one-hop Ubytec module-call supervisor. Never executes module code. */
#define MODULE_LOADER_EMBEDDED 1
#include "modules.c"
#undef main
#ifdef PROGRAM_LOADER_EMBEDDED
#define main program_cli_main
#endif
static struct registry program_registry;
struct program_grant { uint32_t handle, rights, maximum, budget; unsigned function; int unlimited, enabled, typed; unsigned count,loans,kinds[6]; uint32_t loan_rights[2],loan_max[2]; };
static struct program_grant grants[16];
static unsigned grant_count;
static const char *program_input_path, *program_output_path;
static uint32_t program_ceiling, program_maximum, program_budget;
#include "contracts.h"
#include <sys/uio.h>
static unsigned serviced_calls, callee_launches;
static long callee_peak_rss_kib;
static uint64_t request_receive_ns,loan_setup_ns,reply_send_ns,receiver_ticks;
static struct module_timing receiver_timing;
static int program_unlimited;
static int ipc_exact(int fd, void *buffer, size_t length, int writing) {
    unsigned char *p=buffer;
    while (length) {
        if (execution_cancel || execution_stop) return 0;
        ssize_t n=writing ? send(fd,p,length,MSG_NOSIGNAL|MSG_DONTWAIT) : recv(fd,p,length,MSG_DONTWAIT);
        if (n>0) { p+=n; length-=(size_t)n; continue; }
        if (!n) return 0;
        if (errno!=EAGAIN && errno!=EWOULDBLOCK && errno!=EINTR) return 0;
        struct pollfd wait={fd,writing?POLLOUT:POLLIN,0};
#ifdef UBYTEC_BRIDGE_REFERENCE
        poll(&wait,1,10);
#else
        if(wait_broker_events(&wait,1,-1)<0 && errno!=EINTR) return 0;
#endif
    }
    return 1;
}
#ifndef UBYTEC_BRIDGE_REFERENCE
static int ipc_send_parts(int fd,struct iovec *parts,unsigned count) {
    unsigned current=0;
    while(current<count) {
        if(execution_cancel || execution_stop) return 0;
        while(current<count && !parts[current].iov_len) ++current;
        if(current==count) break;
        struct msghdr message={.msg_iov=parts+current,.msg_iovlen=count-current};
        ssize_t n=sendmsg(fd,&message,MSG_NOSIGNAL|MSG_DONTWAIT);
        if(n<0) {
            if(errno!=EAGAIN && errno!=EWOULDBLOCK && errno!=EINTR) return 0;
            struct pollfd ready={fd,POLLOUT,0};
            if(wait_broker_events(&ready,1,-1)<0 && errno!=EINTR) return 0;
            continue;
        }
        if(!n) return 0;
        size_t remaining=(size_t)n;
        while(current<count && remaining>=parts[current].iov_len) {
            remaining-=parts[current].iov_len; ++current;
        }
        if(remaining && current<count) {
            parts[current].iov_base=(unsigned char *)parts[current].iov_base+remaining;
            parts[current].iov_len-=remaining;
        }
    }
    return 1;
}
#endif
static unsigned bridge_status(struct module_result r) {
    if (r.rejected) return 1;
    if (r.outcome.cancelled) return 4;
    if (r.outcome.timed_out) return 3;
    if (r.outcome.protocol_error || r.outcome.setup_error) return 5;
    if (r.outcome.signal) return 2;
    return 0;
}
#ifdef UBYTEC_HOST_IO
#include "host-io-service.h"
#endif
#include "many-service.h"
static int service_request(int fd, const struct message *request, unsigned caller_module) {
    #ifdef UBYTEC_HOST_IO
    if(request->operation==6) return service_host_io(fd,request,caller_module);
    #endif
    if(request->operation==4) return service_many(fd,request,caller_module);
    /* Identity is the worker context selected by the supervisor, never wire data. */
    if (caller_module!=0 || request->operation!=2 || request->checksum!=0x55424331 ||
        request->ticks || request->value || !request->length || request->length>MAX_PAYLOAD) return 0;
    ++serviced_calls;
    struct region copy=create_region(1,request->length);
    if (!ipc_exact(fd,copy.data,request->length,0)) { destroy_region(&copy); return 0; }
    struct module_result result={.rejected=1};
    const struct program_grant *grant=NULL;
    for(unsigned i=0;i<grant_count;i++) if(grants[i].handle==request->region && grants[i].enabled) grant=&grants[i];
    int valid=grant && !grant->typed && (request->rights==1 || request->rights==3) &&
        (request->rights & grant->rights)==request->rights && request->length<=grant->maximum &&
        request->invocation<=MAX_CALL_MS &&
        (grant->unlimited || (request->invocation && request->invocation<=grant->budget));
    if (valid) {
        program_registry.functions[grant->function].execution=request->invocation ?
            (struct execution_contract){EXEC_FINITE,request->invocation} :
            (struct execution_contract){EXEC_UNBOUNDED,0};
        ++callee_launches;
        const struct function_record *fn=&program_registry.functions[grant->function];
        result=call_module(&program_registry,program_registry.modules[fn->module].name,fn->name,
                           &copy,(enum loan_rights)request->rights,1);
    }
    if(result.outcome.rss_kib>callee_peak_rss_kib) callee_peak_rss_kib=result.outcome.rss_kib;
    unsigned status=bridge_status(result);
    /* SIGUSR1 cancels the active leaf, then lets the caller handle that result. */
    if (status==4 && !execution_stop) execution_cancel=0;
    struct message response={3,request->region,request->invocation,request->rights,request->length,
                             status,0,status?0:result.outcome.value};
    int sent=ipc_exact(fd,&response,sizeof response,1);
    if (sent && !status && request->rights==3) sent=ipc_exact(fd,copy.data,request->length,1);
    /* Callee has already been reaped. No failed or partial result is copied back. */
    destroy_region(&copy);
    return sent;
}
static int contracts_setup(int argc,char **argv) {
    if(argc<5 || register_module(&program_registry,"caller",argv[2])!=0 ||
       !read_contract(&program_registry.modules[0].image,&manifests[0])) return 0;
    const struct contract_export *entry=contract_export(0,argv[3]);
    if(!entry || strcmp(entry->signature,"UInt64,UInt64,UInt64,UInt64:Int64") ||
       !register_function(&program_registry,0,"main",entry->symbol,3,MAX_PAYLOAD)) return 0;
    int i=4;
    while(i<argc && !strcmp(argv[i],"--module")) {
        if(i+2>=argc || !contract_id(argv[i+1])) return 0;
        int id=register_module(&program_registry,argv[i+1],argv[i+2]);
        if(id<1 || !read_contract(&program_registry.modules[id].image,&manifests[id])) return 0;
        i+=3;
    }
    for(unsigned n=0;n<manifests[0].ni;n++) {
        const struct contract_import *in=&manifests[0].imports[n];
        unsigned module=1;
        while(module<program_registry.modules_count && strcmp(program_registry.modules[module].name,in->module)) ++module;
        if(module==program_registry.modules_count) return 0;
        const struct contract_export *ex=contract_export(module,in->name);
        if(!ex || strcmp(in->signature,ex->signature)) return 0;
        unsigned function=program_registry.functions_count;
        if(!register_function(&program_registry,module,in->alias,ex->symbol,3,MAX_PAYLOAD)) return 0;
        struct program_grant *grant=&grants[grant_count++];
        *grant=(struct program_grant){.handle=in->handle,.function=function};
        if(strcmp(in->signature,"UInt64,UInt64,UInt64,UInt64:Int64")) {
            grant->typed=1; if(!many_signature(in->signature,grant)) return 0;
        }
    }
    while(i<argc) {
        if(!strcmp(argv[i],"--profile")) { module_profile=1; i++; continue; }
        if(!strcmp(argv[i],"--input") || !strcmp(argv[i],"--output")) {
            if(i+1>=argc) return 0;
            const char **path=!strcmp(argv[i],"--input")?&program_input_path:&program_output_path;
            if(*path) return 0;
            *path=argv[i+1]; i+=2; continue;
        }
        int typed=!strcmp(argv[i],"--grant-many");
        if((!typed && strcmp(argv[i],"--grant")) || i+(typed?7:5)>=argc) return 0;
        struct program_grant *grant=NULL;
        for(unsigned n=0;n<manifests[0].ni;n++) if(!strcmp(manifests[0].imports[n].alias,argv[i+1])) {
            const struct contract_import *in=&manifests[0].imports[n];
            char target[129]; snprintf(target,sizeof target,"%s.%s",in->module,in->name);
            if(strcmp(target,argv[i+2])) return 0;
            grant=&grants[n];
        }
        if(!grant || grant->enabled || grant->typed!=typed) return 0;
        unsigned budget_index;
        if(typed) {
            for(unsigned n=0;n<2;n++) {
                if(!parse_u32(argv[i+3+n*2],&grant->loan_rights[n]) ||
                   !parse_u32(argv[i+4+n*2],&grant->loan_max[n]) || grant->loan_max[n]>MAX_PAYLOAD) return 0;
                if(n>=grant->loans) { if(grant->loan_rights[n] || grant->loan_max[n]) return 0; }
                else if((grant->loan_rights[n]!=1 && grant->loan_rights[n]!=3) || !grant->loan_max[n]) return 0;
            }
            budget_index=i+7;
        } else {
            if(!parse_u32(argv[i+3],&grant->rights) || (grant->rights!=1 && grant->rights!=3) ||
               !parse_u32(argv[i+4],&grant->maximum) || !grant->maximum || grant->maximum>MAX_PAYLOAD) return 0;
            budget_index=i+5;
        }
        grant->unlimited=!strcmp(argv[budget_index],"none");
        if(!grant->unlimited && (!parse_u32(argv[budget_index],&grant->budget) || !grant->budget || grant->budget>MAX_CALL_MS)) return 0;
        grant->enabled=1; i=budget_index+1;
    }
    return 1;
}
int main(int argc,char **argv) {
    uint64_t profile_main=now_ns();
    for(int i=1;i<argc;i++) if(!strcmp(argv[i],"--profile")) module_profile=1;
    if (argc>1 && !strcmp(argv[1],"--module-worker")) module_worker(argc,argv);
    int contracts_mode=argc>1 && !strcmp(argv[1],"--contracts");
    if (contracts_mode) {
        if(!contracts_setup(argc,argv)) { registry_close(&program_registry); puts("{\"accepted\":false,\"contracts_rejected\":true}"); return 1; }
    } else {
    if (argc!=9 || strcmp(argv[1],"--program")) {
        fprintf(stderr,"Usage: program --program caller.elf caller_symbol target.elf target_symbol ceiling maximum_bytes budget_ms|none\n");
        return 2;
    }
    if (!parse_u32(argv[6],&program_ceiling) || (program_ceiling!=1 && program_ceiling!=3) ||
        !parse_u32(argv[7],&program_maximum) || !program_maximum || program_maximum>MAX_PAYLOAD) return 2;
    program_unlimited=!strcmp(argv[8],"none");
    if (!program_unlimited && (!parse_u32(argv[8],&program_budget) || !program_budget || program_budget>MAX_CALL_MS)) return 2;
    int caller=register_module(&program_registry,"caller",argv[2]);
    int target=register_module(&program_registry,"target",argv[4]);
    if (caller!=0 || target!=1 ||
        !register_function(&program_registry,0,"main",argv[3],3,256) ||
        !register_function(&program_registry,1,"callee",argv[5],program_ceiling,program_maximum)) {
        registry_close(&program_registry); return 1;
    }
    grants[0]=(struct program_grant){.handle=1,.rights=program_ceiling,.maximum=program_maximum,.budget=program_budget,.function=1,.unlimited=program_unlimited,.enabled=1};
    grant_count=1;
    }
    program_registry.functions[0].execution=(struct execution_contract){EXEC_UNBOUNDED,0};
    module_request_service=service_request;
    if (!install_execution_signals()) { registry_close(&program_registry); return 2; }
    execution_events=1; execution_request=1;
    uint32_t root_length=256; int input=-1;
    if(program_input_path) {
        input=open(program_input_path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);
        struct stat st;
        if(input<0 || fstat(input,&st) || !S_ISREG(st.st_mode) || st.st_size<32 || st.st_size>MAX_PAYLOAD) {
            if(input>=0) close(input);
            registry_close(&program_registry); return 2;
        }
        root_length=(uint32_t)st.st_size;
    }
    struct region root=create_region(1,root_length); memset(root.data,1,root_length);
    if(input>=0) {
        size_t done=0;
        while(done<root_length) {
            ssize_t n=read(input,root.data+done,root_length-done);
            if(n<0 && errno==EINTR) continue;
            if(n<=0) { close(input); destroy_region(&root); registry_close(&program_registry); return 2; }
            done+=(size_t)n;
        }
        close(input);
    }
    uint64_t profile_ready=module_profile?now_ns():0;
    struct module_result result=call_module(&program_registry,"caller","main",&root,3,1);
    #ifdef UBYTEC_PROGRAM_RESULT_HOOK
    UBYTEC_PROGRAM_RESULT_HOOK(result);
    #endif
    int ok=successful(result);
    emit_case("program",ok,result);
    int neighbors=1;
    for (unsigned i=16;i<256;i++) if (i<128 || i>=136) neighbors &= root.data[i]==1;
    printf("{\"event\":\"program-result\",\"requests\":%u,\"callee_launches\":%u,\"byte0\":%u,\"neighbor\":%u,\"neighbors_preserved\":%s,\"caller_peak_rss_kib\":%ld,\"receiver_peak_rss_kib\":%ld}\n",
           serviced_calls,callee_launches,root.data[0],root.data[16],neighbors?"true":"false",result.outcome.rss_kib,callee_peak_rss_kib);
    if(module_profile) printf("{\"event\":\"profile-result\",\"pidfd_workers\":%u,\"preparation_ns\":%llu,\"module_registration_ns\":%llu,\"module_read_ns\":%llu,\"request_receive_ns\":%llu,\"loan_setup_ns\":%llu,\"receiver_setup_ns\":%llu,\"receiver_fork_ns\":%llu,\"receiver_wait_ns\":%llu,\"receiver_reap_ns\":%llu,\"reply_send_ns\":%llu,\"receiver_ticks\":%llu,\"caller_wait_ns\":%llu}\n",
        pidfd_workers,(unsigned long long)(profile_ready-profile_main),(unsigned long long)module_registration_ns,
        (unsigned long long)module_read_ns,(unsigned long long)request_receive_ns,
        (unsigned long long)loan_setup_ns,(unsigned long long)receiver_timing.setup_ns,
        (unsigned long long)receiver_timing.fork_ns,(unsigned long long)receiver_timing.wait_ns,
        (unsigned long long)receiver_timing.reap_ns,(unsigned long long)reply_send_ns,
        (unsigned long long)receiver_ticks,(unsigned long long)last_module_timing.wait_ns);
    if(program_output_path) {
        int output=open(program_output_path,O_WRONLY|O_CREAT|O_TRUNC|O_CLOEXEC|O_NOFOLLOW,0600);
        size_t done=0;
        while(output>=0 && done<root_length) {
            ssize_t n=write(output,root.data+done,root_length-done);
            if(n<0 && errno==EINTR) continue;
            if(n<=0) break;
            done+=(size_t)n;
        }
        if(output>=0) close(output);
        if(done!=root_length) ok=0;
    }
    destroy_region(&root); registry_close(&program_registry); return ok?0:1;
}
