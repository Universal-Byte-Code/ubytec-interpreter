using System.Diagnostics;
using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Tests;

public sealed class PortableContractBlockTests
{
    private const string Source = """
        module (name:"contract-block", version:"0.1", author:"Ubytec")
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

    [Theory]
    [InlineData("block checked (t_int64, t_int64) -> t_int16", "add\nbreak")]
    [InlineData("block checked 9 (t_int64, t_int64) -> t_int16", "add\nloop\nbreak 9\nend")]
    public void SourceSignatureAndLabeledBreakCrossPortablePipeline(string header, string body)
    {
        string sourceText = $$"""
            module (name:"contract-source", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 100
                    push 2
                    push 40
                    {{header}}
                    {{body}}
                    end
                    add
                    return
                }
            }
            """;
        var source = SourceCompiler.Compile(sourceText, emitProcessEntryPoint: false);
        byte[] bytes = PortableModuleFormat.Encode(source.Module, contractManifest: null,
            includeIndexedExecutable: true, portableContracts: source.PortableContracts,
            executionProfile: PortableExecutionProfile.DirectOnly);
        PortableBinaryVerifier.Verify(bytes, PortableExecutionProfile.DirectOnly);
        var decoded = PortableBinaryCodec.Decode(bytes);
        var block = Assert.Single(decoded.Executable!.Functions[0].Instructions.OfType<PortableContractBlockInstruction>());
        Assert.True(block.Checked);
        Assert.Equal(2, block.InputTypeIndices.Count);
        var native = PortableX64Backend.Compile(bytes);
        Assert.Equal(142L, Assert.Single(NativeStack.Run(
            $"call {source.GetFunctionLabel("Main")}\npush rax", 1, source.Assembly)));
        Assert.Equal(142L, Assert.Single(NativeStack.Run(
            $"call {native.GetFunctionLabel(0)}\npush rax", 1, native.Assembly)));
    }

    private static byte[] Image(Func<uint, uint, PortableInstruction[]> instructions)
    {
        var source = SourceCompiler.Compile(Source, emitProcessEntryPoint: false);
        var module = PortableBinaryCodec.Decode(PortableModuleFormat.Encode(source.Module,
            contractManifest: null, includeIndexedExecutable: true, portableContracts: source.PortableContracts));
        var executable = module.Executable!;
        uint wide = executable.Functions[0].ReturnTypeIndex;
        uint narrow = (uint)Array.FindIndex(executable.Types.ToArray(), t => t.Primitive == PrimitiveType.Int16);
        Assert.NotEqual(uint.MaxValue, narrow);
        var functions = executable.Functions.ToArray();
        functions[0] = functions[0] with { Instructions = instructions(wide, narrow) };
        return PortableBinaryCodec.Encode(module with { Executable = executable with
        {
            Functions = functions,
            Contexts = new PortableContextTable(PortableExecutionProfile.DirectOnly,
                executable.Contexts.ParentFunctionIndices)
        } });
    }

    [Theory]
    [InlineData(false)]
    [InlineData(true)]
    public void ContractConsumesInputsPreservesPrefixAndReturnsThroughBreak(bool earlyExit)
    {
        byte[] bytes = Image((wide, narrow) =>
        [
            new PortablePushInstruction([100]),
            new PortablePushInstruction([2]),
            new PortablePushInstruction([40]),
            new PortableContractBlockInstruction([wide, wide], narrow, true),
            new PortableOperandFreeInstruction(0x20), // ADD
            .. (earlyExit ? new PortableInstruction[] { new PortableControlTransferInstruction(0x07, 0) } : []),
            new PortableOperandFreeInstruction(0x06), // END
            new PortableOperandFreeInstruction(0x20),
            new PortableReturnInstruction(null)
        ]);
        PortableBinaryVerifier.Verify(bytes, PortableExecutionProfile.DirectOnly);
        Assert.Equal(bytes, PortableBinaryCodec.Encode(PortableBinaryCodec.Decode(bytes)));
        var native = PortableX64Backend.Compile(bytes);
        Assert.Equal(142L, Assert.Single(NativeStack.Run(
            $"call {native.GetFunctionLabel(0)}\npush rax", 1, native.Assembly)));
    }

    [Theory]
    [InlineData(false)]
    [InlineData(true)]
    public void UncheckedNarrowingAppliesOnBothExits(bool earlyExit)
    {
        byte[] bytes = Conversion(earlyExit, false, false);
        PortableBinaryVerifier.Verify(bytes, PortableExecutionProfile.DirectOnly);
        var native = PortableX64Backend.Compile(bytes);
        Assert.Equal(-1L, Assert.Single(NativeStack.Run(
            $"call {native.GetFunctionLabel(0)}\npush rax", 1, native.Assembly)));
    }

    [Theory]
    [InlineData(false, false)]
    [InlineData(true, false)]
    [InlineData(false, true)]
    public void CheckedConversionTrapsInIsolatedLinuxProcess(bool earlyExit, bool input)
    {
        if (!OperatingSystem.IsLinux()) return;
        var native = PortableX64Backend.Compile(Conversion(earlyExit, true, input));
        string directory = Path.Combine(Path.GetTempPath(), "ubytec-checked-" + Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(directory);
        try
        {
            string asm = Path.Combine(directory, "test.asm");
            string obj = Path.Combine(directory, "test.o");
            string exe = Path.Combine(directory, "test");
            File.WriteAllText(asm, native.Assembly + $"\nsection .text\nglobal _start\n_start:\n  call {native.GetFunctionLabel(0)}\n  xor edi, edi\n  mov eax, 60\n  syscall\n");
            Assert.Equal(0, RunProcess(Environment.GetEnvironmentVariable("UBYTEC_NASM") ?? "nasm", directory, "-f", "elf64", "-o", obj, asm));
            Assert.Equal(0, RunProcess("ld", directory, "-o", exe, obj));
            int exit = RunProcess(exe, directory);
            Assert.Equal(132, exit); // SIGILL (UD2), not an ordinary nonzero function return.
        }
        finally { Directory.Delete(directory, true); }
    }

    private static byte[] Conversion(bool earlyExit, bool check, bool input) => Image((wide, narrow) =>
    [
        .. (input ? new PortableInstruction[] { new PortablePushInstruction([255, 255]) } : []),
        new PortableContractBlockInstruction(input ? [narrow] : [], narrow, check),
        .. (input ? [] : new PortableInstruction[] { new PortablePushInstruction([255, 255]) }),
        .. (earlyExit ? new PortableInstruction[] { new PortableControlTransferInstruction(0x07, 0) } : []),
        new PortableOperandFreeInstruction(0x06),
        new PortableReturnInstruction(null)
    ]);

    [Theory]
    [InlineData(0)]
    [InlineData(1)]
    [InlineData(2)]
    public void RejectsInvalidStackAccessOrExit(int scenario)
    {
        byte[] bytes = Image((wide, narrow) =>
        [
            new PortablePushInstruction([100]),
            new PortablePushInstruction([42]),
            new PortableContractBlockInstruction([wide], narrow, false),
            scenario switch
            {
                0 => new PortableStackIndexInstruction(0x1D, 1), // PICK below floor
                1 => new PortableExtendedStackInstruction(0x11, 7), // 2-byte cross-floor read
                _ => new PortableOperandFreeInstruction(0x0D) // CLEAR
            },
            new PortableOperandFreeInstruction(0x06),
            new PortableReturnInstruction(null)
        ]);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    private static int RunProcess(string file, string directory, params string[] args)
    {
        var start = new ProcessStartInfo(file) { WorkingDirectory = directory, UseShellExecute = false,
            RedirectStandardError = true, RedirectStandardOutput = true };
        foreach (string arg in args) start.ArgumentList.Add(arg);
        using var process = Process.Start(start)!;
        Assert.True(process.WaitForExit(30000), $"{file} did not finish.");
        string error = process.StandardError.ReadToEnd();
        if (process.ExitCode != 0 && file != Path.Combine(directory, "test"))
            Assert.Fail(error);
        return process.ExitCode;
    }
}
