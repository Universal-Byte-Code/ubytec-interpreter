using System.Diagnostics;

namespace Ubytec.Language.Portable;

public readonly record struct PortableClockObservation(ulong Round, ulong ContextOrdinal, ulong Nanoseconds);

/// <summary>Coordinator-owned temporal runtime for admitted managed contexts. No Python dependency.
/// Single coordinator thread; private preparation may run concurrently. Host adapters are trusted.
/// No protected native capability boundary or autonomous wakeup policy is implied.</summary>
public sealed class PortableTemporalCoordinator
{
    private sealed record Timer(ulong Deadline, PortablePublishedEvent Registration);
    private readonly SortedSet<ulong> _live = new();
    private readonly HashSet<ulong> _clockGrants = new();
    private readonly HashSet<ulong> _timerGrants = new();
    private readonly Dictionary<ulong, Timer> _timers = new();
    private readonly Func<ulong>? _source;
    private readonly Queue<PortableClockObservation>? _replay;
    private readonly List<PortableClockObservation> _observations = new();
    private readonly int _maxContexts;
    private ulong? _lastSample;
    private ulong? _turn;
    private bool _inRound;
    private bool _failed;

    internal PortableRuntimeIdentity Identity { get; } = new();
    internal PortableEventPublication Publication { get; }
    public Guid Session => Identity.Session;
    public ulong Round { get; private set; }
    public IReadOnlyList<PortablePublishedEvent> Events => Publication.Events;
    public IReadOnlyList<PortableClockObservation> Observations => _observations.AsReadOnly();
    public int LiveCount => _live.Count;
    public int SuspendedCount => _timers.Count;

    /// <summary>Source provides elapsed ns in one monotonic domain. Null source means no clock.
    /// Injected sources are intended for testing or explicitly specified host adapters.</summary>
    public PortableTemporalCoordinator(int maxEvents = 100_000, int maxContexts = 128,
        Func<ulong>? source = null, IEnumerable<PortableClockObservation>? replay = null)
    {
        if (maxEvents <= 0 || maxContexts <= 0 || (source is not null && replay is not null))
            throw new ArgumentException("Invalid coordinator configuration.");
        _maxContexts = maxContexts;
        _source = source;
        _replay = replay is null ? null : new Queue<PortableClockObservation>(replay);
        Publication = new PortableEventPublication(Session, maxEvents);
    }

    /// <summary>Linux Stopwatch is backed by the monotonic host clock. The domain starts here.
    /// Explicitly reject other platforms until their suspend semantics are specified.</summary>
    public static PortableTemporalCoordinator LiveLinux(int maxEvents = 100_000, int maxContexts = 128)
    {
        if (!OperatingSystem.IsLinux()) throw new PlatformNotSupportedException("Linux monotonic domain required.");
        long origin = Stopwatch.GetTimestamp();
        return new(maxEvents, maxContexts, () =>
        {
            long ticks = checked(Stopwatch.GetTimestamp() - origin);
            if (ticks < 0) throw new InvalidDataException("Host clock regressed.");
            return checked((ulong)((UInt128)(ulong)ticks * 1_000_000_000 / (ulong)Stopwatch.Frequency));
        });
    }

    private PortableRuntimeContextId Id(ulong ordinal) => new(Session, ordinal);
    private ulong EffectRound => _inRound ? Round : checked(Round + 1);

    private void CheckUsable()
    {
        if (_failed) throw new InvalidOperationException("Coordinator aborted after a failed round.");
    }

    private void RequireBoundary()
    {
        CheckUsable();
        if (_inRound) throw new InvalidOperationException("Only between rounds.");
    }

    private void RequireTurn(PortableRuntimeContextId context)
    {
        CheckUsable();
        if (context.Session != Session || _turn != context.Ordinal || !_live.Contains(context.Ordinal))
            throw new InvalidOperationException("Not the admitted context turn.");
    }

    /// <summary>Allocate context in deterministic host admission order, with explicit authority.</summary>
    public PortableRuntimeContextId CreateContext(bool clock = false, bool timer = false)
    {
        RequireBoundary();
        if (_live.Count >= _maxContexts) throw new InvalidOperationException("Context limit.");
        var id = Identity.CreateContext();
        _live.Add(id.Ordinal);
        if (clock) _clockGrants.Add(id.Ordinal);
        if (timer) _timerGrants.Add(id.Ordinal);
        return id;
    }

    /// <summary>Close a context only after its activations have been closed.</summary>
    public void Retire(PortableRuntimeContextId context)
    {
        RequireTurn(context);
        if (_timers.ContainsKey(context.Ordinal)) throw new InvalidOperationException("Context suspended.");
        Identity.RetireContext(context);
        _live.Remove(context.Ordinal);
        _clockGrants.Remove(context.Ordinal);
        _timerGrants.Remove(context.Ordinal);
    }

