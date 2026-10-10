#!/usr/bin/env python3
"""Diagnose analyzer/library costs and compare equivalent scalar C/Ubytec kernels."""
import argparse,json,math,re,shutil,statistics
from pathlib import Path
import run_text_benchmark as bench
ROOT=bench.ROOT;REPO=bench.REPO
KERNELS=('DiagIdentity','DiagBytes','DiagRecords','DiagLookup')

def sources():return {'diag-native':bench.sources()['bench-native'],'diag-kernels':(ROOT/'diagnose-kernels.ubc').read_text(encoding='utf-8')}
def manifest():
    paths=set(bench.manifest());paths.update('corpus/libft/'+n for n in ('diagnose-kernels.ubc','diagnose-kernels.c','diagnose-client.c','diagnose-profile.h','run_text_diagnostics.py'))
    return {n:bench.sha(REPO/n) for n in sorted(paths)}
def functions(asm):
    starts=list(re.finditer(r'^\s*(func_([0-9A-F]+)_([0-9a-f]{32})_start):\s*$',asm,re.M))
    result=[]
    for i,m in enumerate(starts):
        body=asm[m.start():starts[i+1].start() if i+1<len(starts) else len(asm)]
        end=re.search(re.escape(m[1][:-5]+'end')+r':.*?^\s*ret\s*$',body,re.M|re.S)
        assert end,'Common epilogue must end with ret'
        result.append((bytes.fromhex(m[2]).decode(),m[1],body[:end.end()]))
    return result
def hook(id,which):
    registers=['rax','rcx','rdx','rsi','rdi','r8','r9','r10','r11','rbp']
    return '\n pushfq\n'+''.join(' push '+r+'\n' for r in registers)+' mov rbp,rsp\n and rsp,-16\n mov edi,'+str(id)+'\n call profile_'+which+'\n mov rsp,rbp\n'+''.join(' pop '+r+'\n' for r in reversed(registers))+' popfq\n'
def instrument(asm):
    assert not re.search(r'\b[xyz]mm\d+',asm),'Only integer NASM fixtures can use these hooks'
    names=[]
    for id,(name,label,_) in enumerate(functions(asm)):
        names.append(name)
        asm=re.sub(r'(^\s*'+label+r':\s*$)',lambda m:m[0]+hook(id,'enter'),asm,count=1,flags=re.M)
        end=label[:-5]+'end'
        asm=re.sub(r'(^\s*'+end+r':\s*$)',lambda m:m[0]+hook(id,'exit'),asm,count=1,flags=re.M)
    assert len(names)<128
    original=next(body for name,label,body in functions(asm) if name=='ArenaFind')
    changed,n=re.subn(r'(^\s*j[a-z]+\s+\S*end_while_\d+[^\n]*\n)',r'\1 pushfq\n inc qword [rel profile_arena_visits]\n popfq\n',original,count=1,flags=re.M)
    assert n==1,'ArenaFind body-loop boundary must be verified'
    return 'extern profile_enter,profile_exit,profile_arena_visits\n'+asm.replace(original,changed,1),names

def summarize(raw):
    rows=[json.loads(line) for line in raw.splitlines()];groups={}
    for row in rows:groups.setdefault((row['case'],row['implementation']),[]).append(row)
    assert len(groups)==32
    result={}
    for (case,implementation),samples in groups.items():
        assert len(samples)==30 and len({r['result'] for r in samples})==1
        values=[r['ns']/r['batch'] for r in samples]
        result.setdefault(case,{})[implementation]={'median_ns_per_call':statistics.median(values),'p95_ns_per_call':sorted(values)[28],'batch':samples[0]['batch'],'samples_batch_ns':[r['ns'] for r in samples],'result':samples[0]['result']}
    for case,variants in result.items():
        assert variants['ubytec']['result']==variants['c']['result']
        variants['ratio_ubytec_over_c']=variants['ubytec']['median_ns_per_call']/variants['c']['median_ns_per_call']
    return result

