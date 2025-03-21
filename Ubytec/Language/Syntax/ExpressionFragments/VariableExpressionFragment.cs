using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Interfaces;
using Ubytec.Language.Syntax.Syntaxes;
using static Ubytec.Language.Syntax.Enum.Primitives;

namespace Ubytec.Language.Syntax.ExpressionFragments
{
    public readonly record struct VariableExpressionFragment(PrimitiveType BlockType, bool Nullable, string Name, object? Value, SyntaxToken[] SyntaxTokens) : IUbytecExpressionFragment
    {
        [JsonInclude]
        public List<SyntaxToken>? Tokens { get; init; } = null;
    }
}
