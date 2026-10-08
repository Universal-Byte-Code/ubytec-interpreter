#!/usr/bin/env python3
"""Measure closed nested lookup lowering, exact faults and unchanged real applications."""
import argparse,json,platform,re,statistics,subprocess,hashlib,math
from pathlib import Path
import run_text_diagnostics as diag
ROOT=diag.ROOT;REPO=diag.REPO
def command(args):
    p=subprocess.run([str(a) for a in args],capture_output=True,text=True,timeout=240)
    if p.returncode:raise RuntimeError(p.stdout+p.stderr)
    return p.stdout
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def stats(samples):
    samples=sorted(samples)
    return {'median_ns':statistics.median(samples),'p95_ns':samples[math.ceil(len(samples)*.95)-1],'samples':samples}
def measure_text(a,compiler,out,report):
    bench=diag.bench
    exports={'ArenaInit':2,'ArenaAlloc':2,'VectorInit':3,'TextFeed':5,'TextFlush':3,'TextCleanup':3,'BenchSort':2,'BenchEmit':4}
    fields=';'.join('uint64_t (*'+name+')('+','.join(['uint64_t']*n)+')' for name,n in exports.items())+';'
    declarations='\n'.join('extern uint64_t ubytec_host_'+mode+'_'+name+'('+','.join(['uint64_t']*n)+');' for mode in ('plain','registers') for name,n in exports.items())
    tables=','.join('{'+','.join('ubytec_host_'+mode+'_'+name for name in exports)+'}' for mode in ('plain','registers'))
    client=(ROOT/'text-benchmark.c').read_text()
    start=client.index('#define F(n)');end=client.index('struct vector',start)
    client=client[:start]+declarations+'\nstruct variant {'+fields+'};\nstatic const struct variant variants[]={'+tables+'};\n#define F(n) selected.n\n'+client[end:]
    old='int native=!strcmp(argv[1],"ubytec");require(native||!strcmp(argv[1],"c-linear"));'
    assert old in client
    client=client.replace(old,'int native=1;require(!strcmp(argv[1],"paired"));')
    old='for(unsigned iteration=0;iteration<warm+samples;iteration++){'
    client=client.replace(old,old[:-1]+' for(unsigned order=0;order<2;order++){\n  unsigned variant=(iteration+order)%2; const struct variant selected=variants[variant];')
    old=r'printf("{\"sample\":%u,'
    assert old in client
    client=client.replace(old,r'printf("{\"implementation\":\"%s\",\"sample\":%u,')
    client=client.replace('iteration-warm,feed,sort,emit,unique,peak,usage.ru_maxrss','variant?"registers":"plain",iteration-warm,feed,sort,emit,unique,peak,usage.ru_maxrss')
    derived=out/'text-paired-client.c';derived.write_text(client);report['derived_text_client_sha256']=sha(derived)
    source=bench.sources()['bench-native']
    for mode in ('plain','registers'):
        src=out/('text-'+mode+'.ubc');src.write_text(source);asm=out/('text-'+mode+'.nasm')
        flags=['--host-io','--stack-transfers','--frame-registers']+(['--effect-registers'] if mode=='registers' else [])
        for name in exports:flags+=['--host-export',name+'=ubytec_host_'+mode+'_'+name]
        command([a.dotnet,compiler,src,*flags,'-o',asm]);report['assembly_sha256']['text-'+mode]=sha(asm)
        report['source_sha256']['composed/text-'+mode]=sha(src)
        report.setdefault('text_functions',{})[mode]={name:{'cached':'; frame-registers:' in body or '; effect-registers: write-through' in body,'effect_copies':'; effect-registers: write-through' in body,'reloads':body.count('; effect-registers: reload'),'frame_reads_static':len(re.findall(r'mov \w+, qword \[rbp [+-] \d+\]',body))} for name,_,body in diag.functions(asm.read_text())}
        report.setdefault('text_effect_register_functions',{})[mode]=asm.read_text().count('; effect-registers: write-through')
        command(['nasm','-f','elf64',asm,'-o',out/('text-'+mode+'.o')])
    for cc in ('gcc','clang'):
        command([cc,'-O2','-Wall','-Wextra','-Werror','-no-pie',derived,out/'text-plain.o',out/'text-registers.o','-o',out/('text-'+cc)])
    oracle=out/'text-oracle';command(['gcc','-O2',ROOT/'text-reference.c','-o',oracle])
    report['text']={}
    wanted={'4096-v4-uniform-b4096','4096-v256-uniform-b4096','65536-v64-uniform-b4096'}
    for name,data,chunk,parameters in bench.corpus():
        if name not in wanted:continue
        src=out/(name+'.bin');src.write_bytes(data);expected=out/(name+'.expected');reference=json.loads(command([oracle,src,expected]))
        case={'parameters':parameters,'input_sha256':sha(src),'expected_sha256':sha(expected),'variants':{}}
        for cc in ('gcc','clang'):
            raw=command([out/('text-'+cc),'paired',src,expected,chunk,5,30]);(out/(name+'.'+cc+'.jsonl')).write_text(raw)
            rows=[json.loads(s) for s in raw.splitlines()];assert len(rows)==60
            assert all(r['unique']==reference['unique'] and r['arena_used_after']==0 and r['output_matches'] for r in rows)
            modes={}
            for mode in ('plain','registers'):
                group=[r for r in rows if r['implementation']==mode];assert len(group)==30
                modes[mode]={phase:stats([r[phase+'_ns'] for r in group]) for phase in ('feed','sort','emit')}
            case['variants'][cc]={'modes':modes,'feed_speedup':modes['plain']['feed']['median_ns']/modes['registers']['feed']['median_ns']}
        report['text'][name]=case;print(name+': PASS interleaved text, output and cleanup',flush=True)

