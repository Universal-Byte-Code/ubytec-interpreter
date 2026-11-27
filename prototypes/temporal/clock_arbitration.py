"""Temporal-v0 reference components; not a security boundary or native scheduler."""
from dataclasses import dataclass
import time
import unittest
from itertools import permutations

MAX = (1 << 64) - 1


def positive(value):
    if type(value) is not int or not 0 < value <= MAX:
        raise ValueError("expected positive u64")
    return value


@dataclass(frozen=True, order=True)
class TurnKey:
    round: int
    context: int

    def __post_init__(self):
        positive(self.round)
        positive(self.context)


@dataclass(frozen=True)
class Proposal:
    key: TurnKey
    pc: int
    charged: int
    boundary: tuple


class RoundInbox:
    """One proposal per snapshot member. Accept in any order, release in ordinal order.

    Coordinator-owned, serial API. A proposal is a private-work result, not
    permission to perform an effect. Missing members prevent later release.
    The caller validates worker computation and commits only released proposals.
    """
    def __init__(self, round_no, contexts, max_contexts=128):
        self.round = positive(round_no)
        ids = tuple(positive(c) for c in contexts)
        if len(ids) != len(set(ids)) or len(ids) > positive(max_contexts):
            raise ValueError("invalid frontier membership")
        self._order = tuple(sorted(ids))
        self._members = frozenset(ids)
        self._received = set()
        self._pending = {}
        self._next = 0

    def offer(self, proposal):
        if type(proposal) is not Proposal:
            raise ValueError("invalid proposal")
        key = proposal.key
        if key.round != self.round or key.context not in self._members:
            raise ValueError("stale, future or foreign turn")
        if key.context in self._received:
            raise ValueError("duplicate turn")
        self._pending[key.context] = proposal
        self._received.add(key.context)

    def take_ready(self):
        if self.complete:
            return None
        context = self._order[self._next]
        if context not in self._pending:
            return None
        result = self._pending.pop(context)
        self._next += 1
        return result

    @property
    def complete(self):
        return self._next == len(self._order)


@dataclass(frozen=True)
class ClockRecord:
    key: TurnKey
    nanoseconds: int


class ClockGrant:
    """Opaque reference token, checked by object identity (not a security capability)."""
    __slots__ = ()


class MasterClock:
    """One coordinator-owned clock domain, explicit grants and request-keyed replay.

    live() uses Linux CLOCK_MONOTONIC, excluding suspend. Replay never calls a
    host clock, including initialization. Fresh object defines a fresh domain.
    Host source injection exists for deterministic tests only.
    """
    def __init__(self, source=None, records=None):
        if (source is None) == (records is None):
            raise ValueError("choose exactly one clock mode")
        self._source = source
        self._origin = self._raw() if source is not None else None
        self._expected = tuple(records) if records is not None else None
        self._records = []
        self._grants = {}
        self._last_key = None
        self._last = None

    @classmethod
    def live(cls):
        if not hasattr(time, "CLOCK_MONOTONIC"):
            raise RuntimeError("monotonic clock unavailable")
        return cls(source=lambda: time.clock_gettime_ns(time.CLOCK_MONOTONIC))

    @classmethod
    def replay(cls, records):
        return cls(records=records)

    @property
    def records(self):
        return tuple(self._records)

    def _raw(self):
        value = self._source()
        if type(value) is not int or value < 0:
            raise ValueError("invalid host clock")
        return value

    def grant(self, context):
        positive(context)
        if context in self._grants:
            raise ValueError("duplicate clock grant")
        token = ClockGrant()
        self._grants[context] = token
        return token

    def revoke(self, context):
        if context not in self._grants:
            raise ValueError("unknown clock grant")
        del self._grants[context]

    def sample(self, key, grant):
        if self._grants.get(key.context) is not grant or grant is None:
            raise PermissionError("clock not granted to context")
        if self._last_key is not None and key <= self._last_key:
            raise ValueError("clock request out of admitted order")
        if self._expected is None:
            value = self._raw() - self._origin
        else:
            i = len(self._records)
            if i >= len(self._expected) or self._expected[i].key != key:
                raise ValueError("missing or mismatched replay sample")
            value = self._expected[i].nanoseconds
        if type(value) is not int or not 0 <= value <= MAX or (
                self._last is not None and value < self._last):
            raise ValueError("clock regression or overflow")
        self._records.append(ClockRecord(key, value))
        self._last_key, self._last = key, value
        return value

    def finish(self):
        if self._expected is not None and len(self._records) != len(self._expected):
            raise ValueError("unused replay samples")


