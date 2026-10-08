module_646961676E6F737469635F6B65726E656C73_c846c5d8b77d4d05aa8a07e758e2c713_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:19:12Z
  ; Module UUID: c846c5d8-b77d-4d05-aa8a-07e758e2c713


  section .bss

  section .text

  func_446961674964656E74697479_f9fe02fc00e2473da022b748b81748b9_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_f9fe02fc00e2473da022b748b81748b9_end
  func_446961674964656E74697479_f9fe02fc00e2473da022b748b81748b9_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; block-reductions: stable ordinary RAM, page-bounded AVX2, scalar alias fallback
  mov rdx, qword [rbp + 24]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  cmp r8, r10
  jae func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_fallback
  mov rdi, rdx
  add rdi, r8
  jc func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_fallback
  mov rax, rdx
  add rax, r10
  jc func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_fallback
  mov rcx, rax
  dec rcx
  shr rcx, 47
  jnz func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_fallback
  cmp rdi, rbp
  jae func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_page
  lea rcx, [rsp - 24]
  cmp rax, rcx
  ja func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_fallback
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_page:
  cmp r8, r10
  jae func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_done
  lea rdi, [rdx + r8]
  test rdi, 15
  jnz func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_byte
  mov rcx, r10
  sub rcx, r8
  mov rsi, rdi
  and esi, 4095
  neg rsi
  add rsi, 4096
  cmp rsi, rcx
  cmova rsi, rcx
  and rsi, -16
  jz func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_byte
  ; Before the first read of this page segment reproduce the scalar ledger.
  mov qword [rsp - 8], r9
  mov qword [rsp - 24], r8
  mov qword [rsp - 16], rdi
  lea rsp, [rsp - 8]
  movzx eax, byte [rdi]
  ; The successful byte probe establishes readability of this unchanged
  ; ordinary-RAM page. Aligned vector reads stay in that page and input range.
  mov rcx, rsi
  vpxor ymm0, ymm0, ymm0
  vpxor ymm2, ymm2, ymm2
  vpxor ymm3, ymm3, ymm3
  vpxor ymm4, ymm4, ymm4
  vpxor ymm5, ymm5, ymm5
  ; Keep the common 16-byte page planner; bridge to 32-byte alignment.
  test rdi, 31
  jz func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_aligned
  vmovdqa xmm1, [rdi]
  vpsadbw xmm1, xmm1, xmm0
  vpaddq ymm2, ymm2, ymm1
  add rdi, 16
  sub rsi, 16
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_aligned:
  cmp rsi, 128
  jb func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_single
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_four:
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
  jae func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_four
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_single:
  cmp rsi, 32
  jb func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_sixteen
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_thirtytwo:
  vmovdqa ymm1, [rdi]
  vpsadbw ymm1, ymm1, ymm0
  vpaddq ymm2, ymm2, ymm1
  add rdi, 32
  sub rsi, 32
  cmp rsi, 32
  jae func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_thirtytwo
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_sixteen:
  test rsi, rsi
  jz func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_commit
  vmovdqa xmm1, [rdi]
  vpsadbw xmm1, xmm1, xmm0
  ; VEX128 clears the temporary's upper lanes, not the accumulator's.
  vpaddq ymm2, ymm2, ymm1
  add rdi, 16
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_avx2_commit:
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
  add r9, rax
  add r8, rcx
  mov qword [rbp - 16], r9
  mov qword [rbp - 8], r8
  ; Exact scalar back-edge image, including the final byte and prior index.
  mov qword [rsp], r8
  movzx eax, byte [rdi - 1]
  mov qword [rsp - 8], rax
  lea rax, [r8 - 1]
  mov qword [rsp - 16], rax
  lea rsp, [rsp + 8]
  jmp func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_page
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_byte:
  ; Alignment prefix and short tail retain one-byte access and fault order.
  mov qword [rsp - 8], r9
  mov qword [rsp - 24], r8
  mov qword [rsp - 16], rdi
  lea rsp, [rsp - 8]
  movzx eax, byte [rdi]
  mov qword [rsp - 8], rax
  add r9, rax
  mov qword [rbp - 16], r9
  inc r8
  mov qword [rbp - 8], r8
  lea rsp, [rsp + 8]
  mov qword [rsp - 8], r8
  jmp func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_page
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_done:
  mov rax, r9
  mov qword [rsp - 8], rax
  jmp func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_end
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_block_reduce_fallback:
  ; loop-reductions: scalar bytes, observable stack retained
  mov rdx, qword [rbp + 24]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_byte_reduce:
  cmp r8, r10
    jae func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_byte_reduce_done
  mov qword [rsp - 8], r9
  mov qword [rsp - 24], r8
  mov rcx, r8
    mov rax, rdx
    add rax, rcx
  mov qword [rsp - 16], rax
    lea rsp, [rsp - 8]
  movzx eax, byte [rax]
  mov qword [rsp - 8], rax
    add r9, rax
  mov qword [rbp - 16], r9
  inc r8
  mov qword [rbp - 8], r8
  lea rsp, [rsp + 8]
    mov qword [rsp - 8], r8
    jmp func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_byte_reduce
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start_byte_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_end
  func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_956e1228eeaf49a38dd01ab6147db7d9_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; frame-registers: write-through leaf values
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  while_9b214107df6b4ec2ad892a0eacf21a13: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_8a0bcf979d794e6bafb7dc881c7ee5cd
  push r9
  mov rax, qword [rbp + 24]
    push rax
  push r8
  mov rax, 0x0000000000000018
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    imul rax, rcx
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000010
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r9, rax
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_9b214107df6b4ec2ad892a0eacf21a13 ; Reevaluate WHILE condition
  end_while_8a0bcf979d794e6bafb7dc881c7ee5cd: ; END of while_9b214107df6b4ec2ad892a0eacf21a13
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_956e1228eeaf49a38dd01ab6147db7d9_end
  func_446961675265636F726473_956e1228eeaf49a38dd01ab6147db7d9_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_55c16de9aa4043dcacf03d081d1f490a_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 32], rax
  ; frame-registers: write-through leaf values
  mov r10, qword [rbp + 16]
  mov r9, qword [rbp - 8]
  mov r8, qword [rbp - 16]
  while_3d05acc3fa584bbea895cd44eecfa569: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_fefd4b00633d42eaaadfdad569d8606d
  mov rax, qword [rbp + 40]
    push rax
  push r9
  mov rax, 0x0000000000000018
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    imul rax, rcx
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, 0x0000000000000008
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
    push rax
  mov qword [rsp - 8], r10
  mov rcx, r10
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    push rax
  if_fcad5e6626f84a88b71a2a2106f7b186: ; IF start
  pop rax
    test rax, rax
    je end_if_6467767771174f789409c64de9632d9c
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_4d5996fc7d5e4d57bdaf36ea4c8b6d6b: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_bfcfb352ba834aa4a6ea45123137e958
  mov rax, qword [rbp - 32]
    push rax
  mov qword [rsp - 8], r8
  mov rcx, r8
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov qword [rsp - 8], r8
  mov rcx, r8
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    push rax
  if_e98770481c644a669affb984bcd6aee0: ; IF start
  pop rax
    test rax, rax
    je end_if_5fe49a4f05da4f9d840739cec0b6d138
  jmp end_while_bfcfb352ba834aa4a6ea45123137e958 ; BREAK
  end_if_5fe49a4f05da4f9d840739cec0b6d138: ; END of if_e98770481c644a669affb984bcd6aee0
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_4d5996fc7d5e4d57bdaf36ea4c8b6d6b ; Reevaluate WHILE condition
  end_while_bfcfb352ba834aa4a6ea45123137e958: ; END of while_4d5996fc7d5e4d57bdaf36ea4c8b6d6b
  if_c59055b19a7949c599ef66393c6bd8ca: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_0a3a5406c3db4a1b994bacf9463b75c1
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_55c16de9aa4043dcacf03d081d1f490a_end
  end_if_0a3a5406c3db4a1b994bacf9463b75c1: ; END of if_c59055b19a7949c599ef66393c6bd8ca
  end_if_6467767771174f789409c64de9632d9c: ; END of if_fcad5e6626f84a88b71a2a2106f7b186
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_3d05acc3fa584bbea895cd44eecfa569 ; Reevaluate WHILE condition
  end_while_fefd4b00633d42eaaadfdad569d8606d: ; END of while_3d05acc3fa584bbea895cd44eecfa569
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_55c16de9aa4043dcacf03d081d1f490a_end
  func_446961674C6F6F6B7570_55c16de9aa4043dcacf03d081d1f490a_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_c846c5d8b77d4d05aa8a07e758e2c713_end:
section .text
global ubytec_host_native_block_DiagBytes
ubytec_host_native_block_DiagBytes:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
sub rsp, 8
push rdi
push rsi
call func_446961674279746573_4e723ec7ff0b402b881abf94d95d3b17_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
