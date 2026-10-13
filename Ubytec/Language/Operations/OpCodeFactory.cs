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
    /// Core opcodes use one byte in <c>0x00..0xFE</c>. <c>0xFF</c> is a recursive escape:
    /// one or more consecutive escape bytes are followed by an ExtensionGroup and ExtendedOpCode.
    /// </para>
    /// </summary>
    public static class OpcodeFactory
    {
        /// <summary>
        /// Maps a core <c>ValueType</c> op-code to its delegate constructor.
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
        /// Creates the concrete <see cref="IOpCode"/> represented by the supplied opcode and operands.
        /// </summary>
        /// <remarks>
        /// For a core opcode, operands are forwarded unchanged. For an extended opcode the caller supplies
        /// the first <c>0xFF</c> as <paramref name="opcode"/>. Any immediately following <c>0xFF</c> operands
        /// increase the escape depth. The next two bytes are ExtensionGroup and ExtendedOpCode.
        /// </remarks>
        public static IOpCode Create(
            ValueType opcode,
            VariableExpressionFragment[] variables,
            SyntaxToken[] tokens,
            params ValueType[] operands)
        {
            // Fast path: standard opcode (0x00..0xFE).
            if ((byte)opcode != OpcodeId.ESCAPE)
            {
                if (_factory.TryGetValue(opcode, out var ctor))
                    return ctor(variables, tokens, operands);

                throw new NotSupportedException($"Opcode 0x{opcode:X2} is not supported.");
            }

            int escapeDepth = 1;
            int cursor = 0;

            // The initial 0xFF is supplied as opcode. Additional consecutive 0xFF bytes
            // in the operand stream recursively select deeper namespaces.
            while (cursor < operands.Length && operands[cursor] is byte next && next == OpcodeId.ESCAPE)
            {
                escapeDepth++;
                cursor++;
                if (escapeDepth > ExtendedOpcodeFactory.MAX_SUPPORTED_ESCAPE_DEPTH)
                    throw new NotSupportedException(
                        $"Escape depth {escapeDepth} exceeds this runtime's supported maximum of {ExtendedOpcodeFactory.MAX_SUPPORTED_ESCAPE_DEPTH}.");
            }

            if (operands.Length - cursor < 2)
                throw new NotSupportedException(
                    $"Incomplete extended opcode prefix at escape depth {escapeDepth}; ExtensionGroup + ExtendedOpCode are required.");

            byte extGroup = RequireByte(operands[cursor], "ExtensionGroup");
            byte extOpCode = RequireByte(operands[cursor + 1], "ExtendedOpCode");
            if (extGroup == OpcodeId.ESCAPE || extOpCode == OpcodeId.ESCAPE)
                throw new NotSupportedException("0xFF is reserved for recursive opcode escaping and cannot be allocated as an extension group or extended opcode.");

            var tail = operands.Length > cursor + 2 ? operands[(cursor + 2)..] : [];
            return ExtendedOpcodeFactory.Create(escapeDepth, extGroup, extOpCode, variables, tokens, tail);
        }

        private static byte RequireByte(ValueType value, string role) => value is byte result
            ? result
            : throw new NotSupportedException($"{role} must be encoded as a byte.");
    }
}
