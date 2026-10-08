using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

/// <summary>Observations shared by the source language and its native stack ABI.</summary>
public class ObservableContractTests
{
    [Theory]
    [InlineData(false, false, false)] [InlineData(false, false, true)] [InlineData(true, false, false)] [InlineData(true, false, true)]
    [InlineData(false, true, false)] [InlineData(false, true, true)] [InlineData(true, true, false)] [InlineData(true, true, true)]
    public void RawPointerWriteChangesNamedArgumentAcrossLoop(bool transfers, bool frames, bool registers)
    {
        const string source = """
        module (name:"observable_alias",version:"0.1",author:"Ubytec") {
        func Observe(t_uint64 value,t_uint64 pointer) -> t_uint64 {
        local { t_uint64 i 0 }
        while @i < 2
        load @value
        pop
        load @pointer
        load @value
        inc
        store t_uint64
        load @i
        inc
        store @i
        end
        load @value
        return
        }
        }
        """;
        if (registers) Assert.DoesNotContain("; frame-registers:", Compile(source, transfers, frames, registers).Assembly);
        Assert.Equal(44L, RunAliasedArgument(source, transfers, frames, registers));
    }

    [Theory]
    [InlineData(false, false, false)] [InlineData(false, false, true)] [InlineData(true, false, false)] [InlineData(true, false, true)]
    [InlineData(false, true, false)] [InlineData(false, true, true)] [InlineData(true, true, false)] [InlineData(true, true, true)]
    public void NamedArgumentWriteIsVisibleThroughRawPointer(bool transfers, bool frames, bool registers)
    {
        const string source = """
        module (name:"observable_store",version:"0.1",author:"Ubytec") {
        func Observe(t_uint64 value,t_uint64 pointer) -> t_uint64 {
        push 99
        store @value
        load @pointer
        load t_uint64
        return
        }
        }
        """;
        Assert.Equal(99L, RunAliasedArgument(source, transfers, frames, registers));
    }

    [Theory]
    [InlineData(false, false, false, false)] [InlineData(false, false, false, true)] [InlineData(true, false, false, false)] [InlineData(true, false, false, true)]
    [InlineData(false, true, false, false)] [InlineData(false, true, false, true)] [InlineData(true, true, false, false)] [InlineData(true, true, false, true)]
    [InlineData(false, false, true, false)] [InlineData(false, false, true, true)] [InlineData(true, false, true, false)] [InlineData(true, false, true, true)]
    [InlineData(false, true, true, false)] [InlineData(false, true, true, true)] [InlineData(true, true, true, false)] [InlineData(true, true, true, true)]
    public void DirectAndIndirectCallsCanMutateAliasedArgument(bool transfers, bool frames, bool indirect, bool registers)
    {
        string call = indirect ? "fnaddr Mutate\ncalli 1 t_void" : "call Mutate";
        string source = """
        module (name:"observable_call",version:"0.1",author:"Ubytec") {
        func Mutate(t_uint64 pointer) -> t_void {
        load @pointer
        push 99
        store t_uint64
        return
        }
        func Observe(t_uint64 value,t_uint64 pointer) -> t_uint64 {
        load @value
        pop
        load @pointer
        """ + "\n" + call + "\n" + """
        load @value
        return
        }
        }
        """;
        if (registers) Assert.DoesNotContain("; frame-registers:", Compile(source, transfers, frames, registers).Assembly);
        Assert.Equal(99L, RunAliasedArgument(source, transfers, frames, registers));
    }

    [Theory]
    [InlineData(false, false, false)] [InlineData(false, false, true)] [InlineData(true, false, false)] [InlineData(true, false, true)]
    [InlineData(false, true, false)] [InlineData(false, true, true)] [InlineData(true, true, false)] [InlineData(true, true, true)]
    public void Push16ReadsLittleEndianBytesAcrossLiveCells(bool transfers, bool frames, bool registers)
    {
        const string source = """
        module (name:"observable_bytes",version:"0.1",author:"Ubytec") {
        func Main() -> t_uint64 {
        push 1234605616436508552
        push 12302652060662169617
        push16 7
        return
        }
        }
        """;
        var compiled = Compile(source, transfers, frames, registers);
        Assert.Equal(new long[] { 0x88AA }, NativeStack.Run(
            $"call {compiled.GetFunctionLabel("Main")}\npush rax", 1, compiled.Assembly));
    }

    private static SourceCompilation Compile(string source, bool transfers, bool frames, bool registers) =>
        SourceCompiler.Compile(source, emitProcessEntryPoint: false,
            optimizeStackTransfers: transfers, optimizeFrameValues: frames, optimizeFrameRegisters: registers);

    private static long RunAliasedArgument(string source, bool transfers, bool frames, bool registers)
    {
        var compiled = Compile(source, transfers, frames, registers);
        // Point the second argument at the first argument's actual incoming ABI cell.
        // This is a valid host-provided pointer, not an address guessed by the source.
        string body = $"push 42\nlea rax, [rsp]\npush rax\n" +
            $"call {compiled.GetFunctionLabel("Observe")}\nadd rsp, 16\npush rax";
        return Assert.Single(NativeStack.Run(body, 1, compiled.Assembly));
    }
}
