using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct BREAK(int? LabelIDx) : IOpCode
        {
            public readonly byte OpCode => 0x07;

            public static BREAK CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (operands.Length == 0)
                    return new BREAK(null);

                if (operands.Length == 1 && operands[0] is int labelIdx)
                    return new BREAK(labelIdx);

                throw new SyntaxException(0x07BADBEEF, $"BREAK opcode received unexpected operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);

            string IOpCode.Compile(CompilationScopes scopes)
            {
                if (scopes.Count == 0)
                    throw new SyntaxStackException(0x07FACADE, "BREAK used outside of any valid block or loop context");

                scopes.PushBreak(this);

                var match = scopes.Find(ctx =>
                    ctx.StartLabel.StartsWith("while") ||
                    ctx.StartLabel.StartsWith("loop") ||
                    ctx.StartLabel.StartsWith("branch")) ??
                    throw new SyntaxStackException(0x07D00DFACE, "BREAK could not find a valid target block");

                if (match.StartLabel.StartsWith("branch"))
                {
                    // Pop el contexto del branch (lo cerramos manualmente aquí)
                    var popped = scopes.TryPopUntil(ctx => ctx == match)
                        ?? throw new SyntaxStackException(0x07E0FFFACE, "Could not pop branch context");

                    string jmpLabel = LabelIDx is int
                        ? $"end_branch_{LabelIDx}"
                        : popped.EndLabel;

                    return $"{popped.EndLabel}: ; END of {popped.StartLabel}";
                }

                string labelBase = match.StartLabel.StartsWith("while") ? "whileEnd" : "loopEnd";

                return LabelIDx is int
                    ? $"jmp {labelBase}_{LabelIDx} ; BREAK to labeled {labelBase}"
                    : $"jmp {match.EndLabel} ; BREAK from {labelBase}";
            }
        }
    }
}
