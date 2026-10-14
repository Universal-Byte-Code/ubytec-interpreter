using System.Buffers.Binary;
using System.Text;
using Ubytec.Language.Operations;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Portable;

/// <summary>
/// Fully decoded Portable Module Format image. Container-only sections are retained verbatim while
/// the indexed executable profile, when present, is represented as typed binary data.
/// </summary>
public sealed record PortableBinaryModule(
    ushort MajorVersion,
    ushort MinorVersion,
    IReadOnlyList<PortableModuleSection> ContainerSections,
    PortableExecutableModule? Executable);

/// <summary>Typed architecture-neutral indexed executable module.</summary>
public sealed record PortableExecutableModule(
    IReadOnlyList<string> Strings,
    IReadOnlyList<PortableExecutableType> Types,
    IReadOnlyList<PortableExecutableFunction> Functions,
    IReadOnlyList<PortableExecutableImport> Imports,
    IReadOnlyList<PortableExecutableExport> Exports,
    IReadOnlyList<byte[]> Constants);

/// <summary>One indexed type-table entry.</summary>
public sealed record PortableExecutableType(
    PrimitiveType Primitive,
    TypeModifiers Modifiers,
    ulong FixedArraySize,
    uint? NameStringIndex);

/// <summary>One indexed function and its decoded instruction stream.</summary>
public sealed record PortableExecutableFunction(
    uint ReturnTypeIndex,
    IReadOnlyList<uint> ArgumentTypeIndices,
    IReadOnlyList<uint> LocalTypeIndices,
    IReadOnlyList<PortableInstruction> Instructions);

/// <summary>One portable import authority slot.</summary>
public sealed record PortableExecutableImport(
    uint ModuleStringIndex,
    uint SymbolStringIndex,
    uint ReturnTypeIndex,
    IReadOnlyList<PortableBoundaryDescriptor> Arguments);

/// <summary>One portable export entry.</summary>
public sealed record PortableExecutableExport(
    uint SymbolStringIndex,
    uint FunctionIndex,
    uint ReturnTypeIndex,
    IReadOnlyList<PortableBoundaryDescriptor> Arguments);

/// <summary>One portable module-boundary parameter descriptor.</summary>
public sealed record PortableBoundaryDescriptor(
    PortablePassingMode PassingMode,
    uint TypeIndex);

/// <summary>Portable CALL target classes.</summary>
public enum PortableCallTargetKind : byte
{
    LocalFunction = 0,
    Import = 1
}

/// <summary>Portable raw/named memory addressing modes.</summary>
public enum PortableMemoryAccessMode : byte
{
    Address = 0,
    RawTyped = 1,
    Binding = 2
}

/// <summary>Base type for one decoded indexed executable instruction.</summary>
public abstract record PortableInstruction(byte OpCode);

/// <summary>An operand-free core opcode.</summary>
public sealed record PortableOperandFreeInstruction(byte Value) : PortableInstruction(Value);

/// <summary>RETURN, optionally carrying an explicit TypeIndex.</summary>
public sealed record PortableReturnInstruction(uint? TypeIndex) : PortableInstruction(RETURN.OP);

/// <summary>Portable local initialization.</summary>
public sealed record PortableVariableInstruction(uint BindingIndex, ulong InitialCell) : PortableInstruction(0x10);

/// <summary>PUSH with its canonical one-to-eight-byte immediate.</summary>
public sealed record PortablePushInstruction(byte[] Immediate) : PortableInstruction(StackOperations.PUSH.OP);

/// <summary>DROP/PICK/ROLL with their one-byte stack index.</summary>
public sealed record PortableStackIndexInstruction(byte StackOpCode, byte Index) : PortableInstruction(StackOpCode);

/// <summary>Direct local or imported call.</summary>
public sealed record PortableCallInstruction(PortableCallTargetKind TargetKind, uint TargetIndex)
    : PortableInstruction(FunctionOperations.CALL.OP);

/// <summary>Local function-address materialization.</summary>
public sealed record PortableFunctionAddressInstruction(uint FunctionIndex)
    : PortableInstruction(FunctionOperations.FNADDR.OP);