def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--output',type=Path,default=ROOT/'build/text-diagnostics');parser.add_argument('--dotnet',default='dotnet');parser.add_argument('--assembly-directory',type=Path);parser.add_argument('--compile-only',action='store_true');args=parser.parse_args()
    out=args.output.resolve();out.mkdir(parents=True,exist_ok=True)
    report={'schema':1,'accepted':False,'source_sha256':manifest(),'assembly_sha256':{},'composed_source_sha256':{},'kernels':{},'profiles':{},'assembly_analysis':{},'limitations':['Profiling hooks perturb execution; their exclusive times exclude instrumented children but include instrumentation overhead. No timing subtraction is a causal counterfactual.','Equivalent kernels use valid pointers, fixed 24-byte records, scalar byte loops and unsigned wrap; no vector/arena validation, allocation, libc comparisons or supervisor in either implementation.','C scalar optimizations remain enabled; vectorization and LTO are disabled. Ubytec timings include its public System V adapter and internal stack ABI; identity quantifies call overhead separately.','WSL timings are not bare-metal performance; this diagnostic changes no production library/compiler behavior.']}
    try:
        if not args.assembly_directory:bench.command([args.dotnet,'build',REPO/'Ubytec/Ubytec.csproj','-c','Release','-p:EnableDocFxOnBuild=false','-p:GenerateDocumentationFile=false','--nologo'])
        for name,source in sources().items():
            src=out/(name+'.ubc');asm=out/(name+'.nasm');src.write_text(source,encoding='utf-8')
            if args.assembly_directory:
                staged=args.assembly_directory
                if (staged/src.name).read_text(encoding='utf-8')!=source:raise RuntimeError('Source drift: '+name)
                shutil.copyfile(staged/src.name,src);shutil.copyfile(staged/asm.name,asm)
            else:
                flags=['--host-io'] if name=='diag-native' else ['--library']
                for export in bench.EXPORTS if name=='diag-native' else KERNELS:flags+=['--host-export',export+'=ubytec_host_contract_'+export]
                bench.command([args.dotnet,REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',src,*flags,'-o',asm])
            report['assembly_sha256'][name]=bench.sha(asm);report['composed_source_sha256'][name]=bench.sha(src)
            analysis={}
            for fname,label,body in functions(asm.read_text(encoding='utf-8')):
                instructions=re.findall(r'^\s*(push|pop|call|mov|add|sub|cmp|test|j\w+|ret|inc|mul|imul|lea|xor|and|set\w+|movzx|shl|shr|sar)\b',body,re.M)
                analysis[fname]={'label':label,'instructions_static':len(instructions),'push_pop_static':sum(i in ('push','pop') for i in instructions),'calls_static':sum(i=='call' for i in instructions)}
            report['assembly_analysis'][name]=analysis
        if args.assembly_directory:
            proof=json.loads((args.assembly_directory/'diagnostic-provenance.json').read_text(encoding='utf-8-sig'))
            for key in ('source_sha256','assembly_sha256','composed_source_sha256'):
                if proof[key]!=report[key]:raise RuntimeError('Provenance drift: '+key)
            report['compiler_sha256']=proof['compiler_sha256']
        else:report['compiler_sha256']=bench.sha(REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll')
        (out/'diagnostic-provenance.json').write_text(json.dumps({k:report[k] for k in ('source_sha256','assembly_sha256','composed_source_sha256','compiler_sha256')},indent=2)+'\n',encoding='utf-8')
        if args.compile_only:return
        report['environment']={cc:bench.command([cc,'--version']).splitlines()[0] for cc in ('gcc','clang')};report['environment']['platform']=bench.platform.platform();report['environment']['is_wsl']='microsoft' in bench.platform.release().lower()
        for name in sources():bench.command(['nasm','-f','elf64',out/(name+'.nasm'),'-o',out/(name+'.o')])
        profiled,names=instrument((out/'diag-native.nasm').read_text(encoding='utf-8'));(out/'diag-profile.nasm').write_text(profiled,encoding='utf-8');report['profile_assembly_sha256']=bench.sha(out/'diag-profile.nasm');report['profile_function_ids']=names
        bench.command(['nasm','-f','elf64',out/'diag-profile.nasm','-o',out/'diag-profile.o'])
        client=(ROOT/'text-benchmark.c').read_text(encoding='utf-8').replace('#define F(n)','#include "diagnose-profile.h"\n#define F(n)',1)
        client=client.replace('uint64_t start=clock_ns();int ok=1;','profile_reset();uint64_t start=clock_ns();int ok=1;',1).replace('uint64_t feed=clock_ns()-start;require(ok);','uint64_t feed=clock_ns()-start;require(ok);profile_enabled=0;profile_dump();',1)
        assert client.count('profile_reset();')==1 and client.count('profile_dump();')==1
        (out/'profile-client.c').write_text(client,encoding='utf-8');report['derived_client_sha256']=bench.sha(out/'profile-client.c')
        for cc in ('gcc','clang'):
            flags=['-fno-tree-vectorize'] if cc=='gcc' else ['-fno-vectorize','-fno-slp-vectorize']
            provider=out/('kernels-'+cc+'.o');bench.command([cc,'-std=c11','-O2',*flags,'-Wall','-Wextra','-Werror','-c',ROOT/'diagnose-kernels.c','-o',provider])
            undefined=bench.command(['nm','-u',provider]).strip()
            assert not undefined,'Comparable C kernels must not call runtime/libc helpers: '+undefined
            scalar=bench.command(['objdump','-dr','-Mintel',provider]);assert not re.search(r'\b[xyz]mm\d+',scalar),'C provider must remain scalar'
            (out/('provider-'+cc+'.txt')).write_text(scalar,encoding='utf-8')
            report.setdefault('scalar_audit',{})[cc]={'undefined_symbols':undefined,'vector_registers':False,'provider_sha256':bench.sha(provider),'disassembly_sha256':bench.sha(out/('provider-'+cc+'.txt')),'flags':['-O2',*flags],'lto':False}
            exe=out/('kernels-'+cc);bench.command([cc,'-std=c11','-O2',*flags,'-Wall','-Wextra','-Werror','-no-pie',ROOT/'diagnose-client.c',provider,out/'diag-kernels.o','-o',exe])
            raw=bench.command([exe]);(out/('kernels-'+cc+'.jsonl')).write_text(raw,encoding='utf-8');report['kernels'][cc]=summarize(raw)
            disassembly=bench.command(['objdump','-dr','-Mintel',exe]);(out/('disassembly-'+cc+'.txt')).write_text(disassembly,encoding='utf-8')
            # Kernel correctness also covers wrap, empty spans and length mismatch.
            print(cc+': PASS 16 equivalent kernels, 5 warmups + 30 samples',flush=True)
        for mode,obj in (('profile','diag-profile'),('baseline','diag-native')):
            exe=out/mode;bench.command(['gcc','-std=c11','-O2','-Wall','-Wextra','-Werror','-I',ROOT,'-no-pie',out/'profile-client.c' if mode=='profile' else ROOT/'text-benchmark.c',out/(obj+'.o'),'-o',exe])
        oracle=out/'oracle';bench.command(['gcc','-std=c11','-O2','-Wall','-Wextra','-Werror',ROOT/'text-reference.c','-o',oracle])
        selected={'4096-v4-uniform-b4096','4096-v64-uniform-b4096','4096-v256-uniform-b4096','65536-v256-uniform-b4096'}
        for name,raw,chunk,parameters in bench.corpus():
            if name not in selected:continue
            src=out/(name+'.bin');src.write_bytes(raw);expected=out/(name+'.expected');reference=json.loads(bench.command([oracle,src,expected]));rows={}
            for mode in ('baseline','profile'):
                output=bench.command([out/mode,'ubytec',src,expected,chunk,0,1]);(out/(name+'.'+mode+'.jsonl')).write_text(output,encoding='utf-8');events=[json.loads(line) for line in output.splitlines()];sample=events[-1]
                assert sample['output_matches'] and sample['arena_used_after']==0 and sample['unique']==reference['unique']
                rows[mode]=sample
                if mode=='profile':
                    event=events[0];assert event['event']=='profile';event['functions']=[{'name':names[f['id']],**f} for f in event['functions']]
                    event['edges']=[{**e,'caller_name':names[e['caller']] if e['caller']<128 else '<root>','callee_name':names[e['callee']]} for e in event['edges']]
                    rows['profile_details']=event
            report['profiles'][name]={'parameters':parameters,'reference':reference,'input_sha256':bench.sha(src),'expected_sha256':bench.sha(expected),**rows}
            print(name+': PASS profiling and unchanged baseline match C, arena released',flush=True)
        # Only C code is sanitizer-instrumented. NASM is checked by result comparisons.
        provider=out/'kernels-sanitized.o';san=['-O1','-g','-fsanitize=address,undefined','-fno-sanitize-recover=all','-fno-omit-frame-pointer']
        bench.command(['gcc','-std=c11',*san,'-c',ROOT/'diagnose-kernels.c','-o',provider]);exe=out/'kernels-sanitized';bench.command(['gcc','-std=c11',*san,'-no-pie',ROOT/'diagnose-client.c',provider,out/'diag-kernels.o','-o',exe]);raw=bench.command([exe]);(out/'kernels-sanitized.jsonl').write_text(raw,encoding='utf-8');summarize(raw);report['sanitizer']={'accepted':True,'scope':'C provider/client only; generated NASM not instrumented; sanitizer timings are not performance comparisons.'}
        report['accepted']=True
    finally:(out/'diagnostic-report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
if __name__=='__main__':main()
