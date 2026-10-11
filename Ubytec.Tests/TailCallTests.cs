using Ubytec.Language.AST;
using Ubytec.Language.Exceptions;
using Xunit;
namespace Ubytec.Tests;

public class TailCallTests
{
    private static string Module(string functions, string main, string type = "t_int64") =>
        $"module (name:\"tails\", version:\"0.1\", author:\"Ubytec\") {{\n{functions}\nfunc Main() -> {type} {{\n{main}\n}}\n}}";
    private static long Execute(string source, bool optimize = true)
    {
        var compiled = SourceCompiler.Compile(source, optimizeTailCalls: optimize);
        return Assert.Single(NativeStack.Run($"call {compiled.EntryLabel}\npush rax", 1, compiled.Assembly));
    }
    private const string Sum = """
        func Sum(t_int64 n, t_int64 acc) -> t_int64
        {
            local { t_int64 step 7 }
            if @n == 0
                load @acc
                return
            end
            load @n
            dec
            load @acc
            load @step
            add
            load @step
            inc
            store @step
            call Sum
            return
        }
        """;

    [Fact]
    public void OptInReusesFrameAndReinitializesLocals()
    {
        var source = Module(Sum, "push 2000\npush 0\ncall Sum\nreturn");
        var compilation = SourceCompiler.Compile(source, optimizeTailCalls: true);
        Assert.Contains("; tail call: reuse", compilation.Assembly);
        Assert.Contains("jmp " + compilation.GetFunctionLabel("Sum"), compilation.Assembly);
        Assert.Equal(14000, Execute(source));
    }

    [Fact]
    public void DefaultPreservesPhysicalFrames()
    {
        var source = Module(Sum, "push 10\npush 0\ncall Sum\nreturn");
        Assert.DoesNotContain("; tail call", SourceCompiler.Compile(source).Assembly);
        Assert.Equal(70, Execute(source, false));
    }

    [Fact]
    public void MutualTailRecursionPreservesArgumentPermutation()
    {
        string functions = """
            func Left(t_int64 n, t_int64 a, t_int64 b) -> t_int64
            {
                if @n == 0
                    load @a
                    push 100
                    mul
                    load @b
                    add
                    return
                end
                load @n
                dec
                load @b
                load @a
                call Right
                return
            }
            func Right(t_int64 n, t_int64 a, t_int64 b) -> t_int64
            {
                load @n
                load @a
                load @b
                call Left
                return
            }
            """;
        Assert.Equal(907, Execute(Module(functions, "push 2001\npush 7\npush 9\ncall Left\nreturn")));
    }

    [Fact]
    public void PendingWorkKeepsAnOrdinaryCall()
    {
        string functions = """
            func Count(t_int64 n) -> t_int64
            {
                if @n == 0
                    push 0
                    return
                end
                load @n
                dec
                call Count
                push 1
                add
                return
            }
            """;
        var source = Module(functions, "push 100\ncall Count\nreturn");
        var compiled = SourceCompiler.Compile(source, optimizeTailCalls: true);
        Assert.Contains("call " + compiled.GetFunctionLabel("Count"), compiled.Assembly);
        Assert.DoesNotContain("; tail call", compiled.Assembly);
        Assert.Equal(100, Execute(source));
    }

    [Fact]
    public void DifferentArityKeepsCallerCleanup()
    {
        string functions = """
            func Value(t_int64 n) -> t_int64
            {
                load @n
                return
            }
            """;
        var source = Module(functions, "push 42\ncall Value\nreturn");
        Assert.DoesNotContain("; tail call", SourceCompiler.Compile(source, optimizeTailCalls: true).Assembly);
        Assert.Equal(42, Execute(source));
    }

    [Fact]
    public void DifferentResultTypeKeepsOuterNarrowing()
    {
        string functions = """
            func Wide() -> t_int64
            {
                push 256
                return
            }
            """;
        var source = Module(functions, "call Wide\nreturn", "t_byte");
        Assert.DoesNotContain("; tail call", SourceCompiler.Compile(source, optimizeTailCalls: true).Assembly);
        Assert.Equal(0, Execute(source));
    }

