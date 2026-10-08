module_6172656E615F62656E6368_e2ff3fbffb7941f082ae22f55f593478_start:
; Module: arena_bench v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 12:18:31Z
  ; Module UUID: e2ff3fbf-fb79-41f0-82ae-22f55f593478


  section .bss

  section .text

  func_4172656E61496E6974_59de096fe3a244818a44a18fe24586e7_start:
  push rbp
    mov rbp, rsp
  if_d83b18e397524bcf829ba63786037cd9: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_57a99788cbb64e69a3343d2c60e1eb10
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61496E6974_59de096fe3a244818a44a18fe24586e7_end
  end_if_57a99788cbb64e69a3343d2c60e1eb10: ; END of if_d83b18e397524bcf829ba63786037cd9
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000008
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000000
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, 0x0000000000000001
    push rax
  pop rax
    
    jmp func_4172656E61496E6974_59de096fe3a244818a44a18fe24586e7_end
  func_4172656E61496E6974_59de096fe3a244818a44a18fe24586e7_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146696E64_159da7729ce54143b8dd8a4841e45ad2_start:
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
  mov rax, qword [rbp + 24]
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
    
    mov qword [rbp - 8], rax
  while_c2648b2564cb4b338f2d746c26e6c594: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_daaec0af23f4427db71d33a31a34b3d4
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  if_e92429b6d7894d76b95df34350facf09: ; IF start
  pop rax
    test rax, rax
    je end_if_a57f449f6d8b4d50aa5d36601e8391df
  
    jmp end_else_7bde02f8b14f45c9bb6b6ee7082a3539     ; Jump over ELSE part
  end_if_a57f449f6d8b4d50aa5d36601e8391df:    ; if_e92429b6d7894d76b95df34350facf09 END
  else_277a96a82200409aa0b745b1e1b7800b:  ; Start ELSE block
  mov rax, qword [rbp - 24]
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
  if_f4bed84ec2c74352b58facd90f01e7b2: ; IF start
  pop rax
    test rax, rax
    je end_if_bdc0e0fe3c624d6ab59cfa1eb4890fbd
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_159da7729ce54143b8dd8a4841e45ad2_end
  end_if_bdc0e0fe3c624d6ab59cfa1eb4890fbd: ; END of if_f4bed84ec2c74352b58facd90f01e7b2
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_159da7729ce54143b8dd8a4841e45ad2_end
  end_else_7bde02f8b14f45c9bb6b6ee7082a3539: ; END of else_277a96a82200409aa0b745b1e1b7800b
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_c2648b2564cb4b338f2d746c26e6c594 ; Reevaluate WHILE condition
  end_while_daaec0af23f4427db71d33a31a34b3d4: ; END of while_c2648b2564cb4b338f2d746c26e6c594
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_159da7729ce54143b8dd8a4841e45ad2_end
  func_4172656E6146696E64_159da7729ce54143b8dd8a4841e45ad2_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61416C6C6F63_2a113f9cfc2648f1ae68fc381ed1e37e_start:
  push rbp
    mov rbp, rsp
  sub rsp, 64
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
  if_39fbb44aec834ee7be5aba4b1689b44b: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_f42fff030d5546de96fa2c898db2426c
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_2a113f9cfc2648f1ae68fc381ed1e37e_end
  end_if_f42fff030d5546de96fa2c898db2426c: ; END of if_39fbb44aec834ee7be5aba4b1689b44b
  
  if_7993ecb8cfac4bbfa27fb71049eb7137: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_615fdbfa846b46c99f68aac11f85dc87
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_2a113f9cfc2648f1ae68fc381ed1e37e_end
  end_if_615fdbfa846b46c99f68aac11f85dc87: ; END of if_7993ecb8cfac4bbfa27fb71049eb7137
  
  mov rax, qword [rbp + 16]
    push rax
  mov rax, 0x0000000000000007
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000008
    push rax
  pop rcx
    pop rax
    cqo
    idiv rcx
    push rax
  mov rax, 0x0000000000000008
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  mov rax, qword [rbp + 24]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  mov rax, qword [rbp + 24]
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
  while_a44a37bb6c944f41ac4b632182e45805: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_08d57801958047e5a29c704c99bbf8a7
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 24]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  mov rax, qword [rbp - 32]
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
  if_cad26f88a7ec48d5b9a6818f68c7e978: ; IF start
  pop rax
    test rax, rax
    je end_if_cd32bdaa6d0f4353a273bad43eaa9dbd
  
    jmp end_else_378a38ea9a8f43848146071847dc7d76     ; Jump over ELSE part
  end_if_cd32bdaa6d0f4353a273bad43eaa9dbd:    ; if_cad26f88a7ec48d5b9a6818f68c7e978 END
  else_e95b9d70312c4fddb6a3a4340250aab2:  ; Start ELSE block
  if_359aeb28ff704f83bfcfb3312c77c7f5: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jb end_if_b5400eeaf5c84339917f216fd2830fb6
  
  jmp end_while_08d57801958047e5a29c704c99bbf8a7 ; BREAK
  end_if_b5400eeaf5c84339917f216fd2830fb6: ; END of if_359aeb28ff704f83bfcfb3312c77c7f5
  
  end_else_378a38ea9a8f43848146071847dc7d76: ; END of else_e95b9d70312c4fddb6a3a4340250aab2
  
  mov rax, qword [rbp - 24]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 40]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp while_a44a37bb6c944f41ac4b632182e45805 ; Reevaluate WHILE condition
  end_while_08d57801958047e5a29c704c99bbf8a7: ; END of while_a44a37bb6c944f41ac4b632182e45805
  
  if_d2bfc92a25674b4c941daf833e4c3fa3: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jne end_if_bfef420c027f4b83a6a470eed54ccfc5
  
  mov rax, qword [rbp - 48]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_d6fd23ac424f4c09bc7c4bfaf2dcfa18: ; IF start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jbe end_if_7d14bde751df4ad2ba20967c20243a9f
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_2a113f9cfc2648f1ae68fc381ed1e37e_end
  end_if_7d14bde751df4ad2ba20967c20243a9f: ; END of if_d6fd23ac424f4c09bc7c4bfaf2dcfa18
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000008
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp - 40]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 48]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  end_if_bfef420c027f4b83a6a470eed54ccfc5: ; END of if_d2bfc92a25674b4c941daf833e4c3fa3
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000008
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000000
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  while_5662f244abea4c6da7353a04d36f5e1f: ; WHILE start
  mov rax, qword [rbp - 40]
    mov rcx, rax
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jae end_while_c7bbd41fbad142eaab7065afbc989151
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 56]
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
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 56], rax
    jmp while_5662f244abea4c6da7353a04d36f5e1f ; Reevaluate WHILE condition
  end_while_c7bbd41fbad142eaab7065afbc989151: ; END of while_5662f244abea4c6da7353a04d36f5e1f
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_2a113f9cfc2648f1ae68fc381ed1e37e_end
  func_4172656E61416C6C6F63_2a113f9cfc2648f1ae68fc381ed1e37e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6150696E_c59845df81ad4678bd138119b52c9834_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_4172656E6146696E64_159da7729ce54143b8dd8a4841e45ad2_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_3c1d36501eea40799460b99b0e372fa4: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_2d7cd84eb9c343a08af938c82b09a5aa
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_c59845df81ad4678bd138119b52c9834_end
  end_if_2d7cd84eb9c343a08af938c82b09a5aa: ; END of if_3c1d36501eea40799460b99b0e372fa4
  
  mov rax, qword [rbp - 8]
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
    
    mov qword [rbp - 16], rax
  if_9e07751139ff40ef86def044a19c5ea6: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jb end_if_2d88e7ab2c4343afa360aeb12b7345fe
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_c59845df81ad4678bd138119b52c9834_end
  end_if_2d88e7ab2c4343afa360aeb12b7345fe: ; END of if_9e07751139ff40ef86def044a19c5ea6
  
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 16]
    push rax
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, 0x0000000000000001
    push rax
  pop rax
    
    jmp func_4172656E6150696E_c59845df81ad4678bd138119b52c9834_end
  func_4172656E6150696E_c59845df81ad4678bd138119b52c9834_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61556E70696E_a6034fb1a9b9425186e11508a6de61d7_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_4172656E6146696E64_159da7729ce54143b8dd8a4841e45ad2_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_db019c4f4b01484fa338a17ff3d11631: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_570c20d562c149cfbb5c8dc177f32663
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_a6034fb1a9b9425186e11508a6de61d7_end
  end_if_570c20d562c149cfbb5c8dc177f32663: ; END of if_db019c4f4b01484fa338a17ff3d11631
  
  mov rax, qword [rbp - 8]
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
    
    mov qword [rbp - 16], rax
  if_edd477ea18d2429eb85605db9f1cd8d8: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_b6d1c856b782428fa261df62213a3191
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_a6034fb1a9b9425186e11508a6de61d7_end
  end_if_b6d1c856b782428fa261df62213a3191: ; END of if_edd477ea18d2429eb85605db9f1cd8d8
  
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 16]
    push rax
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, 0x0000000000000001
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_a6034fb1a9b9425186e11508a6de61d7_end
  func_4172656E61556E70696E_a6034fb1a9b9425186e11508a6de61d7_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146726565_fde8171992f847d9a968a041084c6311_start:
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
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_4172656E6146696E64_159da7729ce54143b8dd8a4841e45ad2_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_46bdef1de79e49409e5f9d3d271c8fef: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_3cc087d650e9404ebbfb4dbdffe043af
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_fde8171992f847d9a968a041084c6311_end
  end_if_3cc087d650e9404ebbfb4dbdffe043af: ; END of if_46bdef1de79e49409e5f9d3d271c8fef
  
  mov rax, qword [rbp - 8]
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
  if_3c1d496dcd804e7e924b8ea35b197e93: ; IF start
  pop rax
    test rax, rax
    je end_if_c74c03ffeb5f42c380318c2c5dd4aad4
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_fde8171992f847d9a968a041084c6311_end
  end_if_c74c03ffeb5f42c380318c2c5dd4aad4: ; END of if_3c1d496dcd804e7e924b8ea35b197e93
  
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000000
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp + 24]
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
  while_3ffc4bcda5554b08b8b5f3fca5d872e9: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_86a3d267a06c450e90e6b5ef4a0bb0fa
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 24]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 40]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 8]
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
  if_32fe842d05ab47c5b583d80c279f290a: ; IF start
  pop rax
    test rax, rax
    je end_if_f076fc591d8a4fe0abb1869106456db6
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_if_f076fc591d8a4fe0abb1869106456db6: ; END of if_32fe842d05ab47c5b583d80c279f290a
  
    jmp while_3ffc4bcda5554b08b8b5f3fca5d872e9 ; Reevaluate WHILE condition
  end_while_86a3d267a06c450e90e6b5ef4a0bb0fa: ; END of while_3ffc4bcda5554b08b8b5f3fca5d872e9
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000008
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, 0x0000000000000001
    push rax
  pop rax
    
    jmp func_4172656E6146726565_fde8171992f847d9a968a041084c6311_end
  func_4172656E6146726565_fde8171992f847d9a968a041084c6311_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61526573697A65_9c8da33377c2463cba42a9d84bbde5a2_start:
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
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  call func_4172656E6146696E64_159da7729ce54143b8dd8a4841e45ad2_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_e38216c64f2b4f639657afc2c32e2eca: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_9d77bcbee0b34024aa6df4d81712d631
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_9c8da33377c2463cba42a9d84bbde5a2_end
  end_if_9d77bcbee0b34024aa6df4d81712d631: ; END of if_e38216c64f2b4f639657afc2c32e2eca
  
  mov rax, qword [rbp - 8]
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
  if_81059c4b53f542398889c9b8947bf4a7: ; IF start
  pop rax
    test rax, rax
    je end_if_80097ede3cc642b988877aff6c47ac00
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_9c8da33377c2463cba42a9d84bbde5a2_end
  end_if_80097ede3cc642b988877aff6c47ac00: ; END of if_81059c4b53f542398889c9b8947bf4a7
  
  if_5c47d1de75df4b1ea42ef602b8731ca3: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_3f216391dcea4c50a47d08ec76ab7a4c
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_9c8da33377c2463cba42a9d84bbde5a2_end
  end_if_3f216391dcea4c50a47d08ec76ab7a4c: ; END of if_5c47d1de75df4b1ea42ef602b8731ca3
  
  if_516787638fed47a9b7183c0f818ac5f4: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_dd52d3a210e44a2290c96eaf65fb6c60
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_9c8da33377c2463cba42a9d84bbde5a2_end
  end_if_dd52d3a210e44a2290c96eaf65fb6c60: ; END of if_516787638fed47a9b7183c0f818ac5f4
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 8]
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
    
    mov qword [rbp - 24], rax
  if_c66b51e493bb4c7891da36f6318d5127: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    ja end_if_87785b588a1b4c16b870715e31d7e1b3
  
  if_acb06df410d94654b5caa52a321cc948: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_03a4907eb4ee44429d852093dfe96125
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  while_7ef2df38558946f6a84153e18faf979c: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_986d273530694598b83c11f43f730234
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 40]
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
  mov rax, qword [rbp - 40]
    push rax
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
    jmp while_7ef2df38558946f6a84153e18faf979c ; Reevaluate WHILE condition
  end_while_986d273530694598b83c11f43f730234: ; END of while_7ef2df38558946f6a84153e18faf979c
  
  end_if_03a4907eb4ee44429d852093dfe96125: ; END of if_acb06df410d94654b5caa52a321cc948
  
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000000008
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp + 24]
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_9c8da33377c2463cba42a9d84bbde5a2_end
  end_if_87785b588a1b4c16b870715e31d7e1b3: ; END of if_c66b51e493bb4c7891da36f6318d5127
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_4172656E61416C6C6F63_2a113f9cfc2648f1ae68fc381ed1e37e_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_02d9d76f4a144a58b88efde6b2fba6a7: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_b4598c5a1720465bb8c85279acd4f009
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_9c8da33377c2463cba42a9d84bbde5a2_end
  end_if_b4598c5a1720465bb8c85279acd4f009: ; END of if_02d9d76f4a144a58b88efde6b2fba6a7
  
  while_adb3cddd48ad4e1a98500f82a3e9b54c: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_b14aa4dfa27e41b2bed4a5b2451d619e
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 40]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 40]
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
  mov rax, qword [rbp - 40]
    push rax
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
    jmp while_adb3cddd48ad4e1a98500f82a3e9b54c ; Reevaluate WHILE condition
  end_while_b14aa4dfa27e41b2bed4a5b2451d619e: ; END of while_adb3cddd48ad4e1a98500f82a3e9b54c
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  call func_4172656E6146726565_fde8171992f847d9a968a041084c6311_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_9c8da33377c2463cba42a9d84bbde5a2_end
  func_4172656E61526573697A65_9c8da33377c2463cba42a9d84bbde5a2_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_start:
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
  if_6baaa1b8452a4f57b2935bf63af1765e: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jbe end_if_4ee8c428f69d4cf3bbc44b98d7fa63ad
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_end
  end_if_4ee8c428f69d4cf3bbc44b98d7fa63ad: ; END of if_6baaa1b8452a4f57b2935bf63af1765e
  
  if_5af7d1f0dc1b4bceb4d169907d40f818: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_914ceb2a823c475a8a862a1cbaa5784b
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_end
  end_if_914ceb2a823c475a8a862a1cbaa5784b: ; END of if_5af7d1f0dc1b4bceb4d169907d40f818
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_236bea238f844c59a6ce59ec8a9e3c3b: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_d010d374d97148988c0abab683fad580
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_end
  end_if_d010d374d97148988c0abab683fad580: ; END of if_236bea238f844c59a6ce59ec8a9e3c3b
  
  if_fc1eb905807144caa88f3722f6baa59c: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_20e5a96c974b44beba4c152d83dc7ddc
  
  if_9953b3dfb7f54d60913dfc9d4d67c5a6: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    je end_if_5009e23b2c8a44aa8eaef36c3835e2c8
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_end
  end_if_5009e23b2c8a44aa8eaef36c3835e2c8: ; END of if_9953b3dfb7f54d60913dfc9d4d67c5a6
  
  mov rax, 0x0000000000000008
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp end_else_ed76632f611449e8bec0a698e8a26b4e     ; Jump over ELSE part
  end_if_20e5a96c974b44beba4c152d83dc7ddc:    ; if_fc1eb905807144caa88f3722f6baa59c END
  else_c43b2b29ad2a4acab40b729dbd48e0ae:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  call func_4172656E6146696E64_159da7729ce54143b8dd8a4841e45ad2_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  if_6f80f0d464534aecac46b98c27137081: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_3c9f4242ded34aee95d485429648332f
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_end
  end_if_3c9f4242ded34aee95d485429648332f: ; END of if_6f80f0d464534aecac46b98c27137081
  
  mov rax, qword [rbp - 16]
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
  if_615e2f641db24eac8e319d7e4f2351d6: ; IF start
  pop rax
    test rax, rax
    je end_if_f9a57855eb354b50b42c6c1a8d7467ab
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_end
  end_if_f9a57855eb354b50b42c6c1a8d7467ab: ; END of if_615e2f641db24eac8e319d7e4f2351d6
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 16]
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
    
    mov qword [rbp - 48], rax
  if_19ba29bf9b934ee7958a811299e1557e: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jb end_if_9ab19466bd0a4e5c91142daf3e3d6652
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_end
  end_if_9ab19466bd0a4e5c91142daf3e3d6652: ; END of if_19ba29bf9b934ee7958a811299e1557e
  
  end_else_ed76632f611449e8bec0a698e8a26b4e: ; END of else_c43b2b29ad2a4acab40b729dbd48e0ae
  
  while_c30e86a26e3146119042477b503e198d: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_0b775d4ab0ab40dcb1c2b9ff2ee89b7d
  
  mov rax, qword [rbp - 24]
    push rax
  mov rax, 0x0000000000000002
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp while_c30e86a26e3146119042477b503e198d ; Reevaluate WHILE condition
  end_while_0b775d4ab0ab40dcb1c2b9ff2ee89b7d: ; END of while_c30e86a26e3146119042477b503e198d
  
  if_33f10427f6a144d4a94c1dd380f550f7: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_a570ac88c0da488792050018a4fa92db
  
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61416C6C6F63_2a113f9cfc2648f1ae68fc381ed1e37e_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp end_else_eee1406c92f74fab858d0141235627b7     ; Jump over ELSE part
  end_if_a570ac88c0da488792050018a4fa92db:    ; if_33f10427f6a144d4a94c1dd380f550f7 END
  else_a24ec78b3cdc47bf9793fc193886e525:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61526573697A65_9c8da33377c2463cba42a9d84bbde5a2_start
    add rsp, 24
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_else_eee1406c92f74fab858d0141235627b7: ; END of else_a24ec78b3cdc47bf9793fc193886e525
  
  if_6d24c299c03c4910b760d4ac086688e3: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_bcfbe10fd5bf43f18f195a9c56915701
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_end
  end_if_bcfbe10fd5bf43f18f195a9c56915701: ; END of if_6d24c299c03c4910b760d4ac086688e3
  
  while_7c2ad0e750a34a8d88aab9f391714bb5: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_7731f9ad6f8546e3bb4a857cd28d0912
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 40]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  if_2bbaf09664304958b85f5109c6a7c9b2: ; IF start
  mov rcx, 97
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    jb end_if_425e17771ddb465a82ad363d97985939
  
  if_796e5e28441c4754a0f5ddeb4a9c4a51: ; IF start
  mov rcx, 122
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    ja end_if_c41144560ced472ab6f73dcd7e3e33e6
  
  mov rax, qword [rbp - 48]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  end_if_c41144560ced472ab6f73dcd7e3e33e6: ; END of if_796e5e28441c4754a0f5ddeb4a9c4a51
  
  end_if_425e17771ddb465a82ad363d97985939: ; END of if_2bbaf09664304958b85f5109c6a7c9b2
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 40]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp - 40]
    push rax
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
    jmp while_7c2ad0e750a34a8d88aab9f391714bb5 ; Reevaluate WHILE condition
  end_while_7731f9ad6f8546e3bb4a857cd28d0912: ; END of while_7c2ad0e750a34a8d88aab9f391714bb5
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 16]
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
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_end
  func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_end:
    mov rsp, rbp
    pop rbp
    ret
