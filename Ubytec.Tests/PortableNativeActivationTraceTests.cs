using System.Diagnostics;
using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableNativeActivationTraceTests
{
    private static byte[] Image(bool fault = false)
    {
        string leaf = fault ? "trap" : "push 7\nreturn";
        var source = SourceCompiler.Compile($$"""
            module (name:"activation-trace", version:"0.1", author:"Ubytec")
            {
                func Recur(t_int64 n) -> t_int64
                {
                    if @n <= 0
                        {{leaf}}
                    end
                    load @n
                    dec
                    call Recur
                    return
                }
            }
            """, emitProcessEntryPoint: false);
        return PortableModuleFormat.Encode(source.Module, contractManifest: null,
            includeIndexedExecutable: true, portableContracts: source.PortableContracts,
            executionProfile: PortableExecutionProfile.DirectOnly);
    }

    [Theory]
    [InlineData(false)]
    [InlineData(true)]
    public void ObserveRecursiveInvocationsAndDistinguishAborts(bool fault)
    {
        if (!OperatingSystem.IsLinux() || System.Runtime.InteropServices.RuntimeInformation.ProcessArchitecture
            != System.Runtime.InteropServices.Architecture.X64) return;
        byte[] bytes = Image(fault);
        var native = PortableX64Backend.CompileWithProvenance(bytes, traceActivations: true);
        Assert.Equal(2, native.ActivationMarkers.Count);
        Assert.Empty(PortableX64Backend.CompileWithProvenance(bytes).ActivationMarkers);
        string dir = Path.Combine(Path.GetTempPath(), "ubytec-activation-" + Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(dir);
        try
        {
            string asm = Path.Combine(dir, "test.asm"), obj = Path.Combine(dir, "test.o");
            string exe = Path.Combine(dir, "test"), observer = Path.Combine(dir, "observer");
            File.WriteAllText(asm, native.Compilation.Assembly +
                $"\nsection .text\nglobal _start\n_start:\n  push 2\n  call {native.Compilation.GetFunctionLabel(0)}\n  add rsp, 8\n  mov edi, eax\n  mov eax, 60\n  syscall\n");
            Run("gcc", dir, "-std=c11", "-Wall", "-Wextra", "-Werror", "-O2",
                Path.Combine(AppContext.BaseDirectory, "observe_native_fault.c"), "-o", observer);
            Run(Environment.GetEnvironmentVariable("UBYTEC_NASM") ?? "nasm", dir, "-f", "elf64", "-o", obj, asm);
            Run("ld", dir, "-o", exe, obj);
            byte[] elf = File.ReadAllBytes(exe);
            var map = PortableElfProvenance.Resolve(elf, native);
            string observations = Run(observer, dir, "--activations", exe);
            Assert.Equal(elf, File.ReadAllBytes(exe));
            var trace = PortableNativeActivationTrace.Consume(bytes, PortableExecutionProfile.DirectOnly, map, elf, observations);
            var events = trace.Events;
            Assert.Equal(Enumerable.Range(1, events.Count).Select(i => (ulong)i), events.Select(e => e.CommitSequence));
            Assert.Equal(events.Select(e => e.CommitSequence), events.Select(e => e.LogicalTime));
            Assert.Equal(events.Select(e => e.CommitSequence), events.Select(e => e.Id.Sequence));
            var entries = events.Take(3).Select(e => e.Lifecycle!.Value).ToArray();
            Assert.All(entries, e => Assert.Equal(PortableLifecycleKind.Enter, e.Kind));
            Assert.Equal(new ulong[] { 1, 2, 3 }, entries.Select(e => e.Activation.Ordinal));
            Assert.All(entries, e => Assert.Equal(0U, e.FunctionIndex));
            if (fault)
            {
                Assert.Null(trace.ExitCode);
                var observed = events[3].Fault!.Value;
                Assert.Equal(entries[2].Activation, observed.Activation);
                Assert.Equal(PortableFaultCategory.IntentionalTrap, observed.Category);
                Assert.Equal(PortableTrapKind.ExplicitTrap, observed.Attribution!.Value.TrapKind);
            }
            else
                Assert.Equal(7, trace.ExitCode);
            var closed = events.Skip(fault ? 4 : 3).Select(e => e.Lifecycle!.Value).ToArray();
            Assert.Equal(new ulong[] { 3, 2, 1 }, closed.Select(e => e.Activation.Ordinal));
            Assert.All(closed, e => Assert.Equal(fault ? PortableLifecycleKind.Abort : PortableLifecycleKind.Leave, e.Kind));

            // Missing terminal, unknown marker, conflicting stack and trailing data fail closed.
            string[] lines = observations.TrimEnd().Split('\n');
            Assert.Throws<InvalidDataException>(() => PortableNativeActivationTrace.Consume(bytes,
                PortableExecutionProfile.DirectOnly, map, elf, string.Join("\n", lines[..^1])));
            Assert.Throws<InvalidDataException>(() => PortableNativeActivationTrace.Consume(bytes,
                PortableExecutionProfile.DirectOnly, map, elf, observations + "{\"kind\":\"exit\",\"code\":0}\n"));
            Assert.Throws<InvalidDataException>(() => PortableNativeActivationTrace.Consume(bytes,
                PortableExecutionProfile.DirectOnly, map, elf, "{\"kind\":\"activation\",\"image_offset\":0,\"rsp\":100}\n"));
        }
        finally { Directory.Delete(dir, true); }
    }

    [Fact]
    public void PublicationRequiresContinuousLocalSequenceAndCommittedDependency()
    {
        var identity = new PortableRuntimeIdentity();
        var instance = identity.Load(Image(), PortableExecutionProfile.DirectOnly);
        var a = identity.CreateContext();
        var b = identity.CreateContext();
        var first = identity.EnterObserved(a, instance, 0);
        var second = identity.EnterObserved(b, instance, 0);
        var third = identity.CloseObserved(first.Activation);
        var publisher = new PortableEventPublication(identity.Session);
        Assert.Throws<InvalidDataException>(() => publisher.Publish(third));
        Assert.Throws<InvalidDataException>(() => publisher.Publish(second, first.Id));
        Assert.Empty(publisher.Events);
        Assert.Equal(1UL, publisher.Publish(first).LogicalTime);
        Assert.Equal(2UL, publisher.Publish(second, first.Id).LogicalTime);
        var final = publisher.Publish(third, second.Id);
        Assert.Equal(3UL, final.LogicalTime);
        Assert.Equal(3UL, final.CommitSequence);
        Assert.Throws<InvalidDataException>(() => publisher.Publish(first));
        Assert.Throws<InvalidDataException>(() => new PortableEventPublication(Guid.NewGuid()).Publish(first));
        Assert.Equal(3, publisher.Events.Count);
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
        string output = stdout.GetAwaiter().GetResult(), error = stderr.GetAwaiter().GetResult();
        Assert.True(process.ExitCode == 0, $"{executable}: {process.ExitCode}: {error}\n{output}");
        return output;
    }
}
