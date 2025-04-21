using System.Collections;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Syntax.Scopes.Trackers
{
    public class ScopeTracker : IEnumerable<ScopeContext>
    {
        private readonly Stack<ScopeContext> _stack = new();

        public void Push(ScopeContext context) => _stack.Push(context);

        public ScopeContext Pop()
        {
            if (_stack.Count == 0)
                throw new SyntaxStackException(0xDEAD0011, "Block stack underflow - no block to end");

            return _stack.Pop();
        }

        public int Count => _stack.Count;

        public ScopeContext Peek()
        {
            if (_stack.Count == 0)
                throw new SyntaxStackException(0xDEAD0012, "No block context available");

            return _stack.Peek();
        }

        public void MarkReturn()
        {
            if (_stack.Count == 0) return;
            _stack.Peek().HasReturn = true;
        }

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

        public void ValidateFinalBlock()
        {
            if (_stack.Count == 0) return;
            var ctx = _stack.Peek();
            if (ctx.IsReturnable && ctx.ExpectedReturnType?.Type != PrimitiveType.Void && !ctx.HasReturn)
                throw new SyntaxStackException(0xDEAD0013, $"Function block '{ctx.StartLabel}' ends without a return for expected type: {ctx.ExpectedReturnType?.Type}");
        }

        public IEnumerator<ScopeContext> GetEnumerator()
        {
            return ((IEnumerable<ScopeContext>)_stack).GetEnumerator();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return ((IEnumerable)_stack).GetEnumerator();
        }

        /// <summary>
        /// Busca el primer bloque desde el top del stack que cumpla una condición.
        /// Devuelve un resultado y mantiene el stack intacto.
        /// </summary>
        public ScopeContext? Find(Func<ScopeContext, bool> predicate)
        {
            var tempStack = new Stack<ScopeContext>();
            ScopeContext? found = null;

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

            // Restaurar el stack original
            foreach (var ctx in tempStack.Reverse())
                _stack.Push(ctx);

            return found;
        }

        /// <summary>
        /// Intenta desapilar bloques hasta encontrar uno que cumpla la condición.
        /// Devuelve el bloque encontrado, o null si no hay ninguno. El resto del stack se conserva.
        /// </summary>
        public ScopeContext? TryPopUntil(Func<ScopeContext, bool> predicate)
        {
            var tempStack = new Stack<ScopeContext>();

            while (_stack.Count > 0)
            {
                var ctx = _stack.Pop();

                if (predicate(ctx))
                {
                    // No reinsertamos el que sí cumple
                    foreach (var remaining in tempStack.Reverse())
                        _stack.Push(remaining);

                    return ctx;
                }

                tempStack.Push(ctx);
            }

            // Nada encontrado: restaurar todo
            foreach (var ctx in tempStack.Reverse())
                _stack.Push(ctx);

            return null;
        }

        /// <summary>
        /// Devuelve el bloque del tope si existe, o null si el stack está vacío.
        /// </summary>
        public ScopeContext? PeekOrDefault()
        {
            return _stack.Count > 0 ? _stack.Peek() : null;
        }
    }
}
