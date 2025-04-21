using System.Collections.Immutable;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Fast.Metadata;
using Ubytec.Language.Syntax.Interfaces;
using Ubytec.Language.Tools.Serialization;

namespace Ubytec.Language.Syntax.Model;

/// <summary>
/// Represents a lexical token identified during Ubytec source code analysis.
/// Contains information about its source content, position, semantic scopes, and metadata.
/// </summary>
/// <param name="source">The string content of the token.</param>
/// <param name="line">The line number where the token was found.</param>
/// <param name="startColumn">The starting column index of the token within the line.</param>
/// <param name="endColumn">The ending column index of the token within the line.</param>
/// <param name="scopes">An immutable array of semantic scopes associated with the token.</param>
[StructLayout(LayoutKind.Auto)]
[SkipLocalsInit]
public sealed class SyntaxToken
    : IEquatable<SyntaxToken>, IDisposable, IUbytecSyntax
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
    /// Optional metadata associated with the token. By default, includes a GUID (version 7).
    /// </summary>
    [JsonIgnore]
    ref MetadataRegistry IUbytecSyntax.Metadata => ref _metadata;

    [JsonInclude]
    [JsonPropertyName("Metadata")]
    public Dictionary<string, object> SerializableMetadata => _metadata.ToImmutable().ToDictionary(kv => kv.Key, kv => kv.Value);


    [method: MethodImpl(MethodImplOptions.AggressiveInlining)]
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
    /// Returns a human-readable representation of the token.
    /// </summary>
    /// <returns>A string describing the token content, line, column range, and scopes.</returns>
    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public override string ToString()
        => $"{Source} ({Line}:{StartColumn}-{EndColumn}) [{string.Join(", ", Scopes)}]";

    /// <summary>
    /// Checks whether the current token is equal to another <see cref="SyntaxToken"/>, including scopes.
    /// Uses unsafe access for performance.
    /// </summary>
    /// <param name="other">The token to compare with.</param>
    /// <returns><c>true</c> if tokens are equal; otherwise, <c>false</c>.</returns>
    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public bool Equals(SyntaxToken? other)
    {
        if (Line != other?.Line ||
            StartColumn != other.StartColumn ||
            EndColumn != other.EndColumn ||
            Source != other.Source ||
            Scopes.Length != other.Scopes.Length)
            return false;

        unsafe
        {
            ref string leftRef = ref MemoryMarshal.GetReference(Scopes.AsSpan());
            ref string rightRef = ref MemoryMarshal.GetReference(other.Scopes.AsSpan());
            for (int i = 0; i < Scopes.Length; i++)
                if (!Unsafe.Add(ref leftRef, i).Equals(Unsafe.Add(ref rightRef, i)))
                    return false;
        }

        return true;
    }

    /// <summary>
    /// Determines whether the specified object is equal to the current token.
    /// </summary>
    /// <param name="obj">The object to compare.</param>
    /// <returns><c>true</c> if equal; otherwise, <c>false</c>.</returns>
    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public override bool Equals(object? obj)
        => obj is SyntaxToken other && Equals(other);

    /// <summary>
    /// Returns a hash code for this token, combining source, position and a subset of scopes.
    /// Uses <c>Unsafe.Add</c> for fast scope access.
    /// </summary>
    /// <returns>The hash code of the token.</returns>
    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public override int GetHashCode()
    {
        var hash = HashCode.Combine(Source, Line, StartColumn, EndColumn, Scopes.Length);

        unsafe
        {
            ref string start = ref MemoryMarshal.GetArrayDataReference(Scopes.ToArray());
            for (int i = 0; i < Scopes.Length; i++)
                hash = HashCode.Combine(hash, Unsafe.Add(ref start, i));
        }

        return hash;
    }

    public void Dispose()
    {
        GC.SuppressFinalize(this);
        ((IDisposable)_metadata).Dispose();
    }

    /// <summary>
    /// Determines whether two tokens are equal.
    /// </summary>
    public static bool operator ==(SyntaxToken left, SyntaxToken right) => left.Equals(right);

    /// <summary>
    /// Determines whether two tokens are not equal.
    /// </summary>
    public static bool operator !=(SyntaxToken left, SyntaxToken right) => !left.Equals(right);
}