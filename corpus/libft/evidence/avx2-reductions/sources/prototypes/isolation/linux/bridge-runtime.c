/* Untrusted worker-side bridge; authority and validation live in the supervisor. */
#include <stdint.h>
#include "many-wire.h"
struct wire { uint32_t operation, handle, budget, rights, length, status; uint64_t ticks; int64_t value; };
_Static_assert(sizeof(struct wire)==40,"wire size");
static long io(long op, void *buffer, uint64_t length) {
#ifdef UBYTEC_BRIDGE_IO_TEST
    extern long ubytec_bridge_test_io(long,void *,uint64_t);
    return ubytec_bridge_test_io(op,buffer,length);
#else
    long result;
    __asm__ volatile("syscall" : "=a"(result) : "a"(op),"D"(3L),"S"(buffer),"d"(length) : "rcx","r11","memory");
    return result;
#endif
}
static int exact(long op, void *buffer, uint64_t length) {
    unsigned char *p=buffer;
    while (length) {
        long n=io(op,p,length);
        if (n==-4) continue;
        if (n<=0 || (uint64_t)n>length) return 0;
        p+=n; length-=(uint64_t)n;
    }
    return 1;
}
static unsigned char transfer[65536];
/* handle, local pointer, logical bytes, rights, milliseconds (0=none), result cell */
int64_t ubytec_bridge_call(uint64_t handle, unsigned char *buffer, uint64_t length,
                          uint64_t rights, uint64_t budget, int64_t *value) {
    *value=0;
    if (handle>UINT32_MAX || !length || length>65536 || rights>UINT32_MAX || budget>3600000) return 1;
    for (uint64_t i=0;i<length;i++) transfer[i]=buffer[i];
    struct wire request={2,(uint32_t)handle,(uint32_t)budget,(uint32_t)rights,(uint32_t)length,0x55424331,0,0};
    if (!exact(1,&request,sizeof request) || !exact(1,transfer,length)) return 5;
    struct wire reply;
    if (!exact(0,&reply,sizeof reply) || reply.operation!=3 || reply.handle!=request.handle ||
        reply.length!=request.length || reply.rights!=request.rights || reply.budget!=request.budget ||
        reply.status>5 || reply.ticks) return 5;
    if (!reply.status && rights==3) {
        if (!exact(0,transfer,length)) return 5;
        for (uint64_t i=0;i<length;i++) buffer[i]=transfer[i];
    }
    *value=reply.value;
    return reply.status;
}

static unsigned char many_frame[sizeof(struct wire)+sizeof(struct many_request)+2*65536];
#define MANY_HEADER (sizeof(struct wire)+sizeof(struct many_request))
static unsigned char *const many_transfer[2]={many_frame+MANY_HEADER,many_frame+MANY_HEADER+65536};
int64_t ubytec_bridge_many(uint64_t handle,const struct many_argument *arguments,uint64_t count,
                          uint64_t budget,int64_t *value) {
    *value=0;
    if(handle>UINT32_MAX || count>6 || budget>3600000) return 1;
    struct many_request body={0}; unsigned loans=0;
    for(unsigned i=0;i<count;i++) {
        body.args[i]=arguments[i];
        if(arguments[i].kind==1 || arguments[i].kind==2) {
            if(loans==2 || arguments[i].length>65536) return 1;
            const unsigned char *p=(const unsigned char *)(uintptr_t)arguments[i].value;
            for(uint64_t j=0;j<arguments[i].length;j++) many_transfer[loans][j]=p[j];
            ++loans;
        } else if(arguments[i].kind!=3 && arguments[i].kind!=4) return 1;
    }
    struct wire request={4,(uint32_t)handle,(uint32_t)budget,loans,(uint32_t)count,0x55424332,0,0};
#ifdef UBYTEC_BRIDGE_REFERENCE
    if(!exact(1,&request,sizeof request) || !exact(1,&body,sizeof body)) return 5;
    loans=0;
    for(unsigned i=0;i<count;i++) if(body.args[i].kind<=2)
        if(!exact(1,many_transfer[loans++],body.args[i].length)) return 5;
#else
    const unsigned char *header=(const unsigned char *)&request,*metadata=(const unsigned char *)&body;
    for(unsigned i=0;i<sizeof request;i++) many_frame[i]=header[i];
    for(unsigned i=0;i<sizeof body;i++) many_frame[sizeof request+i]=metadata[i];
    uint64_t frame_length=MANY_HEADER; loans=0;
    for(unsigned i=0;i<count;i++) if(body.args[i].kind<=2) {
        unsigned char *source=many_transfer[loans++];
        /* Compact downwards; forward copying is safe for overlap within this private staging buffer. */
        for(uint64_t j=0;j<body.args[i].length;j++) many_frame[frame_length+j]=source[j];
        frame_length+=body.args[i].length;
    }
    if(!exact(1,many_frame,frame_length)) return 5;
#endif
    struct wire reply;
    if(!exact(0,&reply,sizeof reply) || reply.operation!=5 || reply.handle!=request.handle ||
       reply.budget!=request.budget || reply.length!=request.length || reply.rights!=request.rights ||
       reply.status>5 || reply.ticks) return 5;
    if(!reply.status) {
        loans=0;
        // Receive every result before publishing any of the caller's buffers.
        for(unsigned i=0;i<count;i++) if(body.args[i].kind<=2) {
            if(body.args[i].kind==1 && !exact(0,many_transfer[loans],body.args[i].length)) return 5;
            ++loans;
        }
        loans=0;
        for(unsigned i=0;i<count;i++) if(body.args[i].kind<=2) {
            if(body.args[i].kind==1) {
                unsigned char *p=(unsigned char *)(uintptr_t)body.args[i].value;
                for(uint64_t j=0;j<body.args[i].length;j++) p[j]=many_transfer[loans][j];
            }
            ++loans;
        }
    }
    *value=reply.value; return reply.status;
}

/* Resource handles are not file descriptors. Authority is checked by the parent. */
static int64_t host_io(uint64_t direction,uint64_t handle,uint64_t offset,
                       unsigned char *buffer,uint64_t length,int64_t *value) {
    *value=0;
    if(handle>UINT32_MAX || !handle || length>65536) return 1;
    struct wire request={6,(uint32_t)handle,(uint32_t)direction,0,(uint32_t)length,0x5542494f,offset,0};
    if(direction==2) for(uint64_t i=0;i<length;i++) transfer[i]=buffer[i];
    if(!exact(1,&request,sizeof request) || (direction==2 && !exact(1,transfer,length))) return 5;
    struct wire reply;
    if(!exact(0,&reply,sizeof reply) || reply.operation!=7 || reply.handle!=request.handle ||
       reply.budget!=request.budget || reply.rights || reply.length!=request.length ||
       reply.status>2 || reply.ticks || reply.value<0 || (uint64_t)reply.value>length ||
       (reply.status && reply.value)) return 5;
    if(!reply.status && direction==1) {
        if(!exact(0,transfer,(uint64_t)reply.value)) return 5;
        for(uint64_t i=0;i<(uint64_t)reply.value;i++) buffer[i]=transfer[i];
    }
    *value=reply.value;return reply.status;
}
int64_t ubytec_bridge_read(uint64_t handle,uint64_t offset,unsigned char *buffer,uint64_t length,int64_t *value) {
    return host_io(1,handle,offset,buffer,length,value);
}
int64_t ubytec_bridge_write(uint64_t handle,uint64_t offset,unsigned char *buffer,uint64_t length,int64_t *value) {
    return host_io(2,handle,offset,buffer,length,value);
}
