using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableTemporalParityTests
{
    [Fact]
    public void AllSixFrontierPermutationsAndInvalidBatches()
    {
        Guid session = Guid.NewGuid();
        var keys = Enumerable.Range(1, 3).Select(i => new PortableTurnKey(1, new(session, (ulong)i))).ToArray();
        var proposals = keys.Select(k => new PortableTurnProposal(k, PortableTurnKind.Yield)).ToArray();
        foreach (int[] order in new[] { new[] { 0, 1, 2 }, new[] { 0, 2, 1 }, new[] { 1, 0, 2 },
            new[] { 1, 2, 0 }, new[] { 2, 0, 1 }, new[] { 2, 1, 0 } })
            Assert.Equal(proposals, PortableTurnFrontier.Order(keys, order.Select(i => proposals[i]).ToArray()).ToArray());
        Assert.Throws<InvalidDataException>(() => PortableTurnFrontier.Order(keys, proposals[..2]));
        Assert.Throws<InvalidDataException>(() => PortableTurnFrontier.Order(keys, [proposals[0], proposals[0], proposals[2]]));
        Assert.Throws<InvalidDataException>(() => PortableTurnFrontier.Order(keys,
            [proposals[0], proposals[1], proposals[2] with { Key = keys[2] with { Round = 2 } }]));
        Assert.Throws<InvalidDataException>(() => PortableTurnFrontier.Order(keys,
            [proposals[0], proposals[1], proposals[2] with { Key = new(1, new(Guid.NewGuid(), 3)) }]));
        var c = new PortableTemporalCoordinator();
        c.CreateContext(); c.CreateContext();
        Assert.Throws<InvalidDataException>(() => c.RunRound(k => new(k.Context.Ordinal == 2 ? k with { Round = 2 } : k, PortableTurnKind.Yield)));
        Assert.Equal(2, c.Events.Count); // no primary effect committed before validation
    }

    [Fact]
    public void PhysicalClockAdapterRemainsOnOwnerAndWaitExpiresOnSample()
    {
        int owner = Environment.CurrentManagedThreadId;
        var calls = new List<int>();
        var c = new PortableTemporalCoordinator(source: () => { calls.Add(Environment.CurrentManagedThreadId); return 5; });
        var a = c.CreateContext(timer: true);
        c.CreateContext(clock: true);
        c.RunRound(k => k.Context == a ? new(k, PortableTurnKind.SleepUntil, 5) : new(k, PortableTurnKind.SampleClock), parallel: true);
        Assert.Equal(new[] { owner }, calls.ToArray());
        Assert.Equal(0, c.SuspendedCount);
        var expiry = c.Events.Single(e => e.Effect!.Kind == PortableTemporalEffectKind.TimerExpire);
        Assert.Equal(1UL, expiry.Effect!.Round);
        Assert.Contains(c.Events.Single(e => e.Effect!.Kind == PortableTemporalEffectKind.ClockSample).Id, expiry.Effect.Dependencies);
        c.RunRound(k => new(k, PortableTurnKind.Terminate));
    }

    [Fact]
    public void RevocationIsJournaledAndPreventsHostSampling()
    {
        int calls = 0;
        var c = new PortableTemporalCoordinator(source: () => { calls++; return 10; });
        var a = c.CreateContext(clock: true);
        c.QueueAdmission(new(1, 2, PortableAdmissionKind.RevokeClock, a.Ordinal));
        c.RunRound(k => new(k, PortableTurnKind.SampleClock));
        Assert.Throws<UnauthorizedAccessException>(() => c.RunRound(k => new(k, PortableTurnKind.SampleClock)));
        Assert.Equal(1, calls);
        var revoked = c.Events.Single(e => e.Effect!.Kind == PortableTemporalEffectKind.ClockGrantRevoked);
        Assert.Equal(c.Events.Single(e => e.Effect!.Kind == PortableTemporalEffectKind.ClockRevokeAdmission).Id,
            Assert.Single(revoked.Effect!.Dependencies));
    }

    [Fact]
    public void MissingExtraAndUnusedExternalInputsAreRejected()
    {
        var missing = new PortableTemporalCoordinator(replay: Array.Empty<PortableClockObservation>());
        missing.CreateContext(clock: true);
        Assert.Throws<InvalidDataException>(() => missing.RunRound(k => new(k, PortableTurnKind.SampleClock)));
        var extra = new PortableTemporalCoordinator(replay: new[] { new PortableClockObservation(1, 1, 7, 1) });
        extra.CreateContext();
        extra.RunRound(k => new(k, PortableTurnKind.Terminate));
        Assert.Throws<InvalidDataException>(() => extra.VerifyReplayComplete(extra.Capture()));
        var journal = new PortableTemporalCoordinator();
        journal.CreateContext();
        journal.QueueAdmission(new(1, 3, PortableAdmissionKind.TimerSample, 7));
        Assert.Throws<InvalidDataException>(() => journal.RunRound(k => new(k, PortableTurnKind.Terminate)));
        var noTimer = new PortableTemporalCoordinator();
        noTimer.CreateContext();
        Assert.Throws<UnauthorizedAccessException>(() => noTimer.RunRound(k => new(k, PortableTurnKind.SleepUntil, 7)));
    }

    [Fact]
    public void ThreeContextMixedEffectsReplayAndCancellation()
    {
        static PortableTemporalSnapshot Run(PortableTemporalCoordinator c, bool parallel)
        {
            var a = c.CreateContext(clock: true);
            var b = c.CreateContext();
            var d = c.CreateContext(clock: true);
            var x = c.CreateSharedLocation(0);
            var all = PortableSharedRights.Read | PortableSharedRights.Write | PortableSharedRights.Atomic;
            c.GrantShared(a, x, all); c.GrantShared(b, x, all); c.GrantChannel(b, a);
            c.RunRound(k => k.Context == a ? new(k, PortableTurnKind.Receive, Message: new(b))
                : k.Context == b ? new(k, PortableTurnKind.SharedWrite, Shared: new(x, 5))
                : new(k, PortableTurnKind.SampleClock), parallel);
            c.RunRound(k => k.Context == b ? new(k, PortableTurnKind.Send, Message: new(a, 9))
                : k.Context == d ? new(k, PortableTurnKind.Yield) : throw new InvalidOperationException(), parallel);
            c.RunRound(k => k.Context == b ? new(k, PortableTurnKind.SharedAdd, Shared: new(x, 6))
                : k.Context == d ? new(k, PortableTurnKind.Terminate) : throw new InvalidOperationException(), parallel);
            c.RunRound(k => k.Context == a ? new(k, PortableTurnKind.SharedRead, Shared: new(x))
                : new(k, PortableTurnKind.Terminate), parallel);
            c.RunRound(k => new(k, PortableTurnKind.SampleClock), parallel);
            c.RunRound(k => new(k, PortableTurnKind.Terminate), parallel);
            var received = c.Events.Single(e => e.Effect!.Kind == PortableTemporalEffectKind.MessageReceive);
            var read = c.Events.Single(e => e.Effect!.Kind == PortableTemporalEffectKind.SharedRead);
            Assert.Equal(3UL, received.Effect!.Round);
            Assert.Equal(9UL, received.Effect.Message!.Payload);
            Assert.Equal(11UL, read.Effect!.Shared!.After);
            Assert.Equal(2UL, read.Effect.Shared.AfterVersion);
            Assert.Contains(c.Events.Single(e => e.Effect!.Kind == PortableTemporalEffectKind.SharedAdd).Id, read.Effect.Dependencies);
            return c.Capture();
        }
        var expected = Run(new(source: () => 100), false);
        var replay = new PortableTemporalCoordinator(replay: expected.Observations);
        Run(replay, true);
        replay.VerifyReplayComplete(expected);
    }

    [Fact]
    public void NoncommutativeEffectsChangeOnlyWithExplicitContextOrder()
    {
        static ulong Run(bool reverse)
        {
            var c = new PortableTemporalCoordinator();
            var a = c.CreateContext(); var b = c.CreateContext();
            var x = c.CreateSharedLocation(0);
            var all = PortableSharedRights.Read | PortableSharedRights.Write | PortableSharedRights.Atomic;
            c.GrantShared(a, x, all); c.GrantShared(b, x, all);
            c.RunRound(k => (k.Context == a) != reverse
                ? new(k, PortableTurnKind.SharedAdd, Shared: new(x, 1))
                : new(k, PortableTurnKind.SharedWrite, Shared: new(x, 2)), parallel: true);
            return c.Events[^1].Effect!.Shared!.After;
        }
        Assert.Equal(2UL, Run(false));
        Assert.Equal(3UL, Run(true));
    }
}
