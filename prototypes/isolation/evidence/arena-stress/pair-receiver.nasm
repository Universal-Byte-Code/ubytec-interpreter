module_706169725F7265636569766572_c1cdc1f90af74e27b95d4b9801339166_start:
; Module: pair_receiver v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 12:44:47Z
  ; Module UUID: c1cdc1f9-0af7-4e27-b95d-4b9801339166


  section .bss

  section .text

  func_436F7079_f806ea5baebe493a9b5d5d189a8b4f5d_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_6b0fdff784de436baf3287826672ee27: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_2e8dfc305f6443b681239b65ee742553
  
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
    jmp while_6b0fdff784de436baf3287826672ee27 ; Reevaluate WHILE condition
  end_while_2e8dfc305f6443b681239b65ee742553: ; END of while_6b0fdff784de436baf3287826672ee27
  
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_436F7079_f806ea5baebe493a9b5d5d189a8b4f5d_end
  func_436F7079_f806ea5baebe493a9b5d5d189a8b4f5d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C_343c578abd8047e1a27e53d73763bb6d_start:
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
    
    jmp func_5061727469616C_343c578abd8047e1a27e53d73763bb6d_end
  func_5061727469616C_343c578abd8047e1a27e53d73763bb6d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_16c61d0d963849dc974ae19c600a415e_start:
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
  loop_1a4149971f044c3a9834bf50e2a4a87a: ; LOOP start
    jmp loop_1a4149971f044c3a9834bf50e2a4a87a ; LOOP: continue iteration
  end_loop_76452ec1784c409ea88294e4190b429f: ; END of loop_1a4149971f044c3a9834bf50e2a4a87a
  
  func_5370696E_16c61d0d963849dc974ae19c600a415e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4E65676174697665_bd1cf4c0262343adaf781159dbef149f_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_ddf73a8c62d44ede85cc1687a91343ac: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_31500dc543eb4019b77677af52a6fa6c
  
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
    jmp while_ddf73a8c62d44ede85cc1687a91343ac ; Reevaluate WHILE condition
  end_while_31500dc543eb4019b77677af52a6fa6c: ; END of while_ddf73a8c62d44ede85cc1687a91343ac
  
  mov rax, 0xFFFFFFFFFFFFFFB3
    push rax
  pop rax
    
    jmp func_4E65676174697665_bd1cf4c0262343adaf781159dbef149f_end
  func_4E65676174697665_bd1cf4c0262343adaf781159dbef149f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4475616C5772697465_800e6728f3ce4061bb729eaf5ffcd685_start:
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
    
    jmp func_4475616C5772697465_800e6728f3ce4061bb729eaf5ffcd685_end
  func_4475616C5772697465_800e6728f3ce4061bb729eaf5ffcd685_end:
    mov rsp, rbp
    pop rbp
    ret
  func_52657665727365_9d34911c1c3747dd9fd7c559fb56512c_start:
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
    
    jmp func_52657665727365_9d34911c1c3747dd9fd7c559fb56512c_end
  func_52657665727365_9d34911c1c3747dd9fd7c559fb56512c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4D69786564_572f7ba2d57745aaadd818e1c80f622b_start:
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
    
    jmp func_4D69786564_572f7ba2d57745aaadd818e1c80f622b_end
  func_4D69786564_572f7ba2d57745aaadd818e1c80f622b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5363616C6172_d0da4f302bad4084b3429629236c2a7f_start:
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
    
    jmp func_5363616C6172_d0da4f302bad4084b3429629236c2a7f_end
  func_5363616C6172_d0da4f302bad4084b3429629236c2a7f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_456D707479_aa9600289e424deeb900256da98bd52c_start:
  push rbp
    mov rbp, rsp
  mov rax, 0x000000000000000D
    push rax
  pop rax
    
    jmp func_456D707479_aa9600289e424deeb900256da98bd52c_end
  func_456D707479_aa9600289e424deeb900256da98bd52c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_536978_0b4526779d7c4602b67459f5cf10236e_start:
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
    
    jmp func_536978_0b4526779d7c4602b67459f5cf10236e_end
  func_536978_0b4526779d7c4602b67459f5cf10236e_end:
    mov rsp, rbp
    pop rbp
    ret
module_706169725F7265636569766572_c1cdc1f90af74e27b95d4b9801339166_end:
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
call func_4475616C5772697465_800e6728f3ce4061bb729eaf5ffcd685_start
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
call func_52657665727365_9d34911c1c3747dd9fd7c559fb56512c_start
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
call func_4D69786564_572f7ba2d57745aaadd818e1c80f622b_start
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
call func_5363616C6172_d0da4f302bad4084b3429629236c2a7f_start
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
call func_456D707479_aa9600289e424deeb900256da98bd52c_start
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
call func_536978_0b4526779d7c4602b67459f5cf10236e_start
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
call func_436F7079_f806ea5baebe493a9b5d5d189a8b4f5d_start
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
call func_5061727469616C_343c578abd8047e1a27e53d73763bb6d_start
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
call func_5370696E_16c61d0d963849dc974ae19c600a415e_start
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
call func_4E65676174697665_bd1cf4c0262343adaf781159dbef149f_start
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
