using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language
{
    public interface IUbytecEntity
    {
        string Compile(CompilationScopes scopes);
    }
}