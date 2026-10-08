module_74797065645F6D656D6F7279_819f21c35a3c4e7693086fe62f6a21a6_start:
; Module: typed_memory v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 17:16:20Z
  ; Module UUID: 819f21c3-5a3c-4e76-9308-6fe62f6a21a6


  section .bss

  section .text

  func_66745F6D656D637079_2c36b401084347a9a6d76fbed80afe74_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_f246b9324b5445568c14042628fd9bce: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_27ede2f398c5458daa3530756ce3f8d6
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
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
    mov byte [rax], cl
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_f246b9324b5445568c14042628fd9bce ; Reevaluate WHILE condition
  end_while_27ede2f398c5458daa3530756ce3f8d6: ; END of while_f246b9324b5445568c14042628fd9bce
  
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    
    jmp func_66745F6D656D637079_2c36b401084347a9a6d76fbed80afe74_end
  func_66745F6D656D637079_2c36b401084347a9a6d76fbed80afe74_end:
    mov rsp, rbp
    pop rbp
    ret
  func_436F7079_591f63599fb9462dadb9b94e6dc8db92_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_66745F6D656D637079_2c36b401084347a9a6d76fbed80afe74_start
    add rsp, 24
    push rax
  add rsp, 8
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_436F7079_591f63599fb9462dadb9b94e6dc8db92_end
  func_436F7079_591f63599fb9462dadb9b94e6dc8db92_end:
    mov rsp, rbp
    pop rbp
    ret
  func_536F757263655772697465_ac0ded339bd8400c86fd1f5df6d211e1_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_536F757263655772697465_ac0ded339bd8400c86fd1f5df6d211e1_end
  func_536F757263655772697465_ac0ded339bd8400c86fd1f5df6d211e1_end:
    mov rsp, rbp
    pop rbp
    ret
  func_457363617065_15e500cd16e84a7794e03bbbc4d9cf69_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000010000
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_457363617065_15e500cd16e84a7794e03bbbc4d9cf69_end
  func_457363617065_15e500cd16e84a7794e03bbbc4d9cf69_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C_7641c43c3f2d4e46a678a6201592ff7c_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_5061727469616C_7641c43c3f2d4e46a678a6201592ff7c_end
  func_5061727469616C_7641c43c3f2d4e46a678a6201592ff7c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_53756D56616C756573_29b438ae1ae849e283a6742ac69de565_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_53756D56616C756573_29b438ae1ae849e283a6742ac69de565_end
  func_53756D56616C756573_29b438ae1ae849e283a6742ac69de565_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_63ccdd287a1a4f52ab1df37a35ef28b6_start:
  push rbp
    mov rbp, rsp
  loop_11202b22c0314639a9331a08ab586346: ; LOOP start
    jmp loop_11202b22c0314639a9331a08ab586346 ; LOOP: continue iteration
  end_loop_5f69e1a4077d48f5a290f2ec09511813: ; END of loop_11202b22c0314639a9331a08ab586346
  
  func_5370696E_63ccdd287a1a4f52ab1df37a35ef28b6_end:
    mov rsp, rbp
    pop rbp
    ret
module_74797065645F6D656D6F7279_819f21c35a3c4e7693086fe62f6a21a6_end:
section .text
global ubytec_host_contract_Copy
ubytec_host_contract_Copy:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
push rsi
push rdx
call func_436F7079_591f63599fb9462dadb9b94e6dc8db92_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_SourceWrite
ubytec_host_contract_SourceWrite:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
push rsi
push rdx
call func_536F757263655772697465_ac0ded339bd8400c86fd1f5df6d211e1_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Escape
ubytec_host_contract_Escape:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
push rsi
push rdx
call func_457363617065_15e500cd16e84a7794e03bbbc4d9cf69_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Partial
ubytec_host_contract_Partial:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
push rsi
push rdx
call func_5061727469616C_7641c43c3f2d4e46a678a6201592ff7c_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_SumValues
ubytec_host_contract_SumValues:
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
call func_53756D56616C756573_29b438ae1ae849e283a6742ac69de565_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Spin
ubytec_host_contract_Spin:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
call func_5370696E_63ccdd287a1a4f52ab1df37a35ef28b6_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,67,111,112,121,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,67,111,112,121,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,83,111,117,114,99,101,87,114,105,116,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,111,117,114,99,101,87,114,105,116,101,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,69,115,99,97,112,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,69,115,99,97,112,101,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,80,97,114,116,105,97,108,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,80,97,114,116,105,97,108,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,83,117,109,86,97,108,117,101,115,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,117,109,86,97,108,117,101,115,124,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,83,112,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,112,105,110,124,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
