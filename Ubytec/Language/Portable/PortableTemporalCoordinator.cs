using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Text.Json;

namespace Ubytec.Language.Portable;

public readonly record struct PortableTurnKey(ulong Round, PortableRuntimeContextId Context);
public enum PortableTurnKind { Yield, SampleClock, SleepUntil, Spawn, Terminate, SharedRead, SharedWrite, SharedAdd, SharedCompareExchange, Send, Receive }
public readonly record struct PortableTurnProposal(PortableTurnKey Key, PortableTurnKind Kind,
    ulong Value = 0, bool ClockGrant = false, bool TimerGrant = false,
    PortableSharedRequest? Shared = null, PortableMessageRequest? Message = null);
public enum PortableRoundState { Progressed, Quiescent, Terminated }
public enum PortableAdmissionKind { TimerSample, CancelWait, CancelContext }
public readonly record struct PortableJournalEntry(ulong Ordinal, ulong Round, PortableAdmissionKind Kind, ulong Value);
public readonly record struct PortableClockObservation(ulong Round, ulong ContextOrdinal, ulong Nanoseconds, ulong RequestOrdinal);
public readonly record struct PortableClockInstant(Guid Domain, ulong Nanoseconds);
public sealed record PortableClockDomain(Guid Id, string Source, ulong? ResolutionNanoseconds, bool? ExcludesSuspend);
public readonly record struct PortableFixedSteps(ulong Steps, ulong Remainder)
{
    public static PortableFixedSteps Advance(ulong accumulator, ulong elapsed, ulong duration, ulong cap)
    {
        if (duration == 0) throw new ArgumentOutOfRangeException(nameof(duration));
        ulong total = checked(accumulator + elapsed);
        ulong steps = Math.Min(total / duration, cap);
        return new(steps, total - steps * duration);
    }
}

public sealed record PortableTemporalSnapshot(ulong Round, IReadOnlyList<string> Trace,
    IReadOnlyList<string> Contexts, IReadOnlyList<PortableJournalEntry> Journal,
    IReadOnlyList<PortableClockObservation> Observations, IReadOnlyList<PortableJournalEntry> Pending,
    string ClockPolicy, IReadOnlyList<string> Resources);

/// <summary>Managed semantic coordinator; trusted host calls are serialized. Workers return values,
/// never authority. One primary turn proposal; synthetic delivery is coordinator-owned.
/// Finite event/context bounds also bound all event counters and Lamport clocks below u64 exhaustion.
/// This is not a native protection boundary or the complete temporal profile.</summary>
public sealed partial class PortableTemporalCoordinator
{
    private sealed record Timer(ulong Deadline, PortablePublishedEvent Registration);
    private sealed class Context(bool clock, bool timer)
    {
        internal bool Clock { get; } = clock;
        internal bool Timer { get; } = timer;
        internal string Status = "Live";
    }

    private readonly SortedDictionary<ulong, Context> _contexts = new();
    private readonly SortedSet<ulong> _live = new();
    private readonly Dictionary<ulong, Timer> _timers = new();
    private readonly Func<ulong>? _source;
    private readonly Queue<PortableClockObservation>? _replay;
    private readonly List<PortableClockObservation> _observations = new();
    private readonly List<PortableJournalEntry> _journal = new();
    private readonly Queue<PortableJournalEntry> _pending = new();
    private readonly int _maxContexts, _maxEvents;
    private readonly int _owner = Environment.CurrentManagedThreadId;
    private ulong? _lastSample;
    private bool _inRound, _failed, _started;

    internal PortableRuntimeIdentity Identity { get; } = new();
    internal PortableEventPublication Publication { get; }
    public Guid Session => Identity.Session;
    public PortableClockDomain ClockDomain { get; }
    public ulong Round { get; private set; }
    public IReadOnlyList<PortablePublishedEvent> Events => Publication.Events;
    public IReadOnlyList<PortableClockObservation> Observations => _observations.AsReadOnly();
    public IReadOnlyList<PortableJournalEntry> Journal => _journal.AsReadOnly();
    public int LiveCount => _live.Count;
    public int SuspendedCount => _timers.Count;

