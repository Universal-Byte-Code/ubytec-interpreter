#!/usr/bin/env python3
"""CLI opt-in/opt-out and error publication checks, with no corpus in cwd."""
import argparse,hashlib,json,subprocess,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parent;REPO=ROOT.parents[1]
def main():
    p=argparse.ArgumentParser();p.add_argument('--dotnet',default='dotnet');p.add_argument('--output',type=Path,required=True);a=p.parse_args()
    dll=REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll';rows=[]
    module='module (name:"cli_test",version:"0.1",author:"Ubytec") {\nfunc Main() -> t_int64 {\npush 0\nreturn\n}\n}\n'
    source='import X from memory.X (t_loan_ro) -> t_int64\n'+module
    with tempfile.TemporaryDirectory(prefix='ubytec-cli-check-') as t:
        temp=Path(t);inp=temp/'source.ubc';asm=temp/'output.nasm';generated=temp/'generated.ubc'
        def run(name,args,ok,content=source,inspection=True):
            inp.write_text(content,encoding='utf-8');asm.write_text('KEEP');generated.write_text('KEEP')
            result=subprocess.run([a.dotnet,str(dll),str(inp),*map(str,args),'-o',str(asm)],cwd=temp,capture_output=True,text=True,timeout=30)
            if (result.returncode==0)!=ok:raise RuntimeError(name+': '+result.stdout+result.stderr)
            if not ok and (asm.read_text()!='KEEP' or inp.read_text()!=content or generated.read_text()!='KEEP'):raise RuntimeError(name+': failed command changed output/source')
            if ok and inspection and 'func Arena_X' not in generated.read_text():raise RuntimeError(name+': missing inspection source')
            rows.append({'case':name,'pass':True});return result
        run('bundled-arena-alone',['--arena-imports','--generated-source',generated],True)
        run('tail-calls-compatible',['--arena-imports','--tail-calls','--generated-source',generated],True)
        run('optional-inspection',['--arena-imports'],True,inspection=False)
        run('raw-mode-unchanged',['--library','--module-calls'],True,inspection=False)
        if generated.read_text()!='KEEP':raise RuntimeError('Raw mode wrote generated output')
        run('inspection-requires-mode',['--generated-source',generated],False)
        run('cannot-overwrite-input',['--arena-imports','--generated-source',inp],False)
        run('cannot-share-assembly-path',['--arena-imports','--generated-source',asm],False)
        run('cannot-share-json-path',['--arena-imports','--generated-source',generated,'--json',generated],False)
        run('no-imports',['--arena-imports','--generated-source',generated],False,content=module)
        run('legacy-contract',['--arena-imports','--generated-source',generated],False,content=source.replace('t_loan_ro','t_uint64,t_uint64,t_uint64,t_uint64'))
        run('wrapper-collision',['--arena-imports','--generated-source',generated],False,content=source.replace('Main','Arena_X'))
        run('library-collision',['--arena-imports','--generated-source',generated],False,content=source.replace('Main','ArenaAlloc'))
        run('already-generated',['--arena-imports','--generated-source',generated],False,content=source+'// BEGIN GENERATED ARENA IMPORTS\n')
    report={'accepted':True,'tests':rows,'compiler_sha256':hashlib.sha256(dll.read_bytes()).hexdigest(),'runs_without_corpus_in_cwd':True}
    a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
    print(f'PASS {len(rows)} integrated arena CLI checks')
if __name__=='__main__':main()
