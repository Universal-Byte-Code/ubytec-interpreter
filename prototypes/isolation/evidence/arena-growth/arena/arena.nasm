module_6172656E615F74657374_cc1aebb5c9a641358781bf22addde4cd_start:
; Module: arena_test v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 12:11:22Z
  ; Module UUID: cc1aebb5-c9a6-4135-8781-bf22addde4cd


  section .bss

  section .text

  func_4172656E61496E6974_334337dfbd1e4e85ba3710b5c8c3e350_start:
  push rbp
    mov rbp, rsp
  if_b0e3f03f73974fd4bca14fe482d3d204: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_fb8c977f3d4e4b9ab1adfafde9d66987
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61496E6974_334337dfbd1e4e85ba3710b5c8c3e350_end
  end_if_fb8c977f3d4e4b9ab1adfafde9d66987: ; END of if_b0e3f03f73974fd4bca14fe482d3d204
  
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
    
    jmp func_4172656E61496E6974_334337dfbd1e4e85ba3710b5c8c3e350_end
  func_4172656E61496E6974_334337dfbd1e4e85ba3710b5c8c3e350_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_start:
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
  while_436c64b6090347f0bdcb9f4f4b78d92c: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_2b64675f10af42cc93436cecfc7ba819
  
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
  if_bab6ed440fe549148ff893bf6efe2dff: ; IF start
  pop rax
    test rax, rax
    je end_if_885ee8a99fb8407f842da8903e7fd887
  
    jmp end_else_e86707b336b74be09ac829d1431694db     ; Jump over ELSE part
  end_if_885ee8a99fb8407f842da8903e7fd887:    ; if_bab6ed440fe549148ff893bf6efe2dff END
  else_15413779d3884d6eba251ba6f5388c6b:  ; Start ELSE block
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
  if_7fb1a98bc8f9481cbe5e0516f5693850: ; IF start
  pop rax
    test rax, rax
    je end_if_f0aa43de5e7a483e80c35a6f8e4e27c8
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_end
  end_if_f0aa43de5e7a483e80c35a6f8e4e27c8: ; END of if_7fb1a98bc8f9481cbe5e0516f5693850
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_end
  end_else_e86707b336b74be09ac829d1431694db: ; END of else_15413779d3884d6eba251ba6f5388c6b
  
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
    jmp while_436c64b6090347f0bdcb9f4f4b78d92c ; Reevaluate WHILE condition
  end_while_2b64675f10af42cc93436cecfc7ba819: ; END of while_436c64b6090347f0bdcb9f4f4b78d92c
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_end
  func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61416C6C6F63_bf803c06d3354771a2f73fddbf667738_start:
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
  if_0cd63faef76b45409b4d20b0ef54c1ec: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_6186fbdd5e4d4c45a98398b7f1323c4f
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_bf803c06d3354771a2f73fddbf667738_end
  end_if_6186fbdd5e4d4c45a98398b7f1323c4f: ; END of if_0cd63faef76b45409b4d20b0ef54c1ec
  
  if_d046bd592ace4a2ab6ce985770040279: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_113ee09c24da4990a478e6e63e16df9b
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_bf803c06d3354771a2f73fddbf667738_end
  end_if_113ee09c24da4990a478e6e63e16df9b: ; END of if_d046bd592ace4a2ab6ce985770040279
  
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
  while_d1d170517b214843bf2c387b5a85f99c: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_0136eee463c047b286ab276943694e03
  
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
  if_15ea7280547f4dc9ac6fe7a8d63891fc: ; IF start
  pop rax
    test rax, rax
    je end_if_61a97aaa9a2a4b3d886cfdf23cfcfb98
  
    jmp end_else_cfd0cfbd5a034861985fc34c42cbbc5c     ; Jump over ELSE part
  end_if_61a97aaa9a2a4b3d886cfdf23cfcfb98:    ; if_15ea7280547f4dc9ac6fe7a8d63891fc END
  else_645f43ea15e743d1a0190226901471fc:  ; Start ELSE block
  if_6102cfdacea4475d80e63fd33baf380d: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jb end_if_22ea7d522bf54eef8c5eec57bba2cac1
  
  jmp end_while_0136eee463c047b286ab276943694e03 ; BREAK
  end_if_22ea7d522bf54eef8c5eec57bba2cac1: ; END of if_6102cfdacea4475d80e63fd33baf380d
  
  end_else_cfd0cfbd5a034861985fc34c42cbbc5c: ; END of else_645f43ea15e743d1a0190226901471fc
  
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
    jmp while_d1d170517b214843bf2c387b5a85f99c ; Reevaluate WHILE condition
  end_while_0136eee463c047b286ab276943694e03: ; END of while_d1d170517b214843bf2c387b5a85f99c
  
  if_b94584eac04342f6a80a2b2b8d15c35b: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jne end_if_451e1676c51a4675a2d6ecd8cc72d83f
  
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
  if_91a649bd4eeb4fbba9493047a53d2ec7: ; IF start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jbe end_if_ded7349768bf4cd9845558bc2da6b50a
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_bf803c06d3354771a2f73fddbf667738_end
  end_if_ded7349768bf4cd9845558bc2da6b50a: ; END of if_91a649bd4eeb4fbba9493047a53d2ec7
  
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
    jmp end_else_f2a6fed342f847d9a4ec6050c14489a6     ; Jump over ELSE part
  end_if_451e1676c51a4675a2d6ecd8cc72d83f:    ; if_b94584eac04342f6a80a2b2b8d15c35b END
  else_53e4ae1d3ce7401d887767d0b93a7cee:  ; Start ELSE block
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
  if_e22572548b8c46ba86b2171ebfb800ba: ; IF start
  mov rax, qword [rbp - 64]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jb end_if_7a25c2a600a246158f4edfadb2c82563
  
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
  end_if_7a25c2a600a246158f4edfadb2c82563: ; END of if_e22572548b8c46ba86b2171ebfb800ba
  
  end_else_f2a6fed342f847d9a4ec6050c14489a6: ; END of else_53e4ae1d3ce7401d887767d0b93a7cee
  
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
  while_39ae4aa6379340b1b2f5ed3364c317f8: ; WHILE start
  mov rax, qword [rbp - 40]
    mov rcx, rax
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jae end_while_e7ba9452957a49c7b52ade56d81f114b
  
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
    jmp while_39ae4aa6379340b1b2f5ed3364c317f8 ; Reevaluate WHILE condition
  end_while_e7ba9452957a49c7b52ade56d81f114b: ; END of while_39ae4aa6379340b1b2f5ed3364c317f8
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_bf803c06d3354771a2f73fddbf667738_end
  func_4172656E61416C6C6F63_bf803c06d3354771a2f73fddbf667738_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6150696E_a2d601d134e444e1b2ba7cd82457fbb1_start:
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
  call func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_b1c367a394a2427bab389cb3fb2f672f: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_2c8ee8a4a9b744de937eafb4486af025
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_a2d601d134e444e1b2ba7cd82457fbb1_end
  end_if_2c8ee8a4a9b744de937eafb4486af025: ; END of if_b1c367a394a2427bab389cb3fb2f672f
  
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
  if_e80b1666c36d4407bdff826e09a44826: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jb end_if_b7108ae09ec24b6584a4ea0b3909bcc4
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_a2d601d134e444e1b2ba7cd82457fbb1_end
  end_if_b7108ae09ec24b6584a4ea0b3909bcc4: ; END of if_e80b1666c36d4407bdff826e09a44826
  
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
    
    jmp func_4172656E6150696E_a2d601d134e444e1b2ba7cd82457fbb1_end
  func_4172656E6150696E_a2d601d134e444e1b2ba7cd82457fbb1_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61556E70696E_cd53ed29be1945979ce48ef3ec2db249_start:
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
  call func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_126d9f584602473eb851485f5737fbcd: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_5cfb60ba1a2b4acc8cea2da72eb0e7ff
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_cd53ed29be1945979ce48ef3ec2db249_end
  end_if_5cfb60ba1a2b4acc8cea2da72eb0e7ff: ; END of if_126d9f584602473eb851485f5737fbcd
  
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
  if_23d27c7b444b4e80982b58e6fb5687e0: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_9a3a566e60444b8f94c91fe6423849ed
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_cd53ed29be1945979ce48ef3ec2db249_end
  end_if_9a3a566e60444b8f94c91fe6423849ed: ; END of if_23d27c7b444b4e80982b58e6fb5687e0
  
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
    
    jmp func_4172656E61556E70696E_cd53ed29be1945979ce48ef3ec2db249_end
  func_4172656E61556E70696E_cd53ed29be1945979ce48ef3ec2db249_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146726565_e418dc0fc94e4350b99a79689af02598_start:
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
  call func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_587196de881243dabb0626abf59e149d: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_0bc39263ea0d4cdd929455e282dcd14a
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_e418dc0fc94e4350b99a79689af02598_end
  end_if_0bc39263ea0d4cdd929455e282dcd14a: ; END of if_587196de881243dabb0626abf59e149d
  
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
  if_7bb0c4acde65414688cd60f4b5dd5c7b: ; IF start
  pop rax
    test rax, rax
    je end_if_ddb76b3e4ed340ff91c3f68d064e45a3
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_e418dc0fc94e4350b99a79689af02598_end
  end_if_ddb76b3e4ed340ff91c3f68d064e45a3: ; END of if_7bb0c4acde65414688cd60f4b5dd5c7b
  
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
  while_fc483fd42b6b433bb74d36b78d8c4750: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_80dfc3e81b8e47738ba7a956ee34172f
  
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
  if_cd16a72f2c6a41ada3b3d34cb9357091: ; IF start
  pop rax
    test rax, rax
    je end_if_14a2e22a5aa1436d9e7172d2328942e1
  
  mov rax, qword [rbp - 48]
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp end_else_3bd3bbf1183541ef81e9a0f5c011476f     ; Jump over ELSE part
  end_if_14a2e22a5aa1436d9e7172d2328942e1:    ; if_cd16a72f2c6a41ada3b3d34cb9357091 END
  else_1c7afe7675114b05b0bd8e4821f69e03:  ; Start ELSE block
  while_f03ab65bd930410da8ad77ec2fbcd171: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    jae end_while_7d8f57f9378d454780ca3915c293986f
  
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
  if_d2a26a46986f47c99da9c5f02b06d22e: ; IF start
  pop rax
    test rax, rax
    je end_if_6680b0e523014d3ba39945e13fd87360
  
  jmp end_while_7d8f57f9378d454780ca3915c293986f ; BREAK
  end_if_6680b0e523014d3ba39945e13fd87360: ; END of if_d2a26a46986f47c99da9c5f02b06d22e
  
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
    jmp while_f03ab65bd930410da8ad77ec2fbcd171 ; Reevaluate WHILE condition
  end_while_7d8f57f9378d454780ca3915c293986f: ; END of while_f03ab65bd930410da8ad77ec2fbcd171
  
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
  end_else_3bd3bbf1183541ef81e9a0f5c011476f: ; END of else_1c7afe7675114b05b0bd8e4821f69e03
  
  mov rax, qword [rbp - 48]
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp while_fc483fd42b6b433bb74d36b78d8c4750 ; Reevaluate WHILE condition
  end_while_80dfc3e81b8e47738ba7a956ee34172f: ; END of while_fc483fd42b6b433bb74d36b78d8c4750
  
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
    
    jmp func_4172656E6146726565_e418dc0fc94e4350b99a79689af02598_end
  func_4172656E6146726565_e418dc0fc94e4350b99a79689af02598_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_start:
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
  call func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_bd8601e083aa40d8aff44a5b726c8cff: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_f7fb264f24cf4b78b2080401c859a9c1
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_end
  end_if_f7fb264f24cf4b78b2080401c859a9c1: ; END of if_bd8601e083aa40d8aff44a5b726c8cff
  
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
  if_0d914b9000c24d7bb4e473bfad895b4e: ; IF start
  pop rax
    test rax, rax
    je end_if_9a707e49c28c411480cf88bc42be08e4
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_end
  end_if_9a707e49c28c411480cf88bc42be08e4: ; END of if_0d914b9000c24d7bb4e473bfad895b4e
  
  if_12d0b019e54e444dae1d900ef1f1108c: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_b1a001e4c9a44dacba92789f68bb9d77
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_end
  end_if_b1a001e4c9a44dacba92789f68bb9d77: ; END of if_12d0b019e54e444dae1d900ef1f1108c
  
  if_193ce3b4ee944a9ab4be59d5641cf9eb: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_40ef9ba4b8d04946b1b78b0d7df7bdeb
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_end
  end_if_40ef9ba4b8d04946b1b78b0d7df7bdeb: ; END of if_193ce3b4ee944a9ab4be59d5641cf9eb
  
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
  if_6860d76919ba48659990599c530966d1: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    ja end_if_bf167f33f38a438789065931cdea4ca8
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  while_bb8e4c0c95fa47279faa01f8536cc7bc: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_89f754b0be8e43b99d1d59534465c2f5
  
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
    jmp while_bb8e4c0c95fa47279faa01f8536cc7bc ; Reevaluate WHILE condition
  end_while_89f754b0be8e43b99d1d59534465c2f5: ; END of while_bb8e4c0c95fa47279faa01f8536cc7bc
  
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
    
    jmp func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_end
  end_if_bf167f33f38a438789065931cdea4ca8: ; END of if_6860d76919ba48659990599c530966d1
  
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
  if_7e224f4df90e45568e8c466faf9fc30e: ; IF start
  mov rax, qword [rbp - 64]
    mov rcx, rax
    mov rax, qword [rbp - 72]
    cmp rax, rcx
    jne end_if_11a2a7faa2e342489df21ea661f2cb48
  
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
  if_c5d4e26c63ad4e17be1031cfeb4f9b86: ; IF start
  mov rax, qword [rbp - 88]
    mov rcx, rax
    mov rax, qword [rbp - 80]
    cmp rax, rcx
    ja end_if_a1e575519bdb4232bed9b4aefc3b5f48
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  while_c2c15c61545140f7b6803c1c8faf5619: ; WHILE start
  mov rax, qword [rbp - 56]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_cfa408b727804418a641989b5dd09c50
  
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
    jmp while_c2c15c61545140f7b6803c1c8faf5619 ; Reevaluate WHILE condition
  end_while_cfa408b727804418a641989b5dd09c50: ; END of while_c2c15c61545140f7b6803c1c8faf5619
  
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
    
    jmp func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_end
  end_if_a1e575519bdb4232bed9b4aefc3b5f48: ; END of if_c5d4e26c63ad4e17be1031cfeb4f9b86
  
  end_if_11a2a7faa2e342489df21ea661f2cb48: ; END of if_7e224f4df90e45568e8c466faf9fc30e
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_4172656E61416C6C6F63_bf803c06d3354771a2f73fddbf667738_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_9108eed63bac4873984cbb075f23a60a: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_ca90a88bef6042eaa3df7ecec386ae5a
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_end
  end_if_ca90a88bef6042eaa3df7ecec386ae5a: ; END of if_9108eed63bac4873984cbb075f23a60a
  
  while_b7c4fa0038444c97ac699efd7db4cd65: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_cd7cc176cbed4c8187ef65c993ef2c0c
  
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
    jmp while_b7c4fa0038444c97ac699efd7db4cd65 ; Reevaluate WHILE condition
  end_while_cd7cc176cbed4c8187ef65c993ef2c0c: ; END of while_b7c4fa0038444c97ac699efd7db4cd65
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  call func_4172656E6146726565_e418dc0fc94e4350b99a79689af02598_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_end
  func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_start:
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
  if_21a40f23a5f14c5ba023d91446d2259c: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jbe end_if_de1a394ade154a6ebac5a678cb803a3a
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_end
  end_if_de1a394ade154a6ebac5a678cb803a3a: ; END of if_21a40f23a5f14c5ba023d91446d2259c
  
  if_e81141a0e5a143b3966060e2d8de16a6: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_40fcceea03b640c696c302321c5a8135
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_end
  end_if_40fcceea03b640c696c302321c5a8135: ; END of if_e81141a0e5a143b3966060e2d8de16a6
  
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
  if_ac54311d1254400e9dbca5bbf08b217a: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_3b110129bafe498b88df1cc951b6f57c
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_end
  end_if_3b110129bafe498b88df1cc951b6f57c: ; END of if_ac54311d1254400e9dbca5bbf08b217a
  
  if_149bd668a460474d8edf2b8d8663e859: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_57c52f2975ad401ea424359d18c4ba08
  
  if_1ecf6efcb3c1467abdf67fb20e158962: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    je end_if_0875b31d593b487ca629448f76f0d4c4
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_end
  end_if_0875b31d593b487ca629448f76f0d4c4: ; END of if_1ecf6efcb3c1467abdf67fb20e158962
  
  mov rax, 0x0000000000000008
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp end_else_e185718ae0f74562937a0a21216e8f9f     ; Jump over ELSE part
  end_if_57c52f2975ad401ea424359d18c4ba08:    ; if_149bd668a460474d8edf2b8d8663e859 END
  else_7c636890eba14267917abf590dd2e36f:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  call func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  if_ccde3f5aa8f145d28b194325474fe6fb: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_06e924e0934f44b4a81fa1ff1ffe6ac6
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_end
  end_if_06e924e0934f44b4a81fa1ff1ffe6ac6: ; END of if_ccde3f5aa8f145d28b194325474fe6fb
  
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
  if_69e0c8bb25c04832bffca7082a3adf06: ; IF start
  pop rax
    test rax, rax
    je end_if_cc666366a11a4ab49fc848f6fb58476d
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_end
  end_if_cc666366a11a4ab49fc848f6fb58476d: ; END of if_69e0c8bb25c04832bffca7082a3adf06
  
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
  if_755006d5955f4379a1c8d76264a3374f: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jb end_if_8602bafbe2a241eeab35308729fd824f
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_end
  end_if_8602bafbe2a241eeab35308729fd824f: ; END of if_755006d5955f4379a1c8d76264a3374f
  
  end_else_e185718ae0f74562937a0a21216e8f9f: ; END of else_7c636890eba14267917abf590dd2e36f
  
  while_8f8c763de1194700af53f6dc086f51be: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_d96e5b0c3d4d4a5b9fac03cd5d77c8d5
  
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
    jmp while_8f8c763de1194700af53f6dc086f51be ; Reevaluate WHILE condition
  end_while_d96e5b0c3d4d4a5b9fac03cd5d77c8d5: ; END of while_8f8c763de1194700af53f6dc086f51be
  
  if_96e4708616be49b3abd69f70731f9b5b: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_b2c3bc0dca0d4f3a93a626751a14de29
  
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61416C6C6F63_bf803c06d3354771a2f73fddbf667738_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp end_else_0077cc773ab1443a94491a683bfcd6ce     ; Jump over ELSE part
  end_if_b2c3bc0dca0d4f3a93a626751a14de29:    ; if_96e4708616be49b3abd69f70731f9b5b END
  else_54de3018c66240e78a623096fb062c53:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_start
    add rsp, 24
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_else_0077cc773ab1443a94491a683bfcd6ce: ; END of else_54de3018c66240e78a623096fb062c53
  
  if_5e630c707f2e455d9227a0b8484fafeb: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_190e467b69d24d688ffaa0421c24524f
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_end
  end_if_190e467b69d24d688ffaa0421c24524f: ; END of if_5e630c707f2e455d9227a0b8484fafeb
  
  while_c47062966b8e4dd29789b9f3a4047d1a: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_00d997d0d8a94408ae9fe74bc262e2a1
  
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
  if_d741ba7b094a4933b633471c625f45c6: ; IF start
  mov rcx, 97
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    jb end_if_48b2cdeb8d534ca5a0d42197b553ffcb
  
  if_c2256056b3754c2c9d93e267cfc2530a: ; IF start
  mov rcx, 122
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    ja end_if_d58f058130bd461a8bec9d714d2e7524
  
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
  end_if_d58f058130bd461a8bec9d714d2e7524: ; END of if_c2256056b3754c2c9d93e267cfc2530a
  
  end_if_48b2cdeb8d534ca5a0d42197b553ffcb: ; END of if_d741ba7b094a4933b633471c625f45c6
  
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
    jmp while_c47062966b8e4dd29789b9f3a4047d1a ; Reevaluate WHILE condition
  end_while_00d997d0d8a94408ae9fe74bc262e2a1: ; END of while_c47062966b8e4dd29789b9f3a4047d1a
  
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
    
    jmp func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_end
  func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6154657374_da0b384aa8d74ae5827bb15db4940e39_start:
  push rbp
    mov rbp, rsp
  sub rsp, 128
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
  mov rax, 0x0000000000000000
    mov qword [rbp - 96], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 104], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 112], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 120], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 128], rax
  if_cc6409d8f4604653b001b1f01b07c5d5: ; IF start
  mov rcx, 192
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jae end_if_e3e67b2e99524c08aed1b4d6d80fca0e
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6154657374_da0b384aa8d74ae5827bb15db4940e39_end
  end_if_e3e67b2e99524c08aed1b4d6d80fca0e: ; END of if_cc6409d8f4604653b001b1f01b07c5d5
  
  mov rax, qword [rbp + 40]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
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
    
    mov qword [rbp - 16], rax
  if_ee762a1f82694f1baf25c3076c0fbcf6: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_19292e9224ca4199b76b74dcd6d89861
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6154657374_da0b384aa8d74ae5827bb15db4940e39_end
  end_if_19292e9224ca4199b76b74dcd6d89861: ; END of if_ee762a1f82694f1baf25c3076c0fbcf6
  
  if_81681f7659a541029e0fa94752d4ff9a: ; IF start
  mov rcx, 512
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jbe end_if_99918140c7634357abef8aace7249784
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6154657374_da0b384aa8d74ae5827bb15db4940e39_end
  end_if_99918140c7634357abef8aace7249784: ; END of if_81681f7659a541029e0fa94752d4ff9a
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, 0x0000000000000030
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x00000000000000C0
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  if_eab031a7c4ba441ea2ac403bf4617e10: ; IF start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    je end_if_5da012faf82640878c1d33fab017c2de
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6154657374_da0b384aa8d74ae5827bb15db4940e39_end
  end_if_5da012faf82640878c1d33fab017c2de: ; END of if_eab031a7c4ba441ea2ac403bf4617e10
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x00000000000000A0
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 16]
    push rax
  mov rax, 0x0000000000000030
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
    
    mov qword [rbp - 32], rax
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  call func_4172656E61496E6974_334337dfbd1e4e85ba3710b5c8c3e350_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  while_b8fb3556002b4aba96477784f8e9d8af: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_e6f1bc91847e46d0bd6d343a8ceff216
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x00000000000000A0
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 40]
    push rax
  mov rax, 0x0000000000000030
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
    
    mov qword [rbp - 48], rax
  mov rax, qword [rbp - 48]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 56], rax
  mov rax, qword [rbp - 48]
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
  mov rax, qword [rbp - 48]
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
    
    mov qword [rbp - 72], rax
  mov rax, qword [rbp - 48]
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
    
    mov qword [rbp - 80], rax
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_11fe27a89ce643f2bc4e1e1058ba26b9: ; IF start
  mov rcx, 16
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    jae end_if_b5c28c3e09814278953bda4bf63c1874
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 64]
    push rax
  mov rax, 0x0000000000000008
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
    
    mov qword [rbp - 96], rax
  mov rax, qword [rbp - 96]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 104], rax
  if_a4426e8ec7e54cf287fc212e30084766: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 104]
    cmp rax, rcx
    je end_if_be9dde7c2eed441ba92586ebae3449a2
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 104], rax
  end_if_be9dde7c2eed441ba92586ebae3449a2: ; END of if_a4426e8ec7e54cf287fc212e30084766
  
  if_9d09289339944fd9bb667a38369390b4: ; IF start
  mov rcx, 1
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_2c6f7fb12ee1499283f739a53e66403d
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  call func_4172656E61416C6C6F63_bf803c06d3354771a2f73fddbf667738_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_92f4f00189b54deabfea37d2ba376734: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    je end_if_09e69de3b69a43508aa20f3406c72917
  
  mov rax, qword [rbp - 96]
    push rax
  mov rax, qword [rbp - 88]
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 88]
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_09e69de3b69a43508aa20f3406c72917: ; END of if_92f4f00189b54deabfea37d2ba376734
  
  end_if_2c6f7fb12ee1499283f739a53e66403d: ; END of if_9d09289339944fd9bb667a38369390b4
  
  if_9319cb6f494e496daad5d7c8e6a0b574: ; IF start
  mov rcx, 2
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_f8c59079042a47d69fc7d27cdcf4a6ab
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  call func_4172656E61526573697A65_fc1aa0b7dd9149c08b153a25e6283423_start
    add rsp, 24
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_ecf832f145fa4d1d93816c2ecd32eede: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    je end_if_2b50df6cfe954bb3be0ebd5be891ef8d
  
  mov rax, qword [rbp - 96]
    push rax
  mov rax, qword [rbp - 88]
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 88]
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_2b50df6cfe954bb3be0ebd5be891ef8d: ; END of if_ecf832f145fa4d1d93816c2ecd32eede
  
  end_if_f8c59079042a47d69fc7d27cdcf4a6ab: ; END of if_9319cb6f494e496daad5d7c8e6a0b574
  
  if_36ec63ad84e04c1d9ea72693c3acc7a6: ; IF start
  mov rcx, 3
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_ddaa69ec24dc43df8cc3d0478e4724db
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  call func_4172656E6146726565_e418dc0fc94e4350b99a79689af02598_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_1869f0213531455d96fe64aa938d9667: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    je end_if_37ab67be026545c485654ae5f77f0cf9
  
  mov rax, qword [rbp - 96]
    push rax
  mov rax, 0x0000000000000000
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  end_if_37ab67be026545c485654ae5f77f0cf9: ; END of if_1869f0213531455d96fe64aa938d9667
  
  end_if_ddaa69ec24dc43df8cc3d0478e4724db: ; END of if_36ec63ad84e04c1d9ea72693c3acc7a6
  
  if_409985acc398404889007f372d7889b5: ; IF start
  mov rcx, 4
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_6b49130865874490bf08d8a01d14274b
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  call func_4172656E6150696E_a2d601d134e444e1b2ba7cd82457fbb1_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_6b49130865874490bf08d8a01d14274b: ; END of if_409985acc398404889007f372d7889b5
  
  if_08343c66b57f4aee8c83a71f4195afbe: ; IF start
  mov rcx, 5
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_0f7b6241b8a645e0969227e8a3d67dce
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  call func_4172656E61556E70696E_cd53ed29be1945979ce48ef3ec2db249_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_0f7b6241b8a645e0969227e8a3d67dce: ; END of if_08343c66b57f4aee8c83a71f4195afbe
  
  if_96fb2c71ea234a59a31da91c2b68df80: ; IF start
  mov rcx, 7
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_cf3abe70d9934368b218754652041627
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  call func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_f87d249b1c06458b931d06e51dd1f23d: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    je end_if_9f2053575e7a4462ab0985a477eec061
  
  mov rax, 0x0000000000000001
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_9f2053575e7a4462ab0985a477eec061: ; END of if_f87d249b1c06458b931d06e51dd1f23d
  
  end_if_cf3abe70d9934368b218754652041627: ; END of if_96fb2c71ea234a59a31da91c2b68df80
  
  if_53ae39a370204977958da95ae1d05758: ; IF start
  mov rcx, 6
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_f9dd433053d746d098d111f65bd4dd29
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  call func_4172656E6146696E64_2c4058ebf13e4be0b880899147228f9f_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 112], rax
  if_2cf84fd787bd40dc82579d5a76196081: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 112]
    cmp rax, rcx
    je end_if_b99b8c8806454a1fa150df58e65491e7
  
  mov rax, qword [rbp - 112]
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
    
    mov qword [rbp - 120], rax
  if_bce445cee0fd420c98744758a685a734: ; IF start
  mov rax, qword [rbp - 120]
    mov rcx, rax
    mov rax, qword [rbp - 72]
    cmp rax, rcx
    jae end_if_243574930ef84fcf993402da072db991
  
  mov rax, qword [rbp - 104]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 80]
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, 0x0000000000000001
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_243574930ef84fcf993402da072db991: ; END of if_bce445cee0fd420c98744758a685a734
  
  end_if_b99b8c8806454a1fa150df58e65491e7: ; END of if_2cf84fd787bd40dc82579d5a76196081
  
  end_if_f9dd433053d746d098d111f65bd4dd29: ; END of if_53ae39a370204977958da95ae1d05758
  
  if_3c2e6ce33799497cba9f1b82c3347abd: ; IF start
  mov rcx, 8
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_f9ebba5bf3de41f096ce5e3251ea453c
  
  mov rax, qword [rbp - 48]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 128], rax
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  mov rax, qword [rbp - 128]
    push rax
  mov rax, 0x0000000000000008
    push rax
  call func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_start
    add rsp, 40
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_648120966abe4cde99bda7bf19227f98: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    je end_if_2af36d44f709448e9fe3b0553f3a3f00
  
  mov rax, qword [rbp - 96]
    push rax
  mov rax, qword [rbp - 88]
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 88]
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_2af36d44f709448e9fe3b0553f3a3f00: ; END of if_648120966abe4cde99bda7bf19227f98
  
  end_if_f9ebba5bf3de41f096ce5e3251ea453c: ; END of if_3c2e6ce33799497cba9f1b82c3347abd
  
  end_if_b5c28c3e09814278953bda4bf63c1874: ; END of if_11fe27a89ce643f2bc4e1e1058ba26b9
  
  mov rax, qword [rbp - 48]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 88]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 48]
    push rax
  mov rax, 0x0000000000000028
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 32]
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
  pop rcx
    pop rax
    mov qword [rax], rcx
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
    jmp while_b8fb3556002b4aba96477784f8e9d8af ; Reevaluate WHILE condition
  end_while_e6f1bc91847e46d0bd6d343a8ceff216: ; END of while_b8fb3556002b4aba96477784f8e9d8af
  
  mov rax, qword [rbp + 40]
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
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 32]
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
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, 0x0000000000000001
    push rax
  pop rax
    
    jmp func_4172656E6154657374_da0b384aa8d74ae5827bb15db4940e39_end
  func_4172656E6154657374_da0b384aa8d74ae5827bb15db4940e39_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5465787447726F77_95986569652145159d93c15e6aa9a475_start:
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
  mov rax, 0x0000000000000000
    mov qword [rbp - 96], rax
  if_62eea7fa9e7d496188d4217441aea696: ; IF start
  mov rcx, 64
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jae end_if_d10ecbd6a76e42adb973cc668f84bc8c
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_95986569652145159d93c15e6aa9a475_end
  end_if_d10ecbd6a76e42adb973cc668f84bc8c: ; END of if_62eea7fa9e7d496188d4217441aea696
  
  mov rax, qword [rbp + 40]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
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
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp + 40]
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
  if_3aaab013ed9442ff8bfb32fd65560d5c: ; IF start
  mov rcx, 16384
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_d914ab86732746c7a546eafcb76cffa3
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_95986569652145159d93c15e6aa9a475_end
  end_if_d914ab86732746c7a546eafcb76cffa3: ; END of if_3aaab013ed9442ff8bfb32fd65560d5c
  
  if_30dcde894aaa4021960addc529bf05c8: ; IF start
  mov rcx, 32768
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jbe end_if_26b71d0a4d6f4c0cb7309ff2c3302f24
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_95986569652145159d93c15e6aa9a475_end
  end_if_26b71d0a4d6f4c0cb7309ff2c3302f24: ; END of if_30dcde894aaa4021960addc529bf05c8
  
  if_9218ef4ea7b046158e407f1520d25cf8: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jne end_if_d64fe50e4a834ad8bf9df21e9e7e0b87
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_95986569652145159d93c15e6aa9a475_end
  end_if_d64fe50e4a834ad8bf9df21e9e7e0b87: ; END of if_9218ef4ea7b046158e407f1520d25cf8
  
  if_cfc4bcbdc5564e919ac1f802ffd62b9e: ; IF start
  mov rcx, 256
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jbe end_if_99099cd15357441fa96a9767324dd3be
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_95986569652145159d93c15e6aa9a475_end
  end_if_99099cd15357441fa96a9767324dd3be: ; END of if_cfc4bcbdc5564e919ac1f802ffd62b9e
  
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000040
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_8970d43287424238a169901c01c466ef: ; IF start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    je end_if_25889a346f344b8abe4355d17480b4f6
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_95986569652145159d93c15e6aa9a475_end
  end_if_25889a346f344b8abe4355d17480b4f6: ; END of if_8970d43287424238a169901c01c466ef
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  mov rax, qword [rbp - 48]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  mov rax, qword [rbp - 40]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  call func_4172656E61496E6974_334337dfbd1e4e85ba3710b5c8c3e350_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  loop_50f1a9681ebe48a28ad315251172a87d: ; LOOP start
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp - 56]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 64], rax
  if_31571e8691324cdc8c4781ef56daf742: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    jbe end_if_ed3be821234f4860b0046f32d2039f5a
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 64], rax
  end_if_ed3be821234f4860b0046f32d2039f5a: ; END of if_31571e8691324cdc8c4781ef56daf742
  
  mov rax, qword [rbp - 40]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  mov rax, qword [rbp - 56]
    push rax
  mov rax, qword [rbp - 48]
    push rax
  mov rax, qword [rbp - 56]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 64]
    push rax
  call func_4172656E61417070656E645570706572_3c20a38e55b24409b4ce5ae5b044492d_start
    add rsp, 40
    push rax
  pop rax
    
    mov qword [rbp - 80], rax
  if_70b9d1c4d16a45718a16b835df84532c: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 80]
    cmp rax, rcx
    jne end_if_75b50598add845f2b76ef524b1cbb7f9
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0xFFFFFFFFFFFFFFFF
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, 0xFFFFFFFFFFFFFFFF
    push rax
  pop rax
    
    jmp func_5465787447726F77_95986569652145159d93c15e6aa9a475_end
  end_if_75b50598add845f2b76ef524b1cbb7f9: ; END of if_70b9d1c4d16a45718a16b835df84532c
  
  mov rax, qword [rbp - 80]
    push rax
  pop rax
    
    mov qword [rbp - 72], rax
  mov rax, qword [rbp - 56]
    push rax
  mov rax, qword [rbp - 64]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 56], rax
  if_2216ab6d6c9b4d599edd423a4749ecc5: ; IF start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_944c54411c0f481f887b910aa8d520dc
  
  jmp end_loop_cc232c3410644197808d0bbfb9af042d ; BREAK
  end_if_944c54411c0f481f887b910aa8d520dc: ; END of if_2216ab6d6c9b4d599edd423a4749ecc5
  
    jmp loop_50f1a9681ebe48a28ad315251172a87d ; LOOP: continue iteration
  end_loop_cc232c3410644197808d0bbfb9af042d: ; END of loop_50f1a9681ebe48a28ad315251172a87d
  
  while_4baacfb38b45452f95b3178e20b98c80: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 96]
    cmp rax, rcx
    jae end_while_a857f6f2757d4d7482e2950e2949c1ad
  
  mov rax, qword [rbp - 48]
    push rax
  mov rax, qword [rbp - 96]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 72]
    push rax
  mov rax, qword [rbp - 96]
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
  mov rax, qword [rbp - 96]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 96], rax
    jmp while_4baacfb38b45452f95b3178e20b98c80 ; Reevaluate WHILE condition
  end_while_a857f6f2757d4d7482e2950e2949c1ad: ; END of while_4baacfb38b45452f95b3178e20b98c80
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000018
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    jmp func_5465787447726F77_95986569652145159d93c15e6aa9a475_end
  func_5465787447726F77_95986569652145159d93c15e6aa9a475_end:
    mov rsp, rbp
    pop rbp
    ret
module_6172656E615F74657374_cc1aebb5c9a641358781bf22addde4cd_end:
section .text
global ubytec_host_contract_ArenaTest
ubytec_host_contract_ArenaTest:
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
call func_4172656E6154657374_da0b384aa8d74ae5827bb15db4940e39_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_TextGrow
ubytec_host_contract_TextGrow:
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
call func_5465787447726F77_95986569652145159d93c15e6aa9a475_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,65,114,101,110,97,84,101,115,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,84,101,115,116,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,84,101,120,116,71,114,111,119,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,84,101,120,116,71,114,111,119,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
