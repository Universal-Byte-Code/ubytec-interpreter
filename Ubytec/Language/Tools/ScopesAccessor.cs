using System.Collections.Immutable;
using System.Diagnostics;
using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Tools
{
    /// <summary>
    /// Represents a strongly typed accessor for the semantic scopes of a <see cref="SyntaxToken"/>.
    /// </summary>
    public readonly record struct ScopesAccessor
    {
        private readonly SyntaxToken _token;
        private readonly SyntaxTokenScopeHelper _helper;

        /// <summary>
        /// Initializes a new instance of the <see cref="ScopesAccessor"/> struct with the specified token.
        /// </summary>
        /// <param name="token"></param>
        public ScopesAccessor(SyntaxToken token) 
        {
            _token = token;
            _helper = new(_token);
        }
        /// <summary>
        /// Gets the semantic scopes of the token.
        /// </summary>
        public ImmutableArray<string> DataSource { get; init; }

        /// <summary>
        /// Provides a helper for accessing the token's scopes relevant information in a strongly typed manner.
        /// </summary>
        [JsonIgnore]
        public SyntaxTokenScopeHelper Helper => _helper;

        /// <summary>
        /// Gets the number of elements in the array.
        /// </summary>
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        public int Length => DataSource.Length;

        /// <inheritdoc/>
        public override string ToString() => nameof(ScopesAccessor);
    }
}
