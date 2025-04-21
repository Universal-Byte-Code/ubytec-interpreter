using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct CONTINUE(int? LabelIDx) : IOpCode
        {
            public readonly byte OpCode => 0x08;

            public static CONTINUE CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (operands.Length == 0)
                    return new CONTINUE(null);

                if (operands.Length == 1 && operands[0] is int labelIdx)
                    return new CONTINUE(labelIdx);

                throw new SyntaxException(0x08BADBEEF, $"CONTINUE opcode received unexpected operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);

            string IOpCode.Compile(CompilationScopes scopes)
            {
                if (scopes.Count == 0)
                    throw new SyntaxStackException(0x08FACADE, "CONTINUE without a valid enclosing LOOP or WHILE block");

                scopes.PushContinue(this);

                var match = scopes.Find(ctx =>
                    ctx.StartLabel.StartsWith("while") || ctx.StartLabel.StartsWith("loop")) ?? throw new SyntaxStackException(0x08D00DFACE, "CONTINUE used outside of any loop or while block");
                var isWhile = match.StartLabel.StartsWith("while");
                var labelBase = isWhile ? "while" : "loop";

                return LabelIDx is int id
                    ? $"jmp {labelBase}_{id} ; CONTINUE to labeled {labelBase}"
                    : $"jmp {match.StartLabel} ; CONTINUE to {match.StartLabel}";
            }
        }
    }
}
