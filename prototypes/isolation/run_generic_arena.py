#!/usr/bin/env python3
"""Generic generated loans and the three-stage arena-backed text application."""
import argparse,hashlib,json,platform,random,shutil,signal,struct,subprocess,time
from pathlib import Path
from run import command,records
from generate_arena_imports import generate,emit_wrappers
ROOT=Path(__file__).resolve().parent;REPO=ROOT.parents[1];MASK=(1<<64)-1
NAMES=('pair-caller','pair-receiver','dynamic-text','lexer','mapper','writer')
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def field(b,o):return struct.unpack_from('<Q',b,o)[0]
def main():
    p=argparse.ArgumentParser();p.add_argument('--assembly-directory',type=Path);p.add_argument('--output',type=Path,default=ROOT/'build/generic-arena');a=p.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
    sources=['corpus/libft/arena.ubc','Ubytec/Program.cs','Ubytec/Ubytec.csproj','Ubytec/Language/AST/ArenaImportGenerator.cs','Ubytec/Language/AST/ModuleContracts.cs','Ubytec/Language/AST/SourceCompiler.cs']+['prototypes/isolation/'+n for n in ('run_generic_arena.py','check_arena_cli.py','generate_arena_imports.py','generic_text_cli.py','run.py','linux/program.c','linux/modules.c','linux/contracts.h','linux/many-service.h','linux/many-wire.h','linux/isolation.c','linux/bridge-runtime.c','linux/arena-transport-inject.c','linux/module.ld','common/contract.h')]
    paths={n:ROOT/('ubytec/'+('text/' if n in ('lexer','mapper','writer') else 'arena/')+n+'.ubc') for n in NAMES}
    sources += [str(p.relative_to(REPO)) for p in paths.values()]+['prototypes/isolation/ubytec/arena/'+n+'.ubc' for n in ('pair-source','dynamic-text-source')]
    report={'schema':1,'accepted':False,'platform':platform.platform(),'source_sha256':{s:digest(REPO/s) for s in sources},'tests':{},'assembly_sha256':{}}
    try:
        library=(REPO/'corpus/libft/arena.ubc').read_text()
        for name,template in (('pair-caller','pair-source'),('dynamic-text','dynamic-text-source')):
            expected=generate((ROOT/('ubytec/arena/'+template+'.ubc')).read_text(),library)
            if paths[name].read_text()!=expected:raise RuntimeError('Generated wrapper drift: '+name)
            generated=out/('generated-'+name+'.ubc')
            command(['python3',ROOT/'generate_arena_imports.py',ROOT/('ubytec/arena/'+template+'.ubc'),'--arena-library',REPO/'corpus/libft/arena.ubc','-o',generated])
            if generated.read_text()!=expected:raise RuntimeError('Generator CLI drift')
        rejects=0
        for args,result in [('t_loan_rw,t_loan_ro,t_loan_ro','t_int64'),('t_byte','t_int64'),('t_uint64','t_void'),(','.join(['t_uint64']*7),'t_int64'),(','.join(['t_uint64']*4),'t_int64')]:
            try:emit_wrappers(f'import X from m.f ({args}) -> {result}\nmodule (name:"x") {{}}')
            except ValueError:rejects+=1
            else:raise RuntimeError('Invalid contract accepted')
        for args in ('','t_int64,t_uint64','t_uint64,t_loan_ro,t_int64,t_loan_rw','t_loan_ro'):
            emit_wrappers(f'import X from m.f ({args}) -> t_uint64\nmodule (name:"x") {{}}')
        try:generate('import X from m.f (t_loan_ro) -> t_int64\nmodule (name:"x") {func Arena_X() -> t_int64 {push 0 return}}')
        except ValueError:rejects+=1
        else:raise RuntimeError('Collision accepted')
        report['generator_checks']={'valid':4,'rejections':rejects,'generated_fixture_equality':2,'cli':2}
        if not a.assembly_directory:command(['dotnet','build',REPO/'Ubytec/Ubytec.csproj','-c','Release','-p:EnableDocFxOnBuild=false','-p:GenerateDocumentationFile=false','--nologo'])
        cli_checks=out/'arena-cli-checks.json'
        if a.assembly_directory:shutil.copyfile(a.assembly_directory/'arena-cli-checks.json',cli_checks)
        else:command(['python3',ROOT/'check_arena_cli.py','--output',cli_checks])
        cli_report=json.loads(cli_checks.read_text())
        if not cli_report.get('accepted') or len(cli_report.get('tests',[]))!=13:raise RuntimeError('Integrated CLI checks failed')
        report['integrated_cli_checks']={'passed':True,'count':13,'report_sha256':digest(cli_checks),'compiler_sha256':cli_report['compiler_sha256']}

        for n in NAMES:
            asm=out/(n+'.nasm')
            if a.assembly_directory:shutil.copyfile(a.assembly_directory/(n+'.nasm'),asm)
            else:
                if n in ('pair-caller','dynamic-text'):
                    template='pair-source' if n=='pair-caller' else 'dynamic-text-source'
                    command(['dotnet',REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',ROOT/('ubytec/arena/'+template+'.ubc'),'--arena-imports','--generated-source',out/('cli-'+n+'.ubc'),'-o',asm])
                else:command(['dotnet',REPO/'Ubytec/bin/Release/net9.0/Ubytec.dll',paths[n],'--library','-o',asm])
            if n in ('pair-caller','dynamic-text'):
                cli_source=out/('cli-'+n+'.ubc')
                if a.assembly_directory:shutil.copyfile(a.assembly_directory/('cli-'+n+'.ubc'),cli_source)
                if cli_source.read_text()!=paths[n].read_text():raise RuntimeError('Integrated compiler generation drift: '+n)
                report.setdefault('cli_generated_sha256',{})[n]=digest(cli_source)
            report['assembly_sha256'][n]=digest(asm);command(['nasm','-f','elf64',asm,'-o',out/(n+'.o')])
        runtime=out/'runtime.o';command(['gcc','-O2','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone','-c',ROOT/'linux/bridge-runtime.c','-o',runtime])
        for n,entry in zip(NAMES,('PairMain','Copy','DynamicText','ParseFields','UpperText','BuildText')):command(['ld','-T',ROOT/'linux/module.ld','-e','ubytec_host_contract_'+entry,'-z','noexecstack',out/(n+'.o'),*([runtime] if n in ('pair-caller','dynamic-text') else []),'-o',out/(n+'.elf')])
        flags=['gcc','-O2','-ffreestanding','-fno-builtin','-fno-stack-protector','-fno-pic','-mcmodel=large','-mno-red-zone']
        command(flags+['-DUBYTEC_BRIDGE_IO_TEST','-c',ROOT/'linux/bridge-runtime.c','-o',out/'injected-runtime.o'])
        command(flags+['-c',ROOT/'linux/arena-transport-inject.c','-o',out/'inject.o'])
        command(['ld','-T',ROOT/'linux/module.ld','-e','ubytec_host_contract_PairMain','-z','noexecstack',out/'pair-caller.o',out/'injected-runtime.o',out/'inject.o','-o',out/'pair-injected.elf'])
        inp=out/'input.bin';actual=out/'actual.bin'
        def execute(argv,cancel=False):
            proc=subprocess.Popen([str(x) for x in argv],stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True)
            try:
                if cancel:
                    time.sleep(.25)
                    if proc.poll() is not None:raise RuntimeError('Unbounded call returned before cancellation')
                    proc.send_signal(signal.SIGUSR1)
                stdout,stderr=proc.communicate(timeout=10)
            finally:
                if proc.poll() is None:proc.kill();proc.wait()
            rs=records(stdout);r=next((r for r in rs if r.get('case')=='program'),{});metrics=next((r for r in rs if r.get('event')=='program-result'),{})
            if proc.returncode or stderr or not r.get('pass'):raise RuntimeError(stdout+stderr)
            return r['value'],actual.read_bytes(),metrics
        for cc in ('gcc','clang'):
            loader=out/('generic-'+cc);command([cc,'-std=c11','-O2','-Wall','-Wextra','-Werror',ROOT/'linux/program.c','-o',loader]);rows=[]
            for mode in range(21):
                data=bytearray([0xa5])*2208;struct.pack_into('<16Q',data,0,mode,*([0]*15));inp.write_bytes(data)
                argv=[loader,'--contracts',out/('pair-injected.elf' if mode==13 else 'pair-caller.elf'),'PairMain','--module','pair_receiver',out/'pair-receiver.elf']
                for alias in ('Copy','Partial','Spin','Negative','DualWrite','Reverse','Mixed','Scalar','Empty','Six'):
                    if mode==9 and alias=='Partial':continue
                    rights=(3,3) if alias=='DualWrite' else (1,3) if alias in ('Reverse','Mixed') else (0,0) if alias in ('Scalar','Empty') else (3,1)
                    argv += ['--grant-many',alias,'pair_receiver.'+alias,rights[0],16 if rights[0] else 0,rights[1],16 if rights[1] else 0,'none' if alias=='Spin' else 1000]
                argv += ['--input',inp,'--output',actual];value,got,metrics=execute(argv,mode==7)
                status=1 if mode in (1,2,9,10,11,20) else 2 if mode==5 else 3 if mode==6 else 4 if mode==7 else 5 if mode==13 else 0
                native=-77 if mode==8 else 0 if status or mode==12 else 4294967280 if mode in (16,17) else 13 if mode==18 else 4294967287 if mode==19 else 8
                pins=(1,1) if mode==3 else (0,65536) if mode==2 else (65535,0) if mode==20 else (0,0)
                expected=bytearray(range(1,17))
                if not status and mode<12:expected[4:12]=bytes(range(3,11)) if mode==4 else bytes(range(99,107))
                if mode==14:expected[4]=204
                if mode==16:expected[4]=99
                expected_source=bytearray(range(97,113))
                if mode==14:expected_source[2]=221
                if mode==15:expected_source[2]=5
                if value!=status or tuple(field(got,i) for i in (8,16,24,32,40,48,56,64,72))!=(status,native&MASK,*pins,0,0,16,1,1) or got[80:96]!=expected or got[-16:]!=data[-16:] or metrics['callee_launches']!=(1 if status in (1,5) else 2):raise RuntimeError(f'{cc} pair {mode}: invalid status/pins/data/recovery')
                if got[224:240]!=expected_source or got[176:192]!=expected_source or field(got,136)!=0 or got[240:]!=data[240:]:raise RuntimeError('Neighbor or arena lifecycle changed')
                if struct.unpack_from('<4Q',got,144)!=(16,0,0,0) or struct.unpack_from('<4Q',got,192)!=(16,0,0,0):raise RuntimeError('Allocator metadata changed')
                rows.append({'case':'pair-'+str(mode),'pass':True})
            texts=[b'',b' hola, mundo ,, ubytec ',b' \t\n,\v\f,, ',b'a\x00z,\xffb,\x80',b',a,,b,,',b'a'*4096]
            rng=random.Random(42044)
            texts += [bytes(rng.choice(b' abZ,\t\n\x00\xff') for _ in range(rng.randrange(1,256))) for _ in range(20)]
            textcases=[('text-'+str(i),t,32768,256,len(t)+1,None) for i,t in enumerate(texts)]
            textcases += [('token-oom',b'a,b,c',32768,2,6,None),('output-oom',b'a,b',32768,16,3,None),('arena-oom',b'a,b',40,16,4,None),('no-fields-empty',b'',32768,0,1,None),('no-output',b'',32768,0,0,None),('denied-render',b'a,b',32768,16,4,'Render'),('read-only-ceiling',b'a,b',32768,16,4,'readonly')]
            for name,text,capacity,fields,outcap,deny in textcases:
                data=bytearray([0xa5])*(96+len(text)+capacity+outcap);struct.pack_into('<8Q',data,0,len(text),capacity,fields,outcap,0,0,0,0);data[64:64+len(text)]=text;inp.write_bytes(data)
                argv=[loader,'--contracts',out/'dynamic-text.elf','DynamicText']
                for module in ('lexer','mapper','writer'):argv += ['--module',module,out/(module+'.elf')]
                for alias,target,r0 in (('Tokenize','lexer.ParseFields',3),('Normalize','mapper.UpperText',3),('Render','writer.BuildText',1 if deny=='readonly' else 3)):
                    if alias==deny:continue
                    argv += ['--grant-many',alias,target,r0,65536,1,65536,1000]
                argv += ['--input',inp,'--output',actual];value,got,metrics=execute(argv)
                pieces=[s.strip(b' \t\r\n\v\f') for s in text.split(b',')];pieces=[s for s in pieces if s];expected=b'|'.join(pieces).upper()
                error=-20 if capacity==40 else -11 if len(pieces)>fields else -101 if deny else -12 if len(expected)+1>outcap else len(expected)
                base=64+len(text);published=base+16+capacity
                if value!=error or field(got,48)!=(error&MASK) or got[:32]!=data[:32] or got[64:64+len(text)]!=text or got[-16:]!=data[-16:] or field(got,base+8)!=0:raise RuntimeError(f'{cc} {name}: result {value} expected {error}, geometry/source/lifetime mismatch')
                if error>=0:
                    if field(got,32)!=len(expected) or field(got,40)!=len(pieces) or got[published:published+len(expected)+1]!=expected+b'\0':raise RuntimeError('Published text mismatch')
                elif got[published:published+outcap]!=data[published:published+outcap]:raise RuntimeError('Failed application published output')
                rows.append({'case':name,'pass':True,'value':value})
            report['tests'][cc]=rows;print(cc+': PASS '+str(len(rows))+' generic arena/application cases',flush=True)
        filein=out/'example.txt';fileout=out/'example-output.txt'
        for text,expected in ((b' hola, mundo ,, ubytec ',b'HOLA|MUNDO|UBYTEC'),(b'a\0z,\xffb',b'A\0Z|\xffB'),(b'',b'')):
            filein.write_bytes(text);command(['python3',ROOT/'generic_text_cli.py','--artifacts',out,'--input',filein,'--output',fileout])
            if fileout.read_bytes()!=expected:raise RuntimeError('File driver output')
        filein.write_bytes(b'a,b');fileout.write_bytes(b'KEEP')
        for options in (['--capacity','0'],['--fields','1']):
            proc=subprocess.run(['python3',str(ROOT/'generic_text_cli.py'),'--artifacts',str(out),'--input',str(filein),'--output',str(fileout),*options],capture_output=True,timeout=10)
            if not proc.returncode or fileout.read_bytes()!=b'KEEP':raise RuntimeError('File driver failure published output')
        report['file_driver_checks']=5
        report['accepted']=True
    finally:(out/'generic-arena-report.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main()
