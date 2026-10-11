/* Independent C oracle for the libft string/copy packet application. */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc,char **argv) {
    if(argc!=3) return 2;
    FILE *in=fopen(argv[1],"rb");
    if(!in || fseek(in,0,SEEK_END)) return 2;
    long size=ftell(in);
    if(size<32 || size>65536 || fseek(in,0,SEEK_SET)) return 2;
    unsigned char *packet=malloc((size_t)size);
    if(!packet || fread(packet,1,(size_t)size,in)!=(size_t)size) return 2;
    fclose(in);
    uint64_t capacity; memcpy(&capacity,packet,8);
    if(!capacity || capacity>((uint64_t)size-32)/2 || !memchr(packet+16,0,(size_t)capacity)) return 2;
    uint64_t length=strlen((const char *)packet+16);
    memcpy(packet+8,&length,8);
    memcpy(packet+16+capacity,packet+16,(size_t)length+1);
    memcpy(packet+size-8,&length,8);
    FILE *out=fopen(argv[2],"wb");
    if(!out || fwrite(packet,1,(size_t)size,out)!=(size_t)size || fclose(out)) return 2;
    printf("%llu\n",(unsigned long long)length);
    free(packet);return 0;
}
