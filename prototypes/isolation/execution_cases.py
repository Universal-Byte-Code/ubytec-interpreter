"""Host-selected execution policies for ordinary module invocations."""
import json
import os
import select
import signal
import subprocess
import time

def execution_matrix(loader, native, data, faults):
    rows = []
    def record(name, passed):
        if not passed:
            raise RuntimeError("Execution policy failed: "+name)
        rows.append({"case": name, "pass": True})
    def launch(artifact, symbol, policy, input_byte=False):
        args = [str(loader), "--call", str(artifact), symbol, "1", "1", "256", policy]
        if input_byte:
            args.append("--input-byte")
        process = subprocess.Popen(args, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        try:
            if not select.select([process.stdout], [], [], 5)[0]:
                raise RuntimeError("Missing worker-start event")
            event = json.loads(process.stdout.readline())
            if event.get("event") != "started":
                raise RuntimeError("Invalid worker-start event")
            return process, event
        except BaseException:
            process.kill()
            process.communicate()
            raise
    def finish(process, event):
        try:
            output, error = process.communicate(timeout=5)
            result = json.loads(output)
            # wait4 must finish before the host reports a result.
            reaped = not os.path.exists("/proc/"+str(event["worker_pid"]))
            return result, not error and reaped
        finally:
            if process.poll() is None:
                process.kill()
                process.communicate()
    process, event = launch(native, "ubytec_host_wait_input", "none", True)
    try:
        time.sleep(1.2)
        alive = process.poll() is None
        process.stdin.write(bytes([42]))
        process.stdin.flush()
        result, clean = finish(process, event)
        record("ordinary_event_after_old_deadline", alive and clean and process.returncode == 0 and
               result["value"] == 42 and not result["timeout"] and not result["cancelled"])
    finally:
        if process.poll() is None:
            process.kill()
            process.communicate()
    for name, signo in (("cancel_usr1", signal.SIGUSR1), ("cancel_int", signal.SIGINT), ("cancel_term", signal.SIGTERM)):
        process, event = launch(data, "ubytec_host_tail_infinite", "none")
        try:
            time.sleep(1.2)
            alive = process.poll() is None
            process.send_signal(signo)
            result, clean = finish(process, event)
            record(name, alive and clean and process.returncode == 1 and
                   result["cancelled"] == 1 and result["timeout"] == 0 and result["signal"] == signal.SIGKILL)
        finally:
            if process.poll() is None:
                process.kill()
                process.communicate()
    process, event = launch(data, "ubytec_host_tail_infinite", "100")
    result, clean = finish(process, event)
    record("finite_budget", clean and process.returncode == 1 and result["timeout"] == 1 and not result["cancelled"])
    process, event = launch(faults, "ubytec_host_read_only_write", "none")
    result, clean = finish(process, event)
    record("unbounded_still_protected", clean and process.returncode == 1 and
           result["signal"] == signal.SIGSEGV and not result["timeout"] and not result["cancelled"])
    for policy in ("0", "-1", "3600001", "forever", "100x"):
        result = subprocess.run([str(loader), "--call", str(data), "ubytec_host_read", "1", "1", "256", policy],
                                capture_output=True, timeout=5)
        record("invalid_budget_"+policy, result.returncode == 2 and not result.stdout and not result.stderr)
    return rows
