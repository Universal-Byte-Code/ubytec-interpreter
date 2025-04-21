using System.Collections;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Syntax.Scopes.Trackers
{
    public class FinalizersTracker : IEnumerable<FinalizersContext>
    {
        private readonly Stack<FinalizersContext> _stack = new();

        public void Push(FinalizersContext context) => _stack.Push(context);

        public FinalizersContext Pop()
        {
            if (_stack.Count == 0)
                throw new SyntaxStackException(0xDEAD0020, "Finalizer stack underflow - no context to end");

            return _stack.Pop();
        }

        public FinalizersContext Peek()
        {
            if (_stack.Count == 0)
                throw new SyntaxStackException(0xDEAD0021, "No finalizer context available");

            return _stack.Peek();
        }

        public FinalizersContext? PeekOrDefault() => _stack.Count > 0 ? _stack.Peek() : null;

        public int Count => _stack.Count;

        // Propaga RETURN al contexto actual
        public void PushReturn(RETURN op)
        {
            if (_stack.Count == 0)
                throw new SyntaxStackException(0xDEAD0022, "No active finalizer scope for RETURN");

            _stack.Peek().Push(op);
        }

        // Propaga BREAK a primer contexto válido (en reversa)
        public void PushBreak(BREAK op)
        {
            foreach (var ctx in _stack)
            {
                ctx.Push(op);
                return;
            }

            throw new SyntaxStackException(0xDEAD0023, "No valid BREAK target found in finalizer stack");
        }

        // Propaga CONTINUE a primer contexto válido (en reversa)
        public void PushContinue(CONTINUE op)
        {
            foreach (var ctx in _stack)
            {
                ctx.Push(op);
                return;
            }

            throw new SyntaxStackException(0xDEAD0024, "No valid CONTINUE target found in finalizer stack");
        }

        public IEnumerator<FinalizersContext> GetEnumerator() => _stack.GetEnumerator();
        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();

        public FinalizersContext? Find(Func<FinalizersContext, bool> predicate)
        {
            var tempStack = new Stack<FinalizersContext>();
            FinalizersContext? found = null;

            while (_stack.Count > 0)
            {
                var ctx = _stack.Pop();
                tempStack.Push(ctx);

                if (predicate(ctx))
                {
                    found = ctx;
                    break;
                }
            }

            foreach (var ctx in tempStack.Reverse())
                _stack.Push(ctx);

            return found;
        }

        public FinalizersContext? TryPopUntil(Func<FinalizersContext, bool> predicate)
        {
            var tempStack = new Stack<FinalizersContext>();

            while (_stack.Count > 0)
            {
                var ctx = _stack.Pop();

                if (predicate(ctx))
                {
                    foreach (var remaining in tempStack.Reverse())
                        _stack.Push(remaining);

                    return ctx;
                }

                tempStack.Push(ctx);
            }

            foreach (var ctx in tempStack.Reverse())
                _stack.Push(ctx);

            return null;
        }

        public void ClearAll()
        {
            _stack.Clear();
        }
    }
}
