using System.Reflection;
using System.Text;
using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Extended;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Portable;

/// <summary>
/// Linux x86-64 NASM emitted from the typed portable binary model. Labels are index-derived and
/// therefore do not depend on source names, parser objects, or AST identity.
/// </summary>
public sealed record PortableX64Compilation(
    string Assembly,
    IReadOnlyList<string> FunctionLabels,
    IReadOnlyList<string> ImportLabels,
    IReadOnlyList<string> ExportLabels)
{
    /// <summary>Returns the native label assigned to one portable FunctionIndex.</summary>
    public string GetFunctionLabel(int index) => FunctionLabels[index];

    /// <summary>Returns the unresolved native symbol assigned to one portable ImportIndex.</summary>
    public string GetImportLabel(int index) => ImportLabels[index];

    /// <summary>Returns the object-local native alias assigned to one portable ExportIndex.</summary>
    public string GetExportLabel(int index) => ExportLabels[index];
}

/// <summary>
/// Reference x64 backend for indexed Portable Module Format v0.
///
/// The backend consumes only verified portable bytes or <see cref="PortableBinaryModule"/>. It does
/// not inspect source text, <c>SourceCompilation</c>, parser state, or AST entities. Portable imports
/// remain unresolved external symbols keyed by ImportIndex; native binding is a later loader/linker
/// responsibility.
/// </summary>
public static class PortableX64Backend
{
    private static readonly IReadOnlyDictionary<byte, Type> OperandFreeOperations =
        DiscoverOperandFreeOperations();

    /// <summary>Verifies, decodes, and compiles canonical UBCM bytes to Linux x86-64 NASM.</summary>
    public static PortableX64Compilation Compile(ReadOnlySpan<byte> bytes, bool optimizeTailCalls = false)
    {
        PortableBinaryVerifier.Verify(bytes);
        return Compile(PortableBinaryCodec.Decode(bytes), optimizeTailCalls);
    }

    /// <summary>Compiles a typed portable module to Linux x86-64 NASM.</summary>
    public static PortableX64Compilation Compile(PortableBinaryModule module, bool optimizeTailCalls = false)
    {
        ArgumentNullException.ThrowIfNull(module);
        if (module.Executable is not { } executable)
            throw new NotSupportedException("x64 code generation requires the indexed executable PMF profile.");

        // Re-encoding validates caller-constructed typed models without consulting source state.
        byte[] canonical = PortableBinaryCodec.Encode(module);
        PortableBinaryVerifier.Verify(canonical);
        // Emit from a private decoded snapshot of the exact verified bytes, not mutable
        // caller-owned instruction/array objects.
        executable = PortableBinaryCodec.Decode(canonical).Executable!;
        if (executable.Contexts.Restricted && optimizeTailCalls)
            throw new InvalidDataException("Restricted profiles do not permit frame-reusing tail calls.");
        int dispatchBudget = 65536;

        string[] functionLabels = Enumerable.Range(0, executable.Functions.Count)
            .Select(FunctionLabel)
            .ToArray();
        string[] importLabels = Enumerable.Range(0, executable.Imports.Count)
            .Select(ImportLabel)
            .ToArray();
        string[] exportLabels = Enumerable.Range(0, executable.Exports.Count)
            .Select(ExportLabel)
            .ToArray();

        var moduleScope = BuildModuleScope(executable, functionLabels, importLabels);
        var output = new StringBuilder();
        output.AppendLine("bits 64");
        output.AppendLine("default rel");
        output.AppendLine("section .text");
        foreach (string import in importLabels)
            output.AppendLine($"extern {import}");

        for (int index = 0; index < executable.Functions.Count; index++)
            EmitFunction(output, executable, index, functionLabels, moduleScope, optimizeTailCalls, ref dispatchBudget);

        for (int index = 0; index < executable.Exports.Count; index++)
        {
            PortableExecutableExport export = executable.Exports[index];
            string alias = exportLabels[index];
            string target = functionLabels[checked((int)export.FunctionIndex)];
            // ExportIndex is module-local. Only the ABI projection may publish host-facing symbols.
            // Keeping this alias local allows independently assembled objects to share indices.
            output.AppendLine($"{alias}:");
            output.AppendLine($"  jmp {target}");
        }

        output.AppendLine("section .note.GNU-stack noalloc noexec nowrite progbits");
        return new PortableX64Compilation(
            output.ToString().ReplaceLineEndings("\n"),
            functionLabels,
            importLabels,
            exportLabels);
    }

