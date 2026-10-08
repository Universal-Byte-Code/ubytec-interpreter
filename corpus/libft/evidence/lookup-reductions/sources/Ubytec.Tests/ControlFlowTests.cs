using Ubytec.Language.AST;
using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Xunit;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Tests;

public class ControlFlowTests
{
    private static string Source(string body) =>
        "module (name:\"flow\", version:\"0.1\", author:\"Ubytec\")\n{\nfunc Main() -> t_int64\n{\n" + body + "\n}\n}\n";
    private static long Execute(string body)
    {
        var compiled = SourceCompiler.Compile(Source(body));
        return Assert.Single(NativeStack.Run($"call {compiled.EntryLabel}\n push rax", 1, compiled.Assembly));
    }

    [Theory]
    [InlineData(0, 0)]
    [InlineData(1, 1)]
    [InlineData(6, 6)]
    public void WhileConsumesAndReplenishesStackCondition(int count, int expected)
    {
        Assert.Equal(expected, Execute($"t_int64 n {count}\nt_int64 sum 0\nload @n\nwhile\nload @sum\ninc\nstore @sum\nload @n\ndec\nstore @n\nload @n\nend\nload @sum\nreturn"));
    }

    [Fact]
    public void WhileReadsUpdatedNamedValuesAndContinueRechecksCondition() =>
        Assert.Equal(5, Execute("t_int64 n 0\nwhile @n < 5\nload @n\ninc\nstore @n\ncontinue\nend\nload @n\nreturn"));

    [Fact]
    public void LoopBreakInsideIfPreservesLexicalScopes() =>
        Assert.Equal(4, Execute("t_int64 n 0\nloop\nload @n\ninc\nstore @n\nif @n == 4\nbreak\nend\nend\nload @n\nreturn"));

    [Fact]
    public void NestedLoopBreakOnlyExitsInnermostLoop() =>
        Assert.Equal(6, Execute("t_int64 n 0\nt_int64 outer 0\nwhile @outer < 3\nloop\nload @n\npush 2\nadd\nstore @n\nbreak\nend\nload @outer\ninc\nstore @outer\nend\nload @n\nreturn"));

    [Fact]
    public void ContinueFromNestedIfSkipsRemainingIterationBody() =>
        Assert.Equal(30, Execute("t_int64 n 0\nt_int64 sum 0\nwhile @n < 5\nload @n\ninc\nstore @n\nif @n <= 2\ncontinue\nend\nload @sum\npush 10\nadd\nstore @sum\nend\nload @sum\nreturn"));

    [Theory]
    [InlineData(1, 10)]
    [InlineData(2, 20)]
    [InlineData(3, 99)]
    public void SwitchSelectsOneBranchOrDefault(int selector, int expected) =>
        Assert.Equal(expected, Execute($"t_int64 result 0\npush {selector}\nswitch\nbranch 1\npush 10\nstore @result\nend\nbranch 2\npush 20\nstore @result\nend\ndefault\npush 99\nstore @result\nend\nload @result\nreturn"));

    [Fact]
    public void SwitchWithoutMatchPreservesCallerEvaluationStack() =>
        Assert.Equal(42, Execute("push 42\npush 3\nswitch\nbranch 1\nnop\nend\nend\nreturn"));

    [Fact]
    public void BreakInSwitchBranchSkipsRemainingCases() =>
        Assert.Equal(7, Execute("t_int64 result 0\npush 1\nswitch\nbranch 1\npush 7\nstore @result\nbreak\npush 99\nstore @result\nend\ndefault\npush 100\nstore @result\nend\nload @result\nreturn"));

    [Theory]
    [InlineData("break")]
    [InlineData("continue")]
    [InlineData("loop\npush 1\nend")]
    [InlineData("push 1\nwhile\nnop\nend")]
    [InlineData("loop\npush 1\nbreak\nend")]
    [InlineData("push 1\nswitch\nbranch 1\npush 2\nend\nend")]
    [InlineData("push 1\nswitch\npop\nend")]
    public void RejectsInvalidControlTargetsAndStackPaths(string body) =>
        Assert.ThrowsAny<Exception>(() => SourceCompiler.Compile(Source(body + "\npush 0\nreturn")));

    [Fact]
    public void ScopeLookupDoesNotReorderScopes()
    {
        var scopes = new CompilationScopes();
        var outer = new ScopeContext { StartLabel = "loop_outer", DeclaredByKeyword = "loop" };
        var inner = new ScopeContext { StartLabel = "if_inner", DeclaredByKeyword = "if" };
        scopes.Push(outer); scopes.Push(inner);
        Assert.Same(outer, scopes.Find(x => x.IsLoop));
        Assert.Same(inner, scopes.Peek());
        Assert.Equal(2, scopes.FinalizersCount);
        new END().Compile(scopes);
        Assert.Same(outer, scopes.Peek());
        Assert.Equal(1, scopes.FinalizersCount);
    }

    [Fact]
    public void NamedConditionHandlesFullWidthLiterals() =>
        Assert.Equal(42, Execute("if 9223372036854775807 > 4294967296\npush 42\nelse\npush 0\nend\nreturn"));

    [Theory]
    [InlineData("t_bool flag 256\nload @flag\nreturn")]
    [InlineData("t_bool flag 0\npush 256\nstore @flag\nload @flag\nreturn")]
    public void BooleanFrameValuesAreCanonical(string body) => Assert.Equal(1, Execute(body));

    [Fact]
    public void LabeledBreakFindsOuterSwitchThroughInnerLoop() =>
        Assert.Equal(42, Execute("push 1\nswitch 7\nbranch 1\nloop\nbreak 7\nend\nend\nend\npush 42\nreturn"));

