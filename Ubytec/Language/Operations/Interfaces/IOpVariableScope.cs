using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Operations.Interfaces
{
    public interface IOpVariableScope : IOpCode
    {
        public SyntaxExpression? Variables { get; init; }
    }
}
