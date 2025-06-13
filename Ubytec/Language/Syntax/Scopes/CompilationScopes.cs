using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.Scopes.Trackers;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Syntax.Scopes
{
    /// <summary>
    /// Manages nested scope contexts and finalizer contexts during compilation,
    /// tracking active scopes, finalizers, and data definitions.
    /// </summary>
    public class CompilationScopes
    {
        private readonly ScopeTracker _scopeTracker = new();
        private readonly FinalizersTracker _finalizersTracker = new();

        /// <summary>
        /// Gets the number of currently active scope contexts.
        /// </summary>
        public int Count => _scopeTracker.Count;

        /// <summary>
        /// Gets the number of currently active finalizer contexts.
        /// </summary>
        public int FinalizersCount => _finalizersTracker.Count;

        /// <summary>
        /// Pushes a new scope context onto the stack, and initializes a corresponding finalizers context.
        /// </summary>
        /// <param name="context">The <see cref="ScopeContext"/> to push.</param>
        public void Push(ScopeContext context)
        {
            _scopeTracker.Push(context);
            _finalizersTracker.Push(new FinalizersContext());
        }

        /// <summary>
        /// Pops the top scope and its finalizers context from their respective stacks.
        /// </summary>
        /// <returns>
        /// A tuple containing the popped <see cref="ScopeContext"/> and its associated <see cref="FinalizersContext"/>.
        /// </returns>
        public (ScopeContext scope, FinalizersContext finalizers) Pop()
            => (_scopeTracker.Pop(), _finalizersTracker.Pop());

        /// <summary>
        /// Peeks at the top <see cref="ScopeContext"/> without removing it.
        /// </summary>
        /// <returns>The topmost scope context.</returns>
        public ScopeContext Peek() => _scopeTracker.Peek();

        /// <summary>
        /// Peeks at the top <see cref="ScopeContext"/> without removing it, or returns <c>null</c> if none.
        /// </summary>
        /// <returns>The topmost scope context, or <c>null</c> if the stack is empty.</returns>
        public ScopeContext? PeekOrDefault() => _scopeTracker.PeekOrDefault();

        /// <summary>
        /// Searches for a scope context matching the given predicate without modifying the stack.
        /// </summary>
        /// <param name="predicate">A function to test each <see cref="ScopeContext"/>.</param>
        /// <returns>
        /// The first matching <see cref="ScopeContext"/>, or <c>null</c> if none match.
        /// </returns>
        public ScopeContext? Find(Func<ScopeContext, bool> predicate) => _scopeTracker.Find(predicate);

        /// <summary>
        /// Pops scope contexts until one matching the predicate is found (inclusive), or the stack is empty.
        /// </summary>
        /// <param name="predicate">A function to test each <see cref="ScopeContext"/>.</param>
        /// <returns>
        /// The matching <see cref="ScopeContext"/> if found; otherwise, <c>null</c>.
        /// </returns>
        public ScopeContext? TryPopUntil(Func<ScopeContext, bool> predicate) => _scopeTracker.TryPopUntil(predicate);

        /// <summary>
        /// Validates that the current scope stack ends in a properly closed final block.
        /// </summary>
        public void ValidateFinalScope() => _scopeTracker.ValidateFinalBlock();

        /// <summary>
        /// Records a <c>RETURN</c> operation in the current scope and pushes it to the finalizers tracker.
        /// </summary>
        /// <param name="op">The <c>RETURN</c> opcode to register.</param>
        public void PushReturn(RETURN op)
        {
            _scopeTracker.MarkReturn();
            _finalizersTracker.PushReturn(op);
        }

        /// <summary>
        /// Records a <c>BREAK</c> operation in the current scope and pushes it to the finalizers tracker.
        /// </summary>
        /// <param name="op">The <c>BREAK</c> opcode to register.</param>
        public void PushBreak(BREAK op)
        {
            _scopeTracker.MarkBreak();
            _finalizersTracker.PushBreak(op);
        }

        /// <summary>
        /// Records a <c>CONTINUE</c> operation in the current scope and pushes it to the finalizers tracker.
        /// </summary>
        /// <param name="op">The <c>CONTINUE</c> opcode to register.</param>
        public void PushContinue(CONTINUE op)
        {
            _scopeTracker.MarkContinue();
            _finalizersTracker.PushContinue(op);
        }

        /// <summary>
        /// Peeks at the top <see cref="FinalizersContext"/> without removing it.
        /// </summary>
        /// <returns>The topmost finalizers context.</returns>
        public FinalizersContext PeekFinalizers() => _finalizersTracker.Peek();

        /// <summary>
        /// Peeks at the top <see cref="FinalizersContext"/> without removing it, or returns <c>null</c> if none.
        /// </summary>
        /// <returns>The topmost finalizers context, or <c>null</c> if the stack is empty.</returns>
        public FinalizersContext? PeekFinalizersOrDefault() => _finalizersTracker.PeekOrDefault();

        /// <summary>
        /// Searches for a finalizers context matching the given predicate without modifying the stack.
        /// </summary>
        /// <param name="predicate">A function to test each <see cref="FinalizersContext"/>.</param>
        /// <returns>
        /// The first matching <see cref="FinalizersContext"/>, or <c>null</c> if none match.
        /// </returns>
        public FinalizersContext? FindFinalizers(Func<FinalizersContext, bool> predicate)
            => _finalizersTracker.Find(predicate);

        /// <summary>
        /// Pops finalizers contexts until one matching the predicate is found (inclusive), or the stack is empty.
        /// </summary>
        /// <param name="predicate">A function to test each <see cref="FinalizersContext"/>.</param>
        /// <returns>
        /// The matching <see cref="FinalizersContext"/> if found; otherwise, <c>null</c>.
        /// </returns>
        public FinalizersContext? TryPopFinalizersUntil(Func<FinalizersContext, bool> predicate)
            => _finalizersTracker.TryPopUntil(predicate);

        /// <summary>
        /// Clears all scope and finalizer contexts, resetting this instance to its initial state.
        /// </summary>
        public void Reset()
        {
            while (_scopeTracker.Count > 0)
                _scopeTracker.Pop();

            _finalizersTracker.ClearAll();
        }
    }
}
