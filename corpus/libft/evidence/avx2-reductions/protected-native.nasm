module_646961676E6F737469635F6B65726E656C73_230d42a039354181a11cdf7e988f2acc_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:17:26Z
  ; Module UUID: 230d42a0-3935-4181-a11c-df7e988f2acc


  section .bss

  section .text

  func_446961674964656E74697479_8679fa09d1e14a1294d93c34337dd8b6_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_446961674964656E74697479_8679fa09d1e14a1294d93c34337dd8b6_end
  func_446961674964656E74697479_8679fa09d1e14a1294d93c34337dd8b6_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start:
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
  jae func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_fallback
  mov rdi, rdx
  add rdi, r8
  jc func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_fallback
  mov rax, rdx
  add rax, r10
  jc func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_fallback
  mov rcx, rax
  dec rcx
  shr rcx, 47
  jnz func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_fallback
  cmp rdi, rbp
  jae func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_page
  lea rcx, [rsp - 24]
  cmp rax, rcx
  ja func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_fallback
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_page:
  cmp r8, r10
  jae func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_done
  lea rdi, [rdx + r8]
  test rdi, 15
  jnz func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_byte
  mov rcx, r10
  sub rcx, r8
  mov rsi, rdi
  and esi, 4095
  neg rsi
  add rsi, 4096
  cmp rsi, rcx
  cmova rsi, rcx
  and rsi, -16
  jz func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_byte
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
  jz func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_aligned
  vmovdqa xmm1, [rdi]
  vpsadbw xmm1, xmm1, xmm0
  vpaddq ymm2, ymm2, ymm1
  add rdi, 16
  sub rsi, 16
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_aligned:
  cmp rsi, 128
  jb func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_single
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_four:
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
  jae func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_four
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_single:
  cmp rsi, 32
  jb func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_sixteen
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_thirtytwo:
  vmovdqa ymm1, [rdi]
  vpsadbw ymm1, ymm1, ymm0
  vpaddq ymm2, ymm2, ymm1
  add rdi, 32
  sub rsi, 32
  cmp rsi, 32
  jae func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_thirtytwo
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_sixteen:
  test rsi, rsi
  jz func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_commit
  vmovdqa xmm1, [rdi]
  vpsadbw xmm1, xmm1, xmm0
  ; VEX128 clears the temporary's upper lanes, not the accumulator's.
  vpaddq ymm2, ymm2, ymm1
  add rdi, 16
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_avx2_commit:
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
  jmp func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_page
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_byte:
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
  jmp func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_page
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_done:
  mov rax, r9
  mov qword [rsp - 8], rax
  jmp func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_end
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_block_reduce_fallback:
  ; loop-reductions: scalar bytes, observable stack retained
  mov rdx, qword [rbp + 24]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_byte_reduce:
  cmp r8, r10
    jae func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_byte_reduce_done
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
    jmp func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_byte_reduce
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start_byte_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_end
  func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_13960ff0acce451fa1dfd506b65f3dc6_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_e8c5155686c843aba2f267bf0eacd64d: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_61fba8938dc84f889d06c954a2498439
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_e8c5155686c843aba2f267bf0eacd64d ; Reevaluate WHILE condition
  end_while_61fba8938dc84f889d06c954a2498439: ; END of while_e8c5155686c843aba2f267bf0eacd64d
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_446961675265636F726473_13960ff0acce451fa1dfd506b65f3dc6_end
  func_446961675265636F726473_13960ff0acce451fa1dfd506b65f3dc6_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_0fa0ac3c7742443383d10b964cdb97cf_start:
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
  while_4b33a10f10f6453a98fcf8d2e9774ba3: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_c2c6f24bff4e47cea5158a2ef614c9dd
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, 0x0000000000000008
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    push rax
  if_77633f741d7246ee94f25e22ab7bb839: ; IF start
  pop rax
    test rax, rax
    je end_if_e8361e06bbd749f4855f04db432bdd1d
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  while_8ad22d2528d54d49ba90981c9ce17521: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_919cb015aeec4e1ca578feb1eb6f416c
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    push rax
  if_80060b8f4622441495f33ea4c7b572f3: ; IF start
  pop rax
    test rax, rax
    je end_if_83327b0f6d06410ebb6a078859fbe558
  jmp end_while_919cb015aeec4e1ca578feb1eb6f416c ; BREAK
  end_if_83327b0f6d06410ebb6a078859fbe558: ; END of if_80060b8f4622441495f33ea4c7b572f3
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_8ad22d2528d54d49ba90981c9ce17521 ; Reevaluate WHILE condition
  end_while_919cb015aeec4e1ca578feb1eb6f416c: ; END of while_8ad22d2528d54d49ba90981c9ce17521
  if_7297ee1299c44961a3ca264f8c2f5391: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_5b67d986c692450fb977faf27993b3c7
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_0fa0ac3c7742443383d10b964cdb97cf_end
  end_if_5b67d986c692450fb977faf27993b3c7: ; END of if_7297ee1299c44961a3ca264f8c2f5391
  end_if_e8361e06bbd749f4855f04db432bdd1d: ; END of if_77633f741d7246ee94f25e22ab7bb839
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_4b33a10f10f6453a98fcf8d2e9774ba3 ; Reevaluate WHILE condition
  end_while_c2c6f24bff4e47cea5158a2ef614c9dd: ; END of while_4b33a10f10f6453a98fcf8d2e9774ba3
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_0fa0ac3c7742443383d10b964cdb97cf_end
  func_446961674C6F6F6B7570_0fa0ac3c7742443383d10b964cdb97cf_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_230d42a039354181a11cdf7e988f2acc_end:
section .text
global ubytec_host_contract_Fold
ubytec_host_contract_Fold:
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
call func_446961674279746573_e1d8abf84d9142919c55efdf40afff44_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,70,111,108,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,70,111,108,100,124,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
