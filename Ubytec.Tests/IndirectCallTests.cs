using System.Text.Json;
using Ubytec.Language.AST;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Tools.Serialization;
using Xunit;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Tests;

public class IndirectCallTests
{
    private static string Source(string body, string functions = "") =>
        "module (name:\"callbacks\",version:\"0.1\",author:\"Ubytec\") {\n" + functions + "\nfunc Main() -> t_int64 {\n" + body + "\n}\n}\n";
    private static long Execute(string source, bool tails = false)
    {
        var c = SourceCompiler.Compile(source, optimizeTailCalls: tails);
        return Assert.Single(NativeStack.Run($"call {c.EntryLabel}\npush rax", 1, c.Assembly));
    }
    [Fact]
    public void AddressCanBeStoredPassedAndCalledWithOrderedArguments()
    {
        const string funcs = """
        func Apply(t_uint64 target,t_int64 left,t_int64 right) -> t_int64 {
        load @left
        load @right
        load @target
        calli 2 t_int64
        return
        }
        func Difference(t_int64 left,t_int64 right) -> t_int64 {
        load @left
        load @right
        sub
        return
        }
        """;
        Assert.Equal(116, Execute(Source("t_uint64 cb 0\nFNADDR Difference\nstore @cb\npush 99\nload @cb\npush 20\npush 3\ncall Apply\nadd\nreturn", funcs)));
    }
    [Theory]
    [InlineData("t_byte",255L)] [InlineData("t_sbyte",-1L)]
    [InlineData("t_uint16",65535L)] [InlineData("t_int16",-1L)]
    [InlineData("t_uint32",4294967295L)] [InlineData("t_int32",-1L)]
    [InlineData("t_uint64",-1L)] [InlineData("t_bool",1L)]
    public void ExplicitResultsCanonicalizeIntegerWidths(string type,long expected)
    {
        // The caller's explicit result contract canonicalizes the raw returned cell.
        Assert.Equal(expected,Execute(Source($"push 77\nfnaddr Raw\ncalli 0 {type}\nswap\npop\nreturn", "func Raw() -> t_uint64 { push 18446744073709551615\nreturn\n}")));
    }
    [Fact]
    public void VoidCallbackPreservesLowerCellsAndCleansArguments() =>
        Assert.Equal(42,Execute(Source("push 42\npush 1\npush 2\nfnaddr Consume\ncalli 2 t_void\nreturn", "func Consume(t_uint64 a,t_uint64 b) -> t_void { load @a\nload @b\nadd\npop\nreturn\n}")));
    [Fact]
    public void RecursiveCallbackUsesIndependentFramesWithTailOptimizationEnabled()
    {
        const string f="""
        func Sum(t_uint64 n) -> t_uint64 {
        if @n == 0
        push 0
        return
        end
        load @n
        load @n
        push 1
        sub
        fnaddr Sum
        calli 1 t_uint64
        add
        return
        }
        """;
        Assert.Equal(5050,Execute(Source("push 100\nfnaddr Sum\ncalli 1 t_uint64\nreturn",f),true));
    }
    [Fact]
    public void MoreThanSixArgumentsUseTheInternalStackAbi()
    {
        string args=string.Join(',',Enumerable.Range(0,8).Select(i=>$"t_uint64 a{i}"));
        string body=string.Join('\n',Enumerable.Range(0,8).Select(i=>$"load @a{i}\n"+(i==0?"":"add\n")));
        Assert.Equal(36,Execute(Source(string.Join('\n',Enumerable.Range(1,8).Select(i=>$"push {i}"))+"\nfnaddr Eight\ncalli 8 t_uint64\nreturn",$"func Eight({args}) -> t_uint64 {{\n{body}\nreturn\n}}")));
    }
    [Theory]
    [InlineData("fnaddr Missing\nreturn")]
    [InlineData("fnaddr Main extra\nreturn")]
    [InlineData("calli 0 t_uint64\nreturn")]
    [InlineData("fnaddr Main\ncalli 1 t_uint64\nreturn")]
    [InlineData("push 1\ncalli -1 t_uint64\nreturn")]
    [InlineData("push 1\ncalli 256 t_uint64\nreturn")]
    [InlineData("push 1\ncalli 0 t_float64\nreturn")]
    [InlineData("push 1\ncalli 0 t_uint128\nreturn")]
    [InlineData("push 1\ncalli 0 t_uint64?\nreturn")]
    [InlineData("push 1\ncalli 0\nreturn")]
    [InlineData("push 1\ncalli 0 t_void\nreturn")]
    public void InvalidSignaturesAndStackUnderflowAreRejected(string body) =>
        Assert.ThrowsAny<Exception>(()=>SourceCompiler.Compile(Source(body)));
    [Fact]
    public void FactoryAndJsonPreserveBothInstructions()
    {
        IOpCode[] ops=[new FunctionOperations.FNADDR("Example"),new FunctionOperations.CALLI(2,PrimitiveType.UInt64),new FunctionOperations.CALLI(0,PrimitiveType.Void)];
        var options=new JsonSerializerOptions();options.Converters.Add(new IOpCodeConverter());
        foreach(var op in ops)Assert.Equal(op,JsonSerializer.Deserialize<IOpCode>(JsonSerializer.Serialize(op,options),options));
        Assert.Equal(ops[1],OpcodeFactory.Create((byte)0x62,[],[],2,PrimitiveType.UInt64,TypeModifiers.None));
        Assert.Throws<SyntaxException>(()=>new FunctionOperations.CALLI(-1,PrimitiveType.Void).Compile(new CompilationScopes()));
        Assert.Throws<SyntaxException>(()=>OpcodeFactory.Create((byte)0x62,[],[],true,PrimitiveType.Void));
        Assert.Throws<SyntaxException>(()=>OpcodeFactory.Create((byte)0x62,[],[],0,PrimitiveType.UInt64,TypeModifiers.Const));
    }
    [Fact]
    public void ImportCallbackStillTargetsTheSupervisorBridge()
    {
        string source=Source("push 1\npush 0\npush 0\npush 1\npush 0\npush 0\nfnaddr ModuleInvoke\ncalli 6 t_int64\nreturn");
        Assert.ThrowsAny<Exception>(()=>SourceCompiler.Compile(source,emitProcessEntryPoint:false));
        var compiled=SourceCompiler.Compile(source,emitProcessEntryPoint:false,enableModuleCalls:true);
        Assert.Contains("lea rax, [rel ubytec_module_invoke]",compiled.Assembly);
        Assert.Contains("extern ubytec_bridge_call",compiled.Assembly);
        Assert.Contains("call ubytec_bridge_call",compiled.Assembly);
    }

}
