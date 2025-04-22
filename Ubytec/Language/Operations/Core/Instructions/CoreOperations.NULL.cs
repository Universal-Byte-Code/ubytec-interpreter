
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct NULL : IOpCode
        {
            public readonly byte OpCode => 0x0F;

            public static NULL CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // NULL no acepta operandos ni variables
                if (operands.Length > 0)
                    throw new SyntaxException(0x0FBADBEEF, $"NULL opcode should not receive any operands, but received: {operands.Length}");

                return new NULL();
            }

            public string Compile(CompilationScopes scopes) => ((IOpCode)this).Compile(scopes);

            string IUbytecEntity.Compile(CompilationScopes scopes) => "xor rax, rax   ; NULL = 0\n  push rax";
        }
    }
}