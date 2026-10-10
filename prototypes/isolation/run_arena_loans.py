#!/usr/bin/env python3
"""Scoped arena loans, malicious receivers and same-worker recovery."""
import argparse,hashlib,json,platform,shutil,signal,struct,subprocess,time
from pathlib import Path
from run import command,records
ROOT=Path(__file__).resolve().parent;REPO=ROOT.parents[1]
NAMES=('loan-caller','loan-receiver')
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    p=argparse.ArgumentParser();p.add_argument('--assembly-directory',type=Path);p.add_argument('--output',type=Path,default=ROOT/'build/arena-loans');a=p.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    sources=['corpus/libft/arena.ubc']+['prototypes/isolation/'+n for n in ('run_arena_loans.py','run.py','linux/program.c','linux/modules.c','linux/contracts.h','linux/many-service.h','linux/many-wire.h','linux/isolation.c','linux/bridge-runtime.c','linux/arena-transport-inject.c','linux/module.ld','common/contract.h')]+['prototypes/isolation/ubytec/arena/'+n+'.ubc' for n in NAMES]
    report={'schema':1,'accepted':False,'platform':platform.platform(),'source_sha256':{s:digest(REPO/s) for s in sources},'tests':{},'assembly_sha256':{}}
    try:
        lib=(REPO/'corpus/libft/arena.ubc').read_text().split('{',1)[1].rsplit('}',1)[0]
        if lib not in (ROOT/'ubytec/arena/loan-caller.ubc').read_text():raise RuntimeError('Arena library drift')
        if not a.assembly_directory:command(['dotnet','build',REPO/'Ubytec/Ubytec.csproj','-c','Release','-p:EnableDocFxOnBuild=false','-p:GenerateDocumentationFile=false','--nologo'])
        for name in NAMES:
            asm=out/(name+'.nasm')
            if a.assembly_directory:shutil.copyfile(a.assembly_directory/(name+'.nasm'),asm)
            else:command(['dotnet',REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',ROOT/('ubytec/arena/'+name+'.ubc'),'--library',*(['--module-calls'] if name=='loan-caller' else []),'-o',asm])
            report['assembly_sha256'][name]=digest(asm);command(['nasm','-f','elf64',asm,'-o',out/(name+'.o')])
        runtime=out/'runtime.o';command(['gcc','-O2','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone','-c',ROOT/'linux/bridge-runtime.c','-o',runtime])
        for name,entry in (('loan-caller','LoanMain'),('loan-receiver','Touch')):command(['ld','-T',ROOT/'linux/module.ld','-e','ubytec_host_contract_'+entry,'-z','noexecstack',out/(name+'.o'),*([runtime] if name=='loan-caller' else []),'-o',out/(name+'.elf')])
        flags=['gcc','-O2','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone']
        command(flags+['-DUBYTEC_BRIDGE_IO_TEST','-c',ROOT/'linux/bridge-runtime.c','-o',out/'injected-runtime.o'])
        command(flags+['-c',ROOT/'linux/arena-transport-inject.c','-o',out/'inject.o'])
        command(['ld','-T',ROOT/'linux/module.ld','-e','ubytec_host_contract_LoanMain','-z','noexecstack',out/'loan-caller.o',out/'injected-runtime.o',out/'inject.o','-o',out/'loan-caller-injected.elf'])
        for cc in ('gcc','clang'):
            loader=out/('arena-loans-'+cc);command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror',ROOT/'linux/program.c','-o',loader]);rows=[]
            cases=[('success',0,0,34,8,None,8),('header-attack',1,2,17,0,None,8),('neighbor-attack',2,2,17,0,None,8),('timeout',3,3,17,0,None,8),('cancel',4,4,17,0,None,8),('negative-result-commits',5,0,51,-77,None,8),('read-only-write',6,2,17,0,None,8),('nested-owner-pin',7,0,34,8,None,8),('missing-grant',1,1,17,0,'HeaderAttack',8),('length-ceiling',1,1,17,0,None,7),('invalid-local-selection',8,1,17,0,None,8)]
            cases.append(('transport-failure',0,5,17,0,None,8))
            for name,mode,status,byte,value,deny,maximum in cases:
                data=bytearray([0xa5])*1200;struct.pack_into('<18Q',data,0,mode,*([0]*17));inp=out/'input.bin';actual=out/'actual.bin';inp.write_bytes(data)
                caller='loan-caller-injected.elf' if name=='transport-failure' else 'loan-caller.elf'
                argv=[str(loader),'--contracts',str(out/caller),'LoanMain','--module','arena_receiver',str(out/'loan-receiver.elf')]
                for alias in ('Touch','HeaderAttack','Escape','Spin','Negative','ReadOnly'):
                    if alias==deny:continue
                    argv += ['--grant-many',alias,'arena_receiver.'+alias,'1' if alias=='ReadOnly' else '3',str(maximum if alias=='HeaderAttack' else 8),'0','0','none' if alias=='Spin' else '1000']
                argv += ['--input',str(inp),'--output',str(actual)]
                proc=subprocess.Popen(argv,stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True)
                try:
                    if mode==4:
                        time.sleep(.25)
                        if proc.poll() is not None:raise RuntimeError('Unbounded call returned before cancellation')
                        proc.send_signal(signal.SIGUSR1)
                    stdout,stderr=proc.communicate(timeout=5)
                finally:
                    if proc.poll() is None:proc.kill();proc.wait()
                rs=records(stdout);r=next((x for x in rs if x.get('case')=='program'),{});metrics=next((x for x in rs if x.get('event')=='program-result'),{})
                got=actual.read_bytes() if actual.exists() else b''
                expected=(mode,status,value&((1<<64)-1),0,0,1 if mode==7 else 0,byte,1,0,8)
                if proc.returncode or stderr or not r.get('pass') or r.get('value')!=status or len(got)!=1200 or struct.unpack_from('<10Q',got,0)!=expected:
                    raise RuntimeError(cc+' '+name+': '+stdout+stderr+' fields='+str(struct.unpack_from('<10Q',got,0) if len(got)>=80 else got))
                # The receiver was lent exactly 8 payload bytes, never arena headers.
                # Recovery succeeded in this same root invocation; final free restored used=0.
                if got[-16:]!=bytes([0xa5])*16 or struct.unpack_from('<Q',got,152)[0]!=0 or struct.unpack_from('<Q',got,128)[0]!=34:raise RuntimeError('Arena lifetime or neighboring memory changed')
                if struct.unpack_from('<2Q',got,144)!=(1024,0) or struct.unpack_from('<4Q',got,160)!=(16,0,0,0) or got[192:208]!=bytes([34])+bytes(15) or got[208:]!=data[208:]:raise RuntimeError('Allocator metadata, copied data or neighboring bytes changed')
                launches=1 if status in (1,5) else 2
                if metrics.get('callee_launches')!=launches:raise RuntimeError('Unexpected callee launch count')
                rows.append({'case':name,'pass':True,'status':status,'same_worker_recovery':True})
            report['tests'][cc]=rows;print(cc+': PASS '+str(len(rows))+' scoped arena loan cases',flush=True)
        report['accepted']=True
    finally:(out/'arena-loans-report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
