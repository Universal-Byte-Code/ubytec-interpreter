"""Finite serial reference for #39; not the native runtime or an ISA emulator."""
from collections import defaultdict, deque
from dataclasses import dataclass
import unittest

MAX = (1 << 64) - 1


def u64(value):
    if type(value) is not int or not 0 <= value <= MAX:
        raise ValueError("u64 domain exceeded")
    return value


@dataclass(frozen=True)
class Event:
    commit: int
    context: int
    local: int
    logical: int
    operation: tuple
    result: object


@dataclass(frozen=True)
class Outcome:
    trace: tuple
    memory: tuple
    blocked: tuple


def execute(programs, observations=()):
    """Context IDs are initial declaration ordinals. One committed effect per
    runnable context per sweep; blocked receives consume no event or fuel."""
    programs = tuple(tuple(p) for p in programs)
    samples = iter(observations)
    pc = [0] * len(programs)
    local = [0] * len(programs)
    logical = [0] * len(programs)
    mail = defaultdict(deque)
    memory = {}
    trace = []
    last_sample = None
    while True:
        progressed = False
        for ctx, program in enumerate(programs):
            if pc[ctx] == len(program):
                continue
            operation = program[pc[ctx]]
            op, *args = operation
            receive_clock = 0
            if op == "receive":
                (source,) = args
                if type(source) is not int or not 0 <= source < len(programs):
                    raise ValueError("unknown source")
                queue = mail[source, ctx]
                if not queue:
                    continue
                receive_clock, result = queue.popleft()
            elif op == "send":
                target, result = args
                if type(target) is not int or not 0 <= target < len(programs):
                    raise ValueError("unknown target")
                u64(result)
            elif op == "rmw":
                key, scale, delta = args
                result = u64(memory.get(key, 0) * scale + delta)
                memory[key] = result
            elif op == "read":
                (key,) = args
                result = memory.get(key, 0)
            elif op == "clock":
                if args:
                    raise ValueError("clock takes no operands")
                try:
                    result = u64(next(samples))
                except StopIteration as exc:
                    raise ValueError("missing clock observation") from exc
                if last_sample is not None and result < last_sample:
                    raise ValueError("clock regressed")
                last_sample = result
            elif op == "yield":
                if args:
                    raise ValueError("yield takes no operands")
                result = None
            elif op == "fault":
                (result,) = args
            else:
                raise ValueError("unsupported operation")
            local[ctx] = u64(local[ctx] + 1)
            logical[ctx] = u64(max(logical[ctx], receive_clock) + 1)
            if op == "send":
                mail[ctx, target].append((logical[ctx], result))
            trace.append(Event(u64(len(trace) + 1), ctx, local[ctx], logical[ctx], operation, result))
            pc[ctx] = len(program) if op == "fault" else pc[ctx] + 1
            progressed = True
        if not progressed:
            break
    sentinel = object()
    if next(samples, sentinel) is not sentinel:
        raise ValueError("unused clock observations")
    return Outcome(tuple(trace), tuple(sorted(memory.items())),
                   tuple(i for i, p in enumerate(programs) if pc[i] != len(p)))


def replay(programs, expected):
    samples = (event.result for event in expected.trace if event.operation[0] == "clock")
    actual = execute(programs, samples)
    if actual != expected:
        raise ValueError("replay mismatch")
    return actual


def fixed_step(accumulator, elapsed, duration, cap=MAX):
    """Integer clock units; capped catch-up preserves undispatched backlog."""
    accumulator, elapsed, duration, cap = map(u64, (accumulator, elapsed, duration, cap))
    if duration == 0:
        raise ValueError("zero step duration")
    total = u64(accumulator + elapsed)
    count = min(total // duration, cap)
    return count, total - count * duration


class ReferenceTests(unittest.TestCase):
    def test_three_contexts_clock_and_causality(self):
        programs = [[("receive", 1), ("read", "x"), ("clock",)],
                    [("rmw", "x", 1, 5), ("send", 0, 9)],
                    [("clock",), ("yield",)]]
        result = execute(programs, [100, 100])
        self.assertEqual([e.context for e in result.trace], [1, 2, 1, 2, 0, 0, 0])
        send, receive = result.trace[2], result.trace[4]
        self.assertGreater(receive.logical, send.logical)
        self.assertEqual(receive.result, 9)
        self.assertEqual(result.trace[5].result, 5)
        self.assertEqual([e.commit for e in result.trace], list(range(1, 8)))
        self.assertEqual(result.trace[4].local, 1)
        self.assertEqual(replay(programs, result), result)
        self.assertEqual(result.blocked, ())

    def test_explicit_order_changes_noncommutative_result(self):
        a, b = [("rmw", "x", 1, 1)], [("rmw", "x", 2, 0)]
        self.assertEqual(execute([a, b]).memory, (("x", 2),))
        self.assertEqual(execute([b, a]).memory, (("x", 1),))

    def test_blocked_and_fault(self):
        result = execute([[("receive", 1)], [("fault", "trap"), ("send", 0, 1)]])
        self.assertEqual(result.blocked, (0,))
        self.assertEqual(len(result.trace), 1)
        self.assertEqual(result.trace[0].result, "trap")

    def test_clock_replay_mismatch_and_bounds(self):
        with self.assertRaises(ValueError):
            execute([[('clock',), ('clock',)]], [2, 1])
        with self.assertRaises(ValueError):
            execute([[('clock',)]], [MAX + 1])
        with self.assertRaises(ValueError):
            execute([[('clock',)]], [])
        with self.assertRaises(ValueError):
            execute([[]], [1])
        expected = execute([[('rmw', 'x', 1, 2)]])
        with self.assertRaises(ValueError):
            replay([[('rmw', 'x', 1, 3)]], expected)

    def test_fixed_step_preserves_backlog(self):
        steps, rest = fixed_step(0, 101, 10, 3)
        self.assertEqual((steps, rest), (3, 71))
        self.assertEqual(fixed_step(rest, 0, 10), (7, 1))
        with self.assertRaises(ValueError):
            fixed_step(MAX, 1, 10)
        with self.assertRaises(ValueError):
            fixed_step(0, 0, 0)


if __name__ == '__main__':
    unittest.main()
