using Ubytec.Language.AST;
using Ubytec.Language.Tools;
using Xunit;

namespace Ubytec.Tests;

public sealed class TemporalRuntimeSourceTests
{
    [Fact]
    public void ManifestOrderAndCrossFragmentCallsArePreserved()
    {
        using var fixture = new SourceFixture();
        fixture.Write("a.ubc", "A", "    func First() -> t_uint64\n    {\n        call Second\n        return\n    }");
        fixture.Write("b.ubc", "B", "    func Second() -> t_uint64\n    {\n        push 42\n        return\n    }");
        fixture.Manifest("b.ubc\na.ubc\n");
        string composed = TemporalRuntimeSource.Compose(fixture.DirectoryPath);
        var semantic = SourceCompiler.CompileSemantic(composed, processImage: false);
        Assert.Equal(new[] { "Second", "First" }, semantic.Module.Functions.Select(f => f.Name).ToArray());

        fixture.Manifest("a.ubc\nb.ubc\n");
        var reordered = SourceCompiler.CompileSemantic(TemporalRuntimeSource.Compose(fixture.DirectoryPath), processImage: false);
        Assert.Equal(new[] { "First", "Second" }, reordered.Module.Functions.Select(f => f.Name).ToArray());
    }

    [Theory]
    [InlineData("")]
    [InlineData("a.ubc\na.ubc\n")]
    [InlineData("missing.ubc\n")]
    [InlineData("../a.ubc\n")]
    [InlineData("a.ubc\nmissing.ubc\n")]
    public void ManifestRejectsInvalidSourceSets(string manifest)
    {
        using var fixture = new SourceFixture();
        fixture.Write("a.ubc", "A", "    func First() -> t_uint64\n    {\n        push 1\n        return\n    }");
        fixture.Manifest(manifest);
        Assert.Throws<InvalidDataException>(() => TemporalRuntimeSource.Compose(fixture.DirectoryPath));
    }

    [Fact]
    public void ManifestRejectsUnlistedFilesAndMalformedWrappers()
    {
        using var fixture = new SourceFixture();
        fixture.Write("a.ubc", "A", "    func First() -> t_uint64\n    {\n        push 1\n        return\n    }");
        fixture.Write("b.ubc", "B", "    func Second() -> t_uint64\n    {\n        push 2\n        return\n    }");
        fixture.Manifest("a.ubc\n");
        Assert.Throws<InvalidDataException>(() => TemporalRuntimeSource.Compose(fixture.DirectoryPath));
        fixture.Manifest("a.ubc\nb.ubc\n");
        File.WriteAllText(Path.Combine(fixture.DirectoryPath, "b.ubc"), "not a module\n");
        Assert.Throws<InvalidDataException>(() => TemporalRuntimeSource.Compose(fixture.DirectoryPath));
    }

    private sealed class SourceFixture : IDisposable
    {
        public string DirectoryPath { get; } = Directory.CreateTempSubdirectory("ubytec-temporal-").FullName;

        public void Write(string file, string name, string body) =>
            File.WriteAllText(Path.Combine(DirectoryPath, file),
                $"module (name:\"{name}\",version:\"0.1\",author:\"Ubytec\")\n{{\n{body}\n}}\n");

        public void Manifest(string contents) =>
            File.WriteAllText(Path.Combine(DirectoryPath, "sources.txt"), contents);

        public void Dispose() => Directory.Delete(DirectoryPath, recursive: true);
    }
}
