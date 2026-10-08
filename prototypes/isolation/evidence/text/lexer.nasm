module_746578745F6C65786572_5fda0a3195d147c1b612aa0e9129b3cc_start:
; Module: text_lexer v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 09:01:23Z
  ; Module UUID: 5fda0a31-95d1-47c1-b612-aa0e9129b3cc


  section .bss

  section .text

  func_66745F69737370616365_b0eac7ea2975405aa7763eb094270404_start:
  push rbp
    mov rbp, rsp
  if_dbd6fef8c34140b4afdf93c398cf2f37: ; IF start
  mov rcx, 32
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jne end_if_5eb7ce800ebc4b97adc028653427d9fd
  
  mov rax, 0x0000000000000001
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_b0eac7ea2975405aa7763eb094270404_end
  end_if_5eb7ce800ebc4b97adc028653427d9fd: ; END of if_dbd6fef8c34140b4afdf93c398cf2f37
  
  if_c936241a5a164da09f4accbdc3106fa5: ; IF start
  mov rcx, 9
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jge end_if_18a96b65db2949f9a88cbab72a4254a3
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_b0eac7ea2975405aa7763eb094270404_end
  end_if_18a96b65db2949f9a88cbab72a4254a3: ; END of if_c936241a5a164da09f4accbdc3106fa5
  
  if_8c8240d34d6a466c8a5e67ffd6073fe1: ; IF start
  mov rcx, 13
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jle end_if_2025412853724f34bbb6338cfae52661
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_b0eac7ea2975405aa7763eb094270404_end
  end_if_2025412853724f34bbb6338cfae52661: ; END of if_8c8240d34d6a466c8a5e67ffd6073fe1
  
  mov rax, 0x0000000000000001
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_b0eac7ea2975405aa7763eb094270404_end
  func_66745F69737370616365_b0eac7ea2975405aa7763eb094270404_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5363616E4669656C6473_b3976b84d49c45dd8357d74ab2106609_start:
  push rbp
    mov rbp, rsp
  sub rsp, 48
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 40], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 48], rax
  loop_371f4406a7a245caa34418fbb6658bcf: ; LOOP start
  if_e69f10a03dbd45f4b35157a359aac167: ; IF start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jb end_if_16335b06bafb444981aec956d2d4b5c9
  
  jmp end_loop_5c24ae8e49ce4d7bbf04df62a880a7d3 ; BREAK
  end_if_16335b06bafb444981aec956d2d4b5c9: ; END of if_e69f10a03dbd45f4b35157a359aac167
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  while_efbcb2b94f974ef98d9835ce16741047: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_16b43c6502304e8283d13388e8bdf249
  
  mov rax, qword [rbp + 40]
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
  pop rax
    movsxd rax, eax
    mov qword [rbp - 40], rax
  if_9f8754d1fdfa4b9b85feb5d683fec63a: ; IF start
  mov rcx, 44
    movsxd rax, dword [rbp - 40]
    cmp rax, rcx
    jne end_if_d1c91308518449abb73db89813ebd193
  
  jmp end_while_16b43c6502304e8283d13388e8bdf249 ; BREAK
  end_if_d1c91308518449abb73db89813ebd193: ; END of if_9f8754d1fdfa4b9b85feb5d683fec63a
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_efbcb2b94f974ef98d9835ce16741047 ; Reevaluate WHILE condition
  end_while_16b43c6502304e8283d13388e8bdf249: ; END of while_efbcb2b94f974ef98d9835ce16741047
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  while_f1af9d62fa3a4ffe8bdf646e90b8dfca: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_bca9f4460f774b408a253434126ee83c
  
  mov rax, qword [rbp + 40]
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
  call func_66745F69737370616365_b0eac7ea2975405aa7763eb094270404_start
    add rsp, 8
    push rax
  pop rax
    movsxd rax, eax
    mov qword [rbp - 48], rax
  if_ee38d6063826407d8c16f720bb4f3544: ; IF start
  mov rcx, 0
    movsxd rax, dword [rbp - 48]
    cmp rax, rcx
    jne end_if_f2e2749083c04fcba619cf959d53524c
  
  jmp end_while_bca9f4460f774b408a253434126ee83c ; BREAK
  end_if_f2e2749083c04fcba619cf959d53524c: ; END of if_ee38d6063826407d8c16f720bb4f3544
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_f1af9d62fa3a4ffe8bdf646e90b8dfca ; Reevaluate WHILE condition
  end_while_bca9f4460f774b408a253434126ee83c: ; END of while_f1af9d62fa3a4ffe8bdf646e90b8dfca
  
  while_134b6832a8004d628b0daf49366039c7: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_0cee3832e83c4b06835184c296e19483
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  call func_66745F69737370616365_b0eac7ea2975405aa7763eb094270404_start
    add rsp, 8
    push rax
  pop rax
    movsxd rax, eax
    mov qword [rbp - 48], rax
  if_d93ba4203eea4622a66b7506aa7428da: ; IF start
  mov rcx, 0
    movsxd rax, dword [rbp - 48]
    cmp rax, rcx
    jne end_if_85c57d12ffad4ab1874662a50e390000
  
  jmp end_while_0cee3832e83c4b06835184c296e19483 ; BREAK
  end_if_85c57d12ffad4ab1874662a50e390000: ; END of if_d93ba4203eea4622a66b7506aa7428da
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    dec rax
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp while_134b6832a8004d628b0daf49366039c7 ; Reevaluate WHILE condition
  end_while_0cee3832e83c4b06835184c296e19483: ; END of while_134b6832a8004d628b0daf49366039c7
  
  if_238c45b6e10d4f279b8a8066b58a6be7: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_if_b34cc20056f9431ab8d7fa4b9f954a1c
  
  if_022eacceaec4410d86789ecfb48bc293: ; IF start
  mov rax, qword [rbp + 24]
    mov rcx, rax
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jb end_if_7485e8fe24a1406da2f2f685f543fcd1
  
  mov rax, 0xFFFFFFFFFFFFFFF5
    push rax
  pop rax
    
    jmp func_5363616E4669656C6473_b3976b84d49c45dd8357d74ab2106609_end
  end_if_7485e8fe24a1406da2f2f685f543fcd1: ; END of if_022eacceaec4410d86789ecfb48bc293
  
  if_f5d415ee448244d6b94ab6142b8b84b5: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    je end_if_3a5dcd2dab274228bc03cdd5abfc1e8f
  
  mov rax, qword [rbp + 48]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp + 48]
    push rax
  mov rax, 0x0000000000000028
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  end_if_3a5dcd2dab274228bc03cdd5abfc1e8f: ; END of if_f5d415ee448244d6b94ab6142b8b84b5
  
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_if_b34cc20056f9431ab8d7fa4b9f954a1c: ; END of if_238c45b6e10d4f279b8a8066b58a6be7
  
    jmp loop_371f4406a7a245caa34418fbb6658bcf ; LOOP: continue iteration
  end_loop_5c24ae8e49ce4d7bbf04df62a880a7d3: ; END of loop_371f4406a7a245caa34418fbb6658bcf
  
  if_585e4b92bb38442795084a956b01870e: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    je end_if_f90f2dc7b592424ea3bdf099ffd1ca5f
  
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  end_if_f90f2dc7b592424ea3bdf099ffd1ca5f: ; END of if_585e4b92bb38442795084a956b01870e
  
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_5363616E4669656C6473_b3976b84d49c45dd8357d74ab2106609_end
  func_5363616E4669656C6473_b3976b84d49c45dd8357d74ab2106609_end:
    mov rsp, rbp
    pop rbp
    ret
  func_50617273654669656C6473_2e6d6102adaa4f1ea735dc07a48aba3f_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  mov rax, 0x0000000000000000
    push rax
  call func_5363616E4669656C6473_b3976b84d49c45dd8357d74ab2106609_start
    add rsp, 40
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_85445f931da443ddb3e44de455799ed2: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jge end_if_60bcd46433744eed89a5badaafa43736
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    jmp func_50617273654669656C6473_2e6d6102adaa4f1ea735dc07a48aba3f_end
  end_if_60bcd46433744eed89a5badaafa43736: ; END of if_85445f931da443ddb3e44de455799ed2
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  mov rax, 0x0000000000000001
    push rax
  call func_5363616E4669656C6473_b3976b84d49c45dd8357d74ab2106609_start
    add rsp, 40
    push rax
  pop rax
    
    jmp func_50617273654669656C6473_2e6d6102adaa4f1ea735dc07a48aba3f_end
  func_50617273654669656C6473_2e6d6102adaa4f1ea735dc07a48aba3f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_536F757263655772697465_c83045d884fe4afc8a43654d9a0e638b_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_536F757263655772697465_c83045d884fe4afc8a43654d9a0e638b_end
  func_536F757263655772697465_c83045d884fe4afc8a43654d9a0e638b_end:
    mov rsp, rbp
    pop rbp
    ret
module_746578745F6C65786572_5fda0a3195d147c1b612aa0e9129b3cc_end:
section .text
global ubytec_host_contract_ParseFields
ubytec_host_contract_ParseFields:
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
call func_50617273654669656C6473_2e6d6102adaa4f1ea735dc07a48aba3f_start
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
sub rsp, 8
push rdi
push rsi
call func_536F757263655772697465_c83045d884fe4afc8a43654d9a0e638b_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,80,97,114,115,101,70,105,101,108,100,115,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,80,97,114,115,101,70,105,101,108,100,115,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,83,111,117,114,99,101,87,114,105,116,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,111,117,114,99,101,87,114,105,116,101,124,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
