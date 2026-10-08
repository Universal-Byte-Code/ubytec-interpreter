module_646961676E6F737469635F6B65726E656C73_c76f83bbf53b4141b7340bf9ced5ad97_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 21:46:46Z
  ; Module UUID: c76f83bb-f53b-4141-b734-0bf9ced5ad97


  section .bss

  section .text

  func_446961674964656E74697479_58292c4df43c4ed681a4a8a86cc4c1ed_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_58292c4df43c4ed681a4a8a86cc4c1ed_end
  func_446961674964656E74697479_58292c4df43c4ed681a4a8a86cc4c1ed_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_2278d07c09784e22922e7391e53d4654_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_8cdb1b2dc66f45d0850ad731f2a2049b: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_36ce111b1c0a49e9b40b1bda4bc2f9cf
  
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
    jmp while_8cdb1b2dc66f45d0850ad731f2a2049b ; Reevaluate WHILE condition
  end_while_36ce111b1c0a49e9b40b1bda4bc2f9cf: ; END of while_8cdb1b2dc66f45d0850ad731f2a2049b
  
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674279746573_2278d07c09784e22922e7391e53d4654_end
  func_446961674279746573_2278d07c09784e22922e7391e53d4654_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_4e56ec86fe444df1a1ff26aa9ff7e9fc_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_0618117351db4030b804acc1fcba0030: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_ce9aaf7a07694d278cb63f8f95747e40
  
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
    jmp while_0618117351db4030b804acc1fcba0030 ; Reevaluate WHILE condition
  end_while_ce9aaf7a07694d278cb63f8f95747e40: ; END of while_0618117351db4030b804acc1fcba0030
  
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961675265636F726473_4e56ec86fe444df1a1ff26aa9ff7e9fc_end
  func_446961675265636F726473_4e56ec86fe444df1a1ff26aa9ff7e9fc_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_9254b31b58834827800afe9e61a905b1_start:
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
  while_c7dceab151d845d892bbe05c200f9cf7: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_6520a9db9d4b426386b4f8c362929290
  
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
  if_2f5ad581587540c686182932b60f9e58: ; IF start
  pop rax
    test rax, rax
    je end_if_19867f745c07405896f7d43781720610
  
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
  while_e59ebcf57b2247339100501e8ba198c0: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_00d5472a85d1400cb6c97d7481691ccc
  
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
  if_358c953e5f064492bd6a1e44f8a032b4: ; IF start
  pop rax
    test rax, rax
    je end_if_6f3b210eac6c4276927043ea4b28261a
  
  jmp end_while_00d5472a85d1400cb6c97d7481691ccc ; BREAK
  end_if_6f3b210eac6c4276927043ea4b28261a: ; END of if_358c953e5f064492bd6a1e44f8a032b4
  
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    jmp while_e59ebcf57b2247339100501e8ba198c0 ; Reevaluate WHILE condition
  end_while_00d5472a85d1400cb6c97d7481691ccc: ; END of while_e59ebcf57b2247339100501e8ba198c0
  
  if_0f1eace860b0478888214966826f783d: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_616bb2f66bc24f2f9021f82916b2fc01
  
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_9254b31b58834827800afe9e61a905b1_end
  end_if_616bb2f66bc24f2f9021f82916b2fc01: ; END of if_0f1eace860b0478888214966826f783d
  
  end_if_19867f745c07405896f7d43781720610: ; END of if_2f5ad581587540c686182932b60f9e58
  
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_c7dceab151d845d892bbe05c200f9cf7 ; Reevaluate WHILE condition
  end_while_6520a9db9d4b426386b4f8c362929290: ; END of while_c7dceab151d845d892bbe05c200f9cf7
  
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_9254b31b58834827800afe9e61a905b1_end
  func_446961674C6F6F6B7570_9254b31b58834827800afe9e61a905b1_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_c76f83bbf53b4141b7340bf9ced5ad97_end:
section .text
global ubytec_host_contract_DiagIdentity
ubytec_host_contract_DiagIdentity:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
call func_446961674964656E74697479_58292c4df43c4ed681a4a8a86cc4c1ed_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_contract_DiagBytes
ubytec_host_contract_DiagBytes:
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
call func_446961674279746573_2278d07c09784e22922e7391e53d4654_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_contract_DiagRecords
ubytec_host_contract_DiagRecords:
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
call func_446961675265636F726473_4e56ec86fe444df1a1ff26aa9ff7e9fc_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_contract_DiagLookup
ubytec_host_contract_DiagLookup:
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
call func_446961674C6F6F6B7570_9254b31b58834827800afe9e61a905b1_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