    [Fact]
    public void NestedSwitchesUseIndependentSelectorSlots() =>
        Assert.Equal(42, Execute("t_int64 result 0\npush 1\nswitch\nbranch 1\npush 2\nswitch\nbranch 2\npush 42\nstore @result\nend\nend\nend\nend\nload @result\nreturn"));

    [Theory]
    [InlineData("while @missing < 3\nbreak\nend")]
    [InlineData("if @missing < 3\nnop\nend")]
    [InlineData("if @n <\nnop\nend")]
    [InlineData("loop\nbreak 999\nend")]
    public void RejectsUnknownConditionSymbolsAndLabels(string body) =>
        Assert.ThrowsAny<Exception>(() => SourceCompiler.Compile(Source(body + "\npush 0\nreturn")));

    [Fact]
    public void MissingModuleBraceIsRejected() =>
        Assert.ThrowsAny<Exception>(() => SourceCompiler.Compile(Source("push 0\nreturn").TrimEnd()[..^1]));

    [Fact]
    public void CompleteControlFlowExampleReturns42()
    {
        var compiled = SourceCompiler.Compile(File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "control-flow.ubc")));
        Assert.Equal(42, Assert.Single(NativeStack.Run($"call {compiled.EntryLabel}\n push rax", 1, compiled.Assembly)));
    }

    [Fact]
    public void UntypedBlockMayProduceAValue() => Assert.Equal(42, Execute("block\npush 42\nend\nreturn"));

    [Fact]
    public void TypedBlockProducesAndNarrowsItsResult() => Assert.Equal(-1, Execute("block t_int16\npush 65535\nend\nreturn"));

    [Fact]
    public void TypedBlockWithoutResultIsRejected() =>
        Assert.ThrowsAny<Exception>(() => SourceCompiler.Compile(Source("block t_int16\nnop\nend\npush 0\nreturn")));

    [Theory]
    [InlineData("t_uint64 left 18446744073709551615\nt_uint64 right 1\nif @left > @right\npush 42\nelse\npush 0\nend\nreturn")]
    [InlineData("if t_uint64 18446744073709551615 > 1\npush 42\nelse\npush 0\nend\nreturn")]
    public void UnsignedConditionsRespectDeclaredOrdering(string body) => Assert.Equal(42, Execute(body));

    [Fact]
    public void WideningRulesRejectUnsignedToSameWidthSigned()
    {
        Assert.False(Ubytec.Language.Syntax.TypeSystem.Types.ValidateImplicitCast(
            Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.UInt64, Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.Int64));
        Assert.False(Ubytec.Language.Syntax.TypeSystem.Types.ValidateImplicitCast(
            Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.UInt32, Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.Int32));
        Assert.True(Ubytec.Language.Syntax.TypeSystem.Types.ValidateImplicitCast(
            Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.UInt32, Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.Int64));
    }

    [Fact]
    public void NumericConditionFactoryRetainsDefaultTypeCompatibility()
    {
        var scopes = new CompilationScopes();
        var condition = IF.CreateInstruction([], [], 1, (byte)'<', (byte)0, 2);
        string assembly = condition.Compile(scopes) + "\n push 42\n" +
            new ELSE().Compile(scopes) + "\n push 0\n" + new END().Compile(scopes);
        Assert.Equal(42, Assert.Single(NativeStack.Run(assembly, 1)));
        Assert.Equal(0, scopes.Count);
        Assert.Equal(0, scopes.FinalizersCount);
    }

    [Fact]
    public void FinalizerLookupPreservesOrder()
    {
        var scopes = new CompilationScopes();
        scopes.Push(new ScopeContext());
        var outer = scopes.PeekFinalizers();
        scopes.Push(new ScopeContext());
        var inner = scopes.PeekFinalizers();
        Assert.Same(outer, scopes.FindFinalizers(x => x == outer));
        Assert.Same(inner, scopes.PeekFinalizers());
    }

    [Fact]
    public void RemovingMatchedScopeKeepsRemainingPairsInOrder()
    {
        var scopes = new CompilationScopes();
        var outer = new ScopeContext();
        var middle = new ScopeContext();
        var inner = new ScopeContext();
        scopes.Push(outer);
        var outerFinalizers = scopes.PeekFinalizers();
        scopes.Push(middle);
        scopes.Push(inner);
        var innerFinalizers = scopes.PeekFinalizers();
        Assert.Same(middle, scopes.TryPopUntil(x => x == middle));
        Assert.Same(inner, scopes.Peek());
        Assert.Same(innerFinalizers, scopes.Pop().finalizers);
        Assert.Same(outer, scopes.Peek());
        Assert.Same(outerFinalizers, scopes.PeekFinalizers());
    }

    [Theory]
    [InlineData(1, 42)]
    [InlineData(2, 7)]
    public void SwitchCanReturnOnEveryPath(int selector, int expected) =>
        Assert.Equal(expected, Execute($"push {selector}\nswitch\nbranch 1\npush 42\nreturn\nend\ndefault\npush 7\nreturn\nend"));

    [Fact]
    public void FunctionCanReturnDirectlyFromAnUnconditionalLoop() =>
        Assert.Equal(42, Execute("loop\npush 42\nreturn\nend"));

    [Fact]
    public void ReturnAfterBreakDoesNotHideFunctionFallthrough() =>
        Assert.ThrowsAny<Exception>(() => SourceCompiler.Compile(Source("push 1\nswitch\nbranch 1\nbreak\npush 42\nreturn\nend\ndefault\npush 7\nreturn\nend")));
}
