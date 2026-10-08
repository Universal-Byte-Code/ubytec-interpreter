/* Independent whole-file C oracle; no Ubytec allocator or token helpers. */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
struct entry {char *text;uint64_t count;};
static struct entry *entries;static size_t used,capacity;
static int word(unsigned char c){return (c>='A'&&c<='Z')||(c>='a'&&c<='z')||(c>='0'&&c<='9')||c=='_';}
static void add(const unsigned char *data,size_t length){
    char *text=malloc(length+1);if(!text)exit(2);
    for(size_t i=0;i<length;i++)text[i]=(char)(data[i]>='A'&&data[i]<='Z'?data[i]+32:data[i]);
    text[length]=0;
    for(size_t i=0;i<used;i++)if(!strcmp(entries[i].text,text)){entries[i].count++;free(text);return;}
    if(used==capacity){size_t next=capacity?capacity*2:32;void *p=realloc(entries,next*sizeof(*entries));if(!p)exit(2);entries=p;capacity=next;}
    entries[used++]=(struct entry){text,1};
}
static int compare(const void *a,const void *b){return strcmp(((const struct entry *)a)->text,((const struct entry *)b)->text);}
int main(int argc,char **argv){
    if(argc!=3)return 2;
    FILE *in=fopen(argv[1],"rb"),*out=fopen(argv[2],"wb");if(!in||!out)return 2;
    unsigned char *token=NULL;size_t length=0,allocated=0;uint64_t bytes=0,words=0,emitted=0;int ch;
    while((ch=fgetc(in))!=EOF){bytes++;if(word((unsigned char)ch)){
        if(length==allocated){size_t n=allocated?allocated*2:64;void *p=realloc(token,n);if(!p)return 2;token=p;allocated=n;}token[length++]=(unsigned char)ch;
    }else if(length){add(token,length);words++;length=0;}}
    if(ferror(in))return 2;
    if(length){add(token,length);words++;}free(token);
    if(used)qsort(entries,used,sizeof(*entries),compare);
    for(size_t i=0;i<used;i++){int n=fprintf(out,"%s\t%" PRIu64 "\n",entries[i].text,entries[i].count);if(n<0)return 2;emitted+=(uint64_t)n;free(entries[i].text);}
    free(entries);if(fclose(in)||fclose(out))return 2;
    printf("{\"bytes\":%" PRIu64 ",\"words\":%" PRIu64 ",\"unique\":%zu,\"emitted\":%" PRIu64 "}\n",bytes,words,used,emitted);return 0;
}
