using System.Buffers.Binary;

namespace Ubytec.Language.Portable;

/// <summary>Explicitly declared execution restrictions, not authority grants.</summary>
public enum PortableExecutionProfile : uint
{
    UnsafeCells = 0,
    DirectOnly = 1,
    CallableLocal = 2
}

/// <summary>Canonical lexical declaration topology; independent of source/AST and native labels.</summary>
public sealed class PortableContextTable
{
    public const uint NoIndex = uint.MaxValue;
    // Context v3 introduces explicit contracted BLOCKs and their BREAK targets.
    public const uint WireVersion = 3;
    private readonly uint[] parents;
    private readonly int[] subtreeEnds;

    public PortableExecutionProfile Profile { get; }
    public IReadOnlyList<uint> ParentFunctionIndices { get; }

    public PortableContextTable(PortableExecutionProfile profile, IReadOnlyList<uint> parentFunctionIndices)
    {
        ArgumentNullException.ThrowIfNull(parentFunctionIndices);
        if (profile is not (PortableExecutionProfile.UnsafeCells or PortableExecutionProfile.DirectOnly or PortableExecutionProfile.CallableLocal))
            throw new InvalidDataException("Unknown contextual execution profile.");
        Profile = profile;
        parents = parentFunctionIndices.ToArray();
        ParentFunctionIndices = Array.AsReadOnly(parents);
        subtreeEnds = new int[parents.Length];
        var active = new Stack<int>();

        for (int index = 0; index < parents.Length; index++)
        {
            uint parent = parents[index];
            if (parent != NoIndex && parent >= (uint)index)
                throw new InvalidDataException("Context parent must precede its child.");

            while (active.Count != 0 && (uint)active.Peek() != parent)
                subtreeEnds[active.Pop()] = index;

            if (parent != NoIndex && active.Count == 0)
                throw new InvalidDataException("Context table reopens a closed subtree.");

            active.Push(index);
        }

        while (active.Count != 0)
            subtreeEnds[active.Pop()] = parents.Length;
    }

    public byte[] Encode()
    {
        byte[] bytes = new byte[checked(12 + 4 * parents.Length)];
        BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(0, 4), WireVersion);
        BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(4, 4), (uint)Profile);
        BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(8, 4), (uint)parents.Length);
        for (int i = 0; i < parents.Length; i++)
            BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(12 + i * 4, 4), parents[i]);
        return bytes;
    }

    // Raw wire parser: no dependency on the semantic frontend, AST or typed decoder.
    public static PortableContextTable Decode(ReadOnlySpan<byte> bytes, int functionCount)
    {
        if (functionCount < 0 || bytes.Length < 12 ||
            BinaryPrimitives.ReadUInt32LittleEndian(bytes[..4]) != WireVersion)
            throw new InvalidDataException("Invalid function context table header/version.");
        uint count = BinaryPrimitives.ReadUInt32LittleEndian(bytes.Slice(8, 4));
        if (count != (uint)functionCount || bytes.Length != 12L + 4L * count)
            throw new InvalidDataException("Context table must match the function count exactly.");
        var profile = (PortableExecutionProfile)BinaryPrimitives.ReadUInt32LittleEndian(bytes.Slice(4, 4));
        uint[] parents = new uint[functionCount];
        for (int i = 0; i < parents.Length; i++)
            parents[i] = BinaryPrimitives.ReadUInt32LittleEndian(bytes.Slice(12 + 4 * i, 4));
        return new PortableContextTable(profile, parents);
    }

    public void RequireVisible(int caller, uint target)
    {
        if (caller < 0 || caller >= parents.Length || target >= (uint)parents.Length)
            throw new InvalidDataException("Context reference is outside the function table.");
        uint parent = parents[(int)target];
        if (parent != NoIndex && (caller < (int)parent || caller >= subtreeEnds[(int)parent]))
            throw new InvalidDataException($"FunctionIndex {caller} cannot reference FunctionIndex {target} from its lexical context.");
    }

    public void RequireTopLevel(uint function, string boundary)
    {
        if (function >= (uint)parents.Length || parents[(int)function] != NoIndex)
            throw new InvalidDataException($"{boundary} must reference a top-level function.");
    }

    internal bool DirectOnly => Profile == PortableExecutionProfile.DirectOnly;
    internal bool Restricted => Profile != PortableExecutionProfile.UnsafeCells;

    internal void RequireNoImports(int count)
    {
        if (Restricted && count != 0)
            throw new InvalidDataException("Restricted profile forbids imports.");
    }

    internal void RequireValueExport(PortablePassingMode mode)
    {
        if (Restricted && mode != PortablePassingMode.Value)
            throw new InvalidDataException("Restricted profile forbids loan exports.");
    }

    internal void RejectIndirect()
    {
        if (Restricted)
            throw new InvalidDataException("Restricted profile forbids FNADDR and CALLI.");
    }

    internal void RequireNamedMemory(byte mode)
    {
        if (Restricted && mode != 2)
            throw new InvalidDataException("Restricted profile forbids raw memory access.");
    }

    // The structural and raw verifier both invoke this closed opcode policy only
    // for the operand-free default branch, after handling explicit wire forms.
    internal void RequireAllowedOperandFree(byte opcode)
    {
        if (!Restricted) return;
        if (opcode is >= 0x20 and <= 0x2A or >= 0x30 and <= 0x36 or >= 0x40 and <= 0x49)
            return;
        if (opcode is
            Ubytec.Language.Operations.CoreOperations.NOP.OP or
            Ubytec.Language.Operations.CoreOperations.TRAP.OP or
            Ubytec.Language.Operations.CoreOperations.CLEAR.OP or
            Ubytec.Language.Operations.CoreOperations.NULL.OP or
            Ubytec.Language.Operations.CoreOperations.DEFAULT.OP or
            Ubytec.Language.Operations.StackOperations.POP.OP or
            Ubytec.Language.Operations.StackOperations.DUP.OP or
            Ubytec.Language.Operations.StackOperations.SWAP.OP or
            Ubytec.Language.Operations.StackOperations.ROT.OP or
            Ubytec.Language.Operations.StackOperations.OVER.OP or
            Ubytec.Language.Operations.StackOperations.NIP.OP or
            Ubytec.Language.Operations.StackOperations.TwoDUP.OP or
            Ubytec.Language.Operations.StackOperations.TwoSWAP.OP or
            Ubytec.Language.Operations.StackOperations.TwoROT.OP or
            Ubytec.Language.Operations.StackOperations.TwoOVER.OP)
            return;
        throw new InvalidDataException($"Restricted profile forbids opcode 0x{opcode:X2}.");
    }
}
