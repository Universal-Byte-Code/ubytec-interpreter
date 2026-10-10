#!/usr/bin/env python3
"""Trusted host driver for the isolated Ubytec text application."""
import argparse,json,struct,subprocess,tempfile
from pathlib import Path
from run_text import packet

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--artifacts",type=Path,required=True)
    parser.add_argument("--mode",choices=("mono","split","group"),default="split")
    parser.add_argument("--input",type=Path,required=True)
    parser.add_argument("--output",type=Path,required=True)
    parser.add_argument("--fields",type=int,default=16)
    parser.add_argument("--output-capacity",type=int)
    args=parser.parse_args()
    try:
        if not 0<=args.fields<=256:raise ValueError("Field capacity must be between 0 and 256")
        with args.input.open("rb") as stream:text=stream.read(65537)
        if len(text)>65536:raise ValueError("Input exceeds the experimental root-loan limit")
        outcap=len(text)+1 if args.output_capacity is None else args.output_capacity
        if not 0<=outcap<=65536:raise ValueError("Output capacity must be between 0 and 65536")
        data=packet(text,fields=args.fields,outcap=outcap)
        artifacts=args.artifacts.resolve();artifact="mono" if args.mode=="mono" else "caller"
        entry={"mono":"Mono","split":"Split","group":"Group"}[args.mode]
        argv=[str(artifacts/"text-gcc"),"--contracts",str(artifacts/(artifact+".elf")),entry]
        if artifact=="caller":
            for name in ("lexer","mapper","writer","grouped"):argv += ["--module",name,str(artifacts/(name+".elf"))]
            grants=(("Pipeline","grouped.RunText"),) if args.mode=="group" else (
                ("Tokenize","lexer.ParseFields"),("Normalize","mapper.UpperText"),("Render","writer.BuildText"))
            for alias,target in grants:argv += ["--grant-many",alias,target,"3","65536","1","65536","1000"]
        with tempfile.TemporaryDirectory(prefix="ubytec-text-") as temp:
            before=Path(temp)/"input.bin";after=Path(temp)/"output.bin";before.write_bytes(data)
            proc=subprocess.run(argv+["--input",str(before),"--output",str(after)],capture_output=True,text=True,timeout=10)
            if proc.returncode or proc.stderr:raise ValueError("The protected application did not complete")
            rows=[json.loads(line) for line in proc.stdout.splitlines() if line.startswith("{")]
            result=next(row for row in rows if row.get("case")=="program")
            if not result["pass"]:raise ValueError("The caller failed")
            value=result["value"]
            errors={-10:"Invalid input geometry",-11:"Too many nonempty fields",-12:"Insufficient output capacity (including terminator)",-13:"Invalid field descriptors"}
            if value<0:raise ValueError(errors.get(value,"A domain call failed: "+str(value)))
            returned=after.read_bytes()
            output_start=96+2*len(text)+16*args.fields
            if len(returned)!=len(data) or value>=outcap or struct.unpack_from("<Q",returned,32)[0]!=value or struct.unpack_from("<q",returned,56)[0]!=0:
                raise ValueError("Invalid result metadata")
            count=struct.unpack_from("<Q",returned,40)[0]
            if count>args.fields or returned[64:64+len(text)]!=text or returned[-16:]!=data[-16:] or returned[output_start+value]!=0:
                raise ValueError("Invalid result boundaries")
            output=returned[output_start:output_start+value]
        args.output.write_bytes(output)
        print(str(len(output))+" bytes, "+str(count)+" fields")
        return 0
    except (OSError,ValueError,KeyError,StopIteration,subprocess.TimeoutExpired) as error:
        parser.exit(1,str(error)+"\n")
if __name__=="__main__":raise SystemExit(main())
