using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct NOP : IOpCode
        {
            public readonly byte OpCode => 0x01;

            public static NOP CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // NOP no debe recibir operandos, ni variables
                if (operands.Length > 0)
                    throw new SyntaxException(0x01BADBEEF, $"NOP opcode should not receive any operands, but received: {operands.Length}");

                return new NOP();
            }


            public string Compile(CompilationScopes scopes) => ((IOpCode)this).Compile(scopes);
            string IUbytecEntity.Compile(CompilationScopes scopes) => "nop   ; NOP";
        }
    }
}