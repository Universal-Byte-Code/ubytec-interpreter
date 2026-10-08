module_6D656D6F7279_52caae2f401d4002a79125e3cfdc9a0c_start:
; Module: memory v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 01:16:48Z
  ; Module UUID: 52caae2f-401d-4002-a791-25e3cfdc9a0c


  section .bss

  section .text

  func_5772697465_cf314c6a7b384c83b8e43632d706baa4_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_518910bc741a400d9bfd9f9d289a5d17: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_bbbc7d99772649c0b0f01b5fa0897d40
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x000000000000005A
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_518910bc741a400d9bfd9f9d289a5d17 ; Reevaluate WHILE condition
  end_while_bbbc7d99772649c0b0f01b5fa0897d40: ; END of while_518910bc741a400d9bfd9f9d289a5d17
  
  mov rax, 0x0000000100000001
    push rax
  pop rax
    
    jmp func_5772697465_cf314c6a7b384c83b8e43632d706baa4_end
  func_5772697465_cf314c6a7b384c83b8e43632d706baa4_end:
    mov rsp, rbp
    pop rbp
    ret
module_6D656D6F7279_52caae2f401d4002a79125e3cfdc9a0c_end:
section .text
global ubytec_host_contract_Write
ubytec_host_contract_Write:
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
call func_5772697465_cf314c6a7b384c83b8e43632d706baa4_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,87,114,105,116,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,87,114,105,116,101,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
