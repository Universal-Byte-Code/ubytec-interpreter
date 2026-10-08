module_746578745F6D6170706572_9c65aa00e0e44b229cce26104b9472a7_start:
; Module: text_mapper v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 09:08:37Z
  ; Module UUID: 9c65aa00-e0e4-4b22-9cce-26104b9472a7


  section .bss

  section .text

  func_66745F746F7570706572_eff03dec480748ad838b5ff0179e85f1_start:
  push rbp
    mov rbp, rsp
  if_74983d80f51d45438b7cc3a12216433b: ; IF start
  mov rcx, 97
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jge end_if_bed7caa95cef4cce9419dd412221b22b
  
  movsxd rax, dword [rbp + 16]
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F746F7570706572_eff03dec480748ad838b5ff0179e85f1_end
  end_if_bed7caa95cef4cce9419dd412221b22b: ; END of if_74983d80f51d45438b7cc3a12216433b
  
  if_edfe59e41e7646639dee1e8e32fc7d78: ; IF start
  mov rcx, 122
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jle end_if_17044a98cef04659bef7ea73a1aaaf40
  
  movsxd rax, dword [rbp + 16]
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F746F7570706572_eff03dec480748ad838b5ff0179e85f1_end
  end_if_17044a98cef04659bef7ea73a1aaaf40: ; END of if_edfe59e41e7646639dee1e8e32fc7d78
  
  movsxd rax, dword [rbp + 16]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F746F7570706572_eff03dec480748ad838b5ff0179e85f1_end
  func_66745F746F7570706572_eff03dec480748ad838b5ff0179e85f1_end:
    mov rsp, rbp
    pop rbp
    ret
  func_557070657254657874_d0f146c6c6b04d9cacf00840420ce042_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_2d8837f6c8f8455d9b149a0a66ff55e2: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_9c12385202cd4c6ba96e3cf6214d8499
  
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
  call func_66745F746F7570706572_eff03dec480748ad838b5ff0179e85f1_start
    add rsp, 8
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
    jmp while_2d8837f6c8f8455d9b149a0a66ff55e2 ; Reevaluate WHILE condition
  end_while_9c12385202cd4c6ba96e3cf6214d8499: ; END of while_2d8837f6c8f8455d9b149a0a66ff55e2
  
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_557070657254657874_d0f146c6c6b04d9cacf00840420ce042_end
  func_557070657254657874_d0f146c6c6b04d9cacf00840420ce042_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4573636170655374617465_bada88ac3776422285c9ddba88a04b47_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000000001
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
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4573636170655374617465_bada88ac3776422285c9ddba88a04b47_end
  func_4573636170655374617465_bada88ac3776422285c9ddba88a04b47_end:
    mov rsp, rbp
    pop rbp
    ret
module_746578745F6D6170706572_9c65aa00e0e44b229cce26104b9472a7_end:
section .text
global ubytec_host_contract_EscapeState
ubytec_host_contract_EscapeState:
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
call func_4573636170655374617465_bada88ac3776422285c9ddba88a04b47_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_UpperText
ubytec_host_contract_UpperText:
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
call func_557070657254657874_d0f146c6c6b04d9cacf00840420ce042_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,69,115,99,97,112,101,83,116,97,116,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,69,115,99,97,112,101,83,116,97,116,101,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,85,112,112,101,114,84,101,120,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,85,112,112,101,114,84,101,120,116,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
