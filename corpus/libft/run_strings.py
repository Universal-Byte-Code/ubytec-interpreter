#!/usr/bin/env python3
"""Compile the libft string composition and compare native output with C."""
import argparse,hashlib,json,os,platform,shutil,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parent;REPO=ROOT.parents[1]
STRING_EXPORTS=('ft_strchr','ft_strrchr','ft_memchr','ft_strnlen','ft_strncmp','ft_strlcpy','ft_strlcat','ft_strnstr','ft_strdup_arena','ft_substr_arena','ft_strjoin_arena','ArenaInit','ArenaAlloc','ArenaFree','ArenaPin','ArenaUnpin')
UNSIGNED={'UnsignedDiv':'udiv','UnsignedMod':'umod','LogicalShift':'lshr','UnsignedLt':'ult','UnsignedLe':'ule','UnsignedGt':'ugt','UnsignedGe':'uge'}
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def sources():
    def body(name):
        s=(ROOT/(name+'.ubc')).read_text();return s.split('{',1)[1].rsplit('}',1)[0]
    strings=''.join('export '+n+' as '+n+'\n' for n in STRING_EXPORTS)+'module (name:"libft_strings_native",version:"0.1",author:"Ubytec") {\n'+''.join(body(n) for n in ('strings','arena','arena-strings'))+'\n}\n'
    unsigned=''.join('export '+n+' as '+n+'\n' for n in UNSIGNED)+'module (name:"unsigned_native",version:"0.1",author:"Ubytec") {\n'+''.join('func '+n+'(t_uint64 a,t_uint64 b) -> t_uint64 {\nload @a\nload @b\n'+op+'\nreturn\n}\n' for n,op in UNSIGNED.items())+'}\n'
    return {'strings-composed':strings,'unsigned':unsigned}
def command(args,timeout=120,env=None):
    proc=subprocess.run([str(x) for x in args],capture_output=True,text=True,timeout=timeout,env=env)
    if proc.returncode:raise RuntimeError(str(args)+'\n'+proc.stdout+'\n'+proc.stderr)
    return proc.stdout
def main():
    p=argparse.ArgumentParser();p.add_argument('--prepare-only',action='store_true');p.add_argument('--assembly-directory',type=Path);p.add_argument('--output',type=Path,default=ROOT/'build/strings');a=p.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    for n,s in sources().items():(out/(n+'.ubc')).write_text(s)
    if a.prepare_only:print('Prepared composed Ubytec sources; no tests executed.');return
    paths=['corpus/libft/'+n for n in ('strings.ubc','arena.ubc','arena-strings.ubc','strings-reference.c','run_strings.py')]
    paths+=['Ubytec/Language/Operations/'+n+'.cs' for n in ('ArithmeticOperations','BitwiseOperations','ComparisonOperations','OpCodeFactory','FunctionStackValidator')]
    paths+=['Ubytec/Language/AST/ASTCompiler.cs','Ubytec/Language/AST/SourceCompiler.cs','Ubytec/Language/Grammar/ubytec.tmLanguage.json','Ubytec.Tests/UnsignedOpcodeTests.cs','Ubytec.Tests/LibftStringTests.cs','Ubytec.Tests/GuardedCString.cs','Ubytec.Tests/Ubytec.Tests.csproj']
    report={'schema':1,'accepted':False,'platform':platform.platform(),'source_sha256':{s:digest(REPO/s) for s in paths},'assembly_sha256':{},'composed_source_sha256':{n:digest(out/(n+'.ubc')) for n in sources()},'tests':{}}
    try:
        if not a.assembly_directory:command(['dotnet','build',REPO/'Ubytec/Ubytec.csproj','-c','Release','-p:EnableDocFxOnBuild=false','-p:GenerateDocumentationFile=false','--nologo'])
        for n in sources():
            asm=out/(n+'.nasm')
            if a.assembly_directory:
                if (a.assembly_directory/(n+'.ubc')).read_text()!=(out/(n+'.ubc')).read_text():raise RuntimeError('Composed source mismatch: '+n)
                # Preserve the exact compiled bytes (including host line endings).
                shutil.copyfile(a.assembly_directory/(n+'.ubc'),out/(n+'.ubc'));report['composed_source_sha256'][n]=digest(out/(n+'.ubc'))
                shutil.copyfile(a.assembly_directory/(n+'.nasm'),asm)
            else:command(['dotnet',REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',out/(n+'.ubc'),'--library','-o',asm])
            report['assembly_sha256'][n]=digest(asm);command(['nasm','-f','elf64',asm,'-o',out/(n+'.o')])
        if a.assembly_directory:
            provenance=json.loads((a.assembly_directory/'strings-provenance.json').read_text(encoding='utf-8-sig'))
            if provenance['assembly_sha256']!=report['assembly_sha256'] or provenance['composed_source_sha256']!=report['composed_source_sha256']:raise RuntimeError('Staged compiler provenance mismatch')
            shutil.copyfile(a.assembly_directory/'strings-provenance.json',out/'strings-provenance.json');report['compiler_sha256']=provenance['compiler_sha256']
        else:report['compiler_sha256']=digest(REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll')
        report['environment']={cc:command([cc,'--version']).splitlines()[0] for cc in ('gcc','clang')};report['environment']['nasm']=command(['nasm','-v']).strip()
        for cc in ('gcc','clang','sanitized'):
            exe=out/('strings-'+cc);flags=['-O2'] if cc!='sanitized' else ['-O1','-g','-fsanitize=address,undefined','-fno-sanitize-recover=all','-fno-omit-frame-pointer']
            command([cc if cc!='sanitized' else 'gcc','-std=c11',*flags,'-Wall','-Wextra','-Werror','-no-pie',ROOT/'strings-reference.c',out/'strings-composed.o',out/'unsigned.o','-o',exe])
            env=dict(os.environ);env['ASAN_OPTIONS']='handle_sigfpe=0';raw=command([exe],env=env);(out/('strings-'+cc+'.jsonl')).write_text(raw);row=json.loads(raw)
            if not row.get('accepted') or row['zero_divisor_signals']!=2 or row['string_rounds']!=512 or row['allocation_rounds']!=256:raise RuntimeError('Incomplete native corpus')
            if cc!='gcc' and row!=report['tests']['gcc']:raise RuntimeError('Resource/check counts disagree')
            report['tests'][cc]=row;print(cc+': PASS '+str(row['total_checks'])+' C/reference, guard, allocation and unsigned checks',flush=True)
        report['sanitizer_scope']='C oracle/client instrumented; NASM checked by guard pages, byte comparisons and canaries';report['accepted']=True
    finally:(out/'strings-report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
