module_746F6F6C73_d06de0e4ff894d0eb2c0e970a77bca6c_start:
; Module: tools v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 01:16:46Z
  ; Module UUID: d06de0e4-ff89-4d0e-b2c0-e970a77bca6c


  section .bss

  section .text

  func_52656164_da345a06708140f7a3014041dd1201be_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_02d29e89d4c04f4f944c399bcade6949: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_42a017bdac814bd09da8b2f98ba9c4fb
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 40]
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
    jmp while_02d29e89d4c04f4f944c399bcade6949 ; Reevaluate WHILE condition
  end_while_42a017bdac814bd09da8b2f98ba9c4fb: ; END of while_02d29e89d4c04f4f944c399bcade6949
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_52656164_da345a06708140f7a3014041dd1201be_end
  func_52656164_da345a06708140f7a3014041dd1201be_end:
    mov rsp, rbp
    pop rbp
    ret
module_746F6F6C73_d06de0e4ff894d0eb2c0e970a77bca6c_end:
section .text
global ubytec_host_contract_Read
ubytec_host_contract_Read:
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
call func_52656164_da345a06708140f7a3014041dd1201be_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Hidden
ubytec_host_contract_Hidden:
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
call func_52656164_da345a06708140f7a3014041dd1201be_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,82,101,97,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,82,101,97,100,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,72,105,100,100,101,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,72,105,100,100,101,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
