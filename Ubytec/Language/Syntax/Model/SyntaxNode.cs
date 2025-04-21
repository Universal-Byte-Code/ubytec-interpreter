using System.Text.Json.Serialization;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.Fast.Metadata;
using Ubytec.Language.Syntax.Interfaces;
using Ubytec.Language.Syntax.TypeSystem;

namespace Ubytec.Language.Syntax.Model;

public sealed class SyntaxNode : IUbytecSyntax, IDisposable
{
    [JsonInclude]
    public IOpCode? Operation { get; init; }

    [JsonInclude]
    public IUbytecContextEntity? HighLevelEntity { get; init; }

    [JsonInclude]
    public List<SyntaxNode>? Children { get; init; }

    [JsonInclude]
    public List<SyntaxToken>? Tokens { get; init; }

    private MetadataRegistry _metadata = new(1);

    [JsonIgnore]
    public ref MetadataRegistry Metadata => ref _metadata;

    [JsonInclude]
    [JsonPropertyName("Metadata")]
    public Dictionary<string, object> SerializableMetadata => _metadata.ToImmutable().ToDictionary(kv => kv.Key, kv => kv.Value);

    public SyntaxNode(IOpCode? operation)
    {
        Operation = operation;
        HighLevelEntity = null;
        Children = null;
        Tokens = null;
        _metadata.Add("guid", Guid.CreateVersion7());
    }

    public SyntaxNode(IUbytecContextEntity? entity)
    {
        HighLevelEntity = entity;
        Operation = null;
        Children = null;
        Tokens = null;
        _metadata.Add("guid", Guid.CreateVersion7());
    }

    public IOpCode[] ScopeOpCodes()
    {
        var temp = new List<IOpCode>();
        foreach (var child in Children ?? [])
            if (child.Operation != null)
                temp.Add(child.Operation);
        return [.. temp];
    }

    public SyntaxToken[] ScopeTokens()
    {
        var temp = new List<SyntaxToken>();
        foreach (var token in Tokens ?? [])
            temp.Add(token);
        return [.. temp];
    }

    public bool IsHighLevel => HighLevelEntity != null;
    public bool IsOpCode => Operation != null;

    public override string ToString()
    {
        if (HighLevelEntity != null) return $"HighLevel: {HighLevelEntity.Name}";
        if (Operation != null) return $"OpCode: {Operation.GetType().Name}";
        return "<Empty Node>";
    }

    public void Dispose() => _metadata.Dispose();
}
