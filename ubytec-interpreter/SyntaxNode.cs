using System.Text;
using System.Text.Json.Serialization;
using ubytec_interpreter.Operations;

namespace ubytec_interpreter
{
    public class SyntaxTree
    {
        [JsonInclude]
        public SyntaxSentence RootSentence { get; set; }

        // The active sentence stack for building the tree.
        internal Stack<SyntaxSentence> Sentences { get; set; } = new Stack<SyntaxSentence>();

        [JsonInclude]
        public Dictionary<string, object>? Metadata { get; } = [];

        public SyntaxTree(SyntaxSentence root)
        {
            RootSentence = root;
            Sentences.Push(root);
            Metadata.Add("guid", Guid.CreateVersion7());
            Metadata.Add("encoding", Console.OutputEncoding.EncodingName);
        }
    }

    public class SyntaxSentence
    {
        [JsonInclude]
        public Stack<SyntaxNode> Nodes { get; set; } = new Stack<SyntaxNode>();

        [JsonInclude]
        public List<SyntaxSentence> Sentences { get; set; } = [];

        [JsonInclude]
        public Dictionary<string, object> Metadata { get; } = [];

        public SyntaxSentence()
        {
            Metadata.Add("guid", Guid.CreateVersion7());
        }

        public IOpCode[] ScopeOpCodes()
        {
            var temp = new List<IOpCode>();
            foreach (var node in Nodes)
            {
                if (node.Operation != null)
                    temp.Add(node.Operation);
            }
            return [.. temp];
        }
    }
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
            foreach (var child in Children)
                if (child.Operation != null)
                    temp.Add(child.Operation);
            return [.. temp];
        }

        public SyntaxToken[] ScopeTokens()
        {
            var temp = new List<SyntaxToken>();
            foreach (var token in Tokens)
                    temp.Add(token);
            return [.. temp];
        }
    }
    public readonly record struct SyntaxToken(string Source, string Line, int Row, int Column);
}
