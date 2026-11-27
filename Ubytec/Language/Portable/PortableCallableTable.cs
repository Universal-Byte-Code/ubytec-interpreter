using System.Buffers.Binary;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Portable;

/// <summary>Exact ordered scalar signature, with no callable value or runtime address.</summary>
public sealed class PortableCallableSignature
{
    public uint ReturnTypeIndex { get; }
    public IReadOnlyList<uint> ArgumentTypeIndices { get; }

    public PortableCallableSignature(uint returnTypeIndex, IReadOnlyList<uint> argumentTypeIndices)
    {
        ArgumentNullException.ThrowIfNull(argumentTypeIndices);
        ReturnTypeIndex = returnTypeIndex;
        ArgumentTypeIndices = Array.AsReadOnly(argumentTypeIndices.ToArray());
    }

    internal bool Matches(uint result, IReadOnlyList<uint> arguments) =>
        ReturnTypeIndex == result && ArgumentTypeIndices.SequenceEqual(arguments);
}

/// <summary>Immutable declaration of banks; does not contain initialized capabilities.</summary>
public sealed class PortableCallableTable
{
    public const int MaxSlotsPerFunction = 4096;
    public const int MaxTotalSlots = 65536;
    public const int MaxSignatureArguments = 1024;
    public IReadOnlyList<IReadOnlyList<PortableCallableSignature>> Banks { get; }

    public PortableCallableTable(IReadOnlyList<IReadOnlyList<PortableCallableSignature>> banks)
    {
        ArgumentNullException.ThrowIfNull(banks);
        int total = 0;
        var copy = new List<IReadOnlyList<PortableCallableSignature>>(banks.Count);
        foreach (IReadOnlyList<PortableCallableSignature> bank in banks)
        {
            if (bank.Count > MaxSlotsPerFunction || (total += bank.Count) > MaxTotalSlots)
                throw new InvalidDataException("Callable slot limit exceeded.");
            if (bank.Any(sig => sig is null || sig.ArgumentTypeIndices.Count > MaxSignatureArguments))
                throw new InvalidDataException("Invalid callable signature or argument limit exceeded.");
            copy.Add(Array.AsReadOnly(bank.ToArray()));
        }
        Banks = copy.AsReadOnly();
    }

    public PortableCallableSignature Get(int function, uint slot)
    {
        if (function < 0 || function >= Banks.Count || slot >= (uint)Banks[function].Count)
            throw new InvalidDataException("CallableSlotIndex is outside the current activation bank.");
        return Banks[function][(int)slot];
    }

    public byte[] Encode()
    {
        using var output = new MemoryStream();
        Write(output, 0);
        Write(output, (uint)Banks.Count);
        foreach (var bank in Banks)
        {
            Write(output, (uint)bank.Count);
            foreach (var signature in bank)
            {
                Write(output, signature.ReturnTypeIndex);
                Write(output, (uint)signature.ArgumentTypeIndices.Count);
                foreach (uint argument in signature.ArgumentTypeIndices)
                    Write(output, argument);
            }
        }
        return output.ToArray();
    }

    private static void Write(Stream stream, uint value)
    {
        Span<byte> data = stackalloc byte[4];
        BinaryPrimitives.WriteUInt32LittleEndian(data, value);
        stream.Write(data);
    }

    private static uint Read(ref ReadOnlySpan<byte> data)
    {
        if (data.Length < 4) throw new InvalidDataException("Truncated callable slot table.");
        uint value = BinaryPrimitives.ReadUInt32LittleEndian(data);
        data = data[4..];
        return value;
    }

