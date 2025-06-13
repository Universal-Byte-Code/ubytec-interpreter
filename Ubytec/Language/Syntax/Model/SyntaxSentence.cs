using System.Runtime.CompilerServices;
using System.Text.Json.Serialization;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.Fast.Metadata;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Model
{
    /// <summary>
    /// Represents a sentence (a sequence of syntax nodes) in the Ubytec AST,
    /// along with nested sentences and associated metadata.
    /// </summary>
    public sealed class SyntaxSentence : IUbytecSyntax
    {
        /// <summary>
        /// Gets or sets the stack of <see cref="SyntaxNode"/> instances that make up this sentence.
        /// </summary>
        [JsonInclude]
        public Stack<SyntaxNode> Nodes { get; set; } = new();

        /// <summary>
        /// Gets or sets any nested <see cref="SyntaxSentence"/> instances within this sentence.
        /// </summary>
        [JsonInclude]
        public List<SyntaxSentence> Sentences { get; set; } = [];

        private MetadataRegistry _metadata = new(1);

        /// <summary>
        /// Provides access to the metadata registry for this sentence.
        /// </summary>
        [JsonIgnore]
        public ref MetadataRegistry Metadata => ref _metadata;

        /// <summary>
        /// Gets a JSON-serializable dictionary representation of this sentence's metadata.
        /// </summary>
        [JsonInclude]
        [JsonPropertyName("Metadata")]
        public Dictionary<string, object> SerializableMetadata
            => _metadata.ToImmutable().ToDictionary(kv => kv.Key, kv => kv.Value);

        /// <summary>
        /// Initializes a new instance of the <see cref="SyntaxSentence"/> class
        /// and assigns it a unique GUID in its metadata.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public SyntaxSentence()
        {
            _metadata.Add("guid", Guid.CreateVersion7());
        }

        /// <summary>
        /// Extracts all operation codes (<see cref="IOpCode"/>) from the current sentence's nodes.
        /// </summary>
        /// <returns>
        /// An array of <see cref="IOpCode"/> instances found in <see cref="Nodes"/>.
        /// If no <see cref="IOpCode"/> is present in a node, it is skipped.
        /// </returns>
        public IOpCode[] ScopeOpCodes()
        {
            var temp = new List<IOpCode>(Nodes.Count);
            foreach (var node in Nodes)
            {
                if (node.Entity is IOpCode oc)
                    temp.Add(oc);
            }
            return [.. temp];
        }

        /// <summary>
        /// Releases resources used by this sentence, including its metadata registry.
        /// </summary>
        public void Dispose()
        {
            _metadata.Dispose();
        }
    }
}
