#!/usr/bin/env python3
"""Paired baseline/stack-transfer measurements using one compiler and identical inputs."""
import argparse,json,re,shutil,statistics
from pathlib import Path
import run_text_diagnostics as diag
bench=diag.bench;ROOT=diag.ROOT;REPO=diag.REPO

def sources():
    return {kind+'-'+mode:source for kind,source in diag.sources().items() for mode in ('plain','optimized')}

def manifest():
    result=diag.manifest()
    for path in ('corpus/libft/run_stack_transfers.py','Ubytec.Tests/StackTransferTests.cs','Ubytec.Tests/FrameValueTests.cs'):
        result[path]=bench.sha(REPO/path)
    return dict(sorted(result.items()))

def main():
    p=argparse.ArgumentParser();p.add_argument('--frame-values',action='store_true',help='Compare transfers alone against transfers plus frame forwarding.');p.add_argument('--compile-only',action='store_true');p.add_argument('--dotnet',default='dotnet');p.add_argument('--assembly-directory',type=Path);p.add_argument('--output',type=Path,default=ROOT/'build/stack-transfers');a=p.parse_args()
    out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    report={'accepted':False,'frame_values':a.frame_values,'source_sha256':manifest(),'assembly_sha256':{},'composed_source_sha256':{},'kernels':{},'text':{},'assembly_analysis':{},'warmup':5,'samples':30}
    try:
        if not a.assembly_directory:bench.command([a.dotnet,'build',REPO/'Ubytec/Ubytec.csproj','-c','Release','-p:EnableDocFxOnBuild=false','-p:GenerateDocumentationFile=false','--nologo'])
        for name,source in sources().items():
            src=out/(name+'.ubc');asm=out/(name+'.nasm');src.write_text(source,encoding='utf-8')
            if a.assembly_directory:
                staged=a.assembly_directory
                assert (staged/src.name).read_text(encoding='utf-8')==source
                shutil.copyfile(staged/src.name,src);shutil.copyfile(staged/asm.name,asm)
            else:
                flags=['--host-io'] if name.startswith('diag-native') else ['--library']
                if name.endswith('optimized') or a.frame_values:flags+=['--stack-transfers']
                if name.endswith('optimized') and a.frame_values:flags+=['--frame-values']
                for export in bench.EXPORTS if name.startswith('diag-native') else diag.KERNELS:flags+=['--host-export',export+'=ubytec_host_contract_'+export]
                bench.command([a.dotnet,REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',src,*flags,'-o',asm])
            report['assembly_sha256'][name]=bench.sha(asm);report['composed_source_sha256'][name]=bench.sha(src)
            report['assembly_analysis'][name]={fname:{'push_pop_static':len(re.findall(r'^\s*(?:push|pop)\b',body,re.M)),'frame_reads_static':len(re.findall(r'mov \w+, qword \[rbp [+-] \d+\]',body)),'retained_stack_stores':len(re.findall(r'mov qword \[rsp - 8\]',body))} for fname,_,body in diag.functions(asm.read_text())}
        if a.assembly_directory:
            proof=json.loads((a.assembly_directory/'stack-provenance.json').read_text())
            assert proof.get('frame_values',False)==a.frame_values
            for key in ('source_sha256','assembly_sha256','composed_source_sha256'):assert proof[key]==report[key],key
            report['compiler_sha256']=proof['compiler_sha256']
        else:report['compiler_sha256']=bench.sha(REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll')
        proof={k:report[k] for k in ('source_sha256','assembly_sha256','composed_source_sha256','compiler_sha256','frame_values')}
        (out/'stack-provenance.json').write_text(json.dumps(proof,indent=2)+'\n')
        if a.compile_only:return
        report['environment']={'platform':bench.platform.platform(),'is_wsl':'microsoft' in bench.platform.release().lower()}
        for name in sources():bench.command(['nasm','-f','elf64',out/(name+'.nasm'),'-o',out/(name+'.o')])
        for cc in ('gcc','clang'):
            flags=['-fno-tree-vectorize'] if cc=='gcc' else ['-fno-vectorize','-fno-slp-vectorize']
            provider=out/('provider-'+cc+'.o');bench.command([cc,'-std=c11','-O2',*flags,'-Wall','-Wextra','-Werror','-c',ROOT/'diagnose-kernels.c','-o',provider])
            assert not bench.command(['nm','-u',provider]).strip()
            disasm=bench.command(['objdump','-dr','-Mintel',provider]);assert not re.search(r'\b[xyz]mm\d+',disasm)
            (out/('provider-'+cc+'.txt')).write_text(disasm)
            paired={}
            for mode in ('plain','optimized'):
                exe=out/('kernels-'+cc+'-'+mode);bench.command([cc,'-std=c11','-O2',*flags,'-no-pie',ROOT/'diagnose-client.c',provider,out/('diag-kernels-'+mode+'.o'),'-o',exe])
                raw=bench.command([exe]);(out/(exe.name+'.jsonl')).write_text(raw);paired[mode]=diag.summarize(raw)
                native=out/('native-'+cc+'-'+mode);bench.command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror','-no-pie',ROOT/'text-benchmark.c',out/('diag-native-'+mode+'.o'),'-o',native])
            report['kernels'][cc]={k:{'plain':paired['plain'][k],'optimized':paired['optimized'][k],'speedup':paired['plain'][k]['ubytec']['median_ns_per_call']/paired['optimized'][k]['ubytec']['median_ns_per_call']} for k in paired['plain']}
            print(cc+': PASS 16 paired scalar kernels, 30 samples',flush=True)
        oracle=out/'oracle';bench.command(['gcc','-O2',ROOT/'text-reference.c','-o',oracle])
        selected={'4096-v4-uniform-b4096','4096-v256-uniform-b4096','65536-v64-uniform-b4096'}
        for name,raw,chunk,parameters in bench.corpus():
            if name not in selected:continue
            src=out/(name+'.bin');src.write_bytes(raw);expected=out/(name+'.expected');reference=json.loads(bench.command([oracle,src,expected]))
            case={'parameters':parameters,'input_sha256':bench.sha(src),'expected_sha256':bench.sha(expected),'variants':{}}
            for cc in ('gcc','clang'):
                modes={}
                for mode in ('plain','optimized'):
                    rows=bench.native(out/('native-'+cc+'-'+mode),'ubytec',src,expected,chunk,5,30)
                    assert all(r['unique']==reference['unique'] and r['arena_used_after']==0 for r in rows)
                    (out/(name+'.'+cc+'.'+mode+'.jsonl')).write_text(''.join(json.dumps(r)+'\n' for r in rows))
                    modes[mode]={phase:bench.stats([r[phase+'_ns'] for r in rows]) for phase in ('feed','sort','emit')}
                case['variants'][cc]={'modes':modes,'feed_speedup':modes['plain']['feed']['median_ns']/modes['optimized']['feed']['median_ns']}
            report['text'][name]=case;print(name+': PASS paired text phases and cleanup',flush=True)
        report['accepted']=True
    finally:(out/'stack-report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
if __name__=='__main__':main()
