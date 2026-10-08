module_646961676E6F737469635F6B65726E656C73_4cbac498657e43b084a1e90b163c8ffa_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 09:59:39Z
  ; Module UUID: 4cbac498-657e-43b0-84a1-e90b163c8ffa


  section .bss

  section .text

  func_446961674964656E74697479_d3c2a51eecfe4ff2b1fac064f2c8d5a4_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_d3c2a51eecfe4ff2b1fac064f2c8d5a4_end
  func_446961674964656E74697479_d3c2a51eecfe4ff2b1fac064f2c8d5a4_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_da95bd83e0a84ef89e1bef083d7db8b3_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; effect-registers: write-through copies, raw-store/call reload boundaries
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  while_41cdb6eab5b6447686a9504868f44617: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_9a67c2c7663d45dbadc2dbf366e069b9
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
    jmp while_41cdb6eab5b6447686a9504868f44617 ; Reevaluate WHILE condition
  end_while_9a67c2c7663d45dbadc2dbf366e069b9: ; END of while_41cdb6eab5b6447686a9504868f44617
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_da95bd83e0a84ef89e1bef083d7db8b3_end
  func_446961674279746573_da95bd83e0a84ef89e1bef083d7db8b3_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_ef6b54e3e64e436481b567e90f33c639_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; effect-registers: write-through copies, raw-store/call reload boundaries
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  while_11ad6b492d634269a872c01ec425691b: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_2afd24c1a8e74c0ebfd511971e52159a
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
    jmp while_11ad6b492d634269a872c01ec425691b ; Reevaluate WHILE condition
  end_while_2afd24c1a8e74c0ebfd511971e52159a: ; END of while_11ad6b492d634269a872c01ec425691b
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_ef6b54e3e64e436481b567e90f33c639_end
  func_446961675265636F726473_ef6b54e3e64e436481b567e90f33c639_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_725eacb940c045699c5d5b27e21c7ee5_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; effect-registers: write-through copies, raw-store/call reload boundaries
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  while_be1e07d1ae88468db0fa71ff52caa209: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_2424b496bd124d408c6b532e1a1c82e9
  mov rax, qword [rbp + 40]
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
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r9, rax
  push r9
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
  if_700846a583424ca6bf1ad3a6a2c45581: ; IF start
  pop rax
    test rax, rax
    je end_if_4a30630c171c4f19bbba994c07646092
  mov qword [rsp - 8], r9
  mov rax, r9
    mov rax, qword [rax]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  push r10
  call func_66745F6D656D636D70_07dd1a75eef445cebaa52a82ea631f50_start
    add rsp, 24
    push rax
  ; effect-registers: reload after CALL
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  if_0e5d997139724074abef7c7bc01a009d: ; IF start
  pop rax
    test rax, rax
    je end_if_a3440bec97944212876610c65eeae158
    jmp end_else_dcf534efdab64ba1a1ec5de7cb07599a     ; Jump over ELSE part
  end_if_a3440bec97944212876610c65eeae158:    ; if_0e5d997139724074abef7c7bc01a009d END
  else_6615fb3ba1de4d07a0c2a9947af59510:  ; Start ELSE block
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_725eacb940c045699c5d5b27e21c7ee5_end
  end_else_dcf534efdab64ba1a1ec5de7cb07599a: ; END of else_6615fb3ba1de4d07a0c2a9947af59510
  end_if_4a30630c171c4f19bbba994c07646092: ; END of if_700846a583424ca6bf1ad3a6a2c45581
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_be1e07d1ae88468db0fa71ff52caa209 ; Reevaluate WHILE condition
  end_while_2424b496bd124d408c6b532e1a1c82e9: ; END of while_be1e07d1ae88468db0fa71ff52caa209
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_725eacb940c045699c5d5b27e21c7ee5_end
  func_446961674C6F6F6B7570_725eacb940c045699c5d5b27e21c7ee5_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F6D656D636D70_07dd1a75eef445cebaa52a82ea631f50_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  ; effect-registers: write-through copies, raw-store/call reload boundaries
  mov r10, qword [rbp + 24]
  mov r9, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  while_d72b14e3e2574f6688ddfc980fe5766f: ; WHILE start
  mov rax, r9
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_48bd7515fa1a4d55b8bbe7fb6189d55d
  mov rax, qword [rbp + 32]
    push rax
  mov qword [rsp - 8], r8
  mov rcx, r8
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
  mov qword [rsp - 8], rax
    movsxd rax, eax
    mov qword [rbp - 16], rax
  push r10
  mov qword [rsp - 8], r8
  mov rcx, r8
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
  mov qword [rsp - 8], rax
    movsxd rax, eax
    mov qword [rbp - 24], rax
  if_dd932c7bffef47459fad2090fe2c3614: ; IF start
  movsxd rax, dword [rbp - 24]
    mov rcx, rax
    movsxd rax, dword [rbp - 16]
    cmp rax, rcx
    je end_if_c1a38ddc3bca4274805e1bd080bfd9b1
  movsxd rax, dword [rbp - 16]
    push rax
  movsxd rax, dword [rbp - 24]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    sub rax, rcx
  mov qword [rsp - 8], rax
    movsxd rax, eax
    jmp func_66745F6D656D636D70_07dd1a75eef445cebaa52a82ea631f50_end
  end_if_c1a38ddc3bca4274805e1bd080bfd9b1: ; END of if_dd932c7bffef47459fad2090fe2c3614
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_d72b14e3e2574f6688ddfc980fe5766f ; Reevaluate WHILE condition
  end_while_48bd7515fa1a4d55b8bbe7fb6189d55d: ; END of while_d72b14e3e2574f6688ddfc980fe5766f
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    movsxd rax, eax
    jmp func_66745F6D656D636D70_07dd1a75eef445cebaa52a82ea631f50_end
  func_66745F6D656D636D70_07dd1a75eef445cebaa52a82ea631f50_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_4cbac498657e43b084a1e90b163c8ffa_end:
section .text
global ubytec_host_register_DiagIdentity
ubytec_host_register_DiagIdentity:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
call func_446961674964656E74697479_d3c2a51eecfe4ff2b1fac064f2c8d5a4_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

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
call func_446961674279746573_da95bd83e0a84ef89e1bef083d7db8b3_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_register_DiagRecords
ubytec_host_register_DiagRecords:
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
call func_446961675265636F726473_ef6b54e3e64e436481b567e90f33c639_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_register_DiagLookup
ubytec_host_register_DiagLookup:
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
call func_446961674C6F6F6B7570_725eacb940c045699c5d5b27e21c7ee5_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
