using System.Buffers.Binary;
using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableInstructionIdentityTests
{
    private const string Source = """
        module (name:"instruction-identity", version:"0.1", author:"Ubytec")
        {
            func Main() -> t_int64
            {
                push 1
                return
            }
        }
        """;

    private static byte[] Image(byte value = 1)
    {
        var source = SourceCompiler.Compile(Source, emitProcessEntryPoint: false);
        var module = PortableBinaryCodec.Decode(PortableModuleFormat.Encode(source.Module,
            contractManifest: null, includeIndexedExecutable: true, portableContracts: source.PortableContracts));
        var executable = module.Executable!;
        var functions = executable.Functions.ToArray();
        functions[0] = functions[0] with
        {
            Instructions =
            [
                new PortablePushInstruction([value]),
                new PortablePushInstruction([value]),
                new PortableOperandFreeInstruction(0x20),
                new PortableReturnInstruction(null)
            ]
        };
        return PortableBinaryCodec.Encode(module with { Executable = executable with { Functions = functions } });
    }

    [Fact]
    public void EqualInstructionsHaveDistinctVerifiedOccurrences()
    {
        byte[] bytes = Image();
        var first = PortableBinaryVerifier.IdentifyInstruction(bytes, 0, 0);
        var second = PortableBinaryVerifier.IdentifyInstruction(bytes, 0, 3);
        Assert.Equal(first.ExecutableDigest, second.ExecutableDigest);
        Assert.Equal(64, first.ExecutableDigest.Length);
        Assert.NotEqual(first, second);
        Assert.Equal(first, PortableBinaryVerifier.IdentifyInstruction(bytes, 0, 0));
        Assert.Equal(6u, PortableBinaryVerifier.IdentifyInstruction(bytes, 0, 6).InstructionOffset);
        Assert.Equal(7u, PortableBinaryVerifier.IdentifyInstruction(bytes, 0, 7).InstructionOffset);
    }

    [Theory]
    [InlineData(0u, 1u)]
    [InlineData(0u, 2u)]
    [InlineData(0u, 8u)]
    [InlineData(0u, 9u)]
    [InlineData(1u, 0u)]
    public void RejectsNonBoundaries(uint function, uint offset)
    {
        byte[] bytes = Image();
        Assert.Throws<InvalidDataException>(() =>
            PortableBinaryVerifier.IdentifyInstruction(bytes, function, offset));
    }

    [Fact]
    public void DigestIncludesExecutableBytesButNotUnknownOptionalMetadata()
    {
        byte[] bytes = Image();
        var first = PortableBinaryVerifier.IdentifyInstruction(bytes, 0, 0);
        Assert.NotEqual(first.ExecutableDigest,
            PortableBinaryVerifier.IdentifyInstruction(Image(2), 0, 0).ExecutableDigest);

        byte[] augmented = new byte[bytes.Length + 13];
        bytes.CopyTo(augmented, 0);
        uint count = BinaryPrimitives.ReadUInt32LittleEndian(augmented.AsSpan(8, 4));
        BinaryPrimitives.WriteUInt32LittleEndian(augmented.AsSpan(8, 4), count + 1);
        BinaryPrimitives.WriteUInt16LittleEndian(augmented.AsSpan(bytes.Length, 2), 0x7FFE);
        BinaryPrimitives.WriteUInt64LittleEndian(augmented.AsSpan(bytes.Length + 4, 8), 1);
        augmented[^1] = 0xAA;
        Assert.Equal(first, PortableBinaryVerifier.IdentifyInstruction(augmented, 0, 0));
    }

    [Fact]
    public void InvalidImageCannotReturnEarlierOccurrence()
    {
        byte[] bytes = Image();
        Array.Resize(ref bytes, bytes.Length - 1);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.IdentifyInstruction(bytes, 0, 0));
    }
}
