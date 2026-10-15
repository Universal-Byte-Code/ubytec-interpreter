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
}
