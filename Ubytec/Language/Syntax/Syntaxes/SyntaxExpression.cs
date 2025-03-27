using System.Collections;
using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Syntaxes
{
    public readonly record struct SyntaxExpression : IUbytecSyntax
    {
        public readonly List<IUbytecExpressionFragment> Syntaxes { get; } = [];
        public readonly Dictionary<string, object> Metadata { get; } = [];

        public SyntaxExpression(params IUbytecExpressionFragment[] syntaxes)
        {
            Syntaxes.AddRange(syntaxes);
            Metadata.Add("guid", Guid.CreateVersion7());
        }
    }
}