def main():
    p=argparse.ArgumentParser();p.add_argument('--dotnet',default='dotnet');p.add_argument('--compiler',type=Path);p.add_argument('--verify-only',action='store_true');p.add_argument('--output',type=Path,default=ROOT/'build/effect-registers');a=p.parse_args()
    out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    compiler=a.compiler or REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll'
    report={'accepted':False,'common_flags':['--stack-transfers','--frame-registers'],'text_modes':{'plain':'common flags','registers':'common flags plus --effect-registers'},'warmup':5,'samples':30,'order':'rotating interleaved in one process','environment':{'platform':platform.platform()},'compiler_sha256':sha(compiler),'source_sha256':diag.manifest(),'assembly_sha256':{},'analysis':{},'kernels':{}}
    for n in ('run_effect_registers.py','frame-register-client.c','effect-register-faults.c','effect-faults.ubc','effect-kernels.ubc','effect-kernels.c'):
        report['source_sha256']['corpus/libft/'+n]=sha(ROOT/n)
    for n in ('EffectRegisterTests.cs','ObservableContractTests.cs'):
        report['source_sha256']['Ubytec.Tests/'+n]=sha(REPO/'Ubytec.Tests'/n)
    try:
        for mode in ('plain','registers'):
            source=out/(mode+'.ubc');source.write_bytes((ROOT/'effect-kernels.ubc').read_bytes());asm=out/(mode+'.nasm')
            flags=['--library','--stack-transfers','--frame-registers']+(['--effect-registers'] if mode=='registers' else [])
            for name in diag.KERNELS:flags+=['--host-export',name+'=ubytec_host_'+('plain_' if mode=='plain' else 'register_')+name]
            command([a.dotnet,compiler,source,*flags,'-o',asm]);report['assembly_sha256'][mode]=sha(asm)
            report['analysis'][mode]={name:{'frame_reads_static':len(re.findall(r'mov \w+, qword \[rbp [+-] \d+\]',body)),'cached':'; frame-registers:' in body or '; effect-registers: write-through' in body,'reloads':body.count('; effect-registers: reload')} for name,_,body in diag.functions(asm.read_text())}
            command(['nasm','-f','elf64',asm,'-o',out/(mode+'.o')])
        for mode in ('plain','registers'):
            flags=['--library','--stack-transfers','--frame-registers']+(['--effect-registers'] if mode=='registers' else [])
            flags+=['--host-export','EffectFault=ubytec_host_'+('plain_' if mode=='plain' else 'register_')+'EffectFault']
            asm=out/('fault-'+mode+'.nasm')
            command([a.dotnet,compiler,ROOT/'effect-faults.ubc',*flags,'-o',asm]);report['assembly_sha256']['fault-'+mode]=sha(asm)
            command(['nasm','-f','elf64',asm,'-o',out/('fault-'+mode+'.o')])
        report['faults']={}
        for cc in ('gcc','clang'):
            exe=out/('faults-'+cc)
            command([cc,'-O2','-Wall','-Wextra','-Werror','-no-pie',ROOT/'effect-register-faults.c',out/'fault-plain.o',out/'fault-registers.o','-o',exe])
            raw=command([exe]);(out/(cc+'-faults.json')).write_text(raw);report['faults'][cc]=json.loads(raw);assert report['faults'][cc]['accepted']
        print('PASS raw store, direct call and indirect call SIGSEGV/SIGBUS ledgers, GCC/Clang hosts',flush=True)
        verify=out/'verify-client.c'
        base=(ROOT/'frame-register-client.c').read_text().replace('iteration<35','iteration<1').replace('for(unsigned iteration=0;', 'batch=1;\n  for(unsigned iteration=0;')
        verify.write_text(base);report['derived_verify_client_sha256']=sha(verify)
        for cc in ('gcc','clang'):
            report['environment'][cc]=command([cc,'--version']).splitlines()[0]
            flags=['-fno-tree-vectorize'] if cc=='gcc' else ['-fno-vectorize','-fno-slp-vectorize']
            provider=out/(cc+'.o');command([cc,'-O2',*flags,'-Wall','-Wextra','-Werror','-c',ROOT/'effect-kernels.c','-o',provider])
            assert not command(['nm','-u',provider]).strip()
            disasm=command(['objdump','-dr','-Mintel',provider]);assert not re.search(r'\b[xyz]mm\d+',disasm)
            (out/(cc+'-reference.txt')).write_text(disasm)
            exe=out/(cc+'-paired');command([cc,'-O2',*flags,'-Wall','-Wextra','-Werror','-no-pie',verify if a.verify_only else ROOT/'frame-register-client.c',provider,out/'plain.o',out/'registers.o','-o',exe])
            raw=command([exe]);(out/(cc+'.jsonl')).write_text(raw);rows=[json.loads(s) for s in raw.splitlines()]
            if a.verify_only:
                assert not rows
                continue
            assert len(rows)==16*3*30
            cases={}
            for name in sorted({r['case'] for r in rows}):
                variants={}
                for mode in ('plain','registers','c'):
                    group=[r for r in rows if r['case']==name and r['implementation']==mode]
                    assert len(group)==30 and {r['sample'] for r in group}==set(range(30))
                    variants[mode]=stats([r['ns']/r['batch'] for r in group])
                assert len({r['result'] for r in rows if r['case']==name})==1
                cases[name]={'variants':variants,'speedup':variants['plain']['median_ns']/variants['registers']['median_ns'],'c_ratio':variants['registers']['median_ns']/variants['c']['median_ns']}
            report['kernels'][cc]=cases;print(cc+': PASS 16 interleaved kernels',flush=True)
        report['verification_accepted']=True
        if a.verify_only:
            report['measurements_executed']=False
            return
        measure_text(a,compiler,out,report)
        report['measurements_executed']=True
        report['accepted']=True
    finally:(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
