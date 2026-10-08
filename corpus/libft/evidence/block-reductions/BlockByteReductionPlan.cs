using Ubytec.Language.Syntax.Scopes.Contexts;

namespace Ubytec.Language.Tools.Optimization;

/// <summary>Page-bounded SSE2 lowering for a closed reduction over stable ordinary RAM.</summary>
internal static class BlockByteReductionPlan
{
    internal static string Emit(ByteReductionPlan plan, ScopeContext frame)
    {
        string prefix = frame.StartLabel + "_block_reduce";
        // Guard the entire remaining input against address wrapping, the conservative
        // low canonical user range, and every frame/evaluation byte the loop writes.
        // Guards use registers only: an aliased input must reach the scalar fallback
        // without extra writes to consumed evaluation cells.
        string block = $$"""
            ; block-reductions: stable ordinary RAM, page-bounded SSE2, scalar alias fallback
            mov rdx, qword {{plan.Data.Address}}
            mov r10, qword {{plan.Length.Address}}
            mov r8, qword {{plan.Index.Address}}
            mov r9, qword {{plan.Sum.Address}}
            cmp r8, r10
            jae {{prefix}}_fallback
            mov rdi, rdx
            add rdi, r8
            jc {{prefix}}_fallback
            mov rax, rdx
            add rax, r10
            jc {{prefix}}_fallback
            mov rcx, rax
            dec rcx
            shr rcx, 47
            jnz {{prefix}}_fallback
            cmp rdi, rbp
            jae {{prefix}}_page
            lea rcx, [rsp - 24]
            cmp rax, rcx
            ja {{prefix}}_fallback
            {{prefix}}_page:
            cmp r8, r10
            jae {{prefix}}_done
            lea rdi, [rdx + r8]
            test rdi, 15
            jnz {{prefix}}_byte
            mov rcx, r10
            sub rcx, r8
            mov rsi, rdi
            and esi, 4095
            neg rsi
            add rsi, 4096
            cmp rsi, rcx
            cmova rsi, rcx
            and rsi, -16
            jz {{prefix}}_byte
            ; Before the first read of this page segment reproduce the scalar ledger.
            mov qword [rsp - 8], r9
            mov qword [rsp - 24], r8
            mov qword [rsp - 16], rdi
            lea rsp, [rsp - 8]
            movzx eax, byte [rdi]
            ; The successful byte probe establishes readability of this unchanged
            ; ordinary-RAM page. Aligned vector reads stay in that page and input range.
            mov rcx, rsi
            pxor xmm0, xmm0
            pxor xmm2, xmm2
            pxor xmm3, xmm3
            pxor xmm4, xmm4
            pxor xmm5, xmm5
            cmp rsi, 64
            jb {{prefix}}_single
            {{prefix}}_four:
            movdqa xmm1, [rdi]
            psadbw xmm1, xmm0
            paddq xmm2, xmm1
            movdqa xmm1, [rdi + 16]
            psadbw xmm1, xmm0
            paddq xmm3, xmm1
            movdqa xmm1, [rdi + 32]
            psadbw xmm1, xmm0
            paddq xmm4, xmm1
            movdqa xmm1, [rdi + 48]
            psadbw xmm1, xmm0
            paddq xmm5, xmm1
            add rdi, 64
            sub rsi, 64
            cmp rsi, 64
            jae {{prefix}}_four
            {{prefix}}_single:
            test rsi, rsi
            jz {{prefix}}_commit
            {{prefix}}_sixteen:
            movdqa xmm1, [rdi]
            psadbw xmm1, xmm0
            paddq xmm2, xmm1
            add rdi, 16
            sub rsi, 16
            jnz {{prefix}}_sixteen
            {{prefix}}_commit:
            paddq xmm2, xmm3
            paddq xmm4, xmm5
            paddq xmm2, xmm4
            movq rax, xmm2
            psrldq xmm2, 8
            movq rsi, xmm2
            add rax, rsi
            add r9, rax
            add r8, rcx
            mov qword {{plan.Sum.Address}}, r9
            mov qword {{plan.Index.Address}}, r8
            ; Exact scalar back-edge image, including the final byte and prior index.
            mov qword [rsp], r8
            movzx eax, byte [rdi - 1]
            mov qword [rsp - 8], rax
            lea rax, [r8 - 1]
            mov qword [rsp - 16], rax
            lea rsp, [rsp + 8]
            jmp {{prefix}}_page
            {{prefix}}_byte:
            ; Alignment prefix and short tail retain one-byte access and fault order.
            mov qword [rsp - 8], r9
            mov qword [rsp - 24], r8
            mov qword [rsp - 16], rdi
            lea rsp, [rsp - 8]
            movzx eax, byte [rdi]
            mov qword [rsp - 8], rax
            add r9, rax
            mov qword {{plan.Sum.Address}}, r9
            inc r8
            mov qword {{plan.Index.Address}}, r8
            lea rsp, [rsp + 8]
            mov qword [rsp - 8], r8
            jmp {{prefix}}_page
            {{prefix}}_done:
            mov rax, r9
            mov qword [rsp - 8], rax
            jmp {{frame.EndLabel}}
            {{prefix}}_fallback:
            """;
        return block + "\n" + plan.Emit(frame);
    }
}