/// <summary>Indirect-call signature operands.</summary>
public sealed record PortableCallIndirectInstruction(byte ArgumentCount, PrimitiveType ReturnType)
    : PortableInstruction(FunctionOperations.CALLI.OP);

/// <summary>LOAD/STORE portable addressing operands.</summary>
public sealed record PortableMemoryInstruction(
    byte MemoryOpCode,
    PortableMemoryAccessMode Mode,
    PrimitiveType? RawType,
    uint? BindingIndex) : PortableInstruction(MemoryOpCode);

/// <summary>
/// Symmetric codec for canonical PMF v0. Decode produces a typed executable representation without
/// reconstructing source AST objects; Encode derives table framing and code offsets from that model.
/// For canonical input, Encode(Decode(bytes)) is byte-for-byte identical.
/// </summary>
public static class PortableBinaryCodec
{
    private static readonly byte[] Magic = "UBCM"u8.ToArray();
    private static readonly UTF8Encoding StrictUtf8 = new(false, true);
    private const int HeaderSize = 12;
    private const int SectionHeaderSize = 12;
    private const byte VariableOpcode = 0x10;

    /// <summary>Decodes and verifies a canonical PMF image into its typed binary representation.</summary>
    public static PortableBinaryModule Decode(ReadOnlySpan<byte> bytes)
    {
        PortableModuleImage image = PortableModuleFormat.Decode(bytes);
        PortableExecutableModule? executable = IndexedExecutableFormat.IsPresent(image)
            ? DecodeExecutable(image)
            : null;

        PortableModuleSection[] containerSections = image.Sections
            .Where(section => !IsIndexedExecutableKind(section.Kind))
            .Select(section => new PortableModuleSection(
                section.Kind,
                section.Flags,
                section.Payload.ToArray()))
            .ToArray();

        return new PortableBinaryModule(
            image.MajorVersion,
            image.MinorVersion,
            containerSections,
            executable);
    }

    /// <summary>Encodes a typed PMF model and verifies the resulting canonical image.</summary>
    public static byte[] Encode(PortableBinaryModule module)
    {
        ArgumentNullException.ThrowIfNull(module);
        ArgumentNullException.ThrowIfNull(module.ContainerSections);

        var sections = new List<PortableModuleSection>(module.ContainerSections.Count + 7);
        foreach (PortableModuleSection section in module.ContainerSections)
        {
            if (IsIndexedExecutableKind(section.Kind))
                throw new InvalidDataException("ContainerSections must not contain indexed executable sections.");
            sections.Add(new PortableModuleSection(section.Kind, section.Flags, section.Payload.ToArray()));
        }

        if (module.Executable is not null)
            sections.AddRange(EncodeExecutableSections(module.Executable));

        sections.Sort(static (left, right) => left.Kind.CompareTo(right.Kind));
        if (sections.Count == 0)
            throw new InvalidDataException("Portable module must contain at least one section.");

        long totalLength = HeaderSize;
        foreach (PortableModuleSection section in sections)
            totalLength = checked(totalLength + SectionHeaderSize + section.Payload.Length);
        if (totalLength > int.MaxValue)
            throw new InvalidDataException("Portable module is too large to encode.");

        byte[] output = new byte[checked((int)totalLength)];
        Magic.CopyTo(output, 0);
        BinaryPrimitives.WriteUInt16LittleEndian(output.AsSpan(4, 2), module.MajorVersion);
        BinaryPrimitives.WriteUInt16LittleEndian(output.AsSpan(6, 2), module.MinorVersion);
        BinaryPrimitives.WriteUInt32LittleEndian(output.AsSpan(8, 4), checked((uint)sections.Count));

        int offset = HeaderSize;
        foreach (PortableModuleSection section in sections)
        {
            BinaryPrimitives.WriteUInt16LittleEndian(output.AsSpan(offset, 2), section.Kind);
            BinaryPrimitives.WriteUInt16LittleEndian(output.AsSpan(offset + 2, 2), (ushort)section.Flags);
            BinaryPrimitives.WriteUInt64LittleEndian(
                output.AsSpan(offset + 4, 8),
                checked((ulong)section.Payload.Length));
            offset += SectionHeaderSize;
            section.Payload.Span.CopyTo(output.AsSpan(offset));
            offset += section.Payload.Length;
        }

        PortableModuleFormat.Verify(output);
        return output;
    }

