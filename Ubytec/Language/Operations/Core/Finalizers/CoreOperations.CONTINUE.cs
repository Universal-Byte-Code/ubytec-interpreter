using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct CONTINUE(int? LabelIDx) : IOpCode, IOpCodeFactory, IEquatable<CONTINUE>
        {
            public const byte OP = 0x08;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (operands.Length == 0)
                    return new CONTINUE(null);

                if (operands.Length == 1)
                    return new CONTINUE(StackCode.Index(nameof(CONTINUE), operands, int.MaxValue));

                throw new SyntaxException(0x08BADBEEF, $"CONTINUE opcode received unexpected operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                var target = TransferTarget(scopes, LabelIDx, true);
                return $"jmp {target.StartLabel} ; CONTINUE";
            }
        }
    }
}
