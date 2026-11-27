using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableTemporalCoordinatorTests
{
    [Fact]
    public void ManagedTimerAndClockShareIdentityAndReplay()
    {
        var values = new Queue<ulong>(new ulong[] { 9, 10, 10 });
        var runtime = new PortableTemporalCoordinator(source: () => values.Dequeue());
        Run(runtime);
        Assert.Empty(values);
        Assert.Equal(new ulong[] { 1, 2, 3, 4, 5, 6 }, runtime.Events.Select(e => e.CommitSequence));
        Assert.Equal(new[] { PortableTemporalEffectKind.TimerRegister, PortableTemporalEffectKind.TimerRegister,
            PortableTemporalEffectKind.TimerSample, PortableTemporalEffectKind.TimerSample,
            PortableTemporalEffectKind.TimerExpire, PortableTemporalEffectKind.TimerExpire },
            runtime.Events.Take(6).Select(e => e.Effect!.Kind));
        var recorded = runtime.Observations;
        var replay = new PortableTemporalCoordinator(replay: recorded);
        Run(replay);
        replay.VerifyReplayComplete();
        Assert.Equal(Normalize(runtime), Normalize(replay));
        Assert.NotEqual(runtime.Session, replay.Session);

        static void Run(PortableTemporalCoordinator c)
        {
            var a = c.CreateContext(clock: true, timer: true);
            var b = c.CreateContext(timer: true);
            c.RunRound(id => id.Ordinal, (id, _) => c.SleepUntil(id, 10));
            Assert.Equal(2, c.SuspendedCount);
            c.AdmitTimerSample();
            Assert.Equal(2, c.SuspendedCount);
            c.AdmitTimerSample();
            Assert.Equal(0, c.SuspendedCount);
            Assert.Equal(1UL, c.Events[0].Id.Sequence);
            Assert.Equal(2UL, c.Events[4].Id.Sequence);
            Assert.Equal(c.Events[0].Id, c.Events[4].Effect!.Dependencies[0]);
            Assert.Equal(c.Events[3].Id, c.Events[4].Effect!.Dependencies[1]);
            Assert.Equal(c.Events[1].Id, c.Events[5].Effect!.Dependencies[0]);
            Assert.Equal(c.Events[3].Id, c.Events[5].Effect!.Dependencies[1]);
            Assert.True(c.Events[4].LogicalTime > c.Events[3].LogicalTime);
            c.RunRound(id => id.Ordinal, (id, _) =>
            {
                if (id == a) Assert.Equal(10UL, c.Sample(id));
                c.Retire(id);
            });
            Assert.Equal(0, c.LiveCount);
        }
    }

    [Fact]
    public void ParallelPreparationAndSerialCommitHaveStableOrder()
    {
        var c = new PortableTemporalCoordinator(source: () => 17);
        var a = c.CreateContext(clock: true);
        var b = c.CreateContext(clock: true);
        var order = new List<ulong>();
        c.RunRound(id =>
        {
            if (id == a) Thread.Sleep(10);
            return id.Ordinal * 2;
        }, (id, result) =>
        {
            Assert.Equal(id.Ordinal * 2, result);
            order.Add(id.Ordinal);
            c.Sample(id);
            c.Retire(id);
        }, parallel: true);
        Assert.Equal(new ulong[] { 1, 2 }, order);
        Assert.Equal(new ulong[] { 1, 2 }, c.Events.Select(e => e.Id.Context.Ordinal));
        Assert.Equal(new ulong[] { 1, 1 }, c.Events.Select(e => e.LogicalTime));
    }

    [Fact]
    public void NoImplicitWakeOrClockAuthorityAndCancellationIsRecorded()
    {
        var c = new PortableTemporalCoordinator();
        var a = c.CreateContext(timer: true);
        c.RunRound(id => id, (id, _) => c.SleepUntil(id, 100));
        Assert.Throws<InvalidOperationException>(() => c.RunRound(id => id, (_, _) => { }));
        c.CancelTimer(a);
        Assert.Equal(PortableTemporalEffectKind.TimerCancel, c.Events[^1].Effect!.Kind);
        Assert.Equal(c.Events[0].Id, Assert.Single(c.Events[^1].Effect!.Dependencies));
        c.RunRound(id => id, (id, _) => c.Retire(id));
        var denied = new PortableTemporalCoordinator(source: () => 0);
        denied.CreateContext();
        Assert.Throws<UnauthorizedAccessException>(() => denied.RunRound(id => id, (id, _) => denied.Sample(id)));
        Assert.Throws<InvalidOperationException>(() => denied.CreateContext());
    }

    [Fact]
    public void ReplayRequiresExactRequestKeyAndRejectsRegression()
    {
        var c = new PortableTemporalCoordinator(replay: new[] { new PortableClockObservation(2, 1, 0) });
        c.CreateContext(clock: true);
        Assert.Throws<InvalidDataException>(() => c.RunRound(id => id, (id, _) => c.Sample(id)));
        var samples = new Queue<ulong>(new ulong[] { 10, 9 });
        var live = new PortableTemporalCoordinator(source: () => samples.Dequeue());
        live.CreateContext(clock: true);
        live.RunRound(id => id, (id, _) => live.Sample(id));
        Assert.Throws<InvalidDataException>(() => live.RunRound(id => id, (id, _) => live.Sample(id)));
        Assert.Single(live.Events);
    }

    private static object[] Normalize(PortableTemporalCoordinator c) => c.Events.Select(e => (object)
        (e.CommitSequence, e.LogicalTime, e.Id.Context.Ordinal, e.Id.Sequence,
         e.Effect!.Kind, e.Effect.Round, e.Effect.Value,
         string.Join(",", e.Effect.Dependencies.Select(d => $"{d.Context.Ordinal}:{d.Sequence}")))).ToArray();
}
