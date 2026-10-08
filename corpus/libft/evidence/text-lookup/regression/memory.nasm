module_74797065645F6D656D6F7279_21ea2b5a4ac14bcc9de944fd529b0862_start:
; Module: typed_memory v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 21:08:20Z
  ; Module UUID: 21ea2b5a-4ac1-4bcc-9de9-44fd529b0862


  section .bss

  section .text

  func_66745F6D656D637079_c175e76c1e074e3eaccaf5d1c22d02f9_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_eb48b4faf26d4d919bc7a8dc9bab2729: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_b2db41390f61431ea419126a8102ca75
  
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
    jmp while_eb48b4faf26d4d919bc7a8dc9bab2729 ; Reevaluate WHILE condition
  end_while_b2db41390f61431ea419126a8102ca75: ; END of while_eb48b4faf26d4d919bc7a8dc9bab2729
  
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    
    jmp func_66745F6D656D637079_c175e76c1e074e3eaccaf5d1c22d02f9_end
  func_66745F6D656D637079_c175e76c1e074e3eaccaf5d1c22d02f9_end:
    mov rsp, rbp
    pop rbp
    ret
  func_436F7079_e74c485a914644acbe68906a09596db3_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_66745F6D656D637079_c175e76c1e074e3eaccaf5d1c22d02f9_start
    add rsp, 24
    push rax
  add rsp, 8
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_436F7079_e74c485a914644acbe68906a09596db3_end
  func_436F7079_e74c485a914644acbe68906a09596db3_end:
    mov rsp, rbp
    pop rbp
    ret
  func_536F757263655772697465_0bce28fa315b49b790d735058dbc41c6_start:
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
    
    jmp func_536F757263655772697465_0bce28fa315b49b790d735058dbc41c6_end
  func_536F757263655772697465_0bce28fa315b49b790d735058dbc41c6_end:
    mov rsp, rbp
    pop rbp
    ret
  func_457363617065_d7997dd5db124b1e8e4b91acff8259ca_start:
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
    
    jmp func_457363617065_d7997dd5db124b1e8e4b91acff8259ca_end
  func_457363617065_d7997dd5db124b1e8e4b91acff8259ca_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C_d5e1b59cbe9145c9baac650de4649920_start:
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
    
    jmp func_5061727469616C_d5e1b59cbe9145c9baac650de4649920_end
  func_5061727469616C_d5e1b59cbe9145c9baac650de4649920_end:
    mov rsp, rbp
    pop rbp
    ret
  func_53756D56616C756573_fb7284169877486799b4c00c8482084d_start:
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
    
    jmp func_53756D56616C756573_fb7284169877486799b4c00c8482084d_end
  func_53756D56616C756573_fb7284169877486799b4c00c8482084d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_b1cfd130857043bdaec5501cc13cee3a_start:
  push rbp
    mov rbp, rsp
  loop_72fd13dd63994f009f49bae080c9b8ba: ; LOOP start
    jmp loop_72fd13dd63994f009f49bae080c9b8ba ; LOOP: continue iteration
  end_loop_f76a7b4e3ae74d6e9fd191921b554b14: ; END of loop_72fd13dd63994f009f49bae080c9b8ba
  
  func_5370696E_b1cfd130857043bdaec5501cc13cee3a_end:
    mov rsp, rbp
    pop rbp
    ret
module_74797065645F6D656D6F7279_21ea2b5a4ac14bcc9de944fd529b0862_end:
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
call func_436F7079_e74c485a914644acbe68906a09596db3_start
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
call func_536F757263655772697465_0bce28fa315b49b790d735058dbc41c6_start
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
call func_457363617065_d7997dd5db124b1e8e4b91acff8259ca_start
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
call func_5061727469616C_d5e1b59cbe9145c9baac650de4649920_start
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
call func_53756D56616C756573_fb7284169877486799b4c00c8482084d_start
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
call func_5370696E_b1cfd130857043bdaec5501cc13cee3a_start
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
