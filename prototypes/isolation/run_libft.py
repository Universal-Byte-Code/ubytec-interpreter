#!/usr/bin/env python3
"""C-oracle validation and whole-program measurements for the isolated libft chain."""
import argparse, hashlib, json, platform, shutil, struct, subprocess, time
from pathlib import Path
from run import command, records
ROOT=Path(__file__).resolve().parent
REPO=ROOT.parents[1]
NAMES=("caller","strings","memory","grouped")
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def packet(size,text):
    capacity=(size-32)//2
    if len(text)>=capacity:raise ValueError("String capacity")
    p=bytearray([0xa5])*size;struct.pack_into("<QQ",p,0,capacity,0)
    for i in range(capacity):p[16+i]=(i%255)+1
    p[16:16+len(text)]=text;p[16+len(text)]=0
    return p
def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--assembly-directory",type=Path)
    parser.add_argument("--output",type=Path,default=ROOT/"build/libft-chain")
    parser.add_argument("--skip-benchmark",action="store_true")
    args=parser.parse_args();out=args.output.resolve();out.mkdir(parents=True,exist_ok=True)
    sources=["prototypes/isolation/"+s for s in ("run_libft.py","run.py","linux/program.c","linux/modules.c","linux/many-wire.h","linux/many-service.h",
        "linux/contracts.h","linux/isolation.c","linux/bridge-runtime.c","linux/module.ld","common/contract.h")]
    sources+=["prototypes/isolation/ubytec/libft/"+n+".ubc" for n in NAMES]
    sources+=["corpus/libft/memory.ubc","corpus/libft/chain-reference.c"]
    report={"schema":1,"accepted":False,"source_sha256":{s:digest(REPO/s) for s in sources},
            "environment":{"platform":platform.platform(),"gcc":command(["gcc","--version"]).splitlines()[0],
                "clang":command(["clang","--version"]).splitlines()[0]},
            "benchmarks_executed":not args.skip_benchmark,"tests":{},"benchmarks":[]}
    try:
        corpus=(REPO/"corpus/libft/memory.ubc").read_text()
        for name,next_name,providers in (("ft_strlen","ft_memcmp",("strings","grouped")),
                                        ("ft_memcpy","ft_memmove",("memory","grouped"))):
            body=corpus[corpus.index("func "+name):corpus.index("func "+next_name)].strip()
            for provider in providers:
                if body not in (ROOT/("ubytec/libft/"+provider+".ubc")).read_text():
                    raise RuntimeError("Copied corpus implementation drift: "+name)
        report["compilation"]={"mode":"precompiled-assembly-handoff" if args.assembly_directory else "source-compiled-in-runner"}
        if not args.assembly_directory:
            dll=REPO/"Ubytec/bin/Release/net9.0/Ubytec.dll"
            command(["dotnet","build",REPO/"Ubytec/Ubytec.csproj","-c","Release",
                     "-p:EnableDocFxOnBuild=false","-p:GenerateDocumentationFile=false","--nologo"])
            report["compilation"]["compiler_sha256"]=digest(dll)
        for name in NAMES:
            asm=out/(name+".nasm")
            if args.assembly_directory:shutil.copyfile(args.assembly_directory/(name+".nasm"),asm)
            else:
                cli=["dotnet",dll,ROOT/("ubytec/libft/"+name+".ubc"),"--library","-o",asm]
                if name=="caller":cli+=["--module-calls"]
                command(cli)
            command(["nasm","-f","elf64",asm,"-o",out/(name+".o")])
        runtime=out/"runtime.o"
        command(["gcc","-O2","-ffreestanding","-fno-builtin","-fno-stack-protector","-fno-pic","-mcmodel=large",
                 "-mno-red-zone","-c",ROOT/"linux/bridge-runtime.c","-o",runtime])
        for name in NAMES:
            export={"caller":"Split","strings":"Length","memory":"Copy","grouped":"Pipeline"}[name]
            command(["ld","-T",ROOT/"linux/module.ld","-e","ubytec_host_contract_"+export,"-z","noexecstack",
                     out/(name+".o"),*([runtime] if name=="caller" else []),"-o",out/(name+".elf")])
        oracle=out/"reference";command(["gcc","-std=c11","-O2","-Wall","-Wextra","-Werror",
                                     REPO/"corpus/libft/chain-reference.c","-o",oracle])
        input_file=out/"input.bin";actual=out/"actual.bin";expected=out/"expected.bin"
        def cli(loader,entry,copy_rights=3,outputs=True,denied=False):
            argv=[loader,"--contracts",out/"caller.elf",entry]
            for n in ("strings","memory","grouped"):argv+=["--module",n,out/(n+".elf")]
            if not denied:
                for alias,target,rights in (("ReadLength","strings.Length",1),("CopyMemory","memory.Copy",copy_rights),
                                            ("EscapeMemory","memory.Escape",1),("Grouped","grouped.Pipeline",3)):
                    argv+=["--grant",alias,target,rights,"65536","1000"]
            argv+=["--input",input_file]
            if outputs:argv+=["--output",actual]
            return [str(a) for a in argv]
        def execute(argv):
            p=subprocess.run(argv,capture_output=True,text=True,timeout=10)
            if p.returncode or p.stderr:raise RuntimeError(p.stdout+" "+p.stderr)
            rs=records(p.stdout)
            result=next(r for r in rs if r.get("case")=="program")
            metrics=next(r for r in rs if r.get("event")=="program-result")
            return result["value"],metrics
        vectors=[("empty",256,b""),("ascii",256,b"hello"),("embedded_nul",256,b"A\0B"),
                 ("high_bytes",256,bytes(range(128,240))[:90])]
        for size in (256,4096,65536):
            n=(size-32)//2-1
            vectors.append(("boundary_"+str(size),size,bytes((i%255)+1 for i in range(n))))
        for cc in ("gcc","clang"):
            loader=out/("chain-"+cc)
            command([cc,"-std=c11","-O2","-Wall","-Wextra","-Werror",ROOT/"linux/program.c","-o",loader])
            rows=[]
            for name,size,text in vectors:
                input_file.write_bytes(packet(size,text))
                reference=int(command([oracle,input_file,expected]).strip())
                for entry,count in (("Split",2),("Group",1)):
                    value,metrics=execute(cli(loader,entry))
                    if value!=reference or actual.read_bytes()!=expected.read_bytes() or metrics["callee_launches"]!=count:
                        raise RuntimeError("C equivalence failed: "+name+" "+entry)
                    rows.append({"case":name+"_"+entry,"pass":True,"bytes":size,"string_length":reference,"callee_launches":count})
            for name,entry,rights,status,count,denied in (("insufficient_rights","Split",1,1,1,False),
                  ("readonly_write_fault","ReadOnly",3,2,1,False),("outside_loan","Attack",3,2,1,False),
                  ("ungranted_export","Denied",3,1,0,False),("no_grants","Denied",3,1,0,True)):
                before=packet(256,b"hello");input_file.write_bytes(before)
                value,metrics=execute(cli(loader,entry,rights,denied=denied))
                after=actual.read_bytes();capacity=struct.unpack_from("<Q",before)[0]
                if value!=status or metrics["callee_launches"]!=count or after[16:248]!=before[16:248]:
                    raise RuntimeError("Failed loan containment: "+name)
                if after[16+capacity:16+2*capacity]!=before[16+capacity:16+2*capacity]:
                    raise RuntimeError("Failed call committed destination data")
                rows.append({"case":name,"pass":True,"status":status,"callee_launches":count})
            report["tests"][cc]=rows
            (out/("libft-tests-"+cc+".jsonl")).write_text("".join(json.dumps(r)+"\n" for r in rows))
        if not args.skip_benchmark:
            loader=out/"chain-gcc"
            for size in (256,4096,65536):
                n=(size-32)//2-1
                input_file.write_bytes(packet(size,bytes((i%255)+1 for i in range(n))))
                command([oracle,input_file,expected])
                for entry,count in (("Split",2),("Group",1)):
                    samples=[]
                    for i in range(110):
                        start=time.perf_counter_ns()
                        value,metrics=execute(cli(loader,entry,outputs=False))
                        elapsed=(time.perf_counter_ns()-start)/1000
                        if value!=n or metrics["callee_launches"]!=count:raise RuntimeError("Benchmark operation failed")
                        if i>=10:samples.append(elapsed)
                    samples.sort()
                    report["benchmarks"].append({"variant":entry,"packet_bytes":size,"string_bytes":n,
                      "samples":100,"warmup":10,"median_us":(samples[49]+samples[50])/2,"p95_us":samples[94],
                      "receiver_invocations":count,"includes":"fresh supervisor startup, ELF/contracts, input file, caller worker, IPC copies, receiver workers and reap; no output file"})
            (out/"libft-benchmark.jsonl").write_text("".join(json.dumps(r)+"\n" for r in report["benchmarks"]))
        report["artifact_sha256"]={p.name:digest(p) for p in out.iterdir() if p.suffix in {".elf",".nasm"}}
        report["accepted"]=True
    except Exception as error:report["error"]=str(error);raise
    finally:(out/"libft-report.json").write_text(json.dumps(report,indent=2)+"\n")
    print("PASS 19 libft chain checks (GCC and Clang), "+str(len(report["benchmarks"]))+" whole-application benchmark rows")
if __name__=="__main__":main()
