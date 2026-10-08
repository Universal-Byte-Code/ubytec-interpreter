module_74797065645F6D656D6F7279_41e2ce826f2c4115b1e9b743c8111df7_start:
; Module: typed_memory v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 09:54:19Z
  ; Module UUID: 41e2ce82-6f2c-4115-b1e9-b743c8111df7


  section .bss

  section .text

  func_66745F6D656D637079_b1f7fb50eda3463dbf8f2d7af46e3874_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  ; effect-registers: write-through copies, raw-store/call reload boundaries
  mov r9, qword [rbp + 32]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  while_4d21d093884b437dabea4f78eb5b45f8: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_910bb9688d394bc9b54ce65eff01a030
  push r9
  mov qword [rsp - 8], r8
  mov rcx, r8
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov qword [rsp - 8], r8
  mov rcx, r8
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov byte [rax], cl
  ; effect-registers: reload after STORE
  mov r9, qword [rbp + 32]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_4d21d093884b437dabea4f78eb5b45f8 ; Reevaluate WHILE condition
  end_while_910bb9688d394bc9b54ce65eff01a030: ; END of while_4d21d093884b437dabea4f78eb5b45f8
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_66745F6D656D637079_b1f7fb50eda3463dbf8f2d7af46e3874_end
  func_66745F6D656D637079_b1f7fb50eda3463dbf8f2d7af46e3874_end:
    mov rsp, rbp
    pop rbp
    ret
  func_436F7079_30c52662f92c47d8973696495b1ec1df_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_66745F6D656D637079_b1f7fb50eda3463dbf8f2d7af46e3874_start
    add rsp, 24
    push rax
  add rsp, 8
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_436F7079_30c52662f92c47d8973696495b1ec1df_end
  func_436F7079_30c52662f92c47d8973696495b1ec1df_end:
    mov rsp, rbp
    pop rbp
    ret
  func_536F757263655772697465_1a0ac2f365554ea7b4f40dc674bc5cd9_start:
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
    
    jmp func_536F757263655772697465_1a0ac2f365554ea7b4f40dc674bc5cd9_end
  func_536F757263655772697465_1a0ac2f365554ea7b4f40dc674bc5cd9_end:
    mov rsp, rbp
    pop rbp
    ret
  func_457363617065_9859ba0f4c3d4115b309cdb9b98e0d7e_start:
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
    
    jmp func_457363617065_9859ba0f4c3d4115b309cdb9b98e0d7e_end
  func_457363617065_9859ba0f4c3d4115b309cdb9b98e0d7e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C_9eb391815c9e4aa49e9068b09f3613a3_start:
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
    
    jmp func_5061727469616C_9eb391815c9e4aa49e9068b09f3613a3_end
  func_5061727469616C_9eb391815c9e4aa49e9068b09f3613a3_end:
    mov rsp, rbp
    pop rbp
    ret
  func_53756D56616C756573_0a7975e697c64314ae6bdac5340fb50a_start:
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
    
    jmp func_53756D56616C756573_0a7975e697c64314ae6bdac5340fb50a_end
  func_53756D56616C756573_0a7975e697c64314ae6bdac5340fb50a_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_f74d755e5a61408388f7655041b7035b_start:
  push rbp
    mov rbp, rsp
  loop_91132e0f9b04461393b455f900f513a9: ; LOOP start
    jmp loop_91132e0f9b04461393b455f900f513a9 ; LOOP: continue iteration
  end_loop_c28194f131ec45f6ac872869b5dc1ead: ; END of loop_91132e0f9b04461393b455f900f513a9
  func_5370696E_f74d755e5a61408388f7655041b7035b_end:
    mov rsp, rbp
    pop rbp
    ret
module_74797065645F6D656D6F7279_41e2ce826f2c4115b1e9b743c8111df7_end:
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
call func_436F7079_30c52662f92c47d8973696495b1ec1df_start
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
call func_536F757263655772697465_1a0ac2f365554ea7b4f40dc674bc5cd9_start
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
call func_457363617065_9859ba0f4c3d4115b309cdb9b98e0d7e_start
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
call func_5061727469616C_9eb391815c9e4aa49e9068b09f3613a3_start
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
call func_53756D56616C756573_0a7975e697c64314ae6bdac5340fb50a_start
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
call func_5370696E_f74d755e5a61408388f7655041b7035b_start
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
