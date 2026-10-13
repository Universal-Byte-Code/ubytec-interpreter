using System.Buffers.Binary;
using System.Reflection;
using System.Text;
using Ubytec.Language.HighLevel;
using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Extended;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.Model;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Portable;

/// <summary>
/// Architecture-neutral indexed executable profile for Portable Module Format v0.
/// Symbolic function, frame and module-boundary references are lowered to fixed-width table indices.
/// </summary>
public static class IndexedExecutableFormat
{
    /// <summary>Sentinel used only by table fields whose specification permits an absent index.</summary>
    public const uint NoIndex = uint.MaxValue;

    private static readonly UTF8Encoding StrictUtf8 = new(false, true);
    private static readonly HashSet<byte> OperandFreeCoreOpcodes = DiscoverOperandFreeCoreOpcodes();

    private static readonly PortableModuleSectionKind[] SectionKinds =
    [
        PortableModuleSectionKind.IndexedStringTable,
        PortableModuleSectionKind.IndexedTypeTable,
        PortableModuleSectionKind.IndexedFunctionTable,
        PortableModuleSectionKind.IndexedImportTable,
        PortableModuleSectionKind.IndexedExportTable,
        PortableModuleSectionKind.IndexedConstantTable,
        PortableModuleSectionKind.IndexedCode
    ];

    /// <summary>Returns true when the decoded PMF image carries the complete indexed profile.</summary>
    public static bool IsPresent(PortableModuleImage image) =>
        SectionKinds.All(kind => image.GetSection(kind) is not null);

    internal static IReadOnlyList<IndexedSectionPayload> EncodeSections(Module module) =>
        EncodeSections(module, PortableModuleContracts.Empty);

    internal static IReadOnlyList<IndexedSectionPayload> EncodeSections(
        Module module,
        PortableModuleContracts? contracts)
    {
        ArgumentNullException.ThrowIfNull(module);
        contracts ??= PortableModuleContracts.Empty;

        List<CallableInfo> callables = FlattenCallables(module);
        foreach (CallableInfo callable in callables)
            BuildBindings(callable);

        HashSet<TypeKey> typeKeys = CollectTypes(callables, contracts);
        string[] strings = CollectStrings(typeKeys, contracts);

        var stringIndices = strings
            .Select((value, index) => (value, index))
            .ToDictionary(item => item.value, item => checked((uint)item.index), StringComparer.Ordinal);

        var encodedTypes = typeKeys
            .Select(type => (Type: type, Bytes: EncodeTypeEntry(type, stringIndices)))
            .OrderBy(item => item.Bytes, ByteArrayComparer.Instance)
            .ToArray();
        var typeIndices = encodedTypes
            .Select((item, index) => (item.Type, Index: checked((uint)index)))
            .ToDictionary(item => item.Type, item => item.Index);

        var functionIndices = callables
            .Select((callable, index) => (callable, index))
            .ToDictionary(item => item.callable, item => checked((uint)item.index));
        var topLevel = callables
            .Where(callable => callable.Parent is null)
            .ToDictionary(callable => callable.Name, callable => callable, StringComparer.Ordinal);
        var exportableFunctions = module.Functions
            .ToDictionary(
                function => function.Name,
                function => topLevel[function.Name],
                StringComparer.Ordinal);

        ImportEncoding importEncoding = EncodeImportTable(
            contracts.Imports,
            stringIndices,
            typeIndices);

        using var codeStream = new MemoryStream();
        var functionEntries = new List<FunctionEncoding>(callables.Count);
        foreach (CallableInfo callable in callables)
        {
            uint offset = checked((uint)codeStream.Length);
            byte[] code = EncodeFunction(
                callable,
                typeIndices,
                functionIndices,
                topLevel,
                importEncoding.AliasIndices);
            codeStream.Write(code);
            functionEntries.Add(new FunctionEncoding(callable, offset, checked((uint)code.Length)));
        }

        byte[] stringTable = EncodeStringTable(strings);
        byte[] typeTable = EncodeTypeTable(encodedTypes.Select(item => item.Bytes).ToArray());
        byte[] functionTable = EncodeFunctionTable(functionEntries, typeIndices);
        byte[] exportTable = EncodeExportTable(
            contracts.Exports,
            stringIndices,
            typeIndices,
            functionIndices,
            exportableFunctions);
        byte[] codeSection = codeStream.ToArray();

        return
        [
            new(PortableModuleSectionKind.IndexedStringTable, stringTable),
            new(PortableModuleSectionKind.IndexedTypeTable, typeTable),
            new(PortableModuleSectionKind.IndexedFunctionTable, functionTable),
            new(PortableModuleSectionKind.IndexedImportTable, importEncoding.Table),
            new(PortableModuleSectionKind.IndexedExportTable, exportTable),
            new(PortableModuleSectionKind.IndexedConstantTable, EmptyTable()),
            new(PortableModuleSectionKind.IndexedCode, codeSection)
        ];
    }

    /// <summary>
    /// Verifies the indexed executable section group in a decoded PMF image. If none of the
    /// indexed sections is present this method succeeds without changing the base PMF contract.
    /// </summary>
    public static void Verify(PortableModuleImage image)
    {
        ArgumentNullException.ThrowIfNull(image);
        VerifySections(image.Sections);
    }

