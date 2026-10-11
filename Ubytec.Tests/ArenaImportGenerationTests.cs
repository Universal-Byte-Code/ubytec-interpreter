using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class ArenaImportGenerationTests
{
    private const string Module = "\nmodule (name:\"arena_tests\",version:\"0.1\",author:\"Ubytec\") {\nfunc Main() -> t_int64 {\npush 0\nreturn\n}\n}\n";

    [Theory]
    [InlineData("pair")]
    [InlineData("dynamic-text")]
    public void GeneratedFixturesMatchAndCompile(string name)
    {
        string source = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, name + "-source.ubc"));
        string expected = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, name + "-generated.ubc")).Replace("\r\n", "\n");
        string generated = ArenaImportGenerator.Generate(source);
        Assert.Equal(expected, generated);
        var compiled = SourceCompiler.Compile(generated, emitProcessEntryPoint: false, enableModuleCalls: true);
        Assert.Contains(compiled.Module.Functions, f => f.Name == "ArenaPin");
        Assert.Contains(compiled.Module.Functions, f => f.Name.StartsWith("Arena_", StringComparison.Ordinal));
        Assert.Contains("call ubytec_bridge_many", compiled.Assembly);
        Assert.DoesNotContain("|Arena_", compiled.ContractManifest);
    }

    [Theory]
    [InlineData("t_loan_rw,t_loan_ro,t_loan_ro", "t_int64")]
    [InlineData("t_byte", "t_int64")]
    [InlineData("t_uint64", "t_void")]
    [InlineData("t_uint64,t_uint64,t_uint64,t_uint64,t_uint64,t_uint64,t_uint64", "t_int64")]
    [InlineData("t_uint64,t_uint64,t_uint64,t_uint64", "t_int64")]
    public void UnsupportedContractsAreRejected(string args, string result) =>
        Assert.Throws<ArgumentException>(() => ArenaImportGenerator.Generate($"import X from m.f ({args}) -> {result}" + Module));

    [Theory]
    [InlineData("Arena_X")]
    [InlineData("ArenaAlloc")]
    [InlineData("ArenaResize")]
    public void LibraryAndWrapperCollisionsAreRejected(string name) =>
        Assert.Throws<ArgumentException>(() => ArenaImportGenerator.Generate("import X from m.f (t_loan_ro) -> t_int64" + Module.Replace("Main", name)));

    [Fact]
    public void ImportAliasCannotShadowGeneratedWrapper() =>
        Assert.Throws<ArgumentException>(() => ArenaImportGenerator.Generate("import X from m.f (t_loan_ro) -> t_int64\nimport Arena_X from m.g () -> t_int64" + Module));

    [Fact]
    public void RepeatedGenerationIsRejected()
    {
        string generated = ArenaImportGenerator.Generate("import X from m.f (t_loan_ro) -> t_int64" + Module);
        Assert.Throws<ArgumentException>(() => ArenaImportGenerator.Generate(generated));
    }

    [Fact]
    public void GenerationNeedsImports() => Assert.Throws<ArgumentException>(() => ArenaImportGenerator.Generate(Module));

    [Fact]
    public void RawCompilationDoesNotInsertArenaFunctions()
    {
        var compiled = SourceCompiler.Compile("import X from m.f (t_loan_ro) -> t_int64" + Module, emitProcessEntryPoint: false, enableModuleCalls: true);
        Assert.DoesNotContain(compiled.Module.Functions, f => f.Name.StartsWith("Arena", StringComparison.Ordinal));
    }
}
