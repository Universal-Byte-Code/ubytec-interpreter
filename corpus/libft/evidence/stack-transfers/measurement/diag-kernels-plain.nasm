module_646961676E6F737469635F6B65726E656C73_7ee5f75a5de14e64b9d58cc3f102cce3_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 21:32:17Z
  ; Module UUID: 7ee5f75a-5de1-4e64-b9d5-8cc3f102cce3


  section .bss

  section .text

  func_446961674964656E74697479_9d507ad020f3405fb095bae9258ab454_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_446961674964656E74697479_9d507ad020f3405fb095bae9258ab454_end
  func_446961674964656E74697479_9d507ad020f3405fb095bae9258ab454_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_2c0a1bf458ac4bf6971f5ba7058bb796_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_8c7c567de2b14e0da2fdce6ff156371a: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_48076fbaa2c64bd6b79d4580f7e574f2
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 8]
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
    jmp while_8c7c567de2b14e0da2fdce6ff156371a ; Reevaluate WHILE condition
  end_while_48076fbaa2c64bd6b79d4580f7e574f2: ; END of while_8c7c567de2b14e0da2fdce6ff156371a
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_446961674279746573_2c0a1bf458ac4bf6971f5ba7058bb796_end
  func_446961674279746573_2c0a1bf458ac4bf6971f5ba7058bb796_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_c68cd2908f45448bb7b3d32932aa0510_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_99763dcba15544feada2ee2c61ef0012: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_07f9183cbccb441e85222f3672c59c9a
  
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
    jmp while_99763dcba15544feada2ee2c61ef0012 ; Reevaluate WHILE condition
  end_while_07f9183cbccb441e85222f3672c59c9a: ; END of while_99763dcba15544feada2ee2c61ef0012
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_446961675265636F726473_c68cd2908f45448bb7b3d32932aa0510_end
  func_446961675265636F726473_c68cd2908f45448bb7b3d32932aa0510_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_ee90c9b7a1bf4a1490da4734f4fab012_start:
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
  while_efcb9aa134cf48e491f5730716d7c8ec: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_1400f23a51034844ac73d1b4684dc507
  
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
  if_5bc7b0fdb43b485f8dda0a715070b30e: ; IF start
  pop rax
    test rax, rax
    je end_if_db95393fcf2c45b4a6a8738a55f6cecd
  
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
  while_886fe49b627c4ed1b9f74110d9a19a8a: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_f1e46cbebf43402fa5cdf9c69117cf7f
  
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
  if_dfd4bc7667bf4513b441ae5b4b335b14: ; IF start
  pop rax
    test rax, rax
    je end_if_f53d273101a54b0c9ac8f9a1319fd923
  
  jmp end_while_f1e46cbebf43402fa5cdf9c69117cf7f ; BREAK
  end_if_f53d273101a54b0c9ac8f9a1319fd923: ; END of if_dfd4bc7667bf4513b441ae5b4b335b14
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_886fe49b627c4ed1b9f74110d9a19a8a ; Reevaluate WHILE condition
  end_while_f1e46cbebf43402fa5cdf9c69117cf7f: ; END of while_886fe49b627c4ed1b9f74110d9a19a8a
  
  if_a55383349de147b69d458e04ca89b987: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_e674233ee5f84a42846cf42353117e8b
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_ee90c9b7a1bf4a1490da4734f4fab012_end
  end_if_e674233ee5f84a42846cf42353117e8b: ; END of if_a55383349de147b69d458e04ca89b987
  
  end_if_db95393fcf2c45b4a6a8738a55f6cecd: ; END of if_5bc7b0fdb43b485f8dda0a715070b30e
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_efcb9aa134cf48e491f5730716d7c8ec ; Reevaluate WHILE condition
  end_while_1400f23a51034844ac73d1b4684dc507: ; END of while_efcb9aa134cf48e491f5730716d7c8ec
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_ee90c9b7a1bf4a1490da4734f4fab012_end
  func_446961674C6F6F6B7570_ee90c9b7a1bf4a1490da4734f4fab012_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_7ee5f75a5de14e64b9d58cc3f102cce3_end:
section .text
global ubytec_host_contract_DiagIdentity
ubytec_host_contract_DiagIdentity:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
call func_446961674964656E74697479_9d507ad020f3405fb095bae9258ab454_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_contract_DiagBytes
ubytec_host_contract_DiagBytes:
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
call func_446961674279746573_2c0a1bf458ac4bf6971f5ba7058bb796_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_contract_DiagRecords
ubytec_host_contract_DiagRecords:
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
call func_446961675265636F726473_c68cd2908f45448bb7b3d32932aa0510_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_contract_DiagLookup
ubytec_host_contract_DiagLookup:
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
call func_446961674C6F6F6B7570_ee90c9b7a1bf4a1490da4734f4fab012_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
