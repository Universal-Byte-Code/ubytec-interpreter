using Ubytec.Language.Syntax.Scopes.Contexts;

namespace Ubytec.Language.Tools.Optimization;

/// <summary>Page-bounded SSE2 or native AVX2 lowering for a closed reduction over stable ordinary RAM.</summary>
internal static class BlockByteReductionPlan
{
    internal static string Emit(ByteReductionPlan plan, ScopeContext frame, bool useAvx2 = false)
    {
        string prefix = frame.StartLabel + "_block_reduce";
        string kernel = useAvx2 ? EmitAvx2(prefix) : EmitSse2(prefix);
        string target = useAvx2 ? "AVX2" : "SSE2";
        // Guard the entire remaining input against address wrapping, the conservative
        // low canonical user range, and every frame/evaluation byte the loop writes.
        // Guards use registers only: an aliased input must reach the scalar fallback
        // without extra writes to consumed evaluation cells.
        string block = $$"""
            ; block-reductions: stable ordinary RAM, page-bounded {{target}}, scalar alias fallback
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
            {{kernel}}
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
    private static string EmitSse2(string prefix) => $$"""
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
            """;

    private static string EmitAvx2(string prefix) => $$"""
            vpxor ymm0, ymm0, ymm0
            vpxor ymm2, ymm2, ymm2
            vpxor ymm3, ymm3, ymm3
            vpxor ymm4, ymm4, ymm4
            vpxor ymm5, ymm5, ymm5
            ; Keep the common 16-byte page planner; bridge to 32-byte alignment.
            test rdi, 31
            jz {{prefix}}_avx2_aligned
            vmovdqa xmm1, [rdi]
            vpsadbw xmm1, xmm1, xmm0
            vpaddq ymm2, ymm2, ymm1
            add rdi, 16
            sub rsi, 16
            {{prefix}}_avx2_aligned:
            cmp rsi, 128
            jb {{prefix}}_avx2_single
            {{prefix}}_avx2_four:
            vmovdqa ymm1, [rdi]
            vpsadbw ymm1, ymm1, ymm0
            vpaddq ymm2, ymm2, ymm1
            vmovdqa ymm1, [rdi + 32]
            vpsadbw ymm1, ymm1, ymm0
            vpaddq ymm3, ymm3, ymm1
            vmovdqa ymm1, [rdi + 64]
            vpsadbw ymm1, ymm1, ymm0
            vpaddq ymm4, ymm4, ymm1
            vmovdqa ymm1, [rdi + 96]
            vpsadbw ymm1, ymm1, ymm0
            vpaddq ymm5, ymm5, ymm1
            add rdi, 128
            sub rsi, 128
            cmp rsi, 128
            jae {{prefix}}_avx2_four
            {{prefix}}_avx2_single:
            cmp rsi, 32
            jb {{prefix}}_avx2_sixteen
            {{prefix}}_avx2_thirtytwo:
            vmovdqa ymm1, [rdi]
            vpsadbw ymm1, ymm1, ymm0
            vpaddq ymm2, ymm2, ymm1
            add rdi, 32
            sub rsi, 32
            cmp rsi, 32
            jae {{prefix}}_avx2_thirtytwo
            {{prefix}}_avx2_sixteen:
            test rsi, rsi
            jz {{prefix}}_avx2_commit
            vmovdqa xmm1, [rdi]
            vpsadbw xmm1, xmm1, xmm0
            ; VEX128 clears the temporary's upper lanes, not the accumulator's.
            vpaddq ymm2, ymm2, ymm1
            add rdi, 16
            {{prefix}}_avx2_commit:
            vpaddq ymm2, ymm2, ymm3
            vpaddq ymm4, ymm4, ymm5
            vpaddq ymm2, ymm2, ymm4
            vextracti128 xmm1, ymm2, 1
            vpaddq xmm1, xmm1, xmm2
            vmovq rax, xmm1
            vpsrldq xmm1, xmm1, 8
            vmovq rsi, xmm1
            add rax, rsi
            vzeroupper
            """;
}
