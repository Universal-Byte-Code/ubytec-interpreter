namespace Ubytec.Language.Tools;

/// <summary>Formats UBC source without changing its tokens or control-flow structure.</summary>
public static class UbcFormatter
{
    private const int IndentWidth = 4;

    private static readonly HashSet<string> BlockKeywords = new(StringComparer.OrdinalIgnoreCase)
    {
        "block",
        "branch",
        "if",
        "loop",
        "switch",
        "while"
    };

    /// <summary>Normalizes UBC block layout and indentation to four spaces per nesting level.</summary>
    public static string Format(string source)
    {
        ArgumentNullException.ThrowIfNull(source);
        if (source.Length == 0) return string.Empty;

        var lines = SplitStructuralLines(source);
        var frames = new Stack<Frame>();
        var formatted = new List<string>(lines.Count);

        foreach (string line in lines)
        {
            if (line.Length == 0)
            {
                if (formatted.Count > 0 && formatted[^1].Length != 0)
                    formatted.Add(string.Empty);
                continue;
            }

            string keyword = FirstToken(line);
            if (line == "}")
            {
                PopSyntheticDefault(frames);
                if (frames.TryPeek(out var frame) && frame.Kind == FrameKind.Brace)
                    frames.Pop();
                AppendIndented(formatted, frames.Count, line);
                continue;
            }

            if (line == "{")
            {
                AppendIndented(formatted, frames.Count, line);
                frames.Push(new(FrameKind.Brace));
                continue;
            }

            if (keyword.Equals("end", StringComparison.OrdinalIgnoreCase))
            {
                PopSyntheticDefault(frames);
                if (frames.TryPeek(out var frame) && frame.Kind == FrameKind.Control)
                    frames.Pop();
                AppendIndented(formatted, frames.Count, line);
                continue;
            }

            if (keyword.Equals("else", StringComparison.OrdinalIgnoreCase) &&
                frames.TryPeek(out var ifFrame) &&
                ifFrame.Kind == FrameKind.Control &&
                string.Equals(ifFrame.Keyword, "if", StringComparison.OrdinalIgnoreCase))
            {
                frames.Pop();
                AppendIndented(formatted, frames.Count, line);
                frames.Push(new(FrameKind.Control, "else"));
                continue;
            }

            if (keyword.Equals("default", StringComparison.OrdinalIgnoreCase) &&
                frames.TryPeek(out var switchFrame) &&
                switchFrame.Kind == FrameKind.Control &&
                string.Equals(switchFrame.Keyword, "switch", StringComparison.OrdinalIgnoreCase))
            {
                AppendIndented(formatted, frames.Count, line);
                frames.Push(new(FrameKind.Default));
                continue;
            }

            AppendIndented(formatted, frames.Count, line);
            if (BlockKeywords.Contains(keyword))
                frames.Push(new(FrameKind.Control, keyword));
        }

        while (formatted.Count > 0 && formatted[^1].Length == 0)
            formatted.RemoveAt(formatted.Count - 1);

        return formatted.Count == 0 ? string.Empty : string.Join('\n', formatted) + "\n";
    }

    private static List<string> SplitStructuralLines(string source)
    {
        source = source.Replace("\r\n", "\n", StringComparison.Ordinal).Replace('\r', '\n');
        var result = new List<string>();
        bool inBlockComment = false;

        foreach (string rawLine in source.Split('\n'))
        {
            string line = rawLine.Trim();
            if (line.Length == 0)
            {
                result.Add(string.Empty);
                continue;
            }

            var buffer = new System.Text.StringBuilder();
            bool inDoubleQuotedString = false;
            bool inSingleQuotedString = false;
            bool escaped = false;

            void Flush()
            {
                string segment = buffer.ToString().Trim();
                buffer.Clear();
                if (segment.Length != 0)
                    result.Add(segment);
            }

            for (int i = 0; i < line.Length; i++)
            {
                char current = line[i];
                char next = i + 1 < line.Length ? line[i + 1] : '\0';

                if (inBlockComment)
                {
                    buffer.Append(current);
                    if (current == '*' && next == '/')
                    {
                        buffer.Append(next);
                        i++;
                        inBlockComment = false;
                    }
                    continue;
                }

                if (inDoubleQuotedString || inSingleQuotedString)
                {
                    buffer.Append(current);
                    if (escaped)
                    {
                        escaped = false;
                        continue;
                    }
                    if (current == '\\')
                    {
                        escaped = true;
                        continue;
                    }
                    if ((inDoubleQuotedString && current == '"') ||
                        (inSingleQuotedString && current == '\''))
                    {
                        inDoubleQuotedString = false;
                        inSingleQuotedString = false;
                    }
                    continue;
                }

                if (current == '/' && next == '/')
                {
                    buffer.Append(line.AsSpan(i));
                    break;
                }
                if (current == '/' && next == '*')
                {
                    buffer.Append(current).Append(next);
                    i++;
                    inBlockComment = true;
                    continue;
                }
                if (current == '"')
                {
                    buffer.Append(current);
                    inDoubleQuotedString = true;
                    continue;
                }
                if (current == '\'')
                {
                    buffer.Append(current);
                    inSingleQuotedString = true;
                    continue;
                }
                if (current is '{' or '}')
                {
                    Flush();
                    result.Add(current.ToString());
                    continue;
                }

                buffer.Append(current);
            }

            Flush();
        }

        return result;
    }

    private static string FirstToken(string line)
    {
        int length = 0;
        while (length < line.Length && !char.IsWhiteSpace(line[length]))
            length++;
        return line[..length];
    }

    private static void AppendIndented(List<string> output, int depth, string line) =>
        output.Add(new string(' ', depth * IndentWidth) + line);

    private static void PopSyntheticDefault(Stack<Frame> frames)
    {
        if (frames.TryPeek(out var frame) && frame.Kind == FrameKind.Default)
            frames.Pop();
    }

    private enum FrameKind
    {
        Brace,
        Control,
        Default
    }

    private readonly record struct Frame(FrameKind Kind, string? Keyword = null);
}
