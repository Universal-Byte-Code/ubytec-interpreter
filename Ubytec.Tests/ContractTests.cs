using Ubytec.Language.AST;
using Xunit;
namespace Ubytec.Tests;
public class ContractTests {
private const string Source="""
import Read from tools.Read (t_uint64,t_uint64,t_uint64,t_uint64) -> t_int64
export Main as Main
module (name:"test", version:"0.1", author:"Ubytec") {
func Main(t_uint64 a,t_uint64 b,t_uint64 c,t_uint64 d) -> t_int64 {
push 4096
push 16
push 1
push 1000
push 8192
call Read
return
}
}
""";
[Fact] public void DeclarationsEmitBindingsAndSignatures() {
var c=SourceCompiler.Compile(Source,emitProcessEntryPoint:false,enableModuleCalls:true);
Assert.DoesNotContain("\r",c.ContractManifest);
Assert.Contains("I|1|Read|tools|Read|UInt64,UInt64,UInt64,UInt64:Int64",c.ContractManifest);
Assert.Contains("E|Main|ubytec_host_contract_Main|UInt64,UInt64,UInt64,UInt64:Int64",c.ContractManifest);
Assert.Contains("call ubytec_import_Read",c.Assembly);
}
[Fact] public void ImportsRequireExplicitBridge() =>
Assert.Throws<ArgumentException>(()=>SourceCompiler.Compile(Source,emitProcessEntryPoint:false));
[Fact] public void UnknownExportIsRejected() =>
Assert.Throws<ArgumentException>(()=>SourceCompiler.Compile(Source.Replace("export Main as","export Missing as"),emitProcessEntryPoint:false,enableModuleCalls:true));
[Fact] public void DuplicateImportIsRejected() =>
Assert.Throws<ArgumentException>(()=>SourceCompiler.Compile(Source.Split('\n')[0]+"\n"+Source,emitProcessEntryPoint:false,enableModuleCalls:true));
[Fact] public void DuplicateExportIsRejected() =>
Assert.Throws<ArgumentException>(()=>SourceCompiler.Compile("export Main as Main\n"+Source,emitProcessEntryPoint:false,enableModuleCalls:true));
[Fact] public void UnsupportedImportSignatureIsRejected() =>
Assert.Throws<ArgumentException>(()=>SourceCompiler.Compile(Source.Replace("-> t_int64","-> t_void"),emitProcessEntryPoint:false,enableModuleCalls:true));
[Fact] public void ExportAdapterNameMustFitManifest() =>
Assert.Throws<ArgumentException>(()=>SourceCompiler.Compile(Source.Replace("as Main","as "+new string('A',50)),emitProcessEntryPoint:false,enableModuleCalls:true));
}
