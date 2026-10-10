#!/usr/bin/env python3
"""Build separately compiled Ubytec ELFs and exercise the supervisor-owned module registry."""
import argparse
import hashlib
import json
import os
import platform
import random
import shutil
import struct
import subprocess
from pathlib import Path
from run import command, records, require_cases
from execution_cases import execution_matrix

ROOT = Path(__file__).resolve().parent
EXPORTS = {
    "data": {"Read": "read", "Write": "write", "Copy": "copy", "ReadOwnData": "own_data",
             "TailSelf": "tail_self", "TailMutual": "tail_mutual", "TailInfinite": "tail_infinite"},
    "faults": {"ReadOnlyWrite": "read_only_write", "Foreign": "foreign", "Monitor": "monitor",
               "Neighbor": "neighbor", "StackOverflow": "stack_overflow", "Spin": "loop",
               "Stale": "stale", "PartialFailure": "partial"},
}
CASES = {
    "tail_infinite", "tail_self", "tail_mutual", "read", "own_private_data", "write", "copy", "read_only_write", "foreign_pointer",
    "monitor_pointer", "neighbor_pointer", "stack_overflow", "infinite_loop", "stale_pointer",
    "partial_write_failure", "forged_request", "open_resource", "fresh_private_state", "write_code",
    "execute_loan", "read_other_module_data",
}
REJECTIONS = {"rights_ceiling", "size_contract", "unknown_module", "unregistered_function",
              "wrong_owner", "invalid_registration", "sealed_snapshot",
              "source_replaced_after_registration", "closed_module"}

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def run_rejected(args):
    result = subprocess.run([str(x) for x in args], capture_output=True, text=True, timeout=10)
    if result.returncode != 1 or result.stderr.strip():
        raise RuntimeError(f"Expected controlled rejection: {args}: {result.returncode}\n{result.stdout}\n{result.stderr}")
    rows = records(result.stdout)
    if len(rows) != 1 or rows[0].get("accepted") is not False:
        raise RuntimeError(f"Invalid rejection response: {result.stdout}")
    return rows[0]

