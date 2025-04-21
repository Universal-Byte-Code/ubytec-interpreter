using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Syntax.Interfaces
{
    public interface IUbytecExpressionFragment
    {
        SyntaxToken[] Tokens { get; init; }
    }
}
