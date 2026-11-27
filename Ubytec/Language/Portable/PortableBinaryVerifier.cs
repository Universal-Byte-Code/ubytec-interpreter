using System.Buffers.Binary;
using System.Reflection;
using System.Text;
using System.Text.Json;
using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Extended;
using Ubytec.Language.Operations.Interfaces;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Portable;

/// <summary>
/// Independent raw-wire verifier for Portable Module Format v0.
/// This verifier deliberately does not call PortableModuleFormat.Decode,
/// IndexedExecutableFormat.Verify, or PortableBinaryCodec.Decode.
/// </summary>
public static class PortableBinaryVerifier
{
    private static ReadOnlySpan<byte> Magic => "UBCM"u8;
    private static readonly UTF8Encoding StrictUtf8 = new(false, true);
    private static readonly HashSet<byte> OperandFreeCoreOpcodes = DiscoverOperandFreeCoreOpcodes();

    private static readonly PortableModuleSectionKind[] IndexedKinds =
    [
        PortableModuleSectionKind.IndexedStringTable,
        PortableModuleSectionKind.IndexedTypeTable,
        PortableModuleSectionKind.IndexedFunctionTable,
        PortableModuleSectionKind.IndexedImportTable,
        PortableModuleSectionKind.IndexedExportTable,
        PortableModuleSectionKind.IndexedConstantTable,
        PortableModuleSectionKind.IndexedCode
    ];

    private const int HeaderSize = 12;
    private const int SectionHeaderSize = 12;
    private const ushort KnownSectionFlagMask = (ushort)PortableModuleSectionFlags.Critical;
    private const uint KnownTypeModifierMask = 0x0001FFFF;
    private const byte VarOpcode = 0x10;
    private const uint NoIndex = uint.MaxValue;

    /// <summary>Verifies one canonical PMF v0 image directly from its bytes.</summary>
    public static void Verify(ReadOnlySpan<byte> bytes)
    {
        if (bytes.Length > PortableModuleFormat.MaxModuleBytes)
            throw new InvalidDataException($"Portable module exceeds the {PortableModuleFormat.MaxModuleBytes}-byte runtime limit.");
        if (bytes.Length < HeaderSize)
            throw new InvalidDataException("Portable module header is truncated.");
        if (!bytes[..4].SequenceEqual(Magic))
            throw new InvalidDataException("Portable module magic must be ASCII 'UBCM'.");

        ushort major = BinaryPrimitives.ReadUInt16LittleEndian(bytes.Slice(4, 2));
        ushort minor = BinaryPrimitives.ReadUInt16LittleEndian(bytes.Slice(6, 2));
        if (major != PortableModuleFormat.CurrentMajorVersion || minor != PortableModuleFormat.CurrentMinorVersion)
            throw new InvalidDataException($"Unsupported portable module version {major}.{minor}.");

        uint sectionCount = BinaryPrimitives.ReadUInt32LittleEndian(bytes.Slice(8, 4));
        if (sectionCount == 0 || sectionCount > PortableModuleFormat.MaxSectionCount)
            throw new InvalidDataException(
                $"Portable module section count must be between 1 and {PortableModuleFormat.MaxSectionCount}.");

        int offset = HeaderSize;
        int previousKind = -1;
        var sections = new List<RawSection>(checked((int)sectionCount));

        for (uint index = 0; index < sectionCount; index++)
        {
            if (bytes.Length - offset < SectionHeaderSize)
                throw new InvalidDataException("Portable module section header is truncated.");

            ushort kind = BinaryPrimitives.ReadUInt16LittleEndian(bytes.Slice(offset, 2));
            ushort rawFlags = BinaryPrimitives.ReadUInt16LittleEndian(bytes.Slice(offset + 2, 2));
            ulong rawLength = BinaryPrimitives.ReadUInt64LittleEndian(bytes.Slice(offset + 4, 8));
            offset += SectionHeaderSize;

            if (kind <= previousKind)
                throw new InvalidDataException("Portable module sections must be unique and strictly ordered by kind.");
            previousKind = kind;

            if ((rawFlags & ~KnownSectionFlagMask) != 0)
                throw new InvalidDataException($"Section 0x{kind:X4} uses reserved flag bits.");
            var flags = (PortableModuleSectionFlags)rawFlags;

            if (rawLength > int.MaxValue || rawLength > (ulong)(bytes.Length - offset))
                throw new InvalidDataException($"Section 0x{kind:X4} payload is truncated or too large.");

            int length = checked((int)rawLength);
            byte[] payload = bytes.Slice(offset, length).ToArray();
            offset += length;

            VerifySectionPayload(kind, flags, payload);
            sections.Add(new RawSection(kind, flags, payload));
        }

        if (offset != bytes.Length)
            throw new InvalidDataException("Portable module contains trailing bytes after the final section.");

        RawSection? ast = sections.FirstOrDefault(section =>
            section.Kind == (ushort)PortableModuleSectionKind.SemanticAst);
        if (ast is null)
            throw new InvalidDataException("Portable module is missing the Semantic AST section.");
        if ((ast.Flags & PortableModuleSectionFlags.Critical) == 0)
            throw new InvalidDataException("Semantic AST section must be critical.");

        VerifyIndexedExecutable(sections);
    }

    private static void VerifySectionPayload(
        ushort kind,
        PortableModuleSectionFlags flags,
        ReadOnlySpan<byte> payload)
    {
        bool critical = (flags & PortableModuleSectionFlags.Critical) != 0;
        switch ((PortableModuleSectionKind)kind)
        {
            case PortableModuleSectionKind.SemanticAst:
                if (!critical)
                    throw new InvalidDataException("Semantic AST section must be critical.");
                VerifyCanonicalJson(payload, requireObject: true, "Semantic AST", stripVolatileSyntaxMetadata: true);
                break;

            case PortableModuleSectionKind.ContractManifest:
                if (!critical)
                    throw new InvalidDataException("Contract manifest section must be critical.");
                VerifyCanonicalContract(payload);
                break;

            case PortableModuleSectionKind.CapabilityManifest:
                if (!critical)
                    throw new InvalidDataException("Capability manifest section must be critical.");
                VerifyCapabilityManifest(payload);
                break;

            case PortableModuleSectionKind.IndexedStringTable:
            case PortableModuleSectionKind.IndexedTypeTable:
            case PortableModuleSectionKind.IndexedFunctionTable:
            case PortableModuleSectionKind.IndexedImportTable:
            case PortableModuleSectionKind.IndexedExportTable:
            case PortableModuleSectionKind.IndexedConstantTable:
            case PortableModuleSectionKind.IndexedCode:
                if (!critical)
                    throw new InvalidDataException($"Indexed executable section 0x{kind:X4} must be critical.");
                break;

            default:
                if (critical)
                    throw new InvalidDataException($"Unknown critical section 0x{kind:X4}.");
                break;
        }
    }

