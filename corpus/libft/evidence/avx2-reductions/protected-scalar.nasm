module_646961676E6F737469635F6B65726E656C73_666c355f7da148f88fb4613fd487a9ab_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:17:23Z
  ; Module UUID: 666c355f-7da1-48f8-8fb4-613fd487a9ab


  section .bss

  section .text

  func_446961674964656E74697479_888f633cbcb74a508e9dd0863afac86f_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_446961674964656E74697479_888f633cbcb74a508e9dd0863afac86f_end
  func_446961674964656E74697479_888f633cbcb74a508e9dd0863afac86f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_6c79ce0af25546dcadf9e12a93f2c979_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; loop-reductions: scalar bytes, observable stack retained
  mov rdx, qword [rbp + 24]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  func_446961674279746573_6c79ce0af25546dcadf9e12a93f2c979_start_byte_reduce:
  cmp r8, r10
    jae func_446961674279746573_6c79ce0af25546dcadf9e12a93f2c979_start_byte_reduce_done
  mov qword [rsp - 8], r9
  mov qword [rsp - 24], r8
  mov rcx, r8
    mov rax, rdx
    add rax, rcx
  mov qword [rsp - 16], rax
    lea rsp, [rsp - 8]
  movzx eax, byte [rax]
  mov qword [rsp - 8], rax
    add r9, rax
  mov qword [rbp - 16], r9
  inc r8
  mov qword [rbp - 8], r8
  lea rsp, [rsp + 8]
    mov qword [rsp - 8], r8
    jmp func_446961674279746573_6c79ce0af25546dcadf9e12a93f2c979_start_byte_reduce
  func_446961674279746573_6c79ce0af25546dcadf9e12a93f2c979_start_byte_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961674279746573_6c79ce0af25546dcadf9e12a93f2c979_end
  func_446961674279746573_6c79ce0af25546dcadf9e12a93f2c979_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_611029790bd34f0dbe36e8b9fc464739_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_9b7cf769a9194735bc809dab985dfd35: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_de3938c446a143a3ae2c7a3fa1133fc0
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_9b7cf769a9194735bc809dab985dfd35 ; Reevaluate WHILE condition
  end_while_de3938c446a143a3ae2c7a3fa1133fc0: ; END of while_9b7cf769a9194735bc809dab985dfd35
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_446961675265636F726473_611029790bd34f0dbe36e8b9fc464739_end
  func_446961675265636F726473_611029790bd34f0dbe36e8b9fc464739_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_afb028eabc6f41baa75eb17af60a9240_start:
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
  while_baf5bf0fafcd41b7a42e5f2eda100775: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_a2acacd6c8ba488495b638a1b92848ff
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, 0x0000000000000008
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    push rax
  if_3b4726130e78461ab0731ea8fddd0f26: ; IF start
  pop rax
    test rax, rax
    je end_if_2c0814d04ec5419da1a10fa29e8e03a7
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  while_813c199da9b647f19929e0c72939b4a0: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_6d69f87d6d2c4dcc845c39a812df6389
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 16]
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
    cmp rax, rcx
    setne al
    movzx eax, al
    push rax
  if_ea76934954a54d66bd2d81ecffa7ea2a: ; IF start
  pop rax
    test rax, rax
    je end_if_8e35f7ad2d3642b0bc4a89b3150d46c0
  jmp end_while_6d69f87d6d2c4dcc845c39a812df6389 ; BREAK
  end_if_8e35f7ad2d3642b0bc4a89b3150d46c0: ; END of if_ea76934954a54d66bd2d81ecffa7ea2a
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_813c199da9b647f19929e0c72939b4a0 ; Reevaluate WHILE condition
  end_while_6d69f87d6d2c4dcc845c39a812df6389: ; END of while_813c199da9b647f19929e0c72939b4a0
  if_44683d9e46274032a53c38c203d5f727: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_c835bfcb5f5b48ee81fb9ac152976940
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_afb028eabc6f41baa75eb17af60a9240_end
  end_if_c835bfcb5f5b48ee81fb9ac152976940: ; END of if_44683d9e46274032a53c38c203d5f727
  end_if_2c0814d04ec5419da1a10fa29e8e03a7: ; END of if_3b4726130e78461ab0731ea8fddd0f26
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_baf5bf0fafcd41b7a42e5f2eda100775 ; Reevaluate WHILE condition
  end_while_a2acacd6c8ba488495b638a1b92848ff: ; END of while_baf5bf0fafcd41b7a42e5f2eda100775
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_446961674C6F6F6B7570_afb028eabc6f41baa75eb17af60a9240_end
  func_446961674C6F6F6B7570_afb028eabc6f41baa75eb17af60a9240_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_666c355f7da148f88fb4613fd487a9ab_end:
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
call func_446961674279746573_6c79ce0af25546dcadf9e12a93f2c979_start
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
