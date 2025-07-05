using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct VAR(VariableExpressionFragment Variable) : IOpCode, IOpCodeFactory, IEquatable<VAR>
        {
            public readonly byte OpCode => 0x10;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (operands.Length > 0 || variables.Length > 1)
                    throw new SyntaxException(0x10BADBEEF, $"VAR opcode should not receive any operands, but received: {operands.Length}");

                var variable = variables.FirstOrDefault();

                return new VAR(variable);
            }

            public string Compile(CompilationScopes scopes) => ((IOpCode)this).Compile(scopes);

            string IUbytecEntity.Compile(CompilationScopes scopes) => _ = string.Empty;
        }
    }
}