module_6172656E615F62656E6368_e2ff3fbffb7941f082ae22f55f593478_end:
section .text
global ubytec_host_contract_ArenaInit
ubytec_host_contract_ArenaInit:
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
call func_4172656E61496E6974_59de096fe3a244818a44a18fe24586e7_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ArenaAlloc
ubytec_host_contract_ArenaAlloc:
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
call func_4172656E61416C6C6F63_2a113f9cfc2648f1ae68fc381ed1e37e_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ArenaFree
ubytec_host_contract_ArenaFree:
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
call func_4172656E6146726565_fde8171992f847d9a968a041084c6311_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ArenaResize
ubytec_host_contract_ArenaResize:
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
call func_4172656E61526573697A65_9c8da33377c2463cba42a9d84bbde5a2_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ArenaAppendUpper
ubytec_host_contract_ArenaAppendUpper:
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
push rcx
push r8
call func_4172656E61417070656E645570706572_00ef03ec2c3b49ec988e98afbffe9ce8_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ArenaFind
ubytec_host_contract_ArenaFind:
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
call func_4172656E6146696E64_159da7729ce54143b8dd8a4841e45ad2_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ArenaPin
ubytec_host_contract_ArenaPin:
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
call func_4172656E6150696E_c59845df81ad4678bd138119b52c9834_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ArenaUnpin
ubytec_host_contract_ArenaUnpin:
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
call func_4172656E61556E70696E_a6034fb1a9b9425186e11508a6de61d7_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,65,114,101,110,97,73,110,105,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,73,110,105,116,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,65,108,108,111,99,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,65,108,108,111,99,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,70,114,101,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,70,114,101,101,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,82,101,115,105,122,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,82,101,115,105,122,101,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,65,112,112,101,110,100,85,112,112,101,114,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,65,112,112,101,110,100,85,112,112,101,114,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,70,105,110,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,70,105,110,100,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,80,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,80,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,85,110,112,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,85,110,112,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
