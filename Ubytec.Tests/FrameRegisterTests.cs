using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class FrameRegisterTests
{
    private static SourceCompilation Compile(string source, bool transfers = false, bool frames = false) =>
        SourceCompiler.Compile(source, emitProcessEntryPoint: false, optimizeStackTransfers: transfers,
            optimizeFrameValues: frames, optimizeFrameRegisters: true);

    [Theory]
    [InlineData(false, false)] [InlineData(true, false)]
    [InlineData(false, true)] [InlineData(true, true)]
    public void ReadOfAliasedArgumentSeesEveryWriteAcrossBackEdges(bool transfers, bool frames)
    {
        const string source = """
        module (name:"read_alias",version:"0.1",author:"Ubytec") {
        func Observe(t_uint64 value,t_uint64 pointer) -> t_uint64 {
        local { t_uint64 i 0 t_uint64 total 0 }
        while @i < 3
        load @value
        inc
        store @value
        load @total
        load @pointer
        load t_uint64
        add
        store @total
        load @i
        inc
        store @i
        end
        load @total
        return
        }
        }
        """;
        var compiled = Compile(source, transfers, frames);
        Assert.Contains("; frame-registers:", compiled.Assembly);
        string body = $"push 42\nlea rax, [rsp]\npush rax\ncall {compiled.GetFunctionLabel("Observe")}\nadd rsp, 16\npush rax";
        Assert.Equal(new long[] { 132 }, NativeStack.Run(body, 1, compiled.Assembly));
    }

    [Theory]
    [InlineData(false, false)] [InlineData(true, false)]
    [InlineData(false, true)] [InlineData(true, true)]
    public void BranchContinueBreakAndWrappingKeepValuesCoherent(bool transfers, bool frames)
    {
        const string source = """
        module (name:"register_flow",version:"0.1",author:"Ubytec") {
        func Main() -> t_uint64 {
        local { t_uint64 i 0 t_uint64 sum 18446744073709551615 }
        loop
        load @i
        inc
        store @i
        if @i == 2
        continue
        end
        if @i == 5
        break
        end
        load @sum
        load @i
        add
        store @sum
        end
        load @sum
        return
        }
        }
        """;
        var compiled = Compile(source, transfers, frames);
        Assert.Contains("; frame-registers:", compiled.Assembly);
        Assert.Equal(new long[] { 7 }, NativeStack.Run($"call {compiled.GetFunctionLabel("Main")}\npush rax", 1, compiled.Assembly));
    }

    [Theory]
    [InlineData("twoswap", true, 4)]
    [InlineData("tworot", false, 6)]
    public void ExtendedStackScratchRegistersAreReserved(string instruction, bool eligible, int count)
    {
        string pushes = string.Join('\n', Enumerable.Range(1, count).Select(i => $"push {i}"));
        string pops = string.Join('\n', Enumerable.Range(1, count).Select(_ => "pop"));
        string source = """
        module (name:"register_scratch",version:"0.1",author:"Ubytec") {
        func Main() -> t_uint64 {
        local { t_uint64 i 0 }
        while @i < 3
        """ + "\n" + pushes + "\n" + instruction + "\n" + pops + "\n" + """
        load @i
        inc
        store @i
        end
        load @i
        return
        }
        }
        """;
        var compiled = Compile(source);
        Assert.Equal(eligible, compiled.Assembly.Contains("; frame-registers:"));
        if (eligible) Assert.DoesNotContain("mov r8, qword", compiled.Assembly);
        Assert.Equal(new long[] { 3 }, NativeStack.Run($"call {compiled.GetFunctionLabel("Main")}\npush rax", 1, compiled.Assembly));
    }

    [Theory]
    [InlineData(false)] [InlineData(true)]
    public void Push16InsideCachedLoopKeepsPhysicalCellBytes(bool transfers)
    {
        const string source = """
        module (name:"register_stack_bytes",version:"0.1",author:"Ubytec") {
        func Main() -> t_uint64 {
        local { t_uint64 i 0 t_uint64 sum 0 }
        while @i < 3
        push 1234605616436508552
        push 12302652060662169617
        push16 7
        load @sum
        add
        store @sum
        pop
        pop
        load @i
        inc
        store @i
        end
        load @sum
        return
        }
        }
        """;
        var compiled = Compile(source, transfers);
        Assert.Contains("; frame-registers:", compiled.Assembly);
        Assert.Equal(new long[] { 3 * 0x88AA }, NativeStack.Run($"call {compiled.GetFunctionLabel("Main")}\npush rax", 1, compiled.Assembly));
    }

    [Fact]
    public void NarrowBindingsRetainTheirStorageAndLoadRules()
    {
        const string source = """
        module (name:"register_narrow",version:"0.1",author:"Ubytec") {
        func Main() -> t_int64 {
        local { t_uint64 i 0 t_sbyte value 255 }
        while @i < 2
        load @value
        push 1
        add
        store @value
        load @i
        inc
        store @i
        end
        load @value
        return
        }
        }
        """;
        var compiled = Compile(source);
        Assert.Contains("; frame-registers:", compiled.Assembly);
        Assert.Contains("movsx rax, byte", compiled.Assembly);
        var baseline = SourceCompiler.Compile(source, emitProcessEntryPoint: false);
        Assert.Equal(new long[] { 1 }, NativeStack.Run($"call {baseline.GetFunctionLabel("Main")}\npush rax", 1, baseline.Assembly));
        Assert.Equal(new long[] { 1 }, NativeStack.Run($"call {compiled.GetFunctionLabel("Main")}\npush rax", 1, compiled.Assembly));
    }

    [Fact]
    public void InlineDeclarationsInitializeOnTheirOriginalPaths()
    {
        const string source = """
        module (name:"register_inline",version:"0.1",author:"Ubytec") {
        func Main() -> t_uint64 {
        local { t_uint64 i 0 t_uint64 sum 0 }
        while @i < 3
        t_uint64 temporary 7
        load @sum
        load @temporary
        add
        store @sum
        load @i
        inc
        store @i
        end
        load @sum
        return
        }
        }
        """;
        var compiled = Compile(source);
        Assert.Equal(new long[] { 21 }, NativeStack.Run($"call {compiled.GetFunctionLabel("Main")}\npush rax", 1, compiled.Assembly));
    }
}
