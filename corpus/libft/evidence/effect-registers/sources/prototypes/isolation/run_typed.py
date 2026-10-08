#!/usr/bin/env python3
"""Independent typed scalar / region-loan tests, C oracle and complete-call timings."""
import argparse, hashlib, json, platform, shutil, signal, struct, subprocess, time
from pathlib import Path
from run import command, records
ROOT=Path(__file__).resolve().parent
REPO=ROOT.parents[1]
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def packet(size,count):
    capacity=(size-32)//2
    if not 0<=count<=capacity:raise ValueError("count")
    data=bytearray([0xa5])*size
    struct.pack_into("<QQ",data,0,capacity,count)
    for i in range(capacity):data[16+i]=i%256
    return data
def main():
    p=argparse.ArgumentParser()
    p.add_argument("--assembly-directory",type=Path)
    p.add_argument("--output",type=Path,default=ROOT/"build/typed")
    p.add_argument("--skip-benchmark",action="store_true")
    args=p.parse_args();out=args.output.resolve();out.mkdir(parents=True,exist_ok=True)
    sources=["prototypes/isolation/"+s for s in ("run_typed.py","run.py","linux/program.c","linux/modules.c",
        "linux/contracts.h","linux/many-service.h","linux/many-wire.h","linux/many-parser-test.c","linux/bridge-transfer-test.c","linux/isolation.c","linux/bridge-runtime.c",
        "linux/module.ld","common/contract.h","ubytec/typed/caller.ubc","ubytec/typed/memory.ubc")]
    sources += ["corpus/libft/memory.ubc","corpus/libft/loans-reference.c"]
    report={"schema":2,"accepted":False,"source_sha256":{s:digest(REPO/s) for s in sources},
        "environment":{"platform":platform.platform(),"artifact_directory":str(out)},"tests":{},"benchmarks":[]}
    try:
        corpus=(REPO/"corpus/libft/memory.ubc").read_text()
        body=corpus[corpus.index("func ft_memcpy"):corpus.index("func ft_memmove")].strip()
        if body not in (ROOT/"ubytec/typed/memory.ubc").read_text():raise RuntimeError("ft_memcpy drift")
        report["compilation"]={"mode":"precompiled-assembly-handoff" if args.assembly_directory else "source-compiled-in-runner"}
        if not args.assembly_directory:
            dll=REPO/"Ubytec/bin/Release/net9.0/Ubytec.dll"
            command(["dotnet","build",REPO/"Ubytec/Ubytec.csproj","-c","Release","-p:EnableDocFxOnBuild=false","-p:GenerateDocumentationFile=false","--nologo"])
            report["compilation"]["compiler_sha256"]=digest(dll)
        for name in ("caller","memory"):
            asm=out/(name+".nasm")
            if args.assembly_directory:shutil.copyfile(args.assembly_directory/(name+".nasm"),asm)
            else:command(["dotnet",dll,ROOT/("ubytec/typed/"+name+".ubc"),"--library",*(["--module-calls"] if name=="caller" else []),"-o",asm])
            command(["nasm","-f","elf64",asm,"-o",out/(name+".o")])
        runtime=out/"runtime.o"
        command(["gcc","-O2","-ffreestanding","-fno-builtin","-fno-stack-protector","-fno-pic","-mcmodel=large","-mno-red-zone","-c",ROOT/"linux/bridge-runtime.c","-o",runtime])
        for name,entry in (("caller","Main"),("memory","Copy")):
            command(["ld","-T",ROOT/"linux/module.ld","-e","ubytec_host_contract_"+entry,"-z","noexecstack",out/(name+".o"),*([runtime] if name=="caller" else []),"-o",out/(name+".elf")])
        reference_runtime=out/"reference-runtime.o"
        command(["gcc","-O2","-DUBYTEC_BRIDGE_REFERENCE","-ffreestanding","-fno-builtin","-fno-stack-protector","-fno-pic","-mcmodel=large","-mno-red-zone","-c",ROOT/"linux/bridge-runtime.c","-o",reference_runtime])
        command(["ld","-T",ROOT/"linux/module.ld","-e","ubytec_host_contract_Main","-z","noexecstack",out/"caller.o",reference_runtime,"-o",out/"caller-reference.elf"])
        oracle=out/"reference"
        command(["gcc","-std=c11","-O2","-Wall","-Wextra","-Werror",REPO/"corpus/libft/loans-reference.c","-o",oracle])
        inp=out/"input.bin";actual=out/"actual.bin";expected=out/"expected.bin"
        def cli(loader,entry,rights=3,maximum=65536,denied=False,outputs=True,profile=False):
            argv=[loader,"--contracts",out/("caller-reference.elf" if Path(loader).name=="typed-reference" else "caller.elf"),entry,"--module","memory",out/"memory.elf"]
            if not denied:
                for alias in ("Copy","SourceWrite","Escape","Partial"):
                    argv += ["--grant-many",alias,"memory."+alias,rights,maximum,1,65536,1000]
                argv += ["--grant-many","SumValues","memory.SumValues",0,0,0,0,1000,
                         "--grant-many","Spin","memory.Spin",0,0,0,0,"none"]
            if profile:argv += ["--profile"]
            argv += ["--input",inp]
            if outputs:argv += ["--output",actual]
            return [str(a) for a in argv]
        def parse(stdout):
            rs=records(stdout)
            outcome=next(r for r in rs if r.get("case")=="program")
            metrics=next(r for r in rs if r.get("event")=="program-result")
            if not outcome.get("pass"):raise RuntimeError("Owner failure: "+stdout)
            metrics["profile"]=next((r for r in rs if r.get("event")=="profile-result"),{})
            return outcome["value"],metrics
        def execute(argv):
            run=subprocess.run(argv,capture_output=True,text=True,timeout=10)
            if run.returncode or run.stderr:raise RuntimeError(run.stdout+run.stderr)
            return parse(run.stdout)
        vectors=[("empty",32,0),("one",256,1),("partial",256,17),("binary",4096,1800)]
        vectors += [("boundary_"+str(size),size,(size-32)//2) for size in (256,4096,65536)]
        for cc in ("gcc","clang","reference","fallback"):
            compiler="gcc" if cc in ("reference","fallback") else cc
            report["environment"][cc]=command([compiler,"--version"]).splitlines()[0]
            loader=out/("typed-"+cc)
            command([compiler,"-std=c11","-O2","-Wall","-Wextra","-Werror",*(["-DUBYTEC_BRIDGE_REFERENCE"] if cc=="reference" else ["-DUBYTEC_NO_PIDFD"] if cc=="fallback" else []),ROOT/"linux/program.c","-o",loader])
            rows=[]
            for name,size,count in vectors:
                inp.write_bytes(packet(size,count));command([oracle,inp,expected])
                value,metrics=execute(cli(loader,"Main"))
                if value!=count or actual.read_bytes()!=expected.read_bytes() or metrics["callee_launches"]!=1:raise RuntimeError("C mismatch: "+name)
                rows.append({"case":name,"pass":True,"packet_bytes":size,"copied_bytes":count})
            for name,entry,rights,maximum,status,launches,denied in (
                ("source_write","SourceFault",3,65536,2,1,False),
                ("destination_escape","EscapeFault",3,65536,2,1,False),
                ("failed_partial_write","PartialFault",3,65536,2,1,False),
                ("insufficient_destination_rights","Main",1,65536,1,0,False),
                ("destination_length_ceiling","Main",3,16,1,0,False),
                ("ungranted","Main",3,65536,1,0,True),
                ("finite_timeout","Timeout",3,65536,3,1,False)):
                before=packet(256,17);inp.write_bytes(before)
                value,metrics=execute(cli(loader,entry,rights,maximum,denied))
                after=actual.read_bytes()
                if value!=status or metrics["callee_launches"]!=launches or after[:-8]!=before[:-8]:raise RuntimeError("Containment failed: "+name)
                rows.append({"case":name,"pass":True,"status":status,"callee_launches":launches})
            inp.write_bytes(packet(256,17))
            value,metrics=execute(cli(loader,"Scalar"))
            if value!=4294967280 or metrics["callee_launches"]!=1:raise RuntimeError("Scalar truncation or ABI mismatch")
            rows.append({"case":"signed_and_full_width_scalar","pass":True,"value":value})
            proc=subprocess.Popen(cli(loader,"Cancel"),stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True)
            try:
                time.sleep(.25)
                if proc.poll() is not None:raise RuntimeError("Unbounded call stopped before cancellation")
                proc.send_signal(signal.SIGUSR1)
                stdout,stderr=proc.communicate(timeout=5)
                value,metrics=parse(stdout)
                if proc.returncode or stderr or value!=4 or metrics["callee_launches"]!=1:raise RuntimeError("Cancellation failed: "+stdout+stderr)
            finally:
                if proc.poll() is None:proc.kill();proc.wait()
            rows.append({"case":"unbounded_call_explicit_cancellation","pass":True})
            # Fresh invocations after faults/cancellation must work and inherit no loan contents.
            inp.write_bytes(packet(256,7));command([oracle,inp,expected])
            value,metrics=execute(cli(loader,"Main"))
            if value!=7 or actual.read_bytes()!=expected.read_bytes():raise RuntimeError("Fresh loan recovery failed")
            rows.append({"case":"fresh_recovery","pass":True})
            report["tests"][cc]=rows
        sanitized=out/"many-parser-sanitized"
        command(["gcc","-std=c11","-O1","-g","-Wall","-Wextra","-Werror",
            "-fsanitize=address,undefined","-fno-sanitize-recover=all",ROOT/"linux/many-parser-test.c","-o",sanitized])
        if command([sanitized]).strip()!="PASS 10 malformed request checks":raise RuntimeError("Malformed request checks failed")
        report["sanitizer_tests"]={"malformed_requests":10,"passed":True,"checks_worker_identity":True}
        transport=out/"transport-sanitized"
        command(["gcc","-std=c11","-O1","-g","-Wall","-Wextra","-Werror","-DUBYTEC_BRIDGE_IO_TEST",
            "-fsanitize=address,undefined","-fno-sanitize-recover=all",ROOT/"linux/bridge-runtime.c",ROOT/"linux/bridge-transfer-test.c","-o",transport])
        if command([transport]).strip()!="PASS 5 fragmented transport checks":raise RuntimeError("Transport checks failed")
        report["transport_tests"]={"fragmented_io_eintr_full_size_atomic_copyback":5,"passed":True}
        if not args.skip_benchmark:
            def median(values):
                ordered=sorted(values);return (ordered[49]+ordered[50])/2
            for size in (256,4096,65536):
                count=(size-32)//2;inp.write_bytes(packet(size,count))
                measurements={n:{"samples":[],"profiles":[],"caller_rss":0,"receiver_rss":0} for n in ("reference","gcc")}
                # Alternate order on every paired trial to reduce scheduling/order bias.
                for i in range(110):
                    for name in (("reference","gcc") if i%2==0 else ("gcc","reference")):
                        start=time.perf_counter_ns()
                        value,metrics=execute(cli(out/("typed-"+name),"Main",outputs=False,profile=True))
                        elapsed=(time.perf_counter_ns()-start)/1000
                        if value!=count or metrics["callee_launches"]!=1:raise RuntimeError("Benchmark failed")
                        if i>=10:
                            row=measurements[name];row["samples"].append(elapsed);row["profiles"].append(metrics["profile"])
                            row["caller_rss"]=max(row["caller_rss"],metrics["caller_peak_rss_kib"])
                            row["receiver_rss"]=max(row["receiver_rss"],metrics["receiver_peak_rss_kib"])
                variants={}
                for name,data in measurements.items():
                    samples=sorted(data["samples"])
                    phases={key:median([p[key] for p in data["profiles"]]) for key in data["profiles"][0] if key!="event"}
                    variants[name]={"median_us":median(samples),"p95_us":samples[94],"phase_medians":phases,
                        "caller_peak_rss_kib":data["caller_rss"],"receiver_peak_rss_kib":data["receiver_rss"]}
                report["benchmarks"].append({"packet_bytes":size,"copied_bytes":count,"samples":100,"warmup":10,
                    "variants":variants,"median_reduction_percent":100*(1-variants["gcc"]["median_us"]/variants["reference"]["median_us"]),
                    "receiver_invocations":1,"includes":"whole application, host profiling enabled; no output file",
                    "comparison":"alternating pairs; same artifacts, input, permissions, fresh workers and filesystem; reference uses separate writes and periodic polling"})
        report["artifact_sha256"]={p.name:digest(p) for p in out.iterdir() if p.suffix in {".elf",".nasm"}}
        report["accepted"]=True
    except Exception as error:report["error"]=str(error);raise
    finally:(out/"typed-report.json").write_text(json.dumps(report,indent=2)+"\n")
    print("PASS",len(report["tests"]["gcc"]),"typed call checks per compiler;",len(report["benchmarks"]),"benchmark rows")
if __name__=="__main__":main()
