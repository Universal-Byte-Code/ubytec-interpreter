using Ubytec.Language.AST;
using Xunit;
namespace Ubytec.Tests;
public class ModuleCallTests
{
    private const string Source = """
        module (name:"calls", version:"0.1", author:"Ubytec") {
        func Main() -> t_int64 {
        push 1
        push 4096
        push 16
        push 1
        push 0
        push 8192
        call ModuleInvoke
        return
        }
        }
        """;
    [Fact]
    public void BridgeRequiresExplicitOptIn() =>
        Assert.ThrowsAny<Exception>(() => SourceCompiler.Compile(Source, emitProcessEntryPoint:false));
    [Fact]
    public void BridgeIsAvailableToSourceCalls()
    {
        var result=SourceCompiler.Compile(Source, emitProcessEntryPoint:false, enableModuleCalls:true);
        Assert.Contains("extern ubytec_bridge_call",result.Assembly);
        Assert.Contains("call ubytec_module_invoke",result.Assembly);
    }
    [Fact]
    public void BridgeValidatesArgumentDepth() =>
        Assert.ThrowsAny<Exception>(() => SourceCompiler.Compile(Source.Replace("push 8192",""),
            emitProcessEntryPoint:false, enableModuleCalls:true));
    [Fact]
    public void BridgeRequiresLibraryCompilation() =>
        Assert.Throws<ArgumentException>(() => SourceCompiler.Compile(Source, enableModuleCalls:true));
    [Fact]
    public void HostImportCannotBeRedefined() =>
        Assert.Throws<ArgumentException>(() => SourceCompiler.Compile(
            Source.Replace("func Main()", "func ModuleInvoke()"),emitProcessEntryPoint:false,enableModuleCalls:true));
}
