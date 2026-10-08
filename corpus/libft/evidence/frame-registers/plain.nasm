module_646961676E6F737469635F6B65726E656C73_f31471266aaa44b78f40f2b2ce8d7539_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 22:48:25Z
  ; Module UUID: f3147126-6aaa-44b7-8f40-f2b2ce8d7539


  section .bss

  section .text

  func_446961674964656E74697479_f9bc29fceb734a01be1afb26625ce4da_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_f9bc29fceb734a01be1afb26625ce4da_end
  func_446961674964656E74697479_f9bc29fceb734a01be1afb26625ce4da_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_b6e11a3672e34f098143015b9f0aa021_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_f95d8bd7e1ac4b5a95c9695275d89d39: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_d69a875100ae425cb855b68a18e3afa3
  mov rax, qword [rbp - 16]
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
    add rax, rcx
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_f95d8bd7e1ac4b5a95c9695275d89d39 ; Reevaluate WHILE condition
  end_while_d69a875100ae425cb855b68a18e3afa3: ; END of while_f95d8bd7e1ac4b5a95c9695275d89d39
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674279746573_b6e11a3672e34f098143015b9f0aa021_end
  func_446961674279746573_b6e11a3672e34f098143015b9f0aa021_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_ef3f83c10c574433a23bd137e9866ca1_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_57ea36ea28ee451883566e6017081b1c: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_3eea474e5dfa4e33abca57da59f78f26
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000000018
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    imul rax, rcx
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000010
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_57ea36ea28ee451883566e6017081b1c ; Reevaluate WHILE condition
  end_while_3eea474e5dfa4e33abca57da59f78f26: ; END of while_57ea36ea28ee451883566e6017081b1c
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961675265636F726473_ef3f83c10c574433a23bd137e9866ca1_end
  func_446961675265636F726473_ef3f83c10c574433a23bd137e9866ca1_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_351467b49ca741f786079e0c048c6790_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 32], rax
  while_d7edd0ea14dc4406b8bd21273ff04610: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_ac5305125dcb44a7afe770d743243c1c
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000000018
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    imul rax, rcx
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, 0x0000000000000008
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
    push rax
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    push rax
  if_ce771acddb764a5a992c9b5eb0483832: ; IF start
  pop rax
    test rax, rax
    je end_if_2f15c68a62e943e3a52810227ad4068d
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
  while_de678dbe724c4a8aa067b6e3edbe36e0: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_7518a95d9e4d4d319a84645a4517d37f
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    push rax
  if_50340bb60be544a8bda24cf5fff5a72f: ; IF start
  pop rax
    test rax, rax
    je end_if_186d0f41124248919ca7f9d994f17c2e
  jmp end_while_7518a95d9e4d4d319a84645a4517d37f ; BREAK
  end_if_186d0f41124248919ca7f9d994f17c2e: ; END of if_50340bb60be544a8bda24cf5fff5a72f
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    jmp while_de678dbe724c4a8aa067b6e3edbe36e0 ; Reevaluate WHILE condition
  end_while_7518a95d9e4d4d319a84645a4517d37f: ; END of while_de678dbe724c4a8aa067b6e3edbe36e0
  if_2ca3dcbac1844b4182e3d9503e69eacc: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_43fb6d172f7646499887f0cddbeebf77
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_351467b49ca741f786079e0c048c6790_end
  end_if_43fb6d172f7646499887f0cddbeebf77: ; END of if_2ca3dcbac1844b4182e3d9503e69eacc
  end_if_2f15c68a62e943e3a52810227ad4068d: ; END of if_ce771acddb764a5a992c9b5eb0483832
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_d7edd0ea14dc4406b8bd21273ff04610 ; Reevaluate WHILE condition
  end_while_ac5305125dcb44a7afe770d743243c1c: ; END of while_d7edd0ea14dc4406b8bd21273ff04610
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_351467b49ca741f786079e0c048c6790_end
  func_446961674C6F6F6B7570_351467b49ca741f786079e0c048c6790_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_f31471266aaa44b78f40f2b2ce8d7539_end:
section .text
global ubytec_host_plain_DiagIdentity
ubytec_host_plain_DiagIdentity:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
call func_446961674964656E74697479_f9bc29fceb734a01be1afb26625ce4da_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_plain_DiagBytes
ubytec_host_plain_DiagBytes:
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
call func_446961674279746573_b6e11a3672e34f098143015b9f0aa021_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_plain_DiagRecords
ubytec_host_plain_DiagRecords:
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
call func_446961675265636F726473_ef3f83c10c574433a23bd137e9866ca1_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_plain_DiagLookup
ubytec_host_plain_DiagLookup:
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
call func_446961674C6F6F6B7570_351467b49ca741f786079e0c048c6790_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
