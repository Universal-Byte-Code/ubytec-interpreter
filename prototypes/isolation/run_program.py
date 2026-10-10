#!/usr/bin/env python3
"""Execute calls originating in separately compiled, isolated Ubytec modules."""
import argparse
import hashlib
import json
import os
import queue
import shutil
import signal
import subprocess
import threading
import time
from pathlib import Path
from run import command, records
ROOT=Path(__file__).resolve().parent
FUNCTIONS=("Value","WriteValue","Status","Copy","Partial","Unknown","ExcessRights","Oversize","Deadline",
           "Unlimited","OverBudget","Repeat","BadPointer")
def digest(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--modules",type=Path,required=True)
    parser.add_argument("--caller-assembly",type=Path)
    parser.add_argument("--output",type=Path,default=ROOT/"build/program")
    args=parser.parse_args()
    output=args.output.resolve(); output.mkdir(parents=True,exist_ok=True)
    modules=args.modules.resolve()
    sources=["linux/program.c","linux/modules.c","linux/many-wire.h","linux/many-service.h","linux/isolation.c","linux/bridge-runtime.c",
             "linux/module.ld","linux/contracts.h","linux/bridge-attacks.nasm","common/contract.h","ubytec/modules/caller.ubc","run_program.py","run.py"]
    report={"accepted":False,"schema":1,"source_sha256":{s:digest(ROOT/s) for s in sources},
            "tests":{},"limits":["Linux x64 only","One supervisor-authorized target per caller",
                "Dedicated copying; no shared caller/callee mappings","No receiver delegation",
                "Native ARM fixture tests remain separate","Not a stable module ABI"]}
    try:
        asm=output/"caller.nasm"
        if args.caller_assembly:
            shutil.copyfile(args.caller_assembly,asm)
            report["compilation"]={"mode":"precompiled-assembly-handoff","assembly_sha256":digest(asm)}
        else:
            repo=ROOT.parents[1]
            dll=repo/"Ubytec/bin/Release/net9.0/Ubytec.dll"
            command(["dotnet","build",repo/"Ubytec/Ubytec.csproj","-c","Release",
                     "-p:EnableDocFxOnBuild=false","-p:GenerateDocumentationFile=false","--nologo"])
            compiler=["dotnet",dll,ROOT/"ubytec/modules/caller.ubc","--library","--module-calls","-o",asm]
            for fn in FUNCTIONS: compiler+=["--host-export",fn+"=ubytec_host_"+fn.lower()]
            command(compiler)
            report["compilation"]={"mode":"source-compiled-in-runner","compiler_sha256":digest(dll)}
        obj=output/"caller.o"; command(["nasm","-f","elf64",asm,"-o",obj])
        attacks_obj=output/"bridge-attacks.o"; attacks=output/"bridge-attacks.elf"
        command(["nasm","-f","elf64",ROOT/"linux/bridge-attacks.nasm","-o",attacks_obj])
        command(["ld","-T",ROOT/"linux/module.ld","-e","ubytec_host_bad_length","-z","noexecstack",
                 attacks_obj,"-o",attacks])
        for cc in ("gcc","clang"):
            loader=output/("program-"+cc); runtime=output/("bridge-"+cc+".o"); caller=output/("caller-"+cc+".elf")
            command([cc,"-std=c11","-O2","-Wall","-Wextra","-Werror","-Wl,-z,noexecstack",
                     ROOT/"linux/program.c","-o",loader])
            command([cc,"-std=c11","-O2","-Wall","-Wextra","-Werror","-ffreestanding","-fno-builtin",
                     "-fno-stack-protector","-fno-pic","-mcmodel=large","-mno-red-zone","-c",ROOT/"linux/bridge-runtime.c","-o",runtime])
            command(["ld","-T",ROOT/"linux/module.ld","-e","ubytec_host_status","-z","noexecstack",
                     obj,runtime,"-o",caller])
            rows=[]
            def argv(fn, artifact, target, ceiling=1, maximum=16, budget="1000"):
                return [str(loader),"--program",str(caller),"ubytec_host_"+fn,
                        str(modules/artifact),"ubytec_host_"+target,str(ceiling),str(maximum),str(budget)]
            def check(name, result, expected, requests=1, launches=1, byte0=1, crash=False):
                text,error,code=result
                events=records(text)
                result_row=next((r for r in events if r.get("case")=="program"),{})
                metrics=next((r for r in events if r.get("event")=="program-result"),{})
                passed=not error and metrics.get("requests")==requests and metrics.get("callee_launches")==launches
                passed &= metrics.get("byte0")==byte0 and metrics.get("neighbor")==1 and metrics.get("neighbors_preserved") is True
                if crash: passed &= code==1 and result_row.get("signal")==signal.SIGSEGV
                else: passed &= code==0 and result_row.get("pass") is True and result_row.get("value")==expected
                if not passed: raise RuntimeError(name+": "+text+" "+error)
                rows.append({"case":name,"pass":True,"result":result_row,"resources":metrics})
            def run(args):
                p=subprocess.run(args,text=True,capture_output=True,timeout=10)
                return p.stdout,p.stderr,p.returncode
            check("source_read_value",run(argv("value","data.elf","read")),16)
            check("source_full_64bit_return",run(argv("writevalue","data.elf","write",3)),4294967297,byte0=90)
            check("source_return_status",run(argv("status","data.elf","read")),0)
            check("source_write_copyback",run(argv("copy","data.elf","write",3)),0,byte0=90)
            check("source_repeated_calls",run(argv("repeat","data.elf","read")),0,requests=2,launches=2)
            check("source_unknown_handle",run(argv("unknown","data.elf","read")),1,launches=0)
            check("source_rights_ceiling",run(argv("excessrights","data.elf","read")),1,launches=0)
            check("source_length_ceiling",run(argv("oversize","data.elf","read")),1,launches=0)
            check("source_budget_ceiling",run(argv("overbudget","data.elf","read")),1,launches=0)
            check("source_unlimited_denied",run(argv("unlimited","data.elf","read")),1,launches=0)
            check("source_unlimited_return",run(argv("unlimited","data.elf","read",budget="none")),0)
            check("source_timeout_status",run(argv("deadline","data.elf","tail_infinite")),3)
            for target in ("read_only_write","foreign","monitor","neighbor"):
                check("source_fault_"+target,run(argv("status","faults.elf",target)),2)
            check("source_failed_copy_not_committed",run(argv("partial","faults.elf","partial",3)),2)
            check("source_forged_callee_protocol",run(argv("status","hostile.elf","forge")),5)
            check("source_bad_caller_pointer",run(argv("badpointer","data.elf","read")),None,
                  requests=0,launches=0,crash=True)
            # Cancel the leaf and verify Ubytec receives status 4 and returns normally.
            for mode in ("none","1000"):
                p=subprocess.Popen(argv("unlimited" if mode=="none" else "status","data.elf","tail_infinite",
                                         budget=mode),stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,bufsize=1)
                incoming=queue.Queue(); seen=[]
                def reader():
                    for line in p.stdout: incoming.put(line)
                    incoming.put(None)
                thread=threading.Thread(target=reader,daemon=True); thread.start()
                try:
                    deadline=time.monotonic()+5; started=[]
                    while len(started)<2 and time.monotonic()<deadline:
                        line=incoming.get(timeout=max(.01,deadline-time.monotonic()))
                        if line is None: break
                        seen.append(line)
                        row=json.loads(line)
                        if row.get("event")=="started": started.append(row)
                    if len(started)!=2: raise RuntimeError("Callee did not start")
                    time.sleep(.02); p.send_signal(signal.SIGUSR1)
                    p.wait(timeout=5); thread.join(timeout=1)
                    while not incoming.empty():
                        line=incoming.get()
                        if line is not None: seen.append(line)
                    check("source_cancel_"+mode,("".join(seen),p.stderr.read(),p.returncode),4)
                    if any(os.path.exists("/proc/"+str(row["worker_pid"])) for row in started):
                        raise RuntimeError("Cancelled program retained a worker")
                finally:
                    if p.poll() is None: p.kill(); p.wait()
            check("receiver_cannot_delegate",run(argv("status",str(attacks),"delegate")),5)
            for fn in ("bad_length","bad_version"):
                forged=[str(loader),"--program",str(attacks),"ubytec_host_"+fn,
                        str(modules/"data.elf"),"ubytec_host_read","1","16","1000"]
                p=subprocess.run(forged,text=True,capture_output=True,timeout=5)
                result=next((r for r in records(p.stdout) if r.get("case")=="program"),{})
                metrics=next((r for r in records(p.stdout) if r.get("event")=="program-result"),{})
                if p.returncode!=1 or p.stderr or result.get("protocol_rejected")!=1 or metrics.get("callee_launches")!=0:
                    raise RuntimeError("Invalid broker frame not contained: "+p.stdout)
                rows.append({"case":"malicious_caller_"+fn,"pass":True,"result":result,"resources":metrics})
            # Killing the supervisor must also stop both borrowed-domain workers.
            p=subprocess.Popen(argv("unlimited","data.elf","tail_infinite",budget="none"),
                               stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,bufsize=1)
            try:
                started=[json.loads(p.stdout.readline()),json.loads(p.stdout.readline())]
                if any(row.get("event")!="started" for row in started):
                    raise RuntimeError("Parent-death fixture did not start")
                p.kill(); p.wait(timeout=5)
                deadline=time.monotonic()+2
                def stopped(pid):
                    path=Path("/proc")/str(pid)/"stat"
                    try: return path.read_text().split(") ",1)[1].split()[0]=="Z"
                    except FileNotFoundError: return True
                while time.monotonic()<deadline and not all(stopped(row["worker_pid"]) for row in started):
                    time.sleep(.01)
                if not all(stopped(row["worker_pid"]) for row in started):
                    raise RuntimeError("Supervisor death retained executing borrowers")
                rows.append({"case":"supervisor_death_stops_borrowers","pass":True})
            finally:
                if p.poll() is None: p.kill(); p.wait()
                p.stdout.close(); p.stderr.close()
            p=subprocess.Popen(argv("unlimited","data.elf","tail_infinite",budget="none"),
                               stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,bufsize=1)
            try:
                started=[json.loads(p.stdout.readline()),json.loads(p.stdout.readline())]
                time.sleep(.02); p.send_signal(signal.SIGTERM)
                stop_text,error=p.communicate(timeout=5)
                row=next((r for r in records(stop_text) if r.get("case")=="program"),{})
                if p.returncode!=1 or error or row.get("cancelled")!=1 or row.get("protocol_rejected"):
                    raise RuntimeError("Program termination confused cancellation with protocol failure")
                if any(os.path.exists("/proc/"+str(r["worker_pid"])) for r in started):
                    raise RuntimeError("Terminated program retained workers")
                rows.append({"case":"program_stop_reaps_both_workers","pass":True,"result":row})
            finally:
                if p.poll() is None: p.kill(); p.wait()
            report["tests"][cc]=rows
            (output/("program-tests-"+cc+".jsonl")).write_text("".join(json.dumps(r)+"\n" for r in rows))
        report["artifacts_sha256"]={p.name:digest(p) for p in output.iterdir() if p.suffix in {".elf",".o",".nasm"}}
        report["accepted"]=True
    except Exception as error:
        report["error"]=str(error); raise
    finally:
        (output/"program-report.json").write_text(json.dumps(report,indent=2)+"\n")
    print("PASS "+str(len(report["tests"]["gcc"]))+" source module-call checks with GCC and Clang")
if __name__=="__main__": main()
