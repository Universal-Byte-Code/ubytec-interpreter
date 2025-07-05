using Ubytec.Language.Operations.Extended;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Operations
{
    public static class OpcodeFactory
    {
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
                { NULL.OP, NULL.CreateInstruction }
            };

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
            var tail = operands.Length > 2 ? operands[2..] : Array.Empty<ValueType>();

            return ExtendedOpcodeFactory.Create(extGroup, extOpCode, variables, tokens, tail);
        }
    }
}
