module_74797065645F6D656D6F7279_722416284e23486986031f4c36adb152_start:
; Module: typed_memory v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:17:18Z
  ; Module UUID: 72241628-4e23-4869-8603-1f4c36adb152


  section .bss

  section .text

  func_66745F6D656D637079_c9e5ac149533472f91728a656a75d233_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_bcda2aef44ea41719d15ec42a1792962: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_484c5edf36384c028bed5ebcec6c305a
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
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
    mov byte [rax], cl
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_bcda2aef44ea41719d15ec42a1792962 ; Reevaluate WHILE condition
  end_while_484c5edf36384c028bed5ebcec6c305a: ; END of while_bcda2aef44ea41719d15ec42a1792962
  mov rax, qword [rbp + 32]
  mov qword [rsp - 8], rax
    
    jmp func_66745F6D656D637079_c9e5ac149533472f91728a656a75d233_end
  func_66745F6D656D637079_c9e5ac149533472f91728a656a75d233_end:
    mov rsp, rbp
    pop rbp
    ret
  func_436F7079_ebe32f4e7e58408b9ce9ba7581e64b80_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_66745F6D656D637079_c9e5ac149533472f91728a656a75d233_start
    add rsp, 24
    push rax
  add rsp, 8
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_436F7079_ebe32f4e7e58408b9ce9ba7581e64b80_end
  func_436F7079_ebe32f4e7e58408b9ce9ba7581e64b80_end:
    mov rsp, rbp
    pop rbp
    ret
  func_536F757263655772697465_e5df39e8b90544cf8c8581ce32d380b7_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x00000000000000FF
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_536F757263655772697465_e5df39e8b90544cf8c8581ce32d380b7_end
  func_536F757263655772697465_e5df39e8b90544cf8c8581ce32d380b7_end:
    mov rsp, rbp
    pop rbp
    ret
  func_457363617065_e6ea654de7e04ecabd6eefbe214e79ce_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000010000
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x00000000000000FF
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_457363617065_e6ea654de7e04ecabd6eefbe214e79ce_end
  func_457363617065_e6ea654de7e04ecabd6eefbe214e79ce_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C_333df4141ccc400db64c8516382f433d_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x00000000000000FF
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x00000000000000FF
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_5061727469616C_333df4141ccc400db64c8516382f433d_end
  func_5061727469616C_333df4141ccc400db64c8516382f433d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_53756D56616C756573_0b06443f536e4f1d832f8b300e656952_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    
    jmp func_53756D56616C756573_0b06443f536e4f1d832f8b300e656952_end
  func_53756D56616C756573_0b06443f536e4f1d832f8b300e656952_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_78a0b1e937294740b03ae12e01ef7e2b_start:
  push rbp
    mov rbp, rsp
  loop_9c02e49095e44710a312a7ff858cfaeb: ; LOOP start
    jmp loop_9c02e49095e44710a312a7ff858cfaeb ; LOOP: continue iteration
  end_loop_dadff8f613994684b788ab9bbe89513e: ; END of loop_9c02e49095e44710a312a7ff858cfaeb
  func_5370696E_78a0b1e937294740b03ae12e01ef7e2b_end:
    mov rsp, rbp
    pop rbp
    ret
module_74797065645F6D656D6F7279_722416284e23486986031f4c36adb152_end:
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
push rdi
push rsi
push rdx
call func_436F7079_ebe32f4e7e58408b9ce9ba7581e64b80_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_SourceWrite
ubytec_host_contract_SourceWrite:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
push rsi
push rdx
call func_536F757263655772697465_e5df39e8b90544cf8c8581ce32d380b7_start
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
push rdi
push rsi
push rdx
call func_457363617065_e6ea654de7e04ecabd6eefbe214e79ce_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Partial
ubytec_host_contract_Partial:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
push rsi
push rdx
call func_5061727469616C_333df4141ccc400db64c8516382f433d_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_SumValues
ubytec_host_contract_SumValues:
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
call func_53756D56616C756573_0b06443f536e4f1d832f8b300e656952_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Spin
ubytec_host_contract_Spin:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
call func_5370696E_78a0b1e937294740b03ae12e01ef7e2b_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,67,111,112,121,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,67,111,112,121,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,83,111,117,114,99,101,87,114,105,116,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,111,117,114,99,101,87,114,105,116,101,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,69,115,99,97,112,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,69,115,99,97,112,101,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,80,97,114,116,105,97,108,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,80,97,114,116,105,97,108,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,83,117,109,86,97,108,117,101,115,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,117,109,86,97,108,117,101,115,124,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,83,112,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,112,105,110,124,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
