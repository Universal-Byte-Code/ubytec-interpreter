/* Supervisor-only argument validation and two dedicated region loans. */
static int many_signature(const char *signature,struct program_grant *grant) {
    char text[128]; if(strlen(signature)>=sizeof text) return 0; strcpy(text,signature);
    char *result=strchr(text,':'); if(!result) return 0; *result++=0;
    if(strcmp(result,"Int64") && strcmp(result,"UInt64")) return 0;
    char *cursor=text,*part; unsigned count=0,loans=0;
    if(*text) while((part=strsep(&cursor,","))) {
        if(count==6) return 0;
        unsigned kind=!strcmp(part,"LoanWrite")?1:!strcmp(part,"LoanRead")?2:
                      !strcmp(part,"UInt64")?3:!strcmp(part,"Int64")?4:0;
        if(!kind || (kind<=2 && ++loans>2)) return 0;
        grant->kinds[count++]=kind;
    }
    grant->count=count; grant->loans=loans; return 1;
}
static int service_many(int fd,const struct message *request,unsigned caller) {
    if(caller!=0 || request->operation!=4 || request->checksum!=0x55424332 || request->length>6 ||
       request->rights>2 || request->ticks || request->value) return 0;
    uint64_t profile_begin=module_profile?now_ns():0,profile_receive=0,profile_setup=0;
    struct many_request body;
    if(!ipc_exact(fd,&body,sizeof body,0)) return 0;
    if(module_profile) profile_receive=now_ns()-profile_begin;
    unsigned loans=0;
    for(unsigned i=0;i<6;i++) {
        const struct many_argument *a=&body.args[i];
        if(i>=request->length) { if(a->kind || a->value || a->length) return 0; continue; }
        if(a->kind==1 || a->kind==2) {
            if(++loans>2 || a->length>MAX_PAYLOAD) return 0;
        } else if((a->kind!=3 && a->kind!=4) || a->length) return 0;
    }
    if(loans!=request->rights) return 0;
    ++serviced_calls;
    struct region regions[2]; regions[0]=create_region(1,32); regions[1]=create_region(1,32);
    struct many_parameters parameters={.count=request->length,.loans=loans};
    unsigned ordinal=0;
    for(unsigned i=0;i<request->length;i++) {
        const struct many_argument *a=&body.args[i]; parameters.kinds[i]=(uint32_t)a->kind;
        if(a->kind<=2) {
            destroy_region(&regions[ordinal]); regions[ordinal]=create_region(1,a->length?(uint32_t)a->length:32);
            parameters.length[ordinal]=(uint32_t)a->length; parameters.rights[ordinal]=a->kind==1?3:1;
            uint64_t before=module_profile?now_ns():0;
            if(!ipc_exact(fd,regions[ordinal].data,(size_t)a->length,0)) goto failed;
            if(module_profile) profile_receive+=now_ns()-before;
            ++ordinal;
        } else parameters.values[i]=a->value;
    }
    const struct program_grant *grant=NULL;
    for(unsigned i=0;i<grant_count;i++) if(grants[i].handle==request->region && grants[i].enabled && grants[i].typed) grant=&grants[i];
    int valid=grant && grant->count==request->length && grant->loans==loans &&
        request->invocation<=MAX_CALL_MS &&
        (grant->unlimited || (request->invocation && request->invocation<=grant->budget));
    if(valid) for(unsigned i=0;i<request->length;i++) valid &= grant->kinds[i]==parameters.kinds[i];
    if(valid) for(unsigned i=0;i<loans;i++) valid &= parameters.length[i]<=grant->loan_max[i] &&
        (parameters.rights[i]&grant->loan_rights[i])==parameters.rights[i];
    struct module_result result={.rejected=1};
    if(valid) {
        int meta=memfd_create("ubytec-arguments",MFD_CLOEXEC|MFD_ALLOW_SEALING);
        if(meta<0 || write(meta,&parameters,sizeof parameters)!=sizeof parameters ||
           fcntl(meta,F_ADD_SEALS,F_SEAL_WRITE|F_SEAL_GROW|F_SEAL_SHRINK|F_SEAL_SEAL)) die("sealed arguments");
        struct many_launch launch={meta,regions[1].fd}; pending_many=&launch;
        struct function_record *fn=&program_registry.functions[grant->function];
        fn->execution=request->invocation?(struct execution_contract){EXEC_FINITE,request->invocation}:
                                         (struct execution_contract){EXEC_UNBOUNDED,0};
        ++callee_launches;
        profile_setup=module_profile?now_ns():0;
        result=call_module(&program_registry,program_registry.modules[fn->module].name,fn->name,
                          &regions[0],loans?(enum loan_rights)parameters.rights[0]:LOAN_READ_WRITE,
                          loans && parameters.length[0]>0);
        if(module_profile) {
            loan_setup_ns+=profile_setup-profile_begin-profile_receive;
            receiver_timing.setup_ns+=last_module_timing.setup_ns;
            receiver_timing.fork_ns+=last_module_timing.fork_ns;
            receiver_timing.wait_ns+=last_module_timing.wait_ns;
            receiver_timing.reap_ns+=last_module_timing.reap_ns;
            receiver_ticks+=result.outcome.ticks;
        }
        pending_many=NULL; close(meta);
    }
    if(result.outcome.rss_kib>callee_peak_rss_kib) callee_peak_rss_kib=result.outcome.rss_kib;
    unsigned status=bridge_status(result);
    if(status==4 && !execution_stop) execution_cancel=0;
    struct message response={5,request->region,request->invocation,request->rights,request->length,status,0,status?0:result.outcome.value};
    uint64_t before_reply=module_profile?now_ns():0;
#ifdef UBYTEC_BRIDGE_REFERENCE
    int sent=ipc_exact(fd,&response,sizeof response,1);
    if(!status && sent) for(unsigned i=0;i<loans;i++) if(parameters.rights[i]==3)
        if(!ipc_exact(fd,regions[i].data,parameters.length[i],1)) { sent=0; break; }
#else
    struct iovec reply[3]={{&response,sizeof response}};unsigned count=1;
    if(!status) for(unsigned i=0;i<loans;i++) if(parameters.rights[i]==3)
        reply[count++]=(struct iovec){regions[i].data,parameters.length[i]};
    int sent=ipc_send_parts(fd,reply,count);
#endif
    if(module_profile) { request_receive_ns+=profile_receive; reply_send_ns+=now_ns()-before_reply; }
    destroy_region(&regions[0]); destroy_region(&regions[1]); return sent;
failed:
    destroy_region(&regions[0]); destroy_region(&regions[1]); return 0;
}
