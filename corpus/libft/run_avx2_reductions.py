#!/usr/bin/env python3
"""Validate native AVX2/SSE2 selection, page/fault ledgers and paired working sets."""
import argparse, hashlib, json, os, re, subprocess, sys
from pathlib import Path
import run_codegen_comparison as comparison
from run_text_diagnostics import functions
ROOT=comparison.ROOT;REPO=comparison.REPO
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def command(args,env=None):
    run=subprocess.run([str(a) for a in args],capture_output=True,text=True,timeout=300,env=env)
    if run.returncode:raise RuntimeError(str(args)+'\n'+run.stdout+run.stderr)
    return run.stdout
def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dotnet',default='dotnet');parser.add_argument('--compiler',type=Path)
    parser.add_argument('--verify-only',action='store_true',help='Validate without running timing measurements')
    parser.add_argument('--output',type=Path,default=ROOT/'build/avx2-reductions');a=parser.parse_args()
    out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    compiler=a.compiler or REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll'
    files=['Ubytec/Language/Tools/Optimization/BlockByteReductionPlan.cs',
           'Ubytec/Language/Tools/Optimization/ByteReductionPlan.cs','Ubytec/Language/Tools/Optimization/FunctionValueIR.cs',
           'Ubytec/Language/Operations/FunctionEmitter.cs','Ubytec/Language/AST/SourceCompiler.cs',
           'Ubytec/Language/Syntax/Scopes/CompilationScopes.cs','Ubytec/Program.cs',
           'Ubytec.Tests/LoopReductionTests.cs','Ubytec.Tests/BlockReductionTests.cs',
           'corpus/libft/run_avx2_reductions.py','corpus/libft/block-reduction-faults.c',
           'corpus/libft/diagnose-kernels.ubc','corpus/libft/run_codegen_comparison.py',
           'corpus/libft/reduction-compare.c','corpus/libft/reduction-candidates.nasm',
           'corpus/libft/reduction-intrinsics.c','corpus/libft/diagnose-kernels.c']
    report={'accepted':False,'compiler_sha256':sha(compiler),'source_sha256':{n:sha(REPO/n) for n in files},'assembly_sha256':{}}
    try:
        source=out/'kernels.ubc';source.write_bytes((ROOT/'diagnose-kernels.ubc').read_bytes())
        for mode,symbol,extra in [('reference','register',[]),('scalar','loop',['--loop-reductions']),('block','block',['--block-reductions']),('native','native_block',['--block-reductions-native']),('portable','portable',['--block-reductions-native'])]:
            asm=out/(mode+'.nasm')
            command([a.dotnet,compiler,source,'--library','--stack-transfers','--frame-registers',*extra,
                     '--host-export','DiagBytes=ubytec_host_'+symbol+'_DiagBytes','-o',asm],
                    env={**os.environ,'DOTNET_EnableAVX2':'0','COMPlus_EnableAVX2':'0'} if mode=='portable' else None)
            report['assembly_sha256'][mode]=sha(asm)
            command(['nasm','-f','elf64',asm,'-o',out/(mode+'.o')])
        report['vector_loops']={}
        for mode in ('block','native','portable'):
            assembly=(out/(mode+'.nasm')).read_text()
            avx='page-bounded AVX2' in assembly
            if mode!='native':assert not avx and 'ymm' not in assembly
            body=next(body for name,label,body in functions(assembly) if name=='DiagBytes')
            middle='_avx2' if avx else ''
            match=re.search(r'_block_reduce'+middle+r'_four:\s*\n(.*?)^\s*\w+_block_reduce'+middle+r'_single:',body,re.M|re.S);assert match
            instructions=[line.strip() for line in match[1].splitlines() if line.strip() and not line.strip().startswith(';')]
            assert len(instructions)==16 and sum(line.startswith('vmovdqa' if avx else 'movdqa') for line in instructions)==4
            assert not any(line.startswith('mov qword [') or line.startswith('push ') for line in instructions)
            if avx:assert 'vzeroupper' in body and 'vmovdqa xmm1' in body and 'vpaddq ymm2, ymm2, ymm1' in body
            report['vector_loops'][mode]={'isa':'AVX2' if avx else 'SSE2','bytes_per_iteration':128 if avx else 64,'instructions':16,'vector_reads':4,'memory_writes':0,
                                          'page_limit':4096,'scalar_probe_before_vectors':True,'accumulators':4}
        report['native_target']=report['vector_loops']['native']['isa']
        report['forced_fallback']={'DOTNET_EnableAVX2':'0','COMPlus_EnableAVX2':'0','isa':report['vector_loops']['portable']['isa']}
        report['faults']={}
        for cc in ('gcc','clang'):
            exe=out/('faults-'+cc)
            command([cc,'-O2','-Wall','-Wextra','-Werror','-DWITH_NATIVE_BLOCK_REDUCTION','-no-pie',ROOT/'block-reduction-faults.c',
                     out/'reference.o',out/'scalar.o',out/'block.o',out/'native.o',out/'portable.o','-o',exe])
            raw=command([exe]);(out/(cc+'-faults.json')).write_text(raw)
            report['faults'][cc]=json.loads(raw);assert report['faults'][cc]['accepted']
        print('PASS five-variant SIGSEGV/SIGBUS ledger, GCC/Clang hosts; native target '+report['native_target'],flush=True)
        if a.verify_only:
            report['verification_accepted']=True
            report['measurements_executed']=False
            return
        command([sys.executable,ROOT/'run_codegen_comparison.py','--ubytec-assembly',out/'reference.nasm',
                 '--loop-reduction-assembly',out/'scalar.nasm','--block-reduction-assembly',out/'block.nasm',
                 '--native-block-reduction-assembly',out/'native.nasm','--large-working-sets','--output',out/'comparison'])
        measured=json.loads((out/'comparison/report.json').read_text());assert measured['accepted']
        report['comparison']=measured
        report['speedup_over_sse2']={n:v['ubytec_block_reductions']['median_ns']/v['ubytec_native_block_reductions']['median_ns']
                           for n,v in measured['results'].items()}
        report['verification_accepted']=True
        report['measurements_executed']=True
        report['accepted']=True
        print('PASS interleaved SSE2/native compiler reductions, C and SIMD prototypes over six working sets',flush=True)
    finally:(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
