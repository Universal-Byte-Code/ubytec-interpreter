module_696E646570656E64656E745F6661756C7473_20687f10640d47d7ac29518639670880_start:
; Module: independent_faults v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-04 23:59:01Z
  ; Module UUID: 20687f10-640d-47d7-ac29-518639670880


  section .bss

  section .text

  func_526561644F6E6C795772697465_1cde4d53f31f4b1292f1545f51d66ee7_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_291600a1c00549d38afd17124268058c: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_f4cbfa99863a408dbde88e06049a5d85
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x000000000000005A
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
    jmp while_291600a1c00549d38afd17124268058c ; Reevaluate WHILE condition
  end_while_f4cbfa99863a408dbde88e06049a5d85: ; END of while_291600a1c00549d38afd17124268058c
  
  mov rax, 0x0000000100000001
    push rax
  pop rax
    
    jmp func_526561644F6E6C795772697465_1cde4d53f31f4b1292f1545f51d66ee7_end
  func_526561644F6E6C795772697465_1cde4d53f31f4b1292f1545f51d66ee7_end:
    mov rsp, rbp
    pop rbp
    ret
  func_466F726569676E_f71a5f689bf741d3b1ebb22efdebe1c4_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rax
    
    jmp func_466F726569676E_f71a5f689bf741d3b1ebb22efdebe1c4_end
  func_466F726569676E_f71a5f689bf741d3b1ebb22efdebe1c4_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4D6F6E69746F72_d849075c067c4d2f81e1d33f649175f8_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4D6F6E69746F72_d849075c067c4d2f81e1d33f649175f8_end
  func_4D6F6E69746F72_d849075c067c4d2f81e1d33f649175f8_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4E65696768626F72_c089f1a846b544ad946b5d94e1ea6823_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000000FFF
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000001000
    push rax
  pop rcx
    pop rax
    cqo
    idiv rcx
    push rax
  mov rax, 0x0000000000001000
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4E65696768626F72_c089f1a846b544ad946b5d94e1ea6823_end
  func_4E65696768626F72_c089f1a846b544ad946b5d94e1ea6823_end:
    mov rsp, rbp
    pop rbp
    ret
  func_537461636B4F766572666C6F77_aaa2fee1ab1a40b4abc2eadd3456ef8d_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_537461636B4F766572666C6F77_aaa2fee1ab1a40b4abc2eadd3456ef8d_start
    add rsp, 32
    push rax
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_537461636B4F766572666C6F77_aaa2fee1ab1a40b4abc2eadd3456ef8d_end
  func_537461636B4F766572666C6F77_aaa2fee1ab1a40b4abc2eadd3456ef8d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_cb82be6e5a794057bd02ed82beed6e22_start:
  push rbp
    mov rbp, rsp
  loop_33fed90338dd437bb9c9c5b9e5cc940f: ; LOOP start
    jmp loop_33fed90338dd437bb9c9c5b9e5cc940f ; LOOP: continue iteration
  end_loop_2f70797260774181b70337c67c07b6be: ; END of loop_33fed90338dd437bb9c9c5b9e5cc940f
  
  func_5370696E_cb82be6e5a794057bd02ed82beed6e22_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5374616C65_c1e47aa5c75a4a29be035de87dc943a8_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rax
    
    jmp func_5374616C65_c1e47aa5c75a4a29be035de87dc943a8_end
  func_5374616C65_c1e47aa5c75a4a29be035de87dc943a8_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C4661696C757265_69ef4572b38c4ca2ba171461c57b5518_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x000000000000005A
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 24]
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rax
    
    jmp func_5061727469616C4661696C757265_69ef4572b38c4ca2ba171461c57b5518_end
  func_5061727469616C4661696C757265_69ef4572b38c4ca2ba171461c57b5518_end:
    mov rsp, rbp
    pop rbp
    ret
module_696E646570656E64656E745F6661756C7473_20687f10640d47d7ac29518639670880_end:
section .text
global ubytec_host_read_only_write
ubytec_host_read_only_write:
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
call func_526561644F6E6C795772697465_1cde4d53f31f4b1292f1545f51d66ee7_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_foreign
ubytec_host_foreign:
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
call func_466F726569676E_f71a5f689bf741d3b1ebb22efdebe1c4_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_monitor
ubytec_host_monitor:
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
call func_4D6F6E69746F72_d849075c067c4d2f81e1d33f649175f8_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_neighbor
ubytec_host_neighbor:
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
call func_4E65696768626F72_c089f1a846b544ad946b5d94e1ea6823_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_stack_overflow
ubytec_host_stack_overflow:
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
call func_537461636B4F766572666C6F77_aaa2fee1ab1a40b4abc2eadd3456ef8d_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_loop
ubytec_host_loop:
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
call func_5370696E_cb82be6e5a794057bd02ed82beed6e22_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_stale
ubytec_host_stale:
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
call func_5374616C65_c1e47aa5c75a4a29be035de87dc943a8_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_partial
ubytec_host_partial:
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
call func_5061727469616C4661696C757265_69ef4572b38c4ca2ba171461c57b5518_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
