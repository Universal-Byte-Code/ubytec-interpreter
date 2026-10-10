/* Independent byte-array model for the compiled generic Ubytec vector. */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define F(n) ubytec_host_contract_##n
extern uint64_t F(VectorInit)(uint64_t,uint64_t,uint64_t),F(VectorReserve)(uint64_t,uint64_t),F(VectorEnsure)(uint64_t,uint64_t);
extern uint64_t F(VectorPush)(uint64_t,uint64_t),F(VectorInsert)(uint64_t,uint64_t,uint64_t),F(VectorSet)(uint64_t,uint64_t,uint64_t),F(VectorGet)(uint64_t,uint64_t,uint64_t);
extern uint64_t F(VectorErase)(uint64_t,uint64_t,uint64_t),F(VectorClear)(uint64_t),F(VectorDestroy)(uint64_t),F(VectorValidate)(uint64_t),F(VectorAt)(uint64_t,uint64_t),F(VectorLength)(uint64_t),F(VectorCapacity)(uint64_t),F(VectorPin)(uint64_t),F(VectorUnpin)(uint64_t);
extern uint64_t F(ArenaInit)(uint64_t,uint64_t),F(ArenaFind)(uint64_t,uint64_t),F(ArenaAlloc)(uint64_t,uint64_t),F(ArenaFree)(uint64_t,uint64_t);
extern int64_t F(VectorStateSum)(uint64_t,uint64_t,uint64_t);
extern uint64_t F(VectorAppendText)(uint64_t,uint64_t,uint64_t,uint64_t);
struct vector{uint64_t arena,data,length,capacity,width;};
static _Alignas(16) unsigned char backing[65536+48],descriptor[72],snapshot[65536+16],model[65536];
static struct vector *v;
static uint64_t arena,cap,rng=42048,checks,steps,failures;
static uint64_t addr(const void *p){return (uint64_t)(uintptr_t)p;}
static uint64_t get(uint64_t p){uint64_t n;memcpy(&n,(void *)(uintptr_t)p,8);return n;}
static void check(int ok,int line){++checks;if(!ok){fprintf(stderr,"vector oracle mismatch line %d step %llu width %llu len %llu cap %llu\n",line,(unsigned long long)steps,(unsigned long long)v->width,(unsigned long long)v->length,(unsigned long long)v->capacity);exit(2);}}
#define CHECK(x) check(!!(x),__LINE__)
static uint64_t next(void){rng^=rng<<13;rng^=rng>>7;rng^=rng<<17;return rng;}
static void init(uint64_t capacity,uint64_t width){cap=capacity;memset(backing,0xa5,sizeof backing);memset(descriptor,0xa5,sizeof descriptor);v=(struct vector *)(void *)(descriptor+16);memset(v,0,sizeof *v);arena=addr(backing+16);memset(model,0,sizeof model);CHECK(F(ArenaInit)(arena,cap)==1);CHECK(F(VectorInit)(addr(v),arena,width)==1);}
static void verify(uint64_t length,uint64_t width,uint64_t pins){
 CHECK(F(VectorValidate)(addr(v))==1);CHECK(v->arena==arena&&v->length==length&&v->width==width&&v->capacity>=length&&v->capacity<=(cap-32)/width);CHECK(F(VectorLength)(addr(v))==length&&F(VectorCapacity)(addr(v))==v->capacity);
 if(v->data){uint64_t node=F(ArenaFind)(arena,v->data);CHECK(node!=0&&get(node+24)==pins);CHECK(get(node+8)==v->capacity*width);CHECK(!memcmp((void *)(uintptr_t)v->data,model,v->capacity*width));}
 else CHECK(!length&&!v->capacity&&!pins);
 for(unsigned i=0;i<16;i++)CHECK(backing[i]==0xa5&&backing[32+cap+i]==0xa5&&descriptor[i]==0xa5&&descriptor[56+i]==0xa5);
 CHECK(F(VectorAt)(addr(v),UINT64_MAX)==0);CHECK(F(VectorAt)(addr(v),length)==0);
}
static void random_history(uint64_t width,uint64_t capacity){
 init(capacity,width);uint64_t length=0,pins=0,maximum=(capacity-32)/width;
 for(unsigned step=0;step<2000;step++){
   ++steps;unsigned op=(unsigned)(next()%10);unsigned char element[255],output[255];for(uint64_t i=0;i<width;i++)element[i]=(unsigned char)next();
   struct vector before=*v;memcpy(snapshot,(void *)(uintptr_t)arena,capacity+16);uint64_t ok=0,expected=0,index=next()%(length+2);
   if(next()%19==0)index=UINT64_MAX;
   if(op==0||op==1){if(op==0)index=length;uint64_t source=addr(element);if(length&&next()%3==0){uint64_t from=next()%length;memcpy(element,model+from*width,width);source=F(VectorAt)(addr(v),from);}
     expected=!pins&&index<=length&&length<maximum;ok=op==0?F(VectorPush)(addr(v),source):F(VectorInsert)(addr(v),index,source);
     if(expected){memmove(model+(index+1)*width,model+index*width,(length-index)*width);memcpy(model+index*width,element,width);++length;}
   }else if(op==2){uint64_t count=next()%5;if(next()%17==0)count=UINT64_MAX;expected=index<=length&&count<=length-index&&(!pins||!count);ok=F(VectorErase)(addr(v),index,count);
     if(expected){memmove(model+index*width,model+(index+count)*width,(length-index-count)*width);memset(model+(length-count)*width,0,count*width);length-=count;}
   }else if(op==3){expected=!pins&&index<length;ok=F(VectorSet)(addr(v),index,addr(element));if(expected)memcpy(model+index*width,element,width);
   }else if(op==4){expected=index<length;memset(output,0xa5,sizeof output);ok=F(VectorGet)(addr(v),index,addr(output));if(expected)CHECK(!memcmp(output,model+index*width,width));else for(uint64_t i=0;i<width;i++)CHECK(output[i]==0xa5);
   }else if(op==5){expected=v->data!=0;ok=F(VectorPin)(addr(v));if(expected)++pins;
   }else if(op==6){expected=pins!=0;ok=F(VectorUnpin)(addr(v));if(expected)--pins;
   }else if(op==7){expected=!pins;ok=F(VectorClear)(addr(v));if(expected){memset(model,0,length*width);length=0;}
   }else{uint64_t request=next()%(maximum+2);if(next()%17==0)request=UINT64_MAX;expected=request<=v->capacity||(!pins&&request<=maximum);ok=op==8?F(VectorReserve)(addr(v),request):F(VectorEnsure)(addr(v),request);}
   CHECK(ok==expected);if(!ok){++failures;CHECK(!memcmp(&before,v,sizeof before));CHECK(!memcmp(snapshot,(void *)(uintptr_t)arena,capacity+16));}
   verify(length,width,pins);
 }
 while(pins){CHECK(F(VectorUnpin)(addr(v))==1);--pins;}CHECK(F(VectorDestroy)(addr(v))==1);CHECK(get(arena+8)==0);for(unsigned i=0;i<sizeof *v;i++)CHECK(((unsigned char *)v)[i]==0);
}
static void directed(void){
 init(4096,3);unsigned char item[3]={1,2,3},out[3];for(unsigned i=0;i<4;i++){item[0]=(unsigned char)i;CHECK(F(VectorPush)(addr(v),addr(item))==1);memcpy(model+i*3,item,3);}uint64_t old=v->data,anchor=F(ArenaAlloc)(arena,64);CHECK(anchor!=0);
 uint64_t source=F(VectorAt)(addr(v),3);memcpy(item,model+9,3);CHECK(F(VectorInsert)(addr(v),0,source)==1);CHECK(v->data!=old);memmove(model+3,model,12);memcpy(model,item,3);CHECK(!memcmp((void *)(uintptr_t)v->data,model,15));
 source=F(VectorAt)(addr(v),0);CHECK(F(VectorPush)(addr(v),source)==1);memcpy(model+15,model,3);CHECK(!memcmp((void *)(uintptr_t)v->data,model,18));
 struct vector before=*v;memcpy(snapshot,(void *)(uintptr_t)arena,4096+16);
 CHECK(!F(VectorPush)(addr(v),v->data+1));CHECK(!F(VectorInsert)(addr(v),0,addr(v)));CHECK(!F(VectorGet)(addr(v),0,v->data));CHECK(!F(VectorGet)(addr(v),0,v->data-1));CHECK(!F(VectorPush)(addr(v),v->data+v->length*3));CHECK(!memcmp(&before,v,sizeof before)&&!memcmp(snapshot,(void *)(uintptr_t)arena,4096+16));
 CHECK(F(VectorPin)(addr(v))==1);before=*v;memcpy(snapshot,(void *)(uintptr_t)arena,4096+16);CHECK(!F(VectorReserve)(addr(v),v->capacity+1));CHECK(!F(VectorPush)(addr(v),addr(item)));CHECK(!F(VectorInsert)(addr(v),0,addr(item)));CHECK(!F(VectorSet)(addr(v),0,addr(item)));CHECK(!F(VectorErase)(addr(v),0,1));CHECK(!F(VectorClear)(addr(v)));CHECK(!F(VectorDestroy)(addr(v)));CHECK(F(VectorGet)(addr(v),0,addr(out))==1);CHECK(!memcmp(&before,v,sizeof before)&&!memcmp(snapshot,(void *)(uintptr_t)arena,4096+16));CHECK(F(VectorUnpin)(addr(v))==1);
 CHECK(F(ArenaFree)(arena,anchor)==1);CHECK(F(VectorDestroy)(addr(v))==1&&get(arena+8)==0);
 /* Geometric target cannot coexist with another allocation; exact fallback fits. */
 init(256,1);CHECK(F(VectorReserve)(addr(v),32)==1);for(unsigned i=0;i<32;i++){item[0]=(unsigned char)i;CHECK(F(VectorPush)(addr(v),addr(item))==1);}anchor=F(ArenaAlloc)(arena,88);CHECK(anchor!=0);item[0]=99;CHECK(F(VectorPush)(addr(v),addr(item))==1);CHECK(v->capacity==33);CHECK(F(ArenaFree)(arena,anchor)==1);CHECK(F(VectorDestroy)(addr(v))==1&&get(arena+8)==0);
 init(4096,8);CHECK(F(VectorReserve)(addr(v),64)==1);uint64_t full=F(ArenaAlloc)(arena,3488);CHECK(full!=0);before=*v;memcpy(snapshot,(void *)(uintptr_t)arena,4096+16);CHECK(!F(VectorReserve)(addr(v),65));CHECK(!memcmp(&before,v,sizeof before)&&!memcmp(snapshot,(void *)(uintptr_t)arena,4096+16));CHECK(F(ArenaFree)(arena,full)==1);CHECK(F(VectorReserve)(addr(v),65)==1);CHECK(F(VectorDestroy)(addr(v))==1&&get(arena+8)==0);
}
static void applications(void){
 uint64_t scratch[2];static const uint64_t depths[]={0,1,2,63,128,256};
 init(16384,16);for(unsigned i=0;i<6;i++){uint64_t n=depths[i];CHECK(F(VectorStateSum)(addr(v),addr(scratch),n)==(int64_t)(3*n*(n-1)/2+5*n));CHECK(v->length==0);}CHECK(F(VectorStateSum)(addr(v),addr(scratch),UINT64_MAX)==-1);CHECK(v->length==0);CHECK(F(VectorStateSum)(addr(v),addr(scratch),63)==3*63*62/2+5*63);CHECK(F(VectorDestroy)(addr(v))==1&&get(arena+8)==0);
 init(16384,1);uint64_t used=0;unsigned char text[37];for(unsigned round=0;round<128;round++){size_t n=next()%38;for(size_t i=0;i<n;i++)text[i]=(unsigned char)next();CHECK(F(VectorAppendText)(addr(v),addr(scratch),addr(text),n)==1);for(size_t i=0;i<n;i++)model[used+i]=(unsigned char)toupper(text[i]);used+=n;CHECK(v->length==used);CHECK(!memcmp((void *)(uintptr_t)v->data,model,used));}
 struct vector before=*v;memcpy(snapshot,(void *)(uintptr_t)arena,16384+16);CHECK(!F(VectorAppendText)(addr(v),addr(scratch),addr(text),UINT64_MAX));CHECK(!memcmp(&before,v,sizeof before)&&!memcmp(snapshot,(void *)(uintptr_t)arena,16384+16));CHECK(F(VectorDestroy)(addr(v))==1&&get(arena+8)==0);
}
static void boundaries(void){
 init(65536,65504);unsigned char *element=malloc(65504),*output=malloc(65504);CHECK(element&&output);memset(element,0x3c,65504);CHECK(F(VectorReserve)(addr(v),1)==1);CHECK(get(arena+8)==65536);CHECK(F(VectorPush)(addr(v),addr(element))==1);CHECK(v->length==1&&v->capacity==1);struct vector before=*v;memcpy(snapshot,(void *)(uintptr_t)arena,65536+16);CHECK(!F(VectorPush)(addr(v),addr(element)));CHECK(!F(VectorReserve)(addr(v),UINT64_MAX));CHECK(!memcmp(&before,v,sizeof before)&&!memcmp(snapshot,(void *)(uintptr_t)arena,65536+16));CHECK(F(VectorSet)(addr(v),0,v->data)==1);CHECK(F(VectorGet)(addr(v),0,addr(output))==1);CHECK(!memcmp(element,output,65504));CHECK(F(VectorDestroy)(addr(v))==1&&get(arena+8)==0);before=*v;CHECK(!F(VectorInit)(addr(v),arena,0));CHECK(!F(VectorInit)(addr(v),arena,UINT64_MAX));CHECK(!memcmp(&before,v,sizeof before));CHECK(F(VectorValidate)(0)==0&&F(VectorPush)(0,addr(element))==0);free(output);free(element);
}
int main(void){for(unsigned c=0;c<2;c++)for(unsigned w=0;w<5;w++){static const uint64_t widths[]={1,3,8,16,255};random_history(widths[w],c?16384:4096);}directed();applications();boundaries();printf("{\"accepted\":true,\"random_steps\":%llu,\"checks\":%llu,\"rejections\":%llu,\"histories\":10,\"state_depths\":6,\"text_batches\":128}\n",(unsigned long long)steps,(unsigned long long)checks,(unsigned long long)failures);return 0;}
