#!/usr/bin/env python3
"""Exercise the generated SSE2 reduction inside fresh protected region-loan workers."""
import argparse, hashlib, json, struct, subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parent;REPO=ROOT.parents[1];PROTO=REPO/'prototypes/isolation'
CALLER='''import Fold from memory.Fold (t_loan_ro,t_uint64) -> t_uint64
export Main as Main
module (name:"block_caller",version:"0.1",author:"Ubytec") {
func Main(t_uint64 buffer,t_uint64 length,t_uint64 foreign,t_uint64 monitor) -> t_int64 {
local { t_int64 status 0 }
load @buffer
push 16
add
load @buffer
load t_uint64
load @buffer
push 8
add
load t_uint64
push 1000
load @buffer
load @length
add
push 8
sub
call Fold
store @status
if @status != 0
load @status
return
end
load @buffer
load @length
add
push 8
sub
load t_int64
return
}
}
'''
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def command(args):
    result=subprocess.run([str(x) for x in args],capture_output=True,text=True,timeout=180)
    if result.returncode:raise RuntimeError(str(args)+'\n'+result.stdout+result.stderr)
    return result.stdout
def run(dotnet,compiler,out):
    out=out.resolve();out.mkdir(parents=True,exist_ok=True)
    files=[ROOT/'run_block_reduction_loans.py',ROOT/'diagnose-kernels.ubc',PROTO/'linux/program.c',
           PROTO/'linux/bridge-runtime.c',PROTO/'linux/module.ld']
    files+=list((PROTO/'linux').glob('*.h'))
    report={'accepted':False,'compiler_sha256':sha(compiler),'source_sha256':{p.relative_to(REPO).as_posix():sha(p) for p in files},'tests':{}}
    try:
        caller=out/'caller.ubc';caller.write_text(CALLER)
        target=out/'memory.ubc';target.write_text('export DiagBytes as Fold (t_loan_ro,t_uint64) -> t_uint64\n'+(ROOT/'diagnose-kernels.ubc').read_text())
        command([dotnet,compiler,caller,'--library','--module-calls','-o',out/'caller.nasm'])
        command(['nasm','-f','elf64',out/'caller.nasm','-o',out/'caller.o'])
        command(['gcc','-O2','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone','-c',PROTO/'linux/bridge-runtime.c','-o',out/'runtime.o'])
        command(['ld','-T',PROTO/'linux/module.ld','-e','ubytec_host_contract_Main','-z','noexecstack',out/'caller.o',out/'runtime.o','-o',out/'caller.elf'])
        for mode,option in (('scalar','--loop-reductions'),('block','--block-reductions')):
            command([dotnet,compiler,target,'--library',option,'-o',out/(mode+'.nasm')])
            if mode=='block':assert '; block-reductions:' in (out/(mode+'.nasm')).read_text()
            command(['nasm','-f','elf64',out/(mode+'.nasm'),'-o',out/(mode+'.o')])
            command(['ld','-T',PROTO/'linux/module.ld','-e','ubytec_host_contract_Fold','-z','noexecstack',out/(mode+'.o'),'-o',out/(mode+'.elf')])
        input_file=out/'input.bin';output_file=out/'output.bin'
        def execute(loader,mode,n,requested=None,denied=False,salt=3):
            data=bytearray([0xa5])*(n+32);struct.pack_into('<QQ',data,0,n,n if requested is None else requested)
            data[16:16+n]=bytes((i*17+salt)%256 for i in range(n));input_file.write_bytes(data)
            args=[loader,'--contracts',out/'caller.elf','Main','--module','memory',out/(mode+'.elf')]
            if not denied:args+=['--grant-many','Fold','memory.Fold',1,65536,0,0,1000]
            raw=command([*args,'--input',input_file,'--output',output_file])
            records=[json.loads(line) for line in raw.splitlines() if line.startswith('{')]
            result=next(r for r in records if r.get('case')=='program')
            metrics=next(r for r in records if r.get('event')=='program-result')
            assert result['pass'] and output_file.read_bytes()[:-8]==data[:-8]
            if denied:expected=1;launches=0
            elif requested is not None and requested>n:expected=2;launches=1
            else:
                expected=sum(data[16:16+n]);launches=1
                assert struct.unpack_from('<Q',output_file.read_bytes(),len(data)-8)[0]==expected
            assert result['value']==expected and metrics['callee_launches']==launches,(mode,n,requested,result,metrics)
            return {'bytes':n,'requested':requested if requested is not None else n,'value':expected,'callee_launches':launches,'neighbors_preserved':True}
        for cc in ('gcc','clang'):
            loader=out/('loader-'+cc)
            command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror',PROTO/'linux/program.c','-o',loader])
            for mode in ('scalar','block'):
                rows=[]
                for n in (0,1,15,16,17,31,32,63,64,65,127,128,255,256,4096,65504):
                    rows.append({'case':'authorized_read',**execute(loader,mode,n)})
                rows.append({'case':'fault_beyond_loan_mapping',**execute(loader,mode,4096,requested=4097)})
                rows.append({'case':'ungranted',**execute(loader,mode,128,denied=True)})
                rows.append({'case':'fresh_recovery',**execute(loader,mode,65,salt=91)})
                report['tests'][cc+'_'+mode]=rows
        report['artifact_sha256']={p.name:sha(p) for p in out.iterdir() if p.suffix in ('.ubc','.nasm','.elf')}
        report['accepted']=True
        print('PASS 76 protected scalar/block reads, fault containment, denied grant and fresh recovery',flush=True)
        return report
    finally:(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--dotnet',default='dotnet');parser.add_argument('--compiler',type=Path)
    parser.add_argument('--output',type=Path,default=ROOT/'build/block-loans');args=parser.parse_args()
    run(args.dotnet,args.compiler or REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',args.output)
if __name__=='__main__':main()
