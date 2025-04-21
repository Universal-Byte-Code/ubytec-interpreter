using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.Scopes.Trackers;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Syntax.Scopes
{
    /// <summary>
    /// Mantiene contextos de alcance, rastrea finalizadores y acumula definiciones de datos.
    /// </summary>
    public class CompilationScopes
    {
        private readonly ScopeTracker _scopeTracker = new();
        private readonly FinalizersTracker _finalizersTracker = new();

        /// <summary>
        /// Número de contextos activos.
        /// </summary>
        public int Count => _scopeTracker.Count;
        /// <summary>
        /// Número de contextos de finalizadores activos.
        /// </summary>
        public int FinalizersCount => _finalizersTracker.Count;

        public void Push(ScopeContext context)
        {
            _scopeTracker.Push(context);
            _finalizersTracker.Push(new FinalizersContext());
        }

        public (ScopeContext scope, FinalizersContext finalizers) Pop()
            => (_scopeTracker.Pop(), _finalizersTracker.Pop());

        public ScopeContext Peek() => _scopeTracker.Peek();
        public ScopeContext? PeekOrDefault() => _scopeTracker.PeekOrDefault();
        public ScopeContext? Find(Func<ScopeContext, bool> predicate) => _scopeTracker.Find(predicate);
        public ScopeContext? TryPopUntil(Func<ScopeContext, bool> predicate) => _scopeTracker.TryPopUntil(predicate);
        public void ValidateFinalScope() => _scopeTracker.ValidateFinalBlock();

        public void PushReturn(RETURN op)
        {
            _scopeTracker.MarkReturn();
            _finalizersTracker.PushReturn(op);
        }

        public void PushBreak(BREAK op)
        {
            _scopeTracker.MarkBreak();
            _finalizersTracker.PushBreak(op);
        }

        public void PushContinue(CONTINUE op)
        {
            _scopeTracker.MarkContinue();
            _finalizersTracker.PushContinue(op);
        }

        public FinalizersContext PeekFinalizers() => _finalizersTracker.Peek();
        public FinalizersContext? PeekFinalizersOrDefault() => _finalizersTracker.PeekOrDefault();
        public FinalizersContext? FindFinalizers(Func<FinalizersContext, bool> predicate) => _finalizersTracker.Find(predicate);
        public FinalizersContext? TryPopFinalizersUntil(Func<FinalizersContext, bool> predicate) => _finalizersTracker.TryPopUntil(predicate);

        /// <summary>
        /// Limpia todos los contextos y definiciones de datos.
        /// </summary>
        public void Reset()
        {
            while (_scopeTracker.Count > 0)
                _scopeTracker.Pop();

            _finalizersTracker.ClearAll();
        }
    }
}
