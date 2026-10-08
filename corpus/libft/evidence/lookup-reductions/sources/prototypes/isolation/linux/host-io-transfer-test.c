#include <stdint.h>
#include <stdio.h>
#include <string.h>
struct wire {uint32_t operation,handle,direction,rights,length,status;uint64_t offset;int64_t value;};
extern int64_t ubytec_bridge_read(uint64_t,uint64_t,unsigned char *,uint64_t,int64_t *);
extern int64_t ubytec_bridge_write(uint64_t,uint64_t,unsigned char *,uint64_t,int64_t *);
static unsigned char sent[64],response[48];static size_t written,received,available;static unsigned calls,scenario,error;
long ubytec_bridge_test_io(long op,void *buffer,uint64_t length){
    calls++;if(calls%4==1)return -4;
    size_t n=length>3?3:(size_t)length;
    if(op==1){if(written+n>sizeof sent)return -1;memcpy(sent+written,buffer,n);written+=n;return (long)n;}
    if(received==available)return 0;
    if(n>available-received)n=available-received;
    memcpy(buffer,response+received,n);received+=n;return (long)n;
}
int main(void){
    for(scenario=0;scenario<12;scenario++){
        written=received=calls=error=0;unsigned char data[8];memset(data,0xa5,sizeof data);
        int writing=scenario==1;struct wire reply={7,7,(uint32_t)(writing?2:1),0,8,0,0,3};
        if(scenario==2)reply.handle=9;
        if(scenario==3)reply.direction=2;
        if(scenario==4)reply.rights=1;
        if(scenario==5)reply.length=7;
        if(scenario==6)reply.status=3;
        if(scenario==7)reply.offset=1;
        if(scenario==8)reply.value=-1;
        if(scenario==9)reply.value=9;
        if(scenario==10){reply.status=1;reply.value=1;}
        memcpy(response,&reply,40);memcpy(response+40,"xyz",3);available=scenario==11?42:writing?40:43;
        int64_t value=-1,status=writing?ubytec_bridge_write(7,123,data,8,&value):ubytec_bridge_read(7,123,data,8,&value);
        if(status!=(scenario<2?0:5)||value!=(scenario<2?3:0))return 1;
        struct wire req;memcpy(&req,sent,40);
        if(req.operation!=6||req.handle!=7||req.direction!=(unsigned)(writing?2:1)||req.length!=8||req.status!=0x5542494f||req.offset!=123||req.rights||req.value||written!=(size_t)(writing?48:40))return 2;
        for(unsigned i=0;i<8;i++)if(data[i]!=(scenario==0&&i<3?(unsigned char)"xyz"[i]:0xa5))return 3;
        if(writing)for(unsigned i=40;i<48;i++)if(sent[i]!=0xa5)return 4;
    }
    int64_t value=3;unsigned char data[1]={0};calls=0;
    if(ubytec_bridge_read(UINT64_MAX,0,data,1,&value)!=1||value||calls)return 5;
    if(ubytec_bridge_read(7,0,data,65537,&value)!=1||value||calls)return 6;
    puts("{\"accepted\":true,\"fragmented_cases\":12,\"local_rejections\":2}");return 0;
}
