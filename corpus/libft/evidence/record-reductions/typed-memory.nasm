module_74797065645F6D656D6F7279_6039618a1bbc467abdbb1d67d2175912_start:
; Module: typed_memory v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:35:06Z
  ; Module UUID: 6039618a-1bbc-467a-bdbb-1d67d2175912


  section .bss

  section .text

  func_66745F6D656D637079_2c0c83335b844def9c4e58d46d4742bd_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_fdbab97164d14cfb9a4c351e03c6315c: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_c9b54083be4445718a1db2ad7bf7e4c1
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
    jmp while_fdbab97164d14cfb9a4c351e03c6315c ; Reevaluate WHILE condition
  end_while_c9b54083be4445718a1db2ad7bf7e4c1: ; END of while_fdbab97164d14cfb9a4c351e03c6315c
  mov rax, qword [rbp + 32]
  mov qword [rsp - 8], rax
    
    jmp func_66745F6D656D637079_2c0c83335b844def9c4e58d46d4742bd_end
  func_66745F6D656D637079_2c0c83335b844def9c4e58d46d4742bd_end:
    mov rsp, rbp
    pop rbp
    ret
  func_436F7079_72ccf33cf0444d85be68862bce654ffe_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_66745F6D656D637079_2c0c83335b844def9c4e58d46d4742bd_start
    add rsp, 24
    push rax
  add rsp, 8
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_436F7079_72ccf33cf0444d85be68862bce654ffe_end
  func_436F7079_72ccf33cf0444d85be68862bce654ffe_end:
    mov rsp, rbp
    pop rbp
    ret
  func_536F757263655772697465_aa4c1a163508444b8727f3b9c7422166_start:
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
    
    jmp func_536F757263655772697465_aa4c1a163508444b8727f3b9c7422166_end
  func_536F757263655772697465_aa4c1a163508444b8727f3b9c7422166_end:
    mov rsp, rbp
    pop rbp
    ret
  func_457363617065_f16335fd7a154b3d8fb6a37505e1d8c6_start:
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
    
    jmp func_457363617065_f16335fd7a154b3d8fb6a37505e1d8c6_end
  func_457363617065_f16335fd7a154b3d8fb6a37505e1d8c6_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C_bf845383a3cf48388ed5a3d8a817b14e_start:
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
    
    jmp func_5061727469616C_bf845383a3cf48388ed5a3d8a817b14e_end
  func_5061727469616C_bf845383a3cf48388ed5a3d8a817b14e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_53756D56616C756573_1450245167b74373b3c62d9dedc1389a_start:
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
    
    jmp func_53756D56616C756573_1450245167b74373b3c62d9dedc1389a_end
  func_53756D56616C756573_1450245167b74373b3c62d9dedc1389a_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_4a0edf953c5f403ab8f5784c4da34c0a_start:
  push rbp
    mov rbp, rsp
  loop_64a5cec7774b485ea0a8469748720963: ; LOOP start
    jmp loop_64a5cec7774b485ea0a8469748720963 ; LOOP: continue iteration
  end_loop_1a5d08adc56048ff82f0ef413881cc40: ; END of loop_64a5cec7774b485ea0a8469748720963
  func_5370696E_4a0edf953c5f403ab8f5784c4da34c0a_end:
    mov rsp, rbp
    pop rbp
    ret
module_74797065645F6D656D6F7279_6039618a1bbc467abdbb1d67d2175912_end:
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
call func_436F7079_72ccf33cf0444d85be68862bce654ffe_start
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
call func_536F757263655772697465_aa4c1a163508444b8727f3b9c7422166_start
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
call func_457363617065_f16335fd7a154b3d8fb6a37505e1d8c6_start
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
call func_5061727469616C_bf845383a3cf48388ed5a3d8a817b14e_start
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
call func_53756D56616C756573_1450245167b74373b3c62d9dedc1389a_start
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
call func_5370696E_4a0edf953c5f403ab8f5784c4da34c0a_start
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
