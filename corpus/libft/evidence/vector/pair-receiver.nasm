module_706169725F7265636569766572_822bd45c9ad04981962be48a9d5bc6f3_start:
; Module: pair_receiver v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 15:13:03Z
  ; Module UUID: 822bd45c-9ad0-4981-962b-e48a9d5bc6f3


  section .bss

  section .text

  func_436F7079_058bb578c8774895999ea289fa1e16ad_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_51cab33488d5427aa44fb29cdd6d3400: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_7724d5a73e6c4697b81403b875e56254
  
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
    jmp while_51cab33488d5427aa44fb29cdd6d3400 ; Reevaluate WHILE condition
  end_while_7724d5a73e6c4697b81403b875e56254: ; END of while_51cab33488d5427aa44fb29cdd6d3400
  
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_436F7079_058bb578c8774895999ea289fa1e16ad_end
  func_436F7079_058bb578c8774895999ea289fa1e16ad_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C_45b806d1650344c18e4fe6c3af4dfae8_start:
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
    
    jmp func_5061727469616C_45b806d1650344c18e4fe6c3af4dfae8_end
  func_5061727469616C_45b806d1650344c18e4fe6c3af4dfae8_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_9d0212c392a14dd5a026666e430390ed_start:
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
  loop_ce58dd2874c34a5cb7617e9318831b8a: ; LOOP start
    jmp loop_ce58dd2874c34a5cb7617e9318831b8a ; LOOP: continue iteration
  end_loop_d748bc8eb8654572a4f97cbbbe1d5eb3: ; END of loop_ce58dd2874c34a5cb7617e9318831b8a
  
  func_5370696E_9d0212c392a14dd5a026666e430390ed_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4E65676174697665_b2e04c0796b544fd9b58c592403f4c63_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_afbf07d761bc400bb8f34c0925b3802d: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_c682a6e7e3c544d8aaeb93632dddba29
  
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
    jmp while_afbf07d761bc400bb8f34c0925b3802d ; Reevaluate WHILE condition
  end_while_c682a6e7e3c544d8aaeb93632dddba29: ; END of while_afbf07d761bc400bb8f34c0925b3802d
  
  mov rax, 0xFFFFFFFFFFFFFFB3
    push rax
  pop rax
    
    jmp func_4E65676174697665_b2e04c0796b544fd9b58c592403f4c63_end
  func_4E65676174697665_b2e04c0796b544fd9b58c592403f4c63_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4475616C5772697465_d4cb610524c84469bb7114444eeff2ea_start:
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
    
    jmp func_4475616C5772697465_d4cb610524c84469bb7114444eeff2ea_end
  func_4475616C5772697465_d4cb610524c84469bb7114444eeff2ea_end:
    mov rsp, rbp
    pop rbp
    ret
  func_52657665727365_dd9b13b2f0324248894a76f8a1a08473_start:
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
    
    jmp func_52657665727365_dd9b13b2f0324248894a76f8a1a08473_end
  func_52657665727365_dd9b13b2f0324248894a76f8a1a08473_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4D69786564_7ae1c249bc364900912c6b6f085b9294_start:
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
    
    jmp func_4D69786564_7ae1c249bc364900912c6b6f085b9294_end
  func_4D69786564_7ae1c249bc364900912c6b6f085b9294_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5363616C6172_ce22ac2d57ca4b5dbfee322f54753a13_start:
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
    
    jmp func_5363616C6172_ce22ac2d57ca4b5dbfee322f54753a13_end
  func_5363616C6172_ce22ac2d57ca4b5dbfee322f54753a13_end:
    mov rsp, rbp
    pop rbp
    ret
  func_456D707479_f1f0e6e622614cc68937ceed35bed91f_start:
  push rbp
    mov rbp, rsp
  mov rax, 0x000000000000000D
    push rax
  pop rax
    
    jmp func_456D707479_f1f0e6e622614cc68937ceed35bed91f_end
  func_456D707479_f1f0e6e622614cc68937ceed35bed91f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_536978_216bc92b430d4bd98863bf434dc94ff9_start:
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
    
    jmp func_536978_216bc92b430d4bd98863bf434dc94ff9_end
  func_536978_216bc92b430d4bd98863bf434dc94ff9_end:
    mov rsp, rbp
    pop rbp
    ret
module_706169725F7265636569766572_822bd45c9ad04981962be48a9d5bc6f3_end:
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
call func_4475616C5772697465_d4cb610524c84469bb7114444eeff2ea_start
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
call func_52657665727365_dd9b13b2f0324248894a76f8a1a08473_start
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
call func_4D69786564_7ae1c249bc364900912c6b6f085b9294_start
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
call func_5363616C6172_ce22ac2d57ca4b5dbfee322f54753a13_start
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
call func_456D707479_f1f0e6e622614cc68937ceed35bed91f_start
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
call func_536978_216bc92b430d4bd98863bf434dc94ff9_start
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
call func_436F7079_058bb578c8774895999ea289fa1e16ad_start
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
call func_5061727469616C_45b806d1650344c18e4fe6c3af4dfae8_start
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
call func_5370696E_9d0212c392a14dd5a026666e430390ed_start
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
call func_4E65676174697665_b2e04c0796b544fd9b58c592403f4c63_start
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