    private static ScopeContext BuildModuleScope(
        PortableExecutableModule executable,
        IReadOnlyList<string> functionLabels,
        IReadOnlyList<string> importLabels)
    {
        var scope = new ScopeContext
        {
            StartLabel = "ubytec_binary_module_start",
            EndLabel = "ubytec_binary_module_end",
            DeclaredByKeyword = "module"
        };

        for (int index = 0; index < executable.Functions.Count; index++)
        {
            PortableExecutableFunction function = executable.Functions[index];
            scope.Callables.Add(
                FunctionName(index),
                new CallableBinding(
                    FunctionName(index),
                    functionLabels[index],
                    function.ArgumentTypeIndices.Count,
                    ResolveType(executable, function.ReturnTypeIndex)));
        }

        for (int index = 0; index < executable.Imports.Count; index++)
        {
            PortableExecutableImport import = executable.Imports[index];
            scope.Callables.Add(
                ImportName(index),
                new CallableBinding(
                    ImportName(index),
                    importLabels[index],
                    ImportCallCellCount(executable, import),
                    new UType(PrimitiveType.Int64)));
        }

        return scope;
    }

    private static void EmitFunction(
        StringBuilder output,
        PortableExecutableModule executable,
        int functionIndex,
        IReadOnlyList<string> functionLabels,
        ScopeContext moduleScope,
        bool optimizeTailCalls,
        ref int dispatchBudget)
    {
        PortableExecutableFunction function = executable.Functions[functionIndex];
        UType returnType = ResolveType(executable, function.ReturnTypeIndex);
        if (returnType.Type != PrimitiveType.Void && !FunctionCode.IsCellType(returnType))
            throw new NotSupportedException($"FunctionIndex {functionIndex} return type is not supported by the x64 cell ABI.");

        string label = functionLabels[functionIndex];
        int slotCount = executable.CallableSlots?.Banks[functionIndex].Count ?? 0;
        int switchCount = function.Instructions.Count(instruction => instruction.OpCode == SWITCH.OP);
        // Scalar bindings keep their original offsets. The callable bank sits below all
        // locals, above the evaluation-stack baseline and has no BindingIndex.
        int localCount = function.LocalTypeIndices.Count;
        uint[] bindTargets = function.Instructions.OfType<PortableCallableInstruction>()
            .Where(instruction => instruction.Operation == 0)
            .Select(instruction => instruction.Second!.Value).Distinct().OrderBy(target => target).ToArray();
        if (bindTargets.Length > 256)
            throw new NotSupportedException("CallableLocal x64 supports at most 256 distinct bind targets per function.");
        var frame = new ScopeContext
        {
            StartLabel = label,
            EndLabel = label + "__end",
            DeclaredByKeyword = "func",
            ExpectedReturnType = returnType,
            ArgumentCount = function.ArgumentTypeIndices.Count,
            FrameSize = Align16(checked((localCount + slotCount + switchCount) * 8))
        };
        frame.Callables.Add(
            FunctionName(functionIndex),
            new CallableBinding(FunctionName(functionIndex), label, function.ArgumentTypeIndices.Count, returnType));

        for (int index = 0; index < function.ArgumentTypeIndices.Count; index++)
        {
            UType type = ResolveType(executable, function.ArgumentTypeIndices[index]);
            RequireCellType(type, functionIndex, index);
            int offset = 16 + (function.ArgumentTypeIndices.Count - 1 - index) * 8;
            frame.Symbols.Add(BindingName(index), new StackBinding(
                BindingName(index),
                type,
                offset,
                IsReadOnly(type)));
        }

        for (int local = 0; local < function.LocalTypeIndices.Count; local++)
        {
            UType type = ResolveType(executable, function.LocalTypeIndices[local]);
            int bindingIndex = checked(function.ArgumentTypeIndices.Count + local);
            RequireCellType(type, functionIndex, bindingIndex);
            frame.Symbols.Add(BindingName(bindingIndex), new StackBinding(
                BindingName(bindingIndex),
                type,
                -8 * (local + 1),
                IsReadOnly(type)));
        }

        for (int index = 0; index < switchCount; index++)
            frame.SwitchSlots.Enqueue(checked(-8 * (localCount + slotCount + index + 1)));

        var scopes = new CompilationScopes { EmitProcessEntryPoint = false };
        scopes.Push(CloneModuleScope(moduleScope));
        scopes.Push(frame);

        output.AppendLine($"{label}:");
        output.AppendLine("  push rbp");
        output.AppendLine("  mov rbp, rsp");
        if (frame.FrameSize != 0)
            output.AppendLine($"  sub rsp, {frame.FrameSize}");
        for (int slot = 0; slot < slotCount; slot++)
            output.AppendLine($"  mov qword {CallableAddress(localCount, (uint)slot)}, 0");

        for (int index = 0; index < function.Instructions.Count; index++)
        {
            if (optimizeTailCalls &&
                PortableX64TailCallOptimizer.TryEmit(executable, function, index, functionLabels) is string tail)
            {
                AppendIndented(output, tail);
                index++; // The verified adjacent RETURN is included in the tail transfer.
                continue;
            }

            string assembly = function.Instructions[index] is PortableCallableInstruction callable
                ? CompileCallable(callable, executable, functionIndex, index, localCount, bindTargets, scopes, ref dispatchBudget)
                : CompileInstruction(function.Instructions[index], executable, functionIndex, function, scopes, frame);
            AppendIndented(output, assembly);
        }

        if (scopes.Count != 2)
            throw new InvalidDataException(
                $"FunctionIndex {functionIndex} ended with {scopes.Count - 2} unterminated portable control scope(s).");

        if (returnType.Type == PrimitiveType.Void)
            output.AppendLine("  xor eax, eax");
        output.AppendLine(frame.EndLabel + ":");
        output.AppendLine("  mov rsp, rbp");
        output.AppendLine("  pop rbp");
        output.AppendLine("  ret");
    }

