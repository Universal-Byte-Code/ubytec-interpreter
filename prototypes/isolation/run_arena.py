#!/usr/bin/env python3
"""Bounded source-language allocator and incremental text, Python byte oracle."""
import argparse,hashlib,json,platform,random,shutil,struct,subprocess
from pathlib import Path
from run import command,records
ROOT=Path(__file__).resolve().parent
REPO=ROOT.parents[1]
MASK=(1<<64)-1
def get(b,p):return struct.unpack_from('<Q',b,p)[0]
def put(b,p,v):struct.pack_into('<Q',b,p,v&MASK)
def packet(cap,ops):
    b=bytearray([0xa5])*(192+cap+48*len(ops))
    struct.pack_into('<4Q',b,0,cap,len(ops),0,0)
    b[32:160]=bytes(128)
    for i,op in enumerate(ops):struct.pack_into('<6Q',b,160+48*i,*op,0,0)
    return b
def oracle(original):
    b=bytearray(original)
    if len(b)<192:return 0,b
    cap,n=get(b,0),get(b,8)
    if cap>65536 or n>512 or 192+cap+48*n!=len(b):return 0,b
    base=160+48*n
    put(b,base,cap);put(b,base+8,0)
    def blocks():
        off=16
        while off<16+get(b,base+8):
            yield off
            off+=32+get(b,base+off)
    def find(ptr):
        return next((o for o in blocks() if o+32==ptr and get(b,base+o+16)),0)
    def alloc(size):
        if not 0<size<=65536:return 0
        aligned=(size+7)//8*8
        off=next((o for o in blocks() if not get(b,base+o+16) and get(b,base+o)>=aligned),0)
        used=get(b,base+8)
        if not off:
            if aligned+32>cap-used:return 0
            off=16+used;put(b,base+off,aligned);put(b,base+8,used+aligned+32)
        elif get(b,base+off)>=aligned+40:
            remainder=get(b,base+off)-aligned-32;other=base+off+32+aligned
            struct.pack_into('<4Q',b,other,remainder,0,0,0);put(b,base+off,aligned)
        put(b,base+off+8,size);put(b,base+off+16,1);put(b,base+off+24,0)
        b[base+off+32:base+off+32+get(b,base+off)]=bytes(get(b,base+off))
        return off+32
    def free(ptr):
        off=find(ptr)
        if not off or get(b,base+off+24):return 0
        put(b,base+off+16,0);put(b,base+off+8,0)
        layout=[(o,get(b,base+o),bool(get(b,base+o+16))) for o in blocks()]
        groups=[];last=0
        for o,size,live in layout:
            if live:last=o-16+32+size
            if groups and not live and not groups[-1][2]:
                previous,old,_=groups[-1];groups[-1]=(previous,old+32+size,False)
            else:groups.append((o,size,live))
        for o,size,live in groups:
            if not live:struct.pack_into('<4Q',b,base+o,size,0,0,0)
        put(b,base+8,last);return 1
    def resize(ptr,size):
        off=find(ptr)
        if not off or get(b,base+off+24) or not 0<size<=65536:return 0
        old=get(b,base+off+8)
        if size<=get(b,base+off):
            if size>old:b[base+ptr+old:base+ptr+size]=bytes(size-old)
            put(b,base+off+8,size);return ptr
        aligned=(size+7)//8*8;used=get(b,base+8);capacity=get(b,base+off)
        if off-16+32+capacity==used and aligned-capacity<=cap-used:
            b[base+ptr+old:base+ptr+aligned]=bytes(aligned-old)
            put(b,base+off,aligned);put(b,base+off+8,size);put(b,base+8,used+aligned-capacity)
            return ptr
        fresh=alloc(size)
        if not fresh:return 0
        b[base+fresh:base+fresh+old]=b[base+ptr:base+ptr+old]
        free(ptr);return fresh
    for i in range(n):
        op=160+48*i;code,slot,val,aux=struct.unpack_from('<4Q',b,op);result=0
        if slot<16:
            entry=32+8*slot;ptr=get(b,entry);off=find(ptr)
            if code==1:
                result=alloc(val)
                if result:put(b,entry,result)
            elif code==2:
                result=resize(ptr,val)
                if result:put(b,entry,result)
            elif code==3:
                result=free(ptr)
                if result:put(b,entry,0)
            elif code in (4,5) and off:
                pins=get(b,base+off+24)
                if (code==4 and pins<65536) or (code==5 and pins):
                    put(b,base+off+24,pins+(1 if code==4 else -1));result=1
            elif code==6 and off and val<get(b,base+off+8):
                b[base+ptr+val]=aux&255;result=1
            elif code==7:result=int(bool(find((ptr+val)&MASK)))
            elif code==8:
                need=val+9;size=get(b,base+off) if off else 8
                valid=val<=65536 and need<=65536
                valid &= (not ptr and val==0) or (bool(off) and not get(b,base+off+24) and val<get(b,base+off+8))
                if valid:
                    while size<need:size*=2
                    result=alloc(size) if not ptr else resize(ptr,size)
                    if result:
                        source=bytes(b[op+24:op+32]).upper()
                        b[base+result+val:base+result+val+8]=source
                        b[base+result+val+8]=0;put(b,entry,result)
        put(b,op+32,result);put(b,op+40,get(b,base+8))
    put(b,16,1);put(b,24,get(b,base+8))
    return 1,b
