module_74797065645F6D656D6F7279_171d5c87e76c4de4bd9707e9a96d43d9_start:
; Module: typed_memory v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 21:31:26Z
  ; Module UUID: 171d5c87-e76c-4de4-bd97-07e9a96d43d9


  section .bss

  section .text

  func_66745F6D656D637079_2665ccd03e634a01adb03aa4eea3a5ef_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_d2cdb75b79ed4d9cb02a19cfec249a68: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_7b8880f06d9140f3b77a4b5529f7ec55
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
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
    mov byte [rax], cl
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_d2cdb75b79ed4d9cb02a19cfec249a68 ; Reevaluate WHILE condition
  end_while_7b8880f06d9140f3b77a4b5529f7ec55: ; END of while_d2cdb75b79ed4d9cb02a19cfec249a68
  
  mov rax, qword [rbp + 32]
  mov qword [rsp - 8], rax
    
    jmp func_66745F6D656D637079_2665ccd03e634a01adb03aa4eea3a5ef_end
  func_66745F6D656D637079_2665ccd03e634a01adb03aa4eea3a5ef_end:
    mov rsp, rbp
    pop rbp
    ret
  func_436F7079_aaa8c87500c8421a9d0b78ef747d5be7_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_66745F6D656D637079_2665ccd03e634a01adb03aa4eea3a5ef_start
    add rsp, 24
    push rax
  add rsp, 8
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_436F7079_aaa8c87500c8421a9d0b78ef747d5be7_end
  func_436F7079_aaa8c87500c8421a9d0b78ef747d5be7_end:
    mov rsp, rbp
    pop rbp
    ret
  func_536F757263655772697465_641e07d4452748e6943ac3f5bd295e7f_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x00000000000000FF
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_536F757263655772697465_641e07d4452748e6943ac3f5bd295e7f_end
  func_536F757263655772697465_641e07d4452748e6943ac3f5bd295e7f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_457363617065_a488b8b89e3a46a89a4ddcada309d07d_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000010000
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x00000000000000FF
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_457363617065_a488b8b89e3a46a89a4ddcada309d07d_end
  func_457363617065_a488b8b89e3a46a89a4ddcada309d07d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C_375ae731da8245b9a7787b853b659886_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x00000000000000FF
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x00000000000000FF
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_5061727469616C_375ae731da8245b9a7787b853b659886_end
  func_5061727469616C_375ae731da8245b9a7787b853b659886_end:
    mov rsp, rbp
    pop rbp
    ret
  func_53756D56616C756573_578feea6f5fb4361be005ab6019cf627_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    
    jmp func_53756D56616C756573_578feea6f5fb4361be005ab6019cf627_end
  func_53756D56616C756573_578feea6f5fb4361be005ab6019cf627_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_98c80d6163e84efd975ecd18f3650cc7_start:
  push rbp
    mov rbp, rsp
  loop_38498b12aa944303b5da874547877c13: ; LOOP start
    jmp loop_38498b12aa944303b5da874547877c13 ; LOOP: continue iteration
  end_loop_1fb0168ec6004fb0910c38c4c3f37549: ; END of loop_38498b12aa944303b5da874547877c13
  
  func_5370696E_98c80d6163e84efd975ecd18f3650cc7_end:
    mov rsp, rbp
    pop rbp
    ret
module_74797065645F6D656D6F7279_171d5c87e76c4de4bd9707e9a96d43d9_end:
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
call func_436F7079_aaa8c87500c8421a9d0b78ef747d5be7_start
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
call func_536F757263655772697465_641e07d4452748e6943ac3f5bd295e7f_start
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
call func_457363617065_a488b8b89e3a46a89a4ddcada309d07d_start
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
call func_5061727469616C_375ae731da8245b9a7787b853b659886_start
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
call func_53756D56616C756573_578feea6f5fb4361be005ab6019cf627_start
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
call func_5370696E_98c80d6163e84efd975ecd18f3650cc7_start
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
