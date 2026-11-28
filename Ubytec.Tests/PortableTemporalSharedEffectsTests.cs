using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableTemporalSharedEffectsTests
{
    private const PortableSharedRights All = PortableSharedRights.Read | PortableSharedRights.Write | PortableSharedRights.Atomic;
    private static PortableTurnProposal Mem(PortableTurnKey k, PortableTurnKind kind, PortableSharedLocationId id,
        ulong operand = 0, ulong expected = 0) => new(k, kind, Shared: new(id, operand, expected));
    private static PortableTurnProposal Msg(PortableTurnKey k, PortableTurnKind kind, PortableRuntimeContextId peer,
        ulong payload = 0) => new(k, kind, Message: new(peer, payload));
    private static PortableTurnProposal End(PortableTurnKey k) => new(k, PortableTurnKind.Terminate);

    [Fact]
    public void VersionedReadsAndAtomicOperationsFollowCommitOrder()
    {
        static PortableTemporalSnapshot Run(PortableTemporalCoordinator c, bool parallel)
        {
            var a = c.CreateContext();
            var b = c.CreateContext();
            var d = c.CreateContext();
            var x = c.CreateSharedLocation(0);
            c.GrantShared(a, x, All); c.GrantShared(b, x, All);
            c.GrantShared(d, x, PortableSharedRights.Read);
            c.RunRound(k =>
            {
                if (k.Context == a && parallel) Thread.Sleep(10);
                return k.Context == a ? Mem(k, PortableTurnKind.SharedAdd, x, 1)
                    : k.Context == b ? Mem(k, PortableTurnKind.SharedCompareExchange, x, 10, 1)
                    : Mem(k, PortableTurnKind.SharedRead, x);
            }, parallel);
            var effects = c.Events.Where(e => e.Effect!.Shared is not null).ToArray();
            Assert.Equal(new ulong[] { 1, 10, 10 }, effects.Select(e => e.Effect!.Shared!.After));
            Assert.Equal(new ulong[] { 1, 2, 2 }, effects.Select(e => e.Effect!.Shared!.AfterVersion));
            Assert.Contains(effects[0].Id, effects[1].Effect!.Dependencies);
            Assert.Contains(effects[1].Id, effects[2].Effect!.Dependencies);
            c.RunRound(k => k.Context == a ? Mem(k, PortableTurnKind.SharedCompareExchange, x, 99, 0)
                : k.Context == b ? Mem(k, PortableTurnKind.SharedWrite, x, 7)
                : Mem(k, PortableTurnKind.SharedRead, x), parallel);
            effects = c.Events.Where(e => e.Effect!.Shared is not null).ToArray();
            Assert.False(effects[3].Effect!.Shared!.Written);
            Assert.Equal(2UL, effects[3].Effect!.Shared!.AfterVersion);
            Assert.Equal(effects[1].Id, Assert.Single(effects[4].Effect!.Dependencies));
            Assert.Equal(3UL, effects[4].Effect!.Shared!.AfterVersion);
            Assert.Equal(effects[4].Id, Assert.Single(effects[5].Effect!.Dependencies));
            c.RunRound(End, parallel);
            return c.Capture();
        }

        var serial = Run(new(), false);
        var concurrent = Run(new(), true);
        Assert.Equal(serial.Trace.ToArray(), concurrent.Trace.ToArray());
        Assert.Equal(serial.Resources.ToArray(), concurrent.Resources.ToArray());
        var replay = new PortableTemporalCoordinator(replay: serial.Observations);
        Run(replay, true);
        replay.VerifyReplayComplete(serial);
        Assert.Throws<InvalidDataException>(() => replay.VerifyReplayComplete(serial with { Resources = [] }));
    }

    [Theory]
    [InlineData(true)]
    [InlineData(false)]
    public void ReceiveOrderAndFifoAreIndependentOfWorkerTiming(bool receiverFirst)
    {
        var c = new PortableTemporalCoordinator();
        var first = c.CreateContext(); var second = c.CreateContext();
        var receiver = receiverFirst ? first : second;
        var sender = receiverFirst ? second : first;
        c.GrantChannel(sender, receiver);
        c.RunRound(k => k.Context == receiver ? Msg(k, PortableTurnKind.Receive, sender)
            : Msg(k, PortableTurnKind.Send, receiver, 11), parallel: true);
        Assert.Equal(receiverFirst ? 1 : 0, c.BlockedReceiveCount);
        Assert.Equal(receiverFirst ? 1 : 0, c.QueuedMessageCount);
        Assert.Equal(receiverFirst ? 0 : 1, c.Events.Count(e => e.Effect!.Kind == PortableTemporalEffectKind.MessageReceive));
        c.RunRound(k => k.Context == sender ? Msg(k, PortableTurnKind.Send, receiver, 22)
            : receiverFirst ? throw new InvalidOperationException("Retained receive must not invoke worker")
            : Msg(k, PortableTurnKind.Receive, sender), parallel: true);
        if (receiverFirst)
            c.RunRound(k => k.Context == receiver ? Msg(k, PortableTurnKind.Receive, sender) : End(k));
        var sends = c.Events.Where(e => e.Effect!.Kind == PortableTemporalEffectKind.MessageSend).ToArray();
        var receives = c.Events.Where(e => e.Effect!.Kind == PortableTemporalEffectKind.MessageReceive).ToArray();
        Assert.Equal(new ulong[] { 11, 22 }, receives.Select(e => e.Effect!.Message!.Payload));
        Assert.Equal(new ulong[] { receiverFirst ? 2UL : 1UL, receiverFirst ? 3UL : 2UL },
            receives.Select(e => e.Effect!.Round));
        for (int i = 0; i < 2; i++)
        {
            Assert.Contains(sends[i].Id, receives[i].Effect!.Dependencies);
            Assert.True(receives[i].LogicalTime > sends[i].LogicalTime);
        }
        Assert.Equal(0, c.QueuedMessageCount);
        Assert.Equal(0, c.BlockedReceiveCount);
        c.RunRound(End);
    }

    [Fact]
    public void EmptyReceiveConsumesNoEventAndCanBeCancelledAtJournalBoundary()
    {
        var c = new PortableTemporalCoordinator();
        var a = c.CreateContext(); var b = c.CreateContext();
        c.GrantChannel(b, a);
        c.RunRound(k => k.Context == a ? Msg(k, PortableTurnKind.Receive, b) : End(k));
        Assert.Equal(1, c.BlockedReceiveCount);
        Assert.DoesNotContain(c.Events, e => e.Id.Context == a);
        Assert.Equal(PortableRoundState.Quiescent, c.RunRound(_ => throw new InvalidOperationException()));
        c.QueueAdmission(new(1, 10, PortableAdmissionKind.CancelWait, a.Ordinal));
        Assert.Equal(PortableRoundState.Terminated, c.RunRound(End));
        Assert.Equal(10UL, c.Round);
        var cancel = c.Events.Single(e => e.Effect!.Kind == PortableTemporalEffectKind.ReceiveCancel);
        var admission = c.Events.Single(e => e.Effect!.Kind == PortableTemporalEffectKind.CancelAdmission);
        Assert.Contains(admission.Id, cancel.Effect!.Dependencies);
        Assert.Equal(1UL, cancel.Id.Sequence);
        Assert.Equal(0, c.BlockedReceiveCount);
    }

    [Fact]
    public void DeniedAndExhaustedEffectsDoNotCommitOrMutate()
    {
        var c = new PortableTemporalCoordinator();
        var a = c.CreateContext();
        var x = c.CreateSharedLocation(9);
        c.GrantShared(a, x, PortableSharedRights.Read);
        Assert.Throws<UnauthorizedAccessException>(() => c.RunRound(k => Mem(k, PortableTurnKind.SharedAdd, x, 1)));
        Assert.Single(c.Events);

        var foreign = new PortableTemporalCoordinator();
        foreign.CreateContext();
        Assert.Throws<UnauthorizedAccessException>(() => foreign.RunRound(k => Mem(k, PortableTurnKind.SharedRead, x)));
        Assert.Single(foreign.Events);

        var bounded = new PortableTemporalCoordinator(maxMessages: 1);
        var source = bounded.CreateContext(); var destination = bounded.CreateContext();
        bounded.GrantChannel(source, destination);
        bounded.RunRound(k => k.Context == source ? Msg(k, PortableTurnKind.Send, destination, 3)
            : new(k, PortableTurnKind.Yield));
        int count = bounded.Events.Count;
        Assert.Throws<InvalidOperationException>(() => bounded.RunRound(k => k.Context == source
            ? Msg(k, PortableTurnKind.Send, destination, 4) : new(k, PortableTurnKind.Yield)));
        Assert.Equal(count, bounded.Events.Count);
        Assert.Equal(1, bounded.QueuedMessageCount);

        var denied = new PortableTemporalCoordinator();
        var self = denied.CreateContext();
        Assert.Throws<UnauthorizedAccessException>(() => denied.RunRound(k => Msg(k, PortableTurnKind.Send, self, 1)));
        Assert.Single(denied.Events);
    }

    [Fact]
    public void ReplayPreservesUndeliveredQueuesAndBlockedRequests()
    {
        static void Run(PortableTemporalCoordinator c)
        {
            var a = c.CreateContext(); var b = c.CreateContext(); var d = c.CreateContext();
            c.GrantChannel(a, b); c.GrantChannel(d, b);
            c.RunRound(k => k.Context == a ? Msg(k, PortableTurnKind.Send, b, 42)
                : k.Context == b ? Msg(k, PortableTurnKind.Receive, d) : End(k));
            c.RunRound(k => k.Context == a ? End(k) : throw new InvalidOperationException("Blocked request was lost"));
            Assert.Equal(PortableRoundState.Quiescent, c.RunRound(_ => throw new InvalidOperationException()));
            Assert.Equal(1, c.QueuedMessageCount);
            Assert.Equal(1, c.BlockedReceiveCount);
        }
        var live = new PortableTemporalCoordinator();
        Run(live);
        var expected = live.Capture();
        var replay = new PortableTemporalCoordinator(replay: expected.Observations);
        Run(replay);
        replay.VerifyReplayComplete(expected);
    }
}
