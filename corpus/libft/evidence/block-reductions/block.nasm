module_646961676E6F737469635F6B65726E656C73_23415e5eaccb44fca86b66d9d79921b8_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 00:06:46Z
  ; Module UUID: 23415e5e-accb-44fc-a86b-66d9d79921b8


  section .bss

  section .text

  func_446961674964656E74697479_b7969b54d5f14b33bd085eb07291461c_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_b7969b54d5f14b33bd085eb07291461c_end
  func_446961674964656E74697479_b7969b54d5f14b33bd085eb07291461c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; block-reductions: stable ordinary RAM, page-bounded SSE2, scalar alias fallback
  mov rdx, qword [rbp + 24]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  cmp r8, r10
  jae func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_fallback
  mov rdi, rdx
  add rdi, r8
  jc func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_fallback
  mov rax, rdx
  add rax, r10
  jc func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_fallback
  mov rcx, rax
  dec rcx
  shr rcx, 47
  jnz func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_fallback
  cmp rdi, rbp
  jae func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_page
  lea rcx, [rsp - 24]
  cmp rax, rcx
  ja func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_fallback
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_page:
  cmp r8, r10
  jae func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_done
  lea rdi, [rdx + r8]
  test rdi, 15
  jnz func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_byte
  mov rcx, r10
  sub rcx, r8
  mov rsi, rdi
  and esi, 4095
  neg rsi
  add rsi, 4096
  cmp rsi, rcx
  cmova rsi, rcx
  and rsi, -16
  jz func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_byte
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
  jb func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_single
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_four:
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
  jae func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_four
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_single:
  test rsi, rsi
  jz func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_commit
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_sixteen:
  movdqa xmm1, [rdi]
  psadbw xmm1, xmm0
  paddq xmm2, xmm1
  add rdi, 16
  sub rsi, 16
  jnz func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_sixteen
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_commit:
  paddq xmm2, xmm3
  paddq xmm4, xmm5
  paddq xmm2, xmm4
  movq rax, xmm2
  psrldq xmm2, 8
  movq rsi, xmm2
  add rax, rsi
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
  jmp func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_page
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_byte:
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
  jmp func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_page
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_done:
  mov rax, r9
  mov qword [rsp - 8], rax
  jmp func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_end
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_block_reduce_fallback:
  ; loop-reductions: scalar bytes, observable stack retained
  mov rdx, qword [rbp + 24]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_byte_reduce:
  cmp r8, r10
    jae func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_byte_reduce_done
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
    jmp func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_byte_reduce
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start_byte_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_end
  func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_372bc53aed4042d1a03f714551a694dc_start:
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
  while_bddc0b92293f4e0fbd7f44cbb88b05a8: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_d2d1c9842c3545cf85c1651dde743ffa
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
    jmp while_bddc0b92293f4e0fbd7f44cbb88b05a8 ; Reevaluate WHILE condition
  end_while_d2d1c9842c3545cf85c1651dde743ffa: ; END of while_bddc0b92293f4e0fbd7f44cbb88b05a8
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_372bc53aed4042d1a03f714551a694dc_end
  func_446961675265636F726473_372bc53aed4042d1a03f714551a694dc_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_0579cb283f05440692c3ee588092a09e_start:
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
  while_f54b16fa920b4f9688033d5010c1c7df: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_08bc55fe9b1f4fa4abb407fdf63d2070
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
  if_8bd6e9524eeb4d7da3375127711755f0: ; IF start
  pop rax
    test rax, rax
    je end_if_a1b2efb91aef4a32b32869fb8f856376
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_3a558dc161e844a6bb27d07da8577d0d: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_b0b59cac8453488ebc65b35cde44758b
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
  if_b438e0bb00234ffea545906c15fbbfdf: ; IF start
  pop rax
    test rax, rax
    je end_if_0d2e5fae82b14c75baa54b923622919c
  jmp end_while_b0b59cac8453488ebc65b35cde44758b ; BREAK
  end_if_0d2e5fae82b14c75baa54b923622919c: ; END of if_b438e0bb00234ffea545906c15fbbfdf
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_3a558dc161e844a6bb27d07da8577d0d ; Reevaluate WHILE condition
  end_while_b0b59cac8453488ebc65b35cde44758b: ; END of while_3a558dc161e844a6bb27d07da8577d0d
  if_1da04b059b17427ca2715ab8b65a466b: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_27dcf3078caf402db70ace7083b0c7f3
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_0579cb283f05440692c3ee588092a09e_end
  end_if_27dcf3078caf402db70ace7083b0c7f3: ; END of if_1da04b059b17427ca2715ab8b65a466b
  end_if_a1b2efb91aef4a32b32869fb8f856376: ; END of if_8bd6e9524eeb4d7da3375127711755f0
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_f54b16fa920b4f9688033d5010c1c7df ; Reevaluate WHILE condition
  end_while_08bc55fe9b1f4fa4abb407fdf63d2070: ; END of while_f54b16fa920b4f9688033d5010c1c7df
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_0579cb283f05440692c3ee588092a09e_end
  func_446961674C6F6F6B7570_0579cb283f05440692c3ee588092a09e_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_23415e5eaccb44fca86b66d9d79921b8_end:
section .text
global ubytec_host_block_DiagBytes
ubytec_host_block_DiagBytes:
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
call func_446961674279746573_a268f23fee4c4360aca8bc07852e5b46_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
