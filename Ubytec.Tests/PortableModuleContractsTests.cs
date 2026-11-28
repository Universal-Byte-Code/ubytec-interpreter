using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Tests;

public class PortableModuleContractsTests
{
    private const string Source = """
        import Copy from memory.Copy (t_loan_rw,t_loan_ro,t_uint64) -> t_int64
        export Main as PublicMain (t_uint64) -> t_int64
        module (name:"portable-contracts", version:"0.1", author:"Ubytec") {
        func Main(t_uint64 value) -> t_int64 {
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

    [Fact]
    public void CompilationRetainsPortableBoundarySemantics()
    {
        SourceCompilation compilation = SourceCompiler.Compile(
            Source,
            emitProcessEntryPoint: false,
            enableModuleCalls: true);

        PortableImportContract import = Assert.Single(compilation.PortableContracts.Imports);
        Assert.Equal("Copy", import.SourceAlias);
        Assert.Equal("memory", import.Module);
        Assert.Equal("Copy", import.Symbol);
        Assert.Equal(PrimitiveType.Int64, import.ReturnType);
        Assert.Collection(
            import.Arguments,
            argument =>
            {
                Assert.Equal(PortablePassingMode.LoanWrite, argument.PassingMode);
                Assert.Equal(PrimitiveType.UInt64, argument.CarrierType);
            },
            argument =>
            {
                Assert.Equal(PortablePassingMode.LoanRead, argument.PassingMode);
                Assert.Equal(PrimitiveType.UInt64, argument.CarrierType);
            },
            argument =>
            {
                Assert.Equal(PortablePassingMode.Value, argument.PassingMode);
                Assert.Equal(PrimitiveType.UInt64, argument.CarrierType);
            });

        PortableExportContract export = Assert.Single(compilation.PortableContracts.Exports);
        Assert.Equal("Main", export.FunctionName);
        Assert.Equal("PublicMain", export.Symbol);
        Assert.Equal(PrimitiveType.Int64, export.ReturnType);
        PortableBoundaryParameter parameter = Assert.Single(export.Arguments);
        Assert.Equal(PortablePassingMode.Value, parameter.PassingMode);
        Assert.Equal(PrimitiveType.UInt64, parameter.CarrierType);
    }

    [Fact]
    public void PortableModelDoesNotExposeRuntimeBridgeIdentities()
    {
        SourceCompilation compilation = SourceCompiler.Compile(
            Source,
            emitProcessEntryPoint: false,
            enableModuleCalls: true);

        string model = System.Text.Json.JsonSerializer.Serialize(compilation.PortableContracts);
        Assert.DoesNotContain("ubytec_host_contract_", model, StringComparison.Ordinal);
        Assert.DoesNotContain("Handle", model, StringComparison.Ordinal);
        Assert.DoesNotContain("Bridge", model, StringComparison.Ordinal);
    }
}
