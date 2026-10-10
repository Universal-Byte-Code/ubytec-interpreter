using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.Scopes.Trackers;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Syntax.Scopes
{
    /// <summary>
    /// Manages nested scope contexts and finalizer contexts during compilation,
    /// tracking active scopes, finalizers, data definitions, and deterministic labels.
    /// </summary>
    public class CompilationScopes
    {
        /// <summary>Emit a standalone Linux process entry point. Disable for host libraries.</summary>
        public bool EmitProcessEntryPoint { get; init; } = true;

        /// <summary>Opt in to tail frame reuse; programs must not depend on discarded frame addresses.</summary>
        public bool OptimizeTailCalls { get; init; }

        /// <summary>Keep write-through copies of eligible frame values in registers across loops.</summary>
        public bool OptimizeFrameRegisters { get; init; }
        /// <summary>Extend write-through frame copies to functions with raw stores and calls, using effect barriers.</summary>
        public bool OptimizeEffectRegisters { get; init; }

        /// <summary>Specialize closed scalar byte reductions without losing stack observations.</summary>
        public bool OptimizeLoopReductions { get; init; }

        /// <summary>Guard and vectorize closed byte reductions over stable ordinary RAM.</summary>
        public bool OptimizeBlockReductions { get; init; }

        /// <summary>Specialize closed UInt64 field reductions with constant record stride.</summary>
        public bool OptimizeRecordReductions { get; init; }

        /// <summary>Specialize closed ordinal record lookups with nested byte comparisons.</summary>
        public bool OptimizeLookupReductions { get; init; }

        /// <summary>Use AVX2 only after the compiler host has verified CPU/OS support.</summary>
        public bool UseAvx2BlockReductions { get; init; }

        private readonly ScopeTracker _scopeTracker = new();
        private readonly FinalizersTracker _finalizersTracker = new();
        private readonly Dictionary<string, int> _labelCounters = new(StringComparer.Ordinal);

        public ScopeContext[] All => [.. _scopeTracker];

        /// <summary>Allocates a deterministic label within the nearest function/action frame.</summary>
        internal string NextLabel(string prefix)
        {
            var owner = All.FirstOrDefault(scope => scope.DeclaredByKeyword is "func" or "action")?.StartLabel
                ?? PeekOrDefault()?.StartLabel
                ?? "ubytec";

            string key = owner + "\0" + prefix;
            int index = _labelCounters.GetValueOrDefault(key);
            _labelCounters[key] = index + 1;
            return $"{owner}__{prefix}_{index}";
        }

        /// <summary>Resolves a callable from the innermost enclosing scope.</summary>
        public Ubytec.Language.Operations.CallableBinding ResolveCallable(string name)
        {
            foreach (var scope in All)
                if (scope.Callables.TryGetValue(name, out var binding)) return binding;
            throw new Ubytec.Language.Exceptions.SyntaxException(0xBAD067, $"Unknown function '{name}'.");
        }

        /// <summary>Resolves a symbol in the nearest function frame; caller frames are never captured.</summary>
        public Ubytec.Language.Operations.StackBinding ResolveSymbol(string name)
        {
            var frame = All.FirstOrDefault(x => x.DeclaredByKeyword is "func" or "action")
                ?? throw new Ubytec.Language.Exceptions.SyntaxException(0xBAD068, "Named LOAD/STORE requires a function frame.");
            return frame.Symbols.TryGetValue(name, out var binding) ? binding
                : throw new Ubytec.Language.Exceptions.SyntaxException(0xBAD069, $"Unknown variable or argument '{name}'.");
        }

        /// <summary>Gets the number of currently active scope contexts.</summary>
        public int Count => _scopeTracker.Count;

        /// <summary>Gets the number of currently active finalizer contexts.</summary>
        public int FinalizersCount => _finalizersTracker.Count;

        /// <summary>Pushes a new scope context and its finalizer context.</summary>
        public void Push(ScopeContext context)
        {
            _scopeTracker.Push(context);
            _finalizersTracker.Push(new FinalizersContext());
        }

        /// <summary>Pops the current scope and finalizer context.</summary>
        public (ScopeContext scope, FinalizersContext finalizers) Pop()
            => (_scopeTracker.Pop(), _finalizersTracker.Pop());

        /// <summary>Returns the topmost scope context.</summary>
        public ScopeContext Peek() => _scopeTracker.Peek();

        /// <summary>Returns the topmost scope context, or null if none exists.</summary>
        public ScopeContext? PeekOrDefault() => _scopeTracker.PeekOrDefault();

        /// <summary>Searches for a scope context without modifying stack order.</summary>
        public ScopeContext? Find(Func<ScopeContext, bool> predicate) => _scopeTracker.Find(predicate);

        /// <summary>Pops a matching scope context while preserving inner scopes and finalizers.</summary>
        public ScopeContext? TryPopUntil(Func<ScopeContext, bool> predicate)
        {
            var match = All.FirstOrDefault(predicate);
            if (match is null) return null;
            var inner = new List<(ScopeContext scope, FinalizersContext finalizers)>();
            while (Peek() != match) inner.Add(Pop());
            Pop();
            foreach (var pair in inner.AsEnumerable().Reverse())
            {
                _scopeTracker.Push(pair.scope);
                _finalizersTracker.Push(pair.finalizers);
            }
            return match;
        }

        /// <summary>Validates that the current scope stack ends in a properly closed final block.</summary>
        public void ValidateFinalScope() => _scopeTracker.ValidateFinalBlock();

        /// <summary>Records a RETURN operation in the current scope.</summary>
        public void PushReturn(RETURN op)
        {
            _scopeTracker.MarkReturn();
            _finalizersTracker.PushReturn(op);
        }

        /// <summary>Records a BREAK operation in the current scope.</summary>
        public void PushBreak(BREAK op)
        {
            _scopeTracker.MarkBreak();
            _finalizersTracker.PushBreak(op);
        }

        /// <summary>Records a CONTINUE operation in the current scope.</summary>
        public void PushContinue(CONTINUE op)
        {
            _scopeTracker.MarkContinue();
            _finalizersTracker.PushContinue(op);
        }

        /// <summary>Returns the current finalizer context.</summary>
        public FinalizersContext PeekFinalizers() => _finalizersTracker.Peek();

        /// <summary>Returns the current finalizer context, or null if none exists.</summary>
        public FinalizersContext? PeekFinalizersOrDefault() => _finalizersTracker.PeekOrDefault();

        /// <summary>Searches finalizer contexts without changing their order.</summary>
        public FinalizersContext? FindFinalizers(Func<FinalizersContext, bool> predicate)
            => _finalizersTracker.Find(predicate);

        /// <summary>Pops finalizer contexts until one matching the predicate is found.</summary>
        public FinalizersContext? TryPopFinalizersUntil(Func<FinalizersContext, bool> predicate)
            => _finalizersTracker.TryPopUntil(predicate);

        /// <summary>Clears compilation state, including deterministic label counters.</summary>
        public void Reset()
        {
            while (_scopeTracker.Count > 0)
                _scopeTracker.Pop();

            _finalizersTracker.ClearAll();
            _labelCounters.Clear();
        }

        /// <summary>Returns two-space indentation for the current scope depth.</summary>
        public string GetDepth(int basis = 0)
        {
            var indent = string.Empty;
            var depth = Count + basis;
            for (int i = 0; i < depth; i++)
                indent += "  ";
            return indent;
        }
    }
}
