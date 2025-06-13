using System.Collections;
using Ubytec.Language.Operations;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Syntax.Scopes.Contexts
{
    /// <summary>
    /// Holds stacks of control-flow opcodes (RETURN, BREAK, CONTINUE) to be executed
    /// when finalizing a scope. Supports enumeration over each category and collectively.
    /// </summary>
    public class FinalizersContext :
        IEnumerable<RETURN>,
        IEnumerable<CONTINUE>,
        IEnumerable<BREAK>,
        IEnumerable<IOpCode>
    {
        /// <summary>
        /// Gets the stack of <see cref="RETURN"/> opcodes to finalize.
        /// </summary>
        public Stack<RETURN> ReturnStack { get; private init; } = new();

        /// <summary>
        /// Gets the stack of <see cref="BREAK"/> opcodes to finalize.
        /// </summary>
        public Stack<BREAK> BreakStack { get; private init; } = new();

        /// <summary>
        /// Gets the stack of <see cref="CONTINUE"/> opcodes to finalize.
        /// </summary>
        public Stack<CONTINUE> ContinueStack { get; private init; } = new();

        #region Enumeration

        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();

        /// <summary>
        /// Enumerates all opcodes in this context in the order:
        /// all returns, then breaks, then continues.
        /// </summary>
        /// <returns>An <see cref="IEnumerator{IOpCode}"/> over all opcodes.</returns>
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

        #endregion

        #region Push Methods

        /// <summary>
        /// Adds a <see cref="RETURN"/> opcode to the finalizers.
        /// </summary>
        public void Push(RETURN op) => ReturnStack.Push(op);

        /// <summary>
        /// Adds a <see cref="BREAK"/> opcode to the finalizers.
        /// </summary>
        public void Push(BREAK op) => BreakStack.Push(op);

        /// <summary>
        /// Adds a <see cref="CONTINUE"/> opcode to the finalizers.
        /// </summary>
        public void Push(CONTINUE op) => ContinueStack.Push(op);

        #endregion

        #region Pop Methods

        /// <summary>
        /// Removes and returns the most recent <see cref="RETURN"/> opcode.
        /// </summary>
        public RETURN PopReturn() => ReturnStack.Pop();

        /// <summary>
        /// Removes and returns the most recent <see cref="BREAK"/> opcode.
        /// </summary>
        public BREAK PopBreak() => BreakStack.Pop();

        /// <summary>
        /// Removes and returns the most recent <see cref="CONTINUE"/> opcode.
        /// </summary>
        public CONTINUE PopContinue() => ContinueStack.Pop();

        #endregion

        #region Peek Methods

        /// <summary>
        /// Returns the most recent <see cref="RETURN"/> opcode without removing it.
        /// </summary>
        public RETURN PeekReturn() => ReturnStack.Peek();

        /// <summary>
        /// Returns the most recent <see cref="BREAK"/> opcode without removing it.
        /// </summary>
        public BREAK PeekBreak() => BreakStack.Peek();

        /// <summary>
        /// Returns the most recent <see cref="CONTINUE"/> opcode without removing it.
        /// </summary>
        public CONTINUE PeekContinue() => ContinueStack.Peek();

        #endregion

        #region Count Properties

        /// <summary>
        /// Gets the number of pending <see cref="RETURN"/> opcodes.
        /// </summary>
        public int ReturnCount => ReturnStack.Count;

        /// <summary>
        /// Gets the number of pending <see cref="BREAK"/> opcodes.
        /// </summary>
        public int BreakCount => BreakStack.Count;

        /// <summary>
        /// Gets the number of pending <see cref="CONTINUE"/> opcodes.
        /// </summary>
        public int ContinueCount => ContinueStack.Count;

        /// <summary>
        /// Gets the total number of pending opcodes across all categories.
        /// </summary>
        public int TotalCount => ReturnStack.Count + BreakStack.Count + ContinueStack.Count;

        #endregion

        #region Clear Methods

        /// <summary>
        /// Removes all <see cref="RETURN"/> opcodes.
        /// </summary>
        public void ClearReturns() => ReturnStack.Clear();

        /// <summary>
        /// Removes all <see cref="BREAK"/> opcodes.
        /// </summary>
        public void ClearBreaks() => BreakStack.Clear();

        /// <summary>
        /// Removes all <see cref="CONTINUE"/> opcodes.
        /// </summary>
        public void ClearContinues() => ContinueStack.Clear();

        /// <summary>
        /// Removes all opcodes from all categories.
        /// </summary>
        public void ClearAll()
        {
            ClearReturns();
            ClearBreaks();
            ClearContinues();
        }

        #endregion
    }
}
