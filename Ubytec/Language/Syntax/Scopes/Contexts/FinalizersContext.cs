using System.Collections;
using Ubytec.Language.Operations;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Syntax.Scopes.Contexts
{
    public class FinalizersContext : IEnumerable<RETURN>, IEnumerable<CONTINUE>, IEnumerable<BREAK>, IEnumerable<IOpCode>
    {
        public Stack<RETURN> ReturnStack { get; private init; } = new();
        public Stack<BREAK> BreakStack { get; private init; } = new();
        public Stack<CONTINUE> ContinueStack { get; private init; } = new();

        // General enumeration
        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();

        public IEnumerator<IOpCode> GetEnumerator()
        {
            return ReturnStack.Cast<IOpCode>()
                .Concat(BreakStack.Cast<IOpCode>())
                .Concat(ContinueStack.Cast<IOpCode>())
                .GetEnumerator();
        }

        IEnumerator<RETURN> IEnumerable<RETURN>.GetEnumerator() => ReturnStack.GetEnumerator();
        IEnumerator<CONTINUE> IEnumerable<CONTINUE>.GetEnumerator() => ContinueStack.GetEnumerator();
        IEnumerator<BREAK> IEnumerable<BREAK>.GetEnumerator() => BreakStack.GetEnumerator();

        // Push methods
        public void Push(RETURN op) => ReturnStack.Push(op);
        public void Push(BREAK op) => BreakStack.Push(op);
        public void Push(CONTINUE op) => ContinueStack.Push(op);

        // Pop methods
        public RETURN PopReturn() => ReturnStack.Pop();
        public BREAK PopBreak() => BreakStack.Pop();
        public CONTINUE PopContinue() => ContinueStack.Pop();

        // Peek methods
        public RETURN PeekReturn() => ReturnStack.Peek();
        public BREAK PeekBreak() => BreakStack.Peek();
        public CONTINUE PeekContinue() => ContinueStack.Peek();

        // Count methods
        public int ReturnCount => ReturnStack.Count;
        public int BreakCount => BreakStack.Count;
        public int ContinueCount => ContinueStack.Count;
        public int TotalCount => ReturnStack.Count + BreakStack.Count + ContinueStack.Count;

        // Clear methods
        public void ClearReturns() => ReturnStack.Clear();
        public void ClearBreaks() => BreakStack.Clear();
        public void ClearContinues() => ContinueStack.Clear();
        public void ClearAll()
        {
            ClearReturns();
            ClearBreaks();
            ClearContinues();
        }
    }
}
