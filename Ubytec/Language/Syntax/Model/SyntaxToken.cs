using System.Collections.Immutable;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Fast.Metadata;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Model
{
    /// <summary>
    /// Represents a lexical token identified during Ubytec source code analysis.
    /// Contains information about its text, position, semantic scopes, and metadata.
    /// </summary>
    [StructLayout(LayoutKind.Auto)]
    [SkipLocalsInit]
    public sealed class SyntaxToken : IEquatable<SyntaxToken>, IUbytecSyntax
    {
        /// <summary>
        /// Gets the raw string content of the token.
        /// </summary>
        public string Source { get; init; }

        /// <summary>
        /// Gets the zero-based line number where the token is located.
        /// </summary>
        public int Line { get; init; }

        /// <summary>
        /// Gets the starting column index (inclusive) of the token in the line.
        /// </summary>
        public int StartColumn { get; init; }

        /// <summary>
        /// Gets the ending column index (exclusive) of the token in the line.
        /// </summary>
        public int EndColumn { get; init; }

        /// <summary>
        /// Gets the immutable list of semantic scopes (e.g., keyword, identifier, comment) assigned to the token.
        /// </summary>
        public ImmutableArray<string> Scopes { get; init; }

        private MetadataRegistry _metadata = new(1);

        /// <summary>
        /// Provides access to the metadata registry by reference for performance.
        /// </summary>
        [JsonIgnore]
        ref MetadataRegistry IUbytecSyntax.Metadata => ref _metadata;

        /// <summary>
        /// Gets a serializable dictionary representation of this token's metadata.
        /// </summary>
        [JsonInclude]
        [JsonPropertyName("Metadata")]
        public Dictionary<string, object> SerializableMetadata
            => _metadata.ToImmutable().ToDictionary(kv => kv.Key, kv => kv.Value);

        /// <summary>
        /// Initializes a new instance of the <see cref="SyntaxToken"/> class with the specified properties.
        /// </summary>
        /// <param name="source">The text content of the token.</param>
        /// <param name="line">The line number where the token was found.</param>
        /// <param name="startColumn">The starting column index of the token.</param>
        /// <param name="endColumn">The ending column index of the token.</param>
        /// <param name="scopes">The semantic scopes assigned to the token.</param>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public SyntaxToken(string source, int line, int startColumn, int endColumn, ImmutableArray<string> scopes)
        {
            Source = source;
            Line = line;
            StartColumn = startColumn;
            EndColumn = endColumn;
            Scopes = scopes;

            _metadata.Add("guid", Guid.CreateVersion7());
        }

        /// <summary>
        /// Returns a human-readable representation of the token, including position and scopes.
        /// </summary>
        /// <returns>A string in the format "Source (line:start-end) [scope1, scope2,...]".</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override string ToString()
            => $"{Source} ({Line}:{StartColumn}-{EndColumn}) [{string.Join(", ", Scopes)}]";

        /// <summary>
        /// Determines whether this token is equal to another <see cref="SyntaxToken"/>,
        /// comparing source, position, and all scopes using unsafe access for speed.
        /// </summary>
        /// <param name="other">The token to compare with.</param>
        /// <returns><c>true</c> if both tokens are equal; otherwise, <c>false</c>.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public bool Equals(SyntaxToken? other)
        {
            if (other is null ||
                Line != other.Line ||
                StartColumn != other.StartColumn ||
                EndColumn != other.EndColumn ||
                Source != other.Source ||
                Scopes.Length != other.Scopes.Length)
            {
                return false;
            }

            unsafe
            {
                ref string leftRef = ref MemoryMarshal.GetReference(Scopes.AsSpan());
                ref string rightRef = ref MemoryMarshal.GetReference(other.Scopes.AsSpan());
                for (int i = 0; i < Scopes.Length; i++)
                {
                    if (!Unsafe.Add(ref leftRef, i).Equals(Unsafe.Add(ref rightRef, i)))
                        return false;
                }
            }

            return true;
        }

        /// <summary>
        /// Determines whether the specified object is equal to the current token.
        /// </summary>
        /// <param name="obj">The object to compare with.</param>
        /// <returns><c>true</c> if the specified object is a <see cref="SyntaxToken"/> equal to this one; otherwise, <c>false</c>.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override bool Equals(object? obj)
            => obj is SyntaxToken other && Equals(other);

        /// <summary>
        /// Returns a hash code for this token, combining source, position, and scopes using fast scope access.
        /// </summary>
        /// <returns>An integer hash code for this instance.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override int GetHashCode()
        {
            var hash = HashCode.Combine(Source, Line, StartColumn, EndColumn, Scopes.Length);
            unsafe
            {
                ref string start = ref MemoryMarshal.GetArrayDataReference(Scopes.ToArray());
                for (int i = 0; i < Scopes.Length; i++)
                {
                    hash = HashCode.Combine(hash, Unsafe.Add(ref start, i));
                }
            }
            return hash;
        }

        /// <summary>
        /// Releases resources used by this token, disposing its metadata registry.
        /// </summary>
        public void Dispose()
        {
            GC.SuppressFinalize(this);
            ((IDisposable)_metadata).Dispose();
        }

        /// <summary>
        /// Determines whether two <see cref="SyntaxToken"/> instances are equal.
        /// </summary>
        /// <param name="left">The left-hand token.</param>
        /// <param name="right">The right-hand token.</param>
        /// <returns><c>true</c> if both tokens are equal; otherwise, <c>false</c>.</returns>
        public static bool operator ==(SyntaxToken left, SyntaxToken right) => left.Equals(right);

        /// <summary>
        /// Determines whether two <see cref="SyntaxToken"/> instances are not equal.
        /// </summary>
        /// <param name="left">The left-hand token.</param>
        /// <param name="right">The right-hand token.</param>
        /// <returns><c>true</c> if the tokens differ; otherwise, <c>false</c>.</returns>
        public static bool operator !=(SyntaxToken left, SyntaxToken right) => !left.Equals(right);
    }
}
