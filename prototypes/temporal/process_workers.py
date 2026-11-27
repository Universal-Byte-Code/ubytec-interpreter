"""Process-parallel private turn preparation; coordinator owns all effects."""
from concurrent.futures import ProcessPoolExecutor, as_completed
from dataclasses import dataclass
import multiprocessing
import os
import time
import unittest

from frontier import execute, prepare_turn
from clock_arbitration import MasterClock


@dataclass(frozen=True)
class Diagnostic:
    round: int
    context: int
    pid: int
    start_ns: int
    end_ns: int


def prepare_in_worker(round_no, cid, context, quantum, delay, gate):
    start = time.monotonic_ns()
    if gate is not None:
        gate.wait(timeout=15)
    if delay:
        time.sleep(delay)
    proposal = prepare_turn(round_no, cid, context, quantum)
    return proposal, Diagnostic(round_no, cid, os.getpid(), start, time.monotonic_ns())


class ProcessWorkers:
    """Trusted subprocess workers, no shared-state/clock grants. Diagnostics are nonsemantic.

    Coordinator independently validates private proposals against the serial model.
    This deliberately duplicates work and is not a speedup claim.
    """
    def __init__(self, count=3, delays=None, first_round_gate=None):
        if not 1 <= count <= 32:
            raise ValueError("invalid worker count")
        self.pool = ProcessPoolExecutor(max_workers=count,
                                        mp_context=multiprocessing.get_context("spawn"))
        self.delays = dict(delays or {})
        self.gate = first_round_gate
        self.diagnostics = []

    def __enter__(self):
        return self

    def __exit__(self, *_):
        self.pool.shutdown(wait=True, cancel_futures=True)

    def prepare(self, round_no, contexts, quantum):
        tasks = [self.pool.submit(prepare_in_worker, round_no, cid, ctx, quantum,
                                  self.delays.get(cid, 0),
                                  self.gate if round_no == 1 else None)
                 for cid, ctx in contexts]
        for future in as_completed(tasks, timeout=30):
            proposal, diagnostic = future.result()
            self.diagnostics.append(diagnostic)
            yield proposal


class ProcessWorkerTests(unittest.TestCase):
    def test_real_processes_overlap_and_preserve_complete_trace(self):
        programs = [
            [("tick",), ("rmw", "x", 1, 1), ("sleep_until", 15), ("read", "x")],
            [("tick",), ("rmw", "x", 2, 0), ("clock",), ("send", 3, 7)],
            [("receive", 2), ("rmw", "x", 1, 3)]]
        journal = [(1, 5, "timer_sample", 15)]
        options = dict(journal=journal, timer_contexts=(1,), samples=[(2, 2, 10)])
        expected = execute(programs, **options)
        with multiprocessing.Manager() as manager:
            for delays in ({1: .08, 2: .04}, {2: .08, 3: .04}):
                with ProcessWorkers(3, delays, manager.Barrier(3)) as workers:
                    actual = execute(programs, worker_pool=workers, **options)
                    self.assertEqual(actual, expected)
                    first = [d for d in workers.diagnostics if d.round == 1]
                    self.assertEqual(len({d.pid for d in first}), 3)
                    self.assertNotIn(os.getpid(), {d.pid for d in first})
                    self.assertLess(max(d.start_ns for d in first), min(d.end_ns for d in first))
                    self.assertEqual(actual.memory[0][1][:2], (5, 3))

    def test_worker_clock_observations_remain_coordinator_owned(self):
        programs = [[("clock",)], [("clock",)]]
        source_calls = []
        values = iter([100, 110, 110])
        def source():
            source_calls.append(os.getpid())
            return next(values)
        clock = MasterClock(source=source)
        with ProcessWorkers(2, {1: .03}) as workers:
            out = execute(programs, clock=clock, clock_contexts=(1, 2), worker_pool=workers)
        self.assertEqual(source_calls, [os.getpid()] * 3)
        self.assertEqual(out, execute(programs, samples=[(1, 1, 10), (1, 2, 10)]))


if __name__ == "__main__":
    unittest.main()
