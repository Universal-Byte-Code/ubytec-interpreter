using Ubytec.Language.AST;
using Xunit;
namespace Ubytec.Tests;
public class HostIOCompilationTests
{
    private const string Source="""
    module (name:"hostio",version:"0.1",author:"Ubytec") {
    func Main() -> t_int64 {
    push 257
    push 0
    push 0
    push 0
    push 0
    call HostRead
    return
    }
    }
    """;
    [Fact]
    public void ImportsRequireExplicitHostOptIn()
    {
        Assert.ThrowsAny<Exception>(()=>SourceCompiler.Compile(Source,emitProcessEntryPoint:false,enableModuleCalls:true));
        Assert.Throws<ArgumentException>(()=>SourceCompiler.Compile(Source,enableModuleCalls:true,enableHostIO:true));
        Assert.Throws<ArgumentException>(()=>SourceCompiler.Compile(Source,emitProcessEntryPoint:false,enableHostIO:true));
        var c=SourceCompiler.Compile(Source,emitProcessEntryPoint:false,enableModuleCalls:true,enableHostIO:true);
        Assert.Contains("call ubytec_hostio_HostRead",c.Assembly);Assert.Contains("extern ubytec_bridge_read",c.Assembly);Assert.Contains("extern ubytec_bridge_write",c.Assembly);
    }
    [Fact]
    public void HostCallsValidateFiveCellArgumentDepth() =>
        Assert.ThrowsAny<Exception>(()=>SourceCompiler.Compile(Source.Replace("push 257",""),emitProcessEntryPoint:false,enableModuleCalls:true,enableHostIO:true));
    [Theory]
    [InlineData("HostRead")] [InlineData("HostWrite")]
    public void HostNamesCannotBeRedefined(string name)=>
        Assert.Throws<ArgumentException>(()=>SourceCompiler.Compile(Source.Replace("func Main()",$"func {name}()"),emitProcessEntryPoint:false,enableModuleCalls:true,enableHostIO:true));
}
