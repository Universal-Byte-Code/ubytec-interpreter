module_636861696E5F737472696E6773_827316754b8f4b87a8e6b882dfcced6b_start:
; Module: chain_strings v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 01:27:43Z
  ; Module UUID: 82731675-4b8f-4b87-a8e6-b882dfcced6b


  section .bss

  section .text

  func_66745F7374726C656E_52fd0440647549b68aefdc0df2e0f784_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  loop_7056d2d7e7564f9b870d538d0cc0c573: ; LOOP start
  mov rax, qword [rbp + 16]
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
  if_e2a798193cdc41d8b6fdd63d062a488d: ; IF start
  pop rax
    test rax, rax
    je end_if_ce186eec8f774b989b3fccf49b532422
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp end_else_79f1d6d7959246c39b2a2049cf7696ff     ; Jump over ELSE part
  end_if_ce186eec8f774b989b3fccf49b532422:    ; if_e2a798193cdc41d8b6fdd63d062a488d END
  else_7f6f2c4231bd4eb6962b02f1a345433c:  ; Start ELSE block
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    jmp func_66745F7374726C656E_52fd0440647549b68aefdc0df2e0f784_end
  end_else_79f1d6d7959246c39b2a2049cf7696ff: ; END of else_7f6f2c4231bd4eb6962b02f1a345433c
  
    jmp loop_7056d2d7e7564f9b870d538d0cc0c573 ; LOOP: continue iteration
  end_loop_41d38194c892403cbf1a7c4ab1423563: ; END of loop_7056d2d7e7564f9b870d538d0cc0c573
  
  func_66745F7374726C656E_52fd0440647549b68aefdc0df2e0f784_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4C656E677468_cbfb427555f14d94afde602f480f32f9_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  call func_66745F7374726C656E_52fd0440647549b68aefdc0df2e0f784_start
    add rsp, 8
    push rax
  pop rax
    
    jmp func_4C656E677468_cbfb427555f14d94afde602f480f32f9_end
  func_4C656E677468_cbfb427555f14d94afde602f480f32f9_end:
    mov rsp, rbp
    pop rbp
    ret
module_636861696E5F737472696E6773_827316754b8f4b87a8e6b882dfcced6b_end:
section .text
global ubytec_host_contract_Length
ubytec_host_contract_Length:
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
call func_4C656E677468_cbfb427555f14d94afde602f480f32f9_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,76,101,110,103,116,104,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,76,101,110,103,116,104,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
