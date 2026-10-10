#!/usr/bin/env python3
"""Native allocator workload comparison with preserved v1 source baseline."""
import argparse,hashlib,json,platform,shutil,statistics,subprocess
from pathlib import Path
from run import command,records
ROOT=Path(__file__).resolve().parent;REPO=ROOT.parents[1]
NAMES=('bench-baseline','bench-current')
EXPORTS=('ArenaInit','ArenaAlloc','ArenaFree','ArenaResize','ArenaAppendUpper','ArenaFind','ArenaPin','ArenaUnpin')
def benchmark_source(library):
    body=library.split('{',1)[1].rsplit('}',1)[0]
    return ''.join('export '+n+' as '+n+'\n' for n in EXPORTS)+'module (name:"arena_bench",version:"0.1",author:"Ubytec") {'+body+'}\n'
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    p=argparse.ArgumentParser();p.add_argument('--assembly-directory',type=Path);p.add_argument('--output',type=Path,default=ROOT/'build/arena-benchmark');a=p.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    sources=['corpus/libft/arena.ubc','prototypes/isolation/ubytec/arena/baseline-v1.ubc','prototypes/isolation/linux/arena-benchmark.c','prototypes/isolation/run_arena_benchmark.py','prototypes/isolation/run.py']
    sources+=['prototypes/isolation/ubytec/arena/'+n+'.ubc' for n in NAMES]
    report={'schema':1,'accepted':False,'platform':platform.platform(),'measurement':'trusted same-process native allocator/client workloads; no isolation-boundary timing','source_sha256':{s:digest(REPO/s) for s in sources},'assembly_sha256':{},'resources':[],'benchmarks':[]}
    try:
        if not a.assembly_directory:command(['dotnet','build',REPO/'Ubytec/Ubytec.csproj','-c','Release','-p:EnableDocFxOnBuild=false','-p:GenerateDocumentationFile=false','--nologo'])
        for name,library in zip(NAMES,(ROOT/'ubytec/arena/baseline-v1.ubc',REPO/'corpus/libft/arena.ubc')):
            source=ROOT/('ubytec/arena/'+name+'.ubc')
            if source.read_text()!=benchmark_source(library.read_text()):raise RuntimeError('Benchmark source drift: '+name)
            asm=out/(name+'.nasm')
            if a.assembly_directory:shutil.copyfile(a.assembly_directory/(name+'.nasm'),asm)
            else:command(['dotnet',REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',source,'--library','-o',asm])
            report['assembly_sha256'][name]=digest(asm);command(['nasm','-f','elf64',asm,'-o',out/(name+'.o')])
        command(['objcopy','--prefix-symbols=baseline_',out/'bench-baseline.o',out/'baseline-prefixed.o'])
        executable=out/'arena-benchmark';command(['gcc','-std=c11','-O2','-Wall','-Wextra','-Werror','-no-pie',ROOT/'linux/arena-benchmark.c',out/'bench-current.o',out/'baseline-prefixed.o','-o',executable])
        report['environment']={'gcc':command(['gcc','--version']).splitlines()[0],'nasm':command(['nasm','-v']).strip()}
        cpu=Path('/proc/cpuinfo')
        if cpu.exists():report['environment']['cpu']=next((line.split(':',1)[1].strip() for line in cpu.read_text().splitlines() if line.startswith('model name')),'unavailable')
        result=command([executable],timeout=120);(out/'arena-benchmark.jsonl').write_text(result);rs=records(result)
        report['resources']=[r for r in rs if r['event']=='resources']
        for row in report['resources']:
            row['backing_capacity']=16384 if row['case'] in ('text_growth','pending_state') else 512 if row['case']=='split_churn' else 384 if row['case']=='coalesce_holes' else 8192
            row['peak_used_excludes_arena_header']=True
        report['timing_statistic']='median/p95 of 100 batch averages, each 100 complete workload attempts; not individual latency percentiles'
        for case in ('text_growth','pending_state','split_churn','coalesce_holes','text_tight','state_tight'):
            resources=[r for r in report['resources'] if r['case']==case]
            if len(resources)!=2:raise RuntimeError('Resource samples missing')
            old,new=resources
            if new['failures'] or new['completed']<old['completed'] or new['copied_bytes']>old['copied_bytes']:raise RuntimeError('Optimization regressed resource workload')
            if case in ('text_growth','pending_state') and (old['checksum']!=new['checksum'] or old['completed']!=new['completed']):raise RuntimeError('Complete workload output changed')
            for variant in (0,1):
                rows=[r for r in rs if r['event']=='sample' and r['case']==case and r['variant']==variant]
                if len(rows)!=100:raise RuntimeError('Timing samples missing')
                values=sorted(r['ns']/r['batch'] for r in rows)
                report['benchmarks'].append({'case':case,'variant':'baseline' if variant==0 else 'current','samples':100,'warmup_batches':10,'batch':100,'median_ns':statistics.median(values),'p95_ns':values[94],'same_completed_work':old['completed']==new['completed']})
        report['accepted']=True
        for row in report['resources']:print(f"{row['case']} v{row['variant']}: peak={row['peak_used']} copied={row['copied_bytes']} failures={row['failures']} completed={row['completed']}",flush=True)
    finally:(out/'arena-benchmark-report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
