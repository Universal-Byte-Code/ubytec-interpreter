#!/usr/bin/env python3
"""Streaming Ubytec word frequencies, authorized resource I/O and independent C oracle."""
import argparse
import hashlib
import json
import platform
import random
import shutil
import struct
import subprocess
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parent
REPO=ROOT.parents[1]
PROTO=REPO/'prototypes/isolation'

def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def command(args,timeout=180,expected=0):
    run=subprocess.run([str(x) for x in args],capture_output=True,text=True,timeout=timeout)
    if run.returncode!=expected:raise RuntimeError(str(args)+'\n'+run.stdout+'\n'+run.stderr)
    return run.stdout

def body(name):return (ROOT/(name+'.ubc')).read_text(encoding='utf-8').split('{',1)[1].rsplit('}',1)[0]
def sources():
    return {'text-composed':'export TextMain as TextMain\nmodule (name:"text_program",version:"0.1",author:"Ubytec") {\n'+''.join(body(n) for n in ('arena','scalar','memory','vector','text-analyzer'))+'\n}\n',
            'text-probe':(ROOT/'text-io-probe.ubc').read_text(encoding='utf-8'),
            'text-fault':(ROOT/'text-io-fault.ubc').read_text(encoding='utf-8'),
            'caller':(PROTO/'ubytec/typed/caller.ubc').read_text(encoding='utf-8'),
            'memory':(PROTO/'ubytec/typed/memory.ubc').read_text(encoding='utf-8')}

def manifest():
    paths=list((REPO/'Ubytec/Language').rglob('*.cs'))
    paths += [REPO/'Ubytec'/n for n in ('Program.cs','Ubytec.csproj','Language/Grammar/ubytec.tmLanguage.json')]
    paths += [REPO/'Ubytec.Tests'/n for n in ('Ubytec.Tests.csproj','HostIOCompilationTests.cs','TextAnalyzerTests.cs')]
    paths += [ROOT/n for n in ('arena.ubc','scalar.ubc','memory.ubc','vector.ubc','text-analyzer.ubc','text-io-probe.ubc','text-io-fault.ubc','text-reference.c','run_text.py','loans-reference.c')]
    paths += [p for p in (PROTO/'linux').iterdir() if p.suffix in ('.h','.c','.ld')]
    paths += [PROTO/n for n in ('common/contract.h','run.py','run_typed.py','ubytec/typed/caller.ubc','ubytec/typed/memory.ubc')]
    return {p.relative_to(REPO).as_posix():digest(p) for p in sorted(set(paths))}

def corpus():
    data=[('empty',b'',4096),('delimiters',bytes(i for i in range(256) if not(48<=i<=57 or 65<=i<=90 or 97<=i<=122 or i==95)),1),
          ('all_bytes',bytes(range(256)),17),('wide_word',(b'Ab_9'*5000+b' ')*2,4096),
          ('large_stream',b'Alpha beta beta _42 Z9\n'*50000,4096),
          ('unsorted_unique',b' '.join(('Token_%03d'%i).encode() for i in range(95,-1,-1)),7)]
    for chunk in (1,7,17,4096):data.append(('split_'+str(chunk),b'HELLO hello World\0word_42\xffZ9 _42 alpha BETA beta\nlast',chunk))
    rng=random.Random(420105)
    vocabulary=[('w_%02d'%i).encode() for i in range(32)]
    for i in range(16):
        words=[rng.choice(vocabulary) for _ in range(rng.randrange(1,500))]
        raw=b''.join((w.upper() if rng.randrange(2) else w)+rng.choice([b' ',b'\n',b'\0',b'\xff',b'!?']) for w in words)
        data.append(('random_words_'+str(i),raw,rng.choice([7,64,4096])))
    for i in range(12):data.append(('random_binary_'+str(i),bytes(rng.randrange(256) for _ in range(rng.randrange(512,8193))),4096))
    return data

