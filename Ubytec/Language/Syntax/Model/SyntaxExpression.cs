using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Fast.Metadata;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Model
{
    /// <summary>
    /// Represents a composed Ubytec expression, built from one or more
    /// <see cref="IUbytecExpressionFragment"/> instances (e.g. variable or condition fragments).
    /// </summary>
    [CLSCompliant(true)]
    public sealed class SyntaxExpression : IUbytecSyntax
    {
        /// <summary>
        /// Gets the ordered list of expression fragments that form this expression.
        /// </summary>
        [JsonInclude]
        public List<IUbytecExpressionFragment> Syntaxes { get; } = [];

        private MetadataRegistry _metadata = new(1);

        /// <inheritdoc/>
        [JsonIgnore]
        [CLSCompliant(false)]
        public ref MetadataRegistry Metadata => ref _metadata;

        /// <summary>
        /// Gets a JSON‐serializable snapshot of this expression's metadata,
        /// including the automatically generated GUID.
        /// </summary>
        [JsonInclude]
        [JsonPropertyName("Metadata")]
        public Dictionary<string, object> SerializableMetadata
            => _metadata.ToImmutable()
                        .ToDictionary(kv => kv.Key, kv => kv.Value);

        /// <summary>
        /// Initializes a new instance of the <see cref="SyntaxExpression"/> class
        /// from the provided fragments, and assigns it a unique GUID.
        /// </summary>
        /// <param name="syntaxes">
        /// One or more <see cref="IUbytecExpressionFragment"/> items (e.g.
        /// <see cref="VariableExpressionFragment"/>, <see cref="ConditionExpressionFragment"/>).
        /// </param>
        public SyntaxExpression(params IUbytecExpressionFragment[] syntaxes)
        {
            Syntaxes.AddRange(syntaxes);
            _metadata.Add("guid", Guid.CreateVersion7());
        }

        /// <summary>
        /// Releases resources used by this expression, disposing its metadata registry.
        /// </summary>
        public void Dispose()
        {
            _metadata.Dispose();
        }
    }
}
