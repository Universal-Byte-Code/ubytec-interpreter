using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Operations
{
    public interface IOpInheritance : IOpCode
    {
        public SyntaxExpression? Variables { get; init; }
    }
}