def main():
    p=argparse.ArgumentParser();p.add_argument('--stack-transfers',action='store_true');p.add_argument('--frame-values',action='store_true');p.add_argument('--frame-registers',action='store_true');p.add_argument('--loop-reductions',action='store_true');p.add_argument('--block-reductions',action='store_true');p.add_argument('--compiler',type=Path);p.add_argument('--prepare-only',action='store_true');p.add_argument('--compile-only',action='store_true');p.add_argument('--assembly-directory',type=Path);p.add_argument('--dotnet',default='dotnet');p.add_argument('--output',type=Path,default=ROOT/'build/text');a=p.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    for n,s in sources().items():(out/(n+'.ubc')).write_text(s,encoding='utf-8')
    if a.prepare_only:print('Prepared sources; no compilation/tests executed.');return
    report={'schema':1,'stack_transfers':a.stack_transfers,'frame_values':a.frame_values,'frame_registers':a.frame_registers,'loop_reductions':a.loop_reductions,'block_reductions':a.block_reductions,'accepted':False,'platform':platform.platform(),'source_sha256':manifest(),'assembly_sha256':{},'composed_source_sha256':{},'oracle':{},'io_tests':{},'protected':{}}
    try:
        if not a.assembly_directory and not a.compiler:command([a.dotnet,'build',REPO/'Ubytec/Ubytec.csproj','-c','Release','-p:EnableDocFxOnBuild=false','-p:GenerateDocumentationFile=false','--nologo'])
        for n in sources():
            src=out/(n+'.ubc');asm=out/(n+'.nasm')
            if a.assembly_directory:
                if (a.assembly_directory/src.name).read_text(encoding='utf-8')!=src.read_text(encoding='utf-8'):raise RuntimeError('Staged source drift: '+n)
                shutil.copyfile(a.assembly_directory/src.name,src);shutil.copyfile(a.assembly_directory/asm.name,asm)
            else:
                flags=['--host-io'] if n.startswith('text-') else ['--library',*(['--module-calls'] if n=='caller' else [])]
                if a.stack_transfers:flags+=['--stack-transfers']
                if a.frame_values:flags+=['--frame-values']
                if a.frame_registers:flags+=['--frame-registers']
                if a.loop_reductions:flags+=['--loop-reductions']
                if a.block_reductions:flags+=['--block-reductions']
                command([a.dotnet,(a.compiler or REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll'),src,*flags,'-o',asm])
            report['assembly_sha256'][n]=digest(asm);report['composed_source_sha256'][n]=digest(src)
        if a.assembly_directory:
            proof=json.loads((a.assembly_directory/'text-provenance.json').read_text(encoding='utf-8-sig'))
            if proof.get('loop_reductions',False)!=a.loop_reductions:raise RuntimeError('Loop reduction option drift')
            if proof.get('block_reductions',False)!=a.block_reductions:raise RuntimeError('Block reduction option drift')
            if proof.get('frame_registers',False)!=a.frame_registers:raise RuntimeError('Frame register option drift')
            if proof.get('frame_values',False)!=a.frame_values:raise RuntimeError('Frame value option drift')
            if proof.get('stack_transfers',False)!=a.stack_transfers:raise RuntimeError('Stack transfer option drift')
            for key in ('source_sha256','assembly_sha256','composed_source_sha256'):
                if proof[key]!=report[key]:raise RuntimeError('Compiler provenance drift: '+key)
            report['compiler_sha256']=proof['compiler_sha256']
        else:report['compiler_sha256']=digest(a.compiler or REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll')
        proof={k:report[k] for k in ('source_sha256','assembly_sha256','composed_source_sha256','compiler_sha256','stack_transfers','frame_values','frame_registers','loop_reductions','block_reductions')};(out/'text-provenance.json').write_text(json.dumps(proof,indent=2)+'\n',encoding='utf-8')
        if a.compile_only:print('Compiled Ubytec sources; native/protected tests not executed.');return
        report['environment']={cc:command([cc,'--version']).splitlines()[0] for cc in ('gcc','clang')}
        for n in sources():command(['nasm','-f','elf64',out/(n+'.nasm'),'-o',out/(n+'.o')])
        runtime=out/'runtime.o';command(['gcc','-O2','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone','-c',PROTO/'linux/bridge-runtime.c','-o',runtime])
        for n in ('text-composed','text-probe','text-fault'):command(['ld','-T',PROTO/'linux/module.ld','-e','ubytec_host_contract_TextMain','-z','noexecstack',out/(n+'.o'),runtime,'-o',out/(n+'.elf')])
        cases=corpus();(out/'inputs').mkdir(exist_ok=True);(out/'expected').mkdir(exist_ok=True)
        expected={}
        for variant in ('gcc','clang','sanitized'):
            cc=variant if variant!='sanitized' else 'gcc';flags=['-O2'] if variant!='sanitized' else ['-O1','-g','-fsanitize=address,undefined','-fno-sanitize-recover=all','-fno-omit-frame-pointer']
            oracle=out/('oracle-'+variant);command([cc,'-std=c11',*flags,'-Wall','-Wextra','-Werror',ROOT/'text-reference.c','-o',oracle]);rows=[]
            for name,raw,chunk in cases:
                src=out/'inputs'/(name+'.bin');src.write_bytes(raw);dst=out/'expected'/(name+'.'+variant+'.txt');stats=json.loads(command([oracle,src,dst]));stats['sha256']=digest(dst)
                if variant=='gcc':expected[name]=stats
                elif stats!=expected[name]:raise RuntimeError('Independent C implementations disagree: '+name)
                rows.append({'case':name,**stats})
            report['oracle'][variant]=rows
            unit=out/('io-unit-'+variant);command([cc,'-std=c11',*flags,'-Wall','-Wextra','-Werror',PROTO/'linux/host-io-test.c','-o',unit]);unitrow=json.loads(command([unit]))
            transfer=out/('io-transfer-'+variant);command([cc,'-std=c11',*flags,'-Wall','-Wextra','-Werror','-DUBYTEC_BRIDGE_IO_TEST',PROTO/'linux/bridge-runtime.c',PROTO/'linux/host-io-transfer-test.c','-o',transfer]);transferrow=json.loads(command([transfer]));report['io_tests'][variant]={'service':unitrow,'transport':transferrow}
            if not unitrow['accepted'] or not transferrow['accepted']:raise RuntimeError('Host I/O tests rejected')
            print(variant+': PASS independent C oracle and host I/O tests',flush=True)
        for cc in ('gcc','clang'):
            host=out/('text-host-'+cc);command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror',PROTO/'linux/text-host.c','-o',host]);rows=[];dest=out/('actual-'+cc);dest.mkdir(exist_ok=True)
            def execute(name,src,module='text-composed',chunk=4096,flags=(),code=0):
                target=dest/(name+'.txt');target.write_bytes(b'PRESERVE EXISTING OUTPUT\n');before=digest(src)
                run=command([host,'--caller',out/(module+'.elf'),'--input',src,'--output',target,'--chunk',chunk,*flags],timeout=180,expected=code)
                metrics=next(json.loads(line) for line in run.splitlines() if line.startswith('{') and json.loads(line).get('event')=='text-result')
                if before!=digest(src):raise RuntimeError('Source file changed: '+name)
                if list(dest.glob(target.name+'.ubytec-*')):raise RuntimeError('Staged output leaked: '+name)
                return target,metrics,run
            for name,raw,chunk in cases:
                src=out/'inputs'/(name+'.bin');target,metrics,rawlog=execute(name,src,chunk=chunk)
                stats=expected[name]
                if not metrics['accepted'] or metrics['value'] or metrics['arena_used_after'] or digest(target)!=stats['sha256'] or any(metrics[k]!=stats[k] for k in ('bytes','words','unique','emitted')) or metrics['read_bytes']!=len(raw) or metrics['write_bytes']!=stats['emitted']:raise RuntimeError('Protected analyzer mismatch: '+name+'\n'+rawlog)
                rows.append({'case':name,'pass':True,'metrics':metrics,'sha256':digest(target)})
            failures=[('arena_zero',b'one',('--arena','0'),-2),('io_oom',b'one',('--arena','128'),-2),('token_oom',b'a'*3000,('--arena','2048','--chunk','64'),-2),('dictionary_oom',b' '.join(('word%d'%i).encode() for i in range(50)),('--arena','512','--chunk','64'),-2),('copy_oom',b'a'*40000,(),-2),('denied_read',b'one',('--deny-read',),-3),('denied_write',b'one',('--deny-write',),-5),('quota_zero',b'one',('--quota','0'),-5),('partial_quota',b'ab',('--quota','2'),-5)]
            for name,raw,flags,value in failures:
                src=out/'inputs'/(name+'.bin');src.write_bytes(raw);target,metrics,rawlog=execute(name,src,flags=flags,code=1)
                if metrics['accepted'] or not metrics['completed'] or metrics['value']!=value or metrics['arena_used_after'] or target.read_bytes()!=b'PRESERVE EXISTING OUTPUT\n':raise RuntimeError('Failed application lost cleanup/output contract: '+name+'\n'+rawlog)
                rows.append({'case':name,'pass':True,'metrics':metrics,'existing_output_preserved':True})
            src=out/'inputs/probe.bin';src.write_bytes(b'abc');target,metrics,_=execute('permission_probe',src,module='text-probe')
            if not metrics['accepted'] or target.read_bytes()!=b'abc' or metrics['denials']!=6 or metrics['read_bytes']!=3 or metrics['write_bytes']!=3:raise RuntimeError('Resource permissions failed')
            rows.append({'case':'permission_probe','pass':True,'metrics':metrics})
            target,metrics,_=execute('fault_after_write',src,module='text-fault',code=1)
            if metrics['accepted'] or metrics['completed'] or metrics['write_bytes']!=3 or target.read_bytes()!=b'PRESERVE EXISTING OUTPUT\n':raise RuntimeError('Fault published a partial output')
            rows.append({'case':'fault_after_write','pass':True,'metrics':metrics,'existing_output_preserved':True})
            legacy=out/('legacy-program-'+cc);command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror',PROTO/'linux/program.c','-o',legacy])
            packet=bytearray(65536);struct.pack_into('<4Q',packet,40,4096,65248,257,258);config=out/'legacy-config.bin';config.write_bytes(packet)
            rawlog=command([legacy,'--contracts',out/'text-composed.elf','TextMain','--input',config],timeout=10,expected=1)
            legacy_result=next(json.loads(line) for line in rawlog.splitlines() if line.startswith('{') and json.loads(line).get('case')=='program')
            if not legacy_result['protocol_rejected']:raise RuntimeError('Legacy supervisor did not reject host I/O')
            rows.append({'case':'legacy_supervisor_rejects_io','pass':True,'outcome':legacy_result})
            link=dest/'input-symlink';link.symlink_to(src)
            alias_target=dest/'same-inode';alias_target.hardlink_to(src) if hasattr(alias_target,'hardlink_to') else __import__('os').link(src,alias_target)
            for name,path,target in (('symlink_input',link,dest/'symlink-result.txt'),('same_inode_output',src,alias_target)):
                before=digest(src);command([host,'--caller',out/'text-composed.elf','--input',path,'--output',target],expected=2)
                if digest(src)!=before:raise RuntimeError('Setup rejection modified input')
                rows.append({'case':name,'pass':True,'setup_rejected':True})
            link.unlink();alias_target.unlink()
            report['protected'][cc]=rows;(out/('protected-'+cc+'.jsonl')).write_text(''.join(json.dumps(row)+'\n' for row in rows),encoding='utf-8');print(cc+': PASS '+str(len(rows))+' complete protected application/attack cases',flush=True)
        command([sys.executable,PROTO/'run_typed.py','--skip-benchmark','--assembly-directory',out,'--output',out/'typed-regression'],timeout=180)
        typed=json.loads((out/'typed-regression/typed-report.json').read_text());report['typed_regression']={'accepted':typed['accepted'],'checks_per_variant':{cc:len(rows) for cc,rows in typed['tests'].items()},'transport':typed['transport_tests'],'sanitizer':typed['sanitizer_tests']}
        if not typed['accepted']:raise RuntimeError('Existing typed loans regressed')
        report['scope']='Linux x64 native application; C oracle/service/transport instrumented, generated NASM not instrumented. No benchmark or ARM backend claim.';report['accepted']=True
    finally:(out/'text-report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
if __name__=='__main__':main()
