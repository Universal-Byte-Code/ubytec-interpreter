using Ubytec.Language.Syntax.Syntaxes;

namespace Ubytec.Language.Syntax.Interfaces
{
    public interface IUbytecExpressionFragment
    {
        List<SyntaxToken>? Tokens { get; init; }
    }
}
