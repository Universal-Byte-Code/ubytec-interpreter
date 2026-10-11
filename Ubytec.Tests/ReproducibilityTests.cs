using System.Globalization;
using Ubytec.Language.AST;
using Ubytec.Language.Syntax.Model;
using Xunit;

namespace Ubytec.Tests;

public class ReproducibilityTests
{
    private const string Source = """
module (name:"repro", version:"1.2.3", author:"Ubytec")
{
func Main() -> t_int64
{
t_int64 n 0
while @n < 2
load @n
inc
store @n
end
if @n == 2
push 42
else
push 0
end
return
}
}
""";

    [Fact]
    public void RepeatedCompilationIsByteIdentical()
    {
        var first = SourceCompiler.Compile(Source);
        var second = SourceCompiler.Compile(Source);

        Assert.Equal(first.Assembly, second.Assembly);
        Assert.Equal(first.EntryLabel, second.EntryLabel);
        Assert.Equal(first.Module.ID, second.Module.ID);
        Assert.Equal(first.Module.Functions[0].ID, second.Module.Functions[0].ID);
        Assert.DoesNotContain("\r", first.Assembly);
        Assert.DoesNotContain("Compilation UTC Time", first.Assembly);
        Assert.Equal('8', first.Module.ID.ToString("D")[14]);
        Assert.Equal('8', first.Module.Functions[0].ID.ToString("D")[14]);
    }

    [Fact]
    public void ModuleVersionParticipatesInSemanticIdentity()
    {
        var original = SourceCompiler.Compile(Source);
        var changed = SourceCompiler.Compile(Source.Replace("1.2.3", "1.2.4", StringComparison.Ordinal));

        Assert.NotEqual(original.Module.ID, changed.Module.ID);
        Assert.NotEqual(original.EntryLabel, changed.EntryLabel);
    }

    [Fact]
    public void HostCultureDoesNotAffectCanonicalAssembly()
    {
        CultureInfo previousCulture = CultureInfo.CurrentCulture;
        CultureInfo previousUiCulture = CultureInfo.CurrentUICulture;
        try
        {
            CultureInfo.CurrentCulture = CultureInfo.GetCultureInfo("tr-TR");
            CultureInfo.CurrentUICulture = CultureInfo.GetCultureInfo("tr-TR");
            var turkish = SourceCompiler.Compile(Source);

            CultureInfo.CurrentCulture = CultureInfo.GetCultureInfo("en-US");
            CultureInfo.CurrentUICulture = CultureInfo.GetCultureInfo("en-US");
            var english = SourceCompiler.Compile(Source);

            Assert.Equal(english.Assembly, turkish.Assembly);
            Assert.Equal(english.Module.ID, turkish.Module.ID);
        }
        finally
        {
            CultureInfo.CurrentCulture = previousCulture;
            CultureInfo.CurrentUICulture = previousUiCulture;
        }
    }

    [Fact]
    public void ProvenanceUsesUuidV7WithoutPollutingCanonicalAssembly()
    {
        var compilation = SourceCompiler.Compile(Source);
        var first = CompilationMetadata.Create(
            compilation.Module,
            Source,
            compilation.Assembly,
            "x86-64-baseline");
        var second = CompilationMetadata.Create(
            compilation.Module,
            Source,
            compilation.Assembly,
            "x86-64-baseline");

        Assert.Equal('7', first.CompilationId.ToString("D")[14]);
        Assert.NotEqual(first.CompilationId, second.CompilationId);
        Assert.Equal(compilation.Module.ID, first.Module.SemanticId);
        Assert.Equal(64, first.Hashes.SourceSha256.Length);
        Assert.Equal(64, first.Hashes.AssemblySha256.Length);
    }

    [Fact]
    public void RuntimeSyntaxInstancesUseUuidV7()
    {
        using var tree = new SyntaxTree(new SyntaxSentence());
        string id = Assert.IsType<string>(tree.SerializableMetadata["guid"]);
        Assert.Equal('7', id[14]);
    }
}
