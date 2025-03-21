using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Interfaces;
using Ubytec.Language.Syntax.Syntaxes;

namespace Ubytec.Language.Syntax.ExpressionFragments
{
    public readonly record struct ConditionExpressionFragment(object? Left, string? Operand, object? Right) : IUbytecExpressionFragment
    {
        [JsonInclude]
        public List<SyntaxToken>? Tokens { get; init; } = null;
    }
}
