using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Operations
{
    public static class OpcodeFactory
    {
        private static readonly Dictionary<byte, Func<VariableExpressionFragment[], SyntaxToken[], ValueType[], IOpCode>> _factory =
            new()
            {
                { 0x00, (vars, tokens, ops) => CoreOperations.TRAP.CreateInstruction(vars, tokens, ops) },
                { 0x01, (vars, tokens, ops) => CoreOperations.NOP.CreateInstruction(vars, tokens, ops) },
                { 0x02, (vars, tokens, ops) => CoreOperations.BLOCK.CreateInstruction(vars, tokens, ops) },
                { 0x03, (vars, tokens, ops) => CoreOperations.LOOP.CreateInstruction(vars, tokens, ops) },
                { 0x04, (vars, tokens, ops) => CoreOperations.IF.CreateInstruction(vars, tokens, ops) },
                { 0x05, (vars, tokens, ops) => CoreOperations.ELSE.CreateInstruction(vars, tokens, ops) },
                { 0x06, (vars, tokens, ops) => CoreOperations.END.CreateInstruction(vars, tokens, ops) },
                { 0x07, (vars, tokens, ops) => CoreOperations.BREAK.CreateInstruction(vars, tokens, ops) },
                { 0x08, (vars, tokens, ops) => CoreOperations.CONTINUE.CreateInstruction(vars, tokens, ops) },
                { 0x09, (vars, tokens, ops) => CoreOperations.RETURN.CreateInstruction(vars, tokens, ops) },
                { 0x0A, (vars, tokens, ops) => CoreOperations.BRANCH.CreateInstruction(vars, tokens, ops) },
                { 0x0B, (vars, tokens, ops) => CoreOperations.SWITCH.CreateInstruction(vars, tokens, ops) },
                { 0x0C, (vars, tokens, ops) => CoreOperations.WHILE.CreateInstruction(vars, tokens, ops) },
                { 0x0D, (vars, tokens, ops) => CoreOperations.CLEAR.CreateInstruction(vars, tokens, ops) },
                { 0x0E, (vars, tokens, ops) => CoreOperations.DEFAULT.CreateInstruction(vars, tokens, ops) },
                { 0x0F, (vars, tokens, ops) => CoreOperations.NULL.CreateInstruction(vars, tokens, ops) }
            };

        public static IOpCode Create(byte opcode, VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
        {
            if (_factory.TryGetValue(opcode, out var constructor))
                return constructor(variables, tokens, operands);

            throw new NotSupportedException($"Opcode 0x{opcode:X2} is not supported.");
        }
    }
}
