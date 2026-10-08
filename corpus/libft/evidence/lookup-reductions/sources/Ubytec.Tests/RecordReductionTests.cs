using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class RecordReductionTests
{
    public static IEnumerable<object[]> Profiles() => Enumerable.Range(0, 8).Select(n => new object[] { n });
    internal static string Source(string initialIndex = "0", string seed = "0", int stride = 24, int offset = 16) =>
        LoopReductionTests.Source(initialIndex, seed).Replace("load @cursor\nadd\nload t_byte",
            $"load @cursor\npush {stride}\nmul\nadd\npush {offset}\nadd\nload t_uint64");
    internal static SourceCompilation Compile(string source, int profile, bool reduce = true) =>
        SourceCompiler.Compile(source, emitProcessEntryPoint: false,
            optimizeStackTransfers: (profile & 1) != 0, optimizeFrameValues: (profile & 2) != 0,
            optimizeFrameRegisters: (profile & 4) != 0, optimizeRecordReductions: reduce);

    [Theory, MemberData(nameof(Profiles))]
    public void SuccessfulReadPreservesSeedWrapInitialIndexAndAllResidualCells(int profile)
    {
        var compiled = Compile(Source("1", "18446744073709551615"), profile);
        Assert.Contains("; record-reductions:", compiled.Assembly);
        string body = "sub rsp, 56\nlea rax, [rel fixture]\npush rax\npush 4\n" +
            $"call {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\nmov [rsp], rax\n" + Snapshot();
        string fixture = "\nfixture: dq 0,0,17,0,0,19,0,0,23,0,0,29\n";
        Assert.Equal(new long[] { 70, 4, 70, 70, 29, 16, 24 }, NativeStack.Run(body, 7, compiled.Assembly + fixture).Reverse());
    }

    [Theory, MemberData(nameof(Profiles))]
    public void EmptyLoopLeavesEveryDeeperCellIntactAndDoesNotReadItsPointer(int profile)
    {
        var compiled = Compile(Source("6", "42"), profile);
        string body = "sub rsp, 56\nmov qword [rsp-64], 12345\nmov qword [rsp-72], 67890\nmov qword [rsp-80], 98765\n" +
            $"push -1\npush 5\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\nmov [rsp], rax\n" + Snapshot();
        Assert.Equal(new long[] { 42, 6, 42, 42, 12345, 67890, 98765 }, NativeStack.Run(body, 7, compiled.Assembly).Reverse());
    }

    [Theory, MemberData(nameof(Profiles))]
    public void InputsMayAliasLocalsResidualCellsAndUnalignedIntervals(int profile)
    {
        foreach (var (offset, count, stride, field) in new[] { (-40,1,24,0),(-48,1,24,0),(-56,1,24,0),
            (-64,1,24,0),(-72,1,24,0),(-80,1,24,0),(-160,16,8,0),(-79,8,1,0),(-96,1,24,16) })
        {
            var reference = Compile(Source("0", "42", stride, field), profile, false);
            var optimized = Compile(Source("0", "42", stride, field), profile);
            string Invoke(SourceCompilation c) => string.Join('\n', Enumerable.Range(5, 28)
                .Select(i => $"mov qword [rsp-{i*8}], 12345")) +
                $"\nlea rax, [rsp{offset}]\npush rax\npush {count}\ncall {c.GetFunctionLabel("Fold")}\nadd rsp, 16\n";
            string body = "sub rsp, 56\n" + Invoke(reference) + "mov [rsp], rax\n" + Snapshot() + Invoke(optimized) +
                "xor rax, [rsp]\nmov rcx, rax\n";
            int[] cells = [40, 48, 56, 64, 72, 80];
            for (int i = 0; i < cells.Length; i++)
                body += $"mov rax, [rsp-{cells[i]}]\nxor rax, [rsp+{8*(i+1)}]\nor rcx, rax\n";
            body += "mov [rsp], rcx\n";
            Assert.Equal(0, NativeStack.Run(body, 7, reference.Assembly + optimized.Assembly)[^1]);
        }
    }

    [Theory, MemberData(nameof(Profiles))]
    public void NamesAndArgumentLocalOrderDoNotDetermineRecognition(int profile)
    {
        string source = Source("1", "7", 32, 8)
            .Replace("t_uint64 bytesptr,t_uint64 size", "t_uint64 size,t_uint64 bytesptr")
            .Replace("t_uint64 cursor 1 t_uint64 total 7", "t_uint64 total 7 t_uint64 cursor 1")
            .Replace("Fold", "Renamed");
        var compiled = Compile(source, profile);
        Assert.Contains("stride 32, offset 8", compiled.Assembly);
        string body = $"push 3\nlea rax, [rel fixture]\npush rax\ncall {compiled.GetFunctionLabel("Renamed")}\nadd rsp, 16\npush rax";
        Assert.Equal(new long[] { 7+19+23 }, NativeStack.Run(body, 1, compiled.Assembly + "\nfixture: dq 0,17,0,0,0,19,0,0,0,23,0,0\n"));
    }

    [Theory]
    [InlineData(1, 0)] [InlineData(7, 3)] [InlineData(8, 0)] [InlineData(24, 16)] [InlineData(32, 8)] [InlineData(40, 39)]
    public void ArbitraryStridesOffsetsAndUnalignedReadsKeepTheSameResult(int stride, int offset)
    {
        var compiled = Compile(Source("0", "0", stride, offset), 7);
        string body = $"lea rax, [rel fixture+1]\npush rax\npush 5\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\npush rax";
        Assert.Equal(new long[] { unchecked((long)(5UL * 0x0101010101010101UL)) },
            NativeStack.Run(body, 1, compiled.Assembly + "\nfixture: times 256 db 1\n"));
    }

    [Fact]
    public void WrappingIndexProductAndPointerUseIntegerCellArithmetic()
    {
        var compiled = Compile(Source("18446744073709551614", "42"), 7);
        string body = $"lea rax, [rel fixture+32]\npush rax\npush -1\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\npush rax";
        Assert.Equal(new long[] { 59 }, NativeStack.Run(body, 1, compiled.Assembly + "\nfixture: dq 17\n"));
    }

    [Fact]
    public void LargestSupportedConstantsAreNotSignExtended()
    {
        var compiled = Compile(Source("0", "42", int.MaxValue, int.MaxValue), 7);
        string body = $"lea rax, [rel fixture]\nsub rax, 2147483647\npush rax\npush 1\ncall {compiled.GetFunctionLabel("Fold")}\nadd rsp, 16\npush rax";
        Assert.Equal(new long[] { 59 }, NativeStack.Run(body, 1, compiled.Assembly + "\nfixture: dq 17\n"));
    }

    [Theory]
    [InlineData("load t_uint64\nadd", "load t_uint32\nadd")]
    [InlineData("while @cursor < @size", "while @cursor <= @size")]
    [InlineData("push 24\nmul", "push 0\nmul")]
    [InlineData("push 24\nmul", "push -1\nmul")]
    [InlineData("load @total\nreturn", "load @total\npush 1\nadd\nreturn")]
    [InlineData("t_uint64 cursor 0", "t_uint32 cursor 0")]
    public void DifferentWidthsEffectsConditionsAndUnsupportedConstantsUseReference(string before, string after)
    {
        var compiled = Compile(Source().Replace(before, after), 7);
        Assert.DoesNotContain("; record-reductions:", compiled.Assembly);
    }

    [Fact]
    public void ValidationAndDefaultBehaviorRemainUnchanged()
    {
        Assert.DoesNotContain("; record-reductions:", SourceCompiler.Compile(Source(), emitProcessEntryPoint: false).Assembly);
        string invalid = Source().Replace("return", "return t_int32");
        Assert.ThrowsAny<Exception>(() => Compile(invalid, 7, false));
        Assert.ThrowsAny<Exception>(() => Compile(invalid, 7));
        var compiled = SourceCompiler.Compile(Source(), emitProcessEntryPoint: false,
            optimizeRecordReductions: true, optimizeLoopReductions: true, optimizeBlockReductions: true,
            optimizeNativeBlockReductions: true);
        Assert.Contains("; record-reductions:", compiled.Assembly);
        Assert.DoesNotContain("; block-reductions:", compiled.Assembly);
    }

    private static string Snapshot() => string.Join('\n', new[] { 40,48,56,64,72,80 }.Select((offset,i) =>
        $"mov rax, [rsp-{offset}]\nmov [rsp+{8*(i+1)}], rax")) + "\n";
}
