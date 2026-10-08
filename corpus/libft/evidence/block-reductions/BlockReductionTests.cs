using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class BlockReductionTests
{
    public static IEnumerable<object[]> Profiles() => Enumerable.Range(8, 8).Select(n => new object[] { n });

    [Theory, MemberData(nameof(Profiles))]
    public void BlocksAcrossPagesPreserveSeedWrapInitialIndexAndResidualMemory(int profile)
    {
        var compiled = LoopReductionTests.Compile(LoopReductionTests.Source("2", "18446744073709551615"), profile);
        Assert.Contains("; block-reductions:", compiled.Assembly);
        Assert.Contains("psadbw", compiled.Assembly);
        const int length = 8193;
        long expected = (length - 2) * 255L - 1;
        for (int offset = 0; offset < 16; offset++)
        {
            string body = $"sub rsp, 48\nlea rax, [rel fixture+{offset}]\npush rax\npush {length}\n" +
                $"call {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\nmov [rsp], rax\n" +
                "mov rax, [rsp-40]\nmov [rsp+8], rax\nmov rax, [rsp-48]\nmov [rsp+16], rax\n" +
                "mov rax, [rsp-56]\nmov [rsp+24], rax\nmov rax, [rsp-64]\nmov [rsp+32], rax\n" +
                "mov rax, [rsp-72]\nmov [rsp+40], rax\n";
            Assert.Equal(new long[] { expected, length, expected, expected, 255, length - 1 },
                NativeStack.Run(body, 6, compiled.Assembly + "\nfixture: times 8224 db 255\n").Reverse());
        }
    }

    [Theory, MemberData(nameof(Profiles))]
    public void EitherBindingOrderUsesTheCorrectFrameCells(int profile)
    {
        string source = LoopReductionTests.Source("3", "7")
            .Replace("t_uint64 bytesptr,t_uint64 size", "t_uint64 size,t_uint64 bytesptr")
            .Replace("t_uint64 cursor 3 t_uint64 total 7", "t_uint64 total 7 t_uint64 cursor 3");
        var compiled = LoopReductionTests.Compile(source, profile);
        string body = $"push 257\nlea rax, [rel fixture]\npush rax\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\npush rax";
        Assert.Equal(new long[] { 7 + 254 * 17 }, NativeStack.Run(body, 1, compiled.Assembly + "\nfixture: times 257 db 17\n"));
    }

    [Fact]
    public void BlockOptionWorksIndependentlyAndIsDisabledByDefault()
    {
        string source = LoopReductionTests.Source();
        Assert.DoesNotContain("; block-reductions:", SourceCompiler.Compile(source, emitProcessEntryPoint: false).Assembly);
        var compiled = SourceCompiler.Compile(source, emitProcessEntryPoint: false, optimizeBlockReductions: true);
        Assert.Contains("; block-reductions:", compiled.Assembly);
        string body = $"lea rax, [rel fixture]\npush rax\npush 128\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\npush rax";
        Assert.Equal(new long[] { 128 * 19 }, NativeStack.Run(body, 1, compiled.Assembly + "\nfixture: times 128 db 19\n"));
    }

    [Fact]
    public void UnknownEffectsRemainOnTheReferenceBackend()
    {
        string source = LoopReductionTests.Source().Replace("load @total\nreturn", "load @total\npush 1\nadd\nreturn");
        var compiled = SourceCompiler.Compile(source, emitProcessEntryPoint: false, optimizeBlockReductions: true);
        Assert.DoesNotContain("; block-reductions:", compiled.Assembly);
        Assert.DoesNotContain("; loop-reductions:", compiled.Assembly);
    }

    [Fact]
    public void WrappedAddressesUseTheScalarFallback()
    {
        var compiled = SourceCompiler.Compile(LoopReductionTests.Source("18446744073709551614", "42"),
            emitProcessEntryPoint: false, optimizeBlockReductions: true);
        string body = $"lea rax, [rel fixture+2]\npush rax\npush -1\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\npush rax";
        Assert.Equal(new long[] { 59 }, NativeStack.Run(body, 1, compiled.Assembly + "\nfixture: db 17\n"));
    }
}
