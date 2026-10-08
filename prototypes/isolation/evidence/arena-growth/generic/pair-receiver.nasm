module_706169725F7265636569766572_5754ab0e2a5f49e88faec8f0a3048e11_start:
; Module: pair_receiver v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 11:26:04Z
  ; Module UUID: 5754ab0e-2a5f-49e8-8fae-c8f0a3048e11


  section .bss

  section .text

  func_436F7079_8b8d04f4980d4af0b39c024e92bc704b_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_82e51d7e78f14eaaa67976fb2252f642: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_5575f5d3714641c7974babb3f12cd24f
  
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
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_82e51d7e78f14eaaa67976fb2252f642 ; Reevaluate WHILE condition
  end_while_5575f5d3714641c7974babb3f12cd24f: ; END of while_82e51d7e78f14eaaa67976fb2252f642
  
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_436F7079_8b8d04f4980d4af0b39c024e92bc704b_end
  func_436F7079_8b8d04f4980d4af0b39c024e92bc704b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C_da39e44f45504f03a42d6f6d442b729a_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
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
    
    jmp func_5061727469616C_da39e44f45504f03a42d6f6d442b729a_end
  func_5061727469616C_da39e44f45504f03a42d6f6d442b729a_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_95e8282a7368416497b7562fa55785b2_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  loop_db4605c4e48e407fa94e7d833dba12d6: ; LOOP start
    jmp loop_db4605c4e48e407fa94e7d833dba12d6 ; LOOP: continue iteration
  end_loop_2006afcdfb5f407daea53d732670f938: ; END of loop_db4605c4e48e407fa94e7d833dba12d6
  
  func_5370696E_95e8282a7368416497b7562fa55785b2_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4E65676174697665_9f79c78400e24fc5a6105f38fcba8c70_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_2b1e4328c466475d8de86a9a4c1c8fc0: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_74d6c51c29874f86a6a6cc244ba871bc
  
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
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_2b1e4328c466475d8de86a9a4c1c8fc0 ; Reevaluate WHILE condition
  end_while_74d6c51c29874f86a6a6cc244ba871bc: ; END of while_2b1e4328c466475d8de86a9a4c1c8fc0
  
  mov rax, 0xFFFFFFFFFFFFFFB3
    push rax
  pop rax
    
    jmp func_4E65676174697665_9f79c78400e24fc5a6105f38fcba8c70_end
  func_4E65676174697665_9f79c78400e24fc5a6105f38fcba8c70_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4475616C5772697465_0445a5e79ff446999e5d137eb4ee5cb8_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x00000000000000CC
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x00000000000000DD
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_4475616C5772697465_0445a5e79ff446999e5d137eb4ee5cb8_end
  func_4475616C5772697465_0445a5e79ff446999e5d137eb4ee5cb8_end:
    mov rsp, rbp
    pop rbp
    ret
  func_52657665727365_2cb2d2580bbe456d91cadce7e746b8ad_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_52657665727365_2cb2d2580bbe456d91cadce7e746b8ad_end
  func_52657665727365_2cb2d2580bbe456d91cadce7e746b8ad_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4D69786564_adc2c0e6b76944f28d0168e1249364fb_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_4D69786564_adc2c0e6b76944f28d0168e1249364fb_end
  func_4D69786564_adc2c0e6b76944f28d0168e1249364fb_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5363616C6172_9711ee22ec4a4198a144e21ac4a0faf5_start:
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
    
    jmp func_5363616C6172_9711ee22ec4a4198a144e21ac4a0faf5_end
  func_5363616C6172_9711ee22ec4a4198a144e21ac4a0faf5_end:
    mov rsp, rbp
    pop rbp
    ret
  func_456D707479_8b711590873044a9b7592449f962b002_start:
  push rbp
    mov rbp, rsp
  mov rax, 0x000000000000000D
    push rax
  pop rax
    
    jmp func_456D707479_8b711590873044a9b7592449f962b002_end
  func_456D707479_8b711590873044a9b7592449f962b002_end:
    mov rsp, rbp
    pop rbp
    ret
  func_536978_d667a72ac3874576ad22a4246271a8ea_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 56]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 24]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_536978_d667a72ac3874576ad22a4246271a8ea_end
  func_536978_d667a72ac3874576ad22a4246271a8ea_end:
    mov rsp, rbp
    pop rbp
    ret
module_706169725F7265636569766572_5754ab0e2a5f49e88faec8f0a3048e11_end:
section .text
global ubytec_host_contract_DualWrite
ubytec_host_contract_DualWrite:
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
call func_4475616C5772697465_0445a5e79ff446999e5d137eb4ee5cb8_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Reverse
ubytec_host_contract_Reverse:
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
call func_52657665727365_2cb2d2580bbe456d91cadce7e746b8ad_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Mixed
ubytec_host_contract_Mixed:
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
call func_4D69786564_adc2c0e6b76944f28d0168e1249364fb_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Scalar
ubytec_host_contract_Scalar:
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
call func_5363616C6172_9711ee22ec4a4198a144e21ac4a0faf5_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Empty
ubytec_host_contract_Empty:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
sub rsp, 8
call func_456D707479_8b711590873044a9b7592449f962b002_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Six
ubytec_host_contract_Six:
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
push r8
push r9
call func_536978_d667a72ac3874576ad22a4246271a8ea_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
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
call func_436F7079_8b8d04f4980d4af0b39c024e92bc704b_start
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
call func_5061727469616C_da39e44f45504f03a42d6f6d442b729a_start
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
push rsi
push rdx
call func_5370696E_95e8282a7368416497b7562fa55785b2_start
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
push rdi
push rsi
push rdx
call func_4E65676174697665_9f79c78400e24fc5a6105f38fcba8c70_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,68,117,97,108,87,114,105,116,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,68,117,97,108,87,114,105,116,101,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,82,101,118,101,114,115,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,82,101,118,101,114,115,101,124,76,111,97,110,82,101,97,100,44,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,77,105,120,101,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,77,105,120,101,100,124,73,110,116,54,52,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,76,111,97,110,87,114,105,116,101,58,73,110,116,54,52,10,69,124,83,99,97,108,97,114,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,99,97,108,97,114,124,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,69,109,112,116,121,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,69,109,112,116,121,124,58,73,110,116,54,52,10,69,124,83,105,120,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,105,120,124,73,110,116,54,52,44,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,73,110,116,54,52,58,73,110,116,54,52,10,69,124,67,111,112,121,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,67,111,112,121,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,80,97,114,116,105,97,108,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,80,97,114,116,105,97,108,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,83,112,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,112,105,110,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,78,101,103,97,116,105,118,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,78,101,103,97,116,105,118,101,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
