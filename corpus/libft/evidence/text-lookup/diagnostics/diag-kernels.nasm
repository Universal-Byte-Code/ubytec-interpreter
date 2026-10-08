module_646961676E6F737469635F6B65726E656C73_f65fa17dc8b248c78068dca1f5f6fb44_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 21:08:09Z
  ; Module UUID: f65fa17d-c8b2-48c7-8068-dca1f5f6fb44


  section .bss

  section .text

  func_446961674964656E74697479_ca7cbd8939114ad2b8cb2d28d7f775e0_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_446961674964656E74697479_ca7cbd8939114ad2b8cb2d28d7f775e0_end
  func_446961674964656E74697479_ca7cbd8939114ad2b8cb2d28d7f775e0_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_56534e4fc9c14708a246a5c20b9e63e9_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_fa9e9ee6fa1244b18a725dca0cc22b24: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_4fde86f53616489b9f7bed603204b2f8
  
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
    jmp while_fa9e9ee6fa1244b18a725dca0cc22b24 ; Reevaluate WHILE condition
  end_while_4fde86f53616489b9f7bed603204b2f8: ; END of while_fa9e9ee6fa1244b18a725dca0cc22b24
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_446961674279746573_56534e4fc9c14708a246a5c20b9e63e9_end
  func_446961674279746573_56534e4fc9c14708a246a5c20b9e63e9_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_a76908e5273348898f111a2c7124a8ba_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_532af519a02541b6b9ed9bb7965d3cf3: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_a4a0eccaf0d043d59c4ca0015bf3e935
  
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
    jmp while_532af519a02541b6b9ed9bb7965d3cf3 ; Reevaluate WHILE condition
  end_while_a4a0eccaf0d043d59c4ca0015bf3e935: ; END of while_532af519a02541b6b9ed9bb7965d3cf3
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_446961675265636F726473_a76908e5273348898f111a2c7124a8ba_end
  func_446961675265636F726473_a76908e5273348898f111a2c7124a8ba_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_8abfe5c85ece43538b80e1439f8bc4ce_start:
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
  while_909dff1efbb842e6b108cb42c39bf1af: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_631f38dde3fc49949f5d4a4ae8086354
  
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
  if_69eb242558974d9e9443853c6976f5e9: ; IF start
  pop rax
    test rax, rax
    je end_if_e395405e580141c3a6a88c568c0fbd15
  
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
  while_55582bf9b18248d79250476578624d98: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_34f2774cce65419eb92ef50eb9c31867
  
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
  if_ee8293bdab384bddbf1a9649289a9551: ; IF start
  pop rax
    test rax, rax
    je end_if_3aed76d2d9424e0db6cfaeae792b3e0a
  
  jmp end_while_34f2774cce65419eb92ef50eb9c31867 ; BREAK
  end_if_3aed76d2d9424e0db6cfaeae792b3e0a: ; END of if_ee8293bdab384bddbf1a9649289a9551
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_55582bf9b18248d79250476578624d98 ; Reevaluate WHILE condition
  end_while_34f2774cce65419eb92ef50eb9c31867: ; END of while_55582bf9b18248d79250476578624d98
  
  if_586d54e9dd6e4230a86a05591043e989: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_a3609753810b4598bcdda957cdd40c71
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_8abfe5c85ece43538b80e1439f8bc4ce_end
  end_if_a3609753810b4598bcdda957cdd40c71: ; END of if_586d54e9dd6e4230a86a05591043e989
  
  end_if_e395405e580141c3a6a88c568c0fbd15: ; END of if_69eb242558974d9e9443853c6976f5e9
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_909dff1efbb842e6b108cb42c39bf1af ; Reevaluate WHILE condition
  end_while_631f38dde3fc49949f5d4a4ae8086354: ; END of while_909dff1efbb842e6b108cb42c39bf1af
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_8abfe5c85ece43538b80e1439f8bc4ce_end
  func_446961674C6F6F6B7570_8abfe5c85ece43538b80e1439f8bc4ce_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_f65fa17dc8b248c78068dca1f5f6fb44_end:
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
call func_446961674964656E74697479_ca7cbd8939114ad2b8cb2d28d7f775e0_start
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
call func_446961674279746573_56534e4fc9c14708a246a5c20b9e63e9_start
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
call func_446961675265636F726473_a76908e5273348898f111a2c7124a8ba_start
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
call func_446961674C6F6F6B7570_8abfe5c85ece43538b80e1439f8bc4ce_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