def vectors():
    cases=[]
    def add(name,cap,ops):cases.append((name,packet(cap,ops)))
    add('growth-preserves',512,[(1,0,7,0),(6,0,0,97),(6,0,6,255),(2,0,40,0),(2,0,4,0),(2,0,7,0),(3,0,0,0)])
    add('pinned-lifetime',256,[(1,0,8,0),(4,0,0,0),(4,0,0,0),(2,0,9,0),(3,0,0,0),(5,0,0,0),(3,0,0,0),(5,0,0,0),(5,0,0,0),(3,0,0,0),(3,0,0,0)])
    add('reuse-and-coalesce-tail',256,[(1,0,8,0),(1,1,16,0),(1,2,8,0),(3,1,0,0),(1,3,8,0),(3,3,0,0),(3,2,0,0),(3,0,0,0),(1,0,64,0)])
    add('oom-preserves',80,[(1,0,8,0),(6,0,0,99),(2,0,49,0),(1,1,1,0),(6,0,0,120),(3,0,0,0)])
    add('interior-and-invalid',256,[(2,0,8,0),(3,0,0,0),(1,0,8,0),(7,0,1,0),(7,0,MASK,0),(7,0,0,0),(6,0,8,123),(1,16,8,0),(9,0,0,0)])
    for size in (0,1,7,8,9,65536,65537,1<<63,MASK):add('size-'+str(size),256,[(1,0,size,0),(2,0,size,0)])
    for cap in (0,31,32,39,40,41,256):add('capacity-'+str(cap),cap,[(1,0,1,0),(3,0,0,0)])
    for n in (1,2,8,32,128):
        chunks=[bytes((97+(i+j)%26 for j in range(8))) for i in range(n)]
        add('incremental-text-'+str(n),8192,[(8,0,i*8,int.from_bytes(chunk,'little')) for i,chunk in enumerate(chunks)])
    add('text-oom',128,[(8,0,i*8,int.from_bytes(b'abCd\x00\xffz!','little')) for i in range(16)])
    add('text-pinned',512,[(8,0,0,int.from_bytes(b'abcdefgh','little')),(4,0,0,0),(8,0,8,int.from_bytes(b'ijklmnop','little')),(5,0,0,0),(8,0,8,int.from_bytes(b'ijklmnop','little'))])
    add('tail-grow-exact',80,[(1,0,8,0),(6,0,0,123),(2,0,48,0),(6,0,47,255),(2,0,49,0),(3,0,0,0)])
    add('tail-grow-pinned',128,[(1,0,8,0),(4,0,0,0),(2,0,64,0),(3,0,0,0),(5,0,0,0),(2,0,64,0)])
    add('non-tail-relocation',512,[(1,0,8,0),(6,0,0,123),(1,1,8,0),(2,0,40,0),(6,1,7,255),(3,1,0,0),(3,0,0,0)])
    add('split-three',256,[(1,0,128,0),(6,0,64,255),(1,1,16,0),(3,0,0,0),(1,2,16,0),(1,3,16,0),(1,4,32,0),(6,1,0,77)])
    for size in (40,48,56,64,80):
        add('split-threshold-'+str(size),256,[(1,0,size,0),(1,1,8,0),(3,0,0,0),(1,2,8,0),(1,3,8,0)])
    for order in ((1,2),(2,1)):
        add('coalesce-'+str(order),384,[(1,0,16,0),(1,1,64,0),(1,2,64,0),(1,3,16,0),(3,order[0],0,0),(3,order[1],0,0),(1,4,128,0),(6,0,0,65),(6,3,15,66)])
    add('coalesce-pin-neighbor',512,[(1,0,16,0),(1,1,64,0),(1,2,64,0),(1,3,16,0),(4,3,0,0),(3,1,0,0),(3,2,0,0),(1,4,128,0),(2,3,32,0),(3,3,0,0),(5,3,0,0),(3,4,0,0)])
    add('merge-middle-stale',512,[(1,0,8,0),(1,1,64,0),(1,2,64,0),(1,3,8,0),(3,1,0,0),(3,2,0,0),(7,2,0,0),(1,4,128,0),(7,2,0,0)])
    rng=random.Random(42043)
    for i in range(60):
        ops=[(rng.randrange(1,8),rng.randrange(16),rng.choice([0,1,7,8,16,40,100,MASK]),rng.randrange(256)) for _ in range(120)]
        add('random-'+str(i),rng.choice([128,512,2048]),ops)
    data=packet(128,[]);put(data,0,MASK);cases.append(('invalid-capacity',data))
    data=packet(128,[]);put(data,8,513);cases.append(('invalid-command-count',data))
    cases.append(('short',bytearray(64)))
    return cases
