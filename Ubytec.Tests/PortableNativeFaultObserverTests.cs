using System.Diagnostics;
using System.Text.Json;
using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableNativeFaultObserverTests
{
    [Theory]
    [InlineData("trap", PortableTrapKind.ExplicitTrap, -1)]
    [InlineData("push 1\npush 65535\nblock checked (t_int16, t_int16) -> t_int16\nadd\nend\nreturn", PortableTrapKind.CheckedBlockInput, 1)]
    [InlineData("push 65535\nblock checked (t_int64) -> t_int16\nend\nreturn", PortableTrapKind.CheckedBlockResult, -1)]
    [InlineData("push 65535\nblock checked (t_int64) -> t_int16\nbreak\nend\nreturn", PortableTrapKind.CheckedBlockResult, -1)]
    public void SupervisorObservesActualNativeTrap(string body, PortableTrapKind expected, int inputIndex)
    {
        if (!OperatingSystem.IsLinux() || System.Runtime.InteropServices.RuntimeInformation.ProcessArchitecture
            != System.Runtime.InteropServices.Architecture.X64) return;

        string sourceText = $$"""
            module (name:"observed-fault", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    {{body}}
                }
            }
            """;
        var source = SourceCompiler.Compile(sourceText, emitProcessEntryPoint: false);
        byte[] bytes = PortableModuleFormat.Encode(source.Module, contractManifest: null,
            includeIndexedExecutable: true, portableContracts: source.PortableContracts,
            executionProfile: PortableExecutionProfile.DirectOnly);
        var native = PortableX64Backend.CompileWithProvenance(bytes);
        string directory = Path.Combine(Path.GetTempPath(), "ubytec-observer-" + Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(directory);
        try
        {
            string observer = Path.Combine(directory, "observer");
            string asm = Path.Combine(directory, "test.asm");
            string obj = Path.Combine(directory, "test.o");
            string exe = Path.Combine(directory, "test");
            Run("gcc", directory, "-std=c11", "-Wall", "-Wextra", "-Werror", "-O2",
                Path.Combine(AppContext.BaseDirectory, "observe_native_fault.c"), "-o", observer);
            File.WriteAllText(asm, native.Compilation.Assembly +
                $"\nsection .text\nglobal _start\n_start:\n  call {native.Compilation.GetFunctionLabel(0)}\n  xor edi, edi\n  mov eax, 60\n  syscall\n");
            Run(Environment.GetEnvironmentVariable("UBYTEC_NASM") ?? "nasm", directory, "-f", "elf64", "-o", obj, asm);
            Run("ld", directory, "-o", exe, obj);
            byte[] elf = File.ReadAllBytes(exe);
            var map = PortableElfProvenance.Resolve(elf, native);
            var runtime = new PortableRuntimeIdentity();
            var loaded = runtime.Load(bytes, PortableExecutionProfile.DirectOnly);
            runtime.BindNative(loaded, map, elf);
            // Fixture enters exactly one portable function. Production activation observation is still required.
            var activation = runtime.Enter(runtime.CreateContext(), loaded, 0);
            using var observation = JsonDocument.Parse(Run(observer, directory, exe));
            var root = observation.RootElement;
            Assert.Equal("fault", root.GetProperty("kind").GetString());
            int signal = root.GetProperty("signal").GetInt32();
            int code = root.GetProperty("code").GetInt32();
            var offset = root.GetProperty("image_offset");
            Assert.NotEqual(JsonValueKind.Null, offset.ValueKind);
            Assert.Equal(elf, File.ReadAllBytes(exe));
            var fault = runtime.RecordNativeFault(activation, offset.GetUInt64(), signal, code);
            Assert.Equal(4, signal);
            Assert.Equal(2, code);
            Assert.Equal(PortableFaultCategory.IntentionalTrap, fault.Category);
            Assert.True(fault.Attribution.HasValue);
            Assert.True(fault.Attribution.Value.ExactUd2);
            Assert.Equal(expected, fault.Attribution.Value.TrapKind);
            Assert.Equal(inputIndex < 0 ? (int?)null : inputIndex, fault.Attribution.Value.InputIndex);
            Assert.Equal(1UL, fault.Id.Sequence);
            var unknown = runtime.RecordNativeFault(activation, null, 11, 1);
            Assert.Null(unknown.Attribution);
            Assert.Equal(PortableFaultCategory.MemorySignal, unknown.Category);
            Assert.Equal(2UL, unknown.Id.Sequence);
            runtime.Leave(activation);
        }
        finally { Directory.Delete(directory, true); }
    }

    private static string Run(string executable, string directory, params string[] arguments)
    {
        var info = new ProcessStartInfo(executable)
        {
            WorkingDirectory = directory, UseShellExecute = false,
            RedirectStandardOutput = true, RedirectStandardError = true
        };
        foreach (string argument in arguments) info.ArgumentList.Add(argument);
        using var process = Process.Start(info)!;
        var stdout = process.StandardOutput.ReadToEndAsync();
        var stderr = process.StandardError.ReadToEndAsync();
        if (!process.WaitForExit(15_000))
        {
            process.Kill(entireProcessTree: true);
            throw new TimeoutException(executable);
        }
        string output = stdout.GetAwaiter().GetResult();
        string error = stderr.GetAwaiter().GetResult();
        Assert.True(process.ExitCode == 0, $"{executable}: {process.ExitCode}: {error}\n{output}");
        return output;
    }
}
