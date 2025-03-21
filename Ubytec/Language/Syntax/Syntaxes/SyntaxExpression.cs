using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Syntaxes
{
    public readonly record struct SyntaxExpression : IUbytecSyntax
    {
        public readonly IUbytecExpressionFragment[] Syntaxes { get; private init; }
        public Dictionary<string, object> Metadata { get; } = [];

        public SyntaxExpression(params IUbytecExpressionFragment[] syntaxes)
        {
            Syntaxes=syntaxes;
            Metadata.Add("guid", Guid.CreateVersion7());
        }
    }
}
