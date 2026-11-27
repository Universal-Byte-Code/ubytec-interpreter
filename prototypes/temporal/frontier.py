"""Executable subset of schema temporal-execution-v0.

Abstract instruction tokens, not a UBCM interpreter. Serial reference only.
All operations are in-memory; no host clock, native IO, or authority claim.
Run: python prototypes/temporal/frontier.py
"""
from collections import defaultdict, deque
from dataclasses import dataclass, field, replace
import unittest
from clock_arbitration import MasterClock, RoundInbox, TurnKey, Proposal

MAX = (1 << 64) - 1


def u64(n):
    if type(n) is not int or not 0 <= n <= MAX:
        raise ValueError("outside u64")
    return n


@dataclass(frozen=True)
class Event:
    round: int
    commit: int
    context: int
    local: int
    logical: int
    kind: str
    args: tuple
    result: object
    dependencies: tuple

    @property
    def id(self):
        return self.context, self.local


@dataclass
class Context:
    program: tuple
    pc: int = 0
    pending: tuple | None = None
    terminal: str | None = None
    creation: tuple | None = None


@dataclass(frozen=True)
class Outcome:
    events: tuple
    memory: tuple
    contexts: tuple
    messages: tuple
    fuel: tuple


def prepare_turn(round_no, cid, ctx, quantum):
    """Pure private-work projection; never reads shared state or samples time."""
    key = TurnKey(round_no, cid)
    if ctx.pending is not None:
        return Proposal(key, ctx.pc, 0, ctx.pending)
    pc, charged = ctx.pc, 0
    while charged < quantum:
        if pc == len(ctx.program):
            return Proposal(key, pc, charged, ("$terminate",))
        instruction = ctx.program[pc]
        op, *args = instruction
        charged += 1
        if op == "tick":
            if args:
                raise ValueError("tick takes no args")
            pc += 1
        elif op == "jump":
            (target,) = args
            if type(target) is not int or not 0 <= target < len(ctx.program):
                raise ValueError("invalid abstract jump")
            pc = target
        elif op in ("receive", "send", "read", "write", "rmw", "clock", "spawn", "yield", "fault"):
            return Proposal(key, pc, charged, instruction)
        else:
            raise ValueError("unsupported abstract instruction")
    return Proposal(key, pc, charged, ("$budget",))


