using System.Reflection;
using System.Text;
using System.Text.Json.Serialization;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.Fast.Metadata;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Model
{
    /// <summary>
    /// Represents the root of a Ubytec abstract syntax tree (AST),
    /// holding the top-level sentence and associated metadata.
    /// </summary>
    [CLSCompliant(true)]
    public sealed class SyntaxTree : IUbytecSyntax
    {
        /// <summary>
        /// Gets or sets the root sentence of this syntax tree.
        /// </summary>
        [JsonInclude]
        public SyntaxSentence RootSentence { get; set; }

        private MetadataRegistry _metadata = new(3);

        /// <summary>
        /// Provides access to the underlying <see cref="MetadataRegistry"/> by reference
        /// for efficient metadata operations.
        /// </summary>
        [JsonIgnore]
        [CLSCompliant(false)]
        public ref MetadataRegistry Metadata => ref _metadata;

        /// <summary>
        /// Gets a JSON-serializable dictionary representation of the tree's metadata.
        /// </summary>
        [JsonInclude]
        [JsonPropertyName("Metadata")]
        public Dictionary<string, object> SerializableMetadata
            => _metadata
               .ToImmutable()
               .ToDictionary(kv => kv.Key, kv => kv.Value);

        /// <summary>
        /// Internal stack used during tree traversal or construction.
        /// </summary>
        internal Stack<SyntaxSentence> TreeSentenceStack { get; set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="SyntaxTree"/> class
        /// with the specified root sentence, setting up metadata and traversal stack.
        /// </summary>
        /// <param name="root">
        /// The root <see cref="SyntaxSentence"/> to start this syntax tree.
        /// </param>
        /// <exception cref="LanguageVersionException">
        /// Thrown if the assembly metadata cannot be retrieved.
        /// </exception>
        public SyntaxTree(SyntaxSentence root)
        {
            RootSentence = root;
            TreeSentenceStack = new Stack<SyntaxSentence>();
            TreeSentenceStack.Push(root);

            // Initialize core metadata
            _metadata.Add("guid", Guid.CreateVersion7());
            _metadata.Add("encoding", Encoding.GetEncoding(0).EncodingName);

            // Retrieve assembly version for language version metadata
            var languageAssembly = Assembly.GetAssembly(typeof(SyntaxTree))
                ?? throw new LanguageVersionException(0xEBFE1914569FDD2F, "Null assembly version");

            _metadata.Add("langver", languageAssembly.GetName().Version!);

            // Mark the root sentence type
            RootSentence.Metadata.Add("type", "root");
        }

        /// <summary>
        /// Releases all resources used by the syntax tree, including metadata registry and sentences.
        /// </summary>
        public void Dispose()
        {
            _metadata.Dispose();
            RootSentence.Dispose();
        }
    }
}
