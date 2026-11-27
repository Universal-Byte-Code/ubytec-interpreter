using System.Text;

namespace Ubytec.Language.Portable;

/// <summary>
/// Opt-in x64 tail-transfer lowering for adjacent, verified indexed CALL + RETURN instructions.
/// Called by the backend while emitting the current function, never by rewriting NASM text.
/// Frame reuse changes physical frame lifetime and is not part of the default observable contract.
/// </summary>
internal static class PortableX64TailCallOptimizer
{
    internal static string? TryEmit(
        PortableExecutableModule executable,
        PortableExecutableFunction caller,
        int instructionIndex,
        IReadOnlyList<string> functionLabels)
    {
        IReadOnlyList<PortableInstruction> instructions = caller.Instructions;
        if (instructionIndex + 1 >= instructions.Count ||
            instructions[instructionIndex] is not PortableCallInstruction call ||
            instructions[instructionIndex + 1] is not PortableReturnInstruction ret ||
            call.TargetKind != PortableCallTargetKind.LocalFunction)
        {
            return null;
        }

        // Only invoked after independent verification of the entire module.
        if (call.TargetIndex >= executable.Functions.Count)
            throw new InvalidDataException("Tail CALL FunctionIndex is outside the verified function table.");

        PortableExecutableFunction target = executable.Functions[checked((int)call.TargetIndex)];
        if (caller.ArgumentTypeIndices.Count != target.ArgumentTypeIndices.Count ||
            caller.ReturnTypeIndex != target.ReturnTypeIndex)
        {
            return null;
        }

        if (ret.TypeIndex is uint explicitReturn && explicitReturn != caller.ReturnTypeIndex)
            throw new InvalidDataException("Tail RETURN TypeIndex differs from the enclosing function result type.");

        var output = new StringBuilder("; tail call: reuse incoming argument cells\n");
        // Copy the evaluated arguments in pop order into the incoming argument area.
        for (int index = 0; index < target.ArgumentTypeIndices.Count; index++)
            output.Append("pop rax\n  mov qword [rbp + ").Append(16 + index * 8).Append("], rax\n");
        output.Append("mov rsp, rbp\n  pop rbp\n");
        output.Append("jmp ").Append(functionLabels[checked((int)call.TargetIndex)]).Append('\n');
        return output.ToString();
    }
}
