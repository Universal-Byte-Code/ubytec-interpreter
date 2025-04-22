using System.Text.Json.Serialization;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.Fast.Metadata;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Model;

public sealed class SyntaxNode : IUbytecSyntax, IDisposable
{
    [JsonInclude]
    public IUbytecEntity? Entity { get; init; }

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
        Entity = operation;
        Children = null;
        Tokens = null;
        _metadata.Add("guid", Guid.CreateVersion7());
    }

    public SyntaxNode(IUbytecContextEntity? entity)
    {
        Entity = entity;
        Children = null;
        Tokens = null;
        _metadata.Add("guid", Guid.CreateVersion7());
    }

    public IOpCode[] ScopeOpCodes()
    {
        var temp = new List<IOpCode>();
        foreach (var child in Children ?? [])
            if (child.Entity is IOpCode oc)
                temp.Add(oc);
        return [.. temp];
    }

    public SyntaxToken[] ScopeTokens()
    {
        var temp = new List<SyntaxToken>();
        foreach (var token in Tokens ?? [])
            temp.Add(token);
        return [.. temp];
    }

    public bool IsHighLevel => Entity is IUbytecHighLevelEntity;
    public bool IsOpCode => Entity is IOpCode;

    public override string ToString()
    {
        if (Entity is IUbytecHighLevelEntity hl) return $"HighLevel: {hl.ID}";
        if (Entity is IOpCode oc) return $"OpCode: {oc.GetType().Name}";
        return "<Empty Node>";
    }

    public void Dispose() => _metadata.Dispose();
}
