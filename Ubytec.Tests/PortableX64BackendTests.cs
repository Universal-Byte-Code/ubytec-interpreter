using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;
using static Ubytec.Language.Syntax.TypeSystem.Types;

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

    [Theory]
    [InlineData("push 10\npush 3\nswap\nsub\npush 2\nmul\nreturn", -14L)]
    [InlineData("t_int64 value 5\nload @value\npush 7\nadd\nstore @value\nload @value\nreturn", 12L)]
    [InlineData("push 11\npush 22\npush 33\npick 2\nadd\nroll 2\nsub\nreturn", 33L)]
    public void PortableBinaryBackendMatchesSourceForStackAndFrameSemantics(string body, long expected)
    {
        string sourceText = ExportedMain(body);
        SourceCompilation source = SourceCompiler.Compile(sourceText, emitProcessEntryPoint: false);
        byte[] bytes = EncodeIndexed(source);
        PortableX64Compilation portable = PortableX64Backend.Compile(bytes);
        PortableExecutableExport export = Assert.Single(PortableBinaryCodec.Decode(bytes).Executable!.Exports);

        long sourceResult = RunNoArguments(source.Assembly, source.GetFunctionLabel("Main"));
        long portableResult = RunNoArguments(
            portable.Assembly,
            portable.GetFunctionLabel(checked((int)export.FunctionIndex)));

        Assert.Equal(expected, sourceResult);
        Assert.Equal(sourceResult, portableResult);
    }

    [Theory]
    [InlineData("push 2\nswitch\nbranch 1\npush 10\nend\nbranch 2\npush 42\nend\ndefault\npush 99\nend\nreturn", 42L)]
    [InlineData("push 3\nswitch\nbranch 1\npush 10\nend\ndefault\npush 99\nend\nreturn", 99L)]
    [InlineData("push 2\nswitch\nbranch 2\npush 3\nswitch\nbranch 3\npush 42\nend\ndefault\npush 0\nend\nend\ndefault\npush 99\nend\nreturn", 42L)]
    [InlineData("push 42\npush 1\nswitch\nbranch 1\nbreak\nend\nbranch 1\npop\npush 99\nend\nend\nreturn", 42L)]
    [InlineData("push 42\npush 9\nswitch\nbranch 1\npop\npush 99\nend\nend\nreturn", 42L)]
    public void PortableSwitchMatchesLegacy(string body, long expected)
    {
        SourceCompilation source = SourceCompiler.Compile(ExportedMain(body), emitProcessEntryPoint: false);
        byte[] bytes = EncodeIndexed(source);
        PortableBinaryVerifier.Verify(bytes);
        Assert.Equal(bytes, PortableBinaryCodec.Encode(PortableBinaryCodec.Decode(bytes)));
        PortableX64Compilation portable = PortableX64Backend.Compile(bytes);
        Assert.Equal(expected, RunNoArguments(source.Assembly, source.GetFunctionLabel("Main")));
        Assert.Equal(expected, RunNoArguments(portable.Assembly, portable.GetFunctionLabel(0)));
    }

    [Theory]
    [InlineData(0x11, 0, 42L)]
    [InlineData(0x18, 1, 42L)]
    [InlineData(0x1D, 1, 7L)]
    [InlineData(0x1E, 1, 7L)]
    public void PortableExtendedStackWireRoundTripsAndExecutes(int opcode, int index, long expected)
    {
        SourceCompilation source = SourceCompiler.Compile(ExportedMain("push 42\nreturn"), emitProcessEntryPoint: false);
        PortableBinaryModule binary = PortableBinaryCodec.Decode(EncodeIndexed(source));
        PortableExecutableModule executable = binary.Executable!;
        PortableInstruction[] initial = opcode == 0x11
            ? [new PortablePushInstruction([42])]
            : [new PortablePushInstruction([7]), new PortablePushInstruction([42])];
        PortableInstruction[] code = [.. initial,
            new PortableExtendedStackInstruction((byte)opcode, (ushort)index),
            new PortableReturnInstruction(null)];
        var functions = executable.Functions.ToArray();
        functions[0] = functions[0] with { Instructions = code };
        byte[] bytes = PortableBinaryCodec.Encode(binary with { Executable = executable with { Functions = functions } });
        PortableBinaryVerifier.Verify(bytes);
        Assert.Equal(bytes, PortableBinaryCodec.Encode(PortableBinaryCodec.Decode(bytes)));
        PortableX64Compilation portable = PortableX64Backend.Compile(bytes);
        Assert.Equal(expected, RunNoArguments(portable.Assembly, portable.GetFunctionLabel(0)));
    }

    [Theory]
    [InlineData(0x11, 7)]
    [InlineData(0x18, 1)]
    [InlineData(0x1D, 1)]
    [InlineData(0x1E, 1)]
    public void IndependentVerifierRejectsExtendedAccessOutsideEvaluationStack(int opcode, int index)
    {
        SourceCompilation source = SourceCompiler.Compile(ExportedMain("push 42\nreturn"), emitProcessEntryPoint: false);
        PortableBinaryModule binary = PortableBinaryCodec.Decode(EncodeIndexed(source));
        PortableExecutableModule executable = binary.Executable!;
        var functions = executable.Functions.ToArray();
        functions[0] = functions[0] with
        {
            Instructions = [new PortablePushInstruction([42]),
                new PortableExtendedStackInstruction((byte)opcode, (ushort)index),
                new PortableReturnInstruction(null)]
        };
        byte[] bytes = PortableBinaryCodec.Encode(binary with { Executable = executable with { Functions = functions } });
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
        Assert.Throws<InvalidDataException>(() => PortableX64Backend.Compile(bytes));
    }

    [Fact]
    public void PortableBinaryBackendMatchesSourceForFunctionAddressAndIndirectCall()
    {
        const string sourceText = """
            export Main as Execute () -> t_int64
            module (name:"portable-calli", version:"0.1", author:"Ubytec")
            {
                func Difference(t_int64 left, t_int64 right) -> t_int64
                {
                    load @left
                    load @right
                    sub
                    return
                }

                func Main() -> t_int64
                {
                    push 20
                    push 3
                    fnaddr Difference
                    calli 2 t_int64
                    return
                }
            }
            """;
        SourceCompilation source = SourceCompiler.Compile(sourceText, emitProcessEntryPoint: false);
        byte[] bytes = EncodeIndexed(source);
        PortableExecutableExport export = Assert.Single(PortableBinaryCodec.Decode(bytes).Executable!.Exports);
        PortableX64Compilation portable = PortableX64Backend.Compile(bytes);

        long sourceResult = RunNoArguments(source.Assembly, source.GetFunctionLabel("Main"));
        long portableResult = RunNoArguments(
            portable.Assembly,
            portable.GetFunctionLabel(checked((int)export.FunctionIndex)));

        Assert.Equal(17, sourceResult);
        Assert.Equal(sourceResult, portableResult);
    }

    [Fact]
    public void PortableBinaryBackendUsesOnlyIndexDerivedNativeIdentity()
    {
        SourceCompilation source = SourceCompiler.Compile(LocalCallSource, emitProcessEntryPoint: false);
        PortableX64Compilation portable = PortableX64Backend.Compile(EncodeIndexed(source));

        Assert.DoesNotContain("Main", portable.Assembly);
        Assert.DoesNotContain("Twice", portable.Assembly);
        Assert.DoesNotContain("Execute", portable.Assembly);
        Assert.Contains("ubytec_binary_f_", portable.Assembly);
        Assert.Contains("ubytec_binary_export_0", portable.Assembly);
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
        Assert.Contains("extern ubytec_binary_import_0", portable.Assembly);
        Assert.Contains("call ubytec_binary_import_0", portable.Assembly);
        Assert.DoesNotContain("math", portable.Assembly);
        Assert.DoesNotContain("Remote", portable.Assembly);
    }

    [Fact]
    public void TypedPortableInputStillPassesIndependentVerifier()
    {
        SourceCompilation source = SourceCompiler.Compile(LocalCallSource, emitProcessEntryPoint: false);
        PortableBinaryModule binary = PortableBinaryCodec.Decode(EncodeIndexed(source));
        PortableExecutableModule executable = binary.Executable!;
        PortableExecutableType[] types = executable.Types.ToArray();
        types[0] = types[0] with
        {
            Modifiers = types[0].Modifiers | (TypeModifiers)unchecked((int)0x80000000u)
        };
        PortableBinaryModule malformed = binary with
        {
            Executable = executable with { Types = types }
        };

        Assert.Throws<InvalidDataException>(() => PortableX64Backend.Compile(malformed));
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

    private static string ExportedMain(string body) => $$"""
        export Main as Execute () -> t_int64
        module (name:"portable-differential", version:"0.1", author:"Ubytec")
        {
            func Main() -> t_int64
            {
                {{body}}
            }
        }
        """;

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

    private static long RunNoArguments(string assembly, string label) =>
        Assert.Single(NativeStack.Run($"call {label}\npush rax", 1, assembly));
}
