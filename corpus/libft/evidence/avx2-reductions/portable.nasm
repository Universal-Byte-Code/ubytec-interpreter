module_646961676E6F737469635F6B65726E656C73_4bd7a663eeb14124ac2848640c442723_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:19:15Z
  ; Module UUID: 4bd7a663-eeb1-4124-ac28-48640c442723


  section .bss

  section .text

  func_446961674964656E74697479_064c63169e574971860259acf8e9f73a_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_064c63169e574971860259acf8e9f73a_end
  func_446961674964656E74697479_064c63169e574971860259acf8e9f73a_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start:
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
  jae func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_fallback
  mov rdi, rdx
  add rdi, r8
  jc func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_fallback
  mov rax, rdx
  add rax, r10
  jc func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_fallback
  mov rcx, rax
  dec rcx
  shr rcx, 47
  jnz func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_fallback
  cmp rdi, rbp
  jae func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_page
  lea rcx, [rsp - 24]
  cmp rax, rcx
  ja func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_fallback
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_page:
  cmp r8, r10
  jae func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_done
  lea rdi, [rdx + r8]
  test rdi, 15
  jnz func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_byte
  mov rcx, r10
  sub rcx, r8
  mov rsi, rdi
  and esi, 4095
  neg rsi
  add rsi, 4096
  cmp rsi, rcx
  cmova rsi, rcx
  and rsi, -16
  jz func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_byte
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
  jb func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_single
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_four:
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
  jae func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_four
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_single:
  test rsi, rsi
  jz func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_commit
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_sixteen:
  movdqa xmm1, [rdi]
  psadbw xmm1, xmm0
  paddq xmm2, xmm1
  add rdi, 16
  sub rsi, 16
  jnz func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_sixteen
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_commit:
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
  jmp func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_page
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_byte:
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
  jmp func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_page
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_done:
  mov rax, r9
  mov qword [rsp - 8], rax
  jmp func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_end
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_block_reduce_fallback:
  ; loop-reductions: scalar bytes, observable stack retained
  mov rdx, qword [rbp + 24]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_byte_reduce:
  cmp r8, r10
    jae func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_byte_reduce_done
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
    jmp func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_byte_reduce
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start_byte_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_end
  func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_9a6c2a4d43f0480d9e21848086c7bf5c_start:
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
  while_86147c9c62fd491094d7758376b5e767: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_1bceebb4cc8c4d02bb743dfbb3bf4f25
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
    jmp while_86147c9c62fd491094d7758376b5e767 ; Reevaluate WHILE condition
  end_while_1bceebb4cc8c4d02bb743dfbb3bf4f25: ; END of while_86147c9c62fd491094d7758376b5e767
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_9a6c2a4d43f0480d9e21848086c7bf5c_end
  func_446961675265636F726473_9a6c2a4d43f0480d9e21848086c7bf5c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_905ffee06a4044d58c2aab658339cb24_start:
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
  while_c1643cf7a0164e5397e17161f4d0877d: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_08521a6a4f0649c3a35e205209dac00b
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
  if_e44b0103e3654c17befc06ec928c8edb: ; IF start
  pop rax
    test rax, rax
    je end_if_f186887ceec94cb3a02ab29f711a5b64
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_508cd29eb8584bb48d8a0c21be8506b1: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_9ebeb53dde5941379302a6f94e4eb3fd
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
  if_0b43f00e75b542179c22391853482db2: ; IF start
  pop rax
    test rax, rax
    je end_if_7ff9bf8e56df4a159c3c495796ecae46
  jmp end_while_9ebeb53dde5941379302a6f94e4eb3fd ; BREAK
  end_if_7ff9bf8e56df4a159c3c495796ecae46: ; END of if_0b43f00e75b542179c22391853482db2
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_508cd29eb8584bb48d8a0c21be8506b1 ; Reevaluate WHILE condition
  end_while_9ebeb53dde5941379302a6f94e4eb3fd: ; END of while_508cd29eb8584bb48d8a0c21be8506b1
  if_7eaa4529d5a44b2baef06701a4808c0a: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_37eb1302d52f42b9984dc3c1797b9a43
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_905ffee06a4044d58c2aab658339cb24_end
  end_if_37eb1302d52f42b9984dc3c1797b9a43: ; END of if_7eaa4529d5a44b2baef06701a4808c0a
  end_if_f186887ceec94cb3a02ab29f711a5b64: ; END of if_e44b0103e3654c17befc06ec928c8edb
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_c1643cf7a0164e5397e17161f4d0877d ; Reevaluate WHILE condition
  end_while_08521a6a4f0649c3a35e205209dac00b: ; END of while_c1643cf7a0164e5397e17161f4d0877d
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_905ffee06a4044d58c2aab658339cb24_end
  func_446961674C6F6F6B7570_905ffee06a4044d58c2aab658339cb24_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_4bd7a663eeb14124ac2848640c442723_end:
section .text
global ubytec_host_portable_DiagBytes
ubytec_host_portable_DiagBytes:
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
call func_446961674279746573_24e921b7df8d4a81b58883960ac66d07_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
