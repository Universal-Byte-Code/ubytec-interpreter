module_756E7369676E65645F6E6174697665_ea14b9ac5b8e4a7caf4a411c644a1a0e_start:
; Module: unsigned_native v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 13:30:30Z
  ; Module UUID: ea14b9ac-5b8e-4a7c-af4a-411c644a1a0e


  section .bss

  section .text

  func_556E7369676E6564446976_eb3224a9bd3b4646bd02cd483c24c841_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    xor edx, edx
    div rcx
    push rax
  pop rax
    
    jmp func_556E7369676E6564446976_eb3224a9bd3b4646bd02cd483c24c841_end
  func_556E7369676E6564446976_eb3224a9bd3b4646bd02cd483c24c841_end:
    mov rsp, rbp
    pop rbp
    ret
  func_556E7369676E65644D6F64_aaa28b4aad96433e82c742271a78b69b_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    xor edx, edx
    div rcx
    push rdx
  pop rax
    
    jmp func_556E7369676E65644D6F64_aaa28b4aad96433e82c742271a78b69b_end
  func_556E7369676E65644D6F64_aaa28b4aad96433e82c742271a78b69b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4C6F676963616C5368696674_b398556d20784e579db1b10f9bad89fb_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    shr rax, cl
    push rax
  pop rax
    
    jmp func_4C6F676963616C5368696674_b398556d20784e579db1b10f9bad89fb_end
  func_4C6F676963616C5368696674_b398556d20784e579db1b10f9bad89fb_end:
    mov rsp, rbp
    pop rbp
    ret
  func_556E7369676E65644C74_5645b764db4d45b88bbde211f56d96be_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setb al
    movzx eax, al
    push rax
  pop rax
    
    jmp func_556E7369676E65644C74_5645b764db4d45b88bbde211f56d96be_end
  func_556E7369676E65644C74_5645b764db4d45b88bbde211f56d96be_end:
    mov rsp, rbp
    pop rbp
    ret
  func_556E7369676E65644C65_b56f6676a7354ea781b67bf3687a5d0d_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setbe al
    movzx eax, al
    push rax
  pop rax
    
    jmp func_556E7369676E65644C65_b56f6676a7354ea781b67bf3687a5d0d_end
  func_556E7369676E65644C65_b56f6676a7354ea781b67bf3687a5d0d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_556E7369676E65644774_9d4119c58ef34ff4a6457c7b91f6555f_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    seta al
    movzx eax, al
    push rax
  pop rax
    
    jmp func_556E7369676E65644774_9d4119c58ef34ff4a6457c7b91f6555f_end
  func_556E7369676E65644774_9d4119c58ef34ff4a6457c7b91f6555f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_556E7369676E65644765_6f66f517923749beabfd258d0a4c953e_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setae al
    movzx eax, al
    push rax
  pop rax
    
    jmp func_556E7369676E65644765_6f66f517923749beabfd258d0a4c953e_end
  func_556E7369676E65644765_6f66f517923749beabfd258d0a4c953e_end:
    mov rsp, rbp
    pop rbp
    ret
module_756E7369676E65645F6E6174697665_ea14b9ac5b8e4a7caf4a411c644a1a0e_end:
section .text
global ubytec_host_contract_UnsignedDiv
ubytec_host_contract_UnsignedDiv:
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
call func_556E7369676E6564446976_eb3224a9bd3b4646bd02cd483c24c841_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_UnsignedMod
ubytec_host_contract_UnsignedMod:
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
call func_556E7369676E65644D6F64_aaa28b4aad96433e82c742271a78b69b_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_LogicalShift
ubytec_host_contract_LogicalShift:
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
call func_4C6F676963616C5368696674_b398556d20784e579db1b10f9bad89fb_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_UnsignedLt
ubytec_host_contract_UnsignedLt:
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
call func_556E7369676E65644C74_5645b764db4d45b88bbde211f56d96be_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_UnsignedLe
ubytec_host_contract_UnsignedLe:
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
call func_556E7369676E65644C65_b56f6676a7354ea781b67bf3687a5d0d_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_UnsignedGt
ubytec_host_contract_UnsignedGt:
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
call func_556E7369676E65644774_9d4119c58ef34ff4a6457c7b91f6555f_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_UnsignedGe
ubytec_host_contract_UnsignedGe:
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
call func_556E7369676E65644765_6f66f517923749beabfd258d0a4c953e_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,85,110,115,105,103,110,101,100,68,105,118,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,85,110,115,105,103,110,101,100,68,105,118,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,85,110,115,105,103,110,101,100,77,111,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,85,110,115,105,103,110,101,100,77,111,100,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,76,111,103,105,99,97,108,83,104,105,102,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,76,111,103,105,99,97,108,83,104,105,102,116,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,85,110,115,105,103,110,101,100,76,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,85,110,115,105,103,110,101,100,76,116,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,85,110,115,105,103,110,101,100,76,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,85,110,115,105,103,110,101,100,76,101,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,85,110,115,105,103,110,101,100,71,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,85,110,115,105,103,110,101,100,71,116,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,85,110,115,105,103,110,101,100,71,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,85,110,115,105,103,110,101,100,71,101,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