    public PortableTemporalCoordinator(int maxEvents = 100_000, int maxContexts = 128,
        Func<ulong>? source = null, IEnumerable<PortableClockObservation>? replay = null,
        PortableClockDomain? clockPolicy = null, int maxLocations = 1024,
        int maxChannels = 1024, int maxMessages = 4096)
    {
        if (maxEvents <= 0 || maxContexts <= 0 || maxLocations <= 0 || maxChannels <= 0 || maxMessages <= 0 ||
            (source is not null && replay is not null))
            throw new ArgumentException("Invalid coordinator configuration.");
        _maxContexts = maxContexts;
        _maxEvents = maxEvents;
        _maxLocations = maxLocations;
        _maxChannels = maxChannels;
        _maxMessages = maxMessages;
        _source = source;
        if (replay is not null)
        {
            var bounded = replay.Take(maxEvents == int.MaxValue ? maxEvents : maxEvents + 1).ToArray();
            if (bounded.Length > maxEvents) throw new InvalidDataException("Replay observation limit.");
            _replay = new(bounded);
        }
        ClockDomain = clockPolicy is null
            ? new(Session, "explicit-monotonic-ns", null, null)
            : clockPolicy with { Id = Session };
        Publication = new PortableEventPublication(Session, maxEvents, PortableEventDomain.Semantic);
    }

    [StructLayout(LayoutKind.Sequential)]
    private struct Timespec { public long Seconds; public long Nanoseconds; }

    [DllImport("libc", EntryPoint = "clock_getres", SetLastError = true)]
    private static extern int ClockGetResolution(int clockId, out Timespec resolution);

    public static PortableTemporalCoordinator LiveLinux(int maxEvents = 100_000, int maxContexts = 128)
    {
        if (!OperatingSystem.IsLinux() || IntPtr.Size != 8)
            throw new PlatformNotSupportedException("64-bit Linux monotonic domain required.");
        if (ClockGetResolution(1, out var resolution) != 0 || resolution.Seconds < 0 ||
            resolution.Nanoseconds is < 0 or >= 1_000_000_000)
            throw new InvalidOperationException("CLOCK_MONOTONIC resolution unavailable.");
        ulong ns = checked((ulong)resolution.Seconds * 1_000_000_000UL + (ulong)resolution.Nanoseconds);
        if (ns == 0) throw new InvalidOperationException("Invalid clock resolution.");
        long origin = Stopwatch.GetTimestamp();
        // Tick conversion granularity, not measured host clock precision.
        return new(maxEvents, maxContexts, () =>
        {
            long ticks = checked(Stopwatch.GetTimestamp() - origin);
            if (ticks < 0) throw new InvalidDataException("Host clock regressed.");
            return checked((ulong)((UInt128)(ulong)ticks * 1_000_000_000 / (ulong)Stopwatch.Frequency));
        }, clockPolicy: new(Guid.Empty, $"linux-stopwatch-{Stopwatch.Frequency}-ticks-per-second", ns, true));
    }

    public PortableClockInstant Instant(ulong requestOrdinal)
    {
        RequireBoundary();
        if (requestOrdinal == 0 || requestOrdinal > (ulong)_observations.Count)
            throw new InvalidDataException("Unknown observation in this session.");
        return new(Session, _observations[(int)requestOrdinal - 1].Nanoseconds);
    }

    public static ulong Elapsed(PortableClockInstant first, PortableClockInstant second)
    {
        if (first.Domain == Guid.Empty || first.Domain != second.Domain || second.Nanoseconds < first.Nanoseconds)
            throw new InvalidDataException("Incompatible clock instants.");
        return second.Nanoseconds - first.Nanoseconds;
    }

    private PortableRuntimeContextId Id(ulong ordinal) => new(Session, ordinal);
    private void RequireBoundary()
    {
        if (Environment.CurrentManagedThreadId != _owner || _inRound)
            throw new InvalidOperationException("Only the coordinator owner between rounds may admit work.");
        if (_failed) throw new InvalidOperationException("Coordinator aborted.");
    }

    private PortablePublishedEvent Publish(ulong context, PortableTemporalEffectKind kind, ulong value,
        ulong auxiliary = 0, params PortableRuntimeEventId[] dependencies)
    {
        Publication.RequireCapacity();
        return Publication.Publish(new PortableTemporalEffect(Identity.AllocateEffect(Id(context)), kind,
            Round, value, Array.AsReadOnly(dependencies), auxiliary));
    }

    private PortableRuntimeContextId Create(ulong parent, bool clock, bool timer)
    {
        if (_contexts.Count >= _maxContexts) throw new InvalidOperationException("Session context limit.");
        Publication.RequireCapacity();
        var id = Identity.CreateContext();
        var created = Publish(parent, PortableTemporalEffectKind.ContextCreated, id.Ordinal,
            (clock ? 1UL : 0UL) | (timer ? 2UL : 0UL));
        Publication.RegisterCreation(id, created.Id);
        _contexts.Add(id.Ordinal, new(clock, timer));
        _live.Add(id.Ordinal);
        return id;
    }

