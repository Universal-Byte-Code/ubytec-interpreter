module_646961676E6F737469635F6B65726E656C73_e43f2c2e99864e21a3ba3d0452b1f684_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 09:57:30Z
  ; Module UUID: e43f2c2e-9986-4e21-a3ba-3d0452b1f684


  section .bss

  section .text

  func_446961674964656E74697479_6cb109e125e744ba8eaac6edaa73db6b_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_6cb109e125e744ba8eaac6edaa73db6b_end
  func_446961674964656E74697479_6cb109e125e744ba8eaac6edaa73db6b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_0516df3583574b9baf0845e7f66c38e0_start:
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
  while_08507907d8c4422f8dc2be687dff1da0: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_6881a6d5dba54f87be95567417a33675
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
    jmp while_08507907d8c4422f8dc2be687dff1da0 ; Reevaluate WHILE condition
  end_while_6881a6d5dba54f87be95567417a33675: ; END of while_08507907d8c4422f8dc2be687dff1da0
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_0516df3583574b9baf0845e7f66c38e0_end
  func_446961674279746573_0516df3583574b9baf0845e7f66c38e0_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_8dc48fa64cee41e9a09e286014025ad4_start:
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
  while_a211adfd2c8849e3a627f2784a725a23: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_a70e1ce9848c46fd9d39d8dcf04daba6
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
    jmp while_a211adfd2c8849e3a627f2784a725a23 ; Reevaluate WHILE condition
  end_while_a70e1ce9848c46fd9d39d8dcf04daba6: ; END of while_a211adfd2c8849e3a627f2784a725a23
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_8dc48fa64cee41e9a09e286014025ad4_end
  func_446961675265636F726473_8dc48fa64cee41e9a09e286014025ad4_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_3339dce760ec44539619737536bb94a3_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_ff8dd8153ddb46a2b4c8694a718f806d: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_cb01d59479004c1b844a8ca579875f68
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
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 16]
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
  if_de5f05a4c3224c0d831a187d8a852b2d: ; IF start
  pop rax
    test rax, rax
    je end_if_8cceed6f4b6c4e99a2939ee6e5341e16
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_66745F6D656D636D70_5d44ac53ce9148b5a14d0a7f51b0a6e3_start
    add rsp, 24
    push rax
  if_1f93693120424dccbd6deec00f842f6b: ; IF start
  pop rax
    test rax, rax
    je end_if_acd01673aba2442fa6bf2489cf0a08ac
    jmp end_else_cb1d508b3a814ceb9c38a347314313a3     ; Jump over ELSE part
  end_if_acd01673aba2442fa6bf2489cf0a08ac:    ; if_1f93693120424dccbd6deec00f842f6b END
  else_f30dcecf0bf44e999f929c99754f5d4e:  ; Start ELSE block
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_3339dce760ec44539619737536bb94a3_end
  end_else_cb1d508b3a814ceb9c38a347314313a3: ; END of else_f30dcecf0bf44e999f929c99754f5d4e
  end_if_8cceed6f4b6c4e99a2939ee6e5341e16: ; END of if_de5f05a4c3224c0d831a187d8a852b2d
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_ff8dd8153ddb46a2b4c8694a718f806d ; Reevaluate WHILE condition
  end_while_cb01d59479004c1b844a8ca579875f68: ; END of while_ff8dd8153ddb46a2b4c8694a718f806d
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_3339dce760ec44539619737536bb94a3_end
  func_446961674C6F6F6B7570_3339dce760ec44539619737536bb94a3_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F6D656D636D70_5d44ac53ce9148b5a14d0a7f51b0a6e3_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  ; frame-registers: write-through leaf values
  mov r10, qword [rbp + 24]
  mov r9, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  while_d64faccc6ab2409f8876743e6f505d8a: ; WHILE start
  mov rax, r9
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_3ac988b020114f0da2c91559de3833c8
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
  if_664d6bb23022480a8b60eb41aa79bde1: ; IF start
  movsxd rax, dword [rbp - 24]
    mov rcx, rax
    movsxd rax, dword [rbp - 16]
    cmp rax, rcx
    je end_if_e12ceb4c360f4e70988b20e9cc356327
  movsxd rax, dword [rbp - 16]
    push rax
  movsxd rax, dword [rbp - 24]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    sub rax, rcx
  mov qword [rsp - 8], rax
    movsxd rax, eax
    jmp func_66745F6D656D636D70_5d44ac53ce9148b5a14d0a7f51b0a6e3_end
  end_if_e12ceb4c360f4e70988b20e9cc356327: ; END of if_664d6bb23022480a8b60eb41aa79bde1
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_d64faccc6ab2409f8876743e6f505d8a ; Reevaluate WHILE condition
  end_while_3ac988b020114f0da2c91559de3833c8: ; END of while_d64faccc6ab2409f8876743e6f505d8a
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    movsxd rax, eax
    jmp func_66745F6D656D636D70_5d44ac53ce9148b5a14d0a7f51b0a6e3_end
  func_66745F6D656D636D70_5d44ac53ce9148b5a14d0a7f51b0a6e3_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_e43f2c2e99864e21a3ba3d0452b1f684_end:
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
call func_446961674964656E74697479_6cb109e125e744ba8eaac6edaa73db6b_start
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
call func_446961674279746573_0516df3583574b9baf0845e7f66c38e0_start
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
call func_446961675265636F726473_8dc48fa64cee41e9a09e286014025ad4_start
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
call func_446961674C6F6F6B7570_3339dce760ec44539619737536bb94a3_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
