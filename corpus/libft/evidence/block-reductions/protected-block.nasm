module_646961676E6F737469635F6B65726E656C73_1bbb8fa8178040379adef12c962ca48c_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 00:01:50Z
  ; Module UUID: 1bbb8fa8-1780-4037-9ade-f12c962ca48c


  section .bss

  section .text

  func_446961674964656E74697479_20bc40725b3f4a299bae6d2353f6111a_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_446961674964656E74697479_20bc40725b3f4a299bae6d2353f6111a_end
  func_446961674964656E74697479_20bc40725b3f4a299bae6d2353f6111a_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start:
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
  jae func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_fallback
  mov rdi, rdx
  add rdi, r8
  jc func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_fallback
  mov rax, rdx
  add rax, r10
  jc func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_fallback
  mov rcx, rax
  dec rcx
  shr rcx, 47
  jnz func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_fallback
  cmp rdi, rbp
  jae func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_page
  lea rcx, [rsp - 24]
  cmp rax, rcx
  ja func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_fallback
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_page:
  cmp r8, r10
  jae func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_done
  lea rdi, [rdx + r8]
  test rdi, 15
  jnz func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_byte
  mov rcx, r10
  sub rcx, r8
  mov rsi, rdi
  and esi, 4095
  neg rsi
  add rsi, 4096
  cmp rsi, rcx
  cmova rsi, rcx
  and rsi, -16
  jz func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_byte
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
  jb func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_single
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_four:
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
  jae func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_four
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_single:
  test rsi, rsi
  jz func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_commit
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_sixteen:
  movdqa xmm1, [rdi]
  psadbw xmm1, xmm0
  paddq xmm2, xmm1
  add rdi, 16
  sub rsi, 16
  jnz func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_sixteen
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_commit:
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
  jmp func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_page
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_byte:
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
  jmp func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_page
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_done:
  mov rax, r9
  mov qword [rsp - 8], rax
  jmp func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_end
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_block_reduce_fallback:
  ; loop-reductions: scalar bytes, observable stack retained
  mov rdx, qword [rbp + 24]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_byte_reduce:
  cmp r8, r10
    jae func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_byte_reduce_done
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
    jmp func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_byte_reduce
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start_byte_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_end
  func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_789b644c6883405a9b9c3f2a8c924e52_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_c1aec8a2bc364337a6bb9253f76e1398: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_ddc288a97cc04899a457aaf14d871a54
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
    jmp while_c1aec8a2bc364337a6bb9253f76e1398 ; Reevaluate WHILE condition
  end_while_ddc288a97cc04899a457aaf14d871a54: ; END of while_c1aec8a2bc364337a6bb9253f76e1398
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_446961675265636F726473_789b644c6883405a9b9c3f2a8c924e52_end
  func_446961675265636F726473_789b644c6883405a9b9c3f2a8c924e52_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_e552f2e4e92e418ba87568ece63e5274_start:
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
  while_cdd7595390384de2b86736623ca88e48: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_f1b848c5c07d4bc08ddaacdb50c3b4b6
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
  if_2b13517d61b042c3b6b9385630681564: ; IF start
  pop rax
    test rax, rax
    je end_if_376b0226b2f24055b7cab2c964b92f1b
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
  while_e023b23334b341a9920d966185a6f36a: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_cbbe8d14ff8541348b70f9c95b0cac83
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
  if_272e9a62f88947f2af41cd5fae2bf48f: ; IF start
  pop rax
    test rax, rax
    je end_if_3b053b379b61419983dbccebb586538b
  jmp end_while_cbbe8d14ff8541348b70f9c95b0cac83 ; BREAK
  end_if_3b053b379b61419983dbccebb586538b: ; END of if_272e9a62f88947f2af41cd5fae2bf48f
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_e023b23334b341a9920d966185a6f36a ; Reevaluate WHILE condition
  end_while_cbbe8d14ff8541348b70f9c95b0cac83: ; END of while_e023b23334b341a9920d966185a6f36a
  if_1a39add4bb3a4b49b5048bdee5869c33: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_dc83f305f0624ceab96010b3e3fbbd23
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_e552f2e4e92e418ba87568ece63e5274_end
  end_if_dc83f305f0624ceab96010b3e3fbbd23: ; END of if_1a39add4bb3a4b49b5048bdee5869c33
  end_if_376b0226b2f24055b7cab2c964b92f1b: ; END of if_2b13517d61b042c3b6b9385630681564
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_cdd7595390384de2b86736623ca88e48 ; Reevaluate WHILE condition
  end_while_f1b848c5c07d4bc08ddaacdb50c3b4b6: ; END of while_cdd7595390384de2b86736623ca88e48
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_e552f2e4e92e418ba87568ece63e5274_end
  func_446961674C6F6F6B7570_e552f2e4e92e418ba87568ece63e5274_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_1bbb8fa8178040379adef12c962ca48c_end:
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
call func_446961674279746573_25798bc725a34d7da86cd2263b0f5cd2_start
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
