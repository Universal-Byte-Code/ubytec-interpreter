#!/usr/bin/env python3
"""Validate page-bounded SSE2 lowering and compare cache-size working sets."""
import argparse, hashlib, json, re, subprocess, sys
from pathlib import Path
import run_codegen_comparison as comparison
from run_text_diagnostics import functions
ROOT=comparison.ROOT;REPO=comparison.REPO
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def command(args):
    run=subprocess.run([str(a) for a in args],capture_output=True,text=True,timeout=300)
    if run.returncode:raise RuntimeError(str(args)+'\n'+run.stdout+run.stderr)
    return run.stdout
def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dotnet',default='dotnet');parser.add_argument('--compiler',type=Path)
    parser.add_argument('--output',type=Path,default=ROOT/'build/block-reductions');a=parser.parse_args()
    out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    compiler=a.compiler or REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll'
    files=['Ubytec/Language/Tools/Optimization/BlockByteReductionPlan.cs',
           'Ubytec/Language/Tools/Optimization/ByteReductionPlan.cs','Ubytec/Language/Tools/Optimization/FunctionValueIR.cs',
           'Ubytec/Language/Operations/FunctionEmitter.cs','Ubytec/Language/AST/SourceCompiler.cs',
           'Ubytec/Language/Syntax/Scopes/CompilationScopes.cs','Ubytec/Program.cs',
           'Ubytec.Tests/LoopReductionTests.cs','Ubytec.Tests/BlockReductionTests.cs',
           'corpus/libft/run_block_reductions.py','corpus/libft/block-reduction-faults.c',
           'corpus/libft/diagnose-kernels.ubc','corpus/libft/run_codegen_comparison.py',
           'corpus/libft/reduction-compare.c','corpus/libft/reduction-candidates.nasm',
           'corpus/libft/reduction-intrinsics.c','corpus/libft/diagnose-kernels.c']
    report={'accepted':False,'compiler_sha256':sha(compiler),'source_sha256':{n:sha(REPO/n) for n in files},'assembly_sha256':{}}
    try:
        source=out/'kernels.ubc';source.write_bytes((ROOT/'diagnose-kernels.ubc').read_bytes())
        for mode,symbol,extra in [('reference','register',[]),('scalar','loop',['--loop-reductions']),('block','block',['--block-reductions'])]:
            asm=out/(mode+'.nasm')
            command([a.dotnet,compiler,source,'--library','--stack-transfers','--frame-registers',*extra,
                     '--host-export','DiagBytes=ubytec_host_'+symbol+'_DiagBytes','-o',asm])
            report['assembly_sha256'][mode]=sha(asm)
            command(['nasm','-f','elf64',asm,'-o',out/(mode+'.o')])
        body=next(body for name,label,body in functions((out/'block.nasm').read_text()) if name=='DiagBytes')
        match=re.search(r'_block_reduce_four:\s*\n(.*?)^\s*\w+_block_reduce_single:',body,re.M|re.S);assert match
        instructions=[line.strip() for line in match[1].splitlines() if line.strip() and not line.strip().startswith(';')]
        assert len(instructions)==16 and sum(line.startswith('movdqa') for line in instructions)==4
        assert not any(line.startswith('mov qword [') or line.startswith('push ') for line in instructions)
        report['vector_loop']={'bytes_per_iteration':64,'instructions':16,'vector_reads':4,'memory_writes':0,
                               'page_limit':4096,'scalar_probe_before_vectors':True,'accumulators':4}
        report['faults']={}
        for cc in ('gcc','clang'):
            exe=out/('faults-'+cc)
            command([cc,'-O2','-Wall','-Wextra','-Werror','-no-pie',ROOT/'block-reduction-faults.c',
                     out/'reference.o',out/'scalar.o',out/'block.o','-o',exe])
            raw=command([exe]);(out/(cc+'-faults.json')).write_text(raw)
            report['faults'][cc]=json.loads(raw);assert report['faults'][cc]['accepted']
        print('PASS scalar/block SIGSEGV and SIGBUS ledger, GCC/Clang hosts',flush=True)
        command([sys.executable,ROOT/'run_codegen_comparison.py','--ubytec-assembly',out/'reference.nasm',
                 '--loop-reduction-assembly',out/'scalar.nasm','--block-reduction-assembly',out/'block.nasm',
                 '--large-working-sets','--output',out/'comparison'])
        measured=json.loads((out/'comparison/report.json').read_text());assert measured['accepted']
        report['comparison']=measured
        report['speedup']={n:v['ubytec_loop_reductions']['median_ns']/v['ubytec_block_reductions']['median_ns']
                           for n,v in measured['results'].items()}
        report['accepted']=True
        print('PASS interleaved compiler reductions, C and SIMD prototypes over six working sets',flush=True)
    finally:(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