def execute(programs, *, quantum=3, journal=(), samples=(),
            max_events=10000, max_contexts=128, max_messages=4096,
            arrival_order=None, clock=None, clock_contexts=()):
    """Journal rows (ordinal, round, 'cancel', context).
    Samples (round, context, nanoseconds) are request-keyed inputs.
    Each abstract token costs one instruction, except synthetic termination.
    A pending receive is charged once. Spawned contexts join next round.
    """
    for limit in (quantum, max_events, max_contexts, max_messages):
        if u64(limit) == 0:
            raise ValueError("zero resource limit")
    programs = tuple(tuple(p) for p in programs)
    if len(programs) > max_contexts:
        raise ValueError("context limit")
    contexts = {i: Context(p) for i, p in enumerate(programs, 1)}
    journal = tuple(journal)
    prior_round = 0
    for i, (ordinal, target_round, kind, target) in enumerate(journal, 1):
        if u64(ordinal) != i or u64(target_round) == 0 or target_round < prior_round:
            raise ValueError("journal ordering")
        if kind != "cancel" or u64(target) == 0:
            raise ValueError("unsupported journal entry")
        prior_round = target_round
    samples = deque(samples)
    if clock is not None and samples:
        raise ValueError("choose clock adapter or supplied samples")
    if clock is None and clock_contexts:
        raise ValueError("clock grants require an adapter")
    grants = {}
    for cid in clock_contexts:
        if cid not in contexts or cid in grants:
            raise ValueError("clock grants require distinct initial contexts")
        grants[cid] = clock.grant(cid)
    last_sample = None
    events, committed, last = [], {}, {}
    memory = {}  # key -> (value, version, last writer event ID)
    mail = defaultdict(deque)
    fuel = defaultdict(int)
    journal_index = 0
    round_no = 0

    def commit(ctx, kind, args=(), result=None, deps=()):
        if len(events) >= max_events:
            raise ValueError("trace limit")
        previous = last.get(ctx)
        local = u64(1 + (previous.local if previous else 0))
        creation = contexts[ctx].creation if ctx and previous is None else None
        deps = tuple(sorted(set(d for d in (*deps, creation) if d is not None)))
        if any(d not in committed for d in deps):
            raise ValueError("uncommitted dependency")
        logical = u64(1 + max([previous.logical if previous else 0] +
                              [committed[d].logical for d in deps]))
        event = Event(round_no, u64(len(events) + 1), ctx, local, logical,
                      kind, tuple(args), result, deps)
        events.append(event)
        committed[event.id] = event
        last[ctx] = event
        return event

    def get_context(ctx):
        if type(ctx) is not int or ctx not in contexts:
            raise ValueError("unknown context")
        return contexts[ctx]

    def key_checked(key):
        if not isinstance(key, str):
            raise ValueError("shared key must be text")
        return key

    while any(c.terminal is None for c in contexts.values()):
        round_no = u64(round_no + 1)
        progressed = False
        while journal_index < len(journal) and journal[journal_index][1] == round_no:
            ordinal, _, kind, target = journal[journal_index]
            ctx = get_context(target)
            admission = commit(0, "admit", (ordinal, kind, target))
            if ctx.terminal is None:
                commit(target, "cancel", (ordinal,), ctx.pending, (admission.id,))
                ctx.pending, ctx.terminal = None, "cancelled"
            else:
                # The admission records a no-op cancellation explicitly.
                commit(0, "cancel_noop", (ordinal, target), ctx.terminal, (admission.id,))
            journal_index += 1
            progressed = True
        frontier = tuple(cid for cid in sorted(contexts) if contexts[cid].terminal is None)
        planned = tuple(prepare_turn(round_no, cid, contexts[cid], quantum) for cid in frontier)
        inbox = RoundInbox(round_no, frontier, max_contexts)
        expected = {p.key: p for p in planned}
        arrivals = planned if arrival_order is None else arrival_order(planned)
        for proposal in arrivals:
            if proposal.key not in expected or proposal != expected[proposal.key]:
                raise ValueError("proposal differs from reference private work")
            inbox.offer(proposal)
        while not inbox.complete:
            proposal = inbox.take_ready()
            if proposal is None:
                raise ValueError("incomplete frontier")
            cid = proposal.key.context
            ctx = contexts[cid]
            ctx.pc = proposal.pc
            charged = proposal.charged
            fuel[cid] = u64(fuel[cid] + charged)
            progressed |= charged > 0
            instruction = proposal.boundary
            op, *args = instruction
            if op == "$terminate":
                commit(cid, "terminate")
                ctx.terminal = "completed"
                progressed = True
                continue
            if op == "$budget":
                commit(cid, "budget", (charged,), ctx.pc)
                continue
            if op == "receive":
                (source,) = args
                get_context(source)
                queue = mail[source, cid]
                if not queue:
                    ctx.pending = instruction
                    continue
                value, cause = queue[0]
                commit(cid, op, args, value, (cause,))
                queue.popleft()
            elif op == "send":
                target, value = args
                get_context(target)
                u64(value)
                if sum(len(q) for q in mail.values()) >= max_messages:
                    raise ValueError("message limit")
                event = commit(cid, op, args, value)
                mail[cid, target].append((value, event.id))
            elif op in ("read", "write", "rmw"):
                key = key_checked(args[0])
                value, version, writer = memory.get(key, (0, 0, None))
                if op == "read":
                    if len(args) != 1:
                        raise ValueError("read arity")
                    commit(cid, op, args, (value, version), (writer,))
                else:
                    if op == "write":
                        _, new = args
                        new = u64(new)
                    else:
                        _, scale, delta = args
                        new = u64(value * u64(scale) + u64(delta))
                    version = u64(version + 1)
                    event = commit(cid, op, args, (new, version), (writer,))
                    memory[key] = (new, version, event.id)
            elif op == "clock":
                if args:
                    raise ValueError("invalid clock request")
                if clock is not None:
                    # Check the publication bound before consuming a host sample.
                    if len(events) >= max_events:
                        raise ValueError("trace limit")
                    value = clock.sample(TurnKey(round_no, cid), grants.get(cid))
                else:
                    if not samples:
                        raise ValueError("missing clock sample")
                    r, c, value = samples[0]
                    if (r, c) != (round_no, cid):
                        raise ValueError("clock request key mismatch")
                    value = u64(value)
                    if last_sample is not None and value < last_sample:
                        raise ValueError("clock regressed")
                commit(cid, op, (), value)
                if clock is None:
                    samples.popleft()
                last_sample = value
            elif op == "spawn":
                (program,) = args
                if len(contexts) >= max_contexts:
                    raise ValueError("context limit")
                child = len(contexts) + 1
                program = tuple(program)
                event = commit(cid, op, (program,), child)
                contexts[child] = Context(program, creation=event.id)
            elif op == "yield":
                if args:
                    raise ValueError("yield arity")
                commit(cid, op)
            elif op == "fault":
                (reason,) = args
                commit(cid, op, args, reason)
                ctx.terminal = "faulted"
            else:
                raise ValueError("unsupported abstract instruction")
            ctx.pc += 1
            ctx.pending = None
            progressed = True
        if not progressed:
            break
    if journal_index != len(journal) or samples:
        raise ValueError("unused external inputs")
    if clock is not None:
        clock.finish()
    return Outcome(tuple(events), tuple(sorted(memory.items())),
                   tuple((i, c.pc, c.pending, c.terminal) for i, c in contexts.items()),
                   tuple((key, tuple(q)) for key, q in sorted(mail.items()) if q),
                   tuple((i, fuel[i]) for i in contexts))


def replay(programs, expected, *, journal=(), **limits):
    samples = [(e.round, e.context, e.result) for e in expected.events if e.kind == "clock"]
    actual = execute(programs, journal=journal, samples=samples, **limits)
    if actual != expected:
        raise ValueError("replay mismatch")
    return actual


