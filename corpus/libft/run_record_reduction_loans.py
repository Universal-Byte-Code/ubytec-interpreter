#!/usr/bin/env python3
"""Execute scalar record reductions in real protected loan workers."""
import argparse,json,struct
from pathlib import Path
from run_block_reduction_loans import CALLER,command,sha,ROOT,REPO,PROTO
def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--dotnet',default='dotnet');p.add_argument('--compiler',type=Path)
    p.add_argument('--output',type=Path,default=ROOT/'build/record-loans');a=p.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    compiler=a.compiler or REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll'
    files=[ROOT/'run_record_reduction_loans.py',ROOT/'run_block_reduction_loans.py',ROOT/'diagnose-kernels.ubc',
           PROTO/'linux/program.c',PROTO/'linux/bridge-runtime.c',PROTO/'linux/module.ld',*(PROTO/'linux').glob('*.h')]
    report={'accepted':False,'compiler_sha256':sha(compiler),'source_sha256':{f.relative_to(REPO).as_posix():sha(f) for f in files},'tests':{}}
    try:
        caller=out/'caller.ubc';caller.write_text(CALLER)
        target=out/'memory.ubc';target.write_text('export DiagRecords as Fold (t_loan_ro,t_uint64) -> t_uint64\n'+(ROOT/'diagnose-kernels.ubc').read_text())
        command([a.dotnet,compiler,caller,'--library','--module-calls','-o',out/'caller.nasm']);command(['nasm','-f','elf64',out/'caller.nasm','-o',out/'caller.o'])
        command(['gcc','-O2','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone','-c',PROTO/'linux/bridge-runtime.c','-o',out/'runtime.o'])
        command(['ld','-T',PROTO/'linux/module.ld','-e','ubytec_host_contract_Main','-z','noexecstack',out/'caller.o',out/'runtime.o','-o',out/'caller.elf'])
        for mode in ('reference','reduction'):
            flags=['--library','--stack-transfers','--frame-registers']+(['--record-reductions'] if mode=='reduction' else [])
            command([a.dotnet,compiler,target,*flags,'-o',out/(mode+'.nasm')]);assert ('; record-reductions:' in (out/(mode+'.nasm')).read_text())==(mode=='reduction')
            command(['nasm','-f','elf64',out/(mode+'.nasm'),'-o',out/(mode+'.o')])
            command(['ld','-T',PROTO/'linux/module.ld','-e','ubytec_host_contract_Fold','-z','noexecstack',out/(mode+'.o'),'-o',out/(mode+'.elf')])
        def execute(loader,mode,count,loan_bytes=None,requested=None,denied=False,salt=3):
            n=24*count if loan_bytes is None else loan_bytes;req=count if requested is None else requested
            data=bytearray([0xa5])*(n+32);struct.pack_into('<QQ',data,0,n,req)
            data[16:16+n]=bytes((i*17+salt)%256 for i in range(n));(out/'input.bin').write_bytes(data)
            args=[loader,'--contracts',out/'caller.elf','Main','--module','memory',out/(mode+'.elf')]
            if not denied:args+=['--grant-many','Fold','memory.Fold',1,65536,0,0,1000]
            raw=command([*args,'--input',out/'input.bin','--output',out/'output.bin'])
            rows=[json.loads(l) for l in raw.splitlines() if l.startswith('{')]
            result=next(r for r in rows if r.get('case')=='program');metrics=next(r for r in rows if r.get('event')=='program-result')
            assert result['pass'] and (out/'output.bin').read_bytes()[:-8]==data[:-8]
            if denied:expected=1;launches=0
            elif requested is not None:expected=2;launches=1
            else:
                expected=sum(int.from_bytes(data[16+i*24+16:16+i*24+24],'little') for i in range(count))%(1<<64);launches=1
                assert struct.unpack_from('<Q',(out/'output.bin').read_bytes(),len(data)-8)[0]==expected
                # The public bridge reports Int64 even when the exported value is UInt64.
                if expected>=1<<63:expected-=1<<64
            assert result['value']==expected and metrics['callee_launches']==launches,(mode,count,result,metrics,expected)
            return {'records':count,'loan_bytes':n,'requested_records':req,'value':expected,'callee_launches':launches,'neighbors_preserved':True}
        for cc in ('gcc','clang'):
            loader=out/('loader-'+cc);command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror',PROTO/'linux/program.c','-o',loader])
            for mode in ('reference','reduction'):
                tests=[{'case':'authorized_read',**execute(loader,mode,n)} for n in (0,1,2,3,4,7,8,16,64,128,256,1024,2729)]
                tests+=[{'case':'fault_beyond_mapping',**execute(loader,mode,0,loan_bytes=4096,requested=171)},
                        {'case':'ungranted',**execute(loader,mode,128,denied=True)},
                        {'case':'fresh_recovery',**execute(loader,mode,3,salt=91)}]
                report['tests'][cc+'_'+mode]=tests
        report['artifact_sha256']={f.name:sha(f) for f in out.iterdir() if f.suffix in ('.ubc','.nasm','.elf')}
        report['accepted']=True;print('PASS 64 protected record reads, faults, denied grants and fresh recovery',flush=True)
    finally:(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
