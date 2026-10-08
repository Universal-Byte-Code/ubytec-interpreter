module_646961676E6F737469635F6B65726E656C73_112cb8faf0b84537a44dc7682aaad7a1_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 00:01:46Z
  ; Module UUID: 112cb8fa-f0b8-4537-a44d-c7682aaad7a1


  section .bss

  section .text

  func_446961674964656E74697479_689f444c069041a88d5949045598c46b_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_446961674964656E74697479_689f444c069041a88d5949045598c46b_end
  func_446961674964656E74697479_689f444c069041a88d5949045598c46b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_e3e4a33066a74288b5335ecd18c75c9e_start:
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
  func_446961674279746573_e3e4a33066a74288b5335ecd18c75c9e_start_byte_reduce:
  cmp r8, r10
    jae func_446961674279746573_e3e4a33066a74288b5335ecd18c75c9e_start_byte_reduce_done
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
    jmp func_446961674279746573_e3e4a33066a74288b5335ecd18c75c9e_start_byte_reduce
  func_446961674279746573_e3e4a33066a74288b5335ecd18c75c9e_start_byte_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961674279746573_e3e4a33066a74288b5335ecd18c75c9e_end
  func_446961674279746573_e3e4a33066a74288b5335ecd18c75c9e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_6d5a59335733423da3b58187830d7ba8_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_170cd3fd4b52416c9e56c65160ec3e50: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_46b5ead85b6746c99b52b73b13131433
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
    jmp while_170cd3fd4b52416c9e56c65160ec3e50 ; Reevaluate WHILE condition
  end_while_46b5ead85b6746c99b52b73b13131433: ; END of while_170cd3fd4b52416c9e56c65160ec3e50
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_446961675265636F726473_6d5a59335733423da3b58187830d7ba8_end
  func_446961675265636F726473_6d5a59335733423da3b58187830d7ba8_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_999fe773886d4a0e9b76caa00536ae80_start:
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
  while_18bad9ca8c7a4c8bbcd4d9a222d0e1da: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_473038c722864405b0df1d7fdb45f7bb
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
  if_c75bfe49c7b742dbbfcb1abfd3e09d81: ; IF start
  pop rax
    test rax, rax
    je end_if_0f117ecfb50846e686a32f3b6e6497d6
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
  while_122c6eebe8094707bab21d5a81a83ffb: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_466a57459ac844cabbf9be173ba84511
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
  if_fbc85c1f2f904c81b8458867f242aced: ; IF start
  pop rax
    test rax, rax
    je end_if_1eb629682ffd4d28bf40cf29cd236d6f
  jmp end_while_466a57459ac844cabbf9be173ba84511 ; BREAK
  end_if_1eb629682ffd4d28bf40cf29cd236d6f: ; END of if_fbc85c1f2f904c81b8458867f242aced
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_122c6eebe8094707bab21d5a81a83ffb ; Reevaluate WHILE condition
  end_while_466a57459ac844cabbf9be173ba84511: ; END of while_122c6eebe8094707bab21d5a81a83ffb
  if_2b7c4e00022b49e3b540b89758ecbcd0: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_0a4194ff2a8b42faa8e7538d1a00f152
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_999fe773886d4a0e9b76caa00536ae80_end
  end_if_0a4194ff2a8b42faa8e7538d1a00f152: ; END of if_2b7c4e00022b49e3b540b89758ecbcd0
  end_if_0f117ecfb50846e686a32f3b6e6497d6: ; END of if_c75bfe49c7b742dbbfcb1abfd3e09d81
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_18bad9ca8c7a4c8bbcd4d9a222d0e1da ; Reevaluate WHILE condition
  end_while_473038c722864405b0df1d7fdb45f7bb: ; END of while_18bad9ca8c7a4c8bbcd4d9a222d0e1da
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_999fe773886d4a0e9b76caa00536ae80_end
  func_446961674C6F6F6B7570_999fe773886d4a0e9b76caa00536ae80_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_112cb8faf0b84537a44dc7682aaad7a1_end:
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
call func_446961674279746573_e3e4a33066a74288b5335ecd18c75c9e_start
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