    private static string CompileInstruction(
        PortableInstruction instruction,
        PortableExecutableModule executable,
        int functionIndex,
        PortableExecutableFunction function,
        CompilationScopes scopes,
        ScopeContext frame) => instruction switch
    {
        PortableOperandFreeInstruction operandFree => CompileOperandFree(operandFree.OpCode, scopes),
        PortableReturnInstruction ret => CompileReturn(ret, executable, functionIndex, function, frame),
        PortableVariableInstruction variable => CompileVariable(variable, function, frame),
        PortablePushInstruction push => new StackOperations.PUSH(push.Immediate.ToArray()).Compile(scopes),
        PortableStackIndexInstruction stack => CompileStackIndex(stack, scopes),
        PortableExtendedStackInstruction extended => CompileExtendedStack(extended, scopes),
        PortableBranchInstruction branch => new BRANCH(unchecked((long)branch.CaseCell)).Compile(scopes),
        PortableControlTransferInstruction transfer => CompileTransfer(transfer, scopes),
        PortableContractBlockInstruction contract => CompileContractBlock(contract, executable, scopes),
        PortableBlockInstruction block => new BLOCK(block.ResultTypeIndex is uint typeIndex
            ? ResolveType(executable, typeIndex) : null).Compile(scopes),
        PortableCallInstruction call => CompileCall(call, executable, scopes),
        PortableFunctionAddressInstruction address =>
            new FunctionOperations.FNADDR(FunctionName(checked((int)address.FunctionIndex))).Compile(scopes),
        PortableCallIndirectInstruction indirect =>
            new FunctionOperations.CALLI(indirect.ArgumentCount, indirect.ReturnType).Compile(scopes),
        PortableMemoryInstruction memory => CompileMemory(memory, scopes),
        _ => throw new NotSupportedException(
            $"Portable instruction type '{instruction.GetType().Name}' has no x64 lowering contract.")
    };

