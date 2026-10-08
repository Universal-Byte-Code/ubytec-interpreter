module_646961676E6F737469635F6B65726E656C73_60c4601402b445489ab1ae79020e9eda_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 09:59:36Z
  ; Module UUID: 60c46014-02b4-4548-9ab1-ae79020e9eda


  section .bss

  section .text

  func_446961674964656E74697479_f927004cef814483a162460d544532c3_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_f927004cef814483a162460d544532c3_end
  func_446961674964656E74697479_f927004cef814483a162460d544532c3_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_3f9c2d4900fd4cd280b49b29df1a6988_start:
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
  while_1ff6405f04494a14ac03e2e6f5865e63: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_6696fecf99b24bd1ba0c93384be109a1
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
    jmp while_1ff6405f04494a14ac03e2e6f5865e63 ; Reevaluate WHILE condition
  end_while_6696fecf99b24bd1ba0c93384be109a1: ; END of while_1ff6405f04494a14ac03e2e6f5865e63
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_3f9c2d4900fd4cd280b49b29df1a6988_end
  func_446961674279746573_3f9c2d4900fd4cd280b49b29df1a6988_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_8026626c07ab47ffb250dfb00fb76516_start:
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
  while_4c5775658ea345b38829154f3178eebb: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_a1c3cfcfa4a0484cbaa4abe6d4724391
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
    jmp while_4c5775658ea345b38829154f3178eebb ; Reevaluate WHILE condition
  end_while_a1c3cfcfa4a0484cbaa4abe6d4724391: ; END of while_4c5775658ea345b38829154f3178eebb
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_8026626c07ab47ffb250dfb00fb76516_end
  func_446961675265636F726473_8026626c07ab47ffb250dfb00fb76516_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_d8a3cd81905f4a61913baea1ebabae80_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_d28a50e0ea084268be54a1d9947f6953: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_eba256476f284a59b6c477872251f7ef
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
  if_d5cda15c36924a90a944b70e87ad33bf: ; IF start
  pop rax
    test rax, rax
    je end_if_3bf824d83a384073a3060477cb7e5aec
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_66745F6D656D636D70_c8b026df81ee4445980869310c0b2582_start
    add rsp, 24
    push rax
  if_1d0b66c35da44d7cb483f3ef7cbdaf31: ; IF start
  pop rax
    test rax, rax
    je end_if_282cbabbf1d94d0a82b1625b92f664ea
    jmp end_else_0127f396d2a74f37a999b9f3b267ad0a     ; Jump over ELSE part
  end_if_282cbabbf1d94d0a82b1625b92f664ea:    ; if_1d0b66c35da44d7cb483f3ef7cbdaf31 END
  else_a8cb65c5ac2d4b709c0f184fdc64e7df:  ; Start ELSE block
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_d8a3cd81905f4a61913baea1ebabae80_end
  end_else_0127f396d2a74f37a999b9f3b267ad0a: ; END of else_a8cb65c5ac2d4b709c0f184fdc64e7df
  end_if_3bf824d83a384073a3060477cb7e5aec: ; END of if_d5cda15c36924a90a944b70e87ad33bf
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_d28a50e0ea084268be54a1d9947f6953 ; Reevaluate WHILE condition
  end_while_eba256476f284a59b6c477872251f7ef: ; END of while_d28a50e0ea084268be54a1d9947f6953
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_d8a3cd81905f4a61913baea1ebabae80_end
  func_446961674C6F6F6B7570_d8a3cd81905f4a61913baea1ebabae80_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F6D656D636D70_c8b026df81ee4445980869310c0b2582_start:
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
  while_6948b71833714167bda8f49e38b633a2: ; WHILE start
  mov rax, r9
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_d418cc86a762419db135fc197c219644
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
  if_ae2f5cb32e6c463e963b6f32e9ead9ff: ; IF start
  movsxd rax, dword [rbp - 24]
    mov rcx, rax
    movsxd rax, dword [rbp - 16]
    cmp rax, rcx
    je end_if_4f79fc68320446c0b4f2f610a7dc1ddc
  movsxd rax, dword [rbp - 16]
    push rax
  movsxd rax, dword [rbp - 24]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    sub rax, rcx
  mov qword [rsp - 8], rax
    movsxd rax, eax
    jmp func_66745F6D656D636D70_c8b026df81ee4445980869310c0b2582_end
  end_if_4f79fc68320446c0b4f2f610a7dc1ddc: ; END of if_ae2f5cb32e6c463e963b6f32e9ead9ff
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_6948b71833714167bda8f49e38b633a2 ; Reevaluate WHILE condition
  end_while_d418cc86a762419db135fc197c219644: ; END of while_6948b71833714167bda8f49e38b633a2
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    movsxd rax, eax
    jmp func_66745F6D656D636D70_c8b026df81ee4445980869310c0b2582_end
  func_66745F6D656D636D70_c8b026df81ee4445980869310c0b2582_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_60c4601402b445489ab1ae79020e9eda_end:
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
call func_446961674964656E74697479_f927004cef814483a162460d544532c3_start
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
call func_446961674279746573_3f9c2d4900fd4cd280b49b29df1a6988_start
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
call func_446961675265636F726473_8026626c07ab47ffb250dfb00fb76516_start
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
call func_446961674C6F6F6B7570_d8a3cd81905f4a61913baea1ebabae80_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
