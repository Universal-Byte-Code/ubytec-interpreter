using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableCliTests
{
    private const string Source = """
        module (name:"portable-cli", version:"0.1", author:"Ubytec")
        {
            func Helper() -> t_int64
            {
                push 7
                return
            }

            func Main() -> t_int64
            {
                push 42
                return
            }
        }
        """;

    [Fact]
    public void PortableX64CliWritesTheExactVerifiedModuleUsedForNativeCodegen()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("program.ubc", Source);
        string nasm = fixture.PathOf("program.nasm");
        string module = fixture.PathOf("program.ubcm");

        int status = CommandLineDriver.Run(
        [
            source,
            "-o", nasm,
            "--portable-x64",
            "--portable-module", module,
            "--no-metadata"
        ]);

        Assert.Equal(0, status);
        byte[] bytes = File.ReadAllBytes(module);
        string emitted = File.ReadAllText(nasm).ReplaceLineEndings("\n");
        PortableX64Compilation reconstructed = PortableProcessX64Backend.Compile(bytes);
        PortableProcessEntrypointInfo? entrypoint =
            PortableProcessEntrypoint.Read(PortableBinaryCodec.Decode(bytes));

        Assert.Equal(reconstructed.Assembly, emitted);
        Assert.NotNull(entrypoint);
        Assert.Equal(1u, entrypoint.FunctionIndex);
        Assert.Contains("global _start", emitted);
        Assert.Contains("call ubytec_binary_f_1", emitted);
        Assert.DoesNotContain("Main", emitted);
        Assert.DoesNotContain("Helper", emitted);
        Assert.Equal(0, CommandLineDriver.Run(["--verify-module", module]));
    }

    [Fact]
    public void PortableX64CliDoesNotRequirePersistingTheIntermediateModule()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("memory-only.ubc", Source);
        string nasm = fixture.PathOf("memory-only.nasm");

        int status = CommandLineDriver.Run(
        [
            source,
            "-o", nasm,
            "--portable-x64",
            "--no-metadata"
        ]);

        Assert.Equal(0, status);
        string emitted = File.ReadAllText(nasm);
        Assert.Contains("ubytec_binary_f_", emitted);
        Assert.Contains("global _start", emitted);
    }

    [Fact]
    public void PortableX64CliRejectsLegacyBackendOptimizationFlags()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("reject.ubc", Source);
        string nasm = fixture.PathOf("reject.nasm");

        int status = CommandLineDriver.Run(
        [
            source,
            "-o", nasm,
            "--portable-x64",
            "--tail-calls",
            "--no-metadata"
        ]);

        Assert.Equal(1, status);
        Assert.False(File.Exists(nasm));
    }

    [Fact]
    public void LegacyCliPathRemainsAvailableDuringMigration()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("legacy.ubc", Source);
        string nasm = fixture.PathOf("legacy.nasm");

        int status = CommandLineDriver.Run(
        [
            source,
            "-o", nasm,
            "--no-metadata"
        ]);

        Assert.Equal(0, status);
        string emitted = File.ReadAllText(nasm);
        Assert.Contains("global _start", emitted);
        Assert.DoesNotContain("ubytec_binary_f_", emitted);
    }

    private sealed class TempFixture : IDisposable
    {
        private readonly string root = System.IO.Path.Combine(
            System.IO.Path.GetTempPath(),
            "ubytec-portable-cli-" + Guid.NewGuid().ToString("N"));

        internal TempFixture() => Directory.CreateDirectory(root);

        internal string PathOf(string name) => System.IO.Path.Combine(root, name);

        internal string Write(string name, string content)
        {
            string path = PathOf(name);
            File.WriteAllText(path, content.ReplaceLineEndings("\n"));
            return path;
        }

        public void Dispose()
        {
            if (Directory.Exists(root))
                Directory.Delete(root, recursive: true);
        }
    }
}
