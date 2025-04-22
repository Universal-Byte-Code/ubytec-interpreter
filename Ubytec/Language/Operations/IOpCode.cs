using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public interface IOpCode : IUbytecEntity
    {
        byte OpCode { get; }
    }
}
