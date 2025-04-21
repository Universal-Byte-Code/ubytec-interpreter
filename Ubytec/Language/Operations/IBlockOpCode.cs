using Ubytec.Language.Syntax.Model;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public interface IBlockOpCode : IOpCode
    {
        public UbytecType? BlockType { get; init; }
        public SyntaxExpression? Variables { get; init; }
    }
}
