namespace Ubytec.Language.Tools;

/// <summary>Composes the trusted temporal runtime source fragments into one source module.
/// This is build-time composition, not a portable module linker or an execution dependency.</summary>
public static class TemporalRuntimeSource
{
    public static string Compose(string directory)
    {
        string[] names = File.ReadAllLines(Path.Combine(directory, "sources.txt"))
            .Select(line => line.Trim()).Where(line => line.Length != 0).ToArray();
        var declared = new HashSet<string>(StringComparer.Ordinal);
        foreach (string name in names)
        {
            if (name.Contains('/') || name.Contains('\\') || !name.EndsWith(".ubc", StringComparison.Ordinal)
                || !declared.Add(name))
                throw new InvalidDataException($"Invalid or duplicate temporal source: {name}");
        }
        var actual = Directory.EnumerateFiles(directory, "*.ubc")
            .Select(path => Path.GetFileName(path)).ToHashSet(StringComparer.Ordinal);
        if (declared.Count == 0 || !declared.SetEquals(actual))
            throw new InvalidDataException("Temporal source manifest must cover exactly the UBC source files.");

        var source = new System.Text.StringBuilder("module (name:\"temporal_runtime\",version:\"0.1\",author:\"Ubytec\")\n{\n");
        foreach (string name in names)
        {
            string[] lines = File.ReadAllText(Path.Combine(directory, name))
                .ReplaceLineEndings("\n").TrimEnd().Split('\n');
            if (lines.Length < 3 || !lines[0].StartsWith("module (name:\"", StringComparison.Ordinal)
                || lines[1] != "{" || lines[^1] != "}")
                throw new InvalidDataException($"Unexpected temporal fragment wrapper: {name}");
            source.AppendLine(string.Join('\n', lines[2..^1]));
        }
        return source.AppendLine("}").ToString().ReplaceLineEndings("\n");
    }
}
