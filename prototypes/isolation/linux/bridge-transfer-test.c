/* Transport fault injection: short IO, EINTR, full-sized loans and atomic publication. */
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "many-wire.h"
struct wire { uint32_t operation,handle,budget,rights,length,status; uint64_t ticks; int64_t value; };
extern int64_t ubytec_bridge_many(uint64_t,const struct many_argument *,uint64_t,uint64_t,int64_t *);
static unsigned char request[184+131072],response[40+131072],first[65536],second[65536];
static size_t sent,read_offset,reply_length,limit;
static int write_interrupted,read_interrupted,prepared,error;
static struct many_argument arguments[3];
long ubytec_bridge_test_io(long op,void *buffer,uint64_t length) {
    if(op==1) {
        if(!write_interrupted++) return -4;
        size_t n=length>97?97:(size_t)length;
        if(sent+n>sizeof request) return -1;
        memcpy(request+sent,buffer,n);sent+=n;return (long)n;
    }
    if(!read_interrupted++) return -4;
    if(!prepared) {
        prepared=1;
        struct wire header;struct many_request body;
        memcpy(&header,request,40);memcpy(&body,request+40,sizeof body);
        if(header.operation!=4 || header.handle!=7 || header.rights!=2 || header.length!=3 ||
           header.budget!=1000 || header.status!=0x55424332 || header.ticks || header.value ||
           memcmp(body.args,arguments,sizeof arguments)) error=1;
        for(unsigned i=3;i<6;i++) if(body.args[i].kind || body.args[i].value || body.args[i].length) error=1;
        if(sent!=184+arguments[0].length+arguments[2].length ||
           memcmp(request+184,first,arguments[0].length) ||
           memcmp(request+184+arguments[0].length,second,arguments[2].length)) error=1;
        struct wire reply={5,7,1000,2,3,0,0,4294967297};memcpy(response,&reply,40);reply_length=40;
        for(unsigned i=0;i<3;i++) if(arguments[i].kind==1) {
            memset(response+reply_length,0x5a+i,(size_t)arguments[i].length);reply_length+=arguments[i].length;
        }
        if(limit && limit<reply_length) reply_length=limit;
    }
    if(read_offset==reply_length) return 0;
    size_t n=length>31?31:(size_t)length;if(n>reply_length-read_offset)n=reply_length-read_offset;
    memcpy(buffer,response+read_offset,n);read_offset+=n;return (long)n;
}
int main(void) {
    for(unsigned test=0;test<5;test++) {
        sent=read_offset=reply_length=0;prepared=write_interrupted=read_interrupted=error=0;
        size_t a=test==0?0:test==1?17:65536,b=test==0?0:test==1?513:65536;
        arguments[0]=(struct many_argument){test==3?2:1,(uintptr_t)first,a};
        arguments[1]=(struct many_argument){4,UINT64_MAX,0};
        arguments[2]=(struct many_argument){test<2?2:1,(uintptr_t)second,b};
        memset(first,0x31,sizeof first);memset(second,0x72,sizeof second);
        limit=test==4?40+a+1:0;int64_t value=-1;
        int64_t status=ubytec_bridge_many(7,arguments,3,1000,&value);
        if(error || status!=(test==4?5:0) || value!=(test==4?0:4294967297)) return 1;
        for(size_t i=0;i<sizeof first;i++) {
            unsigned char expected=(test!=4 && arguments[0].kind==1 && i<a)?0x5a:0x31;
            if(first[i]!=expected) return 2;
        }
        for(size_t i=0;i<sizeof second;i++) {
            unsigned char expected=(test!=4 && arguments[2].kind==1 && i<b)?0x5c:0x72;
            if(second[i]!=expected) return 3;
        }
    }
    puts("PASS 5 fragmented transport checks");return 0;
}
