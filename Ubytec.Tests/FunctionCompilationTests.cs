using Ubytec.Language.AST;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.Scopes;
using Xunit;

namespace Ubytec.Tests;

public class FunctionCompilationTests
{
    private static string Module(string body, string functions = "", string resultType = "t_int64") =>
        "module (name:\"test\", version:\"0.1\", author:\"Ubytec\")\n{\n" + functions +
        "\nfunc Main() -> " + resultType + "\n{\n" + body + "\n}\n}\n";

    private static long Execute(string source)
    {
        var compiled = SourceCompiler.Compile(source);
        Assert.NotNull(compiled.EntryLabel);
        return Assert.Single(NativeStack.Run($"call {compiled.EntryLabel}\n  push rax", 1, compiled.Assembly));
    }

    [Fact]
    public void CompleteSourceExampleReturns42() =>
        Assert.Equal(42, Execute(File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "answer.ubc"))));

    [Fact]
    public void ArgumentsAreOrderedAndCallerStackIsPreserved()
    {
        string functions = """
            func Subtract(t_int64 left, t_int64 right) -> t_int64
            {
                load @left
                load @right
                sub
                return
            }
            """;
        Assert.Equal(116, Execute(Module("push 99\npush 20\npush 3\ncall Subtract\nadd\nreturn", functions)));
    }

    [Fact]
    public void NestedCallsUseIndependentFrames()
    {
        string functions = """
            func Twice(t_int64 value) -> t_int64
            {
                local
                {
                    t_int64 temporary 2
                }
                load @value
                load @temporary
                mul
                return
            }
            func FourTimes(t_int64 value) -> t_int64
            {
                load @value
                call Twice
                call Twice
                return
            }
            """;
        Assert.Equal(42, Execute(Module("push 10\ncall FourTimes\npush 2\nadd\nreturn", functions)));
    }

    [Fact]
    public void VoidReturnDoesNotPopAResultAndCallerCleansArguments()
    {
        string functions = """
            func Consume(t_int64 value) -> t_void
            {
                load @value
                pop
                return
            }
            """;
        Assert.Equal(7, Execute(Module("push 7\npush 100\ncall Consume\nreturn", functions)));
    }

    [Fact]
    public void VoidFallthroughRestoresStackEvenWithTemporaries()
    {
        string functions = """
            func Ignore() -> t_void
            {
                push 123
            }
            """;
        Assert.Equal(8, Execute(Module("push 8\ncall Ignore\nreturn", functions)));
    }

    [Fact]
    public void LocalInitializationAndClearPreserveFrameStorage() =>
        Assert.Equal(42, Execute(Module("local\n{\nt_int64 counter 42\n}\npush 1\npush 2\nclear\nload @counter\nreturn")));

    [Fact]
    public void InlineVariablesAreInitializedAndMutable() =>
        Assert.Equal(12, Execute(Module("t_int64 result 10\nload @result\npush 2\nadd\nstore @result\nload @result\nreturn")));

    [Fact]
    public void StoresCanUpdateArguments()
    {
        string functions = """
            func Replace(t_int64 value) -> t_int64
            {
                push 5
                store @value
                load @value
                return
            }
            """;
        Assert.Equal(5, Execute(Module("push 1\ncall Replace\nreturn", functions)));
    }

    [Theory]
    [InlineData("t_int32", "4294967295", -1L)]
    [InlineData("t_uint32", "4294967295", 4294967295L)]
    [InlineData("t_int16", "65535", -1L)]
    [InlineData("t_uint16", "65535", 65535L)]
    [InlineData("t_sbyte", "255", -1L)]
    [InlineData("t_byte", "255", 255L)]
    public void NamedLoadsRespectDeclaredIntegerWidth(string type, string value, long expected) =>
        Assert.Equal(expected, Execute(Module($"local\n{{\n{type} item {value}\n}}\nload @item\nreturn")));

    [Fact]
    public void DataAndNestedBlocksKeepSourceOrder() =>
        Assert.Equal(12, Execute(Module("push 10\nblock t_void\npush 2\nadd\nend\nreturn")));

    [Theory]
    [InlineData(0, 17L)]
    [InlineData(1, 42L)]
    public void BothConditionalReturnsUseSharedEpilogue(int condition, long expected) =>
        Assert.Equal(expected, Execute(Module($"push {condition}\nif\npush 42\nreturn\nelse\npush 17\nreturn\nend")));

    [Theory]
    [InlineData(0, 42L)]
    [InlineData(1, 99L)]
    public void EarlyReturnRestoresLocalFrame(int condition, long expected) =>
        Assert.Equal(expected, Execute(Module($"local\n{{\nt_int64 result 42\n}}\npush {condition}\nif\npush 99\nreturn\nend\nload @result\nreturn")));

    [Fact]
    public void ExplicitReturnTypeParses() =>
        Assert.Equal(42, Execute(Module("push 42\nreturn t_int64")));

    [Theory]
    [InlineData("push 1\ncall Missing\nreturn")]
    [InlineData("load @missing\nreturn")]
    [InlineData("push 1\nstore @missing\npush 42\nreturn")]
    [InlineData("push 1")]
    [InlineData("push 1\nreturn t_int32")]
    [InlineData("push 1\nif\npush 2\nreturn\nend")]
    [InlineData("local\n{\nconst t_int64 item 1\n}\npush 2\nstore @item\nload @item\nreturn")]
    public void InvalidFunctionProgramsAreRejected(string body) =>
        Assert.Throws<SyntaxException>(() => SourceCompiler.Compile(Module(body)));

    [Fact]
    public void DuplicateFrameSymbolsAreRejected() =>
        Assert.Throws<SyntaxException>(() => SourceCompiler.Compile(Module("t_int64 item 1\nt_int64 item 2\nload @item\nreturn")));

    [Fact]
    public void MissingBodyBraceAndUnbalancedBlocksAreRejected()
    {
        Assert.ThrowsAny<Exception>(() => SourceCompiler.Compile("module (name:\"x\",version:\"1\",author:\"x\"){func Main()->t_int64{"));
        Assert.ThrowsAny<Exception>(() => SourceCompiler.Compile(Module("block t_void\npush 42\nreturn")));
        Assert.ThrowsAny<Exception>(() => SourceCompiler.Compile(Module("end\npush 42\nreturn")));
    }

    [Theory]
    [InlineData("t_byte", "256", 0L)]
    [InlineData("t_sbyte", "255", -1L)]
    [InlineData("t_int16", "65535", -1L)]
    [InlineData("t_uint16", "65535", 65535L)]
    [InlineData("t_int32", "4294967295", -1L)]
    [InlineData("t_uint32", "4294967295", 4294967295L)]
    [InlineData("t_bool", "2", 1L)]
    public void ReturnsRespectDeclaredIntegerWidth(string type, string value, long expected)
    {
        string functions = $"func Narrow() -> {type}\n{{\npush {value}\nreturn\n}}";
        Assert.Equal(expected, Execute(Module("call Narrow\nreturn", functions)));
    }

    [Theory]
    [InlineData("return")]
    [InlineData("push 1\nadd\nreturn")]
    [InlineData("push 1\ncall NeedsTwo\nreturn")]
    [InlineData("call NeedsTwo\nreturn")]
    [InlineData("push 1\nif\npush 42\nend\nreturn")]
    public void MissingArgumentsResultsAndInconsistentBranchesAreRejected(string body)
    {
        string functions = "func NeedsTwo(t_int64 left, t_int64 right) -> t_int64\n{\nload @left\nload @right\nadd\nreturn\n}";
        Assert.Throws<SyntaxException>(() => SourceCompiler.Compile(Module(body, functions)));
    }

    [Theory]
    [InlineData("CALL")]
    [InlineData("LOAD")]
    [InlineData("ADD")]
    [InlineData("PICK16")]
    public void NewInstructionFamiliesRoundTripThroughOpcodeJson(string name)
    {
        Ubytec.Language.Operations.Interfaces.IOpCode instruction = name switch
        {
            "CALL" => new FunctionOperations.CALL("Twice"),
            "LOAD" => new MemoryOperations.LOAD("counter"),
            "ADD" => new ArithmeticOperations.ADD(),
            _ => new Ubytec.Language.Operations.Extended.ExtendedStackOperations.PICK16(300)
        };
        var options = new System.Text.Json.JsonSerializerOptions();
        options.Converters.Add(new Ubytec.Language.Tools.Serialization.IOpCodeConverter());
        string json = System.Text.Json.JsonSerializer.Serialize(instruction, options);
        var restored = System.Text.Json.JsonSerializer.Deserialize<Ubytec.Language.Operations.Interfaces.IOpCode>(json, options);
        Assert.NotNull(restored);
        Assert.Equal(instruction, restored);
    }

    [Fact]
    public void FunctionCompilationRestoresScopesAfterErrors()
    {
        var scopes = new CompilationScopes();
        var tokens = new[] { new Ubytec.Language.Syntax.Model.SyntaxToken("return", 1, 0, 6, ["keyword.control.flow.ubytec"]) };
        var (badTree, _) = ASTCompiler.CompileSyntax([new CoreOperations.RETURN(
            new(Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.Int32))], tokens);
        var function = new Ubytec.Language.HighLevel.Func("Broken",
            new(Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.Int64),
            Guid.NewGuid(), definitionSentence: badTree.RootSentence);
        Assert.Throws<SyntaxException>(() => function.Compile(scopes));
        Assert.Equal(0, scopes.Count);
    }
}
