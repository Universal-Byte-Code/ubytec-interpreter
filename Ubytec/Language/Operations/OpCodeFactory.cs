using Ubytec.Language.Operations.Extended;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Operations
{
    /// <summary>
    /// Central factory responsible for instantiating <see cref="IOpCode"/> objects from raw <c>ValueType</c> op-codes.
    /// <para>
    /// The factory supports two categories of instructions:
    /// <list type="bullet">
    /// <item><description><strong>Core op-codes</strong> (byte value ≠ <c>0xFF</c>): created via a fast lookup table.</description></item>
    /// <item><description><strong>Extended op-codes</strong> (byte value <c>0xFF</c>): routed to <see cref="ExtendedOpcodeFactory"/> using the next two operand bytes <c>ExtensionGroup</c> and <c>ExtendedOpCode</c>.</description></item>
    /// </list>
    /// </para>
    /// </summary>
    public static class OpcodeFactory
    {
        /// <summary>
        /// Maps a core <c>ValueType</c> op‑code to its delegate constructor.
        /// </summary>
        private static readonly Dictionary<ValueType, IOpCodeFactory.OpCodeFactoryDelegate> _factory =
            new()
            {
                { TRAP.OP, TRAP.CreateInstruction },
                { NOP.OP, NOP.CreateInstruction },
                { BLOCK.OP, BLOCK.CreateInstruction },
                { LOOP.OP, LOOP.CreateInstruction },
                { IF.OP, IF.CreateInstruction },
                { ELSE.OP, ELSE.CreateInstruction },
                { END.OP, END.CreateInstruction },
                { BREAK.OP, BREAK.CreateInstruction },
                { CONTINUE.OP, CONTINUE.CreateInstruction },
                { RETURN.OP, RETURN.CreateInstruction },
                { BRANCH.OP, BRANCH.CreateInstruction },
                { SWITCH.OP, SWITCH.CreateInstruction },
                { WHILE.OP, WHILE.CreateInstruction },
                { CLEAR.OP, CLEAR.CreateInstruction },
                { DEFAULT.OP, DEFAULT.CreateInstruction },
                { NULL.OP, NULL.CreateInstruction },
                { FunctionOperations.CALL.OP, FunctionOperations.CALL.CreateInstruction },
                { FunctionOperations.FNADDR.OP, FunctionOperations.FNADDR.CreateInstruction },
                { FunctionOperations.CALLI.OP, FunctionOperations.CALLI.CreateInstruction },
                { (byte)0x10, VAR.CreateInstruction },
                { ArithmeticOperations.ADD.OP, ArithmeticOperations.ADD.CreateInstruction },
                { ArithmeticOperations.SUB.OP, ArithmeticOperations.SUB.CreateInstruction },
                { ArithmeticOperations.MUL.OP, ArithmeticOperations.MUL.CreateInstruction },
                { ArithmeticOperations.DIV.OP, ArithmeticOperations.DIV.CreateInstruction },
                { ArithmeticOperations.MOD.OP, ArithmeticOperations.MOD.CreateInstruction },
                { ArithmeticOperations.INC.OP, ArithmeticOperations.INC.CreateInstruction },
                { ArithmeticOperations.DEC.OP, ArithmeticOperations.DEC.CreateInstruction },
                { ArithmeticOperations.NEG.OP, ArithmeticOperations.NEG.CreateInstruction },
                { ArithmeticOperations.ABS.OP, ArithmeticOperations.ABS.CreateInstruction },
                { BitwiseOperations.AND.OP, BitwiseOperations.AND.CreateInstruction },
                { BitwiseOperations.OR.OP, BitwiseOperations.OR.CreateInstruction },
                { BitwiseOperations.XOR.OP, BitwiseOperations.XOR.CreateInstruction },
                { BitwiseOperations.NOT.OP, BitwiseOperations.NOT.CreateInstruction },
                { BitwiseOperations.SHL.OP, BitwiseOperations.SHL.CreateInstruction },
                { BitwiseOperations.SHR.OP, BitwiseOperations.SHR.CreateInstruction },
                { ComparisonOperations.EQ.OP, ComparisonOperations.EQ.CreateInstruction },
                { ComparisonOperations.NEQ.OP, ComparisonOperations.NEQ.CreateInstruction },
                { ComparisonOperations.LT.OP, ComparisonOperations.LT.CreateInstruction },
                { ComparisonOperations.LE.OP, ComparisonOperations.LE.CreateInstruction },
                { ComparisonOperations.GT.OP, ComparisonOperations.GT.CreateInstruction },
                { ComparisonOperations.GE.OP, ComparisonOperations.GE.CreateInstruction },
                { ArithmeticOperations.UDIV.OP, ArithmeticOperations.UDIV.CreateInstruction },
                { ArithmeticOperations.UMOD.OP, ArithmeticOperations.UMOD.CreateInstruction },
                { BitwiseOperations.LSHR.OP, BitwiseOperations.LSHR.CreateInstruction },
                { ComparisonOperations.ULT.OP, ComparisonOperations.ULT.CreateInstruction },
                { ComparisonOperations.ULE.OP, ComparisonOperations.ULE.CreateInstruction },
                { ComparisonOperations.UGT.OP, ComparisonOperations.UGT.CreateInstruction },
                { ComparisonOperations.UGE.OP, ComparisonOperations.UGE.CreateInstruction },
                { MemoryOperations.LOAD.OP, MemoryOperations.LOAD.CreateInstruction },
                { MemoryOperations.STORE.OP, MemoryOperations.STORE.CreateInstruction },
                { StackOperations.PUSH.OP, StackOperations.PUSH.CreateInstruction },
                { StackOperations.POP.OP, StackOperations.POP.CreateInstruction },
                { StackOperations.DUP.OP, StackOperations.DUP.CreateInstruction },
                { StackOperations.SWAP.OP, StackOperations.SWAP.CreateInstruction },
                { StackOperations.ROT.OP, StackOperations.ROT.CreateInstruction },
                { StackOperations.OVER.OP, StackOperations.OVER.CreateInstruction },
                { StackOperations.NIP.OP, StackOperations.NIP.CreateInstruction },
                { StackOperations.DROP.OP, StackOperations.DROP.CreateInstruction },
                { StackOperations.TwoDUP.OP, StackOperations.TwoDUP.CreateInstruction },
                { StackOperations.TwoSWAP.OP, StackOperations.TwoSWAP.CreateInstruction },
                { StackOperations.TwoROT.OP, StackOperations.TwoROT.CreateInstruction },
                { StackOperations.TwoOVER.OP, StackOperations.TwoOVER.CreateInstruction },
                { StackOperations.PICK.OP, StackOperations.PICK.CreateInstruction },
                { StackOperations.ROLL.OP, StackOperations.ROLL.CreateInstruction },
            };

        /// <summary>
        /// Creates the concrete <see cref="IOpCode"/> instance that represents the supplied <paramref name="opcode"/>.
        /// </summary>
        /// <param name="opcode">The raw <c>ValueType</c> identifying the instruction to instantiate.</param>
        /// <param name="variables">Array of variable‑reference fragments passed to the constructor of the instruction.</param>
        /// <param name="tokens">Full token stream for the instruction; used for diagnostics and location mapping.</param>
        /// <param name="operands">Optional trailing operands. For core op‑codes these are forwarded untouched; for extended op‑codes the first two operands are interpreted as <c>ExtensionGroup</c> and <c>ExtendedOpCode</c>.</param>
        /// <returns>The fully‑constructed <see cref="IOpCode"/> implementation.</returns>
        /// <exception cref="NotSupportedException">
        /// Thrown when:
        /// <list type="bullet">
        /// <item><description>The supplied <paramref name="opcode"/> is not recognised by the factory.</description></item>
        /// <item><description>The op‑code is <c>0xFF</c> (extended) but fewer than two operand bytes were provided.</description></item>
        /// </list>
        /// </exception>
        public static IOpCode Create(
            ValueType opcode,
            VariableExpressionFragment[] variables,
            SyntaxToken[] tokens,
            params ValueType[] operands)
        {
            // Fast path: standard opcode (≠ 0xFF)
            if ((byte)opcode != 0xFF)
            {
                if (_factory.TryGetValue(opcode, out var ctor))
                    return ctor(variables, tokens, operands);

                throw new NotSupportedException($"Opcode 0x{opcode:X2} is not supported.");
            }

            // Extended path: need at least 2 extra bytes
            if (operands.Length < 2)
                throw new NotSupportedException("Extended opcode requires ExtensionGroup + ExtendedOpCode bytes.");

            var extGroup = (byte)operands[0];
            var extOpCode = (byte)operands[1];
            var tail = operands.Length > 2 ? operands[2..] : [];

            return ExtendedOpcodeFactory.Create(extGroup, extOpCode, variables, tokens, tail);
        }
    }
}