    private static PortableExecutableModule DecodeExecutable(PortableModuleImage image)
    {
        List<string> strings = DecodeStringTable(Required(image, PortableModuleSectionKind.IndexedStringTable));
        List<PortableExecutableType> types = DecodeTypeTable(
            Required(image, PortableModuleSectionKind.IndexedTypeTable));
        List<FunctionWireEntry> functionEntries = DecodeFunctionTable(
            Required(image, PortableModuleSectionKind.IndexedFunctionTable));
        List<PortableExecutableImport> imports = DecodeImportTable(
            Required(image, PortableModuleSectionKind.IndexedImportTable));
        List<PortableExecutableExport> exports = DecodeExportTable(
            Required(image, PortableModuleSectionKind.IndexedExportTable));
        List<byte[]> constants = DecodeConstantTable(
            Required(image, PortableModuleSectionKind.IndexedConstantTable));
        ReadOnlySpan<byte> code = Required(image, PortableModuleSectionKind.IndexedCode).Span;

        var functions = new List<PortableExecutableFunction>(functionEntries.Count);
        foreach (FunctionWireEntry function in functionEntries)
        {
            ReadOnlySpan<byte> body = code.Slice(
                checked((int)function.CodeOffset),
                checked((int)function.CodeLength));
            functions.Add(new PortableExecutableFunction(
                function.ReturnTypeIndex,
                function.ArgumentTypeIndices,
                function.LocalTypeIndices,
                DecodeInstructions(body)));
        }

        return new PortableExecutableModule(strings, types, functions, imports, exports, constants);
    }

    private static IReadOnlyList<PortableModuleSection> EncodeExecutableSections(PortableExecutableModule executable)
    {
        ArgumentNullException.ThrowIfNull(executable);

        byte[] strings = EncodeStringTable(executable.Strings);
        byte[] types = EncodeTypeTable(executable.Types);
        byte[] imports = EncodeImportTable(executable.Imports);
        byte[] exports = EncodeExportTable(executable.Exports);
        byte[] constants = EncodeConstantTable(executable.Constants);

        using var code = new MemoryStream();
        var functionEncodings = new List<EncodedFunction>(executable.Functions.Count);
        foreach (PortableExecutableFunction function in executable.Functions)
        {
            uint codeOffset = checked((uint)code.Length);
            byte[] body = EncodeInstructions(function.Instructions);
            code.Write(body);
            functionEncodings.Add(new EncodedFunction(function, codeOffset, checked((uint)body.Length)));
        }
        byte[] functions = EncodeFunctionTable(functionEncodings);

        return
        [
            Critical(PortableModuleSectionKind.IndexedStringTable, strings),
            Critical(PortableModuleSectionKind.IndexedTypeTable, types),
            Critical(PortableModuleSectionKind.IndexedFunctionTable, functions),
            Critical(PortableModuleSectionKind.IndexedImportTable, imports),
            Critical(PortableModuleSectionKind.IndexedExportTable, exports),
            Critical(PortableModuleSectionKind.IndexedConstantTable, constants),
            Critical(PortableModuleSectionKind.IndexedCode, code.ToArray())
        ];
    }

    private static PortableModuleSection Critical(PortableModuleSectionKind kind, byte[] payload) =>
        new((ushort)kind, PortableModuleSectionFlags.Critical, payload);

    private static ReadOnlyMemory<byte> Required(PortableModuleImage image, PortableModuleSectionKind kind) =>
        image.GetRequiredSection(kind).Payload;

    private static bool IsIndexedExecutableKind(ushort kind) =>
        kind is >= (ushort)PortableModuleSectionKind.IndexedStringTable
            and <= (ushort)PortableModuleSectionKind.IndexedCode;

    private static List<string> DecodeStringTable(ReadOnlyMemory<byte> payload)
    {
        var reader = new Reader(payload.Span);
        uint count = reader.ReadUInt32();
        var result = new List<string>(checked((int)count));
        for (uint index = 0; index < count; index++)
        {
            int length = checked((int)reader.ReadUInt32());
            result.Add(StrictUtf8.GetString(reader.ReadBytes(length)));
        }
        reader.RequireEnd();
        return result;
    }

