#!/usr/bin/env python3
"""Build and exercise both isolation prototypes on Linux x86-64.
No semihosting. Success requires every expected attack and resource case."""
import argparse
import hashlib
import json
import os
import platform
import queue
import shutil
import struct
import subprocess
import threading
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent
COMMON = {
    "read", "write", "read_only_write", "foreign_pointer", "monitor_pointer",
    "neighbor_pointer", "stack_overflow", "alter_permissions", "forged_request",
    "execute_data", "infinite_loop", "stale_pointer", "copy",
}
LINUX_EXTRA = {"open_resource", "create_process", "inspect_process", "new_mapping", "x32_syscall"}
ARM_EXTRA = {"bad_exception_frame", "semihosting", "raise_privilege", "bitband_alias", "invalid_service_frame", "mask_interrupts", "device_access"}

ARM_EXECUTION_BASE = {"ordinary_event_after_default", "cancel_no_deadline", "finite_custom_budget",
                      "unbounded_still_protected", "cancel_masked_interrupt_attempt", "cancel_finite_call"}
ARM_EXECUTION = ARM_EXECUTION_BASE | {"stale_after_"+c for c in ARM_EXECUTION_BASE} | {
    "recovery_after_"+c for c in ARM_EXECUTION_BASE} | {
    "invalid_execution_budget", "invalid_execution_rights", "invalid_execution_export"}

def command(args, timeout=60):
    result = subprocess.run([str(x) for x in args], text=True, capture_output=True, timeout=timeout)
    if result.returncode:
        raise RuntimeError(f"Command failed ({result.returncode}): {args}\n{result.stdout}\n{result.stderr}")
    return result.stdout

def records(text):
    return [json.loads(line) for line in text.splitlines() if line.startswith("{")]

def require_cases(rows, expected):
    cases = [r["case"] for r in rows if "case" in r]
    if set(cases) != expected or len(cases) != len(expected):
        raise RuntimeError(f"Missing, duplicate or unexpected cases: {cases}")
    if any(r.get("pass") is False for r in rows):
        raise RuntimeError("Containment or resource test failed")
    # Rejection must correspond to the exercised mechanism, not bootstrap failure.
    for row in rows:
        if row.get("case") in {"read", "write", "copy"} and row.get("signal", 0):
            raise RuntimeError("Authorized operation failed")

def run_arm(qemu, elf, timeout=30):
    args = [qemu, "-M", "mps2-an385", "-cpu", "cortex-m3", "-nographic",
            "-monitor", "none", "-serial", "stdio", "-kernel", str(elf)]
    # Do NOT add -semihosting. Native bkpt must not obtain host services.
    process = subprocess.Popen(args, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, bufsize=1)
    lines, incoming = [], queue.Queue()
    def reader():
        for line in process.stdout:
            incoming.put(line)
        incoming.put(None)
    thread = threading.Thread(target=reader, daemon=True)
    thread.start()
    deadline = time.monotonic() + timeout
    done = None
    event_inputs = iter(("E", "C", "C", "C"))
    events_sent = 0
    try:
        while time.monotonic() < deadline:
            try:
                line = incoming.get(timeout=min(1, max(0.01, deadline-time.monotonic())))
            except queue.Empty:
                continue
            if line is None:
                break
            lines.append(line)
            if line.startswith("{") and json.loads(line).get("event") == "arm-await-input":
                row = json.loads(line)
                if row["ticks"] < 12:
                    raise RuntimeError("ARM did not survive its old watchdog")
                byte = next(event_inputs, None)
                if byte is None:
                    raise RuntimeError("Unexpected ARM input request")
                # A command for another invocation must not cancel this one.
                if byte == "E":
                    process.stdin.buffer.write(b"C"+struct.pack("<I", row["invocation"]-1))
                process.stdin.buffer.write(byte.encode("ascii")+struct.pack("<I", row["invocation"]))
                process.stdin.buffer.flush()
                events_sent += 1
            if line.startswith("DONE failures="):
                done = int(line.split("=")[1])
                break
        if done is None or done or events_sent != 4:
            raise RuntimeError("ARM did not complete successfully:\n" + "".join(lines))
    finally:
        if process.poll() is None:
            process.terminate()
            try:
                process.wait(timeout=3)
            except subprocess.TimeoutExpired:
                process.kill()
                process.wait()
        thread.join(timeout=1)
    return "".join(lines)