class FrontierTests(unittest.TestCase):
    def test_block_retry_and_memory_dependencies(self):
        programs = [
            [("receive", 2), ("read", "x"), ("clock",)],
            [("write", "x", 5), ("send", 1, 9), ("rmw", "x", 2, 1)],
            [("clock",), ("yield",)]]
        out = execute(programs, samples=[(1, 3, 100), (5, 1, 100)])
        by_kind = {e.kind: e for e in out.events}
        receive, send = by_kind["receive"], by_kind["send"]
        self.assertEqual(receive.round, 3)
        self.assertIn(send.id, receive.dependencies)
        self.assertIn(by_kind["write"].id, by_kind["rmw"].dependencies)
        self.assertIn(by_kind["rmw"].id, by_kind["read"].dependencies)
        self.assertEqual(by_kind["read"].result, (11, 2))
        self.assertEqual(out.fuel, ((1, 3), (2, 3), (3, 2)))
        self.assertEqual(replay(programs, out), out)

    def test_spawn_next_round_and_cancel_retained_receive(self):
        child = (("receive", 1),)
        programs = [[("spawn", child), ("yield",), ("yield",)]]
        out = execute(programs, journal=[(1, 3, "cancel", 2)])
        self.assertEqual(out.contexts[1][3], "cancelled")
        cancel = next(e for e in out.events if e.kind == "cancel")
        spawn = next(e for e in out.events if e.kind == "spawn")
        admission = next(e for e in out.events if e.kind == "admit")
        self.assertEqual(cancel.result, ("receive", 1))
        self.assertIn(spawn.id, cancel.dependencies)
        self.assertIn(admission.id, cancel.dependencies)
        self.assertEqual(out.fuel[1], (2, 1))
        self.assertEqual(replay(programs, out, journal=[(1, 3, "cancel", 2)]), out)

    def test_fuel_boundary_and_event_priority(self):
        out = execute([[("tick",), ("yield",), ("tick",), ("tick",), ("yield",)]], quantum=2)
        self.assertEqual([e.kind for e in out.events], ["yield", "budget", "yield", "terminate"])
        self.assertEqual(out.fuel, ((1, 5),))
        with self.assertRaisesRegex(ValueError, "trace limit"):
            execute([[("jump", 0)]], quantum=2, max_events=4)

    def test_same_round_enable_and_quiescence(self):
        out = execute([[("send", 2, 1)], [("receive", 1)]])
        receive = next(e for e in out.events if e.kind == "receive")
        self.assertEqual(receive.round, 1)
        blocked = execute([[("receive", 1)]])
        self.assertEqual(blocked.events, ())
        self.assertEqual(blocked.contexts, ((1, 0, ("receive", 1), None),))
        self.assertEqual(blocked.fuel, ((1, 1),))

    def test_shuffled_proposals_and_mediated_clock(self):
        from itertools import permutations
        programs = [[("tick",), ("rmw", "x", 1, 1), ("clock",)],
                    [("rmw", "x", 2, 0), ("clock",)],
                    [("read", "x"), ("yield",)]]
        expected = execute(programs, samples=[(2, 1, 7), (2, 2, 7)])
        for order in permutations((1, 2, 3)):
            rank = {cid: i for i, cid in enumerate(order)}
            actual = execute(programs, samples=[(2, 1, 7), (2, 2, 7)],
                             arrival_order=lambda p: sorted(p, key=lambda x: rank[x.key.context]))
            self.assertEqual(actual, expected)
        clock = MasterClock(source=iter([100, 107, 107]).__next__)
        self.assertEqual(execute(programs, clock=clock, clock_contexts=(1, 2),
                                 arrival_order=lambda p: reversed(p)), expected)
        recorded = MasterClock.replay(clock.records)
        self.assertEqual(execute(programs, clock=recorded, clock_contexts=(1, 2)), expected)
        with self.assertRaises(PermissionError):
            execute([[("clock",)]], clock=MasterClock(source=lambda: 100))
        with self.assertRaisesRegex(ValueError, "incomplete frontier"):
            execute(programs, arrival_order=lambda p: p[1:])
        with self.assertRaisesRegex(ValueError, "differs"):
            execute(programs, arrival_order=lambda p: [replace(p[0], charged=99), *p[1:]])

    def test_order_clock_keys_and_replay_failure(self):
        a, b = [("rmw", "x", 1, 1)], [("rmw", "x", 2, 0)]
        self.assertEqual(execute([a, b]).memory[0][1][:2], (2, 2))
        self.assertEqual(execute([b, a]).memory[0][1][:2], (1, 2))
        with self.assertRaises(ValueError):
            execute([[("clock",)]], samples=[(2, 1, 1)])
        with self.assertRaises(ValueError):
            execute([[("clock",), ("clock",)]], samples=[(1, 1, 2), (2, 1, 1)])
        out = execute([a])
        with self.assertRaises(ValueError):
            replay([a], replace(out, events=out.events[:-1]))
        with self.assertRaises(ValueError):
            execute([a], journal=[(1, 5, "cancel", 1)])


if __name__ == "__main__":
    unittest.main()
