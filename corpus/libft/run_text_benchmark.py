#!/usr/bin/env python3
"""Reproducible Linux x64 text baseline; correctness gates, never speed gates."""
import argparse
import hashlib
import json
import math
import platform
import random
import shutil
import statistics
import subprocess
import time
from pathlib import Path
import run_text as text

ROOT=text.ROOT
REPO=text.REPO
PROTO=text.PROTO
EXPORTS=('ArenaInit','ArenaAlloc','VectorInit','TextFeed','TextFlush','TextCleanup','BenchSort','BenchEmit')

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def command(args,timeout=3600):return text.command(args,timeout=timeout)
def functions(source):return source.split('{',1)[1].rsplit('}',1)[0]

def sources():
    base=functions(text.sources()['text-composed'])
    wrappers=(ROOT/'text-benchmark.ubc').read_text(encoding='utf-8')
    native='module (name:"text_native_benchmark",version:"0.1",author:"Ubytec") {\n'+base+wrappers+'\n}\n'
    instrumented=native
    for name,args,pushes in (('ArenaAlloc','t_uint64 arena,t_uint64 length','load @arena\nload @length\n'),('ArenaResize','t_uint64 arena,t_uint64 pointer,t_uint64 length','load @arena\nload @pointer\nload @length\n')):
        instrumented=instrumented.replace('func '+name+'(', 'func '+name+'MeasuredBody(',1)
        wrapper='func '+name+'('+args+') -> t_uint64 {\nlocal { t_uint64 value 0 }\n'+pushes+'call '+name+'MeasuredBody\nstore @value\nload @arena\ncall BenchPeak\npop\nload @value\nreturn\n}\n'
        instrumented=instrumented.rstrip()[:-1]+wrapper+'}\n'
    peak='''func BenchPeak(t_uint64 arena) -> t_uint64 {
load @arena
push 8
add
load t_uint64
load @arena
push 8
sub
load t_uint64
ugt
if
load @arena
push 8
sub
load @arena
push 8
add
load t_uint64
store t_uint64
end
push 1
return
}
'''
    instrumented=instrumented.rstrip()[:-1]+peak+'}\n'
    transfer=(ROOT/'text-transfer.ubc').read_text(encoding='utf-8').rstrip()[:-1]
    analyzer=(ROOT/'text-analyzer.ubc').read_text(encoding='utf-8')
    write=analyzer[analyzer.index('func TextWrite('):analyzer.index('func TextCleanup(')]
    return {'bench-native':native,'bench-memory':instrumented,'bench-transfer':transfer+write+'}\n','text-composed':text.sources()['text-composed']}

def manifest():
    paths=set(text.manifest())
    paths.update('corpus/libft/'+n for n in ('run_text_benchmark.py','text-benchmark.ubc','text-transfer.ubc','text-benchmark.c'))
    return {n:sha(REPO/n) for n in sorted(paths)}

