#!/usr/bin/env python3
"""Stateful text application: C oracle, domain variants, capacity failures and timings."""
import argparse,hashlib,json,platform,random,shutil,struct,subprocess,sys,time
from pathlib import Path
from run import command,records
ROOT=Path(__file__).resolve().parent
REPO=ROOT.parents[1]
NAMES=("mono","caller","lexer","mapper","writer","grouped")
VARIANTS=(("Mono","mono",0),("Split","caller",3),("Group","caller",1))
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def packet(text,fields=16,capacity=None,outcap=None):
    capacity=len(text) if capacity is None else capacity
    outcap=len(text)+1 if outcap is None else outcap
    if len(text)>capacity:raise ValueError("input capacity")
    data=bytearray([0xa5])*(112+2*capacity+16*fields+outcap)
    if len(data)>65536:raise ValueError("root loan limit")
    struct.pack_into("<8Q",data,0,len(text),capacity,fields,outcap,0,0,0,0)
    state=64+capacity
    struct.pack_into("<4Q",data,state,0,fields,len(text),capacity)
    data[64:64+len(text)]=text
    return data

def main():
    p=argparse.ArgumentParser()
    p.add_argument("--assembly-directory",type=Path)
    p.add_argument("--output",type=Path,default=ROOT/"build/text")
    p.add_argument("--skip-benchmark",action="store_true")
    args=p.parse_args();out=args.output.resolve();out.mkdir(parents=True,exist_ok=True)
    sources=["prototypes/isolation/"+n for n in ("run_text.py","text-reference.c","text_cli.py","run.py","linux/program.c","linux/modules.c",
        "linux/contracts.h","linux/many-service.h","linux/many-wire.h","linux/isolation.c","linux/bridge-runtime.c","linux/module.ld","common/contract.h")]
    sources += ["prototypes/isolation/ubytec/text/"+n+".ubc" for n in NAMES]
    sources += ["corpus/libft/"+n for n in ("memory.ubc","scalar.ubc","text.ubc")]
    report={"schema":1,"accepted":False,"source_sha256":{n:digest(REPO/n) for n in sources},
        "environment":{"platform":platform.platform(),"artifact_directory":str(out)},"tests":{},"benchmarks":[]}
    try:
        canonical=(REPO/"corpus/libft/text.ubc").read_text()
        def body(name):
            start=canonical.index("func "+name);end=canonical.find("\nfunc ",start+1)
            return canonical[start:end if end!=-1 else canonical.rfind("}")].strip()
        for function,providers in (("ScanFields",("mono","lexer","grouped")),("ParseFields",("mono","lexer","grouped")),
            ("UpperText",("mono","mapper","grouped")),("BuildText",("mono","writer","grouped")),("RunText",("mono","grouped")),("ValidateText",("mono","caller"))):
            for name in providers:
                if body(function) not in (ROOT/("ubytec/text/"+name+".ubc")).read_text():raise RuntimeError("Application body drift: "+function+" "+name)
        for filename,function,next_function in (("scalar.ubc","ft_isspace","ft_atoi"),("scalar.ubc","ft_toupper","ft_tolower"),("memory.ubc","ft_memcpy","ft_memmove")):
            source=(REPO/("corpus/libft/"+filename)).read_text();part=source[source.index("func "+function):source.index("func "+next_function)].strip()
            if part not in canonical:raise RuntimeError("Original libft body drift: "+function)
        report["compilation"]={"mode":"precompiled-assembly-handoff" if args.assembly_directory else "source-compiled-in-runner"}
        if not args.assembly_directory:
            dll=REPO/"Ubytec/bin/Release/net9.0/Ubytec.dll"
            command(["dotnet","build",REPO/"Ubytec/Ubytec.csproj","-c","Release","-p:EnableDocFxOnBuild=false","-p:GenerateDocumentationFile=false","--nologo"])
            report["compilation"]["compiler_sha256"]=digest(dll)
        for name in NAMES:
            asm=out/(name+".nasm")
            if args.assembly_directory:shutil.copyfile(args.assembly_directory/(name+".nasm"),asm)
            else:command(["dotnet",dll,ROOT/("ubytec/text/"+name+".ubc"),"--library",*(["--module-calls"] if name=="caller" else []),"-o",asm])
            command(["nasm","-f","elf64",asm,"-o",out/(name+".o")])
        runtime=out/"runtime.o"
        command(["gcc","-O2","-ffreestanding","-fno-builtin","-fno-stack-protector","-fno-pic","-mcmodel=large","-mno-red-zone","-c",ROOT/"linux/bridge-runtime.c","-o",runtime])
        for name,entry in (("mono","Mono"),("caller","Split"),("lexer","ParseFields"),("mapper","UpperText"),("writer","BuildText"),("grouped","RunText")):
            command(["ld","-T",ROOT/"linux/module.ld","-e","ubytec_host_contract_"+entry,"-z","noexecstack",out/(name+".o"),*([runtime] if name=="caller" else []),"-o",out/(name+".elf")])
        oracle=out/"reference"
        command(["gcc","-std=c11","-O2","-Wall","-Wextra","-Werror",ROOT/"text-reference.c","-o",oracle])
        inp=out/"input.bin";actual=out/"actual.bin";expected=out/"expected.bin"
        def cli(loader,entry,artifact="caller",deny=None,render_rights=3,outputs=True,profile=False):
            argv=[loader,"--contracts",out/(artifact+".elf"),entry]
            if artifact=="caller":
                for name in ("lexer","mapper","writer","grouped"):argv += ["--module",name,out/(name+".elf")]
                for alias,target,r0,r1 in (("Tokenize","lexer.ParseFields",3,1),("Normalize","mapper.UpperText",3,1),
                    ("Render","writer.BuildText",render_rights,1),("Pipeline","grouped.RunText",3,1),
                    ("SourceAttack","lexer.SourceWrite",1,0),("OutputAttack","writer.PartialBuild",3,1),("StateAttack","mapper.EscapeState",3,1)):
                    if deny=="all" or deny==alias:continue
                    argv += ["--grant-many",alias,target,r0,65536,r1,65536 if r1 else 0,1000]
            argv += ["--input",inp]
            if outputs:argv += ["--output",actual]
            if profile:argv += ["--profile"]
            return [str(a) for a in argv]
        def execute(argv):
            proc=subprocess.run(argv,capture_output=True,text=True,timeout=10)
            if proc.returncode or proc.stderr:raise RuntimeError(proc.stdout+proc.stderr)
            rs=records(proc.stdout);result=next(r for r in rs if r.get("case")=="program")
            metrics=next(r for r in rs if r.get("event")=="program-result")
            if not result["pass"]:raise RuntimeError("Caller failed: "+proc.stdout)
            metrics["profile"]=next((r for r in rs if r.get("event")=="profile-result"),{})
            return result["value"],metrics
        vectors=[("empty",packet(b"")),("one",packet(b" hola ")), ("fields",packet(b" hola, mundo ,, ubytec ")),
            ("whitespace",packet(b" \t\r\n,\v\f,, ")), ("binary",packet(b" a\0z,\xffb,\x80 ")),
            ("internal_spaces",packet(b" a b , c d ")), ("trailing_delimiter",packet(b",a,,b,,")),
            ("zero_fields",packet(b" , ",fields=0)), ("no_fields_capacity",packet(b"x",fields=0)),
            ("token_capacity_exact",packet(b"a,b,c",fields=3)),("token_capacity_exceeded",packet(b"a,b,c",fields=2)),
            ("output_capacity_exact",packet(b"a,b",outcap=4)),("output_capacity_small",packet(b"a,b",outcap=3)),
            ("zero_output_capacity",packet(b"",outcap=0)), ("unused_capacity",packet(b"a,b",capacity=40,outcap=30)),
            ("max_fields",packet(b",".join([b"x"]*256),fields=256)),
            ("large_field",packet(b"a"*16000,fields=1)),("large_fields",packet(b",".join([b"Ab c"*120]*32),fields=32))]
        for name,offset,value in (("invalid_input_length",0,65537),
                ("invalid_field_count",16,257),("invalid_state_header",64+3+8,17),("invalid_root_geometry",8,65536)):
            data=packet(b"a,b");struct.pack_into("<Q",data,offset,value);vectors.append((name,data))
        for name,offset in (("max_u64_length",0),("max_u64_capacity",8),("max_u64_fields",16),("max_u64_output",24)):
            for high in (1<<63,(1<<64)-1):
                data=packet(b"a,b");struct.pack_into("<Q",data,offset,high);vectors.append((name+"_"+str(high),data))
        for size in (32,64,96):vectors.append(("short_root_"+str(size),packet(b"a,b")[:size]))
        rng=random.Random(42042)
        alphabet=b"abcXYZ019 \t\n\x00\x80\xff"
        for i in range(24):
            fields=[bytes(rng.choice(alphabet) for _ in range(rng.randrange(0,30))) for _ in range(rng.randrange(0,20))]
            text=b",".join(fields);vectors.append(("random_"+str(i),packet(text,fields=rng.randrange(0,21),outcap=rng.choice([0,len(text)+1,max(1,len(text)//2)]))))
        for cc in ("gcc","clang"):
            report["environment"][cc]=command([cc,"--version"]).splitlines()[0]
            loader=out/("text-"+cc)
            command([cc,"-std=c11","-O2","-Wall","-Wextra","-Werror",ROOT/"linux/program.c","-o",loader])
            rows=[]
            for name,data in vectors:
                inp.write_bytes(data);reference=int(command([oracle,inp,expected]).strip())
                for entry,artifact,count in VARIANTS:
                    value,metrics=execute(cli(loader,entry,artifact))
                    if value!=reference or actual.read_bytes()!=expected.read_bytes():raise RuntimeError("C mismatch: "+name+" "+entry)
                    expected_launches=0 if artifact=="mono" or reference==-10 else 1 if entry=="Group" or reference==-11 else 3
                    if metrics["callee_launches"]!=expected_launches:raise RuntimeError("Unexpected invocation count")
                    rows.append({"case":name+"_"+entry,"pass":True,"value":value,"callee_launches":metrics["callee_launches"]})
            for corrupt_name,data in (("populated",packet(b"a,b")),("empty_no_fields",packet(b"",fields=0)),("empty",packet(b"")),("spaces_no_fields",packet(b" \t ",fields=0))):
                inp.write_bytes(data);reference=int(command([oracle,inp,expected,"corrupt"]).strip())
                for entry,artifact,count in (("MonoCorrupt","mono",0),("SplitCorrupt","caller",3),("GroupCorrupt","caller",1)):
                    value,metrics=execute(cli(loader,entry,artifact))
                    expected_launches=2 if entry=="SplitCorrupt" and corrupt_name!="populated" else count
                    if value!=-13 or reference!=-13 or actual.read_bytes()!=expected.read_bytes() or metrics["callee_launches"]!=expected_launches:raise RuntimeError("Corrupted descriptor escaped validation: "+entry+" "+corrupt_name)
                    rows.append({"case":entry+"_"+corrupt_name,"pass":True,"value":value})
            for name,entry,deny,rights,value,launches in (("source_readonly","SourceFault",None,3,-102,1),("mapper_cannot_write_table","StateFault",None,3,-102,2),
                ("output_partial_fault","OutputFault",None,3,-102,3),("ungranted_render","Split","Render",3,-101,2),
                ("readonly_output_ceiling","Split",None,1,-101,2),("import_no_authority","Group","all",3,-101,0)):
                data=packet(b" hola, mundo ");inp.write_bytes(data)
                result,metrics=execute(cli(loader,entry,deny=deny,render_rights=rights))
                after=actual.read_bytes();cap=struct.unpack_from("<Q",data,8)[0];f=struct.unpack_from("<Q",data,16)[0]
                output_start=96+2*cap+16*f
                if result!=value or metrics["callee_launches"]!=launches or after[64:64+cap]!=data[64:64+cap] or after[output_start:]!=data[output_start:]:raise RuntimeError("Failed containment: "+name)
                if name=="mapper_cannot_write_table":
                    state=64+cap;work=state+32+16*f
                    if struct.unpack_from("<Q",after,state)[0]!=2 or after[work:work+cap]!=data[work:work+cap]:raise RuntimeError("Mapper fault changed state or committed work")
                rows.append({"case":name,"pass":True,"value":result,"callee_launches":launches})
            inp.write_bytes(packet(b"fresh, recovery"));command([oracle,inp,expected])
            value,metrics=execute(cli(loader,"Split"))
            if actual.read_bytes()!=expected.read_bytes():raise RuntimeError("Fresh recovery failed")
            rows.append({"case":"fresh_recovery","pass":True})
            report["tests"][cc]=rows
        oracle_sanitized=out/"reference-sanitized"
        command(["gcc","-std=c11","-O1","-g","-fsanitize=address,undefined","-fno-sanitize-recover=all",ROOT/"text-reference.c","-o",oracle_sanitized])
        for _,data in vectors:
            inp.write_bytes(data);command([oracle_sanitized,inp,expected])
        for data in (packet(b"a,b"),packet(b"",fields=0),packet(b""),packet(b" \t ",fields=0)):
            inp.write_bytes(data);command([oracle_sanitized,inp,expected,"corrupt"])
        report["oracle_sanitizer_tests"]={"passed":True,"cases":len(vectors)+4}
        raw=out/"example.txt";plain=out/"example-output.txt"
        raw.write_bytes(b" hola, mundo ,, ubytec ")
        for mode in ("mono","split","group"):
            command([sys.executable,ROOT/"text_cli.py","--artifacts",out,"--mode",mode,"--input",raw,"--output",plain])
            if plain.read_bytes()!=b"HOLA|MUNDO|UBYTEC":raise RuntimeError("Plain-file application failed: "+mode)
        plain.write_bytes(b"KEEP")
        failure=subprocess.run([str(x) for x in (sys.executable,ROOT/"text_cli.py","--artifacts",out,"--mode","split","--input",raw,"--output",plain,"--output-capacity",0)],capture_output=True,text=True,timeout=15)
        if failure.returncode!=1 or plain.read_bytes()!=b"KEEP":raise RuntimeError("Failed application overwrote output")
        report["host_driver_tests"]={"passed":True,"cases":4,"diagnostic_exports_granted":False}
        if not args.skip_benchmark:
            for n in (256,4096,16384):
                # Fixed 32 fields; grow field bodies instead of changing crossing count.
                fields=[b"abc Def "]*32
                text=b",".join(fields)
                if len(text)>n:fields=[b"abc"]*32;text=b",".join(fields)
                remaining=n-len(text)
                fields[0]+=b"x"*remaining;text=b",".join(fields)
                inp.write_bytes(packet(text,fields=32));reference=int(command([oracle,inp,expected]).strip())
                samples={entry:[] for entry,_,_ in VARIANTS};memory={entry:[0,0] for entry,_,_ in VARIANTS}
                for i in range(110):
                    order=list(VARIANTS);rotation=i%3;order=order[rotation:]+order[:rotation]
                    for entry,artifact,count in order:
                        start=time.perf_counter_ns();value,metrics=execute(cli(out/"text-gcc",entry,artifact,outputs=False,profile=True));elapsed=(time.perf_counter_ns()-start)/1000
                        if value!=reference or metrics["callee_launches"]!=count:raise RuntimeError("Benchmark mismatch")
                        if i>=10:
                            samples[entry].append(elapsed);memory[entry][0]=max(memory[entry][0],metrics["caller_peak_rss_kib"]);memory[entry][1]=max(memory[entry][1],metrics["receiver_peak_rss_kib"])
                for entry,artifact,count in VARIANTS:
                    ordered=sorted(samples[entry]);report["benchmarks"].append({"variant":entry,"input_bytes":n,"packet_bytes":inp.stat().st_size,
                        "output_bytes":reference,"fields":32,"samples":100,"warmup":10,"median_us":(ordered[49]+ordered[50])/2,"p95_us":ordered[94],
                        "receiver_invocations":count,"workers_created":1+count,"caller_peak_rss_kib":memory[entry][0],"receiver_peak_rss_kib":memory[entry][1],
                        "includes":"whole application with profiling, fresh workers, contracts, input and loans; no output file","order":"rotating variants on each trial"})
        report["artifact_sha256"]={p.name:digest(p) for p in out.iterdir() if p.suffix in (".elf",".nasm")}
        report["accepted"]=True
    except Exception as error:report["error"]=str(error);raise
    finally:(out/"text-report.json").write_text(json.dumps(report,indent=2)+"\n")
    print("PASS",len(report["tests"]["gcc"]),"stateful text checks per compiler;",len(report["benchmarks"]),"benchmark rows")
if __name__=="__main__":main()