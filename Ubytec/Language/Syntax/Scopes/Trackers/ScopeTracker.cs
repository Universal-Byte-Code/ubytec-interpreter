using System.Collections;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Syntax.Scopes.Trackers
{
    /// <summary>
    /// Tracks nested <see cref="ScopeContext"/> instances during compilation,
    /// managing loop, branch, and function-return semantics.
    /// </summary>
    public class ScopeTracker : IEnumerable<ScopeContext>
    {
        private readonly Stack<ScopeContext> _stack = new();


        /// <summary>
        /// Pushes a new scope context onto the tracker.
        /// </summary>
        /// <param name="context">The <see cref="ScopeContext"/> to push.</param>
        public void Push(ScopeContext context) => _stack.Push(context);

        /// <summary>
        /// Pops and returns the topmost scope context.
        /// </summary>
        /// <returns>The most recently pushed <see cref="ScopeContext"/>.</returns>
        /// <exception cref="SyntaxStackException">
        /// Thrown if no scope context remains on the stack.
        /// </exception>
        public ScopeContext Pop()
        {
            if (_stack.Count == 0)
                throw new SyntaxStackException(0xDEAD0011, "Block stack underflow - no block to end");

            return _stack.Pop();
        }

        /// <summary>
        /// Gets the number of scope contexts currently being tracked.
        /// </summary>
        public int Count => _stack.Count;

        /// <summary>
        /// Peeks at the topmost scope context without removing it.
        /// </summary>
        /// <returns>The current <see cref="ScopeContext"/>.</returns>
        /// <exception cref="SyntaxStackException">
        /// Thrown if the stack is empty.
        /// </exception>
        public ScopeContext Peek()
        {
            if (_stack.Count == 0)
                throw new SyntaxStackException(0xDEAD0012, "No block context available");

            return _stack.Peek();
        }

        /// <summary>
        /// Marks that a <c>return</c> has occurred in the current scope.
        /// </summary>
        public void MarkReturn()
        {
            if (_stack.Count == 0) return;
            _stack.Peek().HasReturn = true;
        }

        /// <summary>
        /// Marks that a <c>break</c> has occurred in the first enclosing loop or branch scope.
        /// </summary>
        public void MarkBreak()
        {
            foreach (var ctx in _stack)
            {
                if (ctx.IsLoop || ctx.IsBranch)
                {
                    ctx.HasBreak = true;
                    return;
                }
            }
        }

        /// <summary>
        /// Marks that a <c>continue</c> has occurred in the first enclosing loop scope.
        /// </summary>
        public void MarkContinue()
        {
            foreach (var ctx in _stack)
            {
                if (ctx.IsLoop)
                {
                    ctx.HasContinue = true;
                    return;
                }
            }
        }

        /// <summary>
        /// Validates that the current function or returnable scope ends with a return,
        /// if an explicit return is required.
        /// </summary>
        /// <exception cref="SyntaxStackException">
        /// Thrown if a returnable scope expects a non-void return but none was marked.
        /// </exception>
        public void ValidateFinalBlock()
        {
            if (_stack.Count == 0) return;

            var ctx = _stack.Peek();
            if (ctx.IsReturnable &&
                ctx.ExpectedReturnType?.Type != PrimitiveType.Void &&
                !ctx.HasReturn)
            {
                throw new SyntaxStackException(
                    0xDEAD0013,
                    $"Function block '{ctx.StartLabel}' ends without a return for expected type: {ctx.ExpectedReturnType?.Type}");
            }
        }

        /// <summary>
        /// Returns an enumerator that iterates through the tracked scope contexts (LIFO order).
        /// </summary>
        /// <returns>An <see cref="IEnumerator{ScopeContext}"/> over the stack.</returns>
        public IEnumerator<ScopeContext> GetEnumerator() => _stack.GetEnumerator();

        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();

        /// <summary>
        /// Searches for the first <see cref="ScopeContext"/> matching the given predicate,
        /// without permanently modifying the stack.
        /// </summary>
        /// <param name="predicate">A function to test each context.</param>
        /// <returns>
        /// The first matching context, or <c>null</c> if none match.
        /// </returns>
        public ScopeContext? Find(Func<ScopeContext, bool> predicate)
        {
            var temp = new Stack<ScopeContext>();
            ScopeContext? found = null;

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
        /// restoring any contexts popped after it.
        /// </summary>
        /// <param name="predicate">A function to test each context.</param>
        /// <returns>
        /// The matching context if found; otherwise, <c>null</c>.
        /// </returns>
        public ScopeContext? TryPopUntil(Func<ScopeContext, bool> predicate)
        {
            var temp = new Stack<ScopeContext>();

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
        /// Peeks at the topmost scope context without removing it,
        /// or returns <c>null</c> if the stack is empty.
        /// </summary>
        /// <returns>
        /// The current <see cref="ScopeContext"/>, or <c>null</c> if none exist.
        /// </returns>
        public ScopeContext? PeekOrDefault() => _stack.Count > 0 ? _stack.Peek() : null;
    }
}