def malformed_matrix(loader, artifact, output):
    original = artifact.read_bytes()
    header = struct.unpack_from("<16sHHIQQQIHHHHHH", original)
    phoff, shoff, phnum, shnum = header[5], header[6], header[10], header[12]
    phdrs = [(phoff+i*56, struct.unpack_from("<IIQQQQQQ", original, phoff+i*56)) for i in range(phnum)]
    code = next(off for off, p in phdrs if p[0] == 1 and p[1] & 1 and p[6])
    data = next(off for off, p in phdrs if p[0] == 1 and p[1] & 2 and p[6])
    unused = next(off for off, p in phdrs if p[0] == 1 and not p[6])
    variants = {}
    def mutation(name, offset, fmt, value):
        blob = bytearray(original)
        struct.pack_into(fmt, blob, offset, value)
        variants[name] = blob
    mutation("elf_bad_magic", 0, "<I", 0)
    mutation("elf_wrong_class", 4, "B", 1)
    mutation("elf_wrong_endian", 5, "B", 2)
    mutation("elf_wrong_machine", 18, "<H", 40)
    mutation("elf_shared_object", 16, "<H", 3)
    mutation("elf_phdr_overflow", 32, "<Q", (1 << 64)-1)
    mutation("elf_shdr_overflow", 40, "<Q", (1 << 64)-1)
    mutation("elf_phdr_count", 56, "<H", 65535)
    mutation("elf_section_count", 60, "<H", 65535)
    mutation("elf_writable_code", code+4, "<I", 7)
    mutation("elf_segment_outside", code+16, "<Q", 0x600000000000)
    mutation("elf_segment_overflow", code+40, "<Q", (1 << 64)-1)
    mutation("elf_file_outside", code+8, "<Q", (1 << 64)-1)
    mutation("elf_filesz_exceeds_memsz", code+32, "<Q", (1 << 64)-1)
    mutation("elf_unaligned_segment", code+16, "<Q", 0x400000000001)
    mutation("elf_bad_alignment", code+48, "<Q", 3)
    mutation("elf_overlap", data+16, "<Q", 0x400000000000)
    mutation("elf_interpreter", unused, "<I", 3)
    mutation("elf_dynamic_segment", unused, "<I", 2)
    mutation("elf_tls_segment", unused, "<I", 7)
    mutation("elf_noncode_entry", 24, "<Q", 0x400000200000)
    blob = bytearray(original)
    struct.pack_into("<II", blob, unused, 0x6474e551, 7)
    variants["elf_executable_stack"] = blob
    variants["elf_truncated"] = original[:40]
    symtab = None
    for i in range(shnum):
        off = shoff+i*64
        section = struct.unpack_from("<IIQQQQIIQQ", original, off)
        if section[1] == 2:
            symtab = section
            mutation("elf_bad_symbol_stride", off+56, "<Q", 1)
            mutation("elf_bad_string_link", off+40, "<I", shnum+1)
            break
    if symtab is None:
        raise RuntimeError("Fixture has no symbol table")
    strings_section = struct.unpack_from("<IIQQQQIIQQ", original, shoff+symtab[6]*64)
    strings = original[strings_section[4]:strings_section[4]+strings_section[5]]
    state_symbol = None
    other_global = None
    for off in range(symtab[4], symtab[4]+symtab[5], 24):
        name, info, _, _, _, _ = struct.unpack_from("<IBBHQQ", original, off)
        if strings[name:].split(b"\0", 1)[0] == b"ubytec_host_state":
            state_symbol = off
        elif info >> 4 == 1:
            other_global = off
    if state_symbol is None or other_global is None:
        raise RuntimeError("Required fixture symbols absent")
    mutation("elf_export_noncode", state_symbol+8, "<Q", 0x400000200000)
    mutation("elf_unterminated_export", state_symbol, "<I", strings_section[5])
    blob = bytearray(original)
    blob[other_global:other_global+24] = blob[state_symbol:state_symbol+24]
    variants["elf_duplicate_export"] = blob
    symbol_cases = {"elf_bad_symbol_stride", "elf_bad_string_link", "elf_export_noncode",
                    "elf_unterminated_export", "elf_duplicate_export"}
    results = []
    for name, blob in variants.items():
        path = output/(name+".elf")
        path.write_bytes(blob)
        args = [loader, "--call", path, "ubytec_host_state", 1, 1, 256] if name in symbol_cases else [loader, "--validate", path]
        response = run_rejected(args)
        results.append({"case": name, "pass": True, "response": response})
    return results

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=ROOT/"build/modules")
    parser.add_argument("--compiler-dll", type=Path)
    parser.add_argument("--assembly-directory", type=Path, help="Explicit Windows/other-host handoff of data.nasm and faults.nasm.")
    parser.add_argument("--skip-benchmark", action="store_true")
    parser.add_argument("--sanitizers", action="store_true", help="Repeat parser rejection/mutation checks under ASan/UBSan.")
    args = parser.parse_args()
    if platform.system() != "Linux" or platform.machine() not in {"x86_64", "amd64"}:
        parser.error("Execute module attacks only in Linux x86-64.")
    if args.assembly_directory and args.compiler_dll:
        parser.error("Choose compiler-dll or assembly-directory.")
    for tool in ("gcc", "clang", "ld", "nasm"):
        if not shutil.which(tool):
            parser.error(f"Missing {tool}.")
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    invalid = output/"invalid"
    invalid.mkdir(exist_ok=True)
    sources = [ROOT/"linux/modules.c",ROOT/"linux/many-wire.h", ROOT/"linux/module.ld", ROOT/"linux/hostile-module.nasm",
               ROOT/"linux/isolation.c", ROOT/"common/contract.h", ROOT/"run_modules.py",
               ROOT/"run.py", ROOT/"execution_cases.py", *[ROOT/f"ubytec/modules/{name}.ubc" for name in EXPORTS]]
    report = {
        "schema": 1, "accepted": False, "environment": platform.platform(),
        "source_sha256": {str(p.relative_to(ROOT)): digest(p) for p in sources},
        "exports": EXPORTS, "benchmarks_executed": not args.skip_benchmark, "sanitizers_executed": False,
        "limits": ["Linux x64 static ELF subset only; no relocations, interpreter, TLS or dynamic dependencies",
                   "Four uint64 arguments and one int64 result are a caller-defined experimental ABI",
                   "Trusted host selects artifacts/contracts; no signature-based publisher authentication",
                   "No module constructors or ELF entry point are automatically executed",
                   "Module code runs only after no_new_privs/seccomp in a new worker per call",
                   "Serialized loans; no delegation, concurrent or persistent grants",
                   "Direct writable loans can retain partial writes; copy commit requires validated success",
                   "ARM remains native fixtures, not a language backend",
                   "No microarchitectural side-channel or kernel/hardware failure guarantee"],
    }
    try:
        dll = args.compiler_dll
        if not args.assembly_directory:
            if dll is None:
                project = ROOT.parent.parent/"Ubytec/Ubytec.csproj"
                command(["dotnet", "build", project, "-c", "Release", "-p:EnableDocFxOnBuild=false",
                         "-p:GenerateDocumentationFile=false"], timeout=120)
                dll = project.parent/"bin/Release/net9.0/Ubytec.dll"
            dll = dll.resolve()
            report["compilation"] = {"mode": "source-compiled-in-runner", "compiler_sha256": digest(dll)}
        else:
            report["compilation"] = {"mode": "precompiled-cross-host-handoff", "assembly_sha256": {}}
        artifacts = []
        for name, exports in EXPORTS.items():
            asm = output/(name+".nasm")
            if args.assembly_directory:
                source = args.assembly_directory/(name+".nasm")
                report["compilation"]["assembly_sha256"][name] = digest(source)
                if source.resolve() != asm:
                    shutil.copyfile(source, asm)
            else:
                compiler = ["dotnet", dll, ROOT/f"ubytec/modules/{name}.ubc", "--library", "--tail-calls", "-o", asm]
                for function, symbol in exports.items():
                    compiler.extend(["--host-export", f"{function}=ubytec_host_{symbol}"])
                command(compiler)
            obj, elf = output/(name+".o"), output/(name+".elf")
            command(["nasm", "-f", "elf64", asm, "-o", obj])
            objects = [obj]
            if name == "data":
                private = output/"private-data.nasm"
                private.write_text("bits 64\nsection .data\n    dq 0x1122334455667788\nsection .note.GNU-stack noalloc noexec nowrite progbits\n")
                private_obj = output/"private-data.o"
                command(["nasm", "-f", "elf64", private, "-o", private_obj])
                objects.append(private_obj)
            command(["ld", "-T", ROOT/"linux/module.ld", "-e", "ubytec_host_"+next(iter(exports.values())),
                     "-z", "noexecstack", *objects, "-o", elf])
            artifacts.extend([asm, obj, elf])
        native_obj, native_elf = output/"hostile.o", output/"hostile.elf"
        command(["nasm", "-f", "elf64", ROOT/"linux/hostile-module.nasm", "-o", native_obj])
        command(["ld", "--defsym", "PRIVATE_BASE=0x400000200000", "-T", ROOT/"linux/module.ld",
                 "-e", "ubytec_host_open", "-z", "noexecstack", native_obj, "-o", native_elf])
        artifacts.extend([native_obj, native_elf])
        expected = CASES | {"recovery_after_"+c for c in CASES} | REJECTIONS
        for compiler in ("gcc", "clang"):
            loader = output/("modules-"+compiler)
            command([compiler, "-std=c11", "-O2", "-Wall", "-Wextra", "-Werror",
                     "-Wl,-z,noexecstack", ROOT/"linux/modules.c", "-o", loader])
            artifacts.append(loader)
            disposable = output/"disposable-hostile.elf"
            shutil.copyfile(native_elf, disposable)
            text = command([loader, "--tests", output/"data.elf", output/"faults.elf", disposable], timeout=30)
            (output/("modules-tests-"+compiler+".jsonl")).write_text(text)
            rows = records(text)
            require_cases(rows, expected)
            report[compiler+"_tests"] = rows
            execution_rows = execution_matrix(loader, native_elf, output/"data.elf", output/"faults.elf")
            report[compiler+"_execution_tests"] = execution_rows
            (output/("execution-tests-"+compiler+".jsonl")).write_text(
                "".join(json.dumps(row)+"\n" for row in execution_rows))
            valid = records(command([loader, "--validate", native_elf]))
            if len(valid) != 1 or valid[0]["accepted"] is not True:
                raise RuntimeError("Valid module was rejected")
        loader = output/"modules-gcc"
        report["malformed_tests"] = malformed_matrix(loader, native_elf, invalid)
        (output/"modules-malformed.jsonl").write_text("".join(json.dumps(r)+"\n" for r in report["malformed_tests"]))
        stress_loader = loader
        if args.sanitizers:
            sanitized = output/"modules-sanitized"
            command(["gcc", "-std=c11", "-O1", "-g", "-Wall", "-Wextra", "-Werror",
                     "-fsanitize=address,undefined", "-fno-sanitize-recover=all", "-fno-omit-frame-pointer",
                     ROOT/"linux/modules.c", "-o", sanitized])
            artifacts.append(sanitized)
            sanitized_output = output/"sanitized"
            sanitized_output.mkdir(exist_ok=True)
            report["sanitizer_checks"] = malformed_matrix(sanitized, native_elf, sanitized_output)
            (output/"modules-sanitized.jsonl").write_text("".join(json.dumps(r)+"\n" for r in report["sanitizer_checks"]))
            report["sanitizers_executed"] = True
            stress_loader = sanitized
        # Deterministic bounded corruption stress: acceptance or controlled rejection, never a crash.
        rng = random.Random(4294967297)
        fuzz = []
        original = native_elf.read_bytes()
        for i in range(64):
            blob = bytearray(original)
            for _ in range(1+i%4):
                offset = rng.randrange(len(blob))
                blob[offset] ^= 1 << rng.randrange(8)
            path = invalid/"mutation.elf"
            path.write_bytes(blob)
            result = subprocess.run([str(stress_loader), "--validate", str(path)], text=True, capture_output=True, timeout=10)
            if result.returncode not in (0, 1) or result.stderr.strip() or len(records(result.stdout)) != 1:
                raise RuntimeError(f"Malformed module crashed loader: {result.returncode} {result.stderr}")
            fuzz.append({"index": i, "accepted": result.returncode == 0})
        report["bounded_mutation_tests"] = fuzz
        if not args.skip_benchmark:
            text = command([loader, "--benchmark", output/"data.elf"], timeout=120)
            (output/"modules-benchmark.jsonl").write_text(text)
            report["benchmarks"] = records(text)
            expected_metrics = {(m,n) for m in ("module_invocation_and_read","module_worker_byte_read") for n in (256,4096,65536)}
            if {(r["metric"],r["bytes"]) for r in report["benchmarks"]} != expected_metrics or len(report["benchmarks"]) != 6:
                raise RuntimeError("Incomplete module benchmark matrix")
        report["artifact_sha256"] = {p.name: digest(p) for p in artifacts}
        report["accepted"] = True
    except Exception as error:
        report["error"] = str(error)
        raise
    finally:
        (output/"modules-report.json").write_text(json.dumps(report,indent=2)+"\n")
    print(f"PASS {len(CASES)} module cases + {len(CASES)} recovery checks + {len(REJECTIONS)} registry cases (GCC and Clang)")
    print(f"PASS {len(report['malformed_tests'])} malformed ELF cases + 64 bounded mutations")

if __name__ == "__main__":
    main()
