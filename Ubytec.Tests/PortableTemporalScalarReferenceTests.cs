using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableTemporalScalarReferenceTests
{
    private static byte[] Image(string body)
    {
        var source = SourceCompiler.Compile($$"""
            module (name:"temporal-scalar", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    {{body}}
                }
            }
            """, emitProcessEntryPoint: false);
        return PortableModuleFormat.Encode(source.Module, contractManifest: null,
            includeIndexedExecutable: true, portableContracts: source.PortableContracts,
            executionProfile: PortableExecutionProfile.DirectOnly);
    }

    [Fact]
    public void ActualPortableInstructionsConsumeFuelAndShareStaticNotDynamicIdentity()
    {
        byte[] image = Image("push 20\npush 22\nadd\nreturn");
        var outcome = PortableTemporalScalarReference.Run(image, [0, 0], quantum: 2);
        Assert.Equal(new ulong?[] { 42, 42 }, outcome.Results.ToArray());
        Assert.Equal(new ulong[] { 1, 1, 2, 2, 3, 3, 4, 4 }, outcome.Trace.Select(e => e.Round));
        Assert.Equal(new[] { PortableScalarBoundaryKind.Enter, PortableScalarBoundaryKind.Enter,
            PortableScalarBoundaryKind.Budget, PortableScalarBoundaryKind.Budget,
            PortableScalarBoundaryKind.Return, PortableScalarBoundaryKind.Return,
            PortableScalarBoundaryKind.Terminate, PortableScalarBoundaryKind.Terminate },
            outcome.Trace.Select(e => e.Kind));
        Assert.Equal(new ulong[] { 0, 0, 2, 2, 4, 4, 4, 4 }, outcome.Trace.Select(e => e.Fuel));
        Assert.Equal(new ulong[] { 1, 2, 1, 2, 1, 2, 1, 2 }, outcome.Trace.Select(e => e.Event.Id.Context.Ordinal));
        Assert.Equal(new ulong[] { 3, 4, 5, 6, 7, 8, 9, 10 }, outcome.Trace.Select(e => e.Event.CommitSequence));
        Assert.Equal(new ulong[] { 2, 3, 3, 4, 4, 5, 5, 6 }, outcome.Trace.Select(e => e.Event.LogicalTime));
        Assert.Equal(PortableBinaryVerifier.IdentifyInstruction(image, 0, 10), outcome.Trace[2].Occurrence);
        Assert.Equal(outcome.Trace[2].Occurrence, outcome.Trace[3].Occurrence);
        Assert.NotEqual(outcome.Trace[2].Event.Id, outcome.Trace[3].Event.Id);
        var again = PortableTemporalScalarReference.Run(image, [0, 0], quantum: 2, parallel: true);
        Assert.Equal(Normalize(outcome), Normalize(again));
        Assert.Equal(outcome.SemanticState.Trace.ToArray(), again.SemanticState.Trace.ToArray());
        Assert.Equal(outcome.SemanticState.Contexts.ToArray(), again.SemanticState.Contexts.ToArray());
        Assert.NotEqual(outcome.Trace[0].Event.Id.Context.Session, again.Trace[0].Event.Id.Context.Session);

        var native = PortableX64Backend.Compile(image);
        Assert.Equal(42L, Assert.Single(NativeStack.Run(
            $"call {native.GetFunctionLabel(0)}\npush rax", 1, native.Assembly)));
    }

    [Fact]
    public void ExplicitTrapConsumesFuelAndAbortsOnSeparateBoundary()
    {
        var outcome = PortableTemporalScalarReference.Run(Image("trap"), [0], quantum: 1);
        Assert.Null(Assert.Single(outcome.Results));
        Assert.Equal(new[] { PortableScalarBoundaryKind.Enter, PortableScalarBoundaryKind.Trap,
            PortableScalarBoundaryKind.Abort, PortableScalarBoundaryKind.Terminate }, outcome.Trace.Select(e => e.Kind));
        Assert.Equal(new ulong[] { 0, 1, 1, 1 }, outcome.Trace.Select(e => e.Fuel));
        Assert.Equal(0U, outcome.Trace[1].Occurrence!.Value.InstructionOffset);
        Assert.Equal(PortableLifecycleKind.Abort, outcome.Trace[2].Event.Lifecycle!.Value.Kind);
    }

    [Fact]
    public void LoopTransfersChargeOnlyAttemptedInstructionsAndReturnBeatsBudget()
    {
        var outcome = PortableTemporalScalarReference.Run(
            Image("loop\nnop\nbreak\nend\npush 42\nreturn"), [0], quantum: 2);
        Assert.Equal(42UL, Assert.Single(outcome.Results));
        Assert.Equal(new[] { PortableScalarBoundaryKind.Enter, PortableScalarBoundaryKind.Budget,
            PortableScalarBoundaryKind.Budget, PortableScalarBoundaryKind.Return, PortableScalarBoundaryKind.Terminate },
            outcome.Trace.Select(e => e.Kind));
        Assert.Equal(new ulong[] { 0, 2, 4, 5, 5 }, outcome.Trace.Select(e => e.Fuel));

        var exact = PortableTemporalScalarReference.Run(Image("nop\npush 42\nreturn"), [0], quantum: 3);
        Assert.DoesNotContain(exact.Trace, e => e.Kind == PortableScalarBoundaryKind.Budget);
        Assert.Equal(3UL, exact.Trace.Single(e => e.Kind == PortableScalarBoundaryKind.Return).Fuel);
    }

    [Fact]
    public void PureLoopAndContinueCannotEscapeEventBudget()
    {
        foreach (string body in new[] { "loop\nnop\nend", "loop\ncontinue\nend" })
            Assert.Throws<InvalidOperationException>(() =>
                PortableTemporalScalarReference.Run(Image(body), [0], quantum: 2, maxEvents: 5));
    }

    [Fact]
    public void UnsupportedAndInvalidImagesFailClosed()
    {
        Assert.Throws<NotSupportedException>(() =>
            PortableTemporalScalarReference.Run(Image("push 3\npush 2\nsub\nreturn"), [0]));
        byte[] image = Image("push 1\nreturn");
        Assert.Throws<InvalidDataException>(() => PortableTemporalScalarReference.Run(image, [1]));
        Assert.Throws<InvalidDataException>(() => PortableTemporalScalarReference.Run(image[..^1], [0]));
        Assert.Throws<InvalidOperationException>(() => PortableTemporalScalarReference.Run(image, [0], maxEvents: 1));
    }

    private static object[] Normalize(PortableScalarOutcome outcome) => outcome.Trace.Select(e => (object)
        (e.Round, e.Kind, e.Event.CommitSequence, e.Event.LogicalTime, e.Event.Id.Context.Ordinal,
         e.Event.Id.Sequence, e.Fuel, e.Occurrence, e.Result)).ToArray();
}