def main():
    p=argparse.ArgumentParser();p.add_argument('--assembly-directory',type=Path);p.add_argument('--output',type=Path,default=ROOT/'build/arena');a=p.parse_args()
    out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    sources=['corpus/libft/arena.ubc','prototypes/isolation/ubytec/arena/arena.ubc']
    sources += ['prototypes/isolation/'+n for n in ('run_arena.py','arena_text_cli.py','run.py','linux/program.c','linux/modules.c','linux/contracts.h','linux/many-service.h','linux/many-wire.h','linux/isolation.c','linux/bridge-runtime.c','linux/module.ld','common/contract.h')]
    report={'schema':1,'accepted':False,'platform':platform.platform(),'source_sha256':{s:hashlib.sha256((REPO/s).read_bytes()).hexdigest() for s in sources},'tests':{}}
    try:
        library=(REPO/'corpus/libft/arena.ubc').read_text().split('{',1)[1].rsplit('}',1)[0]
        if library not in (ROOT/'ubytec/arena/arena.ubc').read_text():raise RuntimeError('Library fixture drift')
        asm=out/'arena.nasm'
        if a.assembly_directory:shutil.copyfile(a.assembly_directory/'arena.nasm',asm)
        else:
            command(['dotnet','build',REPO/'Ubytec/Ubytec.csproj','-c','Release','-p:EnableDocFxOnBuild=false','-p:GenerateDocumentationFile=false','--nologo'])
            command(['dotnet',REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',ROOT/'ubytec/arena/arena.ubc','--library','-o',asm])
        report['assembly_sha256']=hashlib.sha256(asm.read_bytes()).hexdigest()
        command(['nasm','-f','elf64',asm,'-o',out/'arena.o'])
        command(['ld','-T',ROOT/'linux/module.ld','-e','ubytec_host_contract_ArenaTest','-z','noexecstack',out/'arena.o','-o',out/'arena.elf'])
        for cc in ('gcc','clang'):
            loader=out/('arena-'+cc);command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror',ROOT/'linux/program.c','-o',loader])
            rows=[]
            for name,data in vectors():
                expected_value,expected=oracle(data);inp=out/'input.bin';actual=out/'actual.bin';inp.write_bytes(data)
                proc=subprocess.run([str(loader),'--contracts',str(out/'arena.elf'),'ArenaTest','--input',str(inp),'--output',str(actual)],capture_output=True,text=True,timeout=10)
                rs=records(proc.stdout);r=next((r for r in rs if r.get('case')=='program'),{})
                if proc.returncode or not r.get('pass') or r.get('value')!=expected_value:raise RuntimeError(name+': '+proc.stdout+proc.stderr)
                got=actual.read_bytes()
                if got!=expected:
                    pos=next((i for i,(x,y) in enumerate(zip(got,expected)) if x!=y),min(len(got),len(expected)))
                    raise RuntimeError(f'{cc} {name}: byte {pos}: actual={got[pos:pos+16].hex()} expected={expected[pos:pos+16].hex()}')
                rows.append({'case':name,'pass':True})
            texts=[b'',b' hola, mundo ,, ubytec ',b'abcdefgh',b'a\x00z\xff\x80b',b'abcd'*1024]
            text_cases=[('text-'+str(i)+'-chunk-'+str(chunk),text,32768,chunk,len(text)) for i,text in enumerate(texts) for chunk in (1,7,64,256)]
            text_cases += [('text-no-memory',b'hello',0,1,-1),('text-growth-oom',b'abcdefghijklmnopqrstuvwxyz'*8,128,7,-1)]
            for name,text,capacity,chunk,value in text_cases:
                data=bytearray([0xa5])*(64+len(text)+capacity)
                struct.pack_into('<4Q',data,0,len(text),capacity,chunk,0)
                data[32:32+len(text)]=text;inp.write_bytes(data)
                proc=subprocess.run([str(loader),'--contracts',str(out/'arena.elf'),'TextGrow','--input',str(inp),'--output',str(actual)],capture_output=True,text=True,timeout=10)
                r=next((r for r in records(proc.stdout) if r.get('case')=='program'),{})
                got=actual.read_bytes()
                expected_text=text.upper() if value>=0 else text
                if proc.returncode or not r.get('pass') or r.get('value')!=value or len(got)!=len(data) or got[:24]!=data[:24] or get(got,24)!=(value&MASK) or got[32:32+len(text)]!=expected_text or got[-16:]!=bytes([0xa5])*16:
                    raise RuntimeError(cc+' '+name+': '+proc.stdout+proc.stderr)
                rows.append({'case':name,'pass':True})
            report['tests'][cc]=rows;print(f'{cc}: PASS {len(rows)} arena/application cases',flush=True)
        example=out/'example.txt';output=out/'example-output.txt';example.write_bytes(b' hola, mundo ,, ubytec ')
        command(['python3',ROOT/'arena_text_cli.py','--artifacts',out,'--input',example,'--output',output,'--chunk',1])
        if output.read_bytes()!=example.read_bytes().upper():raise RuntimeError('file driver result')
        output.write_bytes(b'KEEP')
        failure=subprocess.run(['python3',str(ROOT/'arena_text_cli.py'),'--artifacts',str(out),'--input',str(example),'--output',str(output),'--capacity','0'],capture_output=True,timeout=10)
        if not failure.returncode or output.read_bytes()!=b'KEEP':raise RuntimeError('file driver failed publication')
        report['file_driver']={'success':True,'oom_preserves_output':True}
        report['accepted']=True
    finally:(out/'arena-report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
