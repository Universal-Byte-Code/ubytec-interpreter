using System.Collections;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Syntax.Scopes.Trackers
{
    /// <summary>
    /// Tracks nested finalizer contexts during compilation, allowing
    /// propagation of control-flow operations (RETURN, BREAK, CONTINUE)
    /// into the appropriate finalizer scopes.
    /// </summary>
    public class FinalizersTracker : IEnumerable<FinalizersContext>
    {
        private readonly Stack<FinalizersContext> _stack = new();

        /// <summary>
        /// Pushes a new <see cref="FinalizersContext"/> onto the tracker stack.
        /// </summary>
        /// <param name="context">The finalizer context to begin tracking.</param>
        public void Push(FinalizersContext context) => _stack.Push(context);

        /// <summary>
        /// Pops and returns the topmost <see cref="FinalizersContext"/>.
        /// </summary>
        /// <returns>The most recently pushed finalizer context.</returns>
        /// <exception cref="SyntaxStackException">
        /// Thrown if no context remains on the stack.
        /// </exception>
        public FinalizersContext Pop()
        {
            if (_stack.Count == 0)
                throw new SyntaxStackException(0xDEAD0020, "Finalizer stack underflow - no context to end");

            return _stack.Pop();
        }

        /// <summary>
        /// Peeks at the topmost <see cref="FinalizersContext"/> without removing it.
        /// </summary>
        /// <returns>The current finalizer context.</returns>
        /// <exception cref="SyntaxStackException">
        /// Thrown if no context is available.
        /// </exception>
        public FinalizersContext Peek()
        {
            if (_stack.Count == 0)
                throw new SyntaxStackException(0xDEAD0021, "No finalizer context available");

            return _stack.Peek();
        }

        /// <summary>
        /// Peeks at the topmost <see cref="FinalizersContext"/> without removing it,
        /// or returns <c>null</c> if the stack is empty.
        /// </summary>
        /// <returns>The current finalizer context, or <c>null</c>.</returns>
        public FinalizersContext? PeekOrDefault() => _stack.Count > 0 ? _stack.Peek() : null;

        /// <summary>
        /// Gets the number of finalizer contexts currently being tracked.
        /// </summary>
        public int Count => _stack.Count;

        /// <summary>
        /// Propagates a <c>RETURN</c> opcode into the current finalizer context.
        /// </summary>
        /// <param name="op">The <c>RETURN</c> opcode to register.</param>
        /// <exception cref="SyntaxStackException">
        /// Thrown if no finalizer context is active.
        /// </exception>
        public void PushReturn(RETURN op)
        {
            if (_stack.Count == 0)
                throw new SyntaxStackException(0xDEAD0022, "No active finalizer scope for RETURN");

            _stack.Peek().Push(op);
        }

        /// <summary>
        /// Propagates a <c>BREAK</c> opcode into the first valid finalizer context (LIFO order).
        /// </summary>
        /// <param name="op">The <c>BREAK</c> opcode to register.</param>
        /// <exception cref="SyntaxStackException">
        /// Thrown if no valid finalizer context is found.
        /// </exception>
        public void PushBreak(BREAK op)
        {
            foreach (var ctx in _stack)
            {
                ctx.Push(op);
                return;
            }

            throw new SyntaxStackException(0xDEAD0023, "No valid BREAK target found in finalizer stack");
        }

        /// <summary>
        /// Propagates a <c>CONTINUE</c> opcode into the first valid finalizer context (LIFO order).
        /// </summary>
        /// <param name="op">The <c>CONTINUE</c> opcode to register.</param>
        /// <exception cref="SyntaxStackException">
        /// Thrown if no valid finalizer context is found.
        /// </exception>
        public void PushContinue(CONTINUE op)
        {
            foreach (var ctx in _stack)
            {
                ctx.Push(op);
                return;
            }

            throw new SyntaxStackException(0xDEAD0024, "No valid CONTINUE target found in finalizer stack");
        }

        /// <summary>
        /// Returns an enumerator that iterates through the tracked finalizer contexts.
        /// </summary>
        /// <returns>An <see cref="IEnumerator{FinalizersContext}"/>.</returns>
        public IEnumerator<FinalizersContext> GetEnumerator() => _stack.GetEnumerator();

        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();

        /// <summary>
        /// Finds the first <see cref="FinalizersContext"/> matching the given predicate,
        /// without permanently modifying the stack.
        /// </summary>
        /// <param name="predicate">A function to test each context.</param>
        /// <returns>
        /// The first matching context, or <c>null</c> if none match.
        /// </returns>
        public FinalizersContext? Find(Func<FinalizersContext, bool> predicate)
        {
            var temp = new Stack<FinalizersContext>();
            FinalizersContext? found = null;

            while (_stack.Count > 0)
            {
                var ctx = _stack.Pop();
                temp.Push(ctx);
                if (predicate(ctx))
                {
                    found = ctx;
                    break;
                }
            }

            foreach (var ctx in temp.Reverse())
                _stack.Push(ctx);

            return found;
        }

        /// <summary>
        /// Pops contexts until one matching the predicate is found (inclusive),
        /// then restores any intervening contexts.
        /// </summary>
        /// <param name="predicate">A function to test each context.</param>
        /// <returns>
        /// The matching context if found; otherwise, <c>null</c>.
        /// </returns>
        public FinalizersContext? TryPopUntil(Func<FinalizersContext, bool> predicate)
        {
            var temp = new Stack<FinalizersContext>();

            while (_stack.Count > 0)
            {
                var ctx = _stack.Pop();
                if (predicate(ctx))
                {
                    foreach (var r in temp.Reverse())
                        _stack.Push(r);
                    return ctx;
                }
                temp.Push(ctx);
            }

            foreach (var ctx in temp.Reverse())
                _stack.Push(ctx);

            return null;
        }

        /// <summary>
        /// Clears all tracked finalizer contexts.
        /// </summary>
        public void ClearAll() => _stack.Clear();
    }
}