    [Theory]
    [InlineData("t_byte", 255)]
    [InlineData("t_sbyte", -1)]
    [InlineData("t_bool", 1)]
    public void CompatibleNarrowReturnsKeepCanonicalResult(string type, long expected)
    {
        string functions = $"func Value() -> {type} {{\npush 255\nreturn\n}}";
        var source = Module(functions, "call Value\nreturn", type);
        Assert.Contains("; tail call", SourceCompiler.Compile(source, optimizeTailCalls: true).Assembly);
        Assert.Equal(expected, Execute(source));
    }

    [Fact]
    public void VoidTailReturnIsZero()
    {
        string functions = "func Done() -> t_void {\nreturn\n}";
        Assert.Equal(0, Execute(Module(functions, "call Done\nreturn", "t_void")));
    }

    [Fact]
    public void ExplicitReturnMismatchStillFails()
    {
        string functions = "func Value() -> t_int64 {\npush 42\nreturn\n}";
        Assert.Throws<SyntaxException>(() =>
            SourceCompiler.Compile(Module(functions, "call Value\nreturn t_byte"), optimizeTailCalls: true));
    }

    [Fact]
    public void PendingStateExplicitStackAndAccumulatorAgree()
    {
        var source = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "recursion.ubc"));
        var compiled = SourceCompiler.Compile(source, emitProcessEntryPoint: false, optimizeTailCalls: true);
        nint memory = System.Runtime.InteropServices.Marshal.AllocHGlobal(176);
        try
        {
            for (int n = 0; n <= 20; n++)
            {
                for (int i = 0; i < 176; i++) System.Runtime.InteropServices.Marshal.WriteByte(memory, i, 0xa5);
                string native = $"push {n}\ncall {compiled.GetFunctionLabel("Factorial")}\nadd rsp, 8\npush rax\n" +
                    $"push {n}\npush 1\ncall {compiled.GetFunctionLabel("FactorialTail")}\nadd rsp, 16\npush rax\n" +
                    $"push {n}\nmov rax, {(long)memory+8}\npush rax\npush 20\ncall {compiled.GetFunctionLabel("FactorialExplicit")}\nadd rsp, 24\npush rax";
                long expected = 1;
                for (int k = 2; k <= n; k++) expected *= k;
                Assert.All(NativeStack.Run(native, 3, compiled.Assembly), value => Assert.Equal(expected, value));
                for (int i = 0; i < 8; i++)
                {
                    Assert.Equal(0xa5, System.Runtime.InteropServices.Marshal.ReadByte(memory, i));
                    Assert.Equal(0xa5, System.Runtime.InteropServices.Marshal.ReadByte(memory, 168+i));
                }
            }
        }
        finally { System.Runtime.InteropServices.Marshal.FreeHGlobal(memory); }
    }

    [Fact]
    public void ExplicitStackRejectsInsufficientCapacityBeforeWriting()
    {
        var source = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "recursion.ubc"));
        var compiled = SourceCompiler.Compile(source, emitProcessEntryPoint: false, optimizeTailCalls: true);
        nint memory = System.Runtime.InteropServices.Marshal.AllocHGlobal(160);
        try
        {
            for (int i = 0; i < 160; i++) System.Runtime.InteropServices.Marshal.WriteByte(memory, i, 0xa5);
            string body = $"push 20\nmov rax, {(long)memory}\npush rax\npush 19\ncall {compiled.GetFunctionLabel("FactorialExplicit")}\nadd rsp, 24\npush rax";
            Assert.Equal(-1, Assert.Single(NativeStack.Run(body, 1, compiled.Assembly)));
            for (int i = 0; i < 160; i++) Assert.Equal(0xa5, System.Runtime.InteropServices.Marshal.ReadByte(memory, i));
        }
        finally { System.Runtime.InteropServices.Marshal.FreeHGlobal(memory); }
    }
}
