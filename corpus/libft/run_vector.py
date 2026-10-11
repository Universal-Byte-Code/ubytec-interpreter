#!/usr/bin/env python3
"""Generic Ubytec vector: independent C model and protected loan lifecycle."""
import argparse,hashlib,json,platform,shutil,struct,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parent;REPO=ROOT.parents[1];PROTO=REPO/'prototypes/isolation'
sys.path.insert(0,str(PROTO))
from generate_arena_imports import generate
EXPORTS=('VectorInit','VectorValidate','VectorReserve','VectorEnsure','VectorPush','VectorInsert','VectorSet','VectorGet','VectorAt','VectorLength','VectorCapacity','VectorErase','VectorClear','VectorDestroy','VectorPin','VectorUnpin','VectorStateSum','VectorAppendText','ArenaInit','ArenaFind','ArenaAlloc','ArenaFree')
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def body(p):return p.read_text().split('{',1)[1].rsplit('}',1)[0]
def sources():
    composed='module (name:"vector_native",version:"0.1",author:"Ubytec") {\n'+''.join(body(ROOT/(n+'.ubc')) for n in ('arena','scalar','vector','vector-apps'))+'\n}\n'
    loan=(PROTO/'ubytec/arena/vector-loans-source.ubc').read_text().rstrip()[:-1]+body(ROOT/'vector.ubc')+'}\n'
    return {'vector-composed':composed,'vector-loans':loan,'pair-receiver':(PROTO/'ubytec/arena/pair-receiver.ubc').read_text()}
def command(args,timeout=120):
    proc=subprocess.run([str(x) for x in args],capture_output=True,text=True,timeout=timeout)
    if proc.returncode:raise RuntimeError(str(args)+'\n'+proc.stdout+'\n'+proc.stderr)
    return proc.stdout