    internal static PortableCallableTable? ReadSection(
        PortableContextTable contexts, ReadOnlyMemory<byte>? payload, int functionCount,
        Func<uint, bool, bool> validType)
    {
        if (contexts.Profile != PortableExecutionProfile.CallableLocal)
        {
            if (payload.HasValue)
                throw new InvalidDataException("Callable slot section requires CallableLocal profile.");
            return null;
        }
        if (!payload.HasValue)
            throw new InvalidDataException("CallableLocal requires the critical callable slot section.");
        ReadOnlySpan<byte> data = payload.Value.Span;
        if (Read(ref data) != 0 || Read(ref data) != (uint)functionCount)
            throw new InvalidDataException("Invalid callable slot version or function count.");
        if (functionCount < 0 || functionCount > data.Length / 4)
            throw new InvalidDataException("Callable slot function count exceeds payload.");
        var banks = new List<IReadOnlyList<PortableCallableSignature>>(functionCount);
        int total = 0;
        for (int f = 0; f < functionCount; f++)
        {
            uint count = Read(ref data);
            if (count > MaxSlotsPerFunction || count > data.Length / 8 || (total += (int)count) > MaxTotalSlots)
                throw new InvalidDataException("Callable slot count exceeds limit or payload.");
            var bank = new PortableCallableSignature[(int)count];
            for (int s = 0; s < bank.Length; s++)
            {
                uint result = Read(ref data);
                uint argc = Read(ref data);
                if (!validType(result, true) || argc > MaxSignatureArguments || argc > data.Length / 4)
                    throw new InvalidDataException("Invalid callable return type or argument count.");
                uint[] arguments = new uint[(int)argc];
                for (int i = 0; i < arguments.Length; i++)
                {
                    arguments[i] = Read(ref data);
                    if (!validType(arguments[i], false))
                        throw new InvalidDataException("Invalid callable argument TypeIndex.");
                }
                bank[s] = new PortableCallableSignature(result, arguments);
            }
            banks.Add(bank);
        }
        if (!data.IsEmpty) throw new InvalidDataException("Callable slot table contains trailing bytes.");
        return new PortableCallableTable(banks);
    }

    internal static bool IsScalarSignatureType(PrimitiveType primitive, uint modifiers, ulong extent, bool result) =>
        extent == 1 && (primitive == PrimitiveType.Void
            ? result && modifiers == 0
            : (modifiers & ~(uint)(TypeModifiers.ReadOnly | TypeModifiers.Const)) == 0 &&
              primitive is PrimitiveType.Bool or PrimitiveType.Char8 or PrimitiveType.Char16 or
                  PrimitiveType.Byte or PrimitiveType.SByte or PrimitiveType.Int16 or PrimitiveType.UInt16 or
                  PrimitiveType.Int32 or PrimitiveType.UInt32 or PrimitiveType.Int64 or PrimitiveType.UInt64);

    internal PortableCallableSignature VerifyOperation(
        PortableContextTable contexts, int caller, byte operation, uint slot, uint? second,
        Func<uint, PortableCallableSignature> targetSignature)
    {
        if (contexts.Profile != PortableExecutionProfile.CallableLocal)
            throw new InvalidDataException("Callable opcode requires CallableLocal profile.");
        PortableCallableSignature signature = Get(caller, slot);
        switch (operation)
        {
            case 0:
                if (second is not uint target)
                    throw new InvalidDataException("CAP_BIND requires a target.");
                contexts.RequireVisible(caller, target);
                PortableCallableSignature actual = targetSignature(target);
                if (!signature.Matches(actual.ReturnTypeIndex, actual.ArgumentTypeIndices))
                    throw new InvalidDataException("CAP_BIND signature mismatch.");
                break;
            case 1:
                if (second is not uint source)
                    throw new InvalidDataException("CAP_COPY requires a source.");
                PortableCallableSignature from = Get(caller, source);
                if (!signature.Matches(from.ReturnTypeIndex, from.ArgumentTypeIndices))
                    throw new InvalidDataException("CAP_COPY signature mismatch.");
                break;
            case 2:
            case 3:
                if (second.HasValue) throw new InvalidDataException("Unexpected callable operand.");
                break;
            default:
                throw new InvalidDataException("Unknown callable opcode.");
        }
        return signature;
    }
}
