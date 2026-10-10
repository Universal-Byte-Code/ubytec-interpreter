using Ubytec.Language.HighLevel;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Tools.Optimization;

/// <summary>A scalar byte reduction with an explicit observable-stack ledger.</summary>
internal sealed record ByteReductionPlan(StackBinding Data, StackBinding Length,
    StackBinding Index, StackBinding Sum)
{
    internal static ByteReductionPlan? TryCreate(FunctionValueIR ir, ScopeContext frame,
        Argument[] arguments, LocalContext? locals, UType result)
    {
        if (!ReductionPlanSupport.TryPrepareSimpleScalarPlan(ir, frame, arguments, locals, result,
                expectedInstructionCount: 14, tailStart: 7, out var ops, out var bindings) ||
            ops[4] is not ArithmeticOperations.ADD ||
            ops[5] is not MemoryOperations.LOAD { VariableName: null, AccessType: PrimitiveType.Byte } ||
            ops[6] is not ArithmeticOperations.ADD)
            return null;

        return new(bindings[0], bindings[1], bindings[2], bindings[3]);
    }

    internal string Emit(ScopeContext frame)
    {
        var (output, loop, done) = ReductionPlanSupport.BeginAccumulatorEmitter(frame,
            "_byte_reduce", "; loop-reductions: scalar bytes, observable stack retained",
            Data, Length, Index, Sum);

        // S = RBP - FrameSize. Before the raw byte read, the original backend has:
        // [S-8] = sum, [S-16] = data+index, [S-24] = index, RSP = S-8.
        // Earlier writes to these same ordinary RAM cells cannot be observed by this
        // closed instruction sequence. Reproduce its last writes before the read.
        output.AppendLine("mov qword [rsp - 8], r9");
        output.AppendLine("mov qword [rsp - 24], r8");
        output.AppendLine("mov rcx, r8\n  mov rax, rdx\n  add rax, rcx");
        output.AppendLine("mov qword [rsp - 16], rax\n  lea rsp, [rsp - 8]");
        // Read exactly one byte in the original order, including address wrapping.
        // A failing read sees the original frame, stack bytes, RSP and effective address.
        output.AppendLine("movzx eax, byte [rax]");
        output.AppendLine("mov qword [rsp - 8], rax\n  add r9, rax");
        output.AppendLine($"mov qword {Sum.Address}, r9");
        output.AppendLine("inc r8");
        output.AppendLine($"mov qword {Index.Address}, r8");
        // Back edge: [S-8]=next index, [S-16]=last byte, [S-24]=previous index.
        output.AppendLine($"lea rsp, [rsp + 8]\n  mov qword [rsp - 8], r8\n  jmp {loop}");
        // LOAD sum; RETURN leaves the returned value in the consumed top cell,
        // even for an empty loop. Preserve the deeper residual bytes as well.
        return ReductionPlanSupport.CompleteAccumulatorEmitter(output, done, frame);
    }
}