class ClockArbitrationTests(unittest.TestCase):
    def test_every_arrival_permutation_has_same_order(self):
        proposals = [Proposal(TurnKey(1, c), 0, 1, ("rmw", "x", c))
                     for c in (1, 2, 3)]
        for arrival in permutations(proposals):
            inbox = RoundInbox(1, [3, 2, 1])
            result = []
            for proposal in arrival:
                inbox.offer(proposal)
                while (ready := inbox.take_ready()) is not None:
                    result.append(ready)
            self.assertTrue(inbox.complete)
            self.assertEqual(result, proposals)

    def test_reject_duplicates_wrong_round_and_missing_turn(self):
        inbox = RoundInbox(2, [1, 2])
        late = Proposal(TurnKey(2, 2), 0, 1, ("yield",))
        inbox.offer(late)
        self.assertIsNone(inbox.take_ready())
        with self.assertRaises(ValueError):
            inbox.offer(late)
        for key in (TurnKey(1, 1), TurnKey(3, 1), TurnKey(2, 3)):
            with self.assertRaises(ValueError):
                inbox.offer(Proposal(key, 0, 0, ("yield",)))
        inbox.offer(Proposal(TurnKey(2, 1), 0, 1, ("yield",)))
        self.assertEqual(inbox.take_ready().key.context, 1)
        self.assertEqual(inbox.take_ready(), late)
        self.assertTrue(inbox.complete)
        with self.assertRaises(ValueError):
            inbox.offer(late)

    def test_clock_grants_replay_and_equal_samples(self):
        values = iter([100, 110, 110, 150])
        clock = MasterClock(source=lambda: next(values))
        a, b = clock.grant(1), clock.grant(2)
        with self.assertRaises(PermissionError):
            clock.sample(TurnKey(1, 1), b)
        self.assertEqual(clock.sample(TurnKey(1, 1), a), 10)
        self.assertEqual(clock.sample(TurnKey(1, 2), b), 10)
        clock.revoke(1)
        with self.assertRaises(PermissionError):
            clock.sample(TurnKey(2, 1), a)
        self.assertEqual(clock.sample(TurnKey(2, 2), b), 50)
        replay = MasterClock.replay(clock.records)
        grants = {i: replay.grant(i) for i in (1, 2)}
        for record in clock.records:
            self.assertEqual(replay.sample(record.key, grants[record.key.context]),
                             record.nanoseconds)
        replay.finish()
        self.assertEqual(clock.records, replay.records)

    def test_clock_regression_overflow_and_replay_errors(self):
        clock = MasterClock(source=iter([100, 99]).__next__)
        with self.assertRaises(ValueError):
            clock.sample(TurnKey(1, 1), clock.grant(1))
        clock = MasterClock(source=iter([0, MAX + 1]).__next__)
        with self.assertRaises(ValueError):
            clock.sample(TurnKey(1, 1), clock.grant(1))
        record = ClockRecord(TurnKey(1, 1), 7)
        clock = MasterClock.replay([record])
        grant = clock.grant(1)
        with self.assertRaises(ValueError):
            clock.finish()
        with self.assertRaises(ValueError):
            clock.sample(TurnKey(2, 1), grant)
        self.assertEqual(clock.sample(record.key, grant), 7)
        with self.assertRaises(ValueError):
            clock.sample(record.key, grant)
        clock.finish()

    def test_real_monotonic_source(self):
        clock = MasterClock.live()
        grant = clock.grant(1)
        a = clock.sample(TurnKey(1, 1), grant)
        b = clock.sample(TurnKey(2, 1), grant)
        self.assertGreaterEqual(b, a)


if __name__ == "__main__":
    unittest.main()
