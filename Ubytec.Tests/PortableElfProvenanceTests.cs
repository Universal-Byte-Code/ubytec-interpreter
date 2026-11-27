using System.Diagnostics;
using System.Security.Cryptography;
using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableElfProvenanceTests
{
    private static byte[] Image()
    {
        var source = SourceCompiler.Compile("""
            module (name:"elf-provenance", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 1
                    return
                }
            }
            """, emitProcessEntryPoint: false);
        var module = PortableBinaryCodec.Decode(PortableModuleFormat.Encode(source.Module,
            contractManifest: null, includeIndexedExecutable: true, portableContracts: source.PortableContracts,
            executionProfile: PortableExecutionProfile.DirectOnly));
        var executable = module.Executable!;
        var functions = executable.Functions.ToArray();
        functions[0] = functions[0] with { Instructions = [new PortableOperandFreeInstruction(0x00)] };
        return PortableBinaryCodec.Encode(module with { Executable = executable with { Functions = functions } });
    }

    [Fact]
    public void MalformedElfAndAssemblyDigestFailClosed()
    {
        var native = PortableX64Backend.CompileWithProvenance(Image());
        Assert.Throws<InvalidDataException>(() => PortableElfProvenance.Resolve(new byte[64], native));
        Assert.Throws<InvalidDataException>(() => PortableElfProvenance.Resolve(Array.Empty<byte>(), native));
    }

    [Fact]
    public void LinkedElfBindsExactTrapAndRejectsMissingSymbols()
    {
        if (!OperatingSystem.IsLinux()) return;
        byte[] image = Image();
        var native = PortableX64Backend.CompileWithProvenance(image);
        string directory = Path.Combine(Path.GetTempPath(), "ubytec-elf-prov-" + Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(directory);
        try
        {
            string asm = Path.Combine(directory, "test.asm");
            string obj = Path.Combine(directory, "test.o");
            string exe = Path.Combine(directory, "test");
            string stripped = Path.Combine(directory, "stripped");
            File.WriteAllText(asm, native.Compilation.Assembly +
                $"\nsection .text\nglobal _start\n_start:\n  call {native.Compilation.GetFunctionLabel(0)}\n  xor edi, edi\n  mov eax, 60\n  syscall\n");
            Assert.Equal(0, Run(Environment.GetEnvironmentVariable("UBYTEC_NASM") ?? "nasm", directory, "-f", "elf64", "-o", obj, asm));
            Assert.Equal(0, Run("ld", directory, "-o", exe, obj));
            byte[] elf = File.ReadAllBytes(exe);
            var map = PortableElfProvenance.Resolve(elf, native);
            Assert.Equal(Convert.ToHexString(SHA256.HashData(elf)), map.ArtifactDigest);
            Assert.Equal(native.AssemblyDigest, map.AssemblyDigest);
            var site = Assert.Single(map.Sites);
            ulong trap = Assert.Single(site.Ud2Offsets);
            Assert.Equal(site.Start, trap);
            Assert.Equal(2UL, site.End - site.Start);
            var attribution = map.Attribute(map.ArtifactDigest, trap);
            Assert.True(attribution.HasValue);
            Assert.True(attribution.Value.ExactUd2);
            Assert.Equal(PortableBinaryVerifier.IdentifyInstruction(image, 0, 0), attribution.Value.Occurrence);
            Assert.False(map.Attribute(map.ArtifactDigest, trap + 1)!.Value.ExactUd2);
            Assert.Null(map.Attribute(map.ArtifactDigest, site.End));
            Assert.Null(map.Attribute(map.ArtifactDigest, 0));

            var runtime = new PortableRuntimeIdentity();
            var loaded = runtime.Load(image, PortableExecutionProfile.DirectOnly);
            var context = runtime.CreateContext();
            Assert.Throws<InvalidDataException>(() => runtime.BindNative(loaded, map, new byte[1]));
            runtime.BindNative(loaded, map, elf);
            Assert.Throws<InvalidOperationException>(() => runtime.BindNative(loaded, map, elf));
            var activation = runtime.Enter(context, loaded, 0);
            var exact = runtime.RecordNativeFault(activation, trap, 4);
            var unknown = runtime.RecordNativeFault(activation, 0, 11);
            Assert.Equal(1UL, exact.Id.Sequence);
            Assert.Equal(2UL, unknown.Id.Sequence);
            Assert.Equal(attribution, exact.Attribution);
            Assert.Null(unknown.Attribution);
            Assert.Equal(4, exact.Signal);
            Assert.Equal(11, unknown.Signal);
            Assert.Equal(3UL, runtime.Record(activation, 0).Id.Sequence);
            runtime.Leave(activation);
            Assert.Throws<InvalidOperationException>(() => runtime.RecordNativeFault(activation, trap, 4));
            Assert.Throws<InvalidDataException>(() => map.Attribute(new string('0', 64), trap));
            Assert.Throws<InvalidDataException>(() => PortableElfProvenance.Resolve(elf,
                native with { AssemblyDigest = new string('0', 64) }));
            Assert.Equal(0, Run("ld", directory, "-s", "-o", stripped, obj));
            Assert.Throws<InvalidDataException>(() => PortableElfProvenance.Resolve(File.ReadAllBytes(stripped), native));
        }
        finally { Directory.Delete(directory, true); }
    }

    private static int Run(string executable, string directory, params string[] arguments)
    {
        var info = new ProcessStartInfo(executable) { WorkingDirectory = directory, UseShellExecute = false };
        foreach (string argument in arguments) info.ArgumentList.Add(argument);
        using var process = Process.Start(info)!;
        if (!process.WaitForExit(10_000))
        {
            process.Kill(entireProcessTree: true);
            throw new TimeoutException(executable);
        }
        return process.ExitCode;
    }
}
