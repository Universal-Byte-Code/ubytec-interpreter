module_646961676E6F737469635F6B65726E656C73_45cc3ec0d96b49fe822cfc4eda77457c_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 02:04:45Z
  ; Module UUID: 45cc3ec0-d96b-49fe-822c-fc4eda77457c


  section .bss

  section .text

  func_446961674964656E74697479_f9f5e02911074d189886b9d461812b87_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_f9f5e02911074d189886b9d461812b87_end
  func_446961674964656E74697479_f9f5e02911074d189886b9d461812b87_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_1549f3a5271c4c56a3270df8103e895f_start:
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
  while_fd725f04d678443eb62f26d47ca5d85a: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_e5674a36db1a4fcbbfa9274542c0b066
  push r9
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
    jmp while_fd725f04d678443eb62f26d47ca5d85a ; Reevaluate WHILE condition
  end_while_e5674a36db1a4fcbbfa9274542c0b066: ; END of while_fd725f04d678443eb62f26d47ca5d85a
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_1549f3a5271c4c56a3270df8103e895f_end
  func_446961674279746573_1549f3a5271c4c56a3270df8103e895f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_17b51d74c3584421a4e30e445fe87989_start:
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
  while_a3dc49626b24429a8a3aad6a295346bd: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_b56df9e5e429469baea55d069deea5d0
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
    jmp while_a3dc49626b24429a8a3aad6a295346bd ; Reevaluate WHILE condition
  end_while_b56df9e5e429469baea55d069deea5d0: ; END of while_a3dc49626b24429a8a3aad6a295346bd
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_17b51d74c3584421a4e30e445fe87989_end
  func_446961675265636F726473_17b51d74c3584421a4e30e445fe87989_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_a440a757be0743869120811d01846ee6_start:
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
  while_8e2232830d4748d2bdefcaaf9c982b70: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_e6e62c7607d142a3a12b1e8b7364151f
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
  if_c2f1e6b18d8a4077a9267f4a71bd4d29: ; IF start
  pop rax
    test rax, rax
    je end_if_6f21899c06094e0c9e87b5dd67fc9c21
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_448e8284ffab4819af55e29af16ffef2: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_bd25132acb9d4a4aae3a07220dc6558a
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
  if_0baebed4a2594bca8af50539a6ac3006: ; IF start
  pop rax
    test rax, rax
    je end_if_cec7a13c1aaa47a998d4eccabe811514
  jmp end_while_bd25132acb9d4a4aae3a07220dc6558a ; BREAK
  end_if_cec7a13c1aaa47a998d4eccabe811514: ; END of if_0baebed4a2594bca8af50539a6ac3006
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_448e8284ffab4819af55e29af16ffef2 ; Reevaluate WHILE condition
  end_while_bd25132acb9d4a4aae3a07220dc6558a: ; END of while_448e8284ffab4819af55e29af16ffef2
  if_a43169130e2f42a5ba498ba103bc7d64: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_d6a930eb0d9d428196c61dae659e78df
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_a440a757be0743869120811d01846ee6_end
  end_if_d6a930eb0d9d428196c61dae659e78df: ; END of if_a43169130e2f42a5ba498ba103bc7d64
  end_if_6f21899c06094e0c9e87b5dd67fc9c21: ; END of if_c2f1e6b18d8a4077a9267f4a71bd4d29
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_8e2232830d4748d2bdefcaaf9c982b70 ; Reevaluate WHILE condition
  end_while_e6e62c7607d142a3a12b1e8b7364151f: ; END of while_8e2232830d4748d2bdefcaaf9c982b70
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_a440a757be0743869120811d01846ee6_end
  func_446961674C6F6F6B7570_a440a757be0743869120811d01846ee6_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_45cc3ec0d96b49fe822cfc4eda77457c_end:
section .text
global ubytec_host_contract_Find
ubytec_host_contract_Find:
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
push rdx
push rcx
call func_446961674C6F6F6B7570_a440a757be0743869120811d01846ee6_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,70,105,110,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,70,105,110,100,124,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,78,68,10
section .text
global ubytec_host_candidate_DiagLookup
ubytec_host_candidate_DiagLookup:
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
push rdx
push rcx
call func_446961674C6F6F6B7570_a440a757be0743869120811d01846ee6_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
