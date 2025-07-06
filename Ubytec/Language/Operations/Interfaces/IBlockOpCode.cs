using Ubytec.Language.Syntax.Model;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations.Interfaces
{
    public interface IBlockOpCode : IOpVariableScope
    {
        public UType? BlockType { get; init; }
    }
}
