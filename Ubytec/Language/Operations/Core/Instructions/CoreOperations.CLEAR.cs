using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct CLEAR : IOpCode, IOpCodeFactory, IEquatable<CLEAR>
        {
            public const byte OP = 0x0D;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // CLEAR no acepta ningún operando
                if (operands.Length > 0)
                    throw new SyntaxException(0x0DBADBEEF, $"CLEAR opcode should not receive any operands, but received: {operands.Length}");

                return new CLEAR();
            }

            public string Compile(CompilationScopes scopes) => ((IOpCode)this).Compile(scopes);
            string IUbytecEntity.Compile(CompilationScopes scopes) => "mov rsp, rbp   ; CLEAR - Reset stack pointer to base pointer\n  ; Stack is now empty";
        }
    }
}