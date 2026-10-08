module_646961676E6F737469635F6B65726E656C73_39b097732e584d0fa3950a4e943edf58_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 20:40:43Z
  ; Module UUID: 39b09773-2e58-4d0f-a395-0a4e943edf58


  section .bss

  section .text

  func_446961674964656E74697479_9a927b7d3c3242739713550fc80d8306_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_446961674964656E74697479_9a927b7d3c3242739713550fc80d8306_end
  func_446961674964656E74697479_9a927b7d3c3242739713550fc80d8306_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_de896da15614408199a426e5dc8e71a1_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_1f4cf683a0af48fab7334d66b8e81011: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_92f1d0d50b02490294c34226c972f801
  
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
    jmp while_1f4cf683a0af48fab7334d66b8e81011 ; Reevaluate WHILE condition
  end_while_92f1d0d50b02490294c34226c972f801: ; END of while_1f4cf683a0af48fab7334d66b8e81011
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_446961674279746573_de896da15614408199a426e5dc8e71a1_end
  func_446961674279746573_de896da15614408199a426e5dc8e71a1_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_02858017e6ad44a8a71ee548f9156c4b_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_7865eff665134944a10188a66eb3291d: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_fe0df87917af41db9edb9af458adf0f9
  
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
    jmp while_7865eff665134944a10188a66eb3291d ; Reevaluate WHILE condition
  end_while_fe0df87917af41db9edb9af458adf0f9: ; END of while_7865eff665134944a10188a66eb3291d
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_446961675265636F726473_02858017e6ad44a8a71ee548f9156c4b_end
  func_446961675265636F726473_02858017e6ad44a8a71ee548f9156c4b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_b4c12504f5c44e56aefa10f4b85d1c69_start:
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
  while_dab571a86e5542468e0aafd0175ef37c: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_ac0dc38e539943008c9491d3e5f5434b
  
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
  if_3130c5b2d89c47b69904770d0c18b95c: ; IF start
  pop rax
    test rax, rax
    je end_if_41cfa60656824046aeb9700bd619228d
  
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
  while_1a99cc1f6051421b8c708067c17b3df9: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_ae6dd500f65d471cb5772c749440ae89
  
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
  if_2e3ca727ec904d1f9abb1792147447aa: ; IF start
  pop rax
    test rax, rax
    je end_if_6d8c757f667c46b498f6ea2535e3d98e
  
  jmp end_while_ae6dd500f65d471cb5772c749440ae89 ; BREAK
  end_if_6d8c757f667c46b498f6ea2535e3d98e: ; END of if_2e3ca727ec904d1f9abb1792147447aa
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_1a99cc1f6051421b8c708067c17b3df9 ; Reevaluate WHILE condition
  end_while_ae6dd500f65d471cb5772c749440ae89: ; END of while_1a99cc1f6051421b8c708067c17b3df9
  
  if_0f2db85fa9cf4be2a2f050837e208601: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_f5d9126255464054a645b58fb8491869
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_b4c12504f5c44e56aefa10f4b85d1c69_end
  end_if_f5d9126255464054a645b58fb8491869: ; END of if_0f2db85fa9cf4be2a2f050837e208601
  
  end_if_41cfa60656824046aeb9700bd619228d: ; END of if_3130c5b2d89c47b69904770d0c18b95c
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_dab571a86e5542468e0aafd0175ef37c ; Reevaluate WHILE condition
  end_while_ac0dc38e539943008c9491d3e5f5434b: ; END of while_dab571a86e5542468e0aafd0175ef37c
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_b4c12504f5c44e56aefa10f4b85d1c69_end
  func_446961674C6F6F6B7570_b4c12504f5c44e56aefa10f4b85d1c69_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_39b097732e584d0fa3950a4e943edf58_end:
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
call func_446961674964656E74697479_9a927b7d3c3242739713550fc80d8306_start
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
call func_446961674279746573_de896da15614408199a426e5dc8e71a1_start
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
call func_446961675265636F726473_02858017e6ad44a8a71ee548f9156c4b_start
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
call func_446961674C6F6F6B7570_b4c12504f5c44e56aefa10f4b85d1c69_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
