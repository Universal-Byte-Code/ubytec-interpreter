module_636861696E5F6D656D6F7279_45b4eadc9a414105aaa28871f6e02784_start:
; Module: chain_memory v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 01:27:44Z
  ; Module UUID: 45b4eadc-9a41-4105-aaa2-8871f6e02784


  section .bss

  section .text

  func_66745F6D656D637079_9992fe5318a6463e8b9b74ae4e89d4ac_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_5ff49d0f6c8e4fd28d4f38a34689448f: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_5fcd8c0caf8f49e7bb8c7afc2cba8b24
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 8]
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
    mov byte [rax], cl
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_5ff49d0f6c8e4fd28d4f38a34689448f ; Reevaluate WHILE condition
  end_while_5fcd8c0caf8f49e7bb8c7afc2cba8b24: ; END of while_5ff49d0f6c8e4fd28d4f38a34689448f
  
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    
    jmp func_66745F6D656D637079_9992fe5318a6463e8b9b74ae4e89d4ac_end
  func_66745F6D656D637079_9992fe5318a6463e8b9b74ae4e89d4ac_end:
    mov rsp, rbp
    pop rbp
    ret
  func_436F7079_c386d375e2ca44078d57ad2052fffbbd_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, qword [rbp + 40]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_32a006698e2b4626a91c2694fc385eb7: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_447f7ec00d86498b88608b4a04714e06
  
  mov rax, 0xFFFFFFFFFFFFFFFF
    push rax
  pop rax
    
    jmp func_436F7079_c386d375e2ca44078d57ad2052fffbbd_end
  end_if_447f7ec00d86498b88608b4a04714e06: ; END of if_32a006698e2b4626a91c2694fc385eb7
  
  if_5f2d15c5b8d748008ebecc16b56cbe02: ; IF start
  mov rcx, 32752
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_347446eb955f4a08912c8e8c696ae376
  
  mov rax, 0xFFFFFFFFFFFFFFFF
    push rax
  pop rax
    
    jmp func_436F7079_c386d375e2ca44078d57ad2052fffbbd_end
  end_if_347446eb955f4a08912c8e8c696ae376: ; END of if_5f2d15c5b8d748008ebecc16b56cbe02
  
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000000002
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 32]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setle al
    movzx eax, al
    push rax
  if_97587ee0f7d841bbab576760a88cc9b0: ; IF start
  pop rax
    test rax, rax
    je end_if_6047302f4fb24ecb858b461cab1f0e23
  
    jmp end_else_1d6002fc1cb74611ad3b983263566a22     ; Jump over ELSE part
  end_if_6047302f4fb24ecb858b461cab1f0e23:    ; if_97587ee0f7d841bbab576760a88cc9b0 END
  else_3aa5cce97a50487aaad52ef9ab1485a5:  ; Start ELSE block
  mov rax, 0xFFFFFFFFFFFFFFFF
    push rax
  pop rax
    
    jmp func_436F7079_c386d375e2ca44078d57ad2052fffbbd_end
  end_else_1d6002fc1cb74611ad3b983263566a22: ; END of else_3aa5cce97a50487aaad52ef9ab1485a5
  
  mov rax, qword [rbp + 40]
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
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  if_f37a221e59ac4b879eb760a5286eb54d: ; IF start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jbe end_if_8bacd181304942539dfcf3073ea9ba3e
  
  mov rax, 0xFFFFFFFFFFFFFFFF
    push rax
  pop rax
    
    jmp func_436F7079_c386d375e2ca44078d57ad2052fffbbd_end
  end_if_8bacd181304942539dfcf3073ea9ba3e: ; END of if_f37a221e59ac4b879eb760a5286eb54d
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 16]
    push rax
  call func_66745F6D656D637079_9992fe5318a6463e8b9b74ae4e89d4ac_start
    add rsp, 24
    push rax
  add rsp, 8
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    dec rax
    push rax
  pop rax
    
    jmp func_436F7079_c386d375e2ca44078d57ad2052fffbbd_end
  func_436F7079_c386d375e2ca44078d57ad2052fffbbd_end:
    mov rsp, rbp
    pop rbp
    ret
  func_457363617065_3d7cd939a552437cbe26631295dc883f_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000010000
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rax
    
    jmp func_457363617065_3d7cd939a552437cbe26631295dc883f_end
  func_457363617065_3d7cd939a552437cbe26631295dc883f_end:
    mov rsp, rbp
    pop rbp
    ret
module_636861696E5F6D656D6F7279_45b4eadc9a414105aaa28871f6e02784_end:
section .text
global ubytec_host_contract_Copy
ubytec_host_contract_Copy:
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
call func_436F7079_c386d375e2ca44078d57ad2052fffbbd_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Escape
ubytec_host_contract_Escape:
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
call func_457363617065_3d7cd939a552437cbe26631295dc883f_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,67,111,112,121,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,67,111,112,121,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,69,115,99,97,112,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,69,115,99,97,112,101,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
