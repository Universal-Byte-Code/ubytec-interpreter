module_646961676E6F737469635F6B65726E656C73_488959461fd8420b976d3f04e18a36c9_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:35:38Z
  ; Module UUID: 48895946-1fd8-420b-976d-3f04e18a36c9


  section .bss

  section .text

  func_446961674964656E74697479_52e6da82e1c94c5fa68dc2bd6bc42473_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_52e6da82e1c94c5fa68dc2bd6bc42473_end
  func_446961674964656E74697479_52e6da82e1c94c5fa68dc2bd6bc42473_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_e9363966a77e4a51ab0c612d6e41cd8a_start:
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
  while_05c740d7c0784dffbbb85c514820b296: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_c85a76f5fc654539be6791560e923a83
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
    jmp while_05c740d7c0784dffbbb85c514820b296 ; Reevaluate WHILE condition
  end_while_c85a76f5fc654539be6791560e923a83: ; END of while_05c740d7c0784dffbbb85c514820b296
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_e9363966a77e4a51ab0c612d6e41cd8a_end
  func_446961674279746573_e9363966a77e4a51ab0c612d6e41cd8a_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_f7e28cdc7470475b8d9d6e7757b99f32_start:
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
  while_35b051888a744cfe98b279fcfbc95516: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_1ca2c931aaef40538ab54f31da360bc5
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
    jmp while_35b051888a744cfe98b279fcfbc95516 ; Reevaluate WHILE condition
  end_while_1ca2c931aaef40538ab54f31da360bc5: ; END of while_35b051888a744cfe98b279fcfbc95516
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_f7e28cdc7470475b8d9d6e7757b99f32_end
  func_446961675265636F726473_f7e28cdc7470475b8d9d6e7757b99f32_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_cda7310014a046d2bed29352f5a1a5de_start:
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
  while_57b61d8b5d054904bfa110abee70ca5f: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_b00020b156eb4aeeb13ca4f425449e7b
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
  if_fe769ea212ef4a2bafb0a95f74ec519e: ; IF start
  pop rax
    test rax, rax
    je end_if_9e5b727485384e338abe03194f831bbd
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_a54d9b6cf6144332b876507227b5d471: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_f71fa68cf91b46f7a9127abdd7a338ae
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
  if_4df77615377749818247296acf7759a1: ; IF start
  pop rax
    test rax, rax
    je end_if_9130db9a026d4024af64d2d6f6ae56c2
  jmp end_while_f71fa68cf91b46f7a9127abdd7a338ae ; BREAK
  end_if_9130db9a026d4024af64d2d6f6ae56c2: ; END of if_4df77615377749818247296acf7759a1
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_a54d9b6cf6144332b876507227b5d471 ; Reevaluate WHILE condition
  end_while_f71fa68cf91b46f7a9127abdd7a338ae: ; END of while_a54d9b6cf6144332b876507227b5d471
  if_f7880e4e769a4c2abeb67d2bf972dbd8: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_2a18c7d846e940498d9a32509143ccc0
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_cda7310014a046d2bed29352f5a1a5de_end
  end_if_2a18c7d846e940498d9a32509143ccc0: ; END of if_f7880e4e769a4c2abeb67d2bf972dbd8
  end_if_9e5b727485384e338abe03194f831bbd: ; END of if_fe769ea212ef4a2bafb0a95f74ec519e
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_57b61d8b5d054904bfa110abee70ca5f ; Reevaluate WHILE condition
  end_while_b00020b156eb4aeeb13ca4f425449e7b: ; END of while_57b61d8b5d054904bfa110abee70ca5f
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_cda7310014a046d2bed29352f5a1a5de_end
  func_446961674C6F6F6B7570_cda7310014a046d2bed29352f5a1a5de_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_488959461fd8420b976d3f04e18a36c9_end:
section .text
global ubytec_host_contract_Fold
ubytec_host_contract_Fold:
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
call func_446961675265636F726473_f7e28cdc7470475b8d9d6e7757b99f32_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,70,111,108,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,70,111,108,100,124,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