    private static List<PortableExecutableType> DecodeTypeTable(ReadOnlyMemory<byte> payload)
    {
        var reader = new Reader(payload.Span);
        uint count = reader.ReadUInt32();
        var result = new List<PortableExecutableType>(checked((int)count));
        for (uint index = 0; index < count; index++)
        {
            var primitive = (PrimitiveType)reader.ReadByte();
            var modifiers = (TypeModifiers)reader.ReadUInt32();
            ulong fixedArraySize = reader.ReadUInt64();
            uint rawNameIndex = reader.ReadUInt32();
            _ = reader.ReadUInt64();
            result.Add(new PortableExecutableType(
                primitive,
                modifiers,
                fixedArraySize,
                rawNameIndex == IndexedExecutableFormat.NoIndex ? null : rawNameIndex));
        }
        reader.RequireEnd();
        return result;
    }

    private static List<FunctionWireEntry> DecodeFunctionTable(ReadOnlyMemory<byte> payload)
    {
        var reader = new Reader(payload.Span);
        uint count = reader.ReadUInt32();
        var result = new List<FunctionWireEntry>(checked((int)count));
        for (uint index = 0; index < count; index++)
        {
            uint returnType = reader.ReadUInt32();
            int argumentCount = checked((int)reader.ReadUInt32());
            int localCount = checked((int)reader.ReadUInt32());
            uint codeOffset = reader.ReadUInt32();
            uint codeLength = reader.ReadUInt32();
            _ = reader.ReadUInt32();

            var arguments = new uint[argumentCount];
            var locals = new uint[localCount];
            for (int argument = 0; argument < arguments.Length; argument++)
                arguments[argument] = reader.ReadUInt32();
            for (int local = 0; local < locals.Length; local++)
                locals[local] = reader.ReadUInt32();

            result.Add(new FunctionWireEntry(returnType, codeOffset, codeLength, arguments, locals));
        }
        reader.RequireEnd();
        return result;
    }

    private static List<PortableExecutableImport> DecodeImportTable(ReadOnlyMemory<byte> payload)
    {
        var reader = new Reader(payload.Span);
        uint count = reader.ReadUInt32();
        var result = new List<PortableExecutableImport>(checked((int)count));
        for (uint index = 0; index < count; index++)
        {
            uint module = reader.ReadUInt32();
            uint symbol = reader.ReadUInt32();
            uint returnType = reader.ReadUInt32();
            int argumentCount = checked((int)reader.ReadUInt32());
            var arguments = new PortableBoundaryDescriptor[argumentCount];
            for (int argument = 0; argument < arguments.Length; argument++)
                arguments[argument] = DecodeBoundaryDescriptor(ref reader);
            result.Add(new PortableExecutableImport(module, symbol, returnType, arguments));
        }
        reader.RequireEnd();
        return result;
    }

    private static List<PortableExecutableExport> DecodeExportTable(ReadOnlyMemory<byte> payload)
    {
        var reader = new Reader(payload.Span);
        uint count = reader.ReadUInt32();
        var result = new List<PortableExecutableExport>(checked((int)count));
        for (uint index = 0; index < count; index++)
        {
            uint symbol = reader.ReadUInt32();
            uint function = reader.ReadUInt32();
            uint returnType = reader.ReadUInt32();
            int argumentCount = checked((int)reader.ReadUInt32());
            var arguments = new PortableBoundaryDescriptor[argumentCount];
            for (int argument = 0; argument < arguments.Length; argument++)
                arguments[argument] = DecodeBoundaryDescriptor(ref reader);
            result.Add(new PortableExecutableExport(symbol, function, returnType, arguments));
        }
        reader.RequireEnd();
        return result;
    }

    private static PortableBoundaryDescriptor DecodeBoundaryDescriptor(ref Reader reader) =>
        new((PortablePassingMode)reader.ReadByte(), reader.ReadUInt32());

    private static List<byte[]> DecodeConstantTable(ReadOnlyMemory<byte> payload)
    {
        var reader = new Reader(payload.Span);
        uint count = reader.ReadUInt32();
        var result = new List<byte[]>(checked((int)count));
        for (uint index = 0; index < count; index++)
        {
            int length = checked((int)reader.ReadUInt32());
            result.Add(reader.ReadBytes(length).ToArray());
        }
        reader.RequireEnd();
        return result;
    }

