using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct BREAK(int? LabelIDx) : IOpCode, IOpCodeFactory, IEquatable<BREAK>
        {
            public const byte OP = 0x07;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (operands.Length == 0)
                    return new BREAK(null);

                if (operands.Length == 1)
                    return new BREAK(StackCode.Index(nameof(BREAK), operands, int.MaxValue));

                throw new SyntaxException(0x07BADBEEF, $"BREAK opcode received unexpected operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                var target = TransferTarget(scopes, LabelIDx, false);
                return $"jmp {target.EndLabel} ; BREAK";
            }
        }
    }
}
