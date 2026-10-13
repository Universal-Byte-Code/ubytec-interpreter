using Ubytec.Language.Tools;
using Xunit;

namespace Ubytec.Tests;

public class RepositoryUbcFormattingTests
{
    [Fact]
    public void EveryRepositoryUbcFileUsesCanonicalFormatting()
    {
        string root = FindRepositoryRoot();
        string[] offenders = Directory
            .EnumerateFiles(root, "*.ubc", SearchOption.AllDirectories)
            .Where(path => !IsBuildArtifact(root, path))
            .Where(path => !IsCanonicallyFormatted(path))
            .Select(path => Path.GetRelativePath(root, path))
            .OrderBy(path => path, StringComparer.Ordinal)
            .ToArray();

        Assert.True(
            offenders.Length == 0,
            "UBC source must use canonical four-space structural indentation:\n" + string.Join('\n', offenders));
    }

    private static bool IsCanonicallyFormatted(string path)
    {
        string source = File.ReadAllText(path)
            .Replace("\r\n", "\n", StringComparison.Ordinal)
            .Replace('\r', '\n');
        return string.Equals(source, UbcFormatter.Format(source), StringComparison.Ordinal);
    }

    private static bool IsBuildArtifact(string root, string path)
    {
        string relative = Path.GetRelativePath(root, path);
        string[] parts = relative.Split(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
        return parts.Any(part => part is "bin" or "obj" or ".git");
    }

    private static string FindRepositoryRoot()
    {
        DirectoryInfo? directory = new(AppContext.BaseDirectory);
        while (directory is not null)
        {
            if (File.Exists(Path.Combine(directory.FullName, "ubytec-interpreter.sln")))
                return directory.FullName;
            directory = directory.Parent;
        }
        throw new DirectoryNotFoundException("Could not locate the repository root from the test output directory.");
    }
}
