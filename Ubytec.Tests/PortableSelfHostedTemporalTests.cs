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
        Assert.Empty(RunNative([0x21], 1, 2, 16));
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
        changed[Find(changed, 0x0016)] = 0x21; Reject(changed); // unsupported opcode
        changed = valid.ToArray();
        changed[Find(changed, 0x0016) + 1] = 0xff; Reject(changed); // invalid immediate length
        Reject(Image("push 3\npush 2\nsub\nreturn"));

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

    private static ulong[] RunNative(byte[] code, int contexts, int quantum, int limit, bool module = false, bool untouched = false)
    {
        const int capacity = 32;
        string source = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "temporal-runtime.ubc"));
        var compiled = SourceCompiler.Compile(source, emitProcessEntryPoint: false);
        byte[] runtime = PortableModuleFormat.Encode(compiled.Module,
            contractManifest: null, includeIndexedExecutable: true, portableContracts: compiled.PortableContracts,
            executionProfile: PortableExecutionProfile.UnsafeCells);
        var native = PortableX64Backend.Compile(runtime);
        nint input = Marshal.AllocHGlobal(code.Length);
        nint states = Marshal.AllocHGlobal(contexts * 64);
        nint stacks = Marshal.AllocHGlobal(contexts * capacity * 8);
        nint ledger = Marshal.AllocHGlobal(limit * 72);
        nint view = Marshal.AllocHGlobal(16);
        try
        {
            Marshal.Copy(code, 0, input, code.Length);
            byte[] sentinel = Enumerable.Repeat((byte)0xA5, limit * 72).ToArray();
            Marshal.Copy(sentinel, 0, ledger, sentinel.Length);
            string[] args = [Address(input), code.Length.ToString(), Address(states), Address(stacks),
                contexts.ToString(), capacity.ToString(), quantum.ToString(), Address(ledger), limit.ToString()];
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
            Marshal.FreeHGlobal(stacks); Marshal.FreeHGlobal(ledger); Marshal.FreeHGlobal(view);
        }
    }

    private static string Address(nint address) => $"0x{unchecked((ulong)(nuint)address):X16}";
}