    public PortableRuntimeContextId CreateContext(bool clock = false, bool timer = false)
    {
        RequireBoundary();
        if (_started) throw new InvalidOperationException("Initial admission closed; use Spawn.");
        return Create(0, clock, timer);
    }

    private void Terminate(ulong ordinal, bool cancelled, params PortableRuntimeEventId[] dependencies)
    {
        Publication.RequireCapacity();
        Identity.RequireInactive(Id(ordinal));
        Publish(ordinal, cancelled ? PortableTemporalEffectKind.ContextCancelled : PortableTemporalEffectKind.ContextTerminated,
            0, 0, dependencies);
        Identity.RetireContext(Id(ordinal));
        _live.Remove(ordinal);
        _timers.Remove(ordinal);
        _blocked.Remove(ordinal);
        _contexts[ordinal].Status = cancelled ? "Cancelled" : "Terminated";
    }

    /// <summary>Queue an explicit external entry before its boundary. No late insertion or implicit host time.</summary>
    public void QueueAdmission(PortableJournalEntry entry)
    {
        RequireBoundary();
        if (_started && _live.Count == 0) throw new InvalidOperationException("Session terminated.");
        int count = checked(_journal.Count + _pending.Count);
        if (count >= _maxEvents || entry.Ordinal != (ulong)count + 1 || entry.Round <= Round ||
            (_pending.TryPeek(out _) && entry.Round < _pending.Last().Round) || !Enum.IsDefined(typeof(PortableAdmissionKind), entry.Kind))
            throw new InvalidDataException("Invalid journal order, boundary or limit.");
        _pending.Enqueue(entry);
    }

    private void ValidateSample(ulong value)
    {
        if (_lastSample is ulong last && value < last) throw new InvalidDataException("Clock regressed.");
    }

    private ulong NextObservationOrdinal => checked((ulong)_observations.Count + 1);
    private void Observe(ulong context, PortableTemporalEffectKind kind, ulong value, ulong admissionOrdinal = 0)
    {
        ValidateSample(value);
        var due = _timers.Where(pair => pair.Value.Deadline <= value)
            .OrderBy(pair => pair.Value.Deadline).ThenBy(pair => pair.Value.Registration.CommitSequence)
            .ThenBy(pair => pair.Key).ToArray();
        Publication.RequireCapacity(checked(1 + due.Length));
        ulong ordinal = NextObservationOrdinal;
        var row = new PortableClockObservation(Round, context, value, ordinal);
        if (_replay is not null && (!_replay.TryPeek(out var expected) || expected != row))
            throw new InvalidDataException("Missing or mismatched replay observation.");
        // Counts of all allocated semantic events and causal predecessors are bounded by maxEvents.
        // Preflight the complete deterministic batch before mutating state or allocating an event.
        var sample = Publish(context, kind, value, admissionOrdinal == 0 ? ordinal : admissionOrdinal);
        _lastSample = value;
        _observations.Add(row);
        foreach (var pair in due)
        {
            Publish(pair.Key, PortableTemporalEffectKind.TimerExpire, value, 0, pair.Value.Registration.Id, sample.Id);
            _timers.Remove(pair.Key);
        }
        _replay?.Dequeue();
    }

    private void Sample(ulong context)
    {
        if (!_contexts[context].Clock) throw new UnauthorizedAccessException("Clock not granted.");
        Publication.RequireCapacity();
        ulong value;
        if (_replay is not null)
        {
            if (!_replay.TryPeek(out var row) || row.Round != Round || row.ContextOrdinal != context ||
                row.RequestOrdinal != NextObservationOrdinal)
                throw new InvalidDataException("Missing or mismatched clock replay request.");
            value = row.Nanoseconds;
        }
        else value = _source?.Invoke() ?? throw new InvalidOperationException("No clock adapter admitted.");
        Observe(context, PortableTemporalEffectKind.ClockSample, value);
    }

