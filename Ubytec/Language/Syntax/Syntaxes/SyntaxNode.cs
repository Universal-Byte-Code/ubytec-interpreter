using System.Text.Json.Serialization;
using Ubytec.Language.Operations;

namespace Ubytec.Language.Syntax.Syntaxes
{
    public readonly record struct SyntaxNode
    {
        [JsonInclude]
        public IOpCode? Operation { get; init; } = null;
        [JsonInclude]
        public List<SyntaxNode>? Children { get; init; } = null;
        [JsonInclude]
        public List<SyntaxToken>? Tokens { get; init; } = null;

        [JsonInclude]
        public Dictionary<string, object> Metadata { get; } = [];

        public SyntaxNode(IOpCode? operation)
        {
            Operation = operation;
            Metadata.Add("guid", Guid.CreateVersion7());
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
    }
}
