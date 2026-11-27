using System.Text.Json;
using Ubytec.Language.AST;
using Ubytec.Language.Operations.Extended;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

/// <summary>Fail when a registered legacy opcode lacks an actual portable codegen fixture.</summary>
public sealed class PortableIsaCoverageTests
{
    private static Dictionary<string, string> Registry()
    {
        using var document = JsonDocument.Parse(File.ReadAllText(
            Path.Combine(AppContext.BaseDirectory, "legacy-opcodes.json")));
        return document.RootElement.GetProperty("opcodes").EnumerateArray().ToDictionary(
            row => row.GetProperty("id").GetString()!,
            row => row.GetProperty("name").GetString()!);
    }

    [Fact]
    public void RegistrySnapshotMatchesImplementedLegacyOpcodeIdentities()
    {
        var actual = new Dictionary<string, string>();
        foreach (Type type in typeof(IOpCode).Assembly.GetTypes())
        {
            if (!type.IsValueType || type.IsAbstract || !typeof(IOpCode).IsAssignableFrom(type))
                continue;
            if (Activator.CreateInstance(type) is not IOpCode operation)
                continue;
            string key = operation is IExtendedOpCode ext
                ? Convert.ToHexString(ext.OpcodeId.Encode()) : operation.OpCode.ToString("X2");
            string name = type.Name.StartsWith("Two", StringComparison.Ordinal)
                ? "2" + type.Name[3..] : type.Name;
            Assert.True(actual.TryAdd(key, name), $"Duplicate legacy opcode {key}");
        }
        Assert.Equal(Registry().OrderBy(x => x.Key), actual.OrderBy(x => x.Key));
    }

    [Fact]
    public void EveryAssignedLegacyOpcodeCrossesIndependentVerifierCodecAndX64Backend()
    {
        var seen = new HashSet<string>();
        foreach (string body in Bodies())
        {
            string source = $$"""
                module (name:"isa-coverage", version:"0.1", author:"Ubytec")
                {
                    func Target() -> t_int64
                    {
                        push 7
                        return
                    }
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
            PortableBinaryModule decoded = PortableBinaryCodec.Decode(bytes);
            Assert.Equal(bytes, PortableBinaryCodec.Encode(decoded));
            Assert.False(string.IsNullOrWhiteSpace(PortableX64Backend.Compile(bytes).Assembly));
            foreach (var instruction in decoded.Executable!.Functions.SelectMany(f => f.Instructions))
            {
                string key = instruction is PortableExtendedStackInstruction ext
                    ? $"FF10{ext.Operation:X2}" : instruction.OpCode.ToString("X2");
                seen.Add(key);
            }
        }
        // Extended source grammar is intentionally not inferred from lexer highlighting.
        // Exercise each legacy extension through the typed codec using an ordinary
        // module fixture. Source syntax coverage is a separate gate.
        const string scalar = """
            module (name:"isa-extended", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 42
                    return
                }
            }
            """;
        var original = SourceCompiler.Compile(scalar, emitProcessEntryPoint: false);
        var model = PortableBinaryCodec.Decode(PortableModuleFormat.Encode(original.Module,
            contractManifest: null, includeIndexedExecutable: true, portableContracts: original.PortableContracts));
        foreach (byte op in new byte[] { 0x11, 0x18, 0x1D, 0x1E })
        {
            var executable = model.Executable!;
            var functions = executable.Functions.ToArray();
            functions[0] = functions[0] with
            {
                Instructions = [new PortablePushInstruction([7]), new PortablePushInstruction([42]),
                    new PortableExtendedStackInstruction(op, 0), new PortableReturnInstruction(null)]
            };
            byte[] bytes = PortableBinaryCodec.Encode(model with
            {
                Executable = executable with { Functions = functions }
            });
            PortableBinaryVerifier.Verify(bytes);
            var decoded = PortableBinaryCodec.Decode(bytes);
            Assert.Equal(bytes, PortableBinaryCodec.Encode(decoded));
            Assert.False(string.IsNullOrWhiteSpace(PortableX64Backend.Compile(bytes).Assembly));
            foreach (var ext in decoded.Executable!.Functions.SelectMany(f => f.Instructions).OfType<PortableExtendedStackInstruction>())
                seen.Add($"FF10{ext.Operation:X2}");
        }
        Assert.Equal(Registry().Keys.OrderBy(x => x), seen.OrderBy(x => x));
    }

    private static IEnumerable<string> Bodies()
    {
        yield return "trap";
        yield return "nop\nblock\nnop\nend\npush 42\nreturn";
        yield return "loop\npush 0\nif\ncontinue\nend\nbreak\nend\npush 42\nreturn";
        yield return "push 1\nif\npush 7\nelse\npush 42\nend\nreturn";
        yield return "push 0\nwhile\npush 0\nend\npush 42\nreturn";
        yield return "push 2\nswitch\nbranch 1\npush 7\nend\ndefault\npush 42\nend\nreturn";
        yield return "push 1\nclear\nnull\npop\ndefault\nreturn";
        yield return "t_int64 value 0\npush 42\nstore @value\nload @value\nreturn";
        yield return "call Target\nreturn";
        yield return "fnaddr Target\ncalli 0 t_int64\nreturn";
        foreach (string op in new[] { "dup", "swap", "rot", "over", "nip", "drop 0",
            "2dup", "2swap", "2rot", "2over", "pick 0", "roll 0" })
            yield return "push 1\npush 2\npush 3\npush 4\npush 5\npush 6\n" + op + "\nreturn";
        foreach (string op in new[] { "add", "sub", "mul", "div", "mod", "udiv", "umod",
            "and", "or", "xor", "shl", "shr", "lshr", "eq", "neq", "lt", "le", "gt", "ge",
            "ult", "ule", "ugt", "uge" })
            yield return "push 42\npush 2\n" + op + "\nreturn";
        foreach (string op in new[] { "inc", "dec", "neg", "abs", "not" })
            yield return "push 42\n" + op + "\nreturn";
    }
}