    internal static void VerifySections(IReadOnlyList<PortableModuleSection> sections)
    {
        int present = SectionKinds.Count(kind => sections.Any(section => section.Kind == (ushort)kind));
        if (present == 0) return;
        if (present != SectionKinds.Length)
            throw new InvalidDataException("Indexed executable PMF sections 0x0010..0x0016 must be present as a complete group.");

        foreach (PortableModuleSectionKind kind in SectionKinds)
        {
            PortableModuleSection section = sections.Single(item => item.Kind == (ushort)kind);
            if ((section.Flags & PortableModuleSectionFlags.Critical) == 0)
                throw new InvalidDataException($"Indexed executable section 0x{(ushort)kind:X4} must be critical.");
        }

        ReadOnlyMemory<byte> stringsPayload = Required(sections, PortableModuleSectionKind.IndexedStringTable).Payload;
        ReadOnlyMemory<byte> typesPayload = Required(sections, PortableModuleSectionKind.IndexedTypeTable).Payload;
        ReadOnlyMemory<byte> functionsPayload = Required(sections, PortableModuleSectionKind.IndexedFunctionTable).Payload;
        ReadOnlyMemory<byte> importsPayload = Required(sections, PortableModuleSectionKind.IndexedImportTable).Payload;
        ReadOnlyMemory<byte> exportsPayload = Required(sections, PortableModuleSectionKind.IndexedExportTable).Payload;
        ReadOnlyMemory<byte> constantsPayload = Required(sections, PortableModuleSectionKind.IndexedConstantTable).Payload;
        ReadOnlyMemory<byte> codePayload = Required(sections, PortableModuleSectionKind.IndexedCode).Payload;

        List<byte[]> strings = ParseStringTable(stringsPayload.Span);
        List<TypeEntry> types = ParseTypeTable(typesPayload.Span, strings.Count);
        List<FunctionEntry> functions = ParseFunctionTable(functionsPayload.Span, types.Count);
        List<ImportEntry> imports = ParseImportTable(importsPayload.Span, strings, types);
        ParseExportTable(exportsPayload.Span, strings, functions, types);
        ParseConstantTable(constantsPayload.Span);
        VerifyFunctionRanges(functions, codePayload.Length);
        VerifyCode(functions, imports.Count, types, codePayload.Span);
    }

    private static PortableModuleSection Required(
        IReadOnlyList<PortableModuleSection> sections,
        PortableModuleSectionKind kind) =>
        sections.Single(section => section.Kind == (ushort)kind);

    private static List<CallableInfo> FlattenCallables(Module module)
    {
        var result = new List<CallableInfo>();

        void AddFunction(Ubytec.Language.HighLevel.Func function, CallableInfo? parent)
        {
            if (function.Definition is null)
                throw new InvalidDataException($"Function '{function.Name}' has no executable body.");
            var info = new CallableInfo(
                function.Name,
                function.ReturnType,
                function.Arguments,
                function.Locals,
                function.Definition,
                parent);
            result.Add(info);
            parent?.Nested.Add(function.Name, info);
            foreach (Ubytec.Language.HighLevel.Func nested in function.Locals?.Functions ?? [])
                AddFunction(nested, info);
            foreach (Ubytec.Language.HighLevel.Action nested in function.Locals?.Actions ?? [])
                AddAction(nested, info);
        }

        void AddAction(Ubytec.Language.HighLevel.Action action, CallableInfo? parent)
        {
            if (action.Definition is null)
                throw new InvalidDataException($"Action '{action.Name}' has no executable body.");
            var info = new CallableInfo(
                action.Name,
                new UType(PrimitiveType.Void),
                action.Arguments,
                action.Locals,
                action.Definition,
                parent);
            result.Add(info);
            parent?.Nested.Add(action.Name, info);
            foreach (Ubytec.Language.HighLevel.Func nested in action.Locals?.Functions ?? [])
                AddFunction(nested, info);
            foreach (Ubytec.Language.HighLevel.Action nested in action.Locals?.Actions ?? [])
                AddAction(nested, info);
        }

        foreach (Ubytec.Language.HighLevel.Func function in module.Functions)
            AddFunction(function, null);
        foreach (Ubytec.Language.HighLevel.Action action in module.Actions)
            AddAction(action, null);

        var topLevelNames = new HashSet<string>(StringComparer.Ordinal);
        foreach (CallableInfo callable in result.Where(item => item.Parent is null))
            if (!topLevelNames.Add(callable.Name))
                throw new InvalidDataException($"Duplicate top-level callable '{callable.Name}'.");

        return result;
    }

    private static void BuildBindings(CallableInfo callable)
    {
        uint next = 0;
        foreach (Argument argument in callable.Arguments)
            Add(argument.Name, argument.Type, isLocal: false, value: null);

        foreach (Variable variable in callable.Locals?.Variables ?? [])
            Add(variable.Name, variable.Type, isLocal: true, variable.Value);

        foreach (VAR declaration in FunctionEmitter.Instructions(callable.Definition).OfType<VAR>())
            Add(declaration.Variable.Name, declaration.Variable.Type, isLocal: true, declaration.Variable.Value, fromBodyVar: true);

        void Add(string name, UType type, bool isLocal, object? value, bool fromBodyVar = false)
        {
            if (!callable.BindingIndices.TryAdd(name, next))
                throw new InvalidDataException($"Duplicate frame binding '{name}' in '{callable.Name}'.");
            callable.Bindings.Add(new BindingInfo(name, type, next, isLocal, value, fromBodyVar));
            next++;
        }
    }

    private static HashSet<TypeKey> CollectTypes(
        IEnumerable<CallableInfo> callables,
        PortableModuleContracts contracts)
    {
        var result = new HashSet<TypeKey>();
        foreach (CallableInfo callable in callables)
        {
            result.Add(TypeKey.From(callable.ReturnType));
            foreach (Argument argument in callable.Arguments)
                result.Add(TypeKey.From(argument.Type));
            foreach (BindingInfo binding in callable.Bindings.Where(binding => binding.IsLocal))
                result.Add(TypeKey.From(binding.Type));
        }

        foreach (PortableImportContract import in contracts.Imports)
        {
            ValidateBoundaryType(import.ReturnType, allowVoid: true, "import return");
            result.Add(TypeKey.From(import.ReturnType));
            foreach (PortableBoundaryParameter argument in import.Arguments)
            {
                ValidateBoundaryParameter(argument, "import argument");
                result.Add(TypeKey.From(argument.CarrierType));
            }
        }

        foreach (PortableExportContract export in contracts.Exports)
        {
            ValidateBoundaryType(export.ReturnType, allowVoid: true, "export return");
            result.Add(TypeKey.From(export.ReturnType));
            foreach (PortableBoundaryParameter argument in export.Arguments)
            {
                ValidateBoundaryParameter(argument, "export argument");
                result.Add(TypeKey.From(argument.CarrierType));
            }
        }
        return result;
    }