def corpus():
    """36 size/vocabulary/distribution/block cases + 8 independent sort cases."""
    rng=random.Random(420106)
    def data(size,vocabulary,distribution,order):
        words=[('token_%03d'%i).encode() for i in range(vocabulary)]
        if order=='descending':words.reverse()
        elif order=='random':rng.shuffle(words)
        cycle=b' '.join(words)+b' '
        if distribution=='skewed':cycle+=b'token_000 '*vocabulary*9
        return (cycle*(size//len(cycle)+1))[:size]
    rows=[]
    for size in (4096,65536,1048576):
        for vocabulary in (4,64,256):
            for distribution in ('uniform','skewed'):
                raw=data(size,vocabulary,distribution,'ascending')
                for chunk in (64,4096):rows.append((f'{size}-v{vocabulary}-{distribution}-b{chunk}',raw,chunk,{'size':size,'vocabulary_requested':vocabulary,'distribution':distribution,'order':'ascending'}))
    for vocabulary in (64,256):
        for order in ('descending','random'):
            raw=data(65536,vocabulary,'uniform',order)
            for chunk in (64,4096):rows.append((f'sort-v{vocabulary}-{order}-b{chunk}',raw,chunk,{'size':65536,'vocabulary_requested':vocabulary,'distribution':'uniform','order':order}))
    rows.append(('empty',b'',4096,{'size':0,'vocabulary_requested':0,'distribution':'empty','order':'ascending'}))
    return rows

def stats(samples,size=0):
    values=sorted(samples)
    if not values:raise RuntimeError('No timing samples')
    median=statistics.median(values)
    return {'samples_ns':samples,'median_ns':median,'p95_ns':values[math.ceil(.95*len(values))-1],
            'bytes_per_second_at_median':size*1e9/median if size and median else None}

def native(exe,mode,src,expected,chunk,warm,samples):
    rows=[json.loads(line) for line in command([exe,mode,src,expected,chunk,warm,samples]).splitlines()]
    if len(rows)!=samples or any(not r['output_matches'] or r['arena_used_after'] for r in rows):raise RuntimeError('Native benchmark failed validation')
    return rows

def timed_process(args):
    # GNU time gives this process's own peak RSS (not Python's accumulating child maximum).
    started=time.monotonic_ns()
    proc=subprocess.run(['/usr/bin/time','-f','BENCH_RSS_KIB=%M',*[str(a) for a in args]],capture_output=True,text=True,timeout=3600)
    elapsed=time.monotonic_ns()-started
    if proc.returncode:raise RuntimeError('Benchmark command failed: '+str(args)+'\n'+proc.stdout+'\n'+proc.stderr)
    rss=next(int(s.split('=',1)[1]) for s in proc.stderr.splitlines() if s.startswith('BENCH_RSS_KIB='))
    return elapsed,rss,proc.stdout

def write_summary(report,out):
    lines=['# Text benchmark results','',
           f"Environment: {report['platform']}; WSL: {report['is_wsl']}. "
           f"Warmups: {report['warmup']}; samples: {report['samples']}. "
           f"Statistical baseline: {report['statistical_baseline']}.",'',
           'All times below are medians in milliseconds. Protected transport copies the input;',
           'it is a separate workload, not an overhead obtained by subtraction.','',
           '| Case | Compiler | Feed | Sort | Emit | Protected analyzer | Transport | C oracle | Arena peak bytes |',
           '|---|---|---:|---:|---:|---:|---:|---:|---:|']
    for case in report['cases']:
        for cc,v in case['variants'].items():
            ns=[v['native']['ubytec'][phase]['median_ns'] for phase in ('feed','sort','emit')]
            ns += [v['protected'][mode]['e2e']['median_ns'] for mode in ('analyzer','transport')]
            ns += [v['oracle_e2e']['e2e']['median_ns']]
            lines.append('| '+case['name']+' | '+cc+' | '+' | '.join(f'{n/1e6:.3f}' for n in ns)+' | '+str(v['arena_peak_extent_bytes'])+' |')
    if report['cases']:
        shares=[]
        for case in report['cases']:
            if not case['reference']['bytes']:continue
            v=case['variants']['gcc']['native']['ubytec'];total=sum(v[p]['median_ns'] for p in ('feed','sort','emit'))
            shares.append(v['feed']['median_ns']/total)
        if shares:
            share=statistics.median(shares)
            lines+=['',f'Feed/count median share of measured native phases across nonempty cases: {share:.1%}.',
                    'Investigate dictionary lookup and vector/arena validation costs first.' if share>.5 else 'Inspect per-case sorting/emission costs before choosing an optimization.',
                    'This identifies a phase; it does not prove which helper inside that phase dominates.',
                    'No opcode or isolation guarantee was changed.']
    (out/'benchmark-summary.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,default=ROOT/'build/text-benchmark')
    parser.add_argument('--dotnet',default='dotnet');parser.add_argument('--assembly-directory',type=Path)
    parser.add_argument('--prepare-only',action='store_true');parser.add_argument('--compile-only',action='store_true')
    parser.add_argument('--warmup',type=int,default=5);parser.add_argument('--samples',type=int,default=30)
    parser.add_argument('--case',action='append',help='Exact case name; repeat to select a subset.')
    args=parser.parse_args()
    if args.warmup<0 or not 1<=args.samples<=10000:parser.error('warmup >= 0; samples 1..10000')
    out=args.output.resolve();out.mkdir(parents=True,exist_ok=True)
    for name,source in sources().items():(out/(name+'.ubc')).write_text(source,encoding='utf-8')
    if args.prepare_only:return
    report={'schema':1,'accepted':False,'platform':platform.platform(),'is_wsl':'microsoft' in platform.release().lower(),
            'warmup':args.warmup,'samples':args.samples,'statistical_baseline':args.warmup>=5 and args.samples>=30,
            'source_sha256':manifest(),'assembly_sha256':{},'composed_source_sha256':{},'cases':[],
            'clock':'CLOCK_MONOTONIC in C; time.monotonic_ns around subprocess + GNU time in Python',
            'p95_definition':'nearest rank ceil(0.95*n)',
            'comparability':'C-linear shares tokenization, linear dictionary and insertion sort; malloc/realloc and libc differ from Ubytec arena/validated vectors. Native emission uses a memory sink, protected emission uses IPC/files. No subtraction is treated as exact transport overhead.',
            'memory_method':'Separate instrumented native run observes arena.used after every ArenaAlloc/ArenaResize, including nested allocations before frees. Peak is occupied backing extent including headers/holes, not live payload. Protected worker RSS uses wait4; supervisor RSS uses getrusage(RUSAGE_SELF). Zero RSS is unavailable, not zero memory.'}
    try:
        if not args.assembly_directory:command([args.dotnet,'build',REPO/'Ubytec/Ubytec.csproj','-c','Release','-p:EnableDocFxOnBuild=false','-p:GenerateDocumentationFile=false','--nologo'])
        for name in sources():
            src=out/(name+'.ubc');asm=out/(name+'.nasm')
            if args.assembly_directory:
                staged=args.assembly_directory
                if (staged/src.name).read_text(encoding='utf-8')!=src.read_text(encoding='utf-8'):raise RuntimeError('Source drift: '+name)
                shutil.copyfile(staged/src.name,src);shutil.copyfile(staged/asm.name,asm)
            else:
                flags=['--host-io']
                if name.startswith('bench-') and name!='bench-transfer':
                    for export in EXPORTS:flags+=['--host-export',export+'=ubytec_host_contract_'+export]
                command([args.dotnet,REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',src,*flags,'-o',asm])
            report['assembly_sha256'][name]=sha(asm);report['composed_source_sha256'][name]=sha(src)
        if args.assembly_directory:
            proof=json.loads((args.assembly_directory/'benchmark-provenance.json').read_text(encoding='utf-8-sig'))
            for key in ('source_sha256','assembly_sha256','composed_source_sha256'):
                if proof[key]!=report[key]:raise RuntimeError('Provenance mismatch: '+key)
            report['compiler_sha256']=proof['compiler_sha256']
        else:report['compiler_sha256']=sha(REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll')
        (out/'benchmark-provenance.json').write_text(json.dumps({k:report[k] for k in ('source_sha256','assembly_sha256','composed_source_sha256','compiler_sha256')},indent=2)+'\n',encoding='utf-8')
        if args.compile_only:return
        report['environment']={cc:command([cc,'--version']).splitlines()[0] for cc in ('gcc','clang')}
        report['environment'].update({'nasm':command(['nasm','-v']).strip(),'ld':command(['ld','--version']).splitlines()[0],
                                      'cpu':Path('/proc/cpuinfo').read_text().split('model name',1)[-1].split('\n',1)[0].strip(' :\t'),'python':platform.python_version()})
        for name in sources():command(['nasm','-f','elf64',out/(name+'.nasm'),'-o',out/(name+'.o')])
        runtime=out/'runtime.o';command(['gcc','-O2','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone','-c',PROTO/'linux/bridge-runtime.c','-o',runtime])
        for name in ('text-composed','bench-transfer'):command(['ld','-T',PROTO/'linux/module.ld','-e','ubytec_host_contract_TextMain','-z','noexecstack',out/(name+'.o'),runtime,'-o',out/(name+'.elf')])
        # Diagnostic broker source adds RSS reporting only; it retains the same policy.
        host_source=(PROTO/'linux/text-host.c').read_text(encoding='utf-8')
        host_source=host_source.replace('finish:', 'finish:\n    ; struct rusage bench_usage; if(!getrusage(RUSAGE_SELF,&bench_usage)) printf("{\\"event\\":\\"benchmark-memory\\",\\"supervisor_peak_rss_kib\\":%ld}\\n",bench_usage.ru_maxrss);',1)
        (out/'benchmark-host.c').write_text(host_source,encoding='utf-8');report['derived_host_sha256']=sha(out/'benchmark-host.c')
        for cc in ('gcc','clang'):
            for name,obj in (('native','bench-native'),('memory','bench-memory')):
                command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror','-no-pie',ROOT/'text-benchmark.c',out/(obj+'.o'),'-o',out/(name+'-'+cc)])
            command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror','-I',PROTO/'linux',out/'benchmark-host.c','-o',out/('host-'+cc)])
            command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror',ROOT/'text-reference.c','-o',out/('oracle-'+cc)])
        all_cases=corpus();selected=[row for row in all_cases if not args.case or row[0] in args.case]
        if not selected or args.case and set(args.case)-{row[0] for row in all_cases}:raise RuntimeError('Unknown/empty case selection')
        report['full_corpus']=not args.case
        for index,(name,raw,chunk,parameters) in enumerate(selected):
            src=out/(name+'.bin');src.write_bytes(raw);expected=out/(name+'.expected');reference=json.loads(command([out/'oracle-gcc',src,expected]));expected_hash=sha(expected)
            other=out/(name+'.clang.expected');other_stats=json.loads(command([out/'oracle-clang',src,other]))
            if other_stats!=reference or sha(other)!=expected_hash:raise RuntimeError('Oracles disagree')
            case={'name':name,'parameters':{**parameters,'chunk':chunk},'input_sha256':sha(src),'expected_sha256':expected_hash,'reference':reference,'variants':{}}
            print(f'{index+1}/{len(selected)} {name}: measuring',flush=True)
            for cc in ('gcc','clang'):
                variant={'native':{},'protected':{},'oracle_e2e':{}}
                for mode in ('ubytec','c-linear'):
                    rows=native(out/('native-'+cc),mode,src,expected,chunk,args.warmup,args.samples)
                    if any(row['unique']!=reference['unique'] for row in rows):raise RuntimeError('Native vocabulary mismatch')
                    variant['native'][mode]={phase:stats([r[phase+'_ns'] for r in rows],len(raw) if phase=='feed' else 0) for phase in ('feed','sort','emit')}
                    variant['native'][mode]['process_peak_rss_kib']=[r['process_peak_rss_kib'] or None for r in rows]
                memory=native(out/('memory-'+cc),'ubytec',src,expected,chunk,0,1)[0]
                variant['arena_peak_extent_bytes']=memory['arena_peak_extent'];variant['arena_capacity_bytes']=65248
                for mode,module in (('analyzer','text-composed'),('transport','bench-transfer')):
                    samples=[];rss=[];metrics=[];worker=[];supervisor=[]
                    for iteration in range(args.warmup+args.samples):
                        target=out/(name+'.'+cc+'.'+mode+'.actual')
                        elapsed,peak,log=timed_process([out/('host-'+cc),'--caller',out/(module+'.elf'),'--input',src,'--output',target,'--chunk',chunk])
                        events=[json.loads(s) for s in log.splitlines() if s.startswith('{')]
                        result=next(r for r in events if r.get('event')=='text-result');program=next(r for r in events if r.get('event')=='program-result');mem=next(r for r in events if r.get('event')=='benchmark-memory')
                        if not result['accepted'] or result['arena_used_after'] or result['denials'] or result['read_bytes']!=len(raw):raise RuntimeError('Protected contract failed')
                        if mode=='analyzer':
                            if sha(target)!=expected_hash or any(result[k]!=reference[k] for k in ('bytes','words','unique','emitted')):raise RuntimeError('Protected output mismatch')
                        elif sha(target)!=sha(src) or result['write_bytes']!=len(raw):raise RuntimeError('Transport copy mismatch')
                        if iteration>=args.warmup:
                            samples.append(elapsed);rss.append(peak);metrics.append(result);worker.append(program['caller_peak_rss_kib'] or None);supervisor.append(mem['supervisor_peak_rss_kib'] or None)
                    variant['protected'][mode]={'e2e':stats(samples,len(raw)),'rss_time_command_kib':rss,'worker_peak_rss_kib':worker,'supervisor_peak_rss_kib':supervisor,'metrics':metrics}
                samples=[];rss=[]
                for iteration in range(args.warmup+args.samples):
                    target=out/(name+'.'+cc+'.oracle.actual');elapsed,peak,log=timed_process([out/('oracle-'+cc),src,target])
                    if json.loads(log)!=reference or sha(target)!=expected_hash:raise RuntimeError('Timed oracle mismatch')
                    if iteration>=args.warmup:samples.append(elapsed);rss.append(peak)
                variant['oracle_e2e']={'e2e':stats(samples,len(raw)),'peak_rss_kib':rss}
                case['variants'][cc]=variant
            if sha(src)!=case['input_sha256']:raise RuntimeError('Input modified')
            report['cases'].append(case)
            (out/'benchmark-report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
            print(f'{name}: PASS timings, C outputs, protected I/O and cleanup',flush=True)
        report['accepted']=True
    finally:
        (out/'benchmark-report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
        write_summary(report,out)
if __name__=='__main__':main()
