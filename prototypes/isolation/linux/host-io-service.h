/* Compiled only into supervisors opting in to UBYTEC_HOST_IO. */
struct host_io_resource { uint32_t handle,rights,maximum; int fd; uint64_t extent; };
static struct host_io_resource host_resources[16];
static unsigned host_resource_count;
static uint64_t host_reads,host_writes,host_denials,host_read_bytes,host_write_bytes;
static int service_host_io(int channel,const struct message *request,unsigned caller) {
    if(caller!=0 || request->operation!=6 || request->checksum!=0x5542494f ||
       request->rights || request->value || request->length>MAX_PAYLOAD ||
       (request->invocation!=1 && request->invocation!=2)) return 0;
    unsigned char buffer[MAX_PAYLOAD];
    if(request->invocation==2 && !ipc_exact(channel,buffer,request->length,0)) return 0;
    ++serviced_calls;
    const struct host_io_resource *resource=NULL;
    for(unsigned i=0;i<host_resource_count;i++) if(host_resources[i].handle==request->region) resource=&host_resources[i];
    unsigned status=1;int64_t count=0;
    unsigned required=request->invocation==1?1:2;
    int valid=resource && (resource->rights&required) && request->length<=resource->maximum &&
        request->ticks<=resource->extent && request->ticks<=INT64_MAX;
    uint64_t length=request->length;
    if(valid) {
        uint64_t available=resource->extent-request->ticks;
        if(required==1 && length>available) length=available;
        if(required==2 && length>available) valid=0;
    }
    if(valid) {
        ssize_t n;
        do {
            n=required==1?pread(resource->fd,buffer,(size_t)length,(off_t)request->ticks):
                           pwrite(resource->fd,buffer,(size_t)length,(off_t)request->ticks);
        } while(n<0 && errno==EINTR && !execution_cancel && !execution_stop);
        status=n<0?2:0;count=n<0?0:n;
        if(required==1){host_reads++;host_read_bytes+=(uint64_t)count;}
        else {host_writes++;host_write_bytes+=(uint64_t)count;}
    } else host_denials++;
    struct message response={7,request->region,request->invocation,0,request->length,status,0,count};
    int sent=ipc_exact(channel,&response,sizeof response,1);
    if(sent && !status && required==1) sent=ipc_exact(channel,buffer,(size_t)count,1);
    return sent;
}
