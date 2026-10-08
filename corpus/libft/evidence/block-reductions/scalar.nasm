module_646961676E6F737469635F6B65726E656C73_205891b93a8f47679d623a4e02176bd1_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 00:06:43Z
  ; Module UUID: 205891b9-3a8f-4767-9d62-3a4e02176bd1


  section .bss

  section .text

  func_446961674964656E74697479_86ed9b953bbd45008185c6840f05cb46_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_86ed9b953bbd45008185c6840f05cb46_end
  func_446961674964656E74697479_86ed9b953bbd45008185c6840f05cb46_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_bf5639c7b2e54559a0bdc5601c82b6ce_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; loop-reductions: scalar bytes, observable stack retained
  mov rdx, qword [rbp + 24]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  func_446961674279746573_bf5639c7b2e54559a0bdc5601c82b6ce_start_byte_reduce:
  cmp r8, r10
    jae func_446961674279746573_bf5639c7b2e54559a0bdc5601c82b6ce_start_byte_reduce_done
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
    jmp func_446961674279746573_bf5639c7b2e54559a0bdc5601c82b6ce_start_byte_reduce
  func_446961674279746573_bf5639c7b2e54559a0bdc5601c82b6ce_start_byte_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961674279746573_bf5639c7b2e54559a0bdc5601c82b6ce_end
  func_446961674279746573_bf5639c7b2e54559a0bdc5601c82b6ce_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_db7aed93d943490d9337e71abed14bcf_start:
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
  while_f6ab512e6a644981969fccd1d8e62f37: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_15c2da4d9a294f3ab8fe0324cccfee95
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
    jmp while_f6ab512e6a644981969fccd1d8e62f37 ; Reevaluate WHILE condition
  end_while_15c2da4d9a294f3ab8fe0324cccfee95: ; END of while_f6ab512e6a644981969fccd1d8e62f37
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_db7aed93d943490d9337e71abed14bcf_end
  func_446961675265636F726473_db7aed93d943490d9337e71abed14bcf_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_a481c9a74ed84ddd8446053dc6eb4b41_start:
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
  while_11892757b4854d4caf19309e52c24d74: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_78b529e4b544460fb4868c08a2fb7632
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
  if_7cf913c850f94919b2e958cceea86ebb: ; IF start
  pop rax
    test rax, rax
    je end_if_511cdf42a6924e8d951697db16b1126f
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_4c78cfba352142c590c69cdae70fe2a0: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_f57626e665764786985ff6a1b868a746
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
  if_d37a522334d6439fa400b19d09488213: ; IF start
  pop rax
    test rax, rax
    je end_if_d5c0f3f7ddd944dd8075eacc6fbc11fb
  jmp end_while_f57626e665764786985ff6a1b868a746 ; BREAK
  end_if_d5c0f3f7ddd944dd8075eacc6fbc11fb: ; END of if_d37a522334d6439fa400b19d09488213
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_4c78cfba352142c590c69cdae70fe2a0 ; Reevaluate WHILE condition
  end_while_f57626e665764786985ff6a1b868a746: ; END of while_4c78cfba352142c590c69cdae70fe2a0
  if_d0a741edff7c474a8b4b8c384b0a7a38: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_8efe4adbbfda424b8870c3634bd9940f
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_a481c9a74ed84ddd8446053dc6eb4b41_end
  end_if_8efe4adbbfda424b8870c3634bd9940f: ; END of if_d0a741edff7c474a8b4b8c384b0a7a38
  end_if_511cdf42a6924e8d951697db16b1126f: ; END of if_7cf913c850f94919b2e958cceea86ebb
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_11892757b4854d4caf19309e52c24d74 ; Reevaluate WHILE condition
  end_while_78b529e4b544460fb4868c08a2fb7632: ; END of while_11892757b4854d4caf19309e52c24d74
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_a481c9a74ed84ddd8446053dc6eb4b41_end
  func_446961674C6F6F6B7570_a481c9a74ed84ddd8446053dc6eb4b41_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_205891b93a8f47679d623a4e02176bd1_end:
section .text
global ubytec_host_loop_DiagBytes
ubytec_host_loop_DiagBytes:
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
call func_446961674279746573_bf5639c7b2e54559a0bdc5601c82b6ce_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
