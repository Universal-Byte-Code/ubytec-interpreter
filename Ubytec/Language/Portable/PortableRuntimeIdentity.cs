namespace Ubytec.Language.Portable;

/// <summary>Identity of one loaded executable, not a capability to use it.</summary>
public readonly record struct PortableLoadedInstanceId(Guid Session, ulong Ordinal);
/// <summary>Identity of one runtime execution context.</summary>
public readonly record struct PortableRuntimeContextId(Guid Session, ulong Ordinal);
/// <summary>Identity of one invocation, including recursive invocations.</summary>
public readonly record struct PortableActivationId(PortableRuntimeContextId Context, ulong Ordinal);
/// <summary>Context-local event identity; replay may compare ordinals without the session GUID.</summary>
public readonly record struct PortableRuntimeEventId(PortableRuntimeContextId Context, ulong Sequence);
/// <summary>Association between a dynamic event, activation, loaded instance and verified instruction.</summary>
public readonly record struct PortableRuntimeEvent(
    PortableRuntimeEventId Id, PortableActivationId Activation,
    PortableLoadedInstanceId Instance, PortableInstructionOccurrence Occurrence);

/// <summary>
/// Serial coordinator reference for event identity. Not thread-safe; callers must serialize all
/// lifecycle and event operations in admitted logical order. No native instrumentation or
/// execution authority is provided. Reload, recursion and restart never reuse an identity
/// within the same session. A fresh coordinator creates a fresh session.
/// </summary>
public sealed class PortableRuntimeIdentity
{
    /// <summary>Fresh runtime namespace; intentionally not part of deterministic replay-local order.</summary>
    public Guid Session { get; } = Guid.NewGuid();
    private ulong _nextInstance;
    private ulong _nextContext;
    private readonly Dictionary<PortableLoadedInstanceId, Loaded> _instances = new();
    private readonly Dictionary<PortableRuntimeContextId, Context> _contexts = new();

    private sealed record Loaded(int FunctionCount,
        IReadOnlyDictionary<(uint Function, uint Offset), PortableInstructionOccurrence> Sites);
    private sealed record Activation(PortableActivationId Id, PortableLoadedInstanceId Instance, uint Function);
    private sealed class Context
    {
        internal ulong LastActivation;
        internal ulong LastEvent;
        internal readonly Stack<Activation> Stack = new();
    }

    /// <summary>Register an independently verified snapshot under an explicit admission profile.</summary>
    public PortableLoadedInstanceId Load(ReadOnlySpan<byte> bytes, PortableExecutionProfile profile,
        int maxInstructions = 1_000_000)
    {
        byte[] snapshot = bytes.ToArray();
        var sites = PortableBinaryVerifier.IdentifyInstructions(snapshot, maxInstructions, profile)
            .ToDictionary(site => (site.FunctionIndex, site.InstructionOffset));
        int count = PortableBinaryCodec.Decode(snapshot).Executable!.Functions.Count;
        var id = new PortableLoadedInstanceId(Session, Next(ref _nextInstance));
        _instances.Add(id, new Loaded(count, sites));
        return id;
    }

    /// <summary>Unload only an inactive instance; its ordinal is never reused.</summary>
    public void Unload(PortableLoadedInstanceId id)
    {
        _ = Instance(id);
        if (_contexts.Values.Any(context => context.Stack.Any(activation => activation.Instance == id)))
            throw new InvalidOperationException("Cannot unload an instance with active invocations.");
        _instances.Remove(id);
    }

    /// <summary>Allocate a context in the order admitted by the coordinator.</summary>
    public PortableRuntimeContextId CreateContext()
    {
        var id = new PortableRuntimeContextId(Session, Next(ref _nextContext));
        _contexts.Add(id, new Context());
        return id;
    }

    /// <summary>Retire an inactive context; its ordinal and local event namespace are not reused.</summary>
    public void RetireContext(PortableRuntimeContextId id)
    {
        Context context = GetContext(id);
        if (context.Stack.Count != 0)
            throw new InvalidOperationException("Cannot retire a context with active invocations.");
        _contexts.Remove(id);
    }

    /// <summary>Record invocation entry. This does not validate call authority or call edges.</summary>
    public PortableActivationId Enter(PortableRuntimeContextId id, PortableLoadedInstanceId instance, uint function)
    {
        Context context = GetContext(id);
        Loaded loaded = Instance(instance);
        if (function >= (uint)loaded.FunctionCount)
            throw new ArgumentOutOfRangeException(nameof(function));
        var activation = new PortableActivationId(id, Next(ref context.LastActivation));
        context.Stack.Push(new Activation(activation, instance, function));
        return activation;
    }

    /// <summary>Record invocation exit in strict LIFO order.</summary>
    public void Leave(PortableActivationId id)
    {
        Context context = GetContext(id.Context);
        if (!context.Stack.TryPeek(out var active) || active.Id != id)
            throw new InvalidOperationException("Activation is not the current invocation.");
        context.Stack.Pop();
    }

    /// <summary>
    /// Attribute one admitted event to a verified instruction in the current invocation.
    /// Uses the bounded verified index created at load time. No event is allocated for a rejected site.
    /// </summary>
    public PortableRuntimeEvent Record(PortableActivationId id, uint offset)
    {
        Context context = GetContext(id.Context);
        if (!context.Stack.TryPeek(out var active) || active.Id != id)
            throw new InvalidOperationException("Activation is not the current invocation.");
        Loaded loaded = Instance(active.Instance);
        if (!loaded.Sites.TryGetValue((active.Function, offset), out var occurrence))
            throw new InvalidDataException("Requested occurrence is not a verified instruction boundary.");
        var eventId = new PortableRuntimeEventId(id.Context, Next(ref context.LastEvent));
        return new PortableRuntimeEvent(eventId, id, active.Instance, occurrence);
    }

    private Loaded Instance(PortableLoadedInstanceId id) =>
        _instances.TryGetValue(id, out var loaded) ? loaded : throw new InvalidOperationException("Unknown loaded instance.");
    private Context GetContext(PortableRuntimeContextId id) =>
        _contexts.TryGetValue(id, out var context) ? context : throw new InvalidOperationException("Unknown runtime context.");

    private static ulong Next(ref ulong last)
    {
        if (last == ulong.MaxValue)
            throw new InvalidOperationException("Identity namespace exhausted; cannot wrap.");
        return ++last;
    }
}
