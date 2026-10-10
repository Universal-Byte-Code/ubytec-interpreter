using System.Buffers.Binary;
using Ubytec.Language.HighLevel;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Tools.Optimization;

/// <summary>A closed UInt64 field reduction with a constant stride and exact scalar read ledger.</summary>
internal sealed record RecordReductionPlan(StackBinding Data, StackBinding Length,
    StackBinding Index, StackBinding Sum, int Stride, int Offset)
{
    internal static RecordReductionPlan? TryCreate(FunctionValueIR ir, ScopeContext frame,
        Argument[] arguments, LocalContext? locals, UType result)
    {
        if (!ReductionPlanSupport.TryPrepareSimpleScalarPlan(ir, frame, arguments, locals, result,
                expectedInstructionCount: 18, tailStart: 11, out var ops, out var bindings) ||
            ops[4] is not StackOperations.PUSH stridePush || !TryConstant(stridePush, out int stride) || stride == 0 ||
            ops[5] is not ArithmeticOperations.MUL || ops[6] is not ArithmeticOperations.ADD ||
            ops[7] is not StackOperations.PUSH offsetPush || !TryConstant(offsetPush, out int offset) ||
            ops[8] is not ArithmeticOperations.ADD ||
            ops[9] is not MemoryOperations.LOAD { VariableName: null, AccessType: PrimitiveType.UInt64 } ||
            ops[10] is not ArithmeticOperations.ADD)
            return null;

        return new(bindings[0], bindings[1], bindings[2], bindings[3], stride, offset);
    }

    private static bool TryConstant(StackOperations.PUSH push, out int value)
    {
        value = 0;
        if (push.operands is not { Length: > 0 and <= sizeof(ulong) } bytes)
            return false;

        Span<byte> buffer = stackalloc byte[sizeof(ulong)];
        buffer.Clear();
        bytes.CopyTo(buffer);
        ulong immediate = BinaryPrimitives.ReadUInt64LittleEndian(buffer);
        if (immediate > int.MaxValue)
            return false;

        value = (int)immediate;
        return true;
    }

    internal string Emit(ScopeContext frame)
    {
        string preheader = $"imul rdi, r8, {Stride}\n  add rdi, rdx\n  add rdi, {Offset}";
        var (output, loop, done) = ReductionPlanSupport.BeginAccumulatorEmitter(frame,
            "_record_reduce",
            $"; record-reductions: scalar UInt64, stride {Stride}, offset {Offset}, observable stack retained",
            Data, Length, Index, Sum, preheader);

        // Integer cell arithmetic wraps modulo 2^64, as in the source MUL/ADD.
        // Advancing the pointer by stride is equivalent to recomputing index*stride.
        // S=RBP-FrameSize. Reproduce all last writes before the single raw read:
        // [S-8]=sum, [S-16]=effective address, [S-24]=offset, [S-32]=stride.
        // This also preserves reads through aliases into locals and residual cells.
        output.AppendLine($"mov qword [rsp - 8], r9\n  mov qword [rsp - 24], {Offset}");
        output.AppendLine($"mov qword [rsp - 32], {Stride}\n  mov qword [rsp - 16], rdi");
        output.AppendLine("lea rsp, [rsp - 8]\n  mov rax, qword [rdi]");
        // Exact eight-byte load, including a load spanning a protection boundary.
        output.AppendLine("mov qword [rsp - 8], rax\n  add r9, rax");
        output.AppendLine($"mov qword {Sum.Address}, r9\n  inc r8\n  mov qword {Index.Address}, r8");
        output.AppendLine($"lea rsp, [rsp + 8]\n  mov qword [rsp - 8], r8\n  add rdi, {Stride}\n  jmp {loop}");
        // Empty loops leave deeper cells intact; LOAD sum still writes the top cell.
        return ReductionPlanSupport.CompleteAccumulatorEmitter(output, done, frame);
    }
}
