#!/usr/bin/env python3
"""Compile Ubytec fixtures, link their System V adapters, then run inside the existing Linux boundary."""
import argparse
import hashlib
import json
import platform
import shutil
from pathlib import Path
from run import command, records, require_cases

ROOT = Path(__file__).resolve().parent
EXPORTS = {
    "Read": "read", "Write": "write", "ReadOnlyWrite": "read_only_write",
    "Foreign": "foreign", "Monitor": "monitor", "Neighbor": "neighbor",
    "StackOverflow": "stack_overflow", "Spin": "loop", "Stale": "stale", "Copy": "copy",
}
CASES = {"read", "write", "read_only_write", "foreign_pointer", "monitor_pointer",
         "neighbor_pointer", "stack_overflow", "infinite_loop", "stale_pointer", "copy"}

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=ROOT/"build/ubytec")
    parser.add_argument("--compiler-dll", type=Path)
    parser.add_argument("--assembly", type=Path, help="Explicit cross-host handoff; compilation happened outside this runner.")
    parser.add_argument("--skip-benchmark", action="store_true")
    args = parser.parse_args()
    if platform.system() != "Linux" or platform.machine() not in {"x86_64", "amd64"}:
        parser.error("Run the attack fixtures only in Linux x86-64.")
    if args.assembly and args.compiler_dll:
        parser.error("Choose --assembly or --compiler-dll.")
    for tool in ("gcc", "nasm"):
        if not shutil.which(tool):
            parser.error(f"Missing {tool}.")
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    assembly, obj, binary = output/"attacks.nasm", output/"attacks.o", output/"ubytec-isolation"
    report = {
        "schema": 1, "accepted": False, "environment": platform.platform(),
        "source_sha256": {str(p.relative_to(ROOT)): digest(p) for p in
                          [ROOT/"ubytec/attacks.ubc", ROOT/"linux/isolation.c",
                           ROOT/"common/contract.h", ROOT/"run_ubytec.py", ROOT/"run.py"]},
        "exports": EXPORTS, "benchmarks_executed": not args.skip_benchmark,
        "limits": ["Statically linked fixture module; no general dynamic module loader",
                   "Linux integration only; ARM continues to use native fixtures",
                   "OS, supervisor, compiler and toolchain remain trusted",
                   "Integer System V arguments only, at most six",
                   "Serialized per-call loans; no delegation or persistent grants",
                   "Raw pointers within a granted page can access initialized padding",
                   "A failed writable loan can contain partial writes; copy commit requires successful return"],
    }
    try:
        if args.assembly:
            source_asm = args.assembly.resolve()
            if source_asm != assembly:
                shutil.copyfile(source_asm, assembly)
            report["compilation"] = {"mode": "precompiled-cross-host-handoff",
                                     "input_assembly_sha256": digest(source_asm)}
        else:
            dll = args.compiler_dll
            if dll is None:
                project = ROOT.parent.parent/"Ubytec/Ubytec.csproj"
                command(["dotnet", "build", project, "-c", "Release", "-p:EnableDocFxOnBuild=false",
                         "-p:GenerateDocumentationFile=false"], timeout=120)
                dll = project.parent/"bin/Release/net9.0/Ubytec.dll"
            dll = dll.resolve()
            compiler_args = ["dotnet", dll, ROOT/"ubytec/attacks.ubc", "--library", "--tail-calls", "-o", assembly]
            for function, symbol in EXPORTS.items():
                compiler_args.extend(["--host-export", f"{function}=ubytec_host_{symbol}"])
            command(compiler_args)
            report["compilation"] = {"mode": "source-compiled-in-runner", "compiler_sha256": digest(dll)}
        command(["nasm", "-f", "elf64", assembly, "-o", obj])
        command(["gcc", "-std=c11", "-O2", "-Wall", "-Wextra", "-Werror", "-DUBYTEC_ENABLED",
                 "-Wl,-z,noexecstack", ROOT/"linux/isolation.c", obj, "-o", binary])
        report["artifact_sha256"] = {p.name: digest(p) for p in [assembly, obj, binary]}
        text = command([binary], timeout=30)
        (output/"ubytec-tests.jsonl").write_text(text)
        report["tests"] = records(text)
        require_cases(report["tests"], CASES | {"recovery_after_"+c for c in CASES})
        results = {r["case"]: r for r in report["tests"]}
        if results["read"]["value"] != 256 or any(results[c]["value"] != 4294967297 for c in ("write", "copy")):
            raise RuntimeError("64-bit result transport failed")
        if not args.skip_benchmark:
            text = command([binary, "--benchmark"], timeout=120)
            (output/"ubytec-benchmark.jsonl").write_text(text)
            report["benchmarks"] = records(text)
            expected = {(m, n) for m in ["invocation_and_read", "copy_only", "local_byte_read_baseline",
                                        "worker_byte_read"] for n in [256, 4096, 65536]}
            actual = {(r["metric"], r["bytes"]) for r in report["benchmarks"]}
            if actual != expected or len(report["benchmarks"]) != len(expected):
                raise RuntimeError("Incomplete Ubytec benchmark matrix")
        report["accepted"] = True
    except Exception as error:
        report["error"] = str(error)
        raise
    finally:
        (output/"ubytec-report.json").write_text(json.dumps(report, indent=2)+"\n")
    print("PASS 10 compiled Ubytec cases + 10 fresh-invocation recovery checks")

if __name__ == "__main__":
    main()
