module_646961676E6F737469635F6B65726E656C73_8a5f451775934567b080e584eba9660f_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 21:46:48Z
  ; Module UUID: 8a5f4517-7593-4567-b080-e584eba9660f


  section .bss

  section .text

  func_446961674964656E74697479_ef55b9b6427949ba9ed115d89ced817a_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_ef55b9b6427949ba9ed115d89ced817a_end
  func_446961674964656E74697479_ef55b9b6427949ba9ed115d89ced817a_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_61bc6eceacfc4d9ab4dc1cebfbd0b094_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_87798a61043b49a1a577fa56948685d3: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_b9b66ee71f4f4ad8bcccc81924a4c5c9
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
  mov rcx, rax
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
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_87798a61043b49a1a577fa56948685d3 ; Reevaluate WHILE condition
  end_while_b9b66ee71f4f4ad8bcccc81924a4c5c9: ; END of while_87798a61043b49a1a577fa56948685d3
  
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674279746573_61bc6eceacfc4d9ab4dc1cebfbd0b094_end
  func_446961674279746573_61bc6eceacfc4d9ab4dc1cebfbd0b094_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_442ab94639e14e71af1ac3238a7744a8_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_bb9b150cffb9459ebc7ccd1152788d5a: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_1d642db6417c4dad8026df9635e2a295
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 8]
    push rax
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
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_bb9b150cffb9459ebc7ccd1152788d5a ; Reevaluate WHILE condition
  end_while_1d642db6417c4dad8026df9635e2a295: ; END of while_bb9b150cffb9459ebc7ccd1152788d5a
  
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961675265636F726473_442ab94639e14e71af1ac3238a7744a8_end
  func_446961675265636F726473_442ab94639e14e71af1ac3238a7744a8_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_42c80e0982c04c9e842810ebcf9ec3a2_start:
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
  while_17903571624b4b71b11ee2b05f7b56f1: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_805f9b372fea4ebca38c885f7539a616
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 8]
    push rax
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
    push rax
  mov rax, 0x0000000000000008
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
    push rax
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    push rax
  if_2b4ebd8738dd49ffbe80cdeac4546412: ; IF start
  pop rax
    test rax, rax
    je end_if_7e460b5b335c481bb7b3b1a38219e198
  
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
  while_43e0a8219608417193a6ec38ce8bb664: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_1457d2a9d6174b4da162335c1526031c
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
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
  if_0eea237c908a41fe9f8812549ea37101: ; IF start
  pop rax
    test rax, rax
    je end_if_434d861ef9724721a448dd186937735e
  
  jmp end_while_1457d2a9d6174b4da162335c1526031c ; BREAK
  end_if_434d861ef9724721a448dd186937735e: ; END of if_0eea237c908a41fe9f8812549ea37101
  
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    jmp while_43e0a8219608417193a6ec38ce8bb664 ; Reevaluate WHILE condition
  end_while_1457d2a9d6174b4da162335c1526031c: ; END of while_43e0a8219608417193a6ec38ce8bb664
  
  if_c8c99a2f0d5d44078c59252c656170c0: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_9e71e95b850e40688118796cf2cf1638
  
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_42c80e0982c04c9e842810ebcf9ec3a2_end
  end_if_9e71e95b850e40688118796cf2cf1638: ; END of if_c8c99a2f0d5d44078c59252c656170c0
  
  end_if_7e460b5b335c481bb7b3b1a38219e198: ; END of if_2b4ebd8738dd49ffbe80cdeac4546412
  
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_17903571624b4b71b11ee2b05f7b56f1 ; Reevaluate WHILE condition
  end_while_805f9b372fea4ebca38c885f7539a616: ; END of while_17903571624b4b71b11ee2b05f7b56f1
  
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_42c80e0982c04c9e842810ebcf9ec3a2_end
  func_446961674C6F6F6B7570_42c80e0982c04c9e842810ebcf9ec3a2_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_8a5f451775934567b080e584eba9660f_end:
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
call func_446961674964656E74697479_ef55b9b6427949ba9ed115d89ced817a_start
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
call func_446961674279746573_61bc6eceacfc4d9ab4dc1cebfbd0b094_start
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
call func_446961675265636F726473_442ab94639e14e71af1ac3238a7744a8_start
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
call func_446961674C6F6F6B7570_42c80e0982c04c9e842810ebcf9ec3a2_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
