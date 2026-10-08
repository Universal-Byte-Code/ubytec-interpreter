module_6172656E615F62656E6368_2df7ac1777794414ad58a059017eee26_start:
; Module: arena_bench v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 12:44:46Z
  ; Module UUID: 2df7ac17-7779-4414-ad58-a059017eee26


  section .bss

  section .text

  func_4172656E61496E6974_a3b4d4217413412b85a0241e43f56bd5_start:
  push rbp
    mov rbp, rsp
  if_73b4dd3fb1334093bcb953f40aedefe4: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_ff1a18429aee45fe90f0da2b8a1c0fcb
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61496E6974_a3b4d4217413412b85a0241e43f56bd5_end
  end_if_ff1a18429aee45fe90f0da2b8a1c0fcb: ; END of if_73b4dd3fb1334093bcb953f40aedefe4
  
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
    
    jmp func_4172656E61496E6974_a3b4d4217413412b85a0241e43f56bd5_end
  func_4172656E61496E6974_a3b4d4217413412b85a0241e43f56bd5_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146696E64_617e63cc6d61485aa7f9d80a9bb892cc_start:
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
  while_a2dfed9ddee24254a1ffebbf293fe37a: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_07de70f189e6443493058917cc726ce3
  
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
  if_f24f1250e4a94ac29e96474db775e69c: ; IF start
  pop rax
    test rax, rax
    je end_if_9d4935038a744f2d9f8aa858de45c6a6
  
    jmp end_else_6e45b6a484a6493db325ded6dc572007     ; Jump over ELSE part
  end_if_9d4935038a744f2d9f8aa858de45c6a6:    ; if_f24f1250e4a94ac29e96474db775e69c END
  else_0b6e9386061f459f9b492e92105d7ce5:  ; Start ELSE block
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
  if_bff05911571543609433848036b67516: ; IF start
  pop rax
    test rax, rax
    je end_if_ba9bce4ffbc843108bc5643e89998df2
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_617e63cc6d61485aa7f9d80a9bb892cc_end
  end_if_ba9bce4ffbc843108bc5643e89998df2: ; END of if_bff05911571543609433848036b67516
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_617e63cc6d61485aa7f9d80a9bb892cc_end
  end_else_6e45b6a484a6493db325ded6dc572007: ; END of else_0b6e9386061f459f9b492e92105d7ce5
  
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
    jmp while_a2dfed9ddee24254a1ffebbf293fe37a ; Reevaluate WHILE condition
  end_while_07de70f189e6443493058917cc726ce3: ; END of while_a2dfed9ddee24254a1ffebbf293fe37a
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_617e63cc6d61485aa7f9d80a9bb892cc_end
  func_4172656E6146696E64_617e63cc6d61485aa7f9d80a9bb892cc_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61416C6C6F63_507c288b3ba94fa59225087e8c8f4699_start:
  push rbp
    mov rbp, rsp
  sub rsp, 80
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
  if_1d1fad02cbf94c88b5c8eebfe2746464: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_f175d4bad6e84531b9157d83d7838c97
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_507c288b3ba94fa59225087e8c8f4699_end
  end_if_f175d4bad6e84531b9157d83d7838c97: ; END of if_1d1fad02cbf94c88b5c8eebfe2746464
  
  if_45bbfa2f37f142eea8cbef2f7479f4e5: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_fa4c3b7f62524ed79f42ba5a30d5dd9a
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_507c288b3ba94fa59225087e8c8f4699_end
  end_if_fa4c3b7f62524ed79f42ba5a30d5dd9a: ; END of if_45bbfa2f37f142eea8cbef2f7479f4e5
  
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
  while_5ec80ecb03ca4d6194faf53338de505b: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_18eb5e19480247e1a019ce71e134c41d
  
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
  if_f9366e78c86e450ea58ea414ad9fd6e4: ; IF start
  pop rax
    test rax, rax
    je end_if_c94e85b9a3454318910a0c7426e8dd91
  
    jmp end_else_7b62dcbb33204a19898550c8e4a84e17     ; Jump over ELSE part
  end_if_c94e85b9a3454318910a0c7426e8dd91:    ; if_f9366e78c86e450ea58ea414ad9fd6e4 END
  else_45f85be250ae46c581f3fd4efbe1ba4e:  ; Start ELSE block
  if_ea8b9a0b9811454fac807291b05a8197: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jb end_if_f520fdbf775d4dc6a6542563166b3d13
  
  jmp end_while_18eb5e19480247e1a019ce71e134c41d ; BREAK
  end_if_f520fdbf775d4dc6a6542563166b3d13: ; END of if_ea8b9a0b9811454fac807291b05a8197
  
  end_else_7b62dcbb33204a19898550c8e4a84e17: ; END of else_45f85be250ae46c581f3fd4efbe1ba4e
  
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
    jmp while_5ec80ecb03ca4d6194faf53338de505b ; Reevaluate WHILE condition
  end_while_18eb5e19480247e1a019ce71e134c41d: ; END of while_5ec80ecb03ca4d6194faf53338de505b
  
  if_7e09efaee9ea420f99b75abf1db32927: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jne end_if_729cefeacc044a7f96e751f917e3a86c
  
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
  if_b828a1747b9b44b48802c5fd8393de8c: ; IF start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jbe end_if_4c077f51f01341ecb6b5a0842ab0fdca
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_507c288b3ba94fa59225087e8c8f4699_end
  end_if_4c077f51f01341ecb6b5a0842ab0fdca: ; END of if_b828a1747b9b44b48802c5fd8393de8c
  
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
    jmp end_else_58973c67ce084ffcb3e916af71ab7175     ; Jump over ELSE part
  end_if_729cefeacc044a7f96e751f917e3a86c:    ; if_7e09efaee9ea420f99b75abf1db32927 END
  else_970068b6560543bc80f983e35cc9a962:  ; Start ELSE block
  mov rax, qword [rbp - 48]
    push rax
  mov rax, 0x0000000000000028
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 64], rax
  if_a7f17c9fcc9b453f8b4b41f8f8b29496: ; IF start
  mov rax, qword [rbp - 64]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jb end_if_1b313dc004184c489521cbea23599f41
  
  mov rax, qword [rbp - 40]
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 72], rax
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 80], rax
  mov rax, qword [rbp - 80]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 80]
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
  mov rax, qword [rbp - 80]
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
  mov rax, qword [rbp - 80]
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
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 48]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  end_if_1b313dc004184c489521cbea23599f41: ; END of if_a7f17c9fcc9b453f8b4b41f8f8b29496
  
  end_else_58973c67ce084ffcb3e916af71ab7175: ; END of else_970068b6560543bc80f983e35cc9a962
  
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
  while_89e15b9016e84fc1a30683e9263f4d7a: ; WHILE start
  mov rax, qword [rbp - 40]
    mov rcx, rax
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jae end_while_2786ed775846447ca29d238603aeb54c
  
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
    jmp while_89e15b9016e84fc1a30683e9263f4d7a ; Reevaluate WHILE condition
  end_while_2786ed775846447ca29d238603aeb54c: ; END of while_89e15b9016e84fc1a30683e9263f4d7a
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_507c288b3ba94fa59225087e8c8f4699_end
  func_4172656E61416C6C6F63_507c288b3ba94fa59225087e8c8f4699_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6150696E_8fa2066ad4584c5b9ba58b87e05907ab_start:
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
  call func_4172656E6146696E64_617e63cc6d61485aa7f9d80a9bb892cc_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_fd6780d64c12466a9dadea0e0d30aa2b: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_7cc0e1ea1e7041448189b9b3d1bde221
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_8fa2066ad4584c5b9ba58b87e05907ab_end
  end_if_7cc0e1ea1e7041448189b9b3d1bde221: ; END of if_fd6780d64c12466a9dadea0e0d30aa2b
  
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
  if_0b14a005d2c74c0bba387cd9ccef46cd: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jb end_if_54a84c43f3f44382a8a673bd4f0151d3
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_8fa2066ad4584c5b9ba58b87e05907ab_end
  end_if_54a84c43f3f44382a8a673bd4f0151d3: ; END of if_0b14a005d2c74c0bba387cd9ccef46cd
  
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
    
    jmp func_4172656E6150696E_8fa2066ad4584c5b9ba58b87e05907ab_end
  func_4172656E6150696E_8fa2066ad4584c5b9ba58b87e05907ab_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61556E70696E_432f65df3cf5459dbf58a97fd5be335b_start:
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
  call func_4172656E6146696E64_617e63cc6d61485aa7f9d80a9bb892cc_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_9bd73bba470e4d41bf85d024c7e6d80e: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_fb0e047bca964f8ab6955676c331b930
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_432f65df3cf5459dbf58a97fd5be335b_end
  end_if_fb0e047bca964f8ab6955676c331b930: ; END of if_9bd73bba470e4d41bf85d024c7e6d80e
  
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
  if_094fd0ccfcbe4491bd5ecc23bf7737fe: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_2a7573dec5ec4f67a877c5584ecf7f1b
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_432f65df3cf5459dbf58a97fd5be335b_end
  end_if_2a7573dec5ec4f67a877c5584ecf7f1b: ; END of if_094fd0ccfcbe4491bd5ecc23bf7737fe
  
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
    
    jmp func_4172656E61556E70696E_432f65df3cf5459dbf58a97fd5be335b_end
  func_4172656E61556E70696E_432f65df3cf5459dbf58a97fd5be335b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146726565_3694d5c5d6ba41da9e1a64a472e7db5a_start:
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
  mov rax, 0x0000000000000000
    mov qword [rbp - 64], rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_4172656E6146696E64_617e63cc6d61485aa7f9d80a9bb892cc_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_659879b3170642edbb559d371a51a86a: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_2a5a357c05e349798c76b96f09e64021
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_3694d5c5d6ba41da9e1a64a472e7db5a_end
  end_if_2a5a357c05e349798c76b96f09e64021: ; END of if_659879b3170642edbb559d371a51a86a
  
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
  if_e3867135028649b2996861d41b38319e: ; IF start
  pop rax
    test rax, rax
    je end_if_ff764dc251c441e5929587f8b20a0ec6
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_3694d5c5d6ba41da9e1a64a472e7db5a_end
  end_if_ff764dc251c441e5929587f8b20a0ec6: ; END of if_e3867135028649b2996861d41b38319e
  
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
  mov rax, qword [rbp - 8]
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
  while_ef8225a2a46e48bf9135e34d08992115: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_4374d286745441559ad02f449f05fb61
  
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
    
    mov qword [rbp - 48], rax
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
  if_dba74981f6ba4d08bddebf3490d07be0: ; IF start
  pop rax
    test rax, rax
    je end_if_9b20b0152c4745e59596ac98cd725751
  
  mov rax, qword [rbp - 48]
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp end_else_8a2a173b200b4bd592fc0c12e708626b     ; Jump over ELSE part
  end_if_9b20b0152c4745e59596ac98cd725751:    ; if_dba74981f6ba4d08bddebf3490d07be0 END
  else_f849ba7c35f547019ee3d4c1f9eec8a3:  ; Start ELSE block
  while_0d56a7c4afc8413abfd270258d3241b3: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    jae end_while_fea78b738acf420eab4a61e2ef740f59
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 56], rax
  mov rax, qword [rbp - 56]
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
  if_7728dce7eba34f5293c45f5bbac80d80: ; IF start
  pop rax
    test rax, rax
    je end_if_e937a722220c4723a1d2118b8c0a9783
  
  jmp end_while_fea78b738acf420eab4a61e2ef740f59 ; BREAK
  end_if_e937a722220c4723a1d2118b8c0a9783: ; END of if_7728dce7eba34f5293c45f5bbac80d80
  
  mov rax, qword [rbp - 56]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 64], rax
  mov rax, qword [rbp - 40]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 64]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  mov rax, qword [rbp - 48]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 64]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
    jmp while_0d56a7c4afc8413abfd270258d3241b3 ; Reevaluate WHILE condition
  end_while_fea78b738acf420eab4a61e2ef740f59: ; END of while_0d56a7c4afc8413abfd270258d3241b3
  
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp - 40]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 8]
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
  mov rax, qword [rbp - 8]
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
  end_else_8a2a173b200b4bd592fc0c12e708626b: ; END of else_f849ba7c35f547019ee3d4c1f9eec8a3
  
  mov rax, qword [rbp - 48]
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp while_ef8225a2a46e48bf9135e34d08992115 ; Reevaluate WHILE condition
  end_while_4374d286745441559ad02f449f05fb61: ; END of while_ef8225a2a46e48bf9135e34d08992115
  
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
    
    jmp func_4172656E6146726565_3694d5c5d6ba41da9e1a64a472e7db5a_end
  func_4172656E6146726565_3694d5c5d6ba41da9e1a64a472e7db5a_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_start:
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
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  call func_4172656E6146696E64_617e63cc6d61485aa7f9d80a9bb892cc_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_5d18fabfe6f54152bd20526b2a9b2f61: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_63cd5a0ad1ae49f28b03f49c1da6cddb
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_end
  end_if_63cd5a0ad1ae49f28b03f49c1da6cddb: ; END of if_5d18fabfe6f54152bd20526b2a9b2f61
  
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
  if_a60c48cfc10d4f1f8f292ac793202d54: ; IF start
  pop rax
    test rax, rax
    je end_if_3afc44e6aad44ec3873bd0680b0f676e
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_end
  end_if_3afc44e6aad44ec3873bd0680b0f676e: ; END of if_a60c48cfc10d4f1f8f292ac793202d54
  
  if_5a8c825abcfa4cb88cb6cd399ad43243: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_17c3f09d5e0849168b410e13de11e29e
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_end
  end_if_17c3f09d5e0849168b410e13de11e29e: ; END of if_5a8c825abcfa4cb88cb6cd399ad43243
  
  if_dc9154b774ce43239586ded3f056620d: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_f484f494a04447379ca44883a5c596c7
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_end
  end_if_f484f494a04447379ca44883a5c596c7: ; END of if_dc9154b774ce43239586ded3f056620d
  
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
  if_a83de705d4cf40c18d8609d2d1407364: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    ja end_if_bf9451346eb44e6bb2cf549c0bcdf7c7
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  while_c3c54b0122b64057aac798e6c124a3ad: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_dc01c1ef995d4544be6804fc6475f06e
  
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
    jmp while_c3c54b0122b64057aac798e6c124a3ad ; Reevaluate WHILE condition
  end_while_dc01c1ef995d4544be6804fc6475f06e: ; END of while_c3c54b0122b64057aac798e6c124a3ad
  
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
    
    jmp func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_end
  end_if_bf9451346eb44e6bb2cf549c0bcdf7c7: ; END of if_a83de705d4cf40c18d8609d2d1407364
  
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
    
    mov qword [rbp - 56], rax
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
    
    mov qword [rbp - 64], rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  mov rax, 0x0000000000000010
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  mov rax, 0x0000000000000020
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
    
    mov qword [rbp - 72], rax
  if_b97530877b3942359bf253a211397c9e: ; IF start
  mov rax, qword [rbp - 64]
    mov rcx, rax
    mov rax, qword [rbp - 72]
    cmp rax, rcx
    jne end_if_81f6742a1ea64bfcb473f5bdad3742c9
  
  mov rax, qword [rbp - 56]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 80], rax
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  mov rax, qword [rbp - 64]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_dcdb135c64dd479585a4bb9e6b794d8e: ; IF start
  mov rax, qword [rbp - 88]
    mov rcx, rax
    mov rax, qword [rbp - 80]
    cmp rax, rcx
    ja end_if_a064c85f6c55490c9d2a754d94edba07
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  while_70a3047f48d8445cb3a02b3a0c024302: ; WHILE start
  mov rax, qword [rbp - 56]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_5394ed36ded64d5cbd4f46abe9d099ee
  
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
    jmp while_70a3047f48d8445cb3a02b3a0c024302 ; Reevaluate WHILE condition
  end_while_5394ed36ded64d5cbd4f46abe9d099ee: ; END of while_70a3047f48d8445cb3a02b3a0c024302
  
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp - 56]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
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
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000000008
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 64]
    push rax
  mov rax, qword [rbp - 80]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp + 24]
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_end
  end_if_a064c85f6c55490c9d2a754d94edba07: ; END of if_dcdb135c64dd479585a4bb9e6b794d8e
  
  end_if_81f6742a1ea64bfcb473f5bdad3742c9: ; END of if_b97530877b3942359bf253a211397c9e
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_4172656E61416C6C6F63_507c288b3ba94fa59225087e8c8f4699_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_fd9dae19d11b480d95e426f14caac18b: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_510e099fb07d4c4aba384d65a707251d
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_end
  end_if_510e099fb07d4c4aba384d65a707251d: ; END of if_fd9dae19d11b480d95e426f14caac18b
  
  while_e905155ebd2d4a4493257c916999fa63: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_63fdc36d3ca14f208b27cdb5f26da46e
  
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
    jmp while_e905155ebd2d4a4493257c916999fa63 ; Reevaluate WHILE condition
  end_while_63fdc36d3ca14f208b27cdb5f26da46e: ; END of while_e905155ebd2d4a4493257c916999fa63
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  call func_4172656E6146726565_3694d5c5d6ba41da9e1a64a472e7db5a_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_end
  func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_start:
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
  if_5cc52b21c01346c393adfcd9ac58dbc1: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jbe end_if_9e10b2061f874923b6fd11a646149008
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_end
  end_if_9e10b2061f874923b6fd11a646149008: ; END of if_5cc52b21c01346c393adfcd9ac58dbc1
  
  if_60235cfeb83e468ab26234d69fedd993: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_8432e17a08774594827edf4643b04d8a
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_end
  end_if_8432e17a08774594827edf4643b04d8a: ; END of if_60235cfeb83e468ab26234d69fedd993
  
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
  if_9907368d2d8c45ad9756ffaee3e28637: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_13d02f838fc24bce839780d9751f0240
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_end
  end_if_13d02f838fc24bce839780d9751f0240: ; END of if_9907368d2d8c45ad9756ffaee3e28637
  
  if_7f9fff8b15da46a2ab8f7ef6d6993fb2: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_e5cc126ee58d42e9840145662c264af2
  
  if_fcbd49c078fd40319634cc7572038a22: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    je end_if_bb26178781274cf5b5eaa2e4b6a3eded
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_end
  end_if_bb26178781274cf5b5eaa2e4b6a3eded: ; END of if_fcbd49c078fd40319634cc7572038a22
  
  mov rax, 0x0000000000000008
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp end_else_3151daf7ddcd49c995bbe60f58cb66b9     ; Jump over ELSE part
  end_if_e5cc126ee58d42e9840145662c264af2:    ; if_7f9fff8b15da46a2ab8f7ef6d6993fb2 END
  else_d7be02637aee44088fedd73729850080:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  call func_4172656E6146696E64_617e63cc6d61485aa7f9d80a9bb892cc_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  if_7553839c861e4ba9845558c9ff162bf5: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_cbdbaed841f04b779f5e97545ff3e875
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_end
  end_if_cbdbaed841f04b779f5e97545ff3e875: ; END of if_7553839c861e4ba9845558c9ff162bf5
  
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
  if_045dcd08abf145dc8f8b9e5e33caf2ea: ; IF start
  pop rax
    test rax, rax
    je end_if_77d49b07f39c427c9dde2087310413c1
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_end
  end_if_77d49b07f39c427c9dde2087310413c1: ; END of if_045dcd08abf145dc8f8b9e5e33caf2ea
  
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
  if_e62bc90d730b464985e97a7d093d6bea: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jb end_if_3126869d15354bb3a8c07c9a8ac179be
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_end
  end_if_3126869d15354bb3a8c07c9a8ac179be: ; END of if_e62bc90d730b464985e97a7d093d6bea
  
  end_else_3151daf7ddcd49c995bbe60f58cb66b9: ; END of else_d7be02637aee44088fedd73729850080
  
  while_a4d0b2db1bd94bdc9e3e0660da2001de: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_601d71e186e34cb6a05202a1d44bc4bc
  
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
    jmp while_a4d0b2db1bd94bdc9e3e0660da2001de ; Reevaluate WHILE condition
  end_while_601d71e186e34cb6a05202a1d44bc4bc: ; END of while_a4d0b2db1bd94bdc9e3e0660da2001de
  
  if_cafeb5c8525c487799050b30b3ee3e75: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_4f1583e216634424b4dc0b4501fa7c74
  
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61416C6C6F63_507c288b3ba94fa59225087e8c8f4699_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp end_else_5946de41307d452cad539918a9aeafb7     ; Jump over ELSE part
  end_if_4f1583e216634424b4dc0b4501fa7c74:    ; if_cafeb5c8525c487799050b30b3ee3e75 END
  else_48278dd901804714a7d493166ac61301:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_start
    add rsp, 24
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_else_5946de41307d452cad539918a9aeafb7: ; END of else_48278dd901804714a7d493166ac61301
  
  if_33040616b1c94a71bc881823992f8398: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_e274a9be6e0749d9b23a6d23c739f2a0
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_end
  end_if_e274a9be6e0749d9b23a6d23c739f2a0: ; END of if_33040616b1c94a71bc881823992f8398
  
  while_afac42a225fb4a7c8bfb550060785ff8: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_94957fd451ef4a7faca5a463c275fd48
  
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
  if_97994d4e69134075a60926071181d682: ; IF start
  mov rcx, 97
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    jb end_if_a8bfaf31997848c28d79c9da672da7c8
  
  if_bc62fe6a5f9946b29f92b0deef9c9c0c: ; IF start
  mov rcx, 122
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    ja end_if_a8823b9475634d20a8531a7546b5e93f
  
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
  end_if_a8823b9475634d20a8531a7546b5e93f: ; END of if_bc62fe6a5f9946b29f92b0deef9c9c0c
  
  end_if_a8bfaf31997848c28d79c9da672da7c8: ; END of if_97994d4e69134075a60926071181d682
  
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
    jmp while_afac42a225fb4a7c8bfb550060785ff8 ; Reevaluate WHILE condition
  end_while_94957fd451ef4a7faca5a463c275fd48: ; END of while_afac42a225fb4a7c8bfb550060785ff8
  
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
    
    jmp func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_end
  func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_end:
    mov rsp, rbp
    pop rbp
    ret
module_6172656E615F62656E6368_2df7ac1777794414ad58a059017eee26_end:
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
call func_4172656E61496E6974_a3b4d4217413412b85a0241e43f56bd5_start
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
call func_4172656E61416C6C6F63_507c288b3ba94fa59225087e8c8f4699_start
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
call func_4172656E6146726565_3694d5c5d6ba41da9e1a64a472e7db5a_start
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
call func_4172656E61526573697A65_cc57fae6cddf429e85ee0298df25cf99_start
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
call func_4172656E61417070656E645570706572_8568849750fb4c75a0c38e366f1d4ac0_start
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
call func_4172656E6146696E64_617e63cc6d61485aa7f9d80a9bb892cc_start
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
call func_4172656E6150696E_8fa2066ad4584c5b9ba58b87e05907ab_start
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
call func_4172656E61556E70696E_432f65df3cf5459dbf58a97fd5be335b_start
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
