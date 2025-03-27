using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Syntaxes;

namespace Ubytec.Language.Operations
{
    public interface IBlockOpCode : IOpCode
    {
        public SyntaxExpression? Variables { get; init; }
    }
}