    private static List<PortableInstruction> DecodeInstructions(ReadOnlySpan<byte> body)
    {
        var reader = new Reader(body);
        var result = new List<PortableInstruction>();
        while (!reader.AtEnd)
        {
            byte opcode = reader.ReadByte();
            switch (opcode)
            {
                case 0xFF:
                    throw new NotSupportedException("Extended opcodes are not supported by indexed executable v0.");

                case RETURN.OP:
                {
                    byte mode = reader.ReadByte();
                    result.Add(new PortableReturnInstruction(mode == 0 ? null : reader.ReadUInt32()));
                    break;
                }

                case VariableOpcode:
                    result.Add(new PortableVariableInstruction(reader.ReadUInt32(), reader.ReadUInt64()));
                    break;

                case StackOperations.PUSH.OP:
                {
                    int length = reader.ReadByte();
                    result.Add(new PortablePushInstruction(reader.ReadBytes(length).ToArray()));
                    break;
                }

                case StackOperations.DROP.OP:
                case StackOperations.PICK.OP:
                case StackOperations.ROLL.OP:
                    result.Add(new PortableStackIndexInstruction(opcode, reader.ReadByte()));
                    break;

                case FunctionOperations.CALL.OP:
                    result.Add(new PortableCallInstruction(
                        (PortableCallTargetKind)reader.ReadByte(),
                        reader.ReadUInt32()));
                    break;

                case FunctionOperations.FNADDR.OP:
                    result.Add(new PortableFunctionAddressInstruction(reader.ReadUInt32()));
                    break;

                case FunctionOperations.CALLI.OP:
                    result.Add(new PortableCallIndirectInstruction(
                        reader.ReadByte(),
                        (PrimitiveType)reader.ReadByte()));
                    break;

                case MemoryOperations.LOAD.OP:
                case MemoryOperations.STORE.OP:
                    result.Add(DecodeMemoryInstruction(opcode, ref reader));
                    break;

                default:
                    result.Add(new PortableOperandFreeInstruction(opcode));
                    break;
            }
        }
        return result;
    }

    private static PortableMemoryInstruction DecodeMemoryInstruction(byte opcode, ref Reader reader)
    {
        var mode = (PortableMemoryAccessMode)reader.ReadByte();
        return mode switch
        {
            PortableMemoryAccessMode.Address => new PortableMemoryInstruction(opcode, mode, null, null),
            PortableMemoryAccessMode.RawTyped => new PortableMemoryInstruction(
                opcode, mode, (PrimitiveType)reader.ReadByte(), null),
            PortableMemoryAccessMode.Binding => new PortableMemoryInstruction(
                opcode, mode, null, reader.ReadUInt32()),
            _ => throw new InvalidDataException($"Unsupported portable memory mode {(byte)mode}.")
        };
    }

    private static byte[] EncodeStringTable(IReadOnlyList<string> strings)
    {
        using var stream = new MemoryStream();
        WriteUInt32(stream, checked((uint)strings.Count));
        foreach (string value in strings)
        {
            byte[] bytes = StrictUtf8.GetBytes(value);
            WriteUInt32(stream, checked((uint)bytes.Length));
            stream.Write(bytes);
        }
        return stream.ToArray();
    }

    private static byte[] EncodeTypeTable(IReadOnlyList<PortableExecutableType> types)
    {
        using var stream = new MemoryStream();
        WriteUInt32(stream, checked((uint)types.Count));
        foreach (PortableExecutableType type in types)
        {
            stream.WriteByte((byte)type.Primitive);
            WriteUInt32(stream, unchecked((uint)type.Modifiers));
            WriteUInt64(stream, type.FixedArraySize);
            WriteUInt32(stream, type.NameStringIndex ?? IndexedExecutableFormat.NoIndex);
            WriteUInt64(stream, 0);
        }
        return stream.ToArray();
    }