    private static string[] CollectStrings(
        IEnumerable<TypeKey> types,
        PortableModuleContracts contracts)
    {
        var strings = new HashSet<string>(StringComparer.Ordinal);
        foreach (TypeKey type in types.Where(type => type.Primitive == PrimitiveType.CustomType))
            Add(type.Name ?? string.Empty, "custom type name");
        foreach (PortableImportContract import in contracts.Imports)
        {
            Add(import.Module, "import module");
            Add(import.Symbol, "import symbol");
        }
        foreach (PortableExportContract export in contracts.Exports)
            Add(export.Symbol, "export symbol");

        return strings
            .OrderBy(static value => StrictUtf8.GetBytes(value), ByteArrayComparer.Instance)
            .ToArray();

        void Add(string value, string field)
        {
            if (string.IsNullOrEmpty(value))
                throw new InvalidDataException($"Indexed executable {field} must not be empty.");
            strings.Add(value);
        }
    }

    private static ImportEncoding EncodeImportTable(
        IReadOnlyList<PortableImportContract> imports,
        IReadOnlyDictionary<string, uint> stringIndices,
        IReadOnlyDictionary<TypeKey, uint> typeIndices)
    {
        ImportCandidate[] candidates = imports
            .Select(contract => new ImportCandidate(
                contract,
                EncodeImportEntry(contract, stringIndices, typeIndices)))
            .OrderBy(candidate => candidate.Bytes, ByteArrayComparer.Instance)
            .ToArray();

        var entries = new List<byte[]>(candidates.Length);
        var aliasIndices = new Dictionary<string, uint>(StringComparer.Ordinal);

        foreach (ImportCandidate candidate in candidates)
        {
            uint currentIndex = checked((uint)entries.Count);
            entries.Add(candidate.Bytes);
            if (!aliasIndices.TryAdd(candidate.Contract.SourceAlias, currentIndex))
                throw new InvalidDataException($"Duplicate portable import alias '{candidate.Contract.SourceAlias}'.");
        }

        return new ImportEncoding(EncodeEntryTable(entries), aliasIndices);
    }

    private static byte[] EncodeImportEntry(
        PortableImportContract import,
        IReadOnlyDictionary<string, uint> stringIndices,
        IReadOnlyDictionary<TypeKey, uint> typeIndices)
    {
        if (string.IsNullOrEmpty(import.SourceAlias))
            throw new InvalidDataException("Portable import source alias must not be empty.");
        ValidateBoundaryType(import.ReturnType, allowVoid: true, "import return");

        using var stream = new MemoryStream();
        WriteUInt32(stream, StringIndex(import.Module, stringIndices, "import module"));
        WriteUInt32(stream, StringIndex(import.Symbol, stringIndices, "import symbol"));
        WriteUInt32(stream, TypeIndex(import.ReturnType, typeIndices));
        WriteUInt32(stream, checked((uint)import.Arguments.Count));
        foreach (PortableBoundaryParameter argument in import.Arguments)
            EncodeBoundaryParameter(stream, argument, typeIndices, "import argument");
        return stream.ToArray();
    }

    private static byte[] EncodeExportTable(
        IReadOnlyList<PortableExportContract> exports,
        IReadOnlyDictionary<string, uint> stringIndices,
        IReadOnlyDictionary<TypeKey, uint> typeIndices,
        IReadOnlyDictionary<CallableInfo, uint> functionIndices,
        IReadOnlyDictionary<string, CallableInfo> exportableFunctions)
    {
        ExportCandidate[] candidates = exports
            .Select(contract =>
            {
                if (!exportableFunctions.TryGetValue(contract.FunctionName, out CallableInfo? callable))
                    throw new InvalidDataException($"Portable export references unknown top-level function '{contract.FunctionName}'.");
                return new ExportCandidate(
                    contract,
                    StrictUtf8.GetBytes(contract.Symbol),
                    EncodeExportEntry(contract, callable, stringIndices, typeIndices, functionIndices));
            })
            .OrderBy(candidate => candidate.SymbolBytes, ByteArrayComparer.Instance)
            .ToArray();

        byte[]? previousSymbol = null;
        foreach (ExportCandidate candidate in candidates)
        {
            if (candidate.SymbolBytes.Length == 0)
                throw new InvalidDataException("Portable export symbol must not be empty.");
            if (previousSymbol is not null &&
                ByteArrayComparer.Instance.Compare(previousSymbol, candidate.SymbolBytes) >= 0)
                throw new InvalidDataException("Portable export symbols must be unique.");
            previousSymbol = candidate.SymbolBytes;
        }

        return EncodeEntryTable(candidates.Select(candidate => candidate.Bytes).ToArray());
    }

    private static byte[] EncodeExportEntry(
        PortableExportContract export,
        CallableInfo callable,
        IReadOnlyDictionary<string, uint> stringIndices,
        IReadOnlyDictionary<TypeKey, uint> typeIndices,
        IReadOnlyDictionary<CallableInfo, uint> functionIndices)
    {
        ValidateBoundaryType(export.ReturnType, allowVoid: true, "export return");
        uint boundaryReturn = TypeIndex(export.ReturnType, typeIndices);
        uint functionReturn = TypeIndex(callable.ReturnType, typeIndices);
        if (boundaryReturn != functionReturn)
            throw new InvalidDataException($"Portable export '{export.Symbol}' return type does not match '{callable.Name}'.");
        if (export.Arguments.Count != callable.Arguments.Length)
            throw new InvalidDataException($"Portable export '{export.Symbol}' argument count does not match '{callable.Name}'.");

        using var stream = new MemoryStream();
        WriteUInt32(stream, StringIndex(export.Symbol, stringIndices, "export symbol"));
        WriteUInt32(stream, functionIndices[callable]);
        WriteUInt32(stream, boundaryReturn);
        WriteUInt32(stream, checked((uint)export.Arguments.Count));
        for (int index = 0; index < export.Arguments.Count; index++)
        {
            PortableBoundaryParameter argument = export.Arguments[index];
            ValidateBoundaryParameter(argument, "export argument");
            uint carrier = TypeIndex(argument.CarrierType, typeIndices);
            uint internalType = TypeIndex(callable.Arguments[index].Type, typeIndices);
            if (carrier != internalType)
                throw new InvalidDataException(
                    $"Portable export '{export.Symbol}' argument {index} does not match '{callable.Name}'.");
            stream.WriteByte((byte)argument.PassingMode);
            WriteUInt32(stream, carrier);
        }
        return stream.ToArray();
    }

