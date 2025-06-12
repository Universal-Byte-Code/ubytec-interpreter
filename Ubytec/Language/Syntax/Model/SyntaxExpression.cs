using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Fast.Metadata;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Model;

public sealed class SyntaxExpression : IUbytecSyntax
{
    public List<IUbytecExpressionFragment> Syntaxes { get; } = [];

    private MetadataRegistry _metadata = new(1);

    [JsonIgnore]
    public ref MetadataRegistry Metadata => ref _metadata;

    [JsonInclude]
    [JsonPropertyName("Metadata")]
    public Dictionary<string, object> SerializableMetadata => _metadata.ToImmutable().ToDictionary(kv => kv.Key, kv => kv.Value);

    public SyntaxExpression(params IUbytecExpressionFragment[] syntaxes)
    {
        Syntaxes.AddRange(syntaxes);
        _metadata.Add("guid", Guid.CreateVersion7());
    }

    public void Dispose() => _metadata.Dispose();
}