    private static void VerifyIndexedExecutable(IReadOnlyList<RawSection> sections)
    {
        int present = IndexedKinds.Count(kind =>
            sections.Any(section => section.Kind == (ushort)kind));
        if (present == 0) return;
        if (present != IndexedKinds.Length)
            throw new InvalidDataException(
                "Indexed executable PMF sections 0x0010..0x0016 must be present as a complete group.");

        byte[] stringsPayload = Required(sections, PortableModuleSectionKind.IndexedStringTable).Payload;
        byte[] typesPayload = Required(sections, PortableModuleSectionKind.IndexedTypeTable).Payload;
        byte[] functionsPayload = Required(sections, PortableModuleSectionKind.IndexedFunctionTable).Payload;
        byte[] importsPayload = Required(sections, PortableModuleSectionKind.IndexedImportTable).Payload;
        byte[] exportsPayload = Required(sections, PortableModuleSectionKind.IndexedExportTable).Payload;
        byte[] constantsPayload = Required(sections, PortableModuleSectionKind.IndexedConstantTable).Payload;
        byte[] codePayload = Required(sections, PortableModuleSectionKind.IndexedCode).Payload;

        List<byte[]> strings = ParseStringTable(stringsPayload);
        List<TypeEntry> types = ParseTypeTable(typesPayload, strings.Count);
        List<FunctionEntry> functions = ParseFunctionTable(functionsPayload, types.Count);
        List<ImportEntry> imports = ParseImportTable(importsPayload, strings, types);
        ParseExportTable(exportsPayload, strings, functions, types);
        ParseConstantTable(constantsPayload);
        VerifyFunctionRanges(functions, codePayload.Length);
        VerifyCode(functions, imports, types, codePayload);
    }

    private static RawSection Required(
        IReadOnlyList<RawSection> sections,
        PortableModuleSectionKind kind) =>
        sections.Single(section => section.Kind == (ushort)kind);