    private static string CallableAddress(int localCount, uint slot) =>
        $"[rbp - {checked((localCount + (int)slot + 1) * 8)}]";

    private static string CompileCallable(
        PortableCallableInstruction instruction, PortableExecutableModule executable,
        int functionIndex, int instructionIndex, int localCount, IReadOnlyList<uint> bindTargets,
        CompilationScopes scopes, ref int dispatchBudget)
    {
        PortableCallableTable table = executable.CallableSlots
            ?? throw new InvalidDataException("Callable instruction has no slot bank.");
        PortableCallableSignature signature = table.Get(functionIndex, instruction.Slot);
        string destination = CallableAddress(localCount, instruction.Slot);
        switch (instruction.Operation)
        {
            case 0:
                // Zero is Empty. Selectors are private, never guest scalar values.
                return $"mov qword {destination}, {checked(instruction.Second!.Value + 1)}";
            case 1:
                return $"mov rax, {CallableAddress(localCount, instruction.Second!.Value)}\n  mov qword {destination}, rax";
            case 2:
                return $"mov qword {destination}, 0";
            case 3:
            {
                // A slot may acquire any compatible target minted by this activation,
                // including via COPY. Restrict dispatch to that finite set, not all code.
                dispatchBudget -= Math.Max(1, bindTargets.Count);
                if (dispatchBudget < 0)
                    throw new NotSupportedException("CallableLocal x64 dispatch expansion limit exceeded.");
                string prefix = $"ubytec_binary_f_{functionIndex}__cap_{instructionIndex}";
                var output = new StringBuilder();
                uint[] allowed = bindTargets.Where(target =>
                {
                    PortableExecutableFunction function = executable.Functions[(int)target];
                    return signature.Matches(function.ReturnTypeIndex, function.ArgumentTypeIndices);
                }).ToArray();
                foreach (uint target in allowed)
                {
                    output.AppendLine($"cmp qword {destination}, {checked(target + 1)}");
                    output.AppendLine($"je {prefix}_target_{target}");
                }
                output.AppendLine("ud2 ; empty or invalid callable selector");
                foreach (uint target in allowed)
                {
                    output.AppendLine($"{prefix}_target_{target}:");
                    output.AppendLine(CompileCall(new PortableCallInstruction(PortableCallTargetKind.LocalFunction, target), executable, scopes));
                    output.AppendLine($"jmp {prefix}_end");
                }
                output.AppendLine($"{prefix}_end:");
                return output.ToString();
            }
            default:
                throw new InvalidDataException("Unknown callable opcode.");
        }
    }

    private static string CompileReturn(
        PortableReturnInstruction instruction,
        PortableExecutableModule executable,
        int functionIndex,
        PortableExecutableFunction function,
        ScopeContext frame)
    {
        UType expected = ResolveType(executable, function.ReturnTypeIndex);
        if (instruction.TypeIndex is uint explicitIndex)
        {
            UType actual = ResolveType(executable, explicitIndex);
            if (actual.Type != expected.Type || actual.Modifiers != expected.Modifiers ||
                actual.FixedArraySize != expected.FixedArraySize)
                throw new InvalidDataException(
                    $"FunctionIndex {functionIndex} RETURN type does not match its function result type.");
        }

        return (expected.Type == PrimitiveType.Void
                ? "xor eax, eax"
                : "pop rax\n  " + FunctionCode.Canonicalize(expected)) +
            $"\n  jmp {frame.EndLabel}";
    }

