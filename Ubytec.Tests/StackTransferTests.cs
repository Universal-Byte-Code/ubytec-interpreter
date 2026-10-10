using System.Reflection;
using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class StackTransferTests
{
    private static string Optimize(string assembly) => (string)typeof(SourceCompiler).Assembly
        .GetType("Ubytec.Language.Tools.Optimization.StackTransferOptimizer", true)!
        .GetMethod("Optimize", BindingFlags.Static | BindingFlags.NonPublic)!.Invoke(null, new object[]{assembly})!;

    [Theory]
    [InlineData("rax", "rax")] [InlineData("rax", "rcx")] [InlineData("r8", "r9")]
    public void TransfersPreserveFullWidthValueStaleCellAndDepth(string source, string target)
    {
        string body=$"mov {source}, 0xFEDCBA9876543210\npush {source}\npop {target}\nmov rdx, [rsp - 8]\npush {target}\npush rdx";
        Assert.Equal(NativeStack.Run(body,2),NativeStack.Run(Optimize(body),2));
        Assert.Contains($"mov qword [rsp - 8], {source}",Optimize(body));
    }
    [Fact]
    public void FlagsAndLiveStackCellsSurvive()
    {
        const string body="push 99\nxor eax, eax\ncmp eax, eax\nmov rax, 42\npush rax\npop rcx\nsetz dl\nmovzx edx, dl\npush rcx\npush rdx";
        Assert.Equal(new long[]{99,42,1},NativeStack.Run(Optimize(body),3));
        Assert.Equal(NativeStack.Run(body,3),NativeStack.Run(Optimize(body),3));
    }
    [Theory]
    [InlineData("push rax\nlabel:\npop rax")]
    [InlineData("push rax\n; comment\npop rax")]
    [InlineData("push rax\ncall elsewhere\npop rax")]
    [InlineData("push rax\nmov [rsp], rcx\npop rax")]
    [InlineData("push rsp\npop rax")]
    [InlineData("push rax\npop rsp")]
    [InlineData("push qword [rax]\npop rcx")]
    [InlineData("push 42\npop rax")]
    [InlineData("pop rax\npush rax")]
    public void BarriersAndUnsupportedOperandsAreUnchanged(string assembly) => Assert.Equal(assembly,Optimize(assembly));

    [Theory]
    [InlineData(false)] [InlineData(true)]
    public void CompiledArithmeticCallsAndLoopsRemainEquivalent(bool optimized)
    {
        const string source="""
        module (name:"stack_transfers",version:"0.1",author:"Ubytec") {
        func Twice(t_uint64 x) -> t_uint64 { load @x
        push 2
        mul
        return
        }
        func Main() -> t_uint64 {
        local { t_uint64 i 0 t_uint64 total 0 }
        while @i < 20
        load @total
        load @i
        call Twice
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
        var c=SourceCompiler.Compile(source,emitProcessEntryPoint:false,optimizeStackTransfers:optimized);
        Assert.Equal(new long[]{380},NativeStack.Run($"call {c.GetFunctionLabel("Main")}\npush rax",1,c.Assembly));
        if(optimized)Assert.Contains("mov qword [rsp - 8]",c.Assembly);
        else Assert.Matches(@"push rax\s+pop",c.Assembly);
    }
}
