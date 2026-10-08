module_746578745F777269746572_4a0165c8886d443d9a37ec1734575764_start:
; Module: text_writer v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 09:01:24Z
  ; Module UUID: 4a0165c8-886d-443d-9a37-ec1734575764


  section .bss

  section .text

  func_66745F6D656D637079_fc4d7e433d34496488073977b2cc4597_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_3e4b40d7c6b440b0a8d63268dbac0f02: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_df3dbade2f584676ade4a420a1c29d5c
  
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
    jmp while_3e4b40d7c6b440b0a8d63268dbac0f02 ; Reevaluate WHILE condition
  end_while_df3dbade2f584676ade4a420a1c29d5c: ; END of while_3e4b40d7c6b440b0a8d63268dbac0f02
  
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    
    jmp func_66745F6D656D637079_fc4d7e433d34496488073977b2cc4597_end
  func_66745F6D656D637079_fc4d7e433d34496488073977b2cc4597_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_start:
  push rbp
    mov rbp, rsp
  sub rsp, 96
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
  mov rax, 0x0000000000000000
    mov qword [rbp - 56], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 64], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 72], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 80], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 88], rax
  if_5faf4ce54d0b4471b6ec9e9be01f0c9c: ; IF start
  mov rcx, 32
    mov rax, qword [rbp + 24]
    cmp rax, rcx
    jae end_if_66af94e1218442c2819ddce958769fbf
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_66af94e1218442c2819ddce958769fbf: ; END of if_5faf4ce54d0b4471b6ec9e9be01f0c9c
  
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  mov rax, qword [rbp + 32]
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
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp + 32]
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
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_9b8cfe0d28574fb9a6f6c5765eb62fe1: ; IF start
  mov rcx, 256
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jbe end_if_b3a113f5c76842078cad89bd5d3daf4c
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_b3a113f5c76842078cad89bd5d3daf4c: ; END of if_9b8cfe0d28574fb9a6f6c5765eb62fe1
  
  if_a2c1d76ba11e4489ae1953f4c4ee064f: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_19423a38a6534feca8f5aba3eb505698
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_19423a38a6534feca8f5aba3eb505698: ; END of if_a2c1d76ba11e4489ae1953f4c4ee064f
  
  if_5e65e6233e6d47e2b9c9687e0d1a9018: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jbe end_if_3a6a084db1094040bc5fe1116dcde4f2
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_3a6a084db1094040bc5fe1116dcde4f2: ; END of if_5e65e6233e6d47e2b9c9687e0d1a9018
  
  if_c5ce51c0ec0a49b6adede9d63d893744: ; IF start
  mov rax, qword [rbp - 32]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jbe end_if_611587321a9a4af3aeb47776411bc879
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_611587321a9a4af3aeb47776411bc879: ; END of if_c5ce51c0ec0a49b6adede9d63d893744
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, 0x0000000000000010
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
  pop rax
    
    mov qword [rbp - 40], rax
  if_4f5f4cb22bc74c54b4e57f120afdffa9: ; IF start
  mov rax, qword [rbp + 24]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jbe end_if_4e0f1abfd48e46b9aaf89b962658550e
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_4e0f1abfd48e46b9aaf89b962658550e: ; END of if_4f5f4cb22bc74c54b4e57f120afdffa9
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 40]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  if_a29b8b85a2da4c5e9368af76460dc26b: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jbe end_if_7519ce31aef14078a15b84450291bc74
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_7519ce31aef14078a15b84450291bc74: ; END of if_a29b8b85a2da4c5e9368af76460dc26b
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 40]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  if_37a9a220600d47ec921323da94c610a1: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_79f28536fc774dca8b2e6d6f90e6dcdd
  
  mov rax, 0xFFFFFFFFFFFFFFF4
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_79f28536fc774dca8b2e6d6f90e6dcdd: ; END of if_37a9a220600d47ec921323da94c610a1
  
  if_360bf34fe8c14f10b3eb01e8d3448c54: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_195527287904414f8b7d22402adda181
  
  mov rax, 0xFFFFFFFFFFFFFFF4
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_195527287904414f8b7d22402adda181: ; END of if_360bf34fe8c14f10b3eb01e8d3448c54
  
  if_e336d137a29f42cd9454dd83a85125d5: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    je end_if_f57a4b1a9bce44bb95302978063d5396
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    dec rax
    push rax
  pop rax
    
    mov qword [rbp - 56], rax
  end_if_f57a4b1a9bce44bb95302978063d5396: ; END of if_e336d137a29f42cd9454dd83a85125d5
  
  while_19e3d724afdb4f588cc9fbfd657c4418: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    jae end_while_57c99d7f9add4008aee87e3627f15709
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 64]
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
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 72], rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000000028
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 64]
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
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 80], rax
  if_a8cc002cb058486d9956ee69b1a2d744: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 72]
    cmp rax, rcx
    jbe end_if_b430cfc0279e475597377745bcbe6a1f
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_b430cfc0279e475597377745bcbe6a1f: ; END of if_a8cc002cb058486d9956ee69b1a2d744
  
  mov rax, qword [rbp - 24]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_888ab46511a14d50a8806f52baaff792: ; IF start
  mov rax, qword [rbp - 88]
    mov rcx, rax
    mov rax, qword [rbp - 80]
    cmp rax, rcx
    jbe end_if_851d9fece47a477daa7cdafc5d931927
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_851d9fece47a477daa7cdafc5d931927: ; END of if_888ab46511a14d50a8806f52baaff792
  
  mov rax, qword [rbp - 56]
    push rax
  mov rax, qword [rbp - 80]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 56], rax
  mov rax, qword [rbp - 64]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 64], rax
    jmp while_19e3d724afdb4f588cc9fbfd657c4418 ; Reevaluate WHILE condition
  end_while_57c99d7f9add4008aee87e3627f15709: ; END of while_19e3d724afdb4f588cc9fbfd657c4418
  
  if_ab850d35026d47739c02c147521e717f: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jb end_if_351ffb903f8b45159312caf366746471
  
  mov rax, 0xFFFFFFFFFFFFFFF4
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  end_if_351ffb903f8b45159312caf366746471: ; END of if_ab850d35026d47739c02c147521e717f
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    mov qword [rbp - 64], rax
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  while_43e11a7cc4494764bd33e06775a901b0: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    jae end_while_321d8a9a5391419fa919bba6f4459da3
  
  if_32e450876d0e46379b08f29a875f522f: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    je end_if_6107efe2ee1d44f08f067612cacec9dc
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 88]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x000000000000007C
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp - 88]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_6107efe2ee1d44f08f067612cacec9dc: ; END of if_32e450876d0e46379b08f29a875f522f
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 64]
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
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 72], rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000000028
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 64]
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
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 80], rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 88]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 48]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 80]
    push rax
  call func_66745F6D656D637079_fc4d7e433d34496488073977b2cc4597_start
    add rsp, 24
    push rax
  add rsp, 8
  mov rax, qword [rbp - 88]
    push rax
  mov rax, qword [rbp - 80]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  mov rax, qword [rbp - 64]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 64], rax
    jmp while_43e11a7cc4494764bd33e06775a901b0 ; Reevaluate WHILE condition
  end_while_321d8a9a5391419fa919bba6f4459da3: ; END of while_43e11a7cc4494764bd33e06775a901b0
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 88]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000000
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp - 56]
    push rax
  pop rax
    
    jmp func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end
  func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5061727469616C4275696C64_5e9c3477e3bc4f3a94c4dc99922f9140_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_5061727469616C4275696C64_5e9c3477e3bc4f3a94c4dc99922f9140_end
  func_5061727469616C4275696C64_5e9c3477e3bc4f3a94c4dc99922f9140_end:
    mov rsp, rbp
    pop rbp
    ret
module_746578745F777269746572_4a0165c8886d443d9a37ec1734575764_end:
section .text
global ubytec_host_contract_BuildText
ubytec_host_contract_BuildText:
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
call func_4275696C6454657874_24a3315d877b4b8a875db7c02de5ac56_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_PartialBuild
ubytec_host_contract_PartialBuild:
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
call func_5061727469616C4275696C64_5e9c3477e3bc4f3a94c4dc99922f9140_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,66,117,105,108,100,84,101,120,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,66,117,105,108,100,84,101,120,116,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,80,97,114,116,105,97,108,66,117,105,108,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,80,97,114,116,105,97,108,66,117,105,108,100,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
