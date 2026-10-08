using Ubytec.Language.AST;
using Xunit;
namespace Ubytec.Tests;

public class HostLibraryTests
{
    private const string Source = """
        module (name:"host", version:"0.1", author:"Ubytec")
        {
        func Main() -> t_int64 {
        push 42
        return
        }
        func Subtract(t_int64 left, t_int64 right) -> t_int64
        {
        load @left
        load @right
        sub
        return
        }
        }
        """;

    [Fact]
    public void LibraryHasNoProcessEntry()
    {
        Assert.Contains("global _start", SourceCompiler.Compile(Source).Assembly);
        var library = SourceCompiler.Compile(Source, emitProcessEntryPoint: false);
        Assert.DoesNotContain("global _start", library.Assembly);
        Assert.DoesNotMatch(@"(?m)^\s*_start:", library.Assembly);
        Assert.NotNull(library.EntryLabel);
    }

    [Theory]
    [InlineData("_start")]
    [InlineData("ubytec_host_bad\nret")]
    [InlineData("bad")]
    [InlineData("ubytec_host_é")]
    public void InvalidHostSymbolsAreRejected(string symbol) =>
        Assert.Throws<ArgumentException>(() => SourceCompiler.Compile(Source, emitProcessEntryPoint: false)
            .GetLinuxSystemVAdapter("Main", symbol));

    [Fact]
    public void UnknownFunctionIsRejected() =>
        Assert.Throws<ArgumentException>(() => SourceCompiler.Compile(Source, emitProcessEntryPoint: false)
            .GetLinuxSystemVAdapter("Missing", "ubytec_host_missing"));

    [Theory]
    [InlineData(0)]
    [InlineData(1)]
    [InlineData(2)]
    [InlineData(5)]
    [InlineData(6)]
    public void HostAdapterExecutesArgumentOrderAndFullWidthResult(int count)
    {
        string arguments = string.Join(", ", Enumerable.Range(0, count).Select(i => $"t_int64 a{i}"));
        string body = "push 4294967297\n" + string.Join("\n",
            Enumerable.Range(0, count).Select(i => $"push 10\nmul\nload @a{i}\nadd"));
        string source = $"module (name:\"abi\", version:\"0.1\", author:\"Ubytec\") {{ func Value({arguments}) -> t_int64 {{ {body}\nreturn }} }}";
        var library = SourceCompiler.Compile(source, emitProcessEntryPoint: false);
        string adapter = library.GetLinuxSystemVAdapter("Value", "ubytec_host_value");
        // Preserve the Windows outer harness's nonvolatile registers and output pointer.
        string native = "push rdi\npush rsi\npush r11\n";
        string[] registers = ["rdi", "rsi", "rdx", "rcx", "r8", "r9"];
        long expected = 4294967297;
        for (int i = 0; i < count; i++)
        {
            native += $"mov {registers[i]}, {i + 1}\n";
            expected = expected * 10 + i + 1;
        }
        native += "call ubytec_host_value\npop r11\npop rsi\npop rdi\npush rax";
        Assert.Equal(expected, Assert.Single(NativeStack.Run(native, 1, library.Assembly + adapter)));
    }

    [Fact]
    public void MoreThanSixHostArgumentsAreRejected()
    {
        string args = string.Join(", ", Enumerable.Range(0, 7).Select(i => $"t_int64 a{i}"));
        var library = SourceCompiler.Compile($"module (name:\"abi\", version:\"0.1\", author:\"Ubytec\") {{ func Value({args}) -> t_int64 {{\npush 0\nreturn\n}} }}",
            emitProcessEntryPoint: false);
        Assert.Throws<ArgumentException>(() => library.GetLinuxSystemVAdapter("Value", "ubytec_host_value"));
    }
}
