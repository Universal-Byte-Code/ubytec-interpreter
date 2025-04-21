using System.Runtime.CompilerServices;
using System.Text.Json.Serialization;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.Fast.Metadata;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Model;

public sealed class SyntaxSentence : IUbytecSyntax, IDisposable
{
    [JsonInclude]
    public Stack<SyntaxNode> Nodes { get; set; } = new();

    [JsonInclude]
    public List<SyntaxSentence> Sentences { get; set; } = [];

    private MetadataRegistry _metadata = new(1);
    [JsonIgnore]
    public ref MetadataRegistry Metadata => ref _metadata;

    [JsonInclude]
    [JsonPropertyName("Metadata")]
    public Dictionary<string, object> SerializableMetadata => _metadata.ToImmutable().ToDictionary(kv => kv.Key, kv => kv.Value);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public SyntaxSentence() => _metadata.Add("guid", Guid.CreateVersion7());

    public IOpCode[] ScopeOpCodes()
    {
        var temp = new List<IOpCode>(Nodes.Count);
        foreach (var node in Nodes)
            if (node.Operation != null)
                temp.Add(node.Operation);
        return [.. temp];
    }

    public void Dispose() => _metadata.Dispose();
}
