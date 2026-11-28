using System.Runtime.InteropServices;
using System.Buffers.Binary;
using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableSelfHostedTemporalTests
{
    private static byte[] Image(string body)
    {
        var source = SourceCompiler.Compile($$"""
            module (name:"temporal-guest",version:"0.1",author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    {{body}}
                }
            }
            """, emitProcessEntryPoint: false);
        var binary = PortableBinaryCodec.Decode(PortableModuleFormat.Encode(source.Module,
            contractManifest: null, includeIndexedExecutable: true, portableContracts: source.PortableContracts,
            executionProfile: PortableExecutionProfile.DirectOnly));
        var executable = binary.Executable!;
        var function = executable.Functions[0];
        // Explicitly exercise the inferred return wire form.
        var code = function.Instructions.Select(i => i is PortableReturnInstruction ? new PortableReturnInstruction(null) : i).ToArray();
        return PortableBinaryCodec.Encode(binary with { Executable = executable with
        {
            Functions = new[] { function with { Instructions = code } }
        } });
    }

    [Theory]
    [InlineData("push 20\npush 22\nadd\nreturn", 2, 2)]
    [InlineData("nop\npush 42\nreturn", 3, 1)]
    [InlineData("push 1\ntrap", 1, 3)]
    [InlineData("push 20\npush 3\nsub\npush 2\nmul\ninc\ndec\nneg\nabs\nreturn", 2, 2)]
    [InlineData("push 20\npush 3\ndiv\npush 7\npush 4\nmod\nadd\npush 2\nudiv\npush 2\numod\nreturn", 3, 1)]
    [InlineData("push 1\npush 63\nshl\npush 65\nshr\npush 2\nlshr\nnot\npush 15\nand\npush 2\nor\npush 3\nxor\nreturn", 4, 1)]
    [InlineData("push 1\nneg\npush 1\nlt\npush 1\nle\npush 0\ngt\npush 1\nge\npush 1\neq\npush 0\nneq\nreturn", 3, 1)]
    [InlineData("push 1\nneg\npush 1\nugt\npush 2\nult\npush 1\nule\npush 1\nuge\nreturn", 2, 2)]
    [InlineData("push 1\npush 2\npush 3\nrot\nswap\nover\nnip\ndup\npop\npick 1\nroll 2\ndrop 1\nadd\nadd\nreturn", 3, 1)]
    [InlineData("push 1\npush 2\npush 3\npush 4\npush 5\npush 6\n2rot\n2swap\n2dup\n2over\nclear\nnull\nreturn", 4, 2)]
    [InlineData("push 18\npush 1\npush 56\nshl\npush16 7\npick16 2\nroll16 1\ndrop16 2\nadd\nreturn", 2, 1)]
    [InlineData("push 1\npush 0\ndiv\nreturn", 3, 2)]
    [InlineData("push 1\npush 0\nmod\nreturn", 2, 1)]
    [InlineData("push 1\npush 0\nudiv\nreturn", 3, 1)]
    [InlineData("push 1\npush 0\numod\nreturn", 3, 1)]
    [InlineData("push 1\npush 63\nshl\npush 1\nneg\ndiv\nreturn", 3, 1)]
    [InlineData("push 1\npush 63\nshl\npush 1\nneg\nmod\nreturn", 3, 1)]
    [InlineData("loop\nnop\nbreak\nend\npush 42\nreturn", 2, 2)]
    [InlineData("push 3\nloop\ndec\ndup\nif\ncontinue\nend\nbreak\nend\nreturn", 1, 2)]
    [InlineData("push 3\ndup\nwhile\ndec\ndup\nend\nreturn", 2, 2)]
    [InlineData("push 0\nif\npush 7\nelse\npush 42\nend\nreturn", 1, 1)]
    [InlineData("push 1\nif\npush 42\nelse\npush 7\nend\nreturn", 2, 2)]
    [InlineData("block\npush 42\nend\nreturn", 1, 1)]
    [InlineData("loop\nloop\nbreak\nend\nbreak\nend\npush 42\nreturn", 2, 2)]
    [InlineData("push 0\nwhile\nnop\npush 0\nend\npush 42\nreturn", 3, 1)]
    public void NativeUbytecSchedulerMatchesManagedLedger(string body, int quantum, int contexts)
    {
        byte[] image = Image(body);
        var expected = PortableTemporalScalarReference.Run(image,
            Enumerable.Repeat(0U, contexts).ToArray(), quantum: quantum);
        byte[] code = PortableModuleFormat.Decode(image).Sections.Single(s => s.Kind == 0x0016).Payload.ToArray();
        var result = RunNative(image, contexts, quantum, 128, module: true);
        Assert.Equal(RunNative(code, contexts, quantum, 128), result);
        Assert.Equal(contexts + expected.Trace.Count, result.Length / 9);
        for (int i = 0; i < contexts; i++)
            Assert.Equal(new ulong[] { 0, 0, (ulong)i + 1, (ulong)i + 1, (ulong)i + 1, 7, 0, uint.MaxValue, (ulong)i + 1 },
                result.Skip(i * 9).Take(9).ToArray());
        for (int i = 0; i < expected.Trace.Count; i++)
        {
            var e = expected.Trace[i];
            Assert.Equal(new ulong[] { e.Round, e.Event.Id.Context.Ordinal, e.Event.Id.Sequence, e.Event.LogicalTime,
                e.Event.CommitSequence, (ulong)e.Kind, e.Fuel, e.Occurrence?.InstructionOffset ?? uint.MaxValue,
                e.Kind == PortableScalarBoundaryKind.Return ? e.Result ?? 0 : 0 },
                result.Skip((contexts + i) * 9).Take(9).ToArray());
        }
    }

    [Fact]
    public void NativeUbytecSchedulerRejectsTruncatedUnsupportedAndExhaustedGuest()
    {
        Assert.Empty(RunNative([0x11, 8, 1], 1, 2, 16));
        Assert.Empty(RunNative([0x62], 1, 2, 16));
        Assert.Empty(RunNative([0x01, 0x01, 0x00], 1, 1, 2));
    }

    [Fact]
    public void ModuleAdmissionRejectsMalformedFramingAndUnsupportedCodeBeforePublishing()
    {
        byte[] valid = Image("push 20\npush 22\nadd\nreturn");
        void Reject(byte[] image) => Assert.Empty(RunNative(image, 1, 2, 32, module: true, untouched: true));
        Reject(valid[..^1]);
        Reject([0x55, 0x42, 0x43, 0x4d]);
        Reject([.. valid, 0]);
        byte[] changed = valid.ToArray();
        changed[0] = 0; Reject(changed);
        changed = valid.ToArray();
        BinaryPrimitives.WriteUInt32LittleEndian(changed.AsSpan(8), 33); Reject(changed);
        changed = valid.ToArray();
        BinaryPrimitives.WriteUInt64LittleEndian(changed.AsSpan(16), ulong.MaxValue); Reject(changed);
        changed = valid.ToArray();
        changed[Find(changed, 0x0018) + 4] = 0; Reject(changed); // wrong profile
        changed = valid.ToArray();
        changed[Find(changed, 0x0012) + 16] = 1; Reject(changed); // nonzero CodeOffset
        changed = valid.ToArray();
        changed[Find(changed, 0x0016)] = 0x62; Reject(changed); // unsupported opcode
        changed = valid.ToArray();
        changed[Find(changed, 0x0016) + 1] = 0xff; Reject(changed); // invalid immediate length
        Reject(Image("block checked () -> t_int16\npush 1\nend\nreturn")); // typed BLOCK still outside this slice

        static int Find(byte[] image, ushort kind)
        {
            int cursor = 12;
            while (cursor < image.Length)
            {
                if (BinaryPrimitives.ReadUInt16LittleEndian(image.AsSpan(cursor)) == kind) return cursor + 12;
                cursor += checked(12 + (int)BinaryPrimitives.ReadUInt64LittleEndian(image.AsSpan(cursor + 4)));
            }
            throw new InvalidDataException();
        }
    }

    [Fact]
    public void StructuredAdmissionRejectsBadScopesTransfersAndStackJoins()
    {
        // Raw Code is now independently planned as well. No event can be
        // published for a malformed scope or inconsistent reachable join.
        byte[][] invalid =
        [
            [0x06],                                  // unmatched END
            [0x03, 0x00],                            // unterminated LOOP
            [0x05, 0x00],                            // ELSE outside IF
            [0x07, 0, 0, 0, 0, 0x00],              // BREAK outside LOOP
            [0x03, 0x08, 1, 0, 0, 0, 0x06],        // missing outer target
            [0x11, 1, 1, 0x04, 0x11, 1, 2, 0x06, 0x00], // IF join differs
            [0x03, 0x11, 1, 1, 0x06],               // LOOP grows stack
            [0x03, 0x11, 1, 1, 0x07, 0, 0, 0, 0, 0x06, 0x00], // BREAK wrong depth
            [0x11, 1, 1, 0x04, 0x05, 0x05, 0x06, 0x00] // duplicate ELSE
        ];
        foreach (byte[] code in invalid)
            Assert.Empty(RunNative(code, 1, 2, 32, untouched: true));
        // A valid infinite loop is admitted, but is subject to event limits.
        Assert.Empty(RunNative([0x03, 0x01, 0x06], 2, 2, 8));
    }

    [Fact]
    public void ModuleSectionPolicyIsIndependentOfScheduler()
    {
        byte[] image = Image("push 42\nreturn");
        ulong[] expected = RunNative(image, 1, 2, 32, module: true);
        Assert.NotEmpty(expected);
        // Unknown optional section after the last indexed section: no semantic effect.
        Assert.Equal(expected, RunNative(AppendSection(image, 0x8000, 0, [1, 2, 3]), 1, 2, 32, module: true));
        // Critical unknown, reserved flags and duplicate/out-of-order known section.
        Reject(AppendSection(image, 0x8000, 1, []));
        Reject(AppendSection(image, 0x8000, 2, []));
        Reject(AppendSection(image, 0x0018, 1, []));
        // Every required indexed section is checked, independently of its content.
        foreach (ushort kind in new ushort[] { 1, 16, 17, 18, 19, 20, 21, 22, 24 })
            Reject(RemoveSection(image, kind));

        void Reject(byte[] bytes) =>
            Assert.Empty(RunNative(bytes, 1, 2, 32, module: true, untouched: true));

        static byte[] AppendSection(byte[] bytes, ushort kind, ushort flags, byte[] payload)
        {
            byte[] result = new byte[checked(bytes.Length + 12 + payload.Length)];
            bytes.CopyTo(result, 0);
            BinaryPrimitives.WriteUInt32LittleEndian(result.AsSpan(8),
                BinaryPrimitives.ReadUInt32LittleEndian(bytes.AsSpan(8)) + 1);
            BinaryPrimitives.WriteUInt16LittleEndian(result.AsSpan(bytes.Length), kind);
            BinaryPrimitives.WriteUInt16LittleEndian(result.AsSpan(bytes.Length + 2), flags);
            BinaryPrimitives.WriteUInt64LittleEndian(result.AsSpan(bytes.Length + 4), (ulong)payload.Length);
            payload.CopyTo(result, bytes.Length + 12);
            return result;
        }

        static byte[] RemoveSection(byte[] bytes, ushort kind)
        {
            int offset = 12;
            while (offset < bytes.Length)
            {
                int extent = checked(12 + (int)BinaryPrimitives.ReadUInt64LittleEndian(bytes.AsSpan(offset + 4)));
                if (BinaryPrimitives.ReadUInt16LittleEndian(bytes.AsSpan(offset)) == kind)
                {
                    byte[] result = [.. bytes[..offset], .. bytes[(offset + extent)..]];
                    BinaryPrimitives.WriteUInt32LittleEndian(result.AsSpan(8),
                        BinaryPrimitives.ReadUInt32LittleEndian(bytes.AsSpan(8)) - 1);
                    return result;
                }
                offset += extent;
            }
            throw new InvalidDataException("Expected required section.");
        }
    }

    [Fact]
    public void StackWindowContractsRejectUnderflowAndCapacityBeforePublishing()
    {
        // Each test is raw Code, not a C# pre-verified image.
        byte[][] invalid =
        [
            [0x12, 0x00],                            // POP with empty stack
            [0x11, 1, 1, 0x15, 0x00],               // ROT needs three cells
            [0x11, 1, 1, 0x1d, 1, 0x00],            // PICK index outside stack
            [0x11, 1, 1, 0xff, 0x10, 0x18, 0xff, 0xff, 0x00], // DROP16 max index
            [0x11, 1, 1, 0xff, 0x10, 0x11, 7, 0, 0x00],       // PUSH16 word crosses absent cell
            [0x11, 1, 1, 0x20, 0x00],               // binary op needs two cells
            [.. Enumerable.Repeat((byte)0x0f, 33), 0x00]       // capacity is 32 cells
        ];
        foreach (byte[] code in invalid)
            Assert.Empty(RunNative(code, 1, 2, 32, untouched: true));
    }

    private static ulong[] RunNative(byte[] code, int contexts, int quantum, int limit, bool module = false, bool untouched = false)
    {
        const int capacity = 32;
        var native = NativeRuntime.Value;
        nint input = Marshal.AllocHGlobal(code.Length);
        nint states = Marshal.AllocHGlobal(contexts * 64);
        nint stacks = Marshal.AllocHGlobal(contexts * capacity * 8);
        nint ledger = Marshal.AllocHGlobal(limit * 72);
        nint view = Marshal.AllocHGlobal(16);
        nint plan = Marshal.AllocHGlobal(Math.Max(1, Math.Min(code.Length, 4096)) * 72);
        try
        {
            Marshal.Copy(code, 0, input, code.Length);
            byte[] sentinel = Enumerable.Repeat((byte)0xA5, limit * 72).ToArray();
            Marshal.Copy(sentinel, 0, ledger, sentinel.Length);
            string[] args = [Address(input), code.Length.ToString(), Address(states), Address(stacks),
                contexts.ToString(), capacity.ToString(), quantum.ToString(), Address(ledger), limit.ToString(), Address(plan)];
            if (module) args = [.. args, Address(view)];
            string body = string.Join("\n", args.Select(arg => $"mov rax, {arg}\npush rax")) +
                $"\ncall {native.GetFunctionLabel(module ? 3 : 1)}\nadd rsp, {args.Length * 8}\npush rax";
            long count = Assert.Single(NativeStack.Run(body, 1, native.Assembly));
            Assert.InRange(count, 0, limit);
            if (untouched)
            {
                byte[] actual = new byte[sentinel.Length];
                Marshal.Copy(ledger, actual, 0, actual.Length);
                Assert.Equal(sentinel, actual);
            }
            var values = new long[checked((int)count * 9)];
            Marshal.Copy(ledger, values, 0, values.Length);
            return values.Select(x => unchecked((ulong)x)).ToArray();
        }
        finally
        {
            Marshal.FreeHGlobal(input); Marshal.FreeHGlobal(states);
            Marshal.FreeHGlobal(stacks); Marshal.FreeHGlobal(ledger); Marshal.FreeHGlobal(view); Marshal.FreeHGlobal(plan);
        }
    }

    private static readonly Lazy<PortableX64Compilation> NativeRuntime = new(() =>
    {
        string source = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "temporal-runtime.ubc"));
        var compiled = SourceCompiler.Compile(source, emitProcessEntryPoint: false);
        byte[] runtime = PortableModuleFormat.Encode(compiled.Module,
            contractManifest: null, includeIndexedExecutable: true, portableContracts: compiled.PortableContracts,
            executionProfile: PortableExecutionProfile.UnsafeCells);
        return PortableX64Backend.Compile(runtime);
    });

    [Theory]
    [InlineData("push 1\npush 2\n2dup\nreturn", 2)]
    [InlineData("push 1\npush 2\npush 3\npush 4\n2swap\nreturn", 2)]
    [InlineData("push 1\npush 2\npush 3\npush 4\npush 5\npush 6\n2rot\nreturn", 2)]
    [InlineData("push 1\npush 2\npush 3\npush 4\n2over\nreturn", 2)]
    [InlineData("push 18\npush 1\npush 56\nshl\npush16 7\nreturn", 4609)]
    [InlineData("push 1\npush 2\npush 3\nroll16 2\nreturn", 1)]
    [InlineData("push 1\npush 2\npush 3\ndrop16 1\nadd\nreturn", 4)]
    public void ExplicitStackVectorsMatchBothReferences(string body, long expected)
    {
        byte[] image = Image(body);
        var managed = PortableTemporalScalarReference.Run(image, [0], quantum: 2);
        Assert.Equal((ulong)expected, Assert.Single(managed.Results));
        ulong[] rows = RunNative(image, 1, 2, 128, module: true);
        Assert.NotEmpty(rows);
        Assert.Equal((ulong)expected, rows[^10]); // result in penultimate row (RETURN)
        var native = PortableX64Backend.Compile(image);
        Assert.Equal(expected, Assert.Single(NativeStack.Run($"call {native.GetFunctionLabel(0)}\npush rax", 1, native.Assembly)));
    }

    private static string Address(nint address) => $"0x{unchecked((ulong)(nuint)address):X16}";
}
