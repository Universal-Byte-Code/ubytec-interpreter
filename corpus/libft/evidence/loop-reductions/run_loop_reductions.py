#!/usr/bin/env python3
"""Measure the compiler's scalar byte-reduction lowering and its fault ledger."""
import argparse, hashlib, json, re, subprocess, sys
from pathlib import Path
import run_codegen_comparison as comparison
from run_text_diagnostics import functions

ROOT=comparison.ROOT;REPO=comparison.REPO
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def command(args):
    p=subprocess.run([str(a) for a in args],capture_output=True,text=True,timeout=300)
    if p.returncode:raise RuntimeError(str(args)+'\n'+p.stdout+p.stderr)
    return p.stdout
def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dotnet',default='dotnet');parser.add_argument('--compiler',type=Path)
    parser.add_argument('--output',type=Path,default=ROOT/'build/loop-reductions');a=parser.parse_args()
    out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    compiler=a.compiler or REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll'
    files=['Ubytec/Language/Tools/Optimization/ByteReductionPlan.cs','Ubytec/Language/Tools/Optimization/FunctionValueIR.cs',
           'Ubytec/Language/Operations/FunctionEmitter.cs','Ubytec/Language/AST/SourceCompiler.cs',
           'Ubytec/Language/Syntax/Scopes/CompilationScopes.cs','Ubytec/Program.cs','Ubytec.Tests/LoopReductionTests.cs',
           'corpus/libft/run_loop_reductions.py','corpus/libft/loop-reduction-faults.c','corpus/libft/diagnose-kernels.ubc']
    report={'accepted':False,'compiler_sha256':sha(compiler),'source_sha256':{n:sha(REPO/n) for n in files},'assembly_sha256':{},'loop_analysis':{}}
    try:
        source=out/'kernels.ubc';source.write_bytes((ROOT/'diagnose-kernels.ubc').read_bytes())
        for mode,symbol in [('reference','ubytec_host_register_DiagBytes'),('reduction','ubytec_host_loop_DiagBytes')]:
            asm=out/(mode+'.nasm');flags=['--library','--stack-transfers','--frame-registers']
            if mode=='reduction':flags+=['--loop-reductions']
            command([a.dotnet,compiler,source,*flags,'--host-export','DiagBytes='+symbol,'-o',asm])
            text=asm.read_text();assert ('; loop-reductions:' in text)==(mode=='reduction')
            report['assembly_sha256'][mode]=sha(asm)
            body=next(body for name,label,body in functions(text) if name=='DiagBytes')
            pattern=(r'_start_byte_reduce:\s*\n(.*?)^\s*\w+_byte_reduce_done:' if mode=='reduction'
                     else r'^\s*while_[^\n]+: ; WHILE start\s*\n(.*?)^\s*end_while_')
            match=re.search(pattern,body,re.M|re.S);assert match,'Closed loop must be present'
            instructions=[line.strip() for line in match[1].splitlines() if line.strip() and not line.strip().startswith(';')]
            writes=sum(line.startswith('push ') or re.match(r'mov qword \[',line) is not None for line in instructions)
            reads=sum(line.startswith('pop ') or re.match(r'mov\w* \w+, (?:qword |byte )?\[',line) is not None for line in instructions)
            report['loop_analysis'][mode]={'instructions':len(instructions),'memory_writes':writes,'memory_reads':reads}
            assert (len(instructions),writes,reads)==((18,7,1) if mode=='reduction' else (28,10,4))
            command(['nasm','-f','elf64',asm,'-o',out/(mode+'.o')])
        report['faults']={}
        for cc in ('gcc','clang'):
            exe=out/('faults-'+cc)
            command([cc,'-O2','-Wall','-Wextra','-Werror','-no-pie',ROOT/'loop-reduction-faults.c',out/'reference.o',out/'reduction.o','-o',exe])
            raw=command([exe]);(out/(cc+'-faults.json')).write_text(raw)
            report['faults'][cc]=json.loads(raw);assert report['faults'][cc]['accepted']
        print('PASS byte fault address, memory ledger and RSP, GCC/Clang hosts',flush=True)
        command([sys.executable,ROOT/'run_codegen_comparison.py','--ubytec-assembly',out/'reference.nasm',
                 '--loop-reduction-assembly',out/'reduction.nasm','--output',out/'comparison'])
        measured=json.loads((out/'comparison/report.json').read_text());assert measured['accepted']
        report['comparison']=measured
        report['speedup']={n:v['ubytec_frame_registers']['median_ns']/v['ubytec_loop_reductions']['median_ns']
                           for n,v in measured['results'].items()}
        report['accepted']=True
        print('PASS interleaved compiled Ubytec, scalar/vector C and SIMD prototypes',flush=True)
    finally:(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
