using System.Text.Json.Serialization;
using Ubytec.Language.Operations;

namespace Ubytec.Language.Syntax.Syntaxes
{
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
}