def elf_resources(path):
    data = path.read_bytes()
    if data[:6] != b"\x7fELF\x01\x01":
        raise RuntimeError("Expected little-endian ELF32 ARM")
    header = struct.unpack_from("<16sHHIIIIIHHHHHH", data)
    shoff, shsize, shcount, string_index = header[6], header[11], header[12], header[13]
    sections = [struct.unpack_from("<IIIIIIIIII", data, shoff+i*shsize) for i in range(shcount)]
    strings = sections[string_index]
    names = data[strings[4]:strings[4]+strings[5]]
    output = {}
    for section in sections:
        if section[2] & 2:  # SHF_ALLOC
            name = names[section[0]:].split(b"\0", 1)[0].decode()
            output[name] = section[5]
    return output

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=ROOT/"build")
    parser.add_argument("--skip-benchmark", action="store_true")
    args = parser.parse_args()
    if platform.system() != "Linux" or platform.machine() not in {"x86_64", "amd64"}:
        parser.error("Run in Linux x86-64 (WSL2 is supported); do not run native attack fixtures on Windows.")
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    for executable in ["gcc", "clang", "ld.lld", "qemu-system-arm"]:
        if not shutil.which(executable):
            parser.error(f"Missing {executable}; install gcc clang lld qemu-system-arm")
    linux = output/"linux-isolation"
    arm = output/"arm.elf"
    command(["gcc", "-std=c11", "-O2", "-Wall", "-Wextra", "-Werror", ROOT/"linux/isolation.c", "-o", linux])
    command(["clang", "--target=arm-none-eabi", "-mcpu=cortex-m3", "-mthumb", "-ffreestanding",
             "-fno-builtin", "-fno-jump-tables", "-O2", "-Wall", "-Wextra", "-Werror",
             "-nostdlib", "-fuse-ld=lld", f"-Wl,-T,{ROOT/'arm/linker.ld'}", f"-Wl,-Map,{output/'arm.map'}",
             ROOT/"arm/startup.S", ROOT/"arm/monitor.c", "-o", arm])
    report = {
        "schema": 1, "accepted": False, "benchmarks_executed": not args.skip_benchmark,
        "environment": {
            "platform": platform.platform(), "machine": platform.machine(),
            "gcc": command(["gcc", "--version"]).splitlines()[0],
            "clang": command(["clang", "--version"]).splitlines()[0],
            "qemu": command(["qemu-system-arm", "--version"]).splitlines()[0],
        },
        "source_sha256": {str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
                          for p in sorted(ROOT.rglob("*")) if p.is_file() and p.suffix in {".c", ".h", ".S", ".ld", ".py"} and "build" not in p.relative_to(ROOT).parts},
        "limits": ["Native fixtures, not language integration", "ARM is QEMU, not physical-board timing",
                   "No microarchitectural side-channel claim", "Trusted OS/MPU/monitor/toolchain",
                   "One invocation at a time; no persistent loans or delegation"],
    }
    try:
        linux_text = command([linux], timeout=30)
        (output/"linux-tests.jsonl").write_text(linux_text)
        report["linux_tests"] = records(linux_text)
        require_cases(report["linux_tests"], COMMON | LINUX_EXTRA)
        arm_text = run_arm("qemu-system-arm", arm)
        (output/"arm-tests.log").write_text(arm_text)
        report["arm_tests"] = records(arm_text)
        require_cases(report["arm_tests"], COMMON | ARM_EXTRA | ARM_EXECUTION)
        execution_rows = [r for r in report["arm_tests"] if r.get("case") in ARM_EXECUTION]
        if any(not r.get("loan_revoked") for r in execution_rows):
            raise RuntimeError("ARM execution policy retained a loan")
        report["arm_execution_tests"] = execution_rows
        sizes = [r["resource_bytes"] for r in report["arm_tests"] if "resource_bytes" in r]
        if sizes != [256, 4096, 65536]:
            raise RuntimeError("ARM size matrix incomplete")
        report["arm_elf_section_bytes"] = elf_resources(arm)
        if not args.skip_benchmark:
            bench = command([linux, "--benchmark"], timeout=120)
            (output/"linux-benchmark.jsonl").write_text(bench)
            report["linux_benchmarks"] = records(bench)
            expected = {(m, n) for m in ["invocation_and_read", "copy_only", "local_byte_read_baseline", "worker_byte_read"]
                        for n in [256, 4096, 65536]}
            actual = {(r["metric"], r["bytes"]) for r in report["linux_benchmarks"]}
            if expected != actual or len(report["linux_benchmarks"]) != len(expected):
                raise RuntimeError("Benchmark matrix incomplete")
        report["accepted"] = True
    except Exception as error:
        report["error"] = str(error)
        raise
    finally:
        (output/"report.json").write_text(json.dumps(report, indent=2)+"\n")
    print(f"PASS Linux {len(COMMON|LINUX_EXTRA)} cases; ARM {len(COMMON|ARM_EXTRA)} cases + {len(ARM_EXECUTION)} execution checks + 3 sizes")
    print(f"Report: {output/'report.json'}")
    if args.skip_benchmark:
        print("Benchmarks skipped; this run is containment-only.")

if __name__ == "__main__":
    main()
