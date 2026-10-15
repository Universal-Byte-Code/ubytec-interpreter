using System.Text;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Portable;

/// <summary>
/// Explicit x64 tail-call optimization over the verified indexed UBCM instruction stream.
/// The pass never consults source names or AST state: tail position, target identity and
/// signature compatibility are derived exclusively from the verified portable module.
/// </summary>
public static class PortableX64TailCallOptimizer
{
    /// <summary>
    /// Rewrites compatible local CALL + RETURN pairs to frame-reusing jumps.
    /// This changes physical frame lifetime and is therefore opt-in rather than a default optimization.
    /// </summary>
    public static PortableX64Compilation Apply(
        ReadOnlySpan<byte> moduleBytes,
        PortableX64Compilation nativeCompilation)
    {
        ArgumentNullException.ThrowIfNull(nativeCompilation);
        PortableProcessEntrypoint.Verify(moduleBytes);
        PortableBinaryModule module = PortableBinaryCodec.Decode(moduleBytes);
        PortableExecutableModule executable = module.Executable
            ?? throw new InvalidDataException("Tail-call optimization requires the indexed executable profile.");

        if (nativeCompilation.FunctionLabels.Count != executable.Functions.Count)
            throw new InvalidDataException("Native function labels do not match the verified UBCM function table.");

        string assembly = nativeCompilation.Assembly.ReplaceLineEndings("\n");
        for (int callerIndex = 0; callerIndex < executable.Functions.Count; callerIndex++)
        {
            PortableExecutableFunction caller = executable.Functions[callerIndex];
            IReadOnlyList<PortableInstruction> instructions = caller.Instructions;
            for (int instructionIndex = 0; instructionIndex + 1 < instructions.Count; instructionIndex++)
            {
                if (instructions[instructionIndex] is not PortableCallInstruction call ||
                    instructions[instructionIndex + 1] is not PortableReturnInstruction ret ||
                    call.TargetKind != PortableCallTargetKind.LocalFunction)
                {
                    continue;
                }

                if (call.TargetIndex >= executable.Functions.Count)
                    throw new InvalidDataException("Tail CALL FunctionIndex is outside the verified function table.");

                PortableExecutableFunction target = executable.Functions[checked((int)call.TargetIndex)];
                if (!Compatible(caller, target))
                    continue;

                if (ret.TypeIndex is uint explicitReturn && explicitReturn != caller.ReturnTypeIndex)
                    throw new InvalidDataException("Tail RETURN TypeIndex differs from the enclosing function result type.");

                string callerLabel = nativeCompilation.GetFunctionLabel(callerIndex);
                string targetLabel = nativeCompilation.GetFunctionLabel(checked((int)call.TargetIndex));
                UType returnType = ResolveType(executable, caller.ReturnTypeIndex);
                string ordinary = EmitIndented(NormalCall(targetLabel, target, executable)) +
                                  EmitIndented(NormalReturn(callerLabel, returnType));
                int position = assembly.IndexOf(ordinary, StringComparison.Ordinal);
                if (position < 0)
                {
                    throw new InvalidDataException(
                        $"Verified tail pair FunctionIndex {callerIndex}->{call.TargetIndex} does not match the x64 backend output.");
                }

                string tail = EmitIndented(TailCall(targetLabel, target.ArgumentTypeIndices.Count));
                assembly = string.Concat(
                    assembly.AsSpan(0, position),
                    tail,
                    assembly.AsSpan(position + ordinary.Length));
                instructionIndex++;
            }
        }

        return nativeCompilation with { Assembly = assembly };
    }

    private static bool Compatible(
        PortableExecutableFunction caller,
        PortableExecutableFunction target) =>
        caller.ArgumentTypeIndices.Count == target.ArgumentTypeIndices.Count &&
        caller.ReturnTypeIndex == target.ReturnTypeIndex;

    private static string NormalCall(
        string targetLabel,
        PortableExecutableFunction target,
        PortableExecutableModule executable)
    {
        string output = $"call {targetLabel}";
        if (target.ArgumentTypeIndices.Count != 0)
            output += $"\n  add rsp, {target.ArgumentTypeIndices.Count * 8}";
        UType returnType = ResolveType(executable, target.ReturnTypeIndex);
        if (returnType.Type != PrimitiveType.Void)
            output += "\n  push rax";
        return output;
    }

    private static string NormalReturn(string callerLabel, UType returnType) =>
        (returnType.Type == PrimitiveType.Void
            ? "xor eax, eax"
            : "pop rax\n  " + FunctionCode.Canonicalize(returnType)) +
        $"\n  jmp {callerLabel}__end";

    private static string TailCall(string targetLabel, int argumentCount)
    {
        var output = new StringBuilder("; tail call: reuse incoming argument cells\n");
        for (int index = 0; index < argumentCount; index++)
            output.AppendLine($"pop rax\n  mov qword [rbp + {16 + index * 8}], rax");
        output.AppendLine("mov rsp, rbp\n  pop rbp");
        output.AppendLine($"jmp {targetLabel}");
        return output.ToString();
    }

    private static string EmitIndented(string assembly)
    {
        var output = new StringBuilder();
        foreach (string line in assembly.ReplaceLineEndings("\n").Split('\n'))
            if (line.Length != 0)
                output.Append("  ").AppendLine(line);
        return output.ToString();
    }

    private static UType ResolveType(PortableExecutableModule executable, uint typeIndex)
    {
        if (typeIndex >= executable.Types.Count)
            throw new InvalidDataException("Tail-call TypeIndex is outside the verified type table.");
        PortableExecutableType type = executable.Types[checked((int)typeIndex)];
        string? name = null;
        if (type.NameStringIndex is uint nameIndex)
        {
            if (nameIndex >= executable.Strings.Count)
                throw new InvalidDataException("Tail-call type name StringIndex is outside the verified string table.");
            name = executable.Strings[checked((int)nameIndex)];
        }
        return new UType(
            type.Primitive,
            type.Modifiers,
            name: name,
            fixedArraySize: checked((nuint)type.FixedArraySize));
    }
}