    private static byte[] EncodeFunctionTable(IReadOnlyList<EncodedFunction> functions)
    {
        using var stream = new MemoryStream();
        WriteUInt32(stream, checked((uint)functions.Count));
        foreach (EncodedFunction encoded in functions)
        {
            PortableExecutableFunction function = encoded.Function;
            WriteUInt32(stream, function.ReturnTypeIndex);
            WriteUInt32(stream, checked((uint)function.ArgumentTypeIndices.Count));
            WriteUInt32(stream, checked((uint)function.LocalTypeIndices.Count));
            WriteUInt32(stream, encoded.CodeOffset);
            WriteUInt32(stream, encoded.CodeLength);
            WriteUInt32(stream, 0);
            foreach (uint typeIndex in function.ArgumentTypeIndices)
                WriteUInt32(stream, typeIndex);
            foreach (uint typeIndex in function.LocalTypeIndices)
                WriteUInt32(stream, typeIndex);
        }
        return stream.ToArray();
    }

    private static byte[] EncodeImportTable(IReadOnlyList<PortableExecutableImport> imports)
    {
        using var stream = new MemoryStream();
        WriteUInt32(stream, checked((uint)imports.Count));
        foreach (PortableExecutableImport import in imports)
        {
            WriteUInt32(stream, import.ModuleStringIndex);
            WriteUInt32(stream, import.SymbolStringIndex);
            WriteUInt32(stream, import.ReturnTypeIndex);
            WriteUInt32(stream, checked((uint)import.Arguments.Count));
            foreach (PortableBoundaryDescriptor argument in import.Arguments)
                EncodeBoundaryDescriptor(stream, argument);
        }
        return stream.ToArray();
    }

    private static byte[] EncodeExportTable(IReadOnlyList<PortableExecutableExport> exports)
    {
        using var stream = new MemoryStream();
        WriteUInt32(stream, checked((uint)exports.Count));
        foreach (PortableExecutableExport export in exports)
        {
            WriteUInt32(stream, export.SymbolStringIndex);
            WriteUInt32(stream, export.FunctionIndex);
            WriteUInt32(stream, export.ReturnTypeIndex);
            WriteUInt32(stream, checked((uint)export.Arguments.Count));
            foreach (PortableBoundaryDescriptor argument in export.Arguments)
                EncodeBoundaryDescriptor(stream, argument);
        }
        return stream.ToArray();
    }

    private static void EncodeBoundaryDescriptor(Stream stream, PortableBoundaryDescriptor descriptor)
    {
        stream.WriteByte((byte)descriptor.PassingMode);
        WriteUInt32(stream, descriptor.TypeIndex);
    }

    private static byte[] EncodeConstantTable(IReadOnlyList<byte[]> constants)
    {
        using var stream = new MemoryStream();
        WriteUInt32(stream, checked((uint)constants.Count));
        foreach (byte[] constant in constants)
        {
            WriteUInt32(stream, checked((uint)constant.Length));
            stream.Write(constant);
        }
        return stream.ToArray();
    }

    private static byte[] EncodeInstructions(IReadOnlyList<PortableInstruction> instructions)
    {
        using var stream = new MemoryStream();
        foreach (PortableInstruction instruction in instructions)
        {
            switch (instruction)
            {
                case PortableOperandFreeInstruction operandFree:
                    stream.WriteByte(operandFree.OpCode);
                    break;

                case PortableReturnInstruction ret:
                    stream.WriteByte(RETURN.OP);
                    if (ret.TypeIndex is uint typeIndex)
                    {
                        stream.WriteByte(1);
                        WriteUInt32(stream, typeIndex);
                    }
                    else
                    {
                        stream.WriteByte(0);
                    }
                    break;

                case PortableVariableInstruction variable:
                    stream.WriteByte(VariableOpcode);
                    WriteUInt32(stream, variable.BindingIndex);
                    WriteUInt64(stream, variable.InitialCell);
                    break;

                case PortablePushInstruction push:
                    stream.WriteByte(StackOperations.PUSH.OP);
                    stream.WriteByte(checked((byte)push.Immediate.Length));
                    stream.Write(push.Immediate);
                    break;

                case PortableStackIndexInstruction stack:
                    stream.WriteByte(stack.StackOpCode);
                    stream.WriteByte(stack.Index);
                    break;

                case PortableCallInstruction call:
                    stream.WriteByte(FunctionOperations.CALL.OP);
                    stream.WriteByte((byte)call.TargetKind);
                    WriteUInt32(stream, call.TargetIndex);
                    break;

                case PortableFunctionAddressInstruction address:
                    stream.WriteByte(FunctionOperations.FNADDR.OP);
                    WriteUInt32(stream, address.FunctionIndex);
                    break;

                case PortableCallIndirectInstruction indirect:
                    stream.WriteByte(FunctionOperations.CALLI.OP);
                    stream.WriteByte(indirect.ArgumentCount);
                    stream.WriteByte((byte)indirect.ReturnType);
                    break;

                case PortableMemoryInstruction memory:
                    EncodeMemoryInstruction(stream, memory);
                    break;

                default:
                    throw new InvalidDataException(
                        $"Unsupported portable instruction model '{instruction.GetType().Name}'.");
            }
        }
        return stream.ToArray();
    }

