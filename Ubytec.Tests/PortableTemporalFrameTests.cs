using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableTemporalFrameTests
{
    private static byte[] Image(string functions)
    {
        var source = SourceCompiler.Compile($$"""
            module (name:"temporal-frame", version:"0.1", author:"Ubytec")
            {
                {{functions}}
            }
            """, emitProcessEntryPoint: false);
        return PortableModuleFormat.Encode(source.Module, contractManifest: null,
            includeIndexedExecutable: true, portableContracts: source.PortableContracts,
            executionProfile: PortableExecutionProfile.DirectOnly);
    }

    [Theory]
    [InlineData(false)]
    [InlineData(true)]
    public void RecursiveCallsHaveDistinctActivationsAndDeterministicUnwind(bool fault)
    {
        string leaf = fault ? "trap" : "push 7\nreturn";
        byte[] image = Image($$"""
            func Main() -> t_int64 {
                push 2
                call Recur
                return
            }
            func Recur(t_int64 n) -> t_int64 {
                if @n <= 0
                    {{leaf}}
                end
                load @n
                dec
                call Recur
                return
            }
            """);
        var serial = PortableTemporalScalarReference.Run(image, [0, 0], quantum: 2);
        var parallel = PortableTemporalScalarReference.Run(image, [0, 0], quantum: 2, parallel: true);
        Assert.Equal(serial.SemanticState.Trace.ToArray(), parallel.SemanticState.Trace.ToArray());
        Assert.Equal(new ulong?[] { fault ? null : 7UL, fault ? null : 7UL }, serial.Results.ToArray());
        foreach (var context in serial.Trace.GroupBy(e => e.Event.Id.Context))
        {
            var calls = context.Where(e => e.Kind == PortableScalarBoundaryKind.Call).ToArray();
            Assert.Equal(3, calls.Length);
            Assert.All(calls, e => Assert.Equal(1U, e.Event.Scalar!.TargetFunction));
            var enters = context.Where(e => e.Kind == PortableScalarBoundaryKind.Enter).ToArray();
            Assert.Equal(new ulong[] { 1, 2, 3, 4 }, enters.Select(e => e.Event.Lifecycle!.Value.Activation.Ordinal));
            var exits = context.Where(e => e.Kind == (fault ? PortableScalarBoundaryKind.Abort : PortableScalarBoundaryKind.Return));
            Assert.Equal(new ulong[] { 4, 3, 2, 1 }, exits.Select(e => e.Event.Lifecycle!.Value.Activation.Ordinal));
            Assert.Equal(fault ? 1 : 0, context.Count(e => e.Kind == PortableScalarBoundaryKind.Trap));
            foreach (var enter in enters.Skip(1))
            {
                var previous = context.Last(e => e.Event.Id.Sequence < enter.Event.Id.Sequence);
                Assert.Equal(PortableScalarBoundaryKind.Call, previous.Kind);
                Assert.Equal(previous.Fuel, enter.Fuel);
            }
        }
        if (!fault)
        {
            var native = PortableX64Backend.Compile(image);
            Assert.Equal(7L, Assert.Single(NativeStack.Run($"call {native.GetFunctionLabel(0)}\npush rax", 1, native.Assembly)));
        }
        Assert.Throws<InvalidOperationException>(() => PortableTemporalScalarReference.Run(image, [0], maxDepth: 2));
    }

    [Theory]
    [InlineData("block checked (t_int64, t_int64) -> t_int16", "add", 142L)]
    [InlineData("block checked (t_int64, t_int64) -> t_int16", "add\nbreak", 142L)]
    [InlineData("block checked 9 (t_int64, t_int64) -> t_int16", "add\nloop\nbreak 9\nend", 142L)]
    public void ContractedBlocksPreservePrefixAndMatchNative(string header, string body, long expected)
    {
        byte[] image = Image($$"""
            func Main() -> t_int64 {
                push 100
                push 2
                push 40
                {{header}}
                {{body}}
                end
                add
                return
            }
            """);
        var managed = PortableTemporalScalarReference.Run(image, [0], quantum: 2);
        Assert.Equal((ulong)expected, Assert.Single(managed.Results));
        var native = PortableX64Backend.Compile(image);
        Assert.Equal(expected, Assert.Single(NativeStack.Run($"call {native.GetFunctionLabel(0)}\npush rax", 1, native.Assembly)));
    }

    [Theory]
    [InlineData("push 65535\nblock checked (t_int16) -> t_int16\nend", "CheckedBlockInput")]
    [InlineData("block checked () -> t_int16\npush 65535\nend", "CheckedBlockResult")]
    [InlineData("block checked () -> t_int16\npush 65535\nbreak\nend", "CheckedBlockResult")]
    public void CheckedConversionsFaultAtAttemptedPortableInstruction(string body, string reason)
    {
        byte[] image = Image("func Main() -> t_int64 {\n" + body + "\nreturn\n}");
        var outcome = PortableTemporalScalarReference.Run(image, [0], quantum: 1);
        Assert.Null(Assert.Single(outcome.Results));
        Assert.Equal(reason, outcome.Trace.Single(e => e.Kind == PortableScalarBoundaryKind.Trap).Event.Scalar!.FaultReason);
        Assert.Equal(PortableScalarBoundaryKind.Abort, outcome.Trace[^2].Kind);
    }

    [Fact]
    public void FrameLocalsAndConditionalBranchesArePrivateAcrossContexts()
    {
        byte[] image = Image("""
            func Main() -> t_int64 {
                local { t_int64 count 2 }
                load @count
                dec
                store @count
                load @count
                if
                    push 42
                else
                    push 7
                end
                return
            }
            """);
        var managed = PortableTemporalScalarReference.Run(image, [0, 0], quantum: 2, parallel: true);
        Assert.Equal(new ulong?[] { 42, 42 }, managed.Results.ToArray());
        var native = PortableX64Backend.Compile(image);
        Assert.Equal(42L, Assert.Single(NativeStack.Run($"call {native.GetFunctionLabel(0)}\npush rax", 1, native.Assembly)));
    }

    [Fact]
    public void NewlySupportedCalleeExecutesThroughDirectCall()
    {
        byte[] image = Image("""
            func Main() -> t_int64 {
                call Other
                return
            }
            func Other() -> t_int64 {
                push 3
                push 2
                sub
                return
            }
            """);
        Assert.Equal(1UL, Assert.Single(PortableTemporalScalarReference.Run(image, [0]).Results));
    }
}
