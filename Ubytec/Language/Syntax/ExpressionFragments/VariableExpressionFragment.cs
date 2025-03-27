using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Interfaces;
using Ubytec.Language.Syntax.Syntaxes;
using static Ubytec.Language.Syntax.Enum.Primitives;

namespace Ubytec.Language.Syntax.ExpressionFragments
{
    public readonly record struct VariableExpressionFragment(PrimitiveType PrimitiveType, bool Nullable, string Name, object? Value) : IUbytecExpressionFragment
    {
        [JsonInclude]
        public required SyntaxToken[]? Tokens { get; init; }
    }
}