    private static List<byte[]> ParseStringTable(ReadOnlySpan<byte> payload)
    {
        var reader = new RawReader(payload);
        uint count = reader.ReadUInt32("String table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("String table entry count is too large.");

        var result = new List<byte[]>(checked((int)count));
        byte[]? previous = null;
        for (uint index = 0; index < count; index++)
        {
            uint rawLength = reader.ReadUInt32("String byte length");
            if (rawLength > int.MaxValue)
                throw new InvalidDataException("Indexed string is too large.");
            byte[] valueBytes = reader.ReadBytes(checked((int)rawLength), "Indexed string").ToArray();
            string value;
            try
            {
                value = StrictUtf8.GetString(valueBytes);
            }
            catch (DecoderFallbackException error)
            {
                throw new InvalidDataException("Indexed string is not valid UTF-8.", error);
            }
            if (value.Length != 0 && value[0] == '\uFEFF')
                throw new InvalidDataException("Indexed string must not contain a BOM.");
            if (previous is not null && ByteArrayComparer.Instance.Compare(previous, valueBytes) >= 0)
                throw new InvalidDataException("Indexed strings must be unique and sorted by UTF-8 bytes.");
            previous = valueBytes;
            result.Add(valueBytes);
        }
        reader.RequireEnd("String table");
        return result;
    }

    private static List<TypeEntry> ParseTypeTable(ReadOnlySpan<byte> payload, int stringCount)
    {
        var reader = new RawReader(payload);
        uint count = reader.ReadUInt32("Type table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("Type table entry count is too large.");

        var result = new List<TypeEntry>(checked((int)count));
        byte[]? previous = null;
        for (uint index = 0; index < count; index++)
        {
            int start = reader.Position;
            byte primitiveRaw = reader.ReadByte("Primitive type");
            if (!Enum.IsDefined(typeof(PrimitiveType), (PrimitiveType)primitiveRaw))
                throw new InvalidDataException(
                    $"Undefined primitive type 0x{primitiveRaw:X2} in indexed type table.");
            var primitive = (PrimitiveType)primitiveRaw;

            uint modifiers = reader.ReadUInt32("Type modifiers");
            if ((modifiers & ~KnownTypeModifierMask) != 0)
                throw new InvalidDataException("Indexed type uses reserved TypeModifiers bits.");

            ulong fixedSize = reader.ReadUInt64("Fixed array size");
            if ((modifiers & (uint)TypeModifiers.IsArray) == 0 && fixedSize != 1)
                throw new InvalidDataException("Non-array indexed types must have a one-cell extent.");

            uint nameIndex = reader.ReadUInt32("Type name string index");
            ulong reserved = reader.ReadUInt64("Type reserved bytes");
            if (reserved != 0)
                throw new InvalidDataException("Indexed type reserved bytes must be zero.");

            if (primitive == PrimitiveType.CustomType)
            {
                if (nameIndex >= (uint)stringCount)
                    throw new InvalidDataException("Custom indexed type requires a valid name StringIndex.");
            }
            else if (nameIndex != NoIndex)
            {
                throw new InvalidDataException("Primitive indexed type must use NoIndex for its name.");
            }

            byte[] encoded = reader.CopyRange(start, 25);
            if (previous is not null && ByteArrayComparer.Instance.Compare(previous, encoded) >= 0)
                throw new InvalidDataException("Indexed types must be unique and sorted by their encoded bytes.");
            previous = encoded;
            result.Add(new TypeEntry(primitive, modifiers, fixedSize, nameIndex));
        }
        reader.RequireEnd("Type table");
        return result;
    }

    private static List<FunctionEntry> ParseFunctionTable(ReadOnlySpan<byte> payload, int typeCount)
    {
        var reader = new RawReader(payload);
        uint count = reader.ReadUInt32("Function table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("Function table entry count is too large.");

        var result = new List<FunctionEntry>(checked((int)count));
        for (uint index = 0; index < count; index++)
        {
            uint returnType = reader.ReadUInt32("Function return TypeIndex");
            uint argumentCount = reader.ReadUInt32("Function argument count");
            uint localCount = reader.ReadUInt32("Function local count");
            uint codeOffset = reader.ReadUInt32("Function code offset");
            uint codeLength = reader.ReadUInt32("Function code length");
            uint flags = reader.ReadUInt32("Function flags");

            RequireIndex(returnType, typeCount, "Function return TypeIndex");
            if (flags != 0)
                throw new InvalidDataException("Indexed function flags are reserved in v0 and must be zero.");
            if (argumentCount > int.MaxValue || localCount > int.MaxValue)
                throw new InvalidDataException("Indexed function binding count is too large.");

            var arguments = new uint[checked((int)argumentCount)];
            var locals = new uint[checked((int)localCount)];
            for (int argument = 0; argument < arguments.Length; argument++)
            {
                arguments[argument] = reader.ReadUInt32("Function argument TypeIndex");
                RequireIndex(arguments[argument], typeCount, "Function argument TypeIndex");
            }
            for (int local = 0; local < locals.Length; local++)
            {
                locals[local] = reader.ReadUInt32("Function local TypeIndex");
                RequireIndex(locals[local], typeCount, "Function local TypeIndex");
            }

            result.Add(new FunctionEntry(
                returnType, argumentCount, localCount, codeOffset, codeLength, arguments, locals));
        }
        reader.RequireEnd("Function table");
        return result;
    }

    private static List<ImportEntry> ParseImportTable(
        ReadOnlySpan<byte> payload,
        IReadOnlyList<byte[]> strings,
        IReadOnlyList<TypeEntry> types)
    {
        var reader = new RawReader(payload);
        uint count = reader.ReadUInt32("Import table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("Import table entry count is too large.");

        var result = new List<ImportEntry>(checked((int)count));
        byte[]? previous = null;
        for (uint index = 0; index < count; index++)
        {
            int start = reader.Position;
            uint module = reader.ReadUInt32("Import module StringIndex");
            uint symbol = reader.ReadUInt32("Import symbol StringIndex");
            uint returnType = reader.ReadUInt32("Import return TypeIndex");
            RequireNonEmptyString(module, strings, "Import module StringIndex");
            RequireNonEmptyString(symbol, strings, "Import symbol StringIndex");
            RequireBoundaryReturnType(returnType, types, "Import return TypeIndex");

            uint argumentCount = reader.ReadUInt32("Import argument count");
            if (argumentCount > int.MaxValue)
                throw new InvalidDataException("Import argument count is too large.");
            var arguments = new BoundaryDescriptor[checked((int)argumentCount)];
            for (int argument = 0; argument < arguments.Length; argument++)
                arguments[argument] = ReadBoundaryDescriptor(ref reader, types, "Import argument");

            byte[] encoded = reader.CopyRange(start, reader.Position - start);
            if (previous is not null && ByteArrayComparer.Instance.Compare(previous, encoded) > 0)
                throw new InvalidDataException(
                    "Imports must be sorted by their encoded bytes; equal rows remain distinct authority slots.");
            previous = encoded;
            result.Add(new ImportEntry(module, symbol, returnType, arguments));
        }
        reader.RequireEnd("Import table");
        return result;
    }

    private static void ParseExportTable(
        ReadOnlySpan<byte> payload,
        IReadOnlyList<byte[]> strings,
        IReadOnlyList<FunctionEntry> functions,
        IReadOnlyList<TypeEntry> types)
    {
        var reader = new RawReader(payload);
        uint count = reader.ReadUInt32("Export table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("Export table entry count is too large.");

        byte[]? previousName = null;
        for (uint index = 0; index < count; index++)
        {
            uint symbol = reader.ReadUInt32("Export symbol StringIndex");
            RequireNonEmptyString(symbol, strings, "Export symbol StringIndex");
            uint functionIndex = reader.ReadUInt32("Export FunctionIndex");
            RequireIndex(functionIndex, functions.Count, "Export FunctionIndex");
            uint returnType = reader.ReadUInt32("Export return TypeIndex");
            RequireBoundaryReturnType(returnType, types, "Export return TypeIndex");
            uint argumentCount = reader.ReadUInt32("Export argument count");
            if (argumentCount > int.MaxValue)
                throw new InvalidDataException("Export argument count is too large.");

            FunctionEntry function = functions[checked((int)functionIndex)];
            if (returnType != function.ReturnType)
                throw new InvalidDataException("Export return TypeIndex must match its FunctionIndex signature.");
            if (argumentCount != function.ArgumentCount)
                throw new InvalidDataException("Export argument count must match its FunctionIndex signature.");

            for (int argument = 0; argument < checked((int)argumentCount); argument++)
            {
                BoundaryDescriptor descriptor = ReadBoundaryDescriptor(ref reader, types, "Export argument");
                TypeEntry carrier = types[checked((int)descriptor.TypeIndex)];
                TypeEntry internalType = types[checked((int)function.ArgumentTypes[argument])];
                if (!MatchesBoundaryCarrier(internalType, carrier))
                    throw new InvalidDataException(
                        "Export argument carrier type must match its FunctionIndex signature modulo binding mutability.");
            }

            byte[] name = strings[checked((int)symbol)];
            if (previousName is not null && ByteArrayComparer.Instance.Compare(previousName, name) >= 0)
                throw new InvalidDataException("Export names must be unique and sorted by UTF-8 bytes.");
            previousName = name;
        }
        reader.RequireEnd("Export table");
    }

    private static bool MatchesBoundaryCarrier(TypeEntry internalType, TypeEntry carrier) =>
        internalType.Primitive == carrier.Primitive &&
        internalType.FixedArraySize == carrier.FixedArraySize &&
        carrier.Modifiers == 0 &&
        (internalType.Modifiers & ~(uint)(TypeModifiers.ReadOnly | TypeModifiers.Const)) == 0;

    private static BoundaryDescriptor ReadBoundaryDescriptor(
        ref RawReader reader,
        IReadOnlyList<TypeEntry> types,
        string field)
    {
        byte rawMode = reader.ReadByte($"{field} passing mode");
        if (rawMode > (byte)PortablePassingMode.LoanWrite)
            throw new InvalidDataException($"{field} uses reserved passing mode 0x{rawMode:X2}.");
        uint typeIndex = reader.ReadUInt32($"{field} carrier TypeIndex");
        RequireIndex(typeIndex, types.Count, $"{field} carrier TypeIndex");
        TypeEntry type = types[checked((int)typeIndex)];
        RequireBoundaryCarrierType(type, field);
        var mode = (PortablePassingMode)rawMode;
        if ((mode is PortablePassingMode.LoanRead or PortablePassingMode.LoanWrite) &&
            type.Primitive != PrimitiveType.UInt64)
            throw new InvalidDataException($"{field} loan passing modes require a UInt64 carrier.");
        return new BoundaryDescriptor(mode, typeIndex);
    }

    private static void RequireBoundaryReturnType(
        uint typeIndex,
        IReadOnlyList<TypeEntry> types,
        string field)
    {
        RequireIndex(typeIndex, types.Count, field);
        TypeEntry type = types[checked((int)typeIndex)];
        if (type.Modifiers != 0 || type.FixedArraySize != 1 ||
            type.Primitive is not (PrimitiveType.Void or PrimitiveType.Byte or PrimitiveType.UInt32 or
                PrimitiveType.Int32 or PrimitiveType.UInt64 or PrimitiveType.Int64))
            throw new InvalidDataException($"{field} is not a supported portable boundary return type.");
    }

    private static void RequireBoundaryCarrierType(TypeEntry type, string field)
    {
        if (type.Modifiers != 0 || type.FixedArraySize != 1 ||
            type.Primitive is not (PrimitiveType.Byte or PrimitiveType.UInt32 or PrimitiveType.Int32 or
                PrimitiveType.UInt64 or PrimitiveType.Int64))
            throw new InvalidDataException($"{field} is not a supported portable boundary carrier type.");
    }

    private static void RequireNonEmptyString(
        uint index,
        IReadOnlyList<byte[]> strings,
        string field)
    {
        RequireIndex(index, strings.Count, field);
        if (strings[checked((int)index)].Length == 0)
            throw new InvalidDataException($"{field} must not reference an empty string.");
    }

    private static void ParseConstantTable(ReadOnlySpan<byte> payload)
    {
        var reader = new RawReader(payload);
        uint count = reader.ReadUInt32("Constant table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("Constant table entry count is too large.");

        byte[]? previous = null;
        int previousLength = -1;
        for (uint index = 0; index < count; index++)
        {
            uint rawLength = reader.ReadUInt32("Constant byte length");
            if (rawLength > int.MaxValue)
                throw new InvalidDataException("Indexed constant is too large.");
            byte[] value = reader.ReadBytes(checked((int)rawLength), "Indexed constant").ToArray();
            if (previous is not null &&
                (value.Length < previousLength ||
                 (value.Length == previousLength && ByteArrayComparer.Instance.Compare(previous, value) >= 0)))
                throw new InvalidDataException(
                    "Constants must be unique and sorted by length then payload bytes.");
            previous = value;
            previousLength = value.Length;
        }
        reader.RequireEnd("Constant table");
    }

    private static void VerifyFunctionRanges(IReadOnlyList<FunctionEntry> functions, int codeLength)
    {
        ulong expectedOffset = 0;
        foreach (FunctionEntry function in functions)
        {
            if (function.CodeOffset != expectedOffset)
                throw new InvalidDataException(
                    "Indexed function code ranges must be consecutively packed in FunctionIndex order.");
            ulong end = (ulong)function.CodeOffset + function.CodeLength;
            if (end > (ulong)codeLength)
                throw new InvalidDataException("Indexed function code range exceeds the Code section.");
            expectedOffset = end;
        }
        if (expectedOffset != (ulong)codeLength)
            throw new InvalidDataException("Indexed Code section contains bytes outside declared function ranges.");
    }

    private static void VerifyCode(
        IReadOnlyList<FunctionEntry> functions,
        IReadOnlyList<ImportEntry> imports,
        IReadOnlyList<TypeEntry> types,
        ReadOnlySpan<byte> code)
    {
        VerifyFunctionTypes(functions, types);

        for (int functionIndex = 0; functionIndex < functions.Count; functionIndex++)
        {
            FunctionEntry function = functions[functionIndex];
            ReadOnlySpan<byte> body = code.Slice(
                checked((int)function.CodeOffset), checked((int)function.CodeLength));
            var reader = new RawReader(body);
            ulong bindingCount = (ulong)function.ArgumentCount + function.LocalCount;
            var initializedLocals = new bool[checked((int)function.LocalCount)];
            var controls = new Stack<ControlFrame>();
            int stackDepth = 0;
            bool reachable = true;

            void Need(int cells, byte opcode)
            {
                if (reachable && stackDepth < cells)
                    throw new InvalidDataException(
                        $"FunctionIndex {functionIndex} opcode 0x{opcode:X2} needs {cells} evaluation stack cell(s), " +
                        $"but only {stackDepth} are available.");
            }

            void Apply(int required, int delta, byte opcode)
            {
                Need(required, opcode);
                if (reachable)
                    stackDepth = checked(stackDepth + delta);
            }

            void RequireDepth(int expected, byte opcode, string boundary)
            {
                if (reachable && stackDepth != expected)
                    throw new InvalidDataException(
                        $"FunctionIndex {functionIndex} opcode 0x{opcode:X2} reaches {boundary} with evaluation " +
                        $"stack depth {stackDepth}; expected {expected}.");
            }

            ControlFrame TransferTarget(byte opcode)
            {
                ControlFrame? target = controls.FirstOrDefault(frame =>
                    frame.Kind is ControlKind.Loop or ControlKind.While);
                return target ?? throw new InvalidDataException(
                    $"FunctionIndex {functionIndex} opcode 0x{opcode:X2} requires an enclosing LOOP or WHILE.");
            }

            while (!reader.AtEnd)
            {
                byte opcode = reader.ReadByte("Opcode");
                if (opcode == 0xFF)
                {
                    int escapeDepth = 1;
                    while (!reader.AtEnd && reader.PeekByte() == 0xFF)
                    {
                        reader.ReadByte("Opcode escape");
                        escapeDepth++;
                    }
                    byte group = reader.ReadByte("Extended opcode group");
                    byte extendedOpcode = reader.ReadByte("Extended opcode number");
                    if (group == 0xFF || extendedOpcode == 0xFF)
                        throw new InvalidDataException(
                            "0xFF is reserved in extended opcode group/code positions.");
                    throw new NotSupportedException(
                        $"Portable binary verifier does not yet support extended opcode " +
                        $"depth={escapeDepth}, group=0x{group:X2}, opcode=0x{extendedOpcode:X2}.");
                }

                switch (opcode)
                {
                    case RETURN.OP:
                    {
                        byte mode = reader.ReadByte("RETURN mode");
                        if (mode == 1)
                        {
                            uint typeIndex = reader.ReadUInt32("RETURN TypeIndex");
                            RequireIndex(typeIndex, types.Count, "RETURN TypeIndex");
                            if (typeIndex != function.ReturnType)
                                throw new InvalidDataException(
                                    "Explicit RETURN TypeIndex must match the enclosing function return type.");
                        }
                        else if (mode != 0)
                        {
                            throw new InvalidDataException($"Unknown RETURN mode {mode}.");
                        }

                        int resultCells = IsVoid(types[checked((int)function.ReturnType)]) ? 0 : 1;
                        Need(resultCells, opcode);
                        if (reachable)
                            reachable = false;
                        break;
                    }

                    case VarOpcode:
                    {
                        uint binding = reader.ReadUInt32("VAR BindingIndex");
                        if (binding >= bindingCount)
                            throw new InvalidDataException("VAR BindingIndex is outside the current function frame.");
                        if (binding < function.ArgumentCount)
                            throw new InvalidDataException("VAR cannot initialize an argument BindingIndex.");
                        int localIndex = checked((int)(binding - function.ArgumentCount));
                        if (initializedLocals[localIndex])
                            throw new InvalidDataException(
                                $"FunctionIndex {functionIndex} local BindingIndex {binding} is initialized more than once.");
                        initializedLocals[localIndex] = true;
                        _ = reader.ReadUInt64("VAR initial cell");
                        break;
                    }

                    case StackOperations.PUSH.OP:
                    {
                        byte length = reader.ReadByte("PUSH byte count");
                        if (length is < 1 or > 8)
                            throw new InvalidDataException("PUSH portable immediate must contain 1..8 bytes.");
                        _ = reader.ReadBytes(length, "PUSH immediate");
                        Apply(0, 1, opcode);
                        break;
                    }

                    case StackOperations.DROP.OP:
                    {
                        byte index = reader.ReadByte("Stack index");
                        Apply(index + 1, -1, opcode);
                        break;
                    }

                    case StackOperations.PICK.OP:
                    {
                        byte index = reader.ReadByte("Stack index");
                        Apply(index + 1, 1, opcode);
                        break;
                    }

                    case StackOperations.ROLL.OP:
                    {
                        byte index = reader.ReadByte("Stack index");
                        Apply(index + 1, 0, opcode);
                        break;
                    }

                    case FunctionOperations.CALL.OP:
                    {
                        byte targetKind = reader.ReadByte("CALL target kind");
                        uint targetIndex = reader.ReadUInt32("CALL target index");
                        switch (targetKind)
                        {
                            case 0:
                            {
                                RequireIndex(targetIndex, functions.Count, "CALL FunctionIndex");
                                FunctionEntry target = functions[checked((int)targetIndex)];
                                int arguments = checked((int)target.ArgumentCount);
                                int results = IsVoid(types[checked((int)target.ReturnType)]) ? 0 : 1;
                                Apply(arguments, results - arguments, opcode);
                                break;
                            }
                            case 1:
                            {
                                RequireIndex(targetIndex, imports.Count, "CALL ImportIndex");
                                int consumed = ImportCallCellCount(
                                    imports[checked((int)targetIndex)], types);
                                Apply(consumed, 1 - consumed, opcode);
                                break;
                            }
                            default:
                                throw new InvalidDataException(
                                    $"CALL uses reserved TargetKind 0x{targetKind:X2}.");
                        }
                        break;
                    }

                    case FunctionOperations.FNADDR.OP:
                        RequireIndex(reader.ReadUInt32("FunctionIndex"), functions.Count, "FunctionIndex");
                        Apply(0, 1, opcode);
                        break;

                    case FunctionOperations.CALLI.OP:
                    {
                        byte argumentCount = reader.ReadByte("CALLI argument count");
                        byte returnTypeRaw = reader.ReadByte("CALLI return primitive type");
                        if (!Enum.IsDefined(typeof(PrimitiveType), (PrimitiveType)returnTypeRaw))
                            throw new InvalidDataException(
                                $"CALLI uses undefined primitive return type 0x{returnTypeRaw:X2}.");
                        var returnType = (PrimitiveType)returnTypeRaw;
                        if (returnType != PrimitiveType.Void && !IsCellPrimitive(returnType))
                            throw new InvalidDataException(
                                "CALLI return type is not void or a scalar cell type.");
                        int consumed = argumentCount + 1;
                        int results = returnType == PrimitiveType.Void ? 0 : 1;
                        Apply(consumed, results - consumed, opcode);
                        break;
                    }

                    case MemoryOperations.LOAD.OP:
                    case MemoryOperations.STORE.OP:
                    {
                        byte mode = reader.ReadByte("LOAD/STORE mode");
                        switch (mode)
                        {
                            case 0:
                                break;
                            case 1:
                            {
                                byte primitiveRaw = reader.ReadByte("LOAD/STORE primitive type");
                                if (!Enum.IsDefined(typeof(PrimitiveType), (PrimitiveType)primitiveRaw) ||
                                    !IsCellPrimitive((PrimitiveType)primitiveRaw))
                                    throw new InvalidDataException(
                                        "LOAD/STORE raw type is not a supported scalar cell type.");
                                break;
                            }
                            case 2:
                            {
                                uint binding = reader.ReadUInt32("LOAD/STORE BindingIndex");
                                if (binding >= bindingCount)
                                    throw new InvalidDataException(
                                        "LOAD/STORE BindingIndex is outside the current function frame.");
                                if (opcode == MemoryOperations.STORE.OP &&
                                    IsReadOnly(BindingType(function, binding, types)))
                                    throw new InvalidDataException(
                                        $"FunctionIndex {functionIndex} cannot STORE to readonly/const BindingIndex {binding}.");
                                break;
                            }
                            default:
                                throw new InvalidDataException($"Unknown LOAD/STORE mode {mode}.");
                        }

                        if (opcode == MemoryOperations.LOAD.OP)
                            Apply(mode == 2 ? 0 : 1, mode == 2 ? 1 : 0, opcode);
                        else
                            Apply(mode == 2 ? 1 : 2, mode == 2 ? -1 : -2, opcode);
                        break;
                    }

                    case BLOCK.OP:
                        controls.Push(new ControlFrame(ControlKind.Block, stackDepth, reachable));
                        break;

                    case LOOP.OP:
                        controls.Push(new ControlFrame(ControlKind.Loop, stackDepth, reachable));
                        break;

                    case IF.OP:
                        Apply(1, -1, opcode);
                        controls.Push(new ControlFrame(ControlKind.If, stackDepth, reachable));
                        break;

                    case WHILE.OP:
                        Apply(1, -1, opcode);
                        controls.Push(new ControlFrame(ControlKind.While, stackDepth, reachable));
                        break;

                    case ELSE.OP:
                    {
                        if (controls.Count == 0 || controls.Peek().Kind != ControlKind.If)
                            throw new InvalidDataException(
                                $"FunctionIndex {functionIndex} ELSE requires a directly enclosing IF.");
                        ControlFrame conditional = controls.Pop();
                        controls.Push(new ControlFrame(
                            ControlKind.Else,
                            conditional.EntryDepth,
                            conditional.EntryReachable)
                        {
                            ThenReachable = reachable,
                            ThenDepth = stackDepth
                        });
                        reachable = conditional.EntryReachable;
                        stackDepth = conditional.EntryDepth;
                        break;
                    }

                    case END.OP:
                    {
                        if (controls.Count == 0)
                            throw new InvalidDataException(
                                $"FunctionIndex {functionIndex} END has no matching structured control opener.");
                        ControlFrame frame = controls.Pop();
                        switch (frame.Kind)
                        {
                            case ControlKind.Block:
                                RequireDepth(frame.EntryDepth, opcode, "BLOCK end");
                                stackDepth = frame.EntryDepth;
                                break;

                            case ControlKind.If:
                                RequireDepth(frame.EntryDepth, opcode, "IF end");
                                reachable = frame.EntryReachable;
                                stackDepth = frame.EntryDepth;
                                break;

                            case ControlKind.Else:
                            {
                                bool elseReachable = reachable;
                                int elseDepth = stackDepth;
                                if (frame.ThenReachable && elseReachable && frame.ThenDepth != elseDepth)
                                    throw new InvalidDataException(
                                        $"FunctionIndex {functionIndex} IF/ELSE branches merge with stack depths " +
                                        $"{frame.ThenDepth} and {elseDepth}.");
                                reachable = frame.ThenReachable || elseReachable;
                                stackDepth = frame.ThenReachable
                                    ? frame.ThenDepth
                                    : elseReachable ? elseDepth : frame.EntryDepth;
                                break;
                            }

                            case ControlKind.Loop:
                                RequireDepth(frame.EntryDepth, opcode, "LOOP backedge");
                                reachable = frame.HasReachableBreak;
                                stackDepth = frame.EntryDepth;
                                break;

                            case ControlKind.While:
                                RequireDepth(frame.EntryDepth + 1, opcode, "WHILE backedge");
                                reachable = frame.EntryReachable || frame.HasReachableBreak;
                                stackDepth = frame.EntryDepth;
                                break;

                            default:
                                throw new InvalidDataException("Unknown portable structured control frame.");
                        }
                        break;
                    }

                    case BREAK.OP:
                    {
                        ControlFrame target = TransferTarget(opcode);
                        RequireDepth(target.EntryDepth, opcode, "BREAK target");
                        if (reachable)
                        {
                            target.HasReachableBreak = true;
                            reachable = false;
                        }
                        break;
                    }

                    case CONTINUE.OP:
                    {
                        ControlFrame target = TransferTarget(opcode);
                        int expected = target.Kind == ControlKind.While
                            ? target.EntryDepth + 1
                            : target.EntryDepth;
                        RequireDepth(expected, opcode, "CONTINUE target");
                        if (reachable)
                            reachable = false;
                        break;
                    }

                    default:
                        if (!OperandFreeCoreOpcodes.Contains(opcode))
                            throw new InvalidDataException(
                                $"Core opcode 0x{opcode:X2} has no supported indexed executable v0 wire contract.");
                        ApplyOperandFreeStackEffect(opcode, ref stackDepth, ref reachable, functionIndex);
                        break;
                }
            }

            reader.RequireEnd($"Function {functionIndex} code");

            if (controls.Count != 0)
                throw new InvalidDataException(
                    $"FunctionIndex {functionIndex} contains {controls.Count} unterminated structured control scope(s).");

            for (int local = 0; local < initializedLocals.Length; local++)
            {
                if (!initializedLocals[local])
                    throw new InvalidDataException(
                        $"FunctionIndex {functionIndex} local BindingIndex {function.ArgumentCount + (uint)local} has no VAR initialization.");
            }

            if (!IsVoid(types[checked((int)function.ReturnType)]) && reachable)
                throw new InvalidDataException(
                    $"FunctionIndex {functionIndex} has a reachable path without RETURN.");
        }
    }

    private static void VerifyFunctionTypes(
        IReadOnlyList<FunctionEntry> functions,
        IReadOnlyList<TypeEntry> types)
    {
        for (int functionIndex = 0; functionIndex < functions.Count; functionIndex++)
        {
            FunctionEntry function = functions[functionIndex];
            TypeEntry returnType = types[checked((int)function.ReturnType)];
            if (IsVoid(returnType))
            {
                if (returnType.Modifiers != 0 || returnType.FixedArraySize != 1)
                    throw new InvalidDataException(
                        $"FunctionIndex {functionIndex} void return type must be an unmodified one-cell type entry.");
            }
            else if (!IsCellType(returnType))
            {
                throw new InvalidDataException(
                    $"FunctionIndex {functionIndex} return type is not supported by the portable cell ABI.");
            }

            for (int argument = 0; argument < function.ArgumentTypes.Length; argument++)
            {
                TypeEntry type = types[checked((int)function.ArgumentTypes[argument])];
                if (!IsCellType(type))
                    throw new InvalidDataException(
                        $"FunctionIndex {functionIndex} argument BindingIndex {argument} is not a scalar cell type.");
            }

            for (int local = 0; local < function.LocalTypes.Length; local++)
            {
                TypeEntry type = types[checked((int)function.LocalTypes[local])];
                if (!IsCellType(type))
                    throw new InvalidDataException(
                        $"FunctionIndex {functionIndex} local BindingIndex {function.ArgumentCount + (uint)local} is not a scalar cell type.");
            }
        }
    }

    private static void ApplyOperandFreeStackEffect(
        byte opcode,
        ref int stackDepth,
        ref bool reachable,
        int functionIndex)
    {
        if (!reachable)
            return;

        if (opcode == TRAP.OP)
        {
            reachable = false;
            return;
        }

        if (opcode == CLEAR.OP)
        {
            stackDepth = 0;
            return;
        }

        int required;
        int delta;
        if (opcode == NULL.OP || opcode == DEFAULT.OP)
        {
            required = 0;
            delta = 1;
        }
        else if (opcode == StackOperations.POP.OP)
        {
            required = 1;
            delta = -1;
        }
        else if (opcode == StackOperations.DUP.OP)
        {
            required = 1;
            delta = 1;
        }
        else if (opcode == StackOperations.SWAP.OP)
        {
            required = 2;
            delta = 0;
        }
        else if (opcode == StackOperations.ROT.OP)
        {
            required = 3;
            delta = 0;
        }
        else if (opcode == StackOperations.OVER.OP)
        {
            required = 2;
            delta = 1;
        }
        else if (opcode == StackOperations.NIP.OP)
        {
            required = 2;
            delta = -1;
        }
        else if (opcode == StackOperations.TwoDUP.OP)
        {
            required = 2;
            delta = 2;
        }
        else if (opcode == StackOperations.TwoSWAP.OP)
        {
            required = 4;
            delta = 0;
        }
        else if (opcode == StackOperations.TwoROT.OP)
        {
            required = 6;
            delta = 0;
        }
        else if (opcode == StackOperations.TwoOVER.OP)
        {
            required = 4;
            delta = 2;
        }
        else if (opcode is >= 0x20 and <= 0x24 or >= 0x30 and <= 0x32 or 0x29 or 0x2A or
                 >= 0x34 and <= 0x36 or >= 0x40 and <= 0x49)
        {
            required = 2;
            delta = -1;
        }
        else if (opcode is >= 0x25 and <= 0x28 or 0x33)
        {
            required = 1;
            delta = 0;
        }
        else
        {
            required = 0;
            delta = 0;
        }

        if (stackDepth < required)
            throw new InvalidDataException(
                $"FunctionIndex {functionIndex} opcode 0x{opcode:X2} needs {required} evaluation stack cell(s), " +
                $"but only {stackDepth} are available.");
        stackDepth = checked(stackDepth + delta);
    }

    private static int ImportCallCellCount(
        ImportEntry import,
        IReadOnlyList<TypeEntry> types)
    {
        bool legacyBuffer = import.Arguments.Length == 4 &&
            import.Arguments.All(argument =>
                argument.PassingMode == PortablePassingMode.Value &&
                types[checked((int)argument.TypeIndex)].Primitive == PrimitiveType.UInt64) &&
            types[checked((int)import.ReturnType)].Primitive == PrimitiveType.Int64;
        if (legacyBuffer)
            return 5;

        int cells = 2; // budget_ms + result_address
        foreach (BoundaryDescriptor argument in import.Arguments)
            cells = checked(cells +
                (argument.PassingMode is PortablePassingMode.LoanRead or PortablePassingMode.LoanWrite ? 2 : 1));
        return cells;
    }

    private static TypeEntry BindingType(
        FunctionEntry function,
        uint binding,
        IReadOnlyList<TypeEntry> types)
    {
        uint typeIndex = binding < function.ArgumentCount
            ? function.ArgumentTypes[checked((int)binding)]
            : function.LocalTypes[checked((int)(binding - function.ArgumentCount))];
        return types[checked((int)typeIndex)];
    }

    private static bool IsVoid(TypeEntry type) => type.Primitive == PrimitiveType.Void;

    private static bool IsReadOnly(TypeEntry type) =>
        (type.Modifiers & (uint)(TypeModifiers.ReadOnly | TypeModifiers.Const)) != 0;

    private static bool IsCellType(TypeEntry type) =>
        type.FixedArraySize == 1 &&
        (type.Modifiers & ~(uint)(TypeModifiers.Const | TypeModifiers.ReadOnly)) == 0 &&
        IsCellPrimitive(type.Primitive);

    private static bool IsCellPrimitive(PrimitiveType primitive) =>
        primitive is PrimitiveType.Bool or PrimitiveType.Char8 or PrimitiveType.Char16 or PrimitiveType.Byte or
            PrimitiveType.SByte or PrimitiveType.Int16 or PrimitiveType.UInt16 or PrimitiveType.Int32 or
            PrimitiveType.UInt32 or PrimitiveType.Int64 or PrimitiveType.UInt64;

    private static HashSet<byte> DiscoverOperandFreeCoreOpcodes()
    {
        var result = new HashSet<byte>();
        foreach (Type type in typeof(IOpCode).Assembly.GetTypes())
        {
            if (!type.IsValueType || type.IsAbstract || !typeof(IOpCode).IsAssignableFrom(type) ||
                typeof(IExtendedOpCode).IsAssignableFrom(type))
                continue;
            if (type.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic).Length != 0)
                continue;
            if (Activator.CreateInstance(type) is not IOpCode operation || operation.OpCode == 0xFF)
                continue;
            result.Add(operation.OpCode);
        }

        result.Remove(RETURN.OP);
        result.Remove(VarOpcode);
        result.Remove(StackOperations.PUSH.OP);
        result.Remove(StackOperations.DROP.OP);
        result.Remove(StackOperations.PICK.OP);
        result.Remove(StackOperations.ROLL.OP);
        result.Remove(MemoryOperations.LOAD.OP);
        result.Remove(MemoryOperations.STORE.OP);
        result.Remove(FunctionOperations.CALL.OP);
        result.Remove(FunctionOperations.FNADDR.OP);
        result.Remove(FunctionOperations.CALLI.OP);
        return result;
    }

    private static void VerifyCanonicalJson(
        ReadOnlySpan<byte> payload,
        bool requireObject,
        string name,
        bool stripVolatileSyntaxMetadata = false)
    {
        byte[] canonical;
        try
        {
            canonical = CanonicalizeJson(payload, requireObject, stripVolatileSyntaxMetadata);
        }
        catch (JsonException error)
        {
            throw new InvalidDataException($"{name} section is not valid JSON.", error);
        }

        if (!payload.SequenceEqual(canonical))
            throw new InvalidDataException($"{name} section is not in canonical JSON v0 form.");
    }

    private static void VerifyCapabilityManifest(ReadOnlySpan<byte> payload)
    {
        VerifyCanonicalJson(payload, requireObject: false, "Capability manifest");
        using JsonDocument document = JsonDocument.Parse(payload.ToArray());
        if (document.RootElement.ValueKind != JsonValueKind.Array)
            throw new InvalidDataException("Capability manifest must be a JSON array.");

        string? previous = null;
        foreach (JsonElement item in document.RootElement.EnumerateArray())
        {
            if (item.ValueKind != JsonValueKind.String)
                throw new InvalidDataException("Capability manifest entries must be strings.");
            string capability = item.GetString() ?? string.Empty;
            if (capability.Length == 0 ||
                !string.Equals(capability, capability.Trim(), StringComparison.Ordinal))
                throw new InvalidDataException("Capability names must be non-empty canonical strings.");
            if (previous is not null && string.CompareOrdinal(previous, capability) >= 0)
                throw new InvalidDataException(
                    "Capability manifest entries must be unique and ordinally sorted.");
            previous = capability;
        }
    }

    private static void VerifyCanonicalContract(ReadOnlySpan<byte> payload)
    {
        string text;
        try
        {
            text = StrictUtf8.GetString(payload);
        }
        catch (DecoderFallbackException error)
        {
            throw new InvalidDataException("Contract manifest is not valid UTF-8.", error);
        }

        if (text.Length != 0 && text[0] == '\uFEFF')
            throw new InvalidDataException("Contract manifest must not contain a BOM.");
        if (text.Contains('\r', StringComparison.Ordinal))
            throw new InvalidDataException("Contract manifest must use LF line endings.");
    }

    private static byte[] CanonicalizeJson(
        ReadOnlySpan<byte> utf8,
        bool requireObject,
        bool stripVolatileSyntaxMetadata)
    {
        using JsonDocument document = JsonDocument.Parse(utf8.ToArray(), new JsonDocumentOptions
        {
            AllowTrailingCommas = false,
            CommentHandling = JsonCommentHandling.Disallow,
            MaxDepth = 128
        });
        if (requireObject && document.RootElement.ValueKind != JsonValueKind.Object)
            throw new JsonException("Canonical payload root must be a JSON object.");

        using var stream = new MemoryStream();
        using (var writer = new Utf8JsonWriter(stream, new JsonWriterOptions
        {
            Indented = false,
            SkipValidation = false
        }))
        {
            WriteCanonicalJson(
                writer,
                document.RootElement,
                stripVolatileSyntaxMetadata,
                metadataObject: false);
        }
        return stream.ToArray();
    }

    private static void WriteCanonicalJson(
        Utf8JsonWriter writer,
        JsonElement element,
        bool stripVolatileSyntaxMetadata,
        bool metadataObject)
    {
        switch (element.ValueKind)
        {
            case JsonValueKind.Object:
                writer.WriteStartObject();
                var names = new HashSet<string>(StringComparer.Ordinal);
                JsonProperty[] properties = element.EnumerateObject().ToArray();
                foreach (JsonProperty property in properties)
                    if (!names.Add(property.Name))
                        throw new JsonException($"Duplicate JSON property '{property.Name}'.");
                foreach (JsonProperty property in properties.OrderBy(
                             property => property.Name, StringComparer.Ordinal))
                {
                    if (stripVolatileSyntaxMetadata && metadataObject &&
                        string.Equals(property.Name, "guid", StringComparison.Ordinal))
                        continue;
                    writer.WritePropertyName(property.Name);
                    WriteCanonicalJson(
                        writer,
                        property.Value,
                        stripVolatileSyntaxMetadata,
                        string.Equals(property.Name, "Metadata", StringComparison.Ordinal));
                }
                writer.WriteEndObject();
                break;

            case JsonValueKind.Array:
                writer.WriteStartArray();
                foreach (JsonElement item in element.EnumerateArray())
                    WriteCanonicalJson(writer, item, stripVolatileSyntaxMetadata, metadataObject: false);
                writer.WriteEndArray();
                break;

            case JsonValueKind.String:
                writer.WriteStringValue(element.GetString());
                break;
            case JsonValueKind.Number:
                element.WriteTo(writer);
                break;
            case JsonValueKind.True:
                writer.WriteBooleanValue(true);
                break;
            case JsonValueKind.False:
                writer.WriteBooleanValue(false);
                break;
            case JsonValueKind.Null:
                writer.WriteNullValue();
                break;
            default:
                throw new JsonException($"Unsupported JSON token {element.ValueKind}.");
        }
    }

    private static void RequireIndex(uint index, int count, string name)
    {
        if (index >= (uint)count)
            throw new InvalidDataException($"{name} {index} is outside table size {count}.");
    }

    private sealed record RawSection(
        ushort Kind,
        PortableModuleSectionFlags Flags,
        byte[] Payload);

    private readonly record struct FunctionEntry(
        uint ReturnType,
        uint ArgumentCount,
        uint LocalCount,
        uint CodeOffset,
        uint CodeLength,
        uint[] ArgumentTypes,
        uint[] LocalTypes);

    private readonly record struct ImportEntry(
        uint ModuleStringIndex,
        uint SymbolStringIndex,
        uint ReturnType,
        BoundaryDescriptor[] Arguments);

    private readonly record struct BoundaryDescriptor(
        PortablePassingMode PassingMode,
        uint TypeIndex);

    private readonly record struct TypeEntry(
        PrimitiveType Primitive,
        uint Modifiers,
        ulong FixedArraySize,
        uint NameStringIndex);

    private enum ControlKind : byte
    {
        Block,
        If,
        Else,
        Loop,
        While
    }

    private sealed class ControlFrame(ControlKind kind, int entryDepth, bool entryReachable)
    {
        internal ControlKind Kind { get; } = kind;
        internal int EntryDepth { get; } = entryDepth;
        internal bool EntryReachable { get; } = entryReachable;
        internal bool ThenReachable { get; set; }
        internal int ThenDepth { get; set; }
        internal bool HasReachableBreak { get; set; }
    }

    private sealed class ByteArrayComparer : IComparer<byte[]>
    {
        internal static ByteArrayComparer Instance { get; } = new();

        public int Compare(byte[]? left, byte[]? right)
        {
            if (ReferenceEquals(left, right)) return 0;
            if (left is null) return -1;
            if (right is null) return 1;
            int common = Math.Min(left.Length, right.Length);
            for (int index = 0; index < common; index++)
            {
                int comparison = left[index].CompareTo(right[index]);
                if (comparison != 0) return comparison;
            }
            return left.Length.CompareTo(right.Length);
        }
    }

    private ref struct RawReader(ReadOnlySpan<byte> data)
    {
        private readonly ReadOnlySpan<byte> _data = data;
        private int _position;

        internal int Position => _position;
        internal bool AtEnd => _position == _data.Length;

        internal byte PeekByte()
        {
            if (_position >= _data.Length)
                throw new InvalidDataException("Portable binary payload is truncated.");
            return _data[_position];
        }

        internal byte ReadByte(string field)
        {
            Ensure(1, field);
            return _data[_position++];
        }

        internal uint ReadUInt32(string field)
        {
            Ensure(4, field);
            uint value = BinaryPrimitives.ReadUInt32LittleEndian(_data.Slice(_position, 4));
            _position += 4;
            return value;
        }

        internal ulong ReadUInt64(string field)
        {
            Ensure(8, field);
            ulong value = BinaryPrimitives.ReadUInt64LittleEndian(_data.Slice(_position, 8));
            _position += 8;
            return value;
        }

        internal ReadOnlySpan<byte> ReadBytes(int length, string field)
        {
            Ensure(length, field);
            ReadOnlySpan<byte> value = _data.Slice(_position, length);
            _position += length;
            return value;
        }

        internal byte[] CopyRange(int start, int length)
        {
            if (start < 0 || length < 0 || start > _data.Length - length)
                throw new InvalidDataException("Portable binary range is invalid.");
            return _data.Slice(start, length).ToArray();
        }

        internal void RequireEnd(string name)
        {
            if (!AtEnd)
                throw new InvalidDataException($"{name} contains trailing bytes.");
        }

        private void Ensure(int length, string field)
        {
            if (length < 0 || _position > _data.Length - length)
                throw new InvalidDataException($"{field} is truncated.");
        }
    }
}
