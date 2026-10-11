#!/usr/bin/env python3
"""Sustained native arena workloads and loans from one protected caller."""
import argparse,hashlib,json,platform,shutil,statistics,struct,subprocess,time
from pathlib import Path
from run import command,records
from generate_arena_imports import generate
ROOT=Path(__file__).resolve().parent;REPO=ROOT.parents[1]
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    p=argparse.ArgumentParser();p.add_argument('--assembly-directory',type=Path);p.add_argument('--output',type=Path,default=ROOT/'build/arena-stress');a=p.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    sources=['corpus/libft/arena.ubc','Ubytec/Program.cs','Ubytec/Ubytec.csproj','Ubytec/Language/AST/ArenaImportGenerator.cs','Ubytec/Language/AST/ModuleContracts.cs','Ubytec/Language/AST/SourceCompiler.cs']
    sources+=['prototypes/isolation/'+s for s in ('run_arena_stress.py','run.py','generate_arena_imports.py','linux/arena-stress.c','linux/program.c','linux/modules.c','linux/contracts.h','linux/many-service.h','linux/many-wire.h','linux/isolation.c','linux/bridge-runtime.c','linux/module.ld','common/contract.h','ubytec/arena/stress-source.ubc','ubytec/arena/pair-receiver.ubc','ubytec/arena/bench-current.ubc')]
    report={'schema':1,'accepted':False,'platform':platform.platform(),'source_sha256':{s:digest(REPO/s) for s in sources},'assembly_sha256':{},'native':{},'protected':{},'timing_scope':'epoch wall time includes client validation, fragmentation scans, random workload and recovery; no primitive latency or throughput claim'}
    try:
        library=(REPO/'corpus/libft/arena.ubc').read_text()
        if (ROOT/'ubytec/arena/bench-current.ubc').read_text().split('{',1)[1].rsplit('}',1)[0].strip()!=library.split('{',1)[1].rsplit('}',1)[0].strip():raise RuntimeError('Native export fixture differs from canonical arena')
        if not a.assembly_directory:command(['dotnet','build',REPO/'Ubytec/Ubytec.csproj','-c','Release','-p:EnableDocFxOnBuild=false','-p:GenerateDocumentationFile=false','--nologo'])
        for name in ('bench-current','stress-caller','pair-receiver'):
            asm=out/(name+'.nasm')
            if a.assembly_directory:shutil.copyfile(a.assembly_directory/(name+'.nasm'),asm)
            else:
                source=ROOT/('ubytec/arena/'+('stress-source' if name=='stress-caller' else name)+'.ubc')
                command(['dotnet',REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',source,*(['--arena-imports','--generated-source',out/'stress-generated.ubc'] if name=='stress-caller' else ['--library']),'-o',asm])
            report['assembly_sha256'][name]=digest(asm);command(['nasm','-f','elf64',asm,'-o',out/(name+'.o')])
        if a.assembly_directory:shutil.copyfile(a.assembly_directory/'stress-generated.ubc',out/'stress-generated.ubc')
        if (out/'stress-generated.ubc').read_text()!=generate((ROOT/'ubytec/arena/stress-source.ubc').read_text(),(REPO/'corpus/libft/arena.ubc').read_text()):raise RuntimeError('Generated source disagrees with current canonical arena/reference generator')
        report['generated_source_sha256']=digest(out/'stress-generated.ubc')
        if a.assembly_directory:
            provenance=json.loads((a.assembly_directory/'stress-provenance.json').read_text(encoding='utf-8-sig'))
            if provenance['assembly_sha256']!=report['assembly_sha256'] or provenance['generated_source_sha256']!=report['generated_source_sha256'] or provenance['canonical_sha256']!=digest(REPO/'corpus/libft/arena.ubc') or provenance['template_sha256']!=digest(ROOT/'ubytec/arena/stress-source.ubc'):raise RuntimeError('Staged compiler provenance mismatch')
            shutil.copyfile(a.assembly_directory/'stress-provenance.json',out/'stress-provenance.json');report['compiler_sha256']=provenance['compiler_sha256']
        else:report['compiler_sha256']=digest(REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll')
        command(['gcc','-O2','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone','-c',ROOT/'linux/bridge-runtime.c','-o',out/'runtime.o'])
        for name,entry in (('stress-caller','StressMain'),('pair-receiver','Copy')):command(['ld','-T',ROOT/'linux/module.ld','-e','ubytec_host_contract_'+entry,'-z','noexecstack',out/(name+'.o'),*([out/'runtime.o'] if name=='stress-caller' else []),'-o',out/(name+'.elf')])
        report['environment']={cc:command([cc,'--version']).splitlines()[0] for cc in ('gcc','clang')};report['environment']['nasm']=command(['nasm','-v']).strip()
        for cc in ('gcc','clang'):
            exe=out/('native-'+cc);command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror','-no-pie',ROOT/'linux/arena-stress.c',out/'bench-current.o','-o',exe]);raw=command([exe],timeout=120);(out/('native-'+cc+'.jsonl')).write_text(raw);rs=records(raw)
            summaries=[r for r in rs if r['event']=='summary'];epochs=[r for r in rs if r['event']=='epoch']
            if len(summaries)!=6 or len(epochs)!=144 or any(r['used_after'] for r in rs):raise RuntimeError('Sustained workload incomplete or arena leaked')
            for summary in summaries:
                rows=[r for r in epochs if (r['capacity'],r['seed'])==(summary['capacity'],summary['seed'])]
                if [r['epoch'] for r in rows]!=list(range(24)) or summary['operations']<12288 or not summary['failures']:raise RuntimeError('Epochs or injected failures missing')
                values=sorted(r['ns'] for r in rows);summary['epoch_median_ns']=statistics.median(values);summary['epoch_p95_ns']=values[22]
                summary['first_8_epoch_median_ns']=statistics.median(r['ns'] for r in rows[:8]);summary['last_8_epoch_median_ns']=statistics.median(r['ns'] for r in rows[-8:])
            report['native'][cc]=summaries
            if cc=='clang':
                resource_keys=('capacity','seed','epochs','operations','failures','peak_used','peak_hole_payload','max_blocks','peak_external_fragmentation_permille','used_after')
                if [{k:r[k] for k in resource_keys} for r in summaries]!=[{k:r[k] for k in resource_keys} for r in report['native']['gcc']]:raise RuntimeError('Native resource results disagree across clients')
            print(cc+': PASS 6 persistent arenas, 144 epochs, 73728 random steps plus OOM/application/recovery probes',flush=True)
            loader=out/('protected-'+cc);command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror',ROOT/'linux/program.c','-o',loader])
            data=bytearray([0xa5])*8352;data[:128]=bytes(128);inp=out/'input.bin';actual=out/('actual-'+cc+'.bin');inp.write_bytes(data)
            argv=[loader,'--contracts',out/'stress-caller.elf','StressMain','--module','pair_receiver',out/'pair-receiver.elf']
            for alias,budget in (('Copy',1000),('Partial',1000),('Spin',25)):argv+=['--grant-many',alias,'pair_receiver.'+alias,3,568,1,568,budget]
            argv+=['--input',inp,'--output',actual];begin=time.monotonic_ns();raw=command(argv,timeout=120);elapsed=time.monotonic_ns()-begin;(out/('protected-'+cc+'.jsonl')).write_text(raw);rs=records(raw)
            result=next(r for r in rs if r.get('case')=='program');metrics=next(r for r in rs if r.get('event')=='program-result');got=actual.read_bytes()
            if not result.get('pass') or result.get('value')!=1024 or len(got)!=8352 or struct.unpack_from('<3Q',got)!=(1024,32,8) or struct.unpack_from('<2Q',got,128)!=(8192,0) or got[24:64]!=data[24:64] or got[72:128]!=data[72:128] or struct.unpack_from('<Q',got,64)[0]!=31 or got[8336:]!=data[8336:] or metrics['callee_launches']!=1064 or metrics['requests']!=1064:raise RuntimeError('Protected sustained loans, fault cleanup or recovery failed: '+raw)
            report['protected'][cc]={'pass':True,'caller_invocations':1,'cycles':1024,'successful_loans':1024,'receiver_faults':32,'explicit_deadlines':8,'injected_oom':2048,'arena_used_after':0,'packet_guards_preserved':True,'elapsed_ns':elapsed,'metrics':metrics,'legacy_neighbor_metric_applicable':False}
            print(cc+': PASS 1024 same-caller cycles, 32 receiver faults, 8 explicit deadlines, 2048 OOM probes',flush=True)
        # Repeat the native client under instrumentation. NASM itself is not instrumented;
        # its writes are covered by the byte oracle, physical-block walk and canaries.
        exe=out/'native-sanitized';command(['gcc','-std=c11','-O1','-g','-Wall','-Wextra','-Werror','-fsanitize=address,undefined','-fno-omit-frame-pointer','-no-pie',ROOT/'linux/arena-stress.c',out/'bench-current.o','-o',exe]);raw=command([exe],timeout=120);(out/'native-sanitized.jsonl').write_text(raw)
        sanitized=records(raw)
        if len(sanitized)!=150 or any(r['used_after'] for r in sanitized) or [{k:r[k] for k in resource_keys} for r in sanitized if r['event']=='summary']!=[{k:r[k] for k in resource_keys} for r in report['native']['gcc']]:raise RuntimeError('Instrumented client incomplete or changed resource results')
        report['sanitized_native_client']={'pass':True,'epochs':144,'assembly_instrumented':False};report['accepted']=True
    finally:(out/'arena-stress-report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
