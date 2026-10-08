module_636861696E5F67726F75706564_402614a7e00643ba94037e260f99efa1_start:
; Module: chain_grouped v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 01:27:45Z
  ; Module UUID: 402614a7-e006-43ba-9403-7e260f99efa1


  section .bss

  section .text

  func_66745F7374726C656E_926aea772fbc4bc8a3be3b24a1464298_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  loop_b5482144efbd4a3ba87a8724102dde2f: ; LOOP start
  mov rax, qword [rbp + 16]
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
  if_90d763a43f75412aab49c6fb2b15fd1a: ; IF start
  pop rax
    test rax, rax
    je end_if_90febb4957ef4605a0560dc08388cad3
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp end_else_b95ab0408918423e9503d4dbc0c8b648     ; Jump over ELSE part
  end_if_90febb4957ef4605a0560dc08388cad3:    ; if_90d763a43f75412aab49c6fb2b15fd1a END
  else_9a59897a67c347619fda2b06d3c7c752:  ; Start ELSE block
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    jmp func_66745F7374726C656E_926aea772fbc4bc8a3be3b24a1464298_end
  end_else_b95ab0408918423e9503d4dbc0c8b648: ; END of else_9a59897a67c347619fda2b06d3c7c752
  
    jmp loop_b5482144efbd4a3ba87a8724102dde2f ; LOOP: continue iteration
  end_loop_989bace47b464dc296fc81aa47720c05: ; END of loop_b5482144efbd4a3ba87a8724102dde2f
  
  func_66745F7374726C656E_926aea772fbc4bc8a3be3b24a1464298_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F6D656D637079_f832d6bbf9934f2bbf5128fe149e78f2_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_d2c2360d9a944c469237c5d9fb96e89b: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_66956d55870348f0ad850a1e617e3179
  
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
    jmp while_d2c2360d9a944c469237c5d9fb96e89b ; Reevaluate WHILE condition
  end_while_66956d55870348f0ad850a1e617e3179: ; END of while_d2c2360d9a944c469237c5d9fb96e89b
  
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    
    jmp func_66745F6D656D637079_f832d6bbf9934f2bbf5128fe149e78f2_end
  func_66745F6D656D637079_f832d6bbf9934f2bbf5128fe149e78f2_end:
    mov rsp, rbp
    pop rbp
    ret
  func_436F7079_b6c033c848dd48ccbad7f4c9c9ab918b_start:
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
  if_35df67f4d0534213812b08edcf5e6bdd: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_508898239741491299c78243f745e23b
  
  mov rax, 0xFFFFFFFFFFFFFFFF
    push rax
  pop rax
    
    jmp func_436F7079_b6c033c848dd48ccbad7f4c9c9ab918b_end
  end_if_508898239741491299c78243f745e23b: ; END of if_35df67f4d0534213812b08edcf5e6bdd
  
  if_324501db90d44fca9e90f9dfd8033751: ; IF start
  mov rcx, 32752
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_3b37beb8f07c4c11a7d51011528e1762
  
  mov rax, 0xFFFFFFFFFFFFFFFF
    push rax
  pop rax
    
    jmp func_436F7079_b6c033c848dd48ccbad7f4c9c9ab918b_end
  end_if_3b37beb8f07c4c11a7d51011528e1762: ; END of if_324501db90d44fca9e90f9dfd8033751
  
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
  if_bbf1e6ed870d466ea4e405b0df17b7db: ; IF start
  pop rax
    test rax, rax
    je end_if_92bcaa340fbf48b0914070735e00a142
  
    jmp end_else_4e24a5f816104b5aaa8a7624547094f6     ; Jump over ELSE part
  end_if_92bcaa340fbf48b0914070735e00a142:    ; if_bbf1e6ed870d466ea4e405b0df17b7db END
  else_a279bd37014145af8544fb126986cd3d:  ; Start ELSE block
  mov rax, 0xFFFFFFFFFFFFFFFF
    push rax
  pop rax
    
    jmp func_436F7079_b6c033c848dd48ccbad7f4c9c9ab918b_end
  end_else_4e24a5f816104b5aaa8a7624547094f6: ; END of else_a279bd37014145af8544fb126986cd3d
  
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
  if_439c8d14d2d5477bbcb1aba92980b1d0: ; IF start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jbe end_if_025bf219240245d19638f81a07d5671d
  
  mov rax, 0xFFFFFFFFFFFFFFFF
    push rax
  pop rax
    
    jmp func_436F7079_b6c033c848dd48ccbad7f4c9c9ab918b_end
  end_if_025bf219240245d19638f81a07d5671d: ; END of if_439c8d14d2d5477bbcb1aba92980b1d0
  
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
  call func_66745F6D656D637079_f832d6bbf9934f2bbf5128fe149e78f2_start
    add rsp, 24
    push rax
  add rsp, 8
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    dec rax
    push rax
  pop rax
    
    jmp func_436F7079_b6c033c848dd48ccbad7f4c9c9ab918b_end
  func_436F7079_b6c033c848dd48ccbad7f4c9c9ab918b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_506970656C696E65_446ac3ad3c1645deadeec1b63f3ff97a_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  call func_66745F7374726C656E_926aea772fbc4bc8a3be3b24a1464298_start
    add rsp, 8
    push rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000008
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    pop rcx
    push rax
    push rcx
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_436F7079_b6c033c848dd48ccbad7f4c9c9ab918b_start
    add rsp, 32
    push rax
  pop rax
    
    jmp func_506970656C696E65_446ac3ad3c1645deadeec1b63f3ff97a_end
  func_506970656C696E65_446ac3ad3c1645deadeec1b63f3ff97a_end:
    mov rsp, rbp
    pop rbp
    ret
module_636861696E5F67726F75706564_402614a7e00643ba94037e260f99efa1_end:
section .text
global ubytec_host_contract_Pipeline
ubytec_host_contract_Pipeline:
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
call func_506970656C696E65_446ac3ad3c1645deadeec1b63f3ff97a_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,80,105,112,101,108,105,110,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,80,105,112,101,108,105,110,101,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