def main():
    p=argparse.ArgumentParser();p.add_argument('--prepare-only',action='store_true');p.add_argument('--assembly-directory',type=Path);p.add_argument('--output',type=Path,default=ROOT/'build/vector');a=p.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    for n,s in sources().items():(out/(n+'.ubc')).write_text(s)
    if a.prepare_only:print('Prepared vector sources; no tests executed.');return
    paths=['corpus/libft/'+n for n in ('arena.ubc','scalar.ubc','vector.ubc','vector-apps.ubc','vector-reference.c','run_vector.py')]
    paths+=['Ubytec.Tests/'+n for n in ('VectorTests.cs','Ubytec.Tests.csproj')]
    paths+=['Ubytec/Language/AST/'+n for n in ('SourceCompiler.cs','ArenaImportGenerator.cs','ModuleContracts.cs')]+['Ubytec/Ubytec.csproj','Ubytec/Program.cs']
    paths+=['prototypes/isolation/'+n for n in ('generate_arena_imports.py','linux/program.c','linux/modules.c','linux/isolation.c','linux/contracts.h','linux/many-service.h','linux/many-wire.h','linux/bridge-runtime.c','linux/module.ld','common/contract.h','ubytec/arena/vector-loans-source.ubc','ubytec/arena/pair-receiver.ubc')]
    report={'schema':1,'accepted':False,'platform':platform.platform(),'source_sha256':{s:digest(REPO/s) for s in paths},'assembly_sha256':{},'composed_source_sha256':{},'native':{},'protected':{}}
    try:
        if not a.assembly_directory:command(['dotnet','build',REPO/'Ubytec/Ubytec.csproj','-c','Release','-p:EnableDocFxOnBuild=false','-p:GenerateDocumentationFile=false','--nologo'])
        for n in sources():
            asm=out/(n+'.nasm')
            if a.assembly_directory:
                if (a.assembly_directory/(n+'.ubc')).read_text()!=(out/(n+'.ubc')).read_text():raise RuntimeError('Composed source drift: '+n)
                shutil.copyfile(a.assembly_directory/(n+'.ubc'),out/(n+'.ubc'));shutil.copyfile(a.assembly_directory/(n+'.nasm'),asm)
                if n=='vector-loans':shutil.copyfile(a.assembly_directory/'vector-loans-generated.ubc',out/'vector-loans-generated.ubc')
            else:
                flags=['--arena-imports','--generated-source',out/'vector-loans-generated.ubc'] if n=='vector-loans' else ['--library']
                if n=='vector-composed':
                    for export in EXPORTS:flags+=['--host-export',export+'=ubytec_host_contract_'+export]
                command(['dotnet',REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',out/(n+'.ubc'),*flags,'-o',asm])
            report['assembly_sha256'][n]=digest(asm);report['composed_source_sha256'][n]=digest(out/(n+'.ubc'));command(['nasm','-f','elf64',asm,'-o',out/(n+'.o')])
        if (out/'vector-loans-generated.ubc').read_text()!=generate((out/'vector-loans.ubc').read_text(),(ROOT/'arena.ubc').read_text()):raise RuntimeError('Generated loans disagree with reference/canonical arena')
        report['generated_source_sha256']=digest(out/'vector-loans-generated.ubc')
        if a.assembly_directory:
            provenance=json.loads((a.assembly_directory/'vector-provenance.json').read_text(encoding='utf-8-sig'))
            for key in ('assembly_sha256','composed_source_sha256','generated_source_sha256'):
                if provenance[key]!=report[key]:raise RuntimeError('Compiler provenance mismatch: '+key)
            report['compiler_sha256']=provenance['compiler_sha256'];shutil.copyfile(a.assembly_directory/'vector-provenance.json',out/'vector-provenance.json')
        else:report['compiler_sha256']=digest(REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll')
        report['environment']={cc:command([cc,'--version']).splitlines()[0] for cc in ('gcc','clang')};report['environment']['nasm']=command(['nasm','-v']).strip()
        for cc in ('gcc','clang','sanitized'):
            exe=out/('vector-'+cc);flags=['-O2'] if cc!='sanitized' else ['-O1','-g','-fsanitize=address,undefined','-fno-sanitize-recover=all','-fno-omit-frame-pointer']
            command([cc if cc!='sanitized' else 'gcc','-std=c11',*flags,'-Wall','-Wextra','-Werror','-no-pie',ROOT/'vector-reference.c',out/'vector-composed.o','-o',exe]);raw=command([exe]);(out/('native-'+cc+'.jsonl')).write_text(raw);row=json.loads(raw)
            if not row['accepted'] or row['random_steps']!=20000 or row['histories']!=10 or not row['rejections']:raise RuntimeError('Native vector corpus incomplete')
            if cc!='gcc' and row!=report['native']['gcc']:raise RuntimeError('Native clients disagree')
            report['native'][cc]=row;print(cc+': PASS '+str(row['random_steps'])+' random steps and '+str(row['checks'])+' vector/model checks',flush=True)
        runtime=out/'runtime.o';command(['gcc','-O2','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone','-c',PROTO/'linux/bridge-runtime.c','-o',runtime])
        for name,entry in (('vector-loans','VectorLoans'),('pair-receiver','Copy')):command(['ld','-T',PROTO/'linux/module.ld','-e','ubytec_host_contract_'+entry,'-z','noexecstack',out/(name+'.o'),*([runtime] if name=='vector-loans' else []),'-o',out/(name+'.elf')])
        for cc in ('gcc','clang'):
            loader=out/('protected-'+cc);command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror',PROTO/'linux/program.c','-o',loader]);data=bytearray([0xa5])*8480;data[:128]=bytes(128);data[128:168]=bytes(40);data[176:216]=bytes(40);inp=out/'input.bin';actual=out/('actual-'+cc+'.bin');inp.write_bytes(data)
            argv=[loader,'--contracts',out/'vector-loans.elf','VectorLoans','--module','pair_receiver',out/'pair-receiver.elf']
            for alias,budget in (('Copy',1000),('Partial',1000),('Spin',25)):argv+=['--grant-many',alias,'pair_receiver.'+alias,3,32,1,32,budget]
            argv+=['--input',inp,'--output',actual];raw=command(argv);(out/('protected-'+cc+'.jsonl')).write_text(raw);rs=[json.loads(line) for line in raw.splitlines() if line.startswith('{')];result=next(r for r in rs if r.get('case')=='program');metrics=next(r for r in rs if r.get('event')=='program-result');got=actual.read_bytes()
            if not result['pass'] or result['value']!=64 or struct.unpack_from('<3Q',got)!=(64,8,2) or struct.unpack_from('<2Q',got,256)!=(8192,0) or got[128:168]!=bytes(40) or got[176:216]!=bytes(40) or got[168:176]!=data[168:176] or got[216:256]!=data[216:256] or got[-16:]!=data[-16:] or metrics['callee_launches']!=74 or metrics['requests']!=74:raise RuntimeError('Protected vector lifecycle failed: '+raw)
            report['protected'][cc]={'pass':True,'caller_invocations':1,'cycles':64,'successful_loans':64,'receiver_faults':8,'explicit_deadlines':2,'receiver_launches':74,'arena_used_after':0,'descriptor_and_packet_guards_preserved':True,'metrics':metrics,'legacy_neighbor_metric_applicable':False};print(cc+': PASS 64 protected vector-loan cycles, 8 faults, 2 explicit deadlines',flush=True)
        report['sanitizer_scope']='C byte-array model/client instrumented; generated NASM checked by snapshots, byte comparisons and canaries';report['accepted']=True
    finally:(out/'vector-report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
