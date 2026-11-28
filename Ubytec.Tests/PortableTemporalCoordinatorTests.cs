using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableTemporalCoordinatorTests
{
    private static PortableTurnProposal Turn(PortableTurnKey key, PortableTurnKind kind, ulong value = 0) =>
        new(key, kind, value);

    [Fact]
    public void JournalTimersCreationAndClockReplayShareOneSemanticLedger()
    {
        var live = new PortableTemporalCoordinator(source: () => 10);
        Run(live);
        var snapshot = live.Capture();
        var replay = new PortableTemporalCoordinator(replay: snapshot.Observations, clockPolicy: live.ClockDomain);
        Run(replay);
        replay.VerifyReplayComplete(snapshot);
        Assert.NotEqual(live.Session, replay.Session);
        Assert.Throws<InvalidDataException>(() => replay.VerifyReplayComplete(snapshot with { Round = 999 }));
        Assert.Throws<InvalidDataException>(() => replay.VerifyReplayComplete(snapshot with { Trace = snapshot.Trace.Skip(1).ToArray() }));
        Assert.Throws<InvalidDataException>(() => replay.VerifyReplayComplete(snapshot with { Contexts = [] }));
        Assert.Throws<InvalidDataException>(() => replay.VerifyReplayComplete(snapshot with { Journal = [] }));
        Assert.All(live.Events, e => Assert.Equal(PortableEventDomain.Semantic, e.Domain));

        static void Run(PortableTemporalCoordinator c)
        {
            var a = c.CreateContext(clock: true, timer: true);
            var b = c.CreateContext(timer: true);
            c.QueueAdmission(new(1, 5, PortableAdmissionKind.TimerSample, 9));
            c.QueueAdmission(new(2, 7, PortableAdmissionKind.TimerSample, 10));
            c.RunRound(k => Turn(k, PortableTurnKind.SleepUntil, 10));
            Assert.Equal(2, c.SuspendedCount);
            Assert.Equal(c.Events[0].Id, Assert.Single(c.Events[2].Effect!.Dependencies));
            Assert.Equal(c.Events[1].Id, Assert.Single(c.Events[3].Effect!.Dependencies));
            c.RunRound(_ => throw new InvalidOperationException("No runnable context"));
            Assert.Equal(5UL, c.Round);
            Assert.Equal(2, c.SuspendedCount);
            c.RunRound(k => Turn(k, k.Context == a ? PortableTurnKind.SampleClock : PortableTurnKind.Terminate));
            Assert.Equal(7UL, c.Round);
            Assert.Equal(0, c.SuspendedCount);
            var expiry = c.Events.Where(e => e.Effect!.Kind == PortableTemporalEffectKind.TimerExpire).ToArray();
            Assert.Equal(new ulong[] { a.Ordinal, b.Ordinal }, expiry.Select(e => e.Id.Context.Ordinal));
            Assert.Equal(c.Events[2].Id, expiry[0].Effect!.Dependencies[0]);
            Assert.Equal(c.Events[5].Id, expiry[0].Effect!.Dependencies[1]);
            Assert.True(expiry[0].LogicalTime > c.Events[5].LogicalTime);
            Assert.Equal(new ulong[] { 1, 2, 3 }, c.Observations.Select(o => o.RequestOrdinal));
            Assert.Equal(new ulong[] { 9, 10, 10 }, c.Observations.Select(o => o.Nanoseconds));
            Assert.Equal(1UL, PortableTemporalCoordinator.Elapsed(c.Instant(1), c.Instant(3)));
            Assert.Equal(PortableRoundState.Terminated, c.RunRound(k => Turn(k, PortableTurnKind.Terminate)));
            Assert.Equal(0, c.LiveCount);
            Assert.Equal(Enumerable.Range(1, c.Events.Count).Select(x => (ulong)x), c.Events.Select(e => e.CommitSequence));
        }
    }

    [Fact]
    public void ParallelProposalsCommitInOrdinalOrderAndRejectWrongKeys()
    {
        static PortableTemporalSnapshot Run(bool parallel)
        {
            var c = new PortableTemporalCoordinator(source: () => 17);
            c.CreateContext(clock: true);
            c.CreateContext(clock: true);
            c.RunRound(k =>
            {
                if (k.Context.Ordinal == 1) Thread.Sleep(10);
                return Turn(k, PortableTurnKind.SampleClock);
            }, parallel);
            c.RunRound(k => Turn(k, PortableTurnKind.Terminate), parallel);
            Assert.Equal(new ulong[] { 1, 2 }, c.Events.Where(e => e.Effect!.Kind == PortableTemporalEffectKind.ClockSample)
                .Select(e => e.Id.Context.Ordinal));
            return c.Capture();
        }
        var serial = Run(false);
        var concurrent = Run(true);
        Assert.Equal(serial.Trace.ToArray(), concurrent.Trace.ToArray());
        Assert.Equal(serial.Contexts.ToArray(), concurrent.Contexts.ToArray());

        var wrong = new PortableTemporalCoordinator();
        wrong.CreateContext();
        Assert.Throws<InvalidDataException>(() => wrong.RunRound(k => Turn(k with { Round = 2 }, PortableTurnKind.Yield)));
        Assert.Single(wrong.Events);
        Assert.Throws<InvalidOperationException>(() => wrong.RunRound(k => Turn(k, PortableTurnKind.Yield)));

        var injected = new PortableTemporalCoordinator();
        injected.CreateContext();
        Assert.Throws<InvalidOperationException>(() => injected.RunRound(k =>
        {
            injected.CreateContext();
            return Turn(k, PortableTurnKind.Yield);
        }));
        Assert.Single(injected.Events);
    }

    [Fact]
    public void SpawnStartsNextRoundAndFirstEventDependsOnCreation()
    {
        var c = new PortableTemporalCoordinator();
        var root = c.CreateContext(timer: true);
        c.RunRound(k => new(k, PortableTurnKind.Spawn, TimerGrant: true));
        Assert.Equal(2, c.LiveCount);
        var spawn = c.Events[^1];
        Assert.Equal(root, spawn.Id.Context);
        Assert.Equal(2UL, spawn.Effect!.Value);
        c.RunRound(k => Turn(k, PortableTurnKind.Terminate));
        Assert.Equal(PortableRoundState.Terminated, c.RunRound(k => Turn(k, PortableTurnKind.Yield)));
        var child = c.Events.Single(e => e.Id.Context.Ordinal == 2);
        Assert.Equal(2UL, child.Effect!.Round);
        Assert.Equal(spawn.Id, Assert.Single(child.Effect.Dependencies));

        var denied = new PortableTemporalCoordinator();
        denied.CreateContext();
        Assert.Throws<UnauthorizedAccessException>(() => denied.RunRound(k => new(k, PortableTurnKind.Spawn, ClockGrant: true)));
        Assert.Single(denied.Events);
    }

    [Theory]
    [InlineData(PortableAdmissionKind.CancelWait, PortableTemporalEffectKind.TimerCancel)]
    [InlineData(PortableAdmissionKind.CancelContext, PortableTemporalEffectKind.ContextCancelled)]
    public void CancellationIsExplicitAndDistinguishesWaitFromContext(PortableAdmissionKind kind, PortableTemporalEffectKind effect)
    {
        var c = new PortableTemporalCoordinator();
        var a = c.CreateContext(timer: true);
        c.RunRound(k => Turn(k, PortableTurnKind.SleepUntil, 100));
        Assert.Equal(PortableRoundState.Quiescent, c.RunRound(_ => throw new InvalidOperationException()));
        c.QueueAdmission(new(1, 4, kind, a.Ordinal));
        c.RunRound(k => Turn(k, PortableTurnKind.Terminate));
        var cancellation = c.Events.Single(e => e.Effect!.Kind == effect);
        Assert.Equal(c.Events[1].Id, cancellation.Effect!.Dependencies[0]);
        Assert.Equal(PortableTemporalEffectKind.CancelAdmission, c.Events[2].Effect!.Kind);
        Assert.Equal(c.Events[2].Id, cancellation.Effect.Dependencies[1]);
        Assert.Equal(0, c.LiveCount);
        Assert.Equal(0, c.SuspendedCount);
        Assert.DoesNotContain(c.Events, e => e.Effect!.Kind == PortableTemporalEffectKind.TimerExpire);
    }

    [Fact]
    public void BatchLimitPreflightsBeforePublishingSampleOrExpiry()
    {
        var c = new PortableTemporalCoordinator(maxEvents: 6);
        c.CreateContext(timer: true);
        c.CreateContext(timer: true);
        c.RunRound(k => Turn(k, PortableTurnKind.SleepUntil, 5));
        c.QueueAdmission(new(1, 2, PortableAdmissionKind.TimerSample, 5));
        Assert.Throws<InvalidOperationException>(() => c.RunRound(k => Turn(k, PortableTurnKind.Terminate)));
        Assert.Equal(4, c.Events.Count);
        Assert.Equal(2, c.SuspendedCount);
        Assert.Empty(c.Observations);
        Assert.Empty(c.Journal);
        Assert.Throws<InvalidOperationException>(() => c.QueueAdmission(new(2, 3, PortableAdmissionKind.TimerSample, 6)));
    }

    [Fact]
    public void ReplayRejectsWrongRequestOrdinalRegressionAndMissingInputs()
    {
        var c = new PortableTemporalCoordinator(replay: new[] { new PortableClockObservation(1, 1, 0, 2) });
        c.CreateContext(clock: true);
        Assert.Throws<InvalidDataException>(() => c.RunRound(k => Turn(k, PortableTurnKind.SampleClock)));
        Assert.Single(c.Events);
        var samples = new Queue<ulong>(new ulong[] { 10, 9 });
        var live = new PortableTemporalCoordinator(source: () => samples.Dequeue());
        live.CreateContext(clock: true);
        live.RunRound(k => Turn(k, PortableTurnKind.SampleClock));
        Assert.Throws<InvalidDataException>(() => live.RunRound(k => Turn(k, PortableTurnKind.SampleClock)));
        Assert.Equal(2, live.Events.Count);
        var denied = new PortableTemporalCoordinator(source: () => throw new InvalidOperationException("Must not sample"));
        denied.CreateContext();
        Assert.Throws<UnauthorizedAccessException>(() => denied.RunRound(k => Turn(k, PortableTurnKind.SampleClock)));
    }

    [Fact]
    public void FixedStepsRetainBacklogAndClockDomainsCannotMix()
    {
        Assert.Equal(new PortableFixedSteps(5, 25), PortableFixedSteps.Advance(0, 105, 16, 5));
        Assert.Equal(new PortableFixedSteps(1, 9), PortableFixedSteps.Advance(25, 0, 16, 5));
        Assert.Equal(new PortableFixedSteps(0, 105), PortableFixedSteps.Advance(0, 105, 16, 0));
        Assert.Throws<OverflowException>(() => PortableFixedSteps.Advance(ulong.MaxValue, 1, 1, 1));
        Assert.Throws<ArgumentOutOfRangeException>(() => PortableFixedSteps.Advance(0, 0, 0, 0));
        Assert.Throws<InvalidDataException>(() => PortableTemporalCoordinator.Elapsed(new(Guid.NewGuid(), 0), new(Guid.NewGuid(), 1)));
    }
}
