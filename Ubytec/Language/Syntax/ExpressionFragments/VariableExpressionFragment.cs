using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Interfaces;
using Ubytec.Language.Syntax.Model;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Syntax.ExpressionFragments
{
    public readonly record struct VariableExpressionFragment(UType Type, string Name, object? Value) : IUbytecExpressionFragment
    {
        [JsonInclude]
        public required SyntaxToken[] Tokens { get; init; } = [];
    }
}