    private static string CompileVariable(
        PortableVariableInstruction instruction,
        PortableExecutableFunction function,
        ScopeContext frame)
    {
        int index = checked((int)instruction.BindingIndex);
        if (index < function.ArgumentTypeIndices.Count)
            throw new InvalidDataException("VAR cannot initialize an argument BindingIndex.");
        if (!frame.Symbols.TryGetValue(BindingName(index), out StackBinding? binding))
            throw new InvalidDataException("VAR BindingIndex is outside the function frame.");
        return $"mov rax, 0x{instruction.InitialCell:X16}\n  mov qword {binding.Address}, rax";
    }

    private static string CompileContractBlock(
        PortableContractBlockInstruction instruction, PortableExecutableModule executable, CompilationScopes scopes)
    {
        string assembly = new BLOCK(ResolveType(executable, instruction.ResultTypeIndex)).Compile(scopes);
        ScopeContext block = scopes.Peek();
        block.IsContractBlock = true;
        block.CheckedBlockResult = instruction.Checked;
        var output = new System.Text.StringBuilder(assembly).AppendLine();
        for (int i = 0; i < instruction.InputTypeIndices.Count; i++)
        {
            int offset = checked((instruction.InputTypeIndices.Count - 1 - i) * 8);
            UType type = ResolveType(executable, instruction.InputTypeIndices[i]);
            output.AppendLine($"  mov rax, qword [rsp + {offset}]");
            output.AppendLine(FunctionCode.CanonicalizeBlockCell(type, instruction.Checked, scopes));
            output.AppendLine($"  mov qword [rsp + {offset}], rax");
        }
        return output.ToString();
    }

    private static string CompileTransfer(PortableControlTransferInstruction instruction, CompilationScopes scopes)
    {
        uint ordinal = instruction.TargetOrdinal;
        bool continuing = instruction.Operation == CONTINUE.OP;
        foreach (ScopeContext scope in scopes.All)
        {
            if (scope.DeclaredByKeyword is "func" or "action") break;
            if (!scope.IsLoop && (continuing || (scope.DeclaredByKeyword != "switch" && !scope.IsContractBlock))) continue;
            if (ordinal == 0)
                return continuing ? $"jmp {scope.StartLabel} ; CONTINUE" : $"jmp {scope.EndLabel} ; BREAK";
            ordinal--;
        }
        throw new InvalidDataException("Verified control target does not exist in native scopes.");
    }

    private static string CompileExtendedStack(PortableExtendedStackInstruction instruction, CompilationScopes scopes) =>
        instruction.Operation switch
        {
            0x11 => new ExtendedStackOperations.PUSH16(instruction.Index).Compile(scopes),
            0x18 => new ExtendedStackOperations.DROP16(instruction.Index).Compile(scopes),
            0x1D => new ExtendedStackOperations.PICK16(instruction.Index).Compile(scopes),
            0x1E => new ExtendedStackOperations.ROLL16(instruction.Index).Compile(scopes),
            _ => throw new InvalidDataException("Unknown extended stack opcode.")
        };

    private static string CompileStackIndex(PortableStackIndexInstruction instruction, CompilationScopes scopes) =>
        instruction.StackOpCode switch
        {
            StackOperations.DROP.OP => new StackOperations.DROP(instruction.Index).Compile(scopes),
            StackOperations.PICK.OP => new StackOperations.PICK(instruction.Index).Compile(scopes),
            StackOperations.ROLL.OP => new StackOperations.ROLL(instruction.Index).Compile(scopes),
            _ => throw new InvalidDataException(
                $"Opcode 0x{instruction.StackOpCode:X2} is not a portable stack-index instruction.")
        };

