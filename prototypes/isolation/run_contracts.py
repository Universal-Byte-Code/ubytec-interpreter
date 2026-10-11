#!/usr/bin/env python3
"""Build source-declared contracts and exercise independent grants for two modules."""
import argparse, hashlib, json, shutil, struct, subprocess
from pathlib import Path
from run import command, records
ROOT=Path(__file__).resolve().parent
def digest(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--assembly-directory",type=Path)
    parser.add_argument("--output",type=Path,default=ROOT/"build/contracts")
    args=parser.parse_args(); out=args.output.resolve();out.mkdir(parents=True,exist_ok=True)
    names=("caller","reader","writer","mismatch")
    sources=["run_contracts.py","run.py","linux/program.c","linux/modules.c","linux/many-wire.h","linux/many-service.h","linux/isolation.c",
             "linux/contracts.h","linux/bridge-runtime.c","linux/module.ld","common/contract.h"]
    sources += ["ubytec/contracts/"+n+".ubc" for n in names]
    report={"accepted":False,"schema":1,"source_sha256":{s:digest(ROOT/s) for s in sources},"tests":{}}
    try:
        report["compilation"]={"mode":"precompiled-assembly-handoff" if args.assembly_directory else "source-compiled-in-runner"}
        if not args.assembly_directory:
            repo=ROOT.parents[1];dll=repo/"Ubytec/bin/Release/net9.0/Ubytec.dll"
            command(["dotnet","build",repo/"Ubytec/Ubytec.csproj","-c","Release","-p:EnableDocFxOnBuild=false",
                     "-p:GenerateDocumentationFile=false","--nologo"])
            report["compilation"]["compiler_sha256"]=digest(dll)
        for n in names:
            asm=out/(n+".nasm")
            if args.assembly_directory: shutil.copyfile(args.assembly_directory/(n+".nasm"),asm)
            else:
                cli=["dotnet",dll,ROOT/("ubytec/contracts/"+n+".ubc"),"--library","-o",asm]
                if n=="caller":cli+=["--module-calls"]
                command(cli)
            command(["nasm","-f","elf64",asm,"-o",out/(n+".o")])
        runtime=out/"runtime.o"
        command(["gcc","-O2","-ffreestanding","-fno-builtin","-fno-stack-protector","-fno-pic","-mcmodel=large",
                 "-mno-red-zone","-c",ROOT/"linux/bridge-runtime.c","-o",runtime])
        for n in names:
            entry="ubytec_host_contract_"+("Main" if n=="caller" else "Read" if n=="reader" else "Write")
            objs=[out/(n+".o")]+([runtime] if n=="caller" else [])
            command(["ld","-T",ROOT/"linux/module.ld","-e",entry,"-z","noexecstack",*objs,"-o",out/(n+".elf")])
        artifact=(out/"caller.elf").read_bytes()
        h=struct.unpack_from("<16sHHIQQQIHHHHHH",artifact)
        sections=[struct.unpack_from("<IIQQQQIIQQ",artifact,h[6]+i*64) for i in range(h[12])]
        shstr=sections[h[13]]; strings=artifact[shstr[4]:shstr[4]+shstr[5]]
        index=next(i for i,s in enumerate(sections) if strings[s[0]:].split(b"\0",1)[0]==b".ubytec_contract")
        sec=sections[index]; start,length=sec[4],sec[5]; manifest=artifact[start:start+length]
        invalid={}
        def mutate(name,offset,fmt,value):
            blob=bytearray(artifact);struct.pack_into(fmt,blob,offset,value);invalid[name]=blob
        mutate("section_too_large",h[6]+index*64+32,"Q",4097)
        mutate("writable_contract",h[6]+index*64+8,"Q",3)
        mutate("wrong_section_type",h[6]+index*64+4,"I",8)
        for name,old,new in (("bad_magic",b"UBC1",b"BAD1"),("duplicate_handle",b"I|2|",b"I|1|"),
                             ("missing_end",b"END\n",b"BAD\n"),("bad_signature",b":Int64",b":Int32")):
            blob=bytearray(artifact);pos=manifest.index(old);blob[start+pos:start+pos+len(old)]=new;invalid[name]=blob
        mutate("embedded_nul",start+10,"B",0)
        paths={}
        for name,blob in invalid.items():
            path=out/("invalid-"+name+".elf");path.write_bytes(blob);paths[name]=path
        for cc in ("gcc","clang"):
            loader=out/("contracts-"+cc)
            command([cc,"-std=c11","-O2","-Wall","-Wextra","-Werror",ROOT/"linux/program.c","-o",loader])
            rows=[]
            def cli(entry="Main",caller=None,writer=None):
                return [loader,"--contracts",caller or out/"caller.elf",entry,
                        "--module","tools",out/"reader.elf","--module","memory",writer or out/"writer.elf"]
            read=["--grant","ReadTool","tools.Read","1","16","1000"]
            write=["--grant","WriteMemory","memory.Write","3","16","1000"]
            def check(name,args,value=None,launches=None,reject=False):
                p=subprocess.run([str(a) for a in args],capture_output=True,text=True,timeout=10);rs=records(p.stdout)
                if reject: ok=p.returncode==1 and rs==[{"accepted":False,"contracts_rejected":True}]
                else:
                    result=next((r for r in rs if r.get("case")=="program"),{})
                    metrics=next((r for r in rs if r.get("event")=="program-result"),{})
                    ok=p.returncode==0 and result.get("value")==value and metrics.get("callee_launches")==launches and metrics.get("neighbors_preserved")
                if not ok or p.stderr:raise RuntimeError(name+": "+p.stdout+" "+p.stderr)
                rows.append({"case":name,"pass":True})
            check("two_modules_three_calls",cli()+read+write,1456,3)
            check("exported_but_not_granted",cli("Denied")+read+write,1,0)
            check("separate_function_grant",cli("Denied")+read+write+["--grant","Forbidden","tools.Hidden","1","16","1000"],0,1)
            check("no_import_authority",cli(),1,0)
            for name,grant in (("per_function_rights",["1","16","1000"]),("per_function_size",["3","8","1000"]),
                               ("per_function_budget",["3","16","500"])):
                check(name,cli()+read+["--grant","WriteMemory","memory.Write"]+grant,1,1)
            check("signature_mismatch",cli(writer=out/"mismatch.elf")+read+write,reject=True)
            check("duplicate_module",cli()+["--module","tools",out/"reader.elf"],reject=True)
            check("unknown_grant",cli()+["--grant","Missing","tools.Read","1","16","1000"],reject=True)
            check("grant_cannot_redirect_import",cli()+["--grant","ReadTool","tools.Hidden","1","16","1000"],reject=True)
            check("duplicate_grant",cli()+read+read,reject=True)
            check("unknown_entry",cli("Missing")+read+write,reject=True)
            check("missing_module",cli()[:4]+read,reject=True)
            for name,path in paths.items():check("malformed_"+name,cli(caller=path)+read+write,reject=True)
            report["tests"][cc]=rows
            (out/("contracts-tests-"+cc+".jsonl")).write_text("".join(json.dumps(r)+"\n" for r in rows))
        sanitized=out/"contracts-sanitized"
        command(["gcc","-std=c11","-O1","-g","-fsanitize=address,undefined","-fno-sanitize-recover=all",
                 ROOT/"linux/program.c","-o",sanitized])
        sanitized_checks=[]
        for name,path in paths.items():
            p=subprocess.run([str(x) for x in [sanitized,*cli(caller=path)[1:],*read,*write]],
                             capture_output=True,text=True,timeout=10)
            if p.returncode!=1 or p.stderr or records(p.stdout)!=[{"accepted":False,"contracts_rejected":True}]:
                raise RuntimeError("Sanitizer parser failure: "+name+" "+p.stderr)
            sanitized_checks.append({"case":name,"pass":True})
        report["sanitizer_tests"]=sanitized_checks
        report["artifact_sha256"]={p.name:digest(p) for p in out.iterdir() if p.suffix in {".nasm",".elf"} and not p.name.startswith("invalid-")}
        report["accepted"]=True
    except Exception as error:report["error"]=str(error);raise
    finally:(out/"contracts-report.json").write_text(json.dumps(report,indent=2)+"\n")
    print("PASS "+str(len(report["tests"]["gcc"]))+" contract checks (GCC and Clang), 8 parser checks under ASan/UBSan")
if __name__=="__main__":main()
