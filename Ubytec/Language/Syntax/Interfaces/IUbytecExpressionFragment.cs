using Ubytec.Language.Syntax.Syntaxes;

namespace Ubytec.Language.Syntax.Interfaces
{
    public interface IUbytecExpressionFragment
    {
        SyntaxToken[]? Tokens { get; init; }
    }
}
