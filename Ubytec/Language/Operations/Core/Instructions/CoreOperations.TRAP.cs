using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct TRAP : IOpCode, IOpCodeFactory
        {
            public const byte OP = 0x00;
            public readonly byte OpCode => OP;
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // TRAP no acepta operandos, ni variables, ni explicaciones.
                if (operands.Length > 0)
                    throw new SyntaxException(0x00BADBEEF, $"TRAP opcode should not receive any operands, but received: {operands.Length}");

                return new TRAP();
            }
            public string Compile(CompilationScopes scopes) => ((IOpCode)this).Compile(scopes);
            string IUbytecEntity.Compile(CompilationScopes scopes) => "ud2   ; TRAP";
        }
    }
}