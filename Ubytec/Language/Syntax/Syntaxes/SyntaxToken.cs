using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Syntax.Syntaxes
{
    public readonly record struct SyntaxToken : IUbytecSyntax
    {
        public string Source { get; private init; }
        public int Line { get; private init; }
        public int StartColumn { get; private init; }
        public int EndColumn { get; private init; }
        public string[] Scopes { get; private init; }
        public SyntaxToken(string source, int line, int startColumn, int endColumn, string[] scopes)
        {
            Source = source;
            Line = line;
            StartColumn = startColumn;
            EndColumn = endColumn;
            Scopes = scopes;
            Metadata.Add("guid", Guid.CreateVersion7());
        }

        [JsonInclude]
        public Dictionary<string, object> Metadata { get; } = [];
    }
}
