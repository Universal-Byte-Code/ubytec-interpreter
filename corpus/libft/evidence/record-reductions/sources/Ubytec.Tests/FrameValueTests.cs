using System.Reflection;
using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class FrameValueTests
{
    private static string Optimize(string assembly) => (string)typeof(SourceCompiler).Assembly
        .GetType("Ubytec.Language.Tools.Optimization.FrameValueOptimizer", true)!
        .GetMethod("Optimize", BindingFlags.Static | BindingFlags.NonPublic)!.Invoke(null, new object[]{assembly})!;

    [Fact]
    public void StoredAndCopiedValuesReplaceFrameReadsWithoutRemovingWrites()
    {
        const string span="mov rax, 0xFEDCBA9876543210\nmov qword [rbp - 16], rax\nmov rcx, rax\nmov rax, 7\nmov rdx, qword [rbp - 16]";
        string optimized=Optimize(span);
        Assert.Contains("mov qword [rbp - 16], rax",optimized);Assert.Contains("mov rdx, rcx",optimized);
        string Wrap(string body)=>"sub rsp, 32\n"+body+"\nadd rsp, 32\npush rdx";
        Assert.Equal(NativeStack.Run(Wrap(span),1),NativeStack.Run(Wrap(optimized),1));
    }
    [Theory]
    [InlineData("mov eax, 9")]
    [InlineData("mov al, 9")]
    [InlineData("inc rax")]
    [InlineData("add rax, 1")]
    [InlineData("lea rdx, [rbp - 16]\nmov qword [rdx], 99")]
    [InlineData("mov rdx, 99\nmov qword [rbp - 15], rdx")]
    [InlineData("push 99\npop rcx")]
    public void RegisterClobbersAliasesOverlapsAndStackWritesRemainCorrect(string mutation)
    {
        string span="mov rax, 42\nmov qword [rbp - 16], rax\n"+mutation+"\nmov rcx, qword [rbp - 16]";
        string Wrap(string body)=>"sub rsp, 32\n"+body+"\nadd rsp, 32\npush rcx";
        Assert.Equal(NativeStack.Run(Wrap(span),1),NativeStack.Run(Wrap(Optimize(span)),1));
    }
    [Theory]
    [InlineData("call fn")]
    [InlineData("label:")]
    [InlineData("jmp label")]
    [InlineData("mov rbp, rsp")]
    [InlineData("mov rsp, rbp")]
    [InlineData("mov qword [rdx], rax")]
    [InlineData("mov qword [rsp - 8], rax")]
    [InlineData("mov byte [rbp - 16], 1")]
    [InlineData("syscall")]
    public void BarriersPreventForwarding(string barrier)
    {
        string assembly="mov rax, qword [rbp - 16]\n"+barrier+"\nmov rcx, qword [rbp - 16]";
        Assert.Equal(assembly,Optimize(assembly));
    }
    [Fact]
    public void FlagsAndOtherRegistersRemainVisible()
    {
        const string span="mov rax, 42\nmov qword [rbp - 16], rax\ncmp rax, rax\nmov rcx, qword [rbp - 16]\nsetz dl\nmovzx edx, dl";
        string Wrap(string body)=>"sub rsp, 32\n"+body+"\nadd rsp, 32\npush rax\npush rcx\npush rdx";
        Assert.Equal(NativeStack.Run(Wrap(span),3),NativeStack.Run(Wrap(Optimize(span)),3));
    }
    [Theory]
    [InlineData(false)] [InlineData(true)]
    public void PublicCompilerOptionPreservesFunctionResult(bool transfers)
    {
        const string source="""
        module (name:"frame_values",version:"0.1",author:"Ubytec") {
        func Main() -> t_uint64 {
        local { t_uint64 n 18446744073709551615 }
        if @n == 18446744073709551615
        load @n
        return
        else
        push 0
        return
        end
        }
        }
        """;
        var c=SourceCompiler.Compile(source,emitProcessEntryPoint:false,optimizeStackTransfers:transfers,optimizeFrameValues:true);
        Assert.Equal(new long[]{-1},NativeStack.Run($"call {c.GetFunctionLabel("Main")}\npush rax",1,c.Assembly));
    }
}
