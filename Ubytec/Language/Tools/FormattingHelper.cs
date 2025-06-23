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
