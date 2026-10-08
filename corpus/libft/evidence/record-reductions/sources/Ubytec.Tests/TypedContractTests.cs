using Ubytec.Language.AST;
using Xunit;
namespace Ubytec.Tests;
public class TypedContractTests {
private const string Source="""
import Copy from memory.Copy (t_loan_rw,t_loan_ro,t_uint64) -> t_int64
export Main as Main
module (name:"typed", version:"0.1", author:"Ubytec") {
func Main() -> t_int64 {
push 4096
push 16
push 8192
push 16
push 16
push 1000
push 16384
call Copy
return
}
}
""";
[Fact] public void TypedImportEmitsIndependentLoanRecords() {
var result=SourceCompiler.Compile(Source,emitProcessEntryPoint:false,enableModuleCalls:true);
Assert.Contains("LoanWrite,LoanRead,UInt64:Int64",result.ContractManifest);
Assert.Contains("call ubytec_bridge_many",result.Assembly);
}
[Fact] public void ThirdLoanIsRejected() =>
Assert.Throws<ArgumentException>(()=>SourceCompiler.Compile(Source.Replace("t_uint64)","t_loan_ro)"),emitProcessEntryPoint:false,enableModuleCalls:true));
[Fact] public void LoanExportMustHavePointerCellABI() =>
Assert.Throws<ArgumentException>(()=>SourceCompiler.Compile(Source.Replace("export Main as Main","export Main as Main (t_loan_rw) -> t_int64"),emitProcessEntryPoint:false,enableModuleCalls:true));
[Fact] public void MissingLoanLengthIsRejected() =>
Assert.ThrowsAny<Exception>(()=>SourceCompiler.Compile(Source.Replace("push 8192",""),emitProcessEntryPoint:false,enableModuleCalls:true));
}
