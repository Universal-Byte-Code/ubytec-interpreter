namespace Ubytec.Language.Portable;

public enum PortableTemporalEffectKind { ClockSample, TimerSample, TimerRegister, TimerExpire, TimerCancel, ContextCreated, ContextTerminated, ContextCancelled, CancelAdmission, Yield, SharedRead, SharedWrite, SharedAdd, SharedCompareExchange, MessageSend, MessageReceive, ReceiveCancel, ClockRevokeAdmission, ClockGrantRevoked }
public enum PortableEventDomain { Diagnostic, Semantic }

/// <summary>Coordinator-owned effect; unlike an instruction event, it need not have an activation.</summary>
public sealed record PortableTemporalEffect(PortableRuntimeEventId Id, PortableTemporalEffectKind Kind,
    ulong Round, ulong Value, IReadOnlyList<PortableRuntimeEventId> Dependencies, ulong Auxiliary = 0,
    PortableSharedEffectData? Shared = null, PortableMessageEffectData? Message = null);

public sealed record PortableScalarEventData(ulong Round, PortableScalarBoundaryKind Kind,
    ulong Fuel, PortableInstructionOccurrence? Occurrence, ulong? Result,
    uint? TargetFunction = null, string? FaultReason = null);

/// <summary>One committed runtime event. Sequence is the coordinator order, not host arrival time.</summary>
public sealed record PortablePublishedEvent(
    ulong CommitSequence, ulong LogicalTime, PortableRuntimeEventId Id,
    PortableLifecycleEvent? Lifecycle, PortableRuntimeEvent? Instruction, PortableRuntimeFault? Fault,
    PortableRuntimeEventId? Dependency, PortableTemporalEffect? Effect = null,
    PortableEventDomain Domain = PortableEventDomain.Diagnostic, PortableScalarEventData? Scalar = null);

/// <summary>
/// Serial reference publication ledger. Caller supplies an already admitted order; this class is
/// not a deterministic scheduler and must never arbitrate parallel requests by arrival time.
/// Logical time tracks local order and an explicitly named, previously committed dependency.
/// </summary>
public sealed class PortableEventPublication(Guid session, int maxEvents = 100_000,
    PortableEventDomain domain = PortableEventDomain.Diagnostic)
{
    private readonly Dictionary<PortableRuntimeContextId, PortablePublishedEvent> _last = new();
    private readonly Dictionary<PortableRuntimeEventId, PortablePublishedEvent> _committed = new();
    private readonly List<PortablePublishedEvent> _events = new();
    private readonly Dictionary<PortableRuntimeContextId, PortableRuntimeEventId> _creation = new();
    public PortableEventDomain Domain => domain;

    internal void RegisterCreation(PortableRuntimeContextId context, PortableRuntimeEventId cause)
    {
        if (context.Session != session || !_committed.ContainsKey(cause) || _last.ContainsKey(context))
            throw new InvalidDataException("Invalid creation dependency.");
        _creation.Add(context, cause);
    }

    public IReadOnlyList<PortablePublishedEvent> Events => _events.AsReadOnly();

    public PortablePublishedEvent Publish(PortableLifecycleEvent value, PortableRuntimeEventId? dependency = null) =>
        Commit(value.Id, value, null, null, dependency);
    public PortablePublishedEvent Publish(PortableRuntimeEvent value, PortableRuntimeEventId? dependency = null) =>
        Commit(value.Id, null, value, null, dependency);
    public PortablePublishedEvent Publish(PortableRuntimeFault value, PortableRuntimeEventId? dependency = null) =>
        Commit(value.Id, null, null, value, dependency);

    internal PortablePublishedEvent PublishScalar(PortableLifecycleEvent value, PortableScalarEventData data) =>
        Commit(value.Id, value, null, null, null, scalar: data);
    internal PortablePublishedEvent PublishScalar(PortableRuntimeEvent value, PortableScalarEventData data) =>
        Commit(value.Id, null, value, null, null, scalar: data);

    internal PortablePublishedEvent Publish(PortableTemporalEffect value) =>
        Commit(value.Id, null, null, null, null, value);

    internal void RequireCapacity(int count = 1)
    {
        if (count < 0 || maxEvents <= 0 || count > maxEvents - _events.Count)
            throw new InvalidOperationException("Publication resource limit reached.");
    }

    private PortablePublishedEvent Commit(PortableRuntimeEventId id, PortableLifecycleEvent? lifecycle,
        PortableRuntimeEvent? instruction, PortableRuntimeFault? fault, PortableRuntimeEventId? dependency,
        PortableTemporalEffect? effect = null, PortableScalarEventData? scalar = null)
    {
        RequireCapacity();
        if (domain == PortableEventDomain.Semantic && (fault is not null || effect is null && scalar is null))
            throw new InvalidDataException("Diagnostic observations require explicit semantic mediation.");
        if (domain == PortableEventDomain.Diagnostic && (effect is not null || scalar is not null))
            throw new InvalidDataException("Semantic events cannot enter a diagnostic ledger.");
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
        if (last is null && _creation.TryGetValue(id.Context, out var creation))
        {
            if (effect is not null)
                effect = effect with { Dependencies = Array.AsReadOnly(effect.Dependencies.Append(creation).Distinct().ToArray()) };
            else if (dependency is null || dependency == creation) dependency = creation;
            else throw new InvalidDataException("First lifecycle event must include creation dependency.");
        }
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
            id, lifecycle, instruction, fault, dependency, effect, domain, scalar);
        _committed.Add(id, entry);
        _last[id.Context] = entry;
        _events.Add(entry);
        return entry;
    }
}
