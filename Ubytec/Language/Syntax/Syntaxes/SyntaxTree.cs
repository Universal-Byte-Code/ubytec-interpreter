using System.Reflection;
using System.Text;
using System.Text.Json.Serialization;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Syntaxes
{
    public class SyntaxTree : IUbytecSyntax
    {
        [JsonInclude]
        public SyntaxSentence RootSentence { get; set; }

        [JsonInclude]
        public Dictionary<string, object> Metadata { get; } = [];

        // The active sentence stack for building the tree.
        internal Stack<SyntaxSentence> TreeSentenceStack { get; set; } = new Stack<SyntaxSentence>();

        public SyntaxTree(SyntaxSentence root)
        {
            var languageAssembly = Assembly.GetAssembly(typeof(SyntaxTree));

            RootSentence = root;
            TreeSentenceStack.Push(root);
            RootSentence.Metadata.Add("type", "root");
            Metadata.Add("guid", Guid.CreateVersion7());
            Metadata.Add("encoding", Encoding.GetEncoding(0).EncodingName);
            Metadata.Add("langver", languageAssembly?.GetName().Version ??
                throw new LanguageVersionException(0xEBFE1914569FDD2F, "Null assembly version, "));
        }
    }
}