    private void Admit(PortableJournalEntry entry)
    {
        if (_live.Count == 0) throw new InvalidDataException("No admissions after termination.");
        if (entry.Kind == PortableAdmissionKind.TimerSample)
        {
            Observe(0, PortableTemporalEffectKind.TimerSample, entry.Value, entry.Ordinal);
            return;
        }
        ulong target = entry.Value;
        if (!_live.Contains(target)) throw new InvalidDataException("Cancellation target is not live.");
        _timers.TryGetValue(target, out var timer);
        bool receiving = _blocked.TryGetValue(target, out var retained);
        if (entry.Kind == PortableAdmissionKind.CancelWait && timer is null && !receiving)
            throw new InvalidDataException("No pending wait to cancel.");
        if (entry.Kind == PortableAdmissionKind.CancelContext) Identity.RequireInactive(Id(target));
        Publication.RequireCapacity(2);
        var admission = Publish(0, PortableTemporalEffectKind.CancelAdmission, target, entry.Ordinal);
        var deps = timer is null ? new[] { admission.Id } : new[] { timer.Registration.Id, admission.Id };
        if (entry.Kind == PortableAdmissionKind.CancelContext) Terminate(target, true, deps);
        else if (timer is not null)
        {
            Publish(target, PortableTemporalEffectKind.TimerCancel, timer.Deadline, 0, deps);
            _timers.Remove(target);
        }
        else
        {
            Publish(target, PortableTemporalEffectKind.ReceiveCancel, retained.Peer.Ordinal, 0, deps);
            _blocked.Remove(target);
        }
    }

    private void Commit(PortableTurnProposal proposal)
    {
        ulong ordinal = proposal.Key.Context.Ordinal;
        var context = _contexts[ordinal];
        bool shared = proposal.Kind is PortableTurnKind.SharedRead or PortableTurnKind.SharedWrite or PortableTurnKind.SharedAdd or PortableTurnKind.SharedCompareExchange;
        bool message = proposal.Kind is PortableTurnKind.Send or PortableTurnKind.Receive;
        if (shared != proposal.Shared.HasValue || message != proposal.Message.HasValue ||
            proposal.Kind != PortableTurnKind.Spawn && (proposal.ClockGrant || proposal.TimerGrant) ||
            proposal.Kind != PortableTurnKind.SleepUntil && proposal.Value != 0)
            throw new InvalidDataException("Noncanonical turn proposal.");
        switch (proposal.Kind)
        {
            case PortableTurnKind.Yield: Publish(ordinal, PortableTemporalEffectKind.Yield, 0); break;
            case PortableTurnKind.SampleClock: Sample(ordinal); break;
            case PortableTurnKind.SleepUntil:
                if (!context.Timer) throw new UnauthorizedAccessException("Timer not granted.");
                var registration = Publish(ordinal, PortableTemporalEffectKind.TimerRegister, proposal.Value);
                _timers.Add(ordinal, new(proposal.Value, registration));
                break;
            case PortableTurnKind.Spawn:
                if (proposal.ClockGrant && !context.Clock || proposal.TimerGrant && !context.Timer)
                    throw new UnauthorizedAccessException("Spawn cannot amplify grants.");
                Create(ordinal, proposal.ClockGrant, proposal.TimerGrant);
                break;
            case PortableTurnKind.Terminate: Terminate(ordinal, false); break;
            case PortableTurnKind.SharedRead:
            case PortableTurnKind.SharedWrite:
            case PortableTurnKind.SharedAdd:
            case PortableTurnKind.SharedCompareExchange:
                CommitShared(ordinal, proposal.Kind, proposal.Shared!.Value); break;
            case PortableTurnKind.Send:
            case PortableTurnKind.Receive:
                CommitMessage(ordinal, proposal.Kind, proposal.Message!.Value); break;
            default: throw new InvalidDataException("Unknown primary effect.");
        }
    }

    public PortableRoundState RunRound(Func<PortableTurnKey, PortableTurnProposal> prepare, bool parallel = false)
    {
        ArgumentNullException.ThrowIfNull(prepare);
        return RunCore(key => _blocked.TryGetValue(key.Context.Ordinal, out var request)
            ? new PortableTurnProposal(key, PortableTurnKind.Receive, Message: request)
            : prepare(key), (key, proposal) =>
        {
            if (proposal.Key != key) throw new InvalidDataException("Stale or foreign turn proposal.");
            Commit(proposal);
        }, parallel);
    }

    // Internal verified interpreter bridge. Exactly one primary ledger event per turn.
    // No external callback may directly mutate identity/publication or use this bridge.
    internal PortableRoundState RunScalarRound<T>(Func<PortableTurnKey, T> prepare,
        Action<PortableTurnKey, T> commit, bool parallel) =>
        RunCore(prepare, (key, proposal) =>
        {
            int before = Events.Count;
            commit(key, proposal);
            if (Events.Count != before + 1 || Events[^1].Id.Context != key.Context)
                throw new InvalidDataException("Interpreter must commit exactly one primary boundary.");
        }, parallel);

    internal void TerminateScalar(PortableTurnKey key) => Terminate(key.Context.Ordinal, false);

