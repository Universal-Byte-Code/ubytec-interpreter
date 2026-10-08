module_646961676E6F737469635F6B65726E656C73_3ae664768e7d41f5a468977e880a4603_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 23:38:23Z
  ; Module UUID: 3ae66476-8e7d-41f5-a468-977e880a4603


  section .bss

  section .text

  func_446961674964656E74697479_796bca5ddd1147f59dd358f8313e4906_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_796bca5ddd1147f59dd358f8313e4906_end
  func_446961674964656E74697479_796bca5ddd1147f59dd358f8313e4906_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_ec7b75f0d5f544f8822c3bd7ce848a2e_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; frame-registers: write-through leaf values
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  while_1550bb6cc4b74a50ba9b1c7f4d06aa6c: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_26ba81c5dde04b43bbf4c3faa7ff596e
  push r9
  mov rax, qword [rbp + 24]
    push rax
  mov qword [rsp - 8], r8
  mov rcx, r8
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
    mov r9, rax
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_1550bb6cc4b74a50ba9b1c7f4d06aa6c ; Reevaluate WHILE condition
  end_while_26ba81c5dde04b43bbf4c3faa7ff596e: ; END of while_1550bb6cc4b74a50ba9b1c7f4d06aa6c
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_ec7b75f0d5f544f8822c3bd7ce848a2e_end
  func_446961674279746573_ec7b75f0d5f544f8822c3bd7ce848a2e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_10b4e0a5a0594db78f21e00b3dd2da99_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; frame-registers: write-through leaf values
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  while_206b4d4945a64a9aab35faa9b348074e: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_209dc1df525b44a6bf0234f39cfe2152
  push r9
  mov rax, qword [rbp + 24]
    push rax
  push r8
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
    mov r9, rax
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_206b4d4945a64a9aab35faa9b348074e ; Reevaluate WHILE condition
  end_while_209dc1df525b44a6bf0234f39cfe2152: ; END of while_206b4d4945a64a9aab35faa9b348074e
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_10b4e0a5a0594db78f21e00b3dd2da99_end
  func_446961675265636F726473_10b4e0a5a0594db78f21e00b3dd2da99_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_a45f7f7c70374383a930bf3642ccf26f_start:
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
  ; frame-registers: write-through leaf values
  mov r10, qword [rbp + 16]
  mov r9, qword [rbp - 8]
  mov r8, qword [rbp - 16]
  while_6b03ed7ea9014e78814a4347568b7f56: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_3fd18e1c766d4059a50894c04ac78563
  mov rax, qword [rbp + 40]
    push rax
  push r9
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
  mov qword [rsp - 8], r10
  mov rcx, r10
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    push rax
  if_bb9719fc57f245a7bda5d23a8dfa1f55: ; IF start
  pop rax
    test rax, rax
    je end_if_7936f0eb76d14a4b9d2ed49ef12b69d2
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_8b20b617cbdf478f8ceb2696a8a2c566: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_8ea3e1840e834324ab2393adca4d8043
  mov rax, qword [rbp - 32]
    push rax
  mov qword [rsp - 8], r8
  mov rcx, r8
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov qword [rsp - 8], r8
  mov rcx, r8
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
  if_8235b993b1c24292ae33d78a803c7caf: ; IF start
  pop rax
    test rax, rax
    je end_if_c1fdec9ca6d84febb5369542ba20c3f5
  jmp end_while_8ea3e1840e834324ab2393adca4d8043 ; BREAK
  end_if_c1fdec9ca6d84febb5369542ba20c3f5: ; END of if_8235b993b1c24292ae33d78a803c7caf
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_8b20b617cbdf478f8ceb2696a8a2c566 ; Reevaluate WHILE condition
  end_while_8ea3e1840e834324ab2393adca4d8043: ; END of while_8b20b617cbdf478f8ceb2696a8a2c566
  if_081637f6ddc841158bfbd371a922ed47: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_d682e2058bb04047a59d45bc996138ff
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_a45f7f7c70374383a930bf3642ccf26f_end
  end_if_d682e2058bb04047a59d45bc996138ff: ; END of if_081637f6ddc841158bfbd371a922ed47
  end_if_7936f0eb76d14a4b9d2ed49ef12b69d2: ; END of if_bb9719fc57f245a7bda5d23a8dfa1f55
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_6b03ed7ea9014e78814a4347568b7f56 ; Reevaluate WHILE condition
  end_while_3fd18e1c766d4059a50894c04ac78563: ; END of while_6b03ed7ea9014e78814a4347568b7f56
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_a45f7f7c70374383a930bf3642ccf26f_end
  func_446961674C6F6F6B7570_a45f7f7c70374383a930bf3642ccf26f_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_3ae664768e7d41f5a468977e880a4603_end:
section .text
global ubytec_host_register_DiagBytes
ubytec_host_register_DiagBytes:
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
call func_446961674279746573_ec7b75f0d5f544f8822c3bd7ce848a2e_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
