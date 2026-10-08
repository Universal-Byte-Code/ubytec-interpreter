module_646961676E6F737469635F6B65726E656C73_71183424a5d84a6b9c544a8ae2c6bfaf_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:17:25Z
  ; Module UUID: 71183424-a5d8-4a6b-9c54-4a8ae2c6bfaf


  section .bss

  section .text

  func_446961674964656E74697479_3ba7187937c249f1978ba09f7bc3c002_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_446961674964656E74697479_3ba7187937c249f1978ba09f7bc3c002_end
  func_446961674964656E74697479_3ba7187937c249f1978ba09f7bc3c002_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start:
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
  jae func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_fallback
  mov rdi, rdx
  add rdi, r8
  jc func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_fallback
  mov rax, rdx
  add rax, r10
  jc func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_fallback
  mov rcx, rax
  dec rcx
  shr rcx, 47
  jnz func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_fallback
  cmp rdi, rbp
  jae func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_page
  lea rcx, [rsp - 24]
  cmp rax, rcx
  ja func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_fallback
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_page:
  cmp r8, r10
  jae func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_done
  lea rdi, [rdx + r8]
  test rdi, 15
  jnz func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_byte
  mov rcx, r10
  sub rcx, r8
  mov rsi, rdi
  and esi, 4095
  neg rsi
  add rsi, 4096
  cmp rsi, rcx
  cmova rsi, rcx
  and rsi, -16
  jz func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_byte
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
  jb func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_single
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_four:
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
  jae func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_four
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_single:
  test rsi, rsi
  jz func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_commit
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_sixteen:
  movdqa xmm1, [rdi]
  psadbw xmm1, xmm0
  paddq xmm2, xmm1
  add rdi, 16
  sub rsi, 16
  jnz func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_sixteen
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_commit:
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
  jmp func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_page
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_byte:
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
  jmp func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_page
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_done:
  mov rax, r9
  mov qword [rsp - 8], rax
  jmp func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_end
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_block_reduce_fallback:
  ; loop-reductions: scalar bytes, observable stack retained
  mov rdx, qword [rbp + 24]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_byte_reduce:
  cmp r8, r10
    jae func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_byte_reduce_done
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
    jmp func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_byte_reduce
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start_byte_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_end
  func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_9adfcda6df21434a9ce5c4eddaf4a37f_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_2be6f2dcc74e4d71ab936d9204ce407f: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_ebc42b968611401eaa6fdf286cbea5cb
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
    jmp while_2be6f2dcc74e4d71ab936d9204ce407f ; Reevaluate WHILE condition
  end_while_ebc42b968611401eaa6fdf286cbea5cb: ; END of while_2be6f2dcc74e4d71ab936d9204ce407f
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_446961675265636F726473_9adfcda6df21434a9ce5c4eddaf4a37f_end
  func_446961675265636F726473_9adfcda6df21434a9ce5c4eddaf4a37f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_d7548ff7546748e0a05ea129c7a6d7fd_start:
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
  while_df1f11f3db5e43fa90c902bc6f810398: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_c7a31ab0ecff45a7a383f8120feec005
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
  if_c3ea9209a865453ebd8a12978efbdc39: ; IF start
  pop rax
    test rax, rax
    je end_if_4345218803e24b27ac6d7ca7a6d34ae7
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
  while_59d531ad0bc940fc829fa6c9947ab491: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_3812e90aac954fe6857f5f0dea55bd5a
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
  if_bd60fd4e9d9e44c3a1ddc773287e6dcf: ; IF start
  pop rax
    test rax, rax
    je end_if_655f9b1a2a4a4fc8893c2f3c72d6fc2d
  jmp end_while_3812e90aac954fe6857f5f0dea55bd5a ; BREAK
  end_if_655f9b1a2a4a4fc8893c2f3c72d6fc2d: ; END of if_bd60fd4e9d9e44c3a1ddc773287e6dcf
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_59d531ad0bc940fc829fa6c9947ab491 ; Reevaluate WHILE condition
  end_while_3812e90aac954fe6857f5f0dea55bd5a: ; END of while_59d531ad0bc940fc829fa6c9947ab491
  if_479f367c3de7414bb9f994cf8ce4d32f: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_8ec10e519a744e678a98d614c87fea88
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_d7548ff7546748e0a05ea129c7a6d7fd_end
  end_if_8ec10e519a744e678a98d614c87fea88: ; END of if_479f367c3de7414bb9f994cf8ce4d32f
  end_if_4345218803e24b27ac6d7ca7a6d34ae7: ; END of if_c3ea9209a865453ebd8a12978efbdc39
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_df1f11f3db5e43fa90c902bc6f810398 ; Reevaluate WHILE condition
  end_while_c7a31ab0ecff45a7a383f8120feec005: ; END of while_df1f11f3db5e43fa90c902bc6f810398
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_d7548ff7546748e0a05ea129c7a6d7fd_end
  func_446961674C6F6F6B7570_d7548ff7546748e0a05ea129c7a6d7fd_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_71183424a5d84a6b9c544a8ae2c6bfaf_end:
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
call func_446961674279746573_a9af7da296e4453d9b3cb0e669b6ff14_start
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
