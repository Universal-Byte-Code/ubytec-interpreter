using System.Text;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public class PortableModuleContractAbiTests
{
    private const string Source = """
        import ReadTool from tools.Read (t_uint64,t_uint64,t_uint64,t_uint64) -> t_int64
        export Main as Main
        module (name:"portable-contract", version:"0.1", author:"Ubytec")
        {
            func Main() -> t_int64
            {
                push 0
                return
            }
        }
        """;

    [Fact]
    public void LoaderAliasesAndAdaptersComeFromVerifiedUbcmContractManifest()
    {
        PortableSourceX64Result compilation = PortableSourceX64Pipeline.Compile(
            Source,
            processImage: false,
            enableModuleCalls: true);

        PortableProcessEntrypoint.Verify(compilation.ModuleBytes);
        PortableModuleImage image = PortableModuleFormat.Decode(compilation.ModuleBytes);
        PortableModuleSection manifest = image.GetRequiredSection(PortableModuleSectionKind.ContractManifest);
        string contract = Encoding.ASCII.GetString(manifest.Payload.Span);

        Assert.Contains("I|1|ReadTool|tools|Read|UInt64,UInt64,UInt64,UInt64:Int64\n", contract);
        Assert.Contains("E|Main|ubytec_host_contract_Main|:Int64\n", contract);

        PortableExecutableModule executable = Assert.IsType<PortableExecutableModule>(
            PortableBinaryCodec.Decode(compilation.ModuleBytes).Executable);
        Assert.Equal(2, executable.Imports.Count);
        Assert.Single(executable.Exports);

        int sourceImportIndex = Enumerable.Range(0, executable.Imports.Count).Single(index =>
        {
            PortableExecutableImport import = executable.Imports[index];
            return executable.Strings[checked((int)import.ModuleStringIndex)] == "tools" &&
                   executable.Strings[checked((int)import.SymbolStringIndex)] == "Read";
        });
        int runtimeImportIndex = Enumerable.Range(0, executable.Imports.Count).Single(index =>
        {
            PortableExecutableImport import = executable.Imports[index];
            return executable.Strings[checked((int)import.ModuleStringIndex)] == "ubytec.runtime" &&
                   executable.Strings[checked((int)import.SymbolStringIndex)] == "module.invoke";
        });

        string sourceImportLabel = compilation.NativeCompilation.GetImportLabel(sourceImportIndex);
        string runtimeImportLabel = compilation.NativeCompilation.GetImportLabel(runtimeImportIndex);
        string assembly = compilation.NativeCompilation.Assembly.ReplaceLineEndings("\n");
        Assert.Contains(sourceImportLabel + ":\n", assembly);
        Assert.Contains(runtimeImportLabel + ":\n", assembly);
        Assert.DoesNotContain("extern " + sourceImportLabel + "\n", assembly);
        Assert.DoesNotContain("extern " + runtimeImportLabel + "\n", assembly);
        Assert.Contains("extern ubytec_bridge_call\n", assembly);
        Assert.Contains("global ubytec_host_contract_Main\n", assembly);
        Assert.Contains("call ubytec_binary_export_0\n", assembly);
        Assert.Contains("section .ubytec_contract alloc noexec nowrite progbits\n", assembly);
    }
}