    private static byte[] EncodeFunction(
        CallableInfo callable,
        IReadOnlyDictionary<TypeKey, uint> typeIndices,
        IReadOnlyDictionary<CallableInfo, uint> functionIndices,
        IReadOnlyDictionary<string, CallableInfo> topLevel,
        IReadOnlyDictionary<string, uint> importIndices)
    {
        using var stream = new MemoryStream();

        foreach (BindingInfo local in callable.Bindings.Where(binding => binding.IsLocal && !binding.FromBodyVar))
        {
            stream.WriteByte(VAR_OPCODE);
            WriteUInt32(stream, local.Index);
            WriteUInt64(stream, unchecked((ulong)FunctionCode.InitialValue(local.Type, local.InitialValue)));
        }

        foreach (IOpCode operation in FunctionEmitter.Instructions(callable.Definition))
            EncodeInstruction(stream, operation, callable, typeIndices, functionIndices, topLevel, importIndices);

        return stream.ToArray();
    }

    private static void EncodeInstruction(
        Stream stream,
        IOpCode operation,
        CallableInfo callable,
        IReadOnlyDictionary<TypeKey, uint> typeIndices,
        IReadOnlyDictionary<CallableInfo, uint> functionIndices,
        IReadOnlyDictionary<string, CallableInfo> topLevel,
        IReadOnlyDictionary<string, uint> importIndices)
    {
        if (operation is IExtendedOpCode extended)
            throw new NotSupportedException(
                $"Indexed executable v0 reference lowering does not yet define operands for extended opcode " +
                $"depth={extended.EscapeDepth}, group=0x{extended.ExtensionGroup:X2}, opcode=0x{extended.ExtendedOpCode:X2}.");

        switch (operation)
        {
            case RETURN ret:
                if (ret.Variables is not null)
                    throw Unsupported(operation, "RETURN expression metadata has no portable v0 wire contract");
                stream.WriteByte(RETURN.OP);
                if (ret.BlockType is null)
                {
                    stream.WriteByte(0);
                }
                else
                {
                    stream.WriteByte(1);
                    WriteUInt32(stream, TypeIndex(ret.BlockType.Value, typeIndices));
                }
                return;

            case VAR declaration:
                stream.WriteByte(VAR_OPCODE);
                WriteUInt32(stream, BindingIndex(callable, declaration.Variable.Name));
                WriteUInt64(stream, unchecked((ulong)FunctionCode.InitialValue(
                    declaration.Variable.Type,
                    declaration.Variable.Value)));
                return;

            case StackOperations.PUSH push:
                if (push.operands.Length is < 1 or > 8)
                    throw new InvalidDataException("PUSH portable immediate must contain 1..8 bytes.");
                stream.WriteByte(StackOperations.PUSH.OP);
                stream.WriteByte(checked((byte)push.operands.Length));
                stream.Write(push.operands);
                return;

            case StackOperations.DROP drop:
                stream.WriteByte(StackOperations.DROP.OP);
                stream.WriteByte(drop.stackIndex);
                return;

            case StackOperations.PICK pick:
                stream.WriteByte(StackOperations.PICK.OP);
                stream.WriteByte(pick.n);
                return;

            case StackOperations.ROLL roll:
                stream.WriteByte(StackOperations.ROLL.OP);
                stream.WriteByte(roll.n);
                return;

            case FunctionOperations.CALL call:
                stream.WriteByte(FunctionOperations.CALL.OP);
                if (TryResolveCallable(callable, call.FunctionName, topLevel, out CallableInfo target))
                {
                    stream.WriteByte(0);
                    WriteUInt32(stream, functionIndices[target]);
                    return;
                }
                if (importIndices.TryGetValue(call.FunctionName, out uint importIndex))
                {
                    stream.WriteByte(1);
                    WriteUInt32(stream, importIndex);
                    return;
                }
                throw new NotSupportedException($"CALL target '{call.FunctionName}' is neither a local function nor a portable import.");

            case FunctionOperations.FNADDR address:
                stream.WriteByte(FunctionOperations.FNADDR.OP);
                if (TryResolveCallable(callable, address.FunctionName, topLevel, out CallableInfo addressTarget))
                {
                    WriteUInt32(stream, functionIndices[addressTarget]);
                    return;
                }
                if (importIndices.ContainsKey(address.FunctionName))
                    throw new NotSupportedException("FNADDR cannot target a portable import in indexed executable v0.");
                throw new NotSupportedException($"FNADDR target '{address.FunctionName}' is not an indexed local function.");

            case FunctionOperations.CALLI indirect:
                indirect.Validate();
                stream.WriteByte(FunctionOperations.CALLI.OP);
                stream.WriteByte(checked((byte)indirect.ArgumentCount));
                stream.WriteByte((byte)indirect.ReturnType);
                return;

            case MemoryOperations.LOAD load:
                EncodeMemory(stream, MemoryOperations.LOAD.OP, load.VariableName, load.AccessType, callable);
                return;

            case MemoryOperations.STORE store:
                EncodeMemory(stream, MemoryOperations.STORE.OP, store.VariableName, store.AccessType, callable);
                return;

            default:
                if (IsOperandFreeCore(operation))
                {
                    stream.WriteByte(operation.OpCode);
                    return;
                }
                throw Unsupported(operation, "opcode has semantic fields but no indexed executable v0 operand contract");
        }
    }

