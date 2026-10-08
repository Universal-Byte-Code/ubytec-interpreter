bits 64
section .text
global candidate_scalar4
global candidate_sse2
global candidate_avx2

; Experimental System V RAM reductions. They are not Ubytec opcode lowering.
; Inputs: RDI=data, RSI=length. Result: RAX=unsigned sum modulo 2^64.
candidate_scalar4:
    xor eax, eax
    xor r8d, r8d
    xor r9d, r9d
    xor r10d, r10d
    cmp rsi, 4
    jb .finish
.loop:
    movzx edx, byte [rdi]
    add rax, rdx
    movzx edx, byte [rdi + 1]
    add r8, rdx
    movzx edx, byte [rdi + 2]
    add r9, rdx
    movzx edx, byte [rdi + 3]
    add r10, rdx
    add rdi, 4
    sub rsi, 4
    cmp rsi, 4
    jae .loop
.finish:
    add rax, r8
    add rax, r9
    add rax, r10
    test rsi, rsi
    jz .done
.tail:
    movzx edx, byte [rdi]
    add rax, rdx
    inc rdi
    dec rsi
    jnz .tail
.done:
    ret

candidate_sse2:
    pxor xmm0, xmm0
    pxor xmm2, xmm2
    cmp rsi, 16
    jb .finish
.loop:
    movdqu xmm1, [rdi]
    psadbw xmm1, xmm0
    paddq xmm2, xmm1
    add rdi, 16
    sub rsi, 16
    cmp rsi, 16
    jae .loop
.finish:
    movq rax, xmm2
    psrldq xmm2, 8
    movq rdx, xmm2
    add rax, rdx
    test rsi, rsi
    jz .done
.tail:
    movzx edx, byte [rdi]
    add rax, rdx
    inc rdi
    dec rsi
    jnz .tail
.done:
    ret

candidate_avx2:
    vpxor ymm0, ymm0, ymm0
    vpxor ymm8, ymm8, ymm8
    vpxor ymm9, ymm9, ymm9
    vpxor ymm10, ymm10, ymm10
    vpxor ymm11, ymm11, ymm11
    cmp rsi, 128
    jb .single
.loop:
    vmovdqu ymm1, [rdi]
    vmovdqu ymm2, [rdi + 32]
    vmovdqu ymm3, [rdi + 64]
    vmovdqu ymm4, [rdi + 96]
    vpsadbw ymm1, ymm1, ymm0
    vpsadbw ymm2, ymm2, ymm0
    vpsadbw ymm3, ymm3, ymm0
    vpsadbw ymm4, ymm4, ymm0
    vpaddq ymm8, ymm8, ymm1
    vpaddq ymm9, ymm9, ymm2
    vpaddq ymm10, ymm10, ymm3
    vpaddq ymm11, ymm11, ymm4
    add rdi, 128
    sub rsi, 128
    cmp rsi, 128
    jae .loop
.single:
    cmp rsi, 32
    jb .finish
.single_loop:
    vmovdqu ymm1, [rdi]
    vpsadbw ymm1, ymm1, ymm0
    vpaddq ymm8, ymm8, ymm1
    add rdi, 32
    sub rsi, 32
    cmp rsi, 32
    jae .single_loop
.finish:
    vpaddq ymm8, ymm8, ymm9
    vpaddq ymm10, ymm10, ymm11
    vpaddq ymm8, ymm8, ymm10
    vextracti128 xmm1, ymm8, 1
    vpaddq xmm1, xmm1, xmm8
    vmovq rax, xmm1
    vpsrldq xmm1, xmm1, 8
    vmovq rdx, xmm1
    add rax, rdx
    vzeroupper
    test rsi, rsi
    jz .done
.tail:
    movzx edx, byte [rdi]
    add rax, rdx
    inc rdi
    dec rsi
    jnz .tail
.done:
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