    private static string CompileCall(
        PortableCallInstruction instruction,
        PortableExecutableModule executable,
        CompilationScopes scopes)
    {
        string name = instruction.TargetKind switch
        {
            PortableCallTargetKind.LocalFunction when instruction.TargetIndex < executable.Functions.Count =>
                FunctionName(checked((int)instruction.TargetIndex)),
            PortableCallTargetKind.Import when instruction.TargetIndex < executable.Imports.Count =>
                ImportName(checked((int)instruction.TargetIndex)),
            PortableCallTargetKind.LocalFunction => throw new InvalidDataException("FunctionIndex is outside the Function table."),
            PortableCallTargetKind.Import => throw new InvalidDataException("ImportIndex is outside the Import table."),
            _ => throw new InvalidDataException($"Reserved CALL TargetKind {(byte)instruction.TargetKind}.")
        };
        return new FunctionOperations.CALL(name).Compile(scopes);
    }

    private static string CompileMemory(PortableMemoryInstruction instruction, CompilationScopes scopes) =>
        instruction.Mode switch
        {
            PortableMemoryAccessMode.Address => MemoryOperation(instruction.MemoryOpCode, null, null, scopes),
            PortableMemoryAccessMode.RawTyped when instruction.RawType is PrimitiveType type =>
                MemoryOperation(instruction.MemoryOpCode, null, type, scopes),
            PortableMemoryAccessMode.Binding when instruction.BindingIndex is uint index =>
                MemoryOperation(instruction.MemoryOpCode, BindingName(checked((int)index)), null, scopes),
            _ => throw new InvalidDataException("Malformed portable LOAD/STORE operands.")
        };

    private static string MemoryOperation(
        byte opcode,
        string? binding,
        PrimitiveType? accessType,
        CompilationScopes scopes) => opcode switch
    {
        MemoryOperations.LOAD.OP => new MemoryOperations.LOAD(binding, accessType).Compile(scopes),
        MemoryOperations.STORE.OP => new MemoryOperations.STORE(binding, accessType).Compile(scopes),
        _ => throw new InvalidDataException($"Opcode 0x{opcode:X2} is not LOAD or STORE.")
    };

    private static string CompileOperandFree(byte opcode, CompilationScopes scopes)
    {
        if (opcode is LOOP.OP or IF.OP or ELSE.OP or END.OP or WHILE.OP or SWITCH.OP)
            return CompileStructuredOperandFree(opcode, scopes);

        if (!OperandFreeOperations.TryGetValue(opcode, out Type? type) ||
            Activator.CreateInstance(type) is not IOpCode operation)
            throw new NotSupportedException($"Opcode 0x{opcode:X2} has no operand-free x64 lowering contract.");

        int depth = scopes.Count;
        string assembly = operation.Compile(scopes);
        if (scopes.Count != depth)
            throw new InvalidDataException(
                $"Opcode 0x{opcode:X2} unexpectedly changed portable structured scope state.");
        return assembly;
    }

    private static string CompileStructuredOperandFree(byte opcode, CompilationScopes scopes)
    {
        if (opcode == END.OP && scopes.Count <= 2)
            throw new InvalidDataException("Portable END cannot close the function or module scope.");

        int depth = scopes.Count;
        IOpCode operation = opcode switch
        {
            LOOP.OP => new LOOP(),
            IF.OP => new IF(),
            ELSE.OP => new ELSE(),
            END.OP => new END(),
            WHILE.OP => new WHILE(),
            SWITCH.OP => new SWITCH(null),
            _ => throw new InvalidDataException($"Opcode 0x{opcode:X2} is not normalized structured control flow.")
        };

        string assembly = operation.Compile(scopes);
        int expectedDepth = opcode switch
        {
            BLOCK.OP or LOOP.OP or IF.OP or WHILE.OP or SWITCH.OP => depth + 1,
            END.OP => depth - 1,
            _ => depth
        };
        if (scopes.Count != expectedDepth)
            throw new InvalidDataException(
                $"Opcode 0x{opcode:X2} produced an invalid portable scope transition {depth}->{scopes.Count}; expected {expectedDepth}.");
        return assembly;
    }

