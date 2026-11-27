using System.Security.Cryptography;
using System.Text;
using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableNativeProvenanceTests
{
    private static byte[] Image(bool trap)
    {
        var source = SourceCompiler.Compile("""
            module (name:"native-provenance", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 1
                    return
                }
            }
            """, emitProcessEntryPoint: false);
        byte[] bytes = PortableModuleFormat.Encode(source.Module, contractManifest: null,
            includeIndexedExecutable: true, portableContracts: source.PortableContracts,
            executionProfile: PortableExecutionProfile.DirectOnly);
        if (!trap) return bytes;
        var module = PortableBinaryCodec.Decode(bytes);
        var executable = module.Executable!;
        var functions = executable.Functions.ToArray();
        functions[0] = functions[0] with { Instructions = [new PortableOperandFreeInstruction(0x00)] };
        return PortableBinaryCodec.Encode(module with { Executable = executable with { Functions = functions } });
    }

    [Fact]
    public void IndexBoundsAndStableEmission()
    {
        byte[] bytes = Image(false);
        var index = PortableBinaryVerifier.IdentifyInstructions(bytes, 2);
        Assert.Equal(new uint[] { 0, 10 }, index.Select(site => site.InstructionOffset).ToArray());
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.IdentifyInstructions(bytes, 1));
        var native = PortableX64Backend.CompileWithProvenance(bytes);
        Assert.Equal(index.ToArray(), native.Sites.Select(site => site.Occurrence).ToArray());
        Assert.Equal(native.AssemblyDigest,
            Convert.ToHexString(SHA256.HashData(Encoding.UTF8.GetBytes(native.Compilation.Assembly))));
        foreach (var site in native.Sites)
        {
            Assert.Contains(site.BeginLabel + ":", native.Compilation.Assembly);
            Assert.Contains(site.EndLabel + ":", native.Compilation.Assembly);
            Assert.Empty(site.Ud2Labels);
        }
        Assert.DoesNotContain("..@ubytec_prov_", PortableX64Backend.Compile(bytes).Assembly);
        Assert.Equal(1L, Assert.Single(NativeStack.Run(
            $"call {native.Compilation.GetFunctionLabel(0)}\npush rax", 1, native.Compilation.Assembly)));
    }

    [Fact]
    public void ExplicitTrapHasExactEmittedUd2Marker()
    {
        byte[] bytes = Image(true);
        var native = PortableX64Backend.CompileWithProvenance(bytes);
        var site = Assert.Single(native.Sites);
        Assert.Equal(PortableBinaryVerifier.IdentifyInstruction(bytes, 0, 0), site.Occurrence);
        string trap = Assert.Single(site.Ud2Labels);
        Assert.Contains(trap + ":\n  ud2", native.Compilation.Assembly);
    }
}
