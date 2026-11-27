using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Tests;

public class PortableStructuredControlTests
{
    private const string Source = """
        export Main as Execute (t_int64) -> t_int64
        module (name:"portable-control", version:"0.1", author:"Ubytec")
        {
            func Main(t_int64 value) -> t_int64
            {
                local
                {
                    t_int64 total 0
                }

                while @value > 0
                    load @total
                    load @value
                    add
                    store @total
                    load @value
                    dec
                    store @value
                end

                load @total
                push 3
                gt
                if
                    load @total
                    push 10
                    add
                else
                    load @total
                    push 20
                    add
                end
                return
            }
        }
        """;

    [Theory]
    [InlineData(3L, 16L)]
    [InlineData(1L, 21L)]
    public void StructuredSourceCrossesVerifiedUbcmAndMatchesLegacySemantics(long value, long expected)
    {
        SourceCompilation source = SourceCompiler.Compile(Source, emitProcessEntryPoint: false);
        byte[] bytes = PortableModuleFormat.Encode(
            source.Module,
            contractManifest: null,
            includeIndexedExecutable: true,
            portableContracts: source.PortableContracts);

        PortableBinaryVerifier.Verify(bytes);
        PortableBinaryModule binary = PortableBinaryCodec.Decode(bytes);
        PortableExecutableExport export = Assert.Single(binary.Executable!.Exports);
        PortableExecutableFunction function = binary.Executable.Functions[checked((int)export.FunctionIndex)];
        byte[] structured = function.Instructions
            .OfType<PortableOperandFreeInstruction>()
            .Select(instruction => instruction.OpCode)
            .ToArray();

        Assert.Contains(LOOP.OP, structured);
        Assert.Contains(IF.OP, structured);
        Assert.Contains(function.Instructions.OfType<PortableControlTransferInstruction>(),
            instruction => instruction.Operation == BREAK.OP && instruction.TargetOrdinal == 0);
        Assert.Contains(ELSE.OP, structured);
        Assert.Contains(END.OP, structured);
        Assert.DoesNotContain(WHILE.OP, structured);

        PortableX64Compilation portable = PortableX64Backend.Compile(bytes);
        string portableLabel = portable.GetFunctionLabel(checked((int)export.FunctionIndex));
        long sourceResult = RunOneArgument(source.Assembly, source.GetFunctionLabel("Main"), value);
        long portableResult = RunOneArgument(portable.Assembly, portableLabel, value);

        Assert.Equal(expected, sourceResult);
        Assert.Equal(sourceResult, portableResult);
    }

    [Theory]
    [InlineData("switch 7", "branch 1", "break 7")]
    [InlineData("switch", "branch 1 7", "break 7")]
    public void LabeledBreakResolvesToOuterSwitchWithoutSerializingSourceLabel(string selection, string branch, string transfer)
    {
        string source = $"""
            module (name:"control-label", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 1
                    {{selection}}
                    {{branch}}
                    loop
                    {{transfer}}
                    end
                    end
                    end
                    push 42
                    return
                }
            }
            """;
        SourceCompilation legacy = SourceCompiler.Compile(source, emitProcessEntryPoint: false);
        byte[] bytes = PortableModuleFormat.Encode(legacy.Module, contractManifest: null,
            includeIndexedExecutable: true, portableContracts: legacy.PortableContracts);
        PortableBinaryVerifier.Verify(bytes);
        PortableBinaryModule decoded = PortableBinaryCodec.Decode(bytes);
        var target = Assert.Single(decoded.Executable!.Functions[0].Instructions.OfType<PortableControlTransferInstruction>());
        Assert.Equal(1u, target.TargetOrdinal);
        Assert.Equal(bytes, PortableBinaryCodec.Encode(decoded));
        var native = PortableX64Backend.Compile(bytes);
        Assert.Equal(42L, Assert.Single(NativeStack.Run(
            $"call {native.GetFunctionLabel(0)}\npush rax", 1, native.Assembly)));
        Assert.Equal(42L, Assert.Single(NativeStack.Run(
            $"call {legacy.GetFunctionLabel("Main")}\npush rax", 1, legacy.Assembly)));

        // Mutate the actual verified wire operand to a non-existent outer target.
        PortableModuleImage image = PortableModuleFormat.Decode(bytes);
        int cursor = 12;
        foreach (PortableModuleSection section in image.Sections)
        {
            if (section.Kind == (ushort)PortableModuleSectionKind.IndexedCode)
            {
                Span<byte> code = bytes.AsSpan(cursor + 12, section.Payload.Length);
                int at = code.IndexOf(new byte[] { BREAK.OP, 1, 0, 0, 0 });
                Assert.True(at >= 0);
                code[at + 1] = 99;
                break;
            }
            cursor += 12 + section.Payload.Length;
        }
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    [Theory]
    [InlineData("block t_int16\npush 65535\nend\nreturn", -1L)]
    [InlineData("block\npush 42\nend\nreturn", 42L)]
    [InlineData("block t_int16\nblock t_int16\npush 65535\nend\nend\nreturn", -1L)]
    [InlineData("block t_int16\npush 42\nreturn\nend", 42L)]
    public void BlocksPreserveLegacyResultSemantics(string body, long expected)
    {
        string source = $"""
            module (name:"typed-block", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    {{body}}
                }
            }
            """;
        SourceCompilation legacy = SourceCompiler.Compile(source, emitProcessEntryPoint: false);
        byte[] bytes = PortableModuleFormat.Encode(legacy.Module, contractManifest: null,
            includeIndexedExecutable: true, portableContracts: legacy.PortableContracts);
        PortableBinaryVerifier.Verify(bytes);
        var decoded = PortableBinaryCodec.Decode(bytes);
        Assert.Contains(decoded.Executable!.Functions[0].Instructions, i => i is PortableBlockInstruction);
        Assert.Equal(bytes, PortableBinaryCodec.Encode(decoded));
        var native = PortableX64Backend.Compile(bytes);
        Assert.Equal(expected, Assert.Single(NativeStack.Run(
            $"call {legacy.GetFunctionLabel("Main")}\npush rax", 1, legacy.Assembly)));
        Assert.Equal(expected, Assert.Single(NativeStack.Run(
            $"call {native.GetFunctionLabel(0)}\npush rax", 1, native.Assembly)));
    }

    [Fact]
    public void IndependentVerifierRejectsMissingTypedBlockResult()
    {
        const string source = """
            module (name:"typed-block-mutation", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    block t_int16
                    push 42
                    end
                    return
                }
            }
            """;
        var legacy = SourceCompiler.Compile(source, emitProcessEntryPoint: false);
        var module = PortableBinaryCodec.Decode(PortableModuleFormat.Encode(legacy.Module,
            contractManifest: null, includeIndexedExecutable: true, portableContracts: legacy.PortableContracts));
        var executable = module.Executable!;
        var functions = executable.Functions.ToArray();
        functions[0] = functions[0] with
        {
            Instructions = functions[0].Instructions.Where(i => i is not PortablePushInstruction).ToArray()
        };
        byte[] bytes = PortableBinaryCodec.Encode(module with { Executable = executable with { Functions = functions } });
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    private static long RunOneArgument(string assembly, string label, long argument)
    {
        string body = $"mov rax, 0x{unchecked((ulong)argument):X16}\npush rax\n" +
            $"call {label}\nadd rsp, 8\npush rax";
        return Assert.Single(NativeStack.Run(body, 1, assembly));
    }
}