    private static IReadOnlyDictionary<byte, Type> DiscoverOperandFreeOperations()
    {
        var result = new Dictionary<byte, Type>();
        foreach (Type type in typeof(IOpCode).Assembly.GetTypes())
        {
            if (!type.IsValueType || type.IsAbstract || !typeof(IOpCode).IsAssignableFrom(type) ||
                typeof(IExtendedOpCode).IsAssignableFrom(type))
                continue;
            if (type.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic).Length != 0)
                continue;
            if (Activator.CreateInstance(type) is not IOpCode operation || operation.OpCode == 0xFF)
                continue;
            if (!result.TryAdd(operation.OpCode, type))
                throw new InvalidOperationException($"Duplicate core opcode 0x{operation.OpCode:X2}.");
        }
        return result;
    }

    private static ScopeContext CloneModuleScope(ScopeContext source)
    {
        var clone = new ScopeContext
        {
            StartLabel = source.StartLabel,
            EndLabel = source.EndLabel,
            DeclaredByKeyword = source.DeclaredByKeyword
        };
        foreach ((string name, CallableBinding binding) in source.Callables)
            clone.Callables.Add(name, binding);
        return clone;
    }

    private static UType ResolveType(PortableExecutableModule executable, uint typeIndex)
    {
        if (typeIndex >= executable.Types.Count)
            throw new InvalidDataException("TypeIndex is outside the Type table.");
        PortableExecutableType type = executable.Types[checked((int)typeIndex)];
        string? name = null;
        if (type.NameStringIndex is uint nameIndex)
        {
            if (nameIndex >= executable.Strings.Count)
                throw new InvalidDataException("Type name StringIndex is outside the String table.");
            name = executable.Strings[checked((int)nameIndex)];
        }
        return new UType(
            type.Primitive,
            type.Modifiers,
            name: name,
            fixedArraySize: checked((nuint)type.FixedArraySize));
    }

    private static int ImportCallCellCount(
        PortableExecutableModule executable,
        PortableExecutableImport import)
    {
        bool legacyBuffer = import.Arguments.Count == 4 &&
            import.Arguments.All(argument =>
                argument.PassingMode == PortablePassingMode.Value &&
                ResolveType(executable, argument.TypeIndex).Type == PrimitiveType.UInt64) &&
            ResolveType(executable, import.ReturnTypeIndex).Type == PrimitiveType.Int64;
        if (legacyBuffer)
            return 5;

        int cells = 2; // budget_ms + result_address
        foreach (PortableBoundaryDescriptor argument in import.Arguments)
            cells += argument.PassingMode is PortablePassingMode.LoanRead or PortablePassingMode.LoanWrite ? 2 : 1;
        return cells;
    }

    private static void RequireCellType(UType type, int functionIndex, int bindingIndex)
    {
        if (!FunctionCode.IsCellType(type))
            throw new NotSupportedException(
                $"FunctionIndex {functionIndex} BindingIndex {bindingIndex} is not supported by the x64 cell ABI.");
    }

    private static bool IsReadOnly(UType type) =>
        (type.Modifiers & (TypeModifiers.ReadOnly | TypeModifiers.Const)) != 0;

    private static int Align16(int bytes) => checked((bytes + 15) & ~15);

    private static string FunctionName(int index) => $"f{index}";
    private static string ImportName(int index) => $"i{index}";
    private static string BindingName(int index) => $"b{index}";
    private static string FunctionLabel(int index) => $"ubytec_binary_f_{index}";
    private static string ImportLabel(int index) => $"ubytec_binary_import_{index}";
    private static string ExportLabel(int index) => $"ubytec_binary_export_{index}";

    private static void AppendIndented(StringBuilder output, string assembly)
    {
        foreach (string line in assembly.ReplaceLineEndings("\n").Split('\n'))
            if (line.Length != 0)
                output.Append("  ").AppendLine(line);
    }
}