    /// <summary>Prepare private work from snapshots, then commit in ascending admitted context order.
    /// Callers MUST NOT perform shared effects or use the coordinator in prepare.
    /// A preparation failure aborts before any turn commits; a commit failure poisons the session.</summary>
    public void RunRound<T>(Func<PortableRuntimeContextId, T> prepare,
        Action<PortableRuntimeContextId, T> commit, bool parallel = false)
    {
        ArgumentNullException.ThrowIfNull(prepare);
        ArgumentNullException.ThrowIfNull(commit);
        RequireBoundary();
        if (_live.Count == 0) throw new InvalidOperationException("No live contexts.");
        ulong[] frontier = _live.Where(c => !_timers.ContainsKey(c)).ToArray();
        if (frontier.Length == 0) throw new InvalidOperationException("Quiescent; admit a timer sample.");
        Round = checked(Round + 1);
        _inRound = true;
        try
        {
            var proposals = new T[frontier.Length];
            if (parallel)
                Parallel.For(0, frontier.Length, i => proposals[i] = prepare(Id(frontier[i])));
            else
                for (int i = 0; i < frontier.Length; i++) proposals[i] = prepare(Id(frontier[i]));
            for (int i = 0; i < frontier.Length; i++)
            {
                _turn = frontier[i];
                commit(Id(frontier[i]), proposals[i]);
                _turn = null;
            }
        }
        catch { _failed = true; throw; }
        finally { _turn = null; _inRound = false; }
    }

    private PortablePublishedEvent Publish(ulong context, PortableTemporalEffectKind kind, ulong value,
        params PortableRuntimeEventId[] dependencies)
    {
        Publication.RequireCapacity();
        return Publication.Publish(new PortableTemporalEffect(Identity.AllocateEffect(Id(context)), kind,
            EffectRound, value, Array.AsReadOnly(dependencies)));
    }

    private void ValidateSample(ulong value)
    {
        if (_lastSample is ulong last && value < last) throw new InvalidDataException("Clock regressed.");
    }

    private PortablePublishedEvent Observe(ulong context, PortableTemporalEffectKind kind, ulong value)
    {
        ValidateSample(value);
        var due = _timers.Where(pair => pair.Value.Deadline <= value)
            .OrderBy(pair => pair.Value.Deadline).ThenBy(pair => pair.Value.Registration.CommitSequence)
            .ThenBy(pair => pair.Key).ToArray();
        Publication.RequireCapacity(checked(1 + due.Length));
        var sample = Publish(context, kind, value);
        _lastSample = value;
        _observations.Add(new(EffectRound, context, value));
        foreach (var pair in due)
        {
            Publish(pair.Key, PortableTemporalEffectKind.TimerExpire, value, pair.Value.Registration.Id, sample.Id);
            _timers.Remove(pair.Key);
        }
        return sample;
    }

    private ulong GetObservation(ulong context)
    {
        if (_replay is not null)
        {
            if (!_replay.TryPeek(out var row) || row.Round != EffectRound || row.ContextOrdinal != context)
                throw new InvalidDataException("Missing or mismatched clock replay observation.");
            return row.Nanoseconds;
        }
        return _source?.Invoke() ?? throw new InvalidOperationException("No clock adapter admitted.");
    }

    public ulong Sample(PortableRuntimeContextId context)
    {
        RequireTurn(context);
        if (!_clockGrants.Contains(context.Ordinal)) throw new UnauthorizedAccessException("Clock not granted.");
        Publication.RequireCapacity();
        ulong value = GetObservation(context.Ordinal);
        Observe(context.Ordinal, PortableTemporalEffectKind.ClockSample, value);
        _replay?.Dequeue();
        return value;
    }

    public void SleepUntil(PortableRuntimeContextId context, ulong deadline)
    {
        RequireTurn(context);
        if (!_timerGrants.Contains(context.Ordinal)) throw new UnauthorizedAccessException("Timer not granted.");
        if (_timers.ContainsKey(context.Ordinal)) throw new InvalidOperationException("Already suspended.");
        var registration = Publish(context.Ordinal, PortableTemporalEffectKind.TimerRegister, deadline);
        _timers.Add(context.Ordinal, new(deadline, registration));
    }

    /// <summary>Explicit coordinator admission before the next round. Replay never reads the host.</summary>
    public void AdmitTimerSample()
    {
        RequireBoundary();
        if (_live.Count == 0) throw new InvalidOperationException("No live contexts.");
        Publication.RequireCapacity();
        ulong value = GetObservation(0);
        Observe(0, PortableTemporalEffectKind.TimerSample, value);
        _replay?.Dequeue();
    }

    /// <summary>Explicit host cancellation of a pending wait (resumes context next round).</summary>
    public void CancelTimer(PortableRuntimeContextId context)
    {
        RequireBoundary();
        if (context.Session != Session || !_timers.TryGetValue(context.Ordinal, out var timer))
            throw new InvalidOperationException("No pending timer.");
        Publish(context.Ordinal, PortableTemporalEffectKind.TimerCancel, timer.Deadline, timer.Registration.Id);
        _timers.Remove(context.Ordinal);
    }

    public void VerifyReplayComplete()
    {
        RequireBoundary();
        if (_replay is { Count: > 0 }) throw new InvalidDataException("Unused clock observations.");
    }
}
