/* Independent C memcpy oracle for the test input layout (not a module ABI). */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc,char **argv) {
    if(argc!=3) return 1;
    FILE *in=fopen(argv[1],"rb"); if(!in) return 2;
    unsigned char data[65536]; size_t size=fread(data,1,sizeof data,in); int extra=fgetc(in); fclose(in);
    if(size<32 || extra!=EOF) return 3;
    uint64_t capacity,count; memcpy(&capacity,data,8); memcpy(&count,data+8,8);
    if(capacity>(size-32)/2 || count>capacity) return 4;
    memcpy(data+16+capacity,data+16,(size_t)count);
    memcpy(data+size-8,&count,8);
    FILE *out=fopen(argv[2],"wb"); if(!out) return 5;
    int good=fwrite(data,1,size,out)==size; if(fclose(out)) good=0;
    return good?0:6;
}
