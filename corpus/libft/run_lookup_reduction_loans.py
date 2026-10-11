#!/usr/bin/env python3
"""Exercise generated nested lookup with two RO loans and worker-private pointer records."""
import argparse,json,re,struct
from pathlib import Path
from run_block_reduction_loans import command,sha,ROOT,REPO,PROTO
CALLER='''import Find from memory.Find (t_loan_ro,t_uint64,t_loan_ro,t_uint64) -> t_uint64
export Main as Main
module (name:"lookup_caller",version:"0.1",author:"Ubytec") {
func Main(t_uint64 buffer,t_uint64 length,t_uint64 foreign,t_uint64 monitor) -> t_int64 {
local { t_int64 status 0 }
load @buffer
push 32
add
load @buffer
load t_uint64
load @buffer
push 8
add
load t_uint64
load @buffer
push 32
add
load @buffer
load t_uint64
add
load @buffer
push 16
add
load t_uint64
load @buffer
push 24
add
load t_uint64
push 1000
load @buffer
load @length
add
push 8
sub
call Find
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
def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--dotnet',default='dotnet');p.add_argument('--compiler',type=Path)
    p.add_argument('--output',type=Path,default=ROOT/'build/lookup-loans');a=p.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    compiler=a.compiler or REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll'
    files=[ROOT/'run_lookup_reduction_loans.py',ROOT/'lookup-loan-fixture.c',ROOT/'run_block_reduction_loans.py',ROOT/'diagnose-kernels.ubc',
           PROTO/'linux/program.c',PROTO/'linux/bridge-runtime.c',PROTO/'linux/module.ld',*(PROTO/'linux').glob('*.h')]
    report={'accepted':False,'compiler_sha256':sha(compiler),'source_sha256':{f.relative_to(REPO).as_posix():sha(f) for f in files},
            'fixture':'native worker preparation of private records; compiler-generated lookup body; two RO loans','tests':{}}
    try:
        src=out/'caller.ubc';src.write_text(CALLER)
        command([a.dotnet,compiler,src,'--library','--module-calls','-o',out/'caller.nasm']);command(['nasm','-f','elf64',out/'caller.nasm','-o',out/'caller.o'])
        command(['gcc','-O2','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone','-c',PROTO/'linux/bridge-runtime.c','-o',out/'runtime.o'])
        command(['ld','-T',PROTO/'linux/module.ld','-e','ubytec_host_contract_Main','-z','noexecstack',out/'caller.o',out/'runtime.o','-o',out/'caller.elf'])
        command(['gcc','-O2','-Wall','-Wextra','-Werror','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone','-c',ROOT/'lookup-loan-fixture.c','-o',out/'fixture.o'])
        target=out/'memory.ubc';target.write_text('export DiagLookup as Find (t_loan_ro,t_uint64,t_loan_ro,t_uint64) -> t_uint64\n'+(ROOT/'diagnose-kernels.ubc').read_text())
        report['assembly_transform']='Only Find public adapter replaced with jmp fixture_lookup; generated kernel and candidate adapter unchanged'
        for mode in ('reference','reduction'):
            flags=['--library','--stack-transfers','--frame-registers']+(['--lookup-reductions'] if mode=='reduction' else [])
            original=out/(mode+'-original.nasm')
            command([a.dotnet,compiler,target,*flags,'--host-export','DiagLookup=ubytec_host_candidate_DiagLookup','-o',original])
            assembly=original.read_text();assert ('; lookup-reductions:' in assembly)==(mode=='reduction')
            pattern=r'(?m)^ubytec_host_contract_Find:\n.*?^ret\n';match=re.search(pattern,assembly,re.S);assert match
            assembly=assembly[:match.start()]+'extern fixture_lookup\nubytec_host_contract_Find:\n jmp fixture_lookup\n'+assembly[match.end():]
            (out/(mode+'.nasm')).write_text(assembly)
            command(['nasm','-f','elf64',out/(mode+'.nasm'),'-o',out/(mode+'.o')])
            command(['ld','-T',PROTO/'linux/module.ld','-e','ubytec_host_contract_Find','-z','noexecstack',out/(mode+'.o'),out/'fixture.o','-o',out/(mode+'.elf')])
        def execute(loader,mode,names,key,count,length=None,denied=False,failing=False):
            query=len(key) if length is None else length
            data=bytearray(struct.pack('<QQQQ',len(names),count,len(key),query)+names+key+b'\xa5'*16)
            (out/'input.bin').write_bytes(data)
            args=[loader,'--contracts',out/'caller.elf','Main','--module','memory',out/(mode+'.elf')]
            if not denied:args+=['--grant-many','Find','memory.Find',1,65536,1,65536,1000]
            raw=command([*args,'--input',out/'input.bin','--output',out/'output.bin'])
            rows=[json.loads(l) for l in raw.splitlines() if l.startswith('{')]
            result=next(r for r in rows if r.get('case')=='program');metrics=next(r for r in rows if r.get('event')=='program-result')
            assert result['pass'] and (out/'output.bin').read_bytes()[:-8]==data[:-8]
            if denied:expected=1;launches=0
            elif failing:expected=2;launches=1
            else:
                expected=next((i+1 for i in range(count) if names[i*8:i*8+query]==key[:query]),0);launches=1
                assert struct.unpack_from('<Q',(out/'output.bin').read_bytes(),len(data)-8)[0]==expected
            assert result['value']==expected and metrics['callee_launches']==launches,(mode,count,query,result,metrics,expected)
            return {'count':count,'query_length':query,'name_loan_bytes':len(names),'key_loan_bytes':len(key),'value':expected,'callee_launches':launches,'neighbors_preserved':True}
        names=b'abcdefghijklmnopqrstuvwx'
        for cc in ('gcc','clang'):
            loader=out/('loader-'+cc);command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror',PROTO/'linux/program.c','-o',loader])
            for mode in ('reference','reduction'):
                cases=[]
                for count,key in [(0,b'abcdefgh'),(1,b'abcdefgh'),(3,b'abcdefgh'),(3,b'ijklmnop'),(3,b'qrstuvwx'),(3,b'ABCDEFGH'),(3,b'abcdefgz'),(3,b'abcdefg'),(1,b'')]:
                    cases.append({'case':'authorized_lookup',**execute(loader,mode,names,key,count)})
                cases.append({'case':'fault_beyond_loans',**execute(loader,mode,bytes(4096),bytes(4096),1,length=4097,failing=True)})
                cases.append({'case':'ungranted',**execute(loader,mode,names,b'abcdefgh',3,denied=True)})
                cases.append({'case':'fresh_recovery',**execute(loader,mode,names,b'qrstuvwx',3)})
                report['tests'][cc+'_'+mode]=cases
        report['artifact_sha256']={f.name:sha(f) for f in out.iterdir() if f.suffix in ('.nasm','.ubc','.elf')}
        report['accepted']=True;print('PASS 48 protected nested lookups with two RO loans, faults, denied grants and fresh recovery',flush=True)
    finally:(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
