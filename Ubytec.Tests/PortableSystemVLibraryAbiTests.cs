using System.Diagnostics;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableSystemVLibraryAbiTests
{
    private const string TwoArgumentLibrarySource = """
        export Pair as portable_pair
        module (name:"portable-systemv-abi", version:"0.1", author:"Ubytec")
        {
            func Pair(t_uint64 first,t_int32 second) -> t_uint64
            {
                load @first
                return
            }
        }
        """;

    [Fact]
    public void AdapterPushesSystemVArgumentsInSourceOrderForTheUbytecStackAbi()
    {
        string directory = Path.Combine(
            Path.GetTempPath(),
            $"ubytec-systemv-abi-{Guid.NewGuid():N}");
        Directory.CreateDirectory(directory);

        try
        {
            string source = Path.Combine(directory, "library.ubc");
            string nasm = Path.Combine(directory, "library.nasm");
            File.WriteAllText(source, TwoArgumentLibrarySource);

            int status = CommandLineDriver.Run(
            [
                source,
                "--library",
                "-o", nasm,
                "--no-metadata"
            ]);

            Assert.Equal(0, status);
            string emitted = File.ReadAllText(nasm).ReplaceLineEndings("\n");
            Assert.Contains(
                "  sub rsp, 8\n" +
                "  push rdi\n" +
                "  push rsi\n" +
                "  call ubytec_binary_export_0\n",
                emitted);
        }
        finally
        {
            Directory.Delete(directory, recursive: true);
        }
    }

    [Fact]
    public void IndependentlyCompiledLibrariesWithEqualExportIndicesLinkAndExecute()
    {
        // The portable backend targets ELF64/System V. Windows still exercises
        // the symbol-visibility contract in PortableCliTests.
        if (!OperatingSystem.IsLinux())
            return;

        string directory = Path.Combine(Path.GetTempPath(), $"ubytec-link-{Guid.NewGuid():N}");
        Directory.CreateDirectory(directory);
        try
        {
            CompileLibrary("first", 17);
            CompileLibrary("second", 29);

            string driver = Path.Combine(directory, "driver.c");
            File.WriteAllText(driver, """
                extern long ubytec_host_first(void);
                extern long ubytec_host_second(void);
                int main(void) {
                    return ubytec_host_first() == 17 &&
                           ubytec_host_second() == 29 ? 0 : 1;
                }
                """);

            string executable = Path.Combine(directory, "linked");
            RunTool("gcc", "-no-pie", driver,
                Path.Combine(directory, "first.o"),
                Path.Combine(directory, "second.o"), "-o", executable);
            RunTool(executable);

            void CompileLibrary(string name, int value)
            {
                string source = $$"""
                    module (name:"{{name}}", version:"0.1", author:"Ubytec")
                    {
                        func Main() -> t_int64
                        {
                            push {{value}}
                            return
                        }
                    }
                    """;
                PortableSourceX64Result result = PortableSourceX64Pipeline.Compile(
                    source, processImage: false,
                    requestedExports: [new PortableRequestedExport("Main", $"ubytec_host_{name}")]);
                PortableProcessEntrypoint.Verify(result.ModuleBytes);
                Assert.Single(PortableBinaryCodec.Decode(result.ModuleBytes).Executable!.Exports);
                Assert.Equal("ubytec_binary_export_0", Assert.Single(result.NativeCompilation.ExportLabels));
                string assembly = result.NativeCompilation.Assembly;
                Assert.Contains("ubytec_binary_export_0:\n", assembly);
                Assert.DoesNotContain("global ubytec_binary_export_0", assembly);
                Assert.Contains($"global ubytec_host_{name}", assembly);

                string nasm = Path.Combine(directory, name + ".nasm");
                File.WriteAllText(nasm, assembly);
                RunTool(Environment.GetEnvironmentVariable("UBYTEC_NASM") ?? "nasm",
                    "-f", "elf64", nasm, "-o", Path.Combine(directory, name + ".o"));
            }
        }
        finally
        {
            Directory.Delete(directory, recursive: true);
        }
    }

    private static void RunTool(string command, params string[] arguments)
    {
        var start = new ProcessStartInfo(command)
        {
            UseShellExecute = false,
            RedirectStandardError = true,
            RedirectStandardOutput = true
        };
        foreach (string argument in arguments)
            start.ArgumentList.Add(argument);

        using Process process = Process.Start(start)!;
        Task<string> stdout = process.StandardOutput.ReadToEndAsync();
        Task<string> stderr = process.StandardError.ReadToEndAsync();
        if (!process.WaitForExit(30_000))
        {
            process.Kill(entireProcessTree: true);
            process.WaitForExit();
            throw new TimeoutException($"{command} did not finish.");
        }

        Assert.True(process.ExitCode == 0,
            $"{command} exited with {process.ExitCode}: {stdout.GetAwaiter().GetResult()}\n{stderr.GetAwaiter().GetResult()}");
    }
}
