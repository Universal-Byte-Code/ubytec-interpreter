module_6172656E615F7265636569766572_e084de0ac77c4bec8cf580d65b09ae54_start:
; Module: arena_receiver v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 10:09:37Z
  ; Module UUID: e084de0a-c77c-4bec-8cf5-80d65b09ae54


  section .bss

  section .text

  func_546F756368_635e7bf857884c3e9d8c423e40f87fe2_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000022
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_546F756368_635e7bf857884c3e9d8c423e40f87fe2_end
  func_546F756368_635e7bf857884c3e9d8c423e40f87fe2_end:
    mov rsp, rbp
    pop rbp
    ret
  func_48656164657241747461636B_707e9ee20e72458cbb97e8f28fb059bc_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000022
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_48656164657241747461636B_707e9ee20e72458cbb97e8f28fb059bc_end
  func_48656164657241747461636B_707e9ee20e72458cbb97e8f28fb059bc_end:
    mov rsp, rbp
    pop rbp
    ret
  func_457363617065_fd96b4d1945c4a2494cdf496a6072eeb_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000022
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 24]
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
    
    jmp func_457363617065_fd96b4d1945c4a2494cdf496a6072eeb_end
  func_457363617065_fd96b4d1945c4a2494cdf496a6072eeb_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_4af6a0eae42d4c1683ac15382bc82a86_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000022
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  loop_11760d131926401489e1dc02690a2f24: ; LOOP start
    jmp loop_11760d131926401489e1dc02690a2f24 ; LOOP: continue iteration
  end_loop_8e4a7de9e05a4d30bc24fe17aea03f0a: ; END of loop_11760d131926401489e1dc02690a2f24
  
  func_5370696E_4af6a0eae42d4c1683ac15382bc82a86_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4E65676174697665_07b0bf93c0524fc893991d49558a06b7_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000033
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, 0xFFFFFFFFFFFFFFB3
    push rax
  pop rax
    
    jmp func_4E65676174697665_07b0bf93c0524fc893991d49558a06b7_end
  func_4E65676174697665_07b0bf93c0524fc893991d49558a06b7_end:
    mov rsp, rbp
    pop rbp
    ret
  func_526561644F6E6C79_fe4ffc0bc63c4282be4ffc94db3d1c3c_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000022
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_526561644F6E6C79_fe4ffc0bc63c4282be4ffc94db3d1c3c_end
  func_526561644F6E6C79_fe4ffc0bc63c4282be4ffc94db3d1c3c_end:
    mov rsp, rbp
    pop rbp
    ret
module_6172656E615F7265636569766572_e084de0ac77c4bec8cf580d65b09ae54_end:
section .text
global ubytec_host_contract_Touch
ubytec_host_contract_Touch:
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
call func_546F756368_635e7bf857884c3e9d8c423e40f87fe2_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_HeaderAttack
ubytec_host_contract_HeaderAttack:
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
call func_48656164657241747461636B_707e9ee20e72458cbb97e8f28fb059bc_start
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
sub rsp, 8
push rdi
push rsi
call func_457363617065_fd96b4d1945c4a2494cdf496a6072eeb_start
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
sub rsp, 8
push rdi
push rsi
call func_5370696E_4af6a0eae42d4c1683ac15382bc82a86_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Negative
ubytec_host_contract_Negative:
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
call func_4E65676174697665_07b0bf93c0524fc893991d49558a06b7_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ReadOnly
ubytec_host_contract_ReadOnly:
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
call func_526561644F6E6C79_fe4ffc0bc63c4282be4ffc94db3d1c3c_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,84,111,117,99,104,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,84,111,117,99,104,124,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,72,101,97,100,101,114,65,116,116,97,99,107,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,72,101,97,100,101,114,65,116,116,97,99,107,124,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,69,115,99,97,112,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,69,115,99,97,112,101,124,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,83,112,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,112,105,110,124,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,78,101,103,97,116,105,118,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,78,101,103,97,116,105,118,101,124,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,82,101,97,100,79,110,108,121,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,82,101,97,100,79,110,108,121,124,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