    private static void EncodeMemoryInstruction(Stream stream, PortableMemoryInstruction memory)
    {
        stream.WriteByte(memory.MemoryOpCode);
        stream.WriteByte((byte)memory.Mode);
        switch (memory.Mode)
        {
            case PortableMemoryAccessMode.Address:
                if (memory.RawType is not null || memory.BindingIndex is not null)
                    throw new InvalidDataException("Address memory mode cannot carry additional operands.");
                break;
            case PortableMemoryAccessMode.RawTyped:
                if (memory.RawType is not PrimitiveType primitive || memory.BindingIndex is not null)
                    throw new InvalidDataException("RawTyped memory mode requires exactly one primitive type.");
                stream.WriteByte((byte)primitive);
                break;
            case PortableMemoryAccessMode.Binding:
                if (memory.BindingIndex is not uint binding || memory.RawType is not null)
                    throw new InvalidDataException("Binding memory mode requires exactly one BindingIndex.");
                WriteUInt32(stream, binding);
                break;
            default:
                throw new InvalidDataException($"Unsupported portable memory mode {(byte)memory.Mode}.");
        }
    }

    private static void WriteUInt32(Stream stream, uint value)
    {
        Span<byte> buffer = stackalloc byte[4];
        BinaryPrimitives.WriteUInt32LittleEndian(buffer, value);
        stream.Write(buffer);
    }

    private static void WriteUInt64(Stream stream, ulong value)
    {
        Span<byte> buffer = stackalloc byte[8];
        BinaryPrimitives.WriteUInt64LittleEndian(buffer, value);
        stream.Write(buffer);
    }

    private sealed record FunctionWireEntry(
        uint ReturnTypeIndex,
        uint CodeOffset,
        uint CodeLength,
        uint[] ArgumentTypeIndices,
        uint[] LocalTypeIndices);

    private sealed record EncodedFunction(
        PortableExecutableFunction Function,
        uint CodeOffset,
        uint CodeLength);

    private ref struct Reader(ReadOnlySpan<byte> data)
    {
        private readonly ReadOnlySpan<byte> _data = data;
        private int _offset;

        internal bool AtEnd => _offset == _data.Length;

        internal byte ReadByte()
        {
            Ensure(1);
            return _data[_offset++];
        }

        internal uint ReadUInt32()
        {
            Ensure(4);
            uint value = BinaryPrimitives.ReadUInt32LittleEndian(_data.Slice(_offset, 4));
            _offset += 4;
            return value;
        }

        internal ulong ReadUInt64()
        {
            Ensure(8);
            ulong value = BinaryPrimitives.ReadUInt64LittleEndian(_data.Slice(_offset, 8));
            _offset += 8;
            return value;
        }

        internal ReadOnlySpan<byte> ReadBytes(int length)
        {
            Ensure(length);
            ReadOnlySpan<byte> value = _data.Slice(_offset, length);
            _offset += length;
            return value;
        }

        internal void RequireEnd()
        {
            if (!AtEnd)
                throw new InvalidDataException("Portable binary table contains trailing bytes.");
        }

        private void Ensure(int length)
        {
            if (length < 0 || _offset > _data.Length - length)
                throw new InvalidDataException("Portable binary payload is truncated.");
        }
    }
}
