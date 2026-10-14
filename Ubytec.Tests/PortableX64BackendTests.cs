using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public class PortableX64BackendTests
{
    private const string LocalCallSource = """
        export Main as Execute (t_int64) -> t_int64
        module (name:"portable-x64", version:"0.1", author:"Ubytec")
        {
            func Twice(t_int64 value) -> t_int64
            {
                load @value
                push 2
                mul
                return
            }

            func Main(t_int64 value) -> t_int64
            {
                load @value
                call Twice
                push 1
                add
                return
            }
        }
        """;

    private const string ImportSource = """
        import Remote from math.Twice (t_int64) -> t_int64
        export Main as Execute (t_int64) -> t_int64
        module (name:"portable-import", version:"0.1", author:"Ubytec")
        {
            func Main(t_int64 value) -> t_int64
            {
                load @value
                push 1000
                push 16384
                call Remote
                return
            }
        }
        """;

    [Fact]
    public void PortableBinaryBackendMatchesSourceBackendForLocalCall()
    {
        SourceCompilation source = SourceCompiler.Compile(LocalCallSource, emitProcessEntryPoint: false);
        byte[] bytes = EncodeIndexed(source);
        PortableBinaryModule binary = PortableBinaryCodec.Decode(bytes);
        PortableExecutableExport export = Assert.Single(binary.Executable!.Exports);

        PortableX64Compilation portable = PortableX64Backend.Compile(bytes);
        string portableLabel = portable.GetFunctionLabel(checked((int)export.FunctionIndex));

        long sourceResult = RunOneArgument(source.Assembly, source.GetFunctionLabel("Main"), 41);
        long portableResult = RunOneArgument(portable.Assembly, portableLabel, 41);

        Assert.Equal(83, sourceResult);
        Assert.Equal(sourceResult, portableResult);
    }

    [Fact]
    public void PortableBinaryBackendUsesOnlyIndexDerivedNativeIdentity()
    {
        SourceCompilation source = SourceCompiler.Compile(LocalCallSource, emitProcessEntryPoint: false);
        PortableX64Compilation portable = PortableX64Backend.Compile(EncodeIndexed(source));

        Assert.DoesNotContain("Main", portable.Assembly, StringComparison.Ordinal);
        Assert.DoesNotContain("Twice", portable.Assembly, StringComparison.Ordinal);
        Assert.DoesNotContain("Execute", portable.Assembly, StringComparison.Ordinal);
        Assert.Contains("ubytec_binary_f_", portable.Assembly, StringComparison.Ordinal);
        Assert.Contains("ubytec_binary_export_0", portable.Assembly, StringComparison.Ordinal);
    }

    [Fact]
    public void PortableImportsRemainUnresolvedIndexSlots()
    {
        SourceCompilation source = SourceCompiler.Compile(
            ImportSource,
            emitProcessEntryPoint: false,
            enableModuleCalls: true);
        PortableX64Compilation portable = PortableX64Backend.Compile(EncodeIndexed(source));

        string import = Assert.Single(portable.ImportLabels);
        Assert.Equal("ubytec_binary_import_0", import);
        Assert.Contains("extern ubytec_binary_import_0", portable.Assembly, StringComparison.Ordinal);
        Assert.Contains("call ubytec_binary_import_0", portable.Assembly, StringComparison.Ordinal);
        Assert.DoesNotContain("math", portable.Assembly, StringComparison.Ordinal);
        Assert.DoesNotContain("Remote", portable.Assembly, StringComparison.Ordinal);
    }

    [Fact]
    public void PortableBinaryBackendRejectsAstOnlyModules()
    {
        const string sourceText = """
            module (name:"ast-only-x64", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 42
                    return
                }
            }
            """;
        SourceCompilation source = SourceCompiler.Compile(sourceText, emitProcessEntryPoint: false);
        byte[] bytes = PortableModuleFormat.Encode(source.Module);

        Assert.Throws<NotSupportedException>(() => PortableX64Backend.Compile(bytes));
    }

    private static byte[] EncodeIndexed(SourceCompilation source) =>
        PortableModuleFormat.Encode(
            source.Module,
            contractManifest: null,
            includeIndexedExecutable: true,
            portableContracts: source.PortableContracts);

    private static long RunOneArgument(string assembly, string label, long argument)
    {
        string body = $"mov rax, 0x{unchecked((ulong)argument):X16}\npush rax\n" +
            $"call {label}\nadd rsp, 8\npush rax";
        return Assert.Single(NativeStack.Run(body, 1, assembly));
    }
}
