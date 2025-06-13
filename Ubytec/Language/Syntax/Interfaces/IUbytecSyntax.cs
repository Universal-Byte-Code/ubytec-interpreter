using Ubytec.Language.Syntax.Fast.Metadata;

namespace Ubytec.Language.Syntax.Interfaces
{
    /// <summary>
    /// Defines a Ubytec syntax element that holds and exposes metadata,
    /// and supports cleanup of resources.
    /// </summary>
    public interface IUbytecSyntax : IDisposable
    {
        /// <summary>
        /// Gets a reference to the <see cref="MetadataRegistry"/> for this syntax element,
        /// allowing addition and retrieval of metadata entries.
        /// </summary>
        public ref MetadataRegistry Metadata { get; }
    }
}