    private static void EncodeMemory(
        Stream stream,
        byte opcode,
        string? variableName,
        PrimitiveType? accessType,
        CallableInfo callable)
    {
        stream.WriteByte(opcode);
        if (variableName is not null)
        {
            if (accessType is not null)
                throw new InvalidDataException("Named LOAD/STORE cannot also carry a raw access type.");
            stream.WriteByte(2);
            WriteUInt32(stream, BindingIndex(callable, variableName));
            return;
        }

        if (accessType is null)
        {
            stream.WriteByte(0);
            return;
        }

        var type = new UType(accessType.Value);
        if (!FunctionCode.IsCellType(type))
            throw new InvalidDataException($"Raw memory access type {accessType} is not a supported scalar cell type.");
        stream.WriteByte(1);
        stream.WriteByte((byte)accessType.Value);
    }

    private static bool TryResolveCallable(
        CallableInfo current,
        string name,
        IReadOnlyDictionary<string, CallableInfo> topLevel,
        out CallableInfo target)
    {
        if (string.Equals(current.Name, name, StringComparison.Ordinal))
        {
            target = current;
            return true;
        }

        for (CallableInfo? scope = current; scope is not null; scope = scope.Parent)
        {
            if (scope.Nested.TryGetValue(name, out CallableInfo? nested))
            {
                target = nested;
                return true;
            }
        }

        if (topLevel.TryGetValue(name, out CallableInfo? top))
        {
            target = top;
            return true;
        }

        target = null!;
        return false;
    }

    private static uint BindingIndex(CallableInfo callable, string name) =>
        callable.BindingIndices.TryGetValue(name, out uint index)
            ? index
            : throw new InvalidDataException($"Unknown frame binding '{name}' in '{callable.Name}'.");

    private static uint StringIndex(
        string value,
        IReadOnlyDictionary<string, uint> stringIndices,
        string field) =>
        stringIndices.TryGetValue(value, out uint index)
            ? index
            : throw new InvalidDataException($"{field} '{value}' is missing from the indexed string table.");

    private static uint TypeIndex(UType type, IReadOnlyDictionary<TypeKey, uint> typeIndices) =>
        typeIndices.TryGetValue(TypeKey.From(type), out uint index)
            ? index
            : throw new InvalidDataException($"Type '{type}' is missing from the indexed type table.");

    private static uint TypeIndex(PrimitiveType type, IReadOnlyDictionary<TypeKey, uint> typeIndices) =>
        typeIndices.TryGetValue(TypeKey.From(type), out uint index)
            ? index
            : throw new InvalidDataException($"Boundary type '{type}' is missing from the indexed type table.");

    private static NotSupportedException Unsupported(IOpCode operation, string reason) =>
        new($"Opcode 0x{operation.OpCode:X2} ({operation.GetType().Name}) cannot be lowered: {reason}.");

    private static bool IsOperandFreeCore(IOpCode operation) =>
        operation.OpCode != 0xFF && OperandFreeCoreOpcodes.Contains(operation.OpCode);

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
        result.Remove(VAR_OPCODE);
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

    private static byte[] EncodeTypeTable(IReadOnlyList<byte[]> entries)
    {
        using var stream = new MemoryStream();
        WriteUInt32(stream, checked((uint)entries.Count));
        foreach (byte[] entry in entries)
            stream.Write(entry);
        return stream.ToArray();
    }

    private static byte[] EncodeFunctionTable(
        IReadOnlyList<FunctionEncoding> functions,
        IReadOnlyDictionary<TypeKey, uint> typeIndices)
    {
        using var stream = new MemoryStream();
        WriteUInt32(stream, checked((uint)functions.Count));
        foreach (FunctionEncoding encoded in functions)
        {
            CallableInfo function = encoded.Callable;
            BindingInfo[] locals = function.Bindings.Where(binding => binding.IsLocal).ToArray();
            WriteUInt32(stream, TypeIndex(function.ReturnType, typeIndices));
            WriteUInt32(stream, checked((uint)function.Arguments.Length));
            WriteUInt32(stream, checked((uint)locals.Length));
            WriteUInt32(stream, encoded.CodeOffset);
            WriteUInt32(stream, encoded.CodeLength);
            WriteUInt32(stream, 0);
            foreach (Argument argument in function.Arguments)
                WriteUInt32(stream, TypeIndex(argument.Type, typeIndices));
            foreach (BindingInfo local in locals)
                WriteUInt32(stream, TypeIndex(local.Type, typeIndices));
        }
        return stream.ToArray();
    }

    private static byte[] EncodeTypeEntry(TypeKey type, IReadOnlyDictionary<string, uint> stringIndices)
    {
        byte[] entry = new byte[25];
        entry[0] = (byte)type.Primitive;
        BinaryPrimitives.WriteUInt32LittleEndian(entry.AsSpan(1, 4), unchecked((uint)type.Modifiers));
        BinaryPrimitives.WriteUInt64LittleEndian(entry.AsSpan(5, 8), type.FixedArraySize);
        uint nameIndex = type.Primitive == PrimitiveType.CustomType
            ? stringIndices[type.Name ?? string.Empty]
            : NoIndex;
        BinaryPrimitives.WriteUInt32LittleEndian(entry.AsSpan(13, 4), nameIndex);
        return entry;
    }

    private static byte[] EncodeEntryTable(IReadOnlyList<byte[]> entries)
    {
        using var stream = new MemoryStream();
        WriteUInt32(stream, checked((uint)entries.Count));
        foreach (byte[] entry in entries)
            stream.Write(entry);
        return stream.ToArray();
    }

    private static byte[] EmptyTable() => EncodeEntryTable([]);

    private static void EncodeBoundaryParameter(
        Stream stream,
        PortableBoundaryParameter parameter,
        IReadOnlyDictionary<TypeKey, uint> typeIndices,
        string field)
    {
        ValidateBoundaryParameter(parameter, field);
        stream.WriteByte((byte)parameter.PassingMode);
        WriteUInt32(stream, TypeIndex(parameter.CarrierType, typeIndices));
    }

    private static void ValidateBoundaryParameter(PortableBoundaryParameter parameter, string field)
    {
        if (!Enum.IsDefined(typeof(PortablePassingMode), parameter.PassingMode))
            throw new InvalidDataException($"{field} uses an undefined passing mode.");
        ValidateBoundaryType(parameter.CarrierType, allowVoid: false, field);
        if ((parameter.PassingMode is PortablePassingMode.LoanRead or PortablePassingMode.LoanWrite) &&
            parameter.CarrierType != PrimitiveType.UInt64)
            throw new InvalidDataException($"{field} loan passing modes require a UInt64 carrier.");
    }

