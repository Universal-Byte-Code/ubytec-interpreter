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

    private const string LibrarySource = """
        export Echo as portable_echo
        module (name:"portable-library", version:"0.1", author:"Ubytec")
        {
            func Echo(t_int64 value) -> t_int64
            {
                load @value
                return
            }
        }
        """;

    [Fact]
    public void DefaultCliWritesTheExactVerifiedModuleUsedForNativeCodegen()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("program.ubc", Source);
        string nasm = fixture.PathOf("program.nasm");
        string module = fixture.PathOf("program.ubcm");

        int status = CommandLineDriver.Run(
        [
            source,
            "-o", nasm,
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
    public void DefaultPortableLibraryBindsExportsFromTheVerifiedModule()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("library.ubc", LibrarySource);
        string nasm = fixture.PathOf("library.nasm");
        string module = fixture.PathOf("library.ubcm");

        int status = CommandLineDriver.Run(
        [
            source,
            "--library",
            "-o", nasm,
            "--portable-module", module,
            "--no-metadata"
        ]);

        Assert.Equal(0, status);
        byte[] bytes = File.ReadAllBytes(module);
        PortableProcessEntrypoint.Verify(bytes);
        PortableBinaryModule decoded = PortableBinaryCodec.Decode(bytes);
        PortableExecutableModule executable = Assert.IsType<PortableExecutableModule>(decoded.Executable);
        PortableExecutableExport export = Assert.Single(executable.Exports);
        Assert.Equal("portable_echo", executable.Strings[checked((int)export.SymbolStringIndex)]);
        Assert.Equal(0u, export.FunctionIndex);

        string emitted = File.ReadAllText(nasm).ReplaceLineEndings("\n");
        Assert.Contains("global ubytec_binary_export_0", emitted);
        Assert.Contains("global portable_echo", emitted);
        Assert.Contains("portable_echo:\n", emitted);
        Assert.Contains("call ubytec_binary_export_0", emitted);
        Assert.DoesNotContain("call Echo", emitted);
    }

    [Fact]
    public void PortableX64FlagRemainsACompatibilityAliasForTheDefaultPipeline()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("alias.ubc", Source);
        string defaultNasm = fixture.PathOf("default.nasm");
        string defaultModule = fixture.PathOf("default.ubcm");
        string explicitNasm = fixture.PathOf("explicit.nasm");
        string explicitModule = fixture.PathOf("explicit.ubcm");

        int defaultStatus = CommandLineDriver.Run(
        [
            source,
            "-o", defaultNasm,
            "--portable-module", defaultModule,
            "--no-metadata"
        ]);
        int explicitStatus = CommandLineDriver.Run(
        [
            source,
            "-o", explicitNasm,
            "--portable-x64",
            "--portable-module", explicitModule,
            "--no-metadata"
        ]);

        Assert.Equal(0, defaultStatus);
        Assert.Equal(0, explicitStatus);
        Assert.Equal(File.ReadAllBytes(defaultModule), File.ReadAllBytes(explicitModule));
        Assert.Equal(
            File.ReadAllText(defaultNasm).ReplaceLineEndings("\n"),
            File.ReadAllText(explicitNasm).ReplaceLineEndings("\n"));
    }

    [Fact]
    public void DefaultCliDoesNotRequirePersistingTheIntermediateModule()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("memory-only.ubc", Source);
        string nasm = fixture.PathOf("memory-only.nasm");

        int status = CommandLineDriver.Run(
        [
            source,
            "-o", nasm,
            "--no-metadata"
        ]);

        Assert.Equal(0, status);
        string emitted = File.ReadAllText(nasm);
        Assert.Contains("ubytec_binary_f_", emitted);
        Assert.Contains("global _start", emitted);
    }

    [Fact]
    public void DefaultCliRejectsLegacyBackendOptimizationFlags()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("reject.ubc", Source);
        string nasm = fixture.PathOf("reject.nasm");

        int status = CommandLineDriver.Run(
        [
            source,
            "-o", nasm,
            "--stack-transfers",
            "--no-metadata"
        ]);

        Assert.Equal(1, status);
        Assert.False(File.Exists(nasm));
    }

    [Fact]
    public void DefaultCliLowersHostExportThroughVerifiedPortableModule()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("host-export.ubc", Source);
        string nasm = fixture.PathOf("host-export.nasm");
        string module = fixture.PathOf("host-export.ubcm");

        int status = CommandLineDriver.Run(
        [
            source,
            "-o", nasm,
            "--library",
            "--host-export", "Main=ubytec_host_main",
            "--portable-module", module,
            "--no-metadata"
        ]);

        Assert.Equal(0, status);
        byte[] bytes = File.ReadAllBytes(module);
        PortableProcessEntrypoint.Verify(bytes);
        PortableExecutableModule executable = Assert.IsType<PortableExecutableModule>(
            PortableBinaryCodec.Decode(bytes).Executable);
        PortableExecutableExport export = Assert.Single(executable.Exports);
        Assert.Equal("ubytec_host_main", executable.Strings[checked((int)export.SymbolStringIndex)]);
        Assert.Equal(1u, export.FunctionIndex);

        string emitted = File.ReadAllText(nasm).ReplaceLineEndings("\n");
        Assert.Contains("global ubytec_host_main", emitted);
        Assert.Contains("ubytec_host_main:\n", emitted);
        Assert.Contains("call ubytec_binary_export_0", emitted);
        Assert.DoesNotContain("call Main", emitted);
    }

    [Fact]
    public void LegacySourceX64CliPathRemainsAvailableDuringMigration()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("legacy.ubc", Source);
        string nasm = fixture.PathOf("legacy.nasm");

        int status = CommandLineDriver.Run(
        [
            source,
            "-o", nasm,
            "--legacy-source-x64",
            "--no-metadata"
        ]);

        Assert.Equal(0, status);
        string emitted = File.ReadAllText(nasm);
        Assert.Contains("global _start", emitted);
        Assert.DoesNotContain("ubytec_binary_f_", emitted);
    }

    [Fact]
    public void LegacySourceX64ExplicitlyUnlocksLegacyBackendOptions()
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("legacy-options.ubc", Source);
        string nasm = fixture.PathOf("legacy-options.nasm");

        int status = CommandLineDriver.Run(
        [
            source,
            "-o", nasm,
            "--legacy-source-x64",
            "--stack-transfers",
            "--no-metadata"
        ]);

        Assert.Equal(0, status);
        Assert.True(File.Exists(nasm));
    }

    [Theory]
    [InlineData("--portable-x64", "--legacy-source-x64")]
    [InlineData("--legacy-source-x64", "--portable-x64")]
    public void CanonicalAndLegacyPipelineFlagsCannotBeCombined(string first, string second)
    {
        using var fixture = new TempFixture();
        string source = fixture.Write("conflict.ubc", Source);
        string nasm = fixture.PathOf("conflict.nasm");

        int status = CommandLineDriver.Run(
        [
            source,
            "-o", nasm,
            first,
            second,
            "--no-metadata"
        ]);

        Assert.Equal(1, status);
        Assert.False(File.Exists(nasm));
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
