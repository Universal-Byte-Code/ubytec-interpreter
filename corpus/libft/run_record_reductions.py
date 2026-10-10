#!/usr/bin/env python3
"""Validate constant-stride UInt64 reductions, exact faults and interleaved C comparisons."""
import argparse,hashlib,json,math,platform,re,statistics,subprocess
from pathlib import Path
import run_text_diagnostics as diag
ROOT=diag.ROOT;REPO=diag.REPO
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def command(args):
    p=subprocess.run([str(a) for a in args],capture_output=True,text=True,timeout=300)
    if p.returncode:raise RuntimeError(str(args)+'\n'+p.stdout+p.stderr)
    return p.stdout
def stats(samples):
    v=sorted(samples);return {'median_ns':statistics.median(v),'p95_ns':v[math.ceil(.95*len(v))-1],'samples':v}

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
        flags=['--host-io','--stack-transfers','--frame-registers']+(['--record-reductions'] if mode=='registers' else [])
        for name in exports:flags+=['--host-export',name+'=ubytec_host_'+mode+'_'+name]
        command([a.dotnet,compiler,src,*flags,'-o',asm]);report['assembly_sha256']['text-'+mode]=sha(asm)
        report['source_sha256']['composed/text-'+mode]=sha(src)
        report.setdefault('text_record_reduction_functions',{})[mode]=asm.read_text().count('; record-reductions:')
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
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--dotnet',default='dotnet');p.add_argument('--compiler',type=Path)
    p.add_argument('--verify-only',action='store_true');p.add_argument('--output',type=Path,default=ROOT/'build/record-reductions');a=p.parse_args()
    out=a.output.resolve();out.mkdir(parents=True,exist_ok=True);compiler=a.compiler or REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll'
    files=['Ubytec/Language/Tools/Optimization/RecordReductionPlan.cs','Ubytec.Tests/RecordReductionTests.cs',
           'corpus/libft/run_record_reductions.py','corpus/libft/record-reduction-faults.c','corpus/libft/record-reduction-compare.c',
           'corpus/libft/record-reduction-reference.c']
    manifest=diag.manifest();manifest.update({n:sha(REPO/n) for n in files})
    report={'accepted':False,'platform':platform.platform(),'compiler_sha256':sha(compiler),'source_sha256':manifest,
            'assembly_sha256':{},'common_flags':['--stack-transfers','--frame-registers'],
            'text_modes':{'plain':'common flags','registers':'common flags plus --record-reductions'},
            'warmup':5,'samples':40,'order':'rotating interleaved in one process','faults':{},'results':{}}
    try:
        src=out/'kernels.ubc';src.write_bytes((ROOT/'diagnose-kernels.ubc').read_bytes())
        report['loop_analysis']={}
        objects=[]
        for mode in ('reference','reduction'):
            asm=out/(mode+'.nasm');flags=['--library','--stack-transfers','--frame-registers']
            if mode=='reduction':flags+=['--record-reductions']
            command([a.dotnet,compiler,src,*flags,'--host-export','DiagRecords=ubytec_host_'+mode+'_DiagRecords','-o',asm])
            text=asm.read_text();report['assembly_sha256'][mode]=sha(asm)
            assert ('; record-reductions:' in text)==(mode=='reduction')
            body=next(b for n,l,b in diag.functions(text) if n=='DiagRecords')
            pattern=(r'_record_reduce:\s*\n(.*?)^\s*\w+_record_reduce_done:' if mode=='reduction'
                     else r'^\s*\S*while_\d+: ; WHILE start\s*\n(.*?)^\s*\S*end_while_\d+:')
            match=re.search(pattern,body,re.M|re.S);assert match
            instructions=[l.strip() for l in match[1].splitlines() if l.strip() and not l.strip().startswith(';')]
            report['loop_analysis'][mode]={'instructions':len(instructions),'push_pop':sum(l.startswith(('push ','pop ')) for l in instructions),
                                         'memory_writes':sum(l.startswith('push ') or bool(re.match(r'mov qword \[',l)) for l in instructions)}
            if mode=='reduction':assert 'imul ' not in match[1] and 'mov rax, qword [rdi]' in match[1]
            obj=out/(mode+'.o');command(['nasm','-f','elf64',asm,'-o',obj]);objects.append(obj)
            (out/(mode+'.disasm')).write_text(command(['objdump','-dr','-Mintel',obj]))
        for cc in ('gcc','clang'):
            exe=out/('faults-'+cc)
            command([cc,'-O2','-Wall','-Wextra','-Werror','-no-pie',ROOT/'record-reduction-faults.c',*objects,'-o',exe])
            raw=command([exe]);(out/(cc+'-faults.json')).write_text(raw);report['faults'][cc]=json.loads(raw);assert report['faults'][cc]['accepted']
        report['compilers']={}
        for cc in ('gcc','clang'):
            report['compilers'][cc]=command([cc,'--version']).splitlines()[0]
            for mode in ('scalar','native'):
                flags=['-O2',*(['-fno-tree-vectorize'] if cc=='gcc' else ['-fno-vectorize','-fno-slp-vectorize'])] if mode=='scalar' else ['-O3','-march=native']
                obj=out/(cc+'-'+mode+'.o');command([cc,*flags,'-Wall','-Wextra','-Werror','-DREDUCE_NAME=c_'+cc+'_'+mode,'-c',ROOT/'record-reduction-reference.c','-o',obj]);objects.append(obj)
                report['compilers'][cc+'_'+mode+'_flags']=flags
                (out/(cc+'-'+mode+'.disasm')).write_text(command(['objdump','-dr','-Mintel',obj]))
        exe=out/'compare';command(['gcc','-O2','-Wall','-Wextra','-Werror','-no-pie',ROOT/'record-reduction-compare.c',*objects,'-o',exe])
        raw=command([exe,*(['--verify-only'] if a.verify_only else [])]);(out/'samples.jsonl').write_text(raw)
        rows=[json.loads(l) for l in raw.splitlines()];report['validation']=rows[0];assert rows[0]['event']=='validation'
        report['verification_accepted']=True
        print('PASS exact record loads, SIGSEGV/SIGBUS ledger, result/guard matrix; '+str(rows[0]['checks'])+' checks',flush=True)
        if a.verify_only:report['measurements_executed']=False;return
        data=rows[1:];assert len(data)==5*6*40
        for n in (4,64,256,4096,65536):
            group=[r for r in data if r['records']==n];assert len({r['result'] for r in group})==1
            case={}
            for variant in sorted({r['variant'] for r in group}):
                selected=[r for r in group if r['variant']==variant];assert {r['sample'] for r in selected}==set(range(40))
                case[variant]=stats([r['ns']/r['batch'] for r in selected])
            report['results'][str(n)]=case
        report['cpu']=command(['lscpu'])
        measure_text(a,compiler,out,report)
        report['verification_accepted']=True;report['measurements_executed']=True;report['accepted']=True
    finally:(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
