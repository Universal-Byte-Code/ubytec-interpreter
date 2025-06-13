using System.Text.Json.Serialization;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.Fast.Metadata;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Model
{
    /// <summary>
    /// Represents a node in the Ubytec abstract syntax tree,
    /// holding an entity (opcode or context), optional child nodes, tokens, and metadata.
    /// </summary>
    public sealed class SyntaxNode : IUbytecSyntax
    {
        /// <summary>
        /// Gets the Ubytec entity associated with this node.
        /// May be an <see cref="IOpCode"/> or a <see cref="IUbytecContextEntity"/>.
        /// </summary>
        [JsonInclude]
        public IUbytecEntity? Entity { get; init; }

        /// <summary>
        /// Gets the list of child <see cref="SyntaxNode"/> instances, if any.
        /// </summary>
        [JsonInclude]
        public List<SyntaxNode>? Children { get; init; }

        /// <summary>
        /// Gets the list of <see cref="SyntaxToken"/> instances associated with this node, if any.
        /// </summary>
        [JsonInclude]
        public List<SyntaxToken>? Tokens { get; init; }

        private MetadataRegistry _metadata = new(1);

        /// <inheritdoc/>
        [JsonIgnore]
        public ref MetadataRegistry Metadata => ref _metadata;

        /// <summary>
        /// Gets a JSON-serializable dictionary of this node’s metadata.
        /// </summary>
        [JsonInclude]
        [JsonPropertyName("Metadata")]
        public Dictionary<string, object> SerializableMetadata
            => _metadata.ToImmutable()
                        .ToDictionary(kv => kv.Key, kv => kv.Value);

        /// <summary>
        /// Initializes a new <see cref="SyntaxNode"/> with the specified opcode entity.
        /// </summary>
        /// <param name="operation">The <see cref="IOpCode"/> to assign to this node.</param>
        public SyntaxNode(IOpCode? operation)
        {
            Entity   = operation;
            Children = null;
            Tokens   = null;
            _metadata.Add("guid", Guid.CreateVersion7());
        }

        /// <summary>
        /// Initializes a new <see cref="SyntaxNode"/> with the specified high-level context entity.
        /// </summary>
        /// <param name="entity">The <see cref="IUbytecContextEntity"/> to assign to this node.</param>
        public SyntaxNode(IUbytecContextEntity? entity)
        {
            Entity   = entity;
            Children = null;
            Tokens   = null;
            _metadata.Add("guid", Guid.CreateVersion7());
        }

        /// <summary>
        /// Extracts all <see cref="IOpCode"/> instances from this node’s children.
        /// </summary>
        /// <returns>
        /// An array of <see cref="IOpCode"/> found in <see cref="Children"/>,
        /// or an empty array if there are none.
        /// </returns>
        public IOpCode[] ScopeOpCodes()
        {
            var temp = new List<IOpCode>();
            foreach (var child in Children ?? [])
                if (child.Entity is IOpCode oc)
                    temp.Add(oc);
            return [.. temp];
        }

        /// <summary>
        /// Extracts all <see cref="SyntaxToken"/> instances from this node.
        /// </summary>
        /// <returns>
        /// An array of <see cref="SyntaxToken"/> from <see cref="Tokens"/>,
        /// or an empty array if there are none.
        /// </returns>
        public SyntaxToken[] ScopeTokens()
        {
            var temp = new List<SyntaxToken>();
            foreach (var token in Tokens ?? [])
                temp.Add(token);
            return [.. temp];
        }

        /// <summary>
        /// Gets a value indicating whether the node’s entity is a high-level context construct.
        /// </summary>
        public bool IsHighLevel => Entity is IUbytecHighLevelEntity;

        /// <summary>
        /// Gets a value indicating whether the node’s entity is a low-level opcode.
        /// </summary>
        public bool IsOpCode => Entity is IOpCode;

        /// <summary>
        /// Releases resources held by this node, including its metadata registry.
        /// </summary>
        public void Dispose() => _metadata.Dispose();
    }
}
