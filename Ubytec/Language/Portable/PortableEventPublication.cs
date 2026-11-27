namespace Ubytec.Language.Portable;

public enum PortableTemporalEffectKind { ClockSample, TimerSample, TimerRegister, TimerExpire, TimerCancel }

/// <summary>Coordinator-owned effect; unlike an instruction event, it need not have an activation.</summary>
public sealed record PortableTemporalEffect(PortableRuntimeEventId Id, PortableTemporalEffectKind Kind,
    ulong Round, ulong Value, IReadOnlyList<PortableRuntimeEventId> Dependencies);

/// <summary>One committed runtime event. Sequence is the coordinator order, not host arrival time.</summary>
public sealed record PortablePublishedEvent(
    ulong CommitSequence, ulong LogicalTime, PortableRuntimeEventId Id,
    PortableLifecycleEvent? Lifecycle, PortableRuntimeEvent? Instruction, PortableRuntimeFault? Fault,
    PortableRuntimeEventId? Dependency, PortableTemporalEffect? Effect = null);

/// <summary>
/// Serial reference publication ledger. Caller supplies an already admitted order; this class is
/// not a deterministic scheduler and must never arbitrate parallel requests by arrival time.
/// Logical time tracks local order and an explicitly named, previously committed dependency.
/// </summary>
public sealed class PortableEventPublication(Guid session, int maxEvents = 100_000)
{
    private readonly Dictionary<PortableRuntimeContextId, PortablePublishedEvent> _last = new();
    private readonly Dictionary<PortableRuntimeEventId, PortablePublishedEvent> _committed = new();
    private readonly List<PortablePublishedEvent> _events = new();

    public IReadOnlyList<PortablePublishedEvent> Events => _events.AsReadOnly();

    public PortablePublishedEvent Publish(PortableLifecycleEvent value, PortableRuntimeEventId? dependency = null) =>
        Commit(value.Id, value, null, null, dependency);
    public PortablePublishedEvent Publish(PortableRuntimeEvent value, PortableRuntimeEventId? dependency = null) =>
        Commit(value.Id, null, value, null, dependency);
    public PortablePublishedEvent Publish(PortableRuntimeFault value, PortableRuntimeEventId? dependency = null) =>
        Commit(value.Id, null, null, value, dependency);

    internal PortablePublishedEvent Publish(PortableTemporalEffect value) =>
        Commit(value.Id, null, null, null, null, value);

    internal void RequireCapacity(int count = 1)
    {
        if (count < 0 || maxEvents <= 0 || count > maxEvents - _events.Count)
            throw new InvalidOperationException("Publication resource limit reached.");
    }

    private PortablePublishedEvent Commit(PortableRuntimeEventId id, PortableLifecycleEvent? lifecycle,
        PortableRuntimeEvent? instruction, PortableRuntimeFault? fault, PortableRuntimeEventId? dependency,
        PortableTemporalEffect? effect = null)
    {
        RequireCapacity();
        if (id.Context.Session != session || (id.Context.Ordinal == 0 && effect is null))
            throw new InvalidDataException("Event belongs to another session or invalid context.");
        if (effect is null)
        {
            var activation = lifecycle?.Activation ?? instruction?.Activation ?? fault!.Value.Activation;
            var instance = lifecycle?.Instance ?? instruction?.Instance ?? fault!.Value.Instance;
            if (activation.Context != id.Context || activation.Ordinal == 0 ||
                instance.Session != session || instance.Ordinal == 0)
                throw new InvalidDataException("Event identity domains disagree.");
        }
        _last.TryGetValue(id.Context, out var last);
        if (id.Sequence != checked((last?.Id.Sequence ?? 0) + 1))
            throw new InvalidDataException("Event sequence is duplicated or has a gap.");
        ulong logical = last?.LogicalTime ?? 0;
        if (dependency is { } predecessor)
        {
            if (!_committed.TryGetValue(predecessor, out var cause))
                throw new InvalidDataException("Dependency has not committed.");
            logical = Math.Max(logical, cause.LogicalTime);
        }
        if (effect is not null)
            foreach (var predecessorId in effect.Dependencies)
            {
                if (!_committed.TryGetValue(predecessorId, out var cause))
                    throw new InvalidDataException("Effect dependency has not committed.");
                logical = Math.Max(logical, cause.LogicalTime);
            }
        var entry = new PortablePublishedEvent((ulong)_events.Count + 1, checked(logical + 1),
            id, lifecycle, instruction, fault, dependency, effect);
        _committed.Add(id, entry);
        _last[id.Context] = entry;
        _events.Add(entry);
        return entry;
    }
}
