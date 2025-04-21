using Ubytec.Language.Syntax.Fast.Metadata;

namespace Ubytec.Language.Syntax.Interfaces
{
    public interface IUbytecSyntax
    {
        public ref MetadataRegistry Metadata { get; }
    }
}