module_74797065645F6D656D6F7279_4af66410085141868d2f982d54791e87_start:
; Module: typed_memory v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 02:04:40Z
  ; Module UUID: 4af66410-0851-4186-8d2f-982d54791e87


  section .bss

  section .text

  func_66745F6D656D637079_37f5c421a2dc44e483074304f2f161c4_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_cafcf16006b443c5993ab79c8f612a0f: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_2357b65b757148c9b39d5743a7221b24
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
    jmp while_cafcf16006b443c5993ab79c8f612a0f ; Reevaluate WHILE condition
  end_while_2357b65b757148c9b39d5743a7221b24: ; END of while_cafcf16006b443c5993ab79c8f612a0f
  mov rax, qword [rbp + 32]
  mov qword [rsp - 8], rax
    
    jmp func_66745F6D656D637079_37f5c421a2dc44e483074304f2f161c4_end
  func_66745F6D656D637079_37f5c421a2dc44e483074304f2f161c4_end:
    mov rsp, rbp
    pop rbp
    ret
  func_436F7079_f67d3c95fba74c7d9e2b3a11079882bc_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_66745F6D656D637079_37f5c421a2dc44e483074304f2f161c4_start
    add rsp, 24
    push rax
  add rsp, 8
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_436F7079_f67d3c95fba74c7d9e2b3a11079882bc_end
  func_436F7079_f67d3c95fba74c7d9e2b3a11079882bc_end:
    mov rsp, rbp
    pop rbp
    ret
  func_536F757263655772697465_bb50000524d347429b2fec98af91e4b6_start:
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
    
    jmp func_536F757263655772697465_bb50000524d347429b2fec98af91e4b6_end
  func_536F757263655772697465_bb50000524d347429b2fec98af91e4b6_end:
    mov rsp, rbp
    pop rbp
    ret
  func_457363617065_2807d6f512f7426799d7083147cf3705_start:
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
    
    jmp func_457363617065_2807d6f512f7426799d7083147cf3705_end
  func_457363617065_2807d6f512f7426799d7083147cf3705_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C_a003d79691464a0d9032cd1914e5927b_start:
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
    
    jmp func_5061727469616C_a003d79691464a0d9032cd1914e5927b_end
  func_5061727469616C_a003d79691464a0d9032cd1914e5927b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_53756D56616C756573_33e1ae7c0e88433bbaa4ee0e961e734d_start:
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
    
    jmp func_53756D56616C756573_33e1ae7c0e88433bbaa4ee0e961e734d_end
  func_53756D56616C756573_33e1ae7c0e88433bbaa4ee0e961e734d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_baeafe2034cd423894867ee0d80ea4c0_start:
  push rbp
    mov rbp, rsp
  loop_7b325ee6349a48efa4717e2768b78684: ; LOOP start
    jmp loop_7b325ee6349a48efa4717e2768b78684 ; LOOP: continue iteration
  end_loop_bb4f6f3fd02a4b299fa5b89dabf23fe9: ; END of loop_7b325ee6349a48efa4717e2768b78684
  func_5370696E_baeafe2034cd423894867ee0d80ea4c0_end:
    mov rsp, rbp
    pop rbp
    ret
module_74797065645F6D656D6F7279_4af66410085141868d2f982d54791e87_end:
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
call func_436F7079_f67d3c95fba74c7d9e2b3a11079882bc_start
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
call func_536F757263655772697465_bb50000524d347429b2fec98af91e4b6_start
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
call func_457363617065_2807d6f512f7426799d7083147cf3705_start
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
call func_5061727469616C_a003d79691464a0d9032cd1914e5927b_start
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
call func_53756D56616C756573_33e1ae7c0e88433bbaa4ee0e961e734d_start
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
call func_5370696E_baeafe2034cd423894867ee0d80ea4c0_start
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