    private static void ValidateBoundaryType(PrimitiveType type, bool allowVoid, string field)
    {
        bool supported = type is PrimitiveType.Byte or PrimitiveType.UInt32 or PrimitiveType.Int32 or
            PrimitiveType.UInt64 or PrimitiveType.Int64 || (allowVoid && type == PrimitiveType.Void);
        if (!supported)
            throw new InvalidDataException($"{field} uses unsupported portable carrier type '{type}'.");
    }

    private static List<byte[]> ParseStringTable(ReadOnlySpan<byte> payload)
    {
        var reader = new SpanReader(payload);
        uint count = reader.ReadUInt32("String table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("String table entry count is too large.");
        var result = new List<byte[]>(checked((int)count));
        byte[]? previous = null;
        for (uint i = 0; i < count; i++)
        {
            uint rawLength = reader.ReadUInt32("String byte length");
            if (rawLength > int.MaxValue)
                throw new InvalidDataException("Indexed string is too large.");
            byte[] bytes = reader.ReadBytes(checked((int)rawLength), "Indexed string").ToArray();
            string value;
            try
            {
                value = StrictUtf8.GetString(bytes);
            }
            catch (DecoderFallbackException error)
            {
                throw new InvalidDataException("Indexed string is not valid UTF-8.", error);
            }
            if (value.Length != 0 && value[0] == '\uFEFF')
                throw new InvalidDataException("Indexed string must not contain a BOM.");
            if (previous is not null && ByteArrayComparer.Instance.Compare(previous, bytes) >= 0)
                throw new InvalidDataException("Indexed strings must be unique and sorted by UTF-8 bytes.");
            previous = bytes;
            result.Add(bytes);
        }
        reader.RequireEnd("String table");
        return result;
    }

    private static List<TypeEntry> ParseTypeTable(ReadOnlySpan<byte> payload, int stringCount)
    {
        var reader = new SpanReader(payload);
        uint count = reader.ReadUInt32("Type table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("Type table entry count is too large.");
        var result = new List<TypeEntry>(checked((int)count));
        byte[]? previous = null;
        for (uint i = 0; i < count; i++)
        {
            int start = reader.Position;
            byte primitiveRaw = reader.ReadByte("Primitive type");
            if (!Enum.IsDefined(typeof(PrimitiveType), (PrimitiveType)primitiveRaw))
                throw new InvalidDataException($"Undefined primitive type 0x{primitiveRaw:X2} in indexed type table.");
            var primitive = (PrimitiveType)primitiveRaw;
            uint modifiers = reader.ReadUInt32("Type modifiers");
            ulong fixedSize = reader.ReadUInt64("Fixed array size");
            uint nameIndex = reader.ReadUInt32("Type name string index");
            ulong reserved = reader.ReadUInt64("Type reserved bytes");
            if (reserved != 0)
                throw new InvalidDataException("Indexed type reserved bytes must be zero.");
            if (primitive == PrimitiveType.CustomType)
            {
                if (nameIndex >= stringCount)
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
        var reader = new SpanReader(payload);
        uint count = reader.ReadUInt32("Function table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("Function table entry count is too large.");
        var result = new List<FunctionEntry>(checked((int)count));
        for (uint i = 0; i < count; i++)
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

            var argumentTypes = new uint[checked((int)argumentCount)];
            var localTypes = new uint[checked((int)localCount)];
            for (int argument = 0; argument < argumentTypes.Length; argument++)
            {
                argumentTypes[argument] = reader.ReadUInt32("Function argument TypeIndex");
                RequireIndex(argumentTypes[argument], typeCount, "Function argument TypeIndex");
            }
            for (int local = 0; local < localTypes.Length; local++)
            {
                localTypes[local] = reader.ReadUInt32("Function local TypeIndex");
                RequireIndex(localTypes[local], typeCount, "Function local TypeIndex");
            }

            result.Add(new FunctionEntry(
                returnType,
                argumentCount,
                localCount,
                codeOffset,
                codeLength,
                argumentTypes,
                localTypes));
        }
        reader.RequireEnd("Function table");
        return result;
    }

    private static List<ImportEntry> ParseImportTable(
        ReadOnlySpan<byte> payload,
        IReadOnlyList<byte[]> strings,
        IReadOnlyList<TypeEntry> types)
    {
        var reader = new SpanReader(payload);
        uint count = reader.ReadUInt32("Import table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("Import table entry count is too large.");
        var result = new List<ImportEntry>(checked((int)count));
        byte[]? previous = null;
        for (uint i = 0; i < count; i++)
        {
            int start = reader.Position;
            uint module = reader.ReadUInt32("Import module StringIndex");
            uint symbol = reader.ReadUInt32("Import symbol StringIndex");
            uint returnType = reader.ReadUInt32("Import return TypeIndex");
            RequireNonEmptyString(module, strings, "Import module StringIndex");
            RequireNonEmptyString(symbol, strings, "Import symbol StringIndex");
            RequireBoundaryReturnType(returnType, types, "Import return TypeIndex");
            uint arguments = reader.ReadUInt32("Import argument count");
            if (arguments > int.MaxValue)
                throw new InvalidDataException("Import argument count is too large.");
            var parameters = new BoundaryDescriptor[checked((int)arguments)];
            for (int argument = 0; argument < parameters.Length; argument++)
                parameters[argument] = ReadBoundaryDescriptor(ref reader, types, "Import argument");
            byte[] encoded = reader.CopyRange(start, reader.Position - start);
            if (previous is not null && ByteArrayComparer.Instance.Compare(previous, encoded) > 0)
                throw new InvalidDataException("Imports must be sorted by their encoded bytes; equal rows remain distinct authority slots.");
            previous = encoded;
            result.Add(new ImportEntry(module, symbol, returnType, parameters));
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
        var reader = new SpanReader(payload);
        uint count = reader.ReadUInt32("Export table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("Export table entry count is too large.");
        byte[]? previousName = null;
        for (uint i = 0; i < count; i++)
        {
            uint symbol = reader.ReadUInt32("Export symbol StringIndex");
            RequireNonEmptyString(symbol, strings, "Export symbol StringIndex");
            uint functionIndex = reader.ReadUInt32("Export FunctionIndex");
            RequireIndex(functionIndex, functions.Count, "Export FunctionIndex");
            uint returnType = reader.ReadUInt32("Export return TypeIndex");
            RequireBoundaryReturnType(returnType, types, "Export return TypeIndex");
            uint arguments = reader.ReadUInt32("Export argument count");
            if (arguments > int.MaxValue)
                throw new InvalidDataException("Export argument count is too large.");

            FunctionEntry function = functions[checked((int)functionIndex)];
            if (returnType != function.ReturnType)
                throw new InvalidDataException("Export return TypeIndex must match its FunctionIndex signature.");
            if (arguments != function.ArgumentCount)
                throw new InvalidDataException("Export argument count must match its FunctionIndex signature.");

            for (int argument = 0; argument < checked((int)arguments); argument++)
            {
                BoundaryDescriptor descriptor = ReadBoundaryDescriptor(ref reader, types, "Export argument");
                if (descriptor.TypeIndex != function.ArgumentTypes[argument])
                    throw new InvalidDataException("Export argument carrier TypeIndex must match its FunctionIndex signature.");
            }

            byte[] name = strings[checked((int)symbol)];
            if (previousName is not null && ByteArrayComparer.Instance.Compare(previousName, name) >= 0)
                throw new InvalidDataException("Export names must be unique and sorted by UTF-8 bytes.");
            previousName = name;
        }
        reader.RequireEnd("Export table");
    }

    private static BoundaryDescriptor ReadBoundaryDescriptor(
        ref SpanReader reader,
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
        if (type.Modifiers != 0 || type.FixedArraySize != 0 ||
            type.Primitive is not (PrimitiveType.Void or PrimitiveType.Byte or PrimitiveType.UInt32 or
                PrimitiveType.Int32 or PrimitiveType.UInt64 or PrimitiveType.Int64))
            throw new InvalidDataException($"{field} is not a supported portable boundary return type.");
    }

    private static void RequireBoundaryCarrierType(TypeEntry type, string field)
    {
        if (type.Modifiers != 0 || type.FixedArraySize != 0 ||
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
        var reader = new SpanReader(payload);
        uint count = reader.ReadUInt32("Constant table entry count");
        if (count > int.MaxValue)
            throw new InvalidDataException("Constant table entry count is too large.");
        byte[]? previous = null;
        int previousLength = -1;
        for (uint i = 0; i < count; i++)
        {
            uint rawLength = reader.ReadUInt32("Constant byte length");
            if (rawLength > int.MaxValue)
                throw new InvalidDataException("Indexed constant is too large.");
            byte[] bytes = reader.ReadBytes(checked((int)rawLength), "Indexed constant").ToArray();
            if (previous is not null &&
                (bytes.Length < previousLength ||
                 (bytes.Length == previousLength && ByteArrayComparer.Instance.Compare(previous, bytes) >= 0)))
                throw new InvalidDataException("Constants must be unique and sorted by length then payload bytes.");
            previous = bytes;
            previousLength = bytes.Length;
        }
        reader.RequireEnd("Constant table");
    }

    private static void VerifyFunctionRanges(IReadOnlyList<FunctionEntry> functions, int codeLength)
    {
        ulong expectedOffset = 0;
        foreach (FunctionEntry function in functions)
        {
            if (function.CodeOffset != expectedOffset)
                throw new InvalidDataException("Indexed function code ranges must be consecutively packed in FunctionIndex order.");
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
        int importCount,
        IReadOnlyList<TypeEntry> types,
        ReadOnlySpan<byte> code)
    {
        for (int functionIndex = 0; functionIndex < functions.Count; functionIndex++)
        {
            FunctionEntry function = functions[functionIndex];
            ReadOnlySpan<byte> body = code.Slice(checked((int)function.CodeOffset), checked((int)function.CodeLength));
            var reader = new SpanReader(body);
            ulong bindingCount = (ulong)function.ArgumentCount + function.LocalCount;

            while (!reader.AtEnd)
            {
                byte opcode = reader.ReadByte("Opcode");
                if (opcode == 0xFF)
                {
                    int depth = 1;
                    while (!reader.AtEnd && reader.PeekByte() == 0xFF)
                    {
                        reader.ReadByte("Opcode escape");
                        depth++;
                    }
                    byte group = reader.ReadByte("Extended opcode group");
                    byte extendedOpcode = reader.ReadByte("Extended opcode number");
                    if (group == 0xFF || extendedOpcode == 0xFF)
                        throw new InvalidDataException("0xFF is reserved in extended opcode group/code positions.");
                    throw new NotSupportedException(
                        $"Indexed executable v0 reference verifier does not yet support extended opcode " +
                        $"depth={depth}, group=0x{group:X2}, opcode=0x{extendedOpcode:X2}.");
                }

                switch (opcode)
                {
                    case RETURN.OP:
                    {
                        byte mode = reader.ReadByte("RETURN mode");
                        if (mode == 0) break;
                        if (mode != 1)
                            throw new InvalidDataException($"Unknown RETURN mode {mode}.");
                        uint typeIndex = reader.ReadUInt32("RETURN TypeIndex");
                        RequireIndex(typeIndex, types.Count, "RETURN TypeIndex");
                        if (typeIndex != function.ReturnType)
                            throw new InvalidDataException("Explicit RETURN TypeIndex must match the enclosing function return type.");
                        break;
                    }

                    case VAR_OPCODE:
                    {
                        uint binding = reader.ReadUInt32("VAR BindingIndex");
                        if (binding >= bindingCount)
                            throw new InvalidDataException("VAR BindingIndex is outside the current function frame.");
                        _ = reader.ReadUInt64("VAR initial cell");
                        break;
                    }

                    case StackOperations.PUSH.OP:
                    {
                        byte length = reader.ReadByte("PUSH byte count");
                        if (length is < 1 or > 8)
                            throw new InvalidDataException("PUSH portable immediate must contain 1..8 bytes.");
                        _ = reader.ReadBytes(length, "PUSH immediate");
                        break;
                    }

                    case StackOperations.DROP.OP:
                    case StackOperations.PICK.OP:
                    case StackOperations.ROLL.OP:
                        _ = reader.ReadByte("Stack index");
                        break;

                    case FunctionOperations.CALL.OP:
                    {
                        byte targetKind = reader.ReadByte("CALL target kind");
                        uint targetIndex = reader.ReadUInt32("CALL target index");
                        switch (targetKind)
                        {
                            case 0:
                                RequireIndex(targetIndex, functions.Count, "CALL FunctionIndex");
                                break;
                            case 1:
                                RequireIndex(targetIndex, importCount, "CALL ImportIndex");
                                break;
                            default:
                                throw new InvalidDataException($"CALL uses reserved TargetKind 0x{targetKind:X2}.");
                        }
                        break;
                    }

                    case FunctionOperations.FNADDR.OP:
                        RequireIndex(reader.ReadUInt32("FunctionIndex"), functions.Count, "FunctionIndex");
                        break;

                    case FunctionOperations.CALLI.OP:
                    {
                        _ = reader.ReadByte("CALLI argument count");
                        byte returnType = reader.ReadByte("CALLI return primitive type");
                        if (!Enum.IsDefined(typeof(PrimitiveType), (PrimitiveType)returnType))
                            throw new InvalidDataException($"CALLI uses undefined primitive return type 0x{returnType:X2}.");
                        var type = new UType((PrimitiveType)returnType);
                        if (type.Type != PrimitiveType.Void && !FunctionCode.IsCellType(type))
                            throw new InvalidDataException("CALLI return type is not void or a scalar cell type.");
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
                                byte primitive = reader.ReadByte("LOAD/STORE primitive type");
                                if (!Enum.IsDefined(typeof(PrimitiveType), (PrimitiveType)primitive) ||
                                    !FunctionCode.IsCellType(new UType((PrimitiveType)primitive)))
                                    throw new InvalidDataException("LOAD/STORE raw type is not a supported scalar cell type.");
                                break;
                            }
                            case 2:
                            {
                                uint binding = reader.ReadUInt32("LOAD/STORE BindingIndex");
                                if (binding >= bindingCount)
                                    throw new InvalidDataException("LOAD/STORE BindingIndex is outside the current function frame.");
                                break;
                            }
                            default:
                                throw new InvalidDataException($"Unknown LOAD/STORE mode {mode}.");
                        }
                        break;
                    }

                    default:
                        if (!OperandFreeCoreOpcodes.Contains(opcode))
                            throw new InvalidDataException($"Core opcode 0x{opcode:X2} has no supported indexed executable v0 wire contract.");
                        break;
                }
            }

            reader.RequireEnd($"Function {functionIndex} code");
        }
    }

    private static void RequireIndex(uint index, int count, string name)
    {
        if (index >= (uint)count)
            throw new InvalidDataException($"{name} {index} is outside table size {count}.");
    }

    private static void WriteUInt32(Stream stream, uint value)
    {
        Span<byte> bytes = stackalloc byte[4];
        BinaryPrimitives.WriteUInt32LittleEndian(bytes, value);
        stream.Write(bytes);
    }

    private static void WriteUInt64(Stream stream, ulong value)
    {
        Span<byte> bytes = stackalloc byte[8];
        BinaryPrimitives.WriteUInt64LittleEndian(bytes, value);
        stream.Write(bytes);
    }

    private const byte VAR_OPCODE = 0x10;

    internal sealed record IndexedSectionPayload(PortableModuleSectionKind Kind, byte[] Payload);

    private sealed class CallableInfo(
        string name,
        UType returnType,
        Argument[] arguments,
        LocalContext? locals,
        SyntaxSentence definition,
        CallableInfo? parent)
    {
        internal string Name { get; } = name;
        internal UType ReturnType { get; } = returnType;
        internal Argument[] Arguments { get; } = arguments;
        internal LocalContext? Locals { get; } = locals;
        internal SyntaxSentence Definition { get; } = definition;
        internal CallableInfo? Parent { get; } = parent;
        internal Dictionary<string, CallableInfo> Nested { get; } = new(StringComparer.Ordinal);
        internal Dictionary<string, uint> BindingIndices { get; } = new(StringComparer.Ordinal);
        internal List<BindingInfo> Bindings { get; } = [];
    }

    private sealed record BindingInfo(
        string Name,
        UType Type,
        uint Index,
        bool IsLocal,
        object? InitialValue,
        bool FromBodyVar);

    private sealed record ImportCandidate(PortableImportContract Contract, byte[] Bytes);

    private sealed record ImportEncoding(
        byte[] Table,
        IReadOnlyDictionary<string, uint> AliasIndices);

    private sealed record ExportCandidate(
        PortableExportContract Contract,
        byte[] SymbolBytes,
        byte[] Bytes);

    private readonly record struct FunctionEncoding(CallableInfo Callable, uint CodeOffset, uint CodeLength);

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

    private readonly record struct TypeKey(
        PrimitiveType Primitive,
        TypeModifiers Modifiers,
        ulong FixedArraySize,
        string? Name)
    {
        internal static TypeKey From(UType type) => new(
            type.Type,
            type.Modifiers,
            type.FixedArraySize,
            type.Type == PrimitiveType.CustomType ? type.Name : null);

        internal static TypeKey From(PrimitiveType type) => new(
            type,
            TypeModifiers.None,
            0,
            null);
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

    private ref struct SpanReader(ReadOnlySpan<byte> data)
    {
        private readonly ReadOnlySpan<byte> _data = data;
        private int _position;

        internal int Position => _position;
        internal bool AtEnd => _position == _data.Length;

        internal byte PeekByte()
        {
            if (_position >= _data.Length)
                throw new InvalidDataException("Indexed executable payload is truncated.");
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
                throw new InvalidDataException("Indexed executable range is invalid.");
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
