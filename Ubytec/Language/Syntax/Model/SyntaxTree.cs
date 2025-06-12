using System.Reflection;
using System.Text;
using System.Text.Json.Serialization;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.Fast.Metadata;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Model;

public sealed class SyntaxTree : IUbytecSyntax
{
    [JsonInclude]
    public SyntaxSentence RootSentence { get; set; }

    private MetadataRegistry _metadata = new(3);

    [JsonIgnore]
    public ref MetadataRegistry Metadata => ref _metadata;

    [JsonInclude]
    [JsonPropertyName("Metadata")]
    public Dictionary<string, object> SerializableMetadata => _metadata.ToImmutable().ToDictionary(kv => kv.Key, kv => kv.Value);

    internal Stack<SyntaxSentence> TreeSentenceStack { get; set; }

    public SyntaxTree(SyntaxSentence root)
    {
        RootSentence = root;
        TreeSentenceStack = new Stack<SyntaxSentence>();
        TreeSentenceStack.Push(root);

        _metadata.Add("guid", Guid.CreateVersion7());
        _metadata.Add("encoding", Encoding.GetEncoding(0).EncodingName);

        var languageAssembly = Assembly.GetAssembly(typeof(SyntaxTree))
            ?? throw new LanguageVersionException(0xEBFE1914569FDD2F, "Null assembly version");

        _metadata.Add("langver", languageAssembly.GetName().Version!);
        RootSentence.Metadata.Add("type", "root");
    }

    public void Dispose()
    {
        _metadata.Dispose();
        RootSentence.Dispose();
    }
}
