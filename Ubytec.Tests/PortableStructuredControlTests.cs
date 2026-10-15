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
        Assert.Contains(BREAK.OP, structured);
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

    private static long RunOneArgument(string assembly, string label, long argument)
    {
        string body = $"mov rax, 0x{unchecked((ulong)argument):X16}\npush rax\n" +
            $"call {label}\nadd rsp, 8\npush rax";
        return Assert.Single(NativeStack.Run(body, 1, assembly));
    }
}
