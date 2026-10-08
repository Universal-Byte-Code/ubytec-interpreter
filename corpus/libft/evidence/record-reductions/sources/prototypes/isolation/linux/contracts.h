/* Bounded metadata reader; declarations are data, never permission. */
#define CONTRACT_LIMIT 16
struct contract_import { char alias[64], module[64], name[64], signature[128]; uint32_t handle; };
struct contract_export { char name[64], symbol[64], signature[128]; };
struct contract_manifest { struct contract_import imports[CONTRACT_LIMIT]; struct contract_export exports[CONTRACT_LIMIT]; unsigned ni,ne; };
static struct contract_manifest manifests[MODULE_LIMIT];
static int contract_id(const char *s) {
    if (!*s || strlen(s)>63 || !((*s>='A' && *s<='Z') || (*s>='a' && *s<='z') || *s=='_')) return 0;
    for (++s;*s;s++) if (!((*s>='A' && *s<='Z') || (*s>='a' && *s<='z') || (*s>='0' && *s<='9') || *s=='_')) return 0;
    return 1;
}
static int read_contract(const struct image *image,struct contract_manifest *out) {
    memset(out,0,sizeof *out);
    Elf64_Shdr names;
    if (image->header.e_shstrndx>=image->header.e_shnum) return 0;
    memcpy(&names,image->bytes+image->header.e_shoff+image->header.e_shstrndx*sizeof names,sizeof names);
    if (names.sh_type!=SHT_STRTAB || !file_range(image->length,names.sh_offset,names.sh_size)) return 0;
    char text_buffer[4097]; int found=0;
    for(unsigned i=0;i<image->header.e_shnum;i++) {
        Elf64_Shdr s; memcpy(&s,image->bytes+image->header.e_shoff+i*sizeof s,sizeof s);
        if (s.sh_name>=names.sh_size) return 0;
        const char *name=(const char *)image->bytes+names.sh_offset+s.sh_name;
        if (!memchr(name,0,names.sh_size-s.sh_name)) return 0;
        if (strcmp(name,".ubytec_contract")) continue;
        if (++found!=1 || s.sh_type!=SHT_PROGBITS || s.sh_flags!=SHF_ALLOC ||
            !s.sh_size || s.sh_size>4096 || !file_range(image->length,s.sh_offset,s.sh_size)) return 0;
        int mapped=0;
        for(unsigned j=0;j<image->count;j++) {
            const Elf64_Phdr *p=&image->loads[j];
            if(p->p_flags==PF_R && s.sh_addr>=p->p_vaddr &&
                s.sh_addr-p->p_vaddr<=p->p_filesz && s.sh_size<=p->p_filesz-(s.sh_addr-p->p_vaddr) &&
                s.sh_offset==p->p_offset+(s.sh_addr-p->p_vaddr)) mapped=1;
        }
        if(!mapped) return 0;
        memcpy(text_buffer,image->bytes+s.sh_offset,s.sh_size); text_buffer[s.sh_size]=0;
        for(uint64_t j=0;j<s.sh_size;j++) if(text_buffer[j]!='\n' && (text_buffer[j]<33 || text_buffer[j]>126)) return 0;
    }
    if(found!=1) return 0;
    char *cursor=text_buffer, *line=strsep(&cursor,"\n");
    if(!line || strcmp(line,"UBC1")) return 0;
    int ended=0;
    while((line=strsep(&cursor,"\n"))) {
        if(!strcmp(line,"END")) { ended=1; if(!cursor || *cursor) return 0; break; }
        char *fields[7]; unsigned n=0; char *part;
        while((part=strsep(&line,"|"))) { if(n==7 || !*part) return 0; fields[n++]=part; }
        if(n==6 && !strcmp(fields[0],"I")) {
            if(out->ni==CONTRACT_LIMIT || !contract_id(fields[2]) || !contract_id(fields[3]) ||
               !contract_id(fields[4]) || strlen(fields[5])>=128) return 0;
            struct contract_import *in=&out->imports[out->ni];
            if(!parse_u32(fields[1],&in->handle) || in->handle!=out->ni+1) return 0;
            for(unsigned j=0;j<out->ni;j++) if(!strcmp(out->imports[j].alias,fields[2])) return 0;
            strcpy(in->alias,fields[2]); strcpy(in->module,fields[3]); strcpy(in->name,fields[4]); strcpy(in->signature,fields[5]); ++out->ni;
        } else if(n==4 && !strcmp(fields[0],"E")) {
            if(out->ne==CONTRACT_LIMIT || !contract_id(fields[1]) || !contract_id(fields[2]) || strlen(fields[3])>=128) return 0;
            uint64_t entry; if(!find_export(image,fields[2],&entry)) return 0;
            for(unsigned j=0;j<out->ne;j++) if(!strcmp(out->exports[j].name,fields[1])) return 0;
            struct contract_export *ex=&out->exports[out->ne++];
            strcpy(ex->name,fields[1]); strcpy(ex->symbol,fields[2]); strcpy(ex->signature,fields[3]);
        } else return 0;
    }
    return ended;
}
static const struct contract_export *contract_export(unsigned module,const char *name) {
    for(unsigned i=0;i<manifests[module].ne;i++) if(!strcmp(manifests[module].exports[i].name,name)) return &manifests[module].exports[i];
    return NULL;
}
