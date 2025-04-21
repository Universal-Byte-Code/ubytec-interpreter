using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public interface IOpCode
    {
        public byte OpCode { get; }
        public string Compile(CompilationScopes scopes);
    }
}
