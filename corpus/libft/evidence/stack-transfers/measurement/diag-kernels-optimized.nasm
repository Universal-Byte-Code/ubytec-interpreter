module_646961676E6F737469635F6B65726E656C73_5cdb4b8ffb06496b99e83ff5eb422d0a_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 21:32:18Z
  ; Module UUID: 5cdb4b8f-fb06-496b-99e8-3ff5eb422d0a


  section .bss

  section .text

  func_446961674964656E74697479_a31397ecb14b4878973443f0cf2e4769_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_a31397ecb14b4878973443f0cf2e4769_end
  func_446961674964656E74697479_a31397ecb14b4878973443f0cf2e4769_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_9f8bd02e2ab04d0fa283bdb908d99946_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_30825f92b6d9429a89d91ee93aec440a: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_36d36df5ed4540e39f269215055b0dcb
  
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
    jmp while_30825f92b6d9429a89d91ee93aec440a ; Reevaluate WHILE condition
  end_while_36d36df5ed4540e39f269215055b0dcb: ; END of while_30825f92b6d9429a89d91ee93aec440a
  
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674279746573_9f8bd02e2ab04d0fa283bdb908d99946_end
  func_446961674279746573_9f8bd02e2ab04d0fa283bdb908d99946_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_fa733dd8a3a84fed9cf116cdcf99f3cb_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_f15c54213b0344f08f4a07b8934a5400: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_762dc7d8f63d482cb6b1d37d5fbe83b5
  
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
    jmp while_f15c54213b0344f08f4a07b8934a5400 ; Reevaluate WHILE condition
  end_while_762dc7d8f63d482cb6b1d37d5fbe83b5: ; END of while_f15c54213b0344f08f4a07b8934a5400
  
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961675265636F726473_fa733dd8a3a84fed9cf116cdcf99f3cb_end
  func_446961675265636F726473_fa733dd8a3a84fed9cf116cdcf99f3cb_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_ebb0618c77f949608734f935d29f3dc8_start:
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
  while_3f7ffc8e9cfc48c3b8bffd916339701e: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_62bb15c22cbb4979b80eb5b9996875f3
  
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
  if_2df5dff0721246309f1c92da2a8895ac: ; IF start
  pop rax
    test rax, rax
    je end_if_defdb378528d48899f24a946ec9c4d39
  
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
  while_75646a8a484b42bd9783b35309882817: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_27abeb6574b74e34a60a0fb55dfc357d
  
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
  if_4aaf541c1767493ebfca73ecd964986f: ; IF start
  pop rax
    test rax, rax
    je end_if_5f7a4556577d4c7a9db8eb3948b386ab
  
  jmp end_while_27abeb6574b74e34a60a0fb55dfc357d ; BREAK
  end_if_5f7a4556577d4c7a9db8eb3948b386ab: ; END of if_4aaf541c1767493ebfca73ecd964986f
  
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    jmp while_75646a8a484b42bd9783b35309882817 ; Reevaluate WHILE condition
  end_while_27abeb6574b74e34a60a0fb55dfc357d: ; END of while_75646a8a484b42bd9783b35309882817
  
  if_21d555edf90849e7a5d7163bd9176865: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_4e513f68699247b79535f75b2784fef8
  
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_ebb0618c77f949608734f935d29f3dc8_end
  end_if_4e513f68699247b79535f75b2784fef8: ; END of if_21d555edf90849e7a5d7163bd9176865
  
  end_if_defdb378528d48899f24a946ec9c4d39: ; END of if_2df5dff0721246309f1c92da2a8895ac
  
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_3f7ffc8e9cfc48c3b8bffd916339701e ; Reevaluate WHILE condition
  end_while_62bb15c22cbb4979b80eb5b9996875f3: ; END of while_3f7ffc8e9cfc48c3b8bffd916339701e
  
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_ebb0618c77f949608734f935d29f3dc8_end
  func_446961674C6F6F6B7570_ebb0618c77f949608734f935d29f3dc8_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_5cdb4b8ffb06496b99e83ff5eb422d0a_end:
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
call func_446961674964656E74697479_a31397ecb14b4878973443f0cf2e4769_start
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
call func_446961674279746573_9f8bd02e2ab04d0fa283bdb908d99946_start
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
call func_446961675265636F726473_fa733dd8a3a84fed9cf116cdcf99f3cb_start
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
call func_446961674C6F6F6B7570_ebb0618c77f949608734f935d29f3dc8_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
