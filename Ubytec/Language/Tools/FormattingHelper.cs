using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Tools
{
    public static class FormattingHelper
    {
        // Helper that returns the current indentation
        public static string GetDepth(CompilationScopes scopes, int basis = 0)
        {
            var indent = string.Empty;
            var depth = scopes.Count + basis;
            for (int i = 0; i < depth; i++)
                indent += "  ";
            return indent;
        }

        // Prefixes every non-empty line in 'lines' with 'depth'
        public static string FormatCompiledLines(string? lines, string depth)
        {

            var formatted = string.Empty;
            foreach (var line in lines?.Split('\n', StringSplitOptions.RemoveEmptyEntries) ?? [])
                formatted += depth + line + "\n";
            return formatted;
        }
    }
}
