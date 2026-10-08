using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class LoopReductionTests
{
    public static IEnumerable<object[]> Profiles() => Enumerable.Range(0, 32).Select(n => new object[] { n });

    internal static string Source(string initialIndex = "0", string seed = "0") => $$"""
        module (name:"reduction_contract",version:"0.1",author:"Ubytec") {
        func Fold(t_uint64 bytesptr,t_uint64 size) -> t_uint64 {
        local { t_uint64 cursor {{initialIndex}} t_uint64 total {{seed}} }
        while @cursor < @size
        load @total
        load @bytesptr
        load @cursor
        add
        load t_byte
        add
        store @total
        load @cursor
        inc
        store @cursor
        end
        load @total
        return
        }
        }
        """;

    internal static SourceCompilation Compile(string source, int profile, bool reduce = true) =>
        SourceCompiler.Compile(source, emitProcessEntryPoint: false,
            optimizeStackTransfers: (profile & 1) != 0, optimizeFrameValues: (profile & 2) != 0,
            optimizeFrameRegisters: (profile & 4) != 0, optimizeLoopReductions: reduce,
            optimizeBlockReductions: reduce && (profile & 8) != 0,
            optimizeNativeBlockReductions: reduce && (profile & 16) != 0);

    [Theory, MemberData(nameof(Profiles))]
    public void NativeResultsPreserveUnsignedWrapNonzeroStartAndExactBytes(int profile)
    {
        var compiled = Compile(Source("2", "18446744073709551615"), profile);
        Assert.Contains("; loop-reductions:", compiled.Assembly);
        Assert.DoesNotContain("; frame-registers:", compiled.Assembly);
        string body = $"lea rax, [rel fixture]\npush rax\npush 5\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\npush rax";
        Assert.Equal(new long[] { 8 }, NativeStack.Run(body, 1, compiled.Assembly + "\nfixture: db 0,1,2,3,4\n"));
    }

    [Theory, MemberData(nameof(Profiles))]
    public void SuccessfulReturnPreservesTheEntireWrittenFrameAndResidualStack(int profile)
    {
        var compiled = Compile(Source("0", "18446744073709551615"), profile);
        string body = "sub rsp, 48\nlea rax, [rel fixture]\npush rax\npush 3\n" +
            $"call {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\nmov [rsp], rax\n" +
            Snapshot(new[] { -40, -48, -56, -64, -72 }, 8);
        Assert.Equal(new long[] { 5, 3, 5, 5, 3, 2 },
            NativeStack.Run(body, 6, compiled.Assembly + "\nfixture: db 1,2,3\n").Reverse());
    }

    [Theory, MemberData(nameof(Profiles))]
    public void EmptyReductionDoesNotReadItsInvalidInputOrWriteDeeperCells(int profile)
    {
        var compiled = Compile(Source("0", "42"), profile);
        string body = "sub rsp, 48\nmov qword [rsp-64], 12345\nmov qword [rsp-72], 67890\n" +
            $"push 0\npush 0\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\nmov [rsp], rax\n" +
            Snapshot(new[] { -40, -48, -56, -64, -72 }, 8);
        Assert.Equal(new long[] { 42, 0, 42, 42, 12345, 67890 }, NativeStack.Run(body, 6, compiled.Assembly).Reverse());
    }

    [Theory, MemberData(nameof(Profiles))]
    public void RawInputCanAliasLocalsAndLiveOrConsumedEvaluationCells(int profile)
    {
        var reference = Compile(Source("0", "42"), profile, reduce: false);
        var optimized = Compile(Source("0", "42"), profile);
        // Call both functions at the same physical stack position. Re-seed every
        // residual cell before each call so neither inherits the other's writes.
        // These ranges include unaligned reads and pointer-valued evaluation cells.
        foreach (var (offset, count) in new[] { (-48, 8), (-40, 8), (-56, 8), (-64, 8),
                     (-72, 8), (-69, 17), (-160, 128), (-48, 1), (-56, 1), (-72, 1) })
        {
            string Seed() => string.Join('\n', Enumerable.Range(7, 16)
                .Select(i => $"mov qword [rsp-{i * 8}], 12345"));
            string Invoke(SourceCompilation compilation) => Seed() +
                $"\nlea rax, [rsp{offset}]\npush rax\npush {count}\n" +
                $"call {compilation.GetFunctionLabel("Fold")}\nadd rsp, 16\n";
            var body = "sub rsp, 48\n" + Invoke(reference) + "mov [rsp], rax\n" +
                Snapshot(new[] { -40, -48, -56, -64, -72 }, 8) + Invoke(optimized) +
                "xor rax, [rsp]\nmov rcx, rax\n";
            for (int i = 0; i < 5; i++)
                body += $"mov rax, [rsp-{new[] { 40, 48, 56, 64, 72 }[i]}]\nxor rax, [rsp+{8 * (i + 1)}]\nor rcx, rax\n";
            body += "mov [rsp], rcx\n";
            Assert.Equal(0, NativeStack.Run(body, 6, reference.Assembly + optimized.Assembly)[^1]);
        }
    }

    [Theory]
    [InlineData(-48, 84)] [InlineData(-56, 84)] [InlineData(-40, 42)] [InlineData(-72, 42)]
    public void AliasedOneByteReadHasAnIndependentExpectedResult(int offset, long expected)
    {
        var compiled = Compile(Source("0", "42"), 7);
        string body = $"lea rax, [rsp{offset}]\npush rax\npush 1\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\npush rax";
        Assert.Equal(new[] { expected }, NativeStack.Run(body, 1, compiled.Assembly));
    }

    [Fact]
    public void RecognitionUsesBindingsWithEitherArgumentAndLocalOrder()
    {
        string source = Source().Replace("t_uint64 bytesptr,t_uint64 size", "t_uint64 size,t_uint64 bytesptr")
            .Replace("t_uint64 cursor 0 t_uint64 total 0", "t_uint64 total 0 t_uint64 cursor 0");
        var compiled = Compile(source, 7);
        Assert.Contains("; loop-reductions:", compiled.Assembly);
        string body = $"push 3\nlea rax, [rel fixture]\npush rax\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\npush rax";
        Assert.Equal(new long[] { 6 }, NativeStack.Run(body, 1, compiled.Assembly + "\nfixture: db 1,2,3\n"));
    }

    [Theory]
    [InlineData("while @cursor < @size", "while @cursor <= @size", 1, 256)]
    [InlineData("load t_byte", "load t_sbyte", 1, -1)]
    [InlineData("load t_byte", "load t_uint16", 1, 511)]
    [InlineData("t_uint64 cursor 0", "t_uint32 cursor 0", 1, 255)]
    [InlineData("while @cursor < @size", "while t_int64 @cursor < @size", 1, 255)]
    [InlineData("load @total\nreturn", "load @total\npush 1\nadd\nreturn", 1, 256)]
    public void OtherWidthsConditionsOrEffectsUseTheReferenceBackend(string original, string change, int count, long expected)
    {
        string source = Source().Replace(original, change);
        var compiled = Compile(source, 7);
        Assert.DoesNotContain("; loop-reductions:", compiled.Assembly);
        string body = $"lea rax, [rel fixture]\npush rax\npush {count}\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\npush rax";
        Assert.Equal(new[] { expected }, NativeStack.Run(body, 1, compiled.Assembly + "\nfixture: db 255,1,0\n"));
    }

    [Fact]
    public void ReferenceValidationStillRejectsAnExplicitWrongReturnType()
    {
        string source = Source().Replace("return", "return t_int32");
        Assert.ThrowsAny<Exception>(() => Compile(source, 7, false));
        Assert.ThrowsAny<Exception>(() => Compile(source, 7));
    }

    [Fact]
    public void UnsignedLimitAndWrappedAddressKeepOneExactRead()
    {
        var compiled = Compile(Source("18446744073709551614", "42"), 7);
        Assert.Contains("; loop-reductions:", compiled.Assembly);
        // input + (UINT64_MAX-1) wraps to fixture; the next index equals the limit.
        string body = $"lea rax, [rel fixture+2]\npush rax\npush -1\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\npush rax";
        Assert.Equal(new long[] { 59 }, NativeStack.Run(body, 1, compiled.Assembly + "\nfixture: db 17\n"));
    }

    [Fact]
    public void OptimizationIsDisabledByDefault()
    {
        Assert.DoesNotContain("; loop-reductions:", SourceCompiler.Compile(Source(), emitProcessEntryPoint: false).Assembly);
    }

    private static string Snapshot(int[] offsets, int destination) => string.Join('\n', offsets.Select((offset, i) =>
        $"mov rax, [rsp{offset}]\nmov [rsp+{destination + i * 8}], rax")) + "\n";
}