    private PortableRoundState RunCore<T>(Func<PortableTurnKey, T> prepare, Action<PortableTurnKey, T> commit, bool parallel)
    {
        ArgumentNullException.ThrowIfNull(prepare);
        RequireBoundary();
        if (_live.Count == 0)
        {
            if (_pending.Count != 0) throw new InvalidDataException("Unused journal after termination.");
            return PortableRoundState.Terminated;
        }
        if (!_live.Any(CanProgress) && _pending.Count == 0) return PortableRoundState.Quiescent;
        _started = true;
        try
        {
            ulong next = checked(Round + 1);
            if (!_live.Any(CanProgress) && _pending.TryPeek(out var future)) next = future.Round;
            Round = next;
            _inRound = true;
            while (_pending.TryPeek(out var entry) && entry.Round == Round)
            {
                Admit(entry);
                _journal.Add(_pending.Dequeue());
            }
            var frontier = _live.Where(c => !_timers.ContainsKey(c)).Select(c => new PortableTurnKey(Round, Id(c))).ToArray();
            var proposals = new T[frontier.Length];
            if (parallel) Parallel.For(0, frontier.Length, i => proposals[i] = prepare(frontier[i]));
            else for (int i = 0; i < frontier.Length; i++) proposals[i] = prepare(frontier[i]);
            // A typed, immutable proposal is the only public commit input.
            for (int i = 0; i < frontier.Length; i++) commit(frontier[i], proposals[i]);
            if (_live.Count == 0)
            {
                if (_pending.Count != 0) throw new InvalidDataException("Unused journal after termination.");
                return PortableRoundState.Terminated;
            }
            return PortableRoundState.Progressed;
        }
        catch { _failed = true; throw; }
        finally { _inRound = false; }
    }

    public PortableTemporalSnapshot Capture()
    {
        RequireBoundary();
        var trace = Events.Select(e => JsonSerializer.Serialize(new
        {
            e.CommitSequence, e.LogicalTime, Context = e.Id.Context.Ordinal, e.Id.Sequence,
            Lifecycle = e.Lifecycle?.Kind, Activation = e.Lifecycle?.Activation.Ordinal ?? e.Instruction?.Activation.Ordinal,
            Instance = e.Lifecycle?.Instance.Ordinal ?? e.Instruction?.Instance.Ordinal,
            Function = e.Lifecycle?.FunctionIndex ?? e.Instruction?.Occurrence.FunctionIndex,
            Occurrence = e.Instruction?.Occurrence, e.Scalar,
            Dependency = e.Dependency is { } d ? new[] { d.Context.Ordinal, d.Sequence } : null,
            Kind = e.Effect?.Kind, Round = e.Effect?.Round, Value = e.Effect?.Value, Aux = e.Effect?.Auxiliary,
            Shared = e.Effect?.Shared, Message = e.Effect?.Message,
            Dependencies = e.Effect?.Dependencies.Select(d => new[] { d.Context.Ordinal, d.Sequence }).ToArray()
        })).ToArray();
        var contexts = _contexts.Select(pair => JsonSerializer.Serialize(new
        {
            Ordinal = pair.Key, pair.Value.Status, pair.Value.Clock, pair.Value.Timer,
            Deadline = _timers.TryGetValue(pair.Key, out var timer) ? (ulong?)timer.Deadline : null
        })).ToArray();
        string policy = JsonSerializer.Serialize(new { ClockDomain.Source, ClockDomain.ResolutionNanoseconds, ClockDomain.ExcludesSuspend });
        return new(Round, Array.AsReadOnly(trace), Array.AsReadOnly(contexts),
            Array.AsReadOnly(_journal.ToArray()), Array.AsReadOnly(_observations.ToArray()),
            Array.AsReadOnly(_pending.ToArray()), policy, CaptureResources());
    }

    public void VerifyReplayComplete(PortableTemporalSnapshot expected)
    {
        ArgumentNullException.ThrowIfNull(expected);
        RequireBoundary();
        if (_replay is null || _replay.Count != 0) throw new InvalidDataException("Replay has unused observations or no replay source.");
        var actual = Capture();
        if (actual.Round != expected.Round || actual.ClockPolicy != expected.ClockPolicy ||
            !actual.Trace.SequenceEqual(expected.Trace) || !actual.Contexts.SequenceEqual(expected.Contexts) ||
            !actual.Journal.SequenceEqual(expected.Journal) || !actual.Observations.SequenceEqual(expected.Observations) ||
            !actual.Pending.SequenceEqual(expected.Pending) || !actual.Resources.SequenceEqual(expected.Resources))
            throw new InvalidDataException("Replay trace or final state mismatch.");
    }
}
