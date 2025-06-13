using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Tools
{
    /// <summary>
    /// Provides helper methods for formatting compiled output
    /// with proper indentation based on the current compilation scopes.
    /// </summary>
    public static class FormattingHelper
    {
        /// <summary>
        /// Calculates the indentation string for the current depth of nested scopes.
        /// </summary>
        /// <param name="scopes">The <see cref="CompilationScopes"/> whose depth to use.</param>
        /// <param name="basis">
        /// An optional additional indentation level to apply on top of the scope count.
        /// Defaults to <c>0</c>.
        /// </param>
        /// <returns>
        /// A string consisting of two spaces per indentation level,
        /// where level = <paramref name="scopes"/>.Count + <paramref name="basis"/>.
        /// </returns>
        public static string GetDepth(CompilationScopes scopes, int basis = 0)
        {
            var indent = string.Empty;
            var depth = scopes.Count + basis;
            for (int i = 0; i < depth; i++)
                indent += "  ";
            return indent;
        }

        /// <summary>
        /// Prefixes each non-empty line of the input with the specified indentation string.
        /// </summary>
        /// <param name="lines">
        /// The multi-line string to format. May be <c>null</c> or empty.
        /// </param>
        /// <param name="depth">
        /// The indentation string to prepend to each line.
        /// </param>
        /// <returns>
        /// A new string where each non-empty line from <paramref name="lines"/>
        /// is prefixed with <paramref name="depth"/>, followed by a newline.
        /// If <paramref name="lines"/> is <c>null</c> or contains no non-empty lines,
        /// returns an empty string.
        /// </returns>
        public static string FormatCompiledLines(string? lines, string depth)
        {
            var formatted = string.Empty;
            foreach (var line in lines?.Split('\n', StringSplitOptions.RemoveEmptyEntries) ?? [])
                formatted += depth + line + "\n";
            return formatted;
        }
    }
}
