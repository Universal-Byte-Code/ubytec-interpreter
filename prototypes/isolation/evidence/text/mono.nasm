module_746578745F6D6F6E6F_2e29c05eac084a75ad48eb9d06bd982c_start:
; Module: text_mono v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 09:10:59Z
  ; Module UUID: 2e29c05e-ac08-4a75-ad48-eb9d06bd982c


  section .bss

  section .text

  func_66745F69737370616365_217615ab981047de89c055097d1660bb_start:
  push rbp
    mov rbp, rsp
  if_e735a94d52e34f0f9ca4f900e8b79b29: ; IF start
  mov rcx, 32
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jne end_if_c652619c10f140d6b0da3de993d0ec63
  
  mov rax, 0x0000000000000001
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_217615ab981047de89c055097d1660bb_end
  end_if_c652619c10f140d6b0da3de993d0ec63: ; END of if_e735a94d52e34f0f9ca4f900e8b79b29
  
  if_8646c67272374317a15e38338fac8baf: ; IF start
  mov rcx, 9
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jge end_if_f53a8c1c68014f4986ae957d119bed9b
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_217615ab981047de89c055097d1660bb_end
  end_if_f53a8c1c68014f4986ae957d119bed9b: ; END of if_8646c67272374317a15e38338fac8baf
  
  if_7facc5f5761848c39117154d8c7fd9d5: ; IF start
  mov rcx, 13
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jle end_if_ae8a5ed283ba4a7f9a2bf81e787dd3db
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_217615ab981047de89c055097d1660bb_end
  end_if_ae8a5ed283ba4a7f9a2bf81e787dd3db: ; END of if_7facc5f5761848c39117154d8c7fd9d5
  
  mov rax, 0x0000000000000001
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_217615ab981047de89c055097d1660bb_end
  func_66745F69737370616365_217615ab981047de89c055097d1660bb_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F746F7570706572_df402677975a406eb0a9b2e2477a3652_start:
  push rbp
    mov rbp, rsp
  if_0494ba493e8f44f5b8270573ab775275: ; IF start
  mov rcx, 97
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jge end_if_49cf117c4d1c4a82a9058be99557a6dd
  
  movsxd rax, dword [rbp + 16]
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F746F7570706572_df402677975a406eb0a9b2e2477a3652_end
  end_if_49cf117c4d1c4a82a9058be99557a6dd: ; END of if_0494ba493e8f44f5b8270573ab775275
  
  if_9a618062b52f4c32a1e1bc4c1e6280ca: ; IF start
  mov rcx, 122
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jle end_if_04ce0592fd974df6aeb9eda6421e0d2f
  
  movsxd rax, dword [rbp + 16]
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F746F7570706572_df402677975a406eb0a9b2e2477a3652_end
  end_if_04ce0592fd974df6aeb9eda6421e0d2f: ; END of if_9a618062b52f4c32a1e1bc4c1e6280ca
  
  movsxd rax, dword [rbp + 16]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F746F7570706572_df402677975a406eb0a9b2e2477a3652_end
  func_66745F746F7570706572_df402677975a406eb0a9b2e2477a3652_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F6D656D637079_d4abc604892f43418763c1ca4f7bc5f9_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_3249d23e278e45dab9173ea8c45b6006: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_095168bb7ba44259aa03580b90ccc991
  
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
    jmp while_3249d23e278e45dab9173ea8c45b6006 ; Reevaluate WHILE condition
  end_while_095168bb7ba44259aa03580b90ccc991: ; END of while_3249d23e278e45dab9173ea8c45b6006
  
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    
    jmp func_66745F6D656D637079_d4abc604892f43418763c1ca4f7bc5f9_end
  func_66745F6D656D637079_d4abc604892f43418763c1ca4f7bc5f9_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5363616E4669656C6473_75577d8dc6834e8fb4337994e7cf1ed0_start:
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
  loop_87640abe9aa045568e60561479addf1c: ; LOOP start
  if_a94ee70bf23a4700ab5efd017bf21506: ; IF start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jb end_if_df2c3097df2d435584e274e153d66185
  
  jmp end_loop_4a98fb778fdc4ddd9a89c368fa8bd23b ; BREAK
  end_if_df2c3097df2d435584e274e153d66185: ; END of if_a94ee70bf23a4700ab5efd017bf21506
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  while_5610a3b4af204cf798dc5da72a3c927f: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_f8a6c8b598824d578ed5b5dde2e25f66
  
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
  if_b013f98d4ebd4db5a30f1495b228cbf2: ; IF start
  mov rcx, 44
    movsxd rax, dword [rbp - 40]
    cmp rax, rcx
    jne end_if_39a405b6ddcd4373a3bd1ae5ecdee675
  
  jmp end_while_f8a6c8b598824d578ed5b5dde2e25f66 ; BREAK
  end_if_39a405b6ddcd4373a3bd1ae5ecdee675: ; END of if_b013f98d4ebd4db5a30f1495b228cbf2
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_5610a3b4af204cf798dc5da72a3c927f ; Reevaluate WHILE condition
  end_while_f8a6c8b598824d578ed5b5dde2e25f66: ; END of while_5610a3b4af204cf798dc5da72a3c927f
  
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
  while_b682dc54ea2940c081460925fb4985cc: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_989f0b3c5c264419b7697a8e7ba357c6
  
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
  call func_66745F69737370616365_217615ab981047de89c055097d1660bb_start
    add rsp, 8
    push rax
  pop rax
    movsxd rax, eax
    mov qword [rbp - 48], rax
  if_acff1c6e402040e7b70b2d5589e0ca5f: ; IF start
  mov rcx, 0
    movsxd rax, dword [rbp - 48]
    cmp rax, rcx
    jne end_if_de47434daef4461e8306a64bc9818b47
  
  jmp end_while_989f0b3c5c264419b7697a8e7ba357c6 ; BREAK
  end_if_de47434daef4461e8306a64bc9818b47: ; END of if_acff1c6e402040e7b70b2d5589e0ca5f
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_b682dc54ea2940c081460925fb4985cc ; Reevaluate WHILE condition
  end_while_989f0b3c5c264419b7697a8e7ba357c6: ; END of while_b682dc54ea2940c081460925fb4985cc
  
  while_263e60e759b94db084f185846bc6d90a: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_a496e7d94723489eb174af01c98b3f60
  
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
  call func_66745F69737370616365_217615ab981047de89c055097d1660bb_start
    add rsp, 8
    push rax
  pop rax
    movsxd rax, eax
    mov qword [rbp - 48], rax
  if_b14bdb512a0d45108278812a6fd6c690: ; IF start
  mov rcx, 0
    movsxd rax, dword [rbp - 48]
    cmp rax, rcx
    jne end_if_4f4145a4599345b38cfe7cd8cb20d5e5
  
  jmp end_while_a496e7d94723489eb174af01c98b3f60 ; BREAK
  end_if_4f4145a4599345b38cfe7cd8cb20d5e5: ; END of if_b14bdb512a0d45108278812a6fd6c690
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    dec rax
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp while_263e60e759b94db084f185846bc6d90a ; Reevaluate WHILE condition
  end_while_a496e7d94723489eb174af01c98b3f60: ; END of while_263e60e759b94db084f185846bc6d90a
  
  if_6a737985b3e14b3dae2aea84462cf529: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_if_33df52b063244356b3606451aaf49f58
  
  if_755121fa3ed14972b7bb27dc08195b87: ; IF start
  mov rax, qword [rbp + 24]
    mov rcx, rax
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jb end_if_3e0903928d6843be9d7623abc6da951e
  
  mov rax, 0xFFFFFFFFFFFFFFF5
    push rax
  pop rax
    
    jmp func_5363616E4669656C6473_75577d8dc6834e8fb4337994e7cf1ed0_end
  end_if_3e0903928d6843be9d7623abc6da951e: ; END of if_755121fa3ed14972b7bb27dc08195b87
  
  if_454d3d93007f4767a85dd7356e7a1e02: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    je end_if_d915a8b7844e4f208d1d790e70f696d7
  
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
  end_if_d915a8b7844e4f208d1d790e70f696d7: ; END of if_454d3d93007f4767a85dd7356e7a1e02
  
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_if_33df52b063244356b3606451aaf49f58: ; END of if_6a737985b3e14b3dae2aea84462cf529
  
    jmp loop_87640abe9aa045568e60561479addf1c ; LOOP: continue iteration
  end_loop_4a98fb778fdc4ddd9a89c368fa8bd23b: ; END of loop_87640abe9aa045568e60561479addf1c
  
  if_60ef4e398ef5432b8aca583d6f63d729: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    je end_if_6d09e743e530437cbcdaa4f95e12afb9
  
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  end_if_6d09e743e530437cbcdaa4f95e12afb9: ; END of if_60ef4e398ef5432b8aca583d6f63d729
  
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_5363616E4669656C6473_75577d8dc6834e8fb4337994e7cf1ed0_end
  func_5363616E4669656C6473_75577d8dc6834e8fb4337994e7cf1ed0_end:
    mov rsp, rbp
    pop rbp
    ret
  func_50617273654669656C6473_6b7c100ed89249b28953b4f11b5004b1_start:
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
  call func_5363616E4669656C6473_75577d8dc6834e8fb4337994e7cf1ed0_start
    add rsp, 40
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_55c0db1de22545eab08d53a7508f5367: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jge end_if_288873cc88d54ac6a47fcb8067d847b8
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    jmp func_50617273654669656C6473_6b7c100ed89249b28953b4f11b5004b1_end
  end_if_288873cc88d54ac6a47fcb8067d847b8: ; END of if_55c0db1de22545eab08d53a7508f5367
  
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
  call func_5363616E4669656C6473_75577d8dc6834e8fb4337994e7cf1ed0_start
    add rsp, 40
    push rax
  pop rax
    
    jmp func_50617273654669656C6473_6b7c100ed89249b28953b4f11b5004b1_end
  func_50617273654669656C6473_6b7c100ed89249b28953b4f11b5004b1_end:
    mov rsp, rbp
    pop rbp
    ret
  func_557070657254657874_621ca925768e414eb3542c85f55798bc_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_ebc11d8e8d8e46b79f56af972aa4d8d3: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_1975ebb3b240489098e67931f244d91d
  
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
  call func_66745F746F7570706572_df402677975a406eb0a9b2e2477a3652_start
    add rsp, 8
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
    jmp while_ebc11d8e8d8e46b79f56af972aa4d8d3 ; Reevaluate WHILE condition
  end_while_1975ebb3b240489098e67931f244d91d: ; END of while_ebc11d8e8d8e46b79f56af972aa4d8d3
  
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_557070657254657874_621ca925768e414eb3542c85f55798bc_end
  func_557070657254657874_621ca925768e414eb3542c85f55798bc_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_start:
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
  if_075356c311664bee969a0662b2e1101e: ; IF start
  mov rcx, 32
    mov rax, qword [rbp + 24]
    cmp rax, rcx
    jae end_if_6be54f9749b942e19f6446b06f06df10
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_6be54f9749b942e19f6446b06f06df10: ; END of if_075356c311664bee969a0662b2e1101e
  
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
  if_841b87a6dfaa44148831072082dc2fa5: ; IF start
  mov rcx, 256
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jbe end_if_57a42bdec9854be397f143d9b29186e5
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_57a42bdec9854be397f143d9b29186e5: ; END of if_841b87a6dfaa44148831072082dc2fa5
  
  if_50517b62eb104aa3bdaded6cb7c15b7a: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_b6391da55cf446a8903ad4e2c2daf884
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_b6391da55cf446a8903ad4e2c2daf884: ; END of if_50517b62eb104aa3bdaded6cb7c15b7a
  
  if_d132c88b51bc48018b6b3fc1844084c2: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jbe end_if_bedd22fb650d4a65875f1c0bde77eac0
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_bedd22fb650d4a65875f1c0bde77eac0: ; END of if_d132c88b51bc48018b6b3fc1844084c2
  
  if_ef6042b642fa4ef9bc4a7ec70a8956fa: ; IF start
  mov rax, qword [rbp - 32]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jbe end_if_dfe883358df44bf2be8dbefb1068110f
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_dfe883358df44bf2be8dbefb1068110f: ; END of if_ef6042b642fa4ef9bc4a7ec70a8956fa
  
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
  if_cd9168e89a424d02938a6df3efa09e99: ; IF start
  mov rax, qword [rbp + 24]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jbe end_if_d2269dfaeb05489e99526725f55d3927
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_d2269dfaeb05489e99526725f55d3927: ; END of if_cd9168e89a424d02938a6df3efa09e99
  
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
  if_d649246b3494430894289e35511828d8: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jbe end_if_b1f8c39f0d644d1ca03755ef555712ed
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_b1f8c39f0d644d1ca03755ef555712ed: ; END of if_d649246b3494430894289e35511828d8
  
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
  if_d5675226a02d42bc83b24e4191efe32e: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_be65264ec52343d19b735763fe064e83
  
  mov rax, 0xFFFFFFFFFFFFFFF4
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_be65264ec52343d19b735763fe064e83: ; END of if_d5675226a02d42bc83b24e4191efe32e
  
  if_d6ceef1504794072aa721af1c533e24e: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_c86fb0b7cda643b989a1fa090a8f789c
  
  mov rax, 0xFFFFFFFFFFFFFFF4
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_c86fb0b7cda643b989a1fa090a8f789c: ; END of if_d6ceef1504794072aa721af1c533e24e
  
  if_a2c9935119a44b0695c2d4474fde9fe3: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    je end_if_02891ad4fc3d49748faed63658f8b7ab
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    dec rax
    push rax
  pop rax
    
    mov qword [rbp - 56], rax
  end_if_02891ad4fc3d49748faed63658f8b7ab: ; END of if_a2c9935119a44b0695c2d4474fde9fe3
  
  while_3c041e34f51d41c688004453bbbd9701: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    jae end_while_82701abbd4ba4ebd895e5f88410c45af
  
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
  if_2333c7283ed243d890d13efcf8561eb2: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 72]
    cmp rax, rcx
    jbe end_if_850f5c194e524764975a76d7104d9d34
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_850f5c194e524764975a76d7104d9d34: ; END of if_2333c7283ed243d890d13efcf8561eb2
  
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
  if_83b9ca8a157e4e1a8de041949ab1e5bf: ; IF start
  mov rax, qword [rbp - 88]
    mov rcx, rax
    mov rax, qword [rbp - 80]
    cmp rax, rcx
    jbe end_if_6e09255ab5934372a951a21563beba75
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_6e09255ab5934372a951a21563beba75: ; END of if_83b9ca8a157e4e1a8de041949ab1e5bf
  
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
    jmp while_3c041e34f51d41c688004453bbbd9701 ; Reevaluate WHILE condition
  end_while_82701abbd4ba4ebd895e5f88410c45af: ; END of while_3c041e34f51d41c688004453bbbd9701
  
  if_8032507970fb4e4b93c2ab3edb415715: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jb end_if_2253c62ce22747009c3013dd3096dd0e
  
  mov rax, 0xFFFFFFFFFFFFFFF4
    push rax
  pop rax
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  end_if_2253c62ce22747009c3013dd3096dd0e: ; END of if_8032507970fb4e4b93c2ab3edb415715
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    mov qword [rbp - 64], rax
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  while_74408b0536ae4f3f930928b5de3e87ad: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    jae end_while_3f5aca69eebc4a369b7f97329a9d860e
  
  if_425fe01a205341a3a00c4d9ada5f977a: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    je end_if_d73af1eef6a54b51bffb1b90b7db5ed6
  
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
  end_if_d73af1eef6a54b51bffb1b90b7db5ed6: ; END of if_425fe01a205341a3a00c4d9ada5f977a
  
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
  call func_66745F6D656D637079_d4abc604892f43418763c1ca4f7bc5f9_start
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
    jmp while_74408b0536ae4f3f930928b5de3e87ad ; Reevaluate WHILE condition
  end_while_3f5aca69eebc4a369b7f97329a9d860e: ; END of while_74408b0536ae4f3f930928b5de3e87ad
  
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
    
    jmp func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end
  func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_end:
    mov rsp, rbp
    pop rbp
    ret
  func_52756E54657874_8bd2407632434ff4846ff920f8cd2186_start:
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
  mov rax, qword [rbp + 56]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 32]
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
    
    mov qword [rbp - 8], rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp + 56]
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
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 56]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp + 56]
    push rax
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  call func_50617273654669656C6473_6b7c100ed89249b28953b4f11b5004b1_start
    add rsp, 32
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_16688187efcb4b85a66a8c9f19f2acc5: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jge end_if_5b1a25c2e0e241aea8acf0fe6b2ae4c0
  
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_52756E54657874_8bd2407632434ff4846ff920f8cd2186_end
  end_if_5b1a25c2e0e241aea8acf0fe6b2ae4c0: ; END of if_16688187efcb4b85a66a8c9f19f2acc5
  
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  call func_557070657254657874_621ca925768e414eb3542c85f55798bc_start
    add rsp, 24
    push rax
  add rsp, 8
  if_fcc5d95cbe88409eb590775c21425c4c: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    je end_if_d00fc00c11f54b40b50f8014e4597800
  
  if_3454e47bd4da4e9896d19edad8bbfcd4: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_846668579b9c4324b32d32284d4c17aa
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_52756E54657874_8bd2407632434ff4846ff920f8cd2186_end
  end_if_846668579b9c4324b32d32284d4c17aa: ; END of if_3454e47bd4da4e9896d19edad8bbfcd4
  
  mov rax, qword [rbp + 56]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 40]
    push rax
  pop rax
    inc rax
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  end_if_d00fc00c11f54b40b50f8014e4597800: ; END of if_fcc5d95cbe88409eb590775c21425c4c
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 56]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  call func_4275696C6454657874_13980f87e7154e4498b13301b0c372b4_start
    add rsp, 32
    push rax
  pop rax
    
    jmp func_52756E54657874_8bd2407632434ff4846ff920f8cd2186_end
  func_52756E54657874_8bd2407632434ff4846ff920f8cd2186_end:
    mov rsp, rbp
    pop rbp
    ret
  func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_start:
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
  if_147ad08cc9cf4785b5c0bb58b3bfbdc6: ; IF start
  mov rcx, 112
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jae end_if_5fd8c29b7048478f99de09160e76e848
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_end
  end_if_5fd8c29b7048478f99de09160e76e848: ; END of if_147ad08cc9cf4785b5c0bb58b3bfbdc6
  
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
  mov rax, qword [rbp + 24]
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
  mov rax, qword [rbp + 24]
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
  if_d8f67c48b842468abb8f08ec059a5973: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jbe end_if_4e5dca23a8914e99a56b457c60865da3
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_end
  end_if_4e5dca23a8914e99a56b457c60865da3: ; END of if_d8f67c48b842468abb8f08ec059a5973
  
  if_67e7362e3cab40799e8976c094064ac4: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_31fa7c773ced46998549c7bd7e2255ab
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_end
  end_if_31fa7c773ced46998549c7bd7e2255ab: ; END of if_67e7362e3cab40799e8976c094064ac4
  
  if_d4c5e17b2ca447c1b2863cfc491157fb: ; IF start
  mov rcx, 256
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jbe end_if_dc7d095d93584177b1f2fe6ead1eaa5c
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_end
  end_if_dc7d095d93584177b1f2fe6ead1eaa5c: ; END of if_d4c5e17b2ca447c1b2863cfc491157fb
  
  if_62ec9ce4b1a04d2e849f169ad5791ece: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jbe end_if_a7ea7d94cd58415dacc351ab7fae4732
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_end
  end_if_a7ea7d94cd58415dacc351ab7fae4732: ; END of if_62ec9ce4b1a04d2e849f169ad5791ece
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, 0x0000000000000002
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  mov rax, qword [rbp - 24]
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
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000070
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  if_a8f125d485774c129dba3c41a1c78459: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    je end_if_55795898ff4b423aba7bee0fa9a74f9c
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_end
  end_if_55795898ff4b423aba7bee0fa9a74f9c: ; END of if_a8f125d485774c129dba3c41a1c78459
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, 0x0000000000000040
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
    
    mov qword [rbp - 48], rax
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
  mov rax, qword [rbp - 24]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  if_7db3cde95add47d38a50d7b840141351: ; IF start
  pop rax
    test rax, rax
    je end_if_c6ec46204bbc41abb21e4b7d8ddc09d8
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_end
  end_if_c6ec46204bbc41abb21e4b7d8ddc09d8: ; END of if_7db3cde95add47d38a50d7b840141351
  
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
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  if_812b1543f2ad4a59b3c018819425ad78: ; IF start
  pop rax
    test rax, rax
    je end_if_103020bb096d4af49fa080008f90a206
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_end
  end_if_103020bb096d4af49fa080008f90a206: ; END of if_812b1543f2ad4a59b3c018819425ad78
  
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
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  if_e1ee674dc0c44ccdba37d47db7121972: ; IF start
  pop rax
    test rax, rax
    je end_if_363c59ebe01e4d9e838c3202cf798b2f
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_end
  end_if_363c59ebe01e4d9e838c3202cf798b2f: ; END of if_e1ee674dc0c44ccdba37d47db7121972
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_end
  func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4D6F6E6F_44b8dff44a8446d0b18e2027d072c202_start:
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
  if_195f562d0bbd432c8807626db140c244: ; IF start
  mov rcx, 64
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jae end_if_f0e0ecc7107c4ef1affeab3053a78fac
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_4D6F6E6F_44b8dff44a8446d0b18e2027d072c202_end
  end_if_f0e0ecc7107c4ef1affeab3053a78fac: ; END of if_195f562d0bbd432c8807626db140c244
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  call func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_7109f3259ce54912a3494e85961d92bd: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    jne end_if_8e0b674aed8744cc849a3fca4f839af6
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000040
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  mov rax, qword [rbp + 40]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
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
    
    mov qword [rbp - 48], rax
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
    
    mov qword [rbp - 56], rax
  mov rax, qword [rbp + 40]
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
    
    mov qword [rbp - 64], rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 56]
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
    
    mov qword [rbp - 72], rax
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  mov rax, qword [rbp - 72]
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 80], rax
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp - 40]
    push rax
  mov rax, qword [rbp - 56]
    push rax
  mov rax, qword [rbp - 64]
    push rax
  mov rax, 0x0000000000000000
    push rax
  call func_52756E54657874_8bd2407632434ff4846ff920f8cd2186_start
    add rsp, 48
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_8e0b674aed8744cc849a3fca4f839af6: ; END of if_7109f3259ce54912a3494e85961d92bd
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000030
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
  if_6a9e96d30f414381921d67f45247cf4f: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    jge end_if_2e9c80ed2dc944fc995ea83288764019
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000038
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
    jmp end_else_0332059567294233855564449247aac9     ; Jump over ELSE part
  end_if_2e9c80ed2dc944fc995ea83288764019:    ; if_6a9e96d30f414381921d67f45247cf4f END
  else_aa8c3df4cacc4739bf01fd8864ecb730:  ; Start ELSE block
  mov rax, qword [rbp + 40]
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
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000028
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000038
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
  end_else_0332059567294233855564449247aac9: ; END of else_aa8c3df4cacc4739bf01fd8864ecb730
  
  mov rax, qword [rbp - 88]
    push rax
  pop rax
    
    jmp func_4D6F6E6F_44b8dff44a8446d0b18e2027d072c202_end
  func_4D6F6E6F_44b8dff44a8446d0b18e2027d072c202_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4D6F6E6F436F7272757074_ba94032b046745c78f2ece00aa15b3f6_start:
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
  if_2310291f6b4a4a21b49530f0a0a4718f: ; IF start
  mov rcx, 64
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jae end_if_f49aea828b494cb2846b45fa93b8cdd5
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_4D6F6E6F436F7272757074_ba94032b046745c78f2ece00aa15b3f6_end
  end_if_f49aea828b494cb2846b45fa93b8cdd5: ; END of if_2310291f6b4a4a21b49530f0a0a4718f
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  call func_56616C696461746554657874_5708037d2f71430ba5663961757af9f6_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_85b6c41c2ede4bd6895f352e3f40ea5d: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    jne end_if_1af3e3e7da474bb7b5761b33fe864543
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000040
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  mov rax, qword [rbp + 40]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
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
    
    mov qword [rbp - 48], rax
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
    
    mov qword [rbp - 56], rax
  mov rax, qword [rbp + 40]
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
    
    mov qword [rbp - 64], rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 56]
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
    
    mov qword [rbp - 72], rax
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  mov rax, qword [rbp - 72]
    push rax
  mov rax, qword [rbp - 48]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 80], rax
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp - 40]
    push rax
  mov rax, qword [rbp - 56]
    push rax
  mov rax, qword [rbp - 64]
    push rax
  mov rax, 0x0000000000000001
    push rax
  call func_52756E54657874_8bd2407632434ff4846ff920f8cd2186_start
    add rsp, 48
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_1af3e3e7da474bb7b5761b33fe864543: ; END of if_85b6c41c2ede4bd6895f352e3f40ea5d
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000030
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
  if_349653eb3b11465e8c382c4dea94c9db: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    jge end_if_05e7352edf16449191d004a9bbbdd8f3
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000038
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
    jmp end_else_a6dbfa5d0bb94445a4b280d59d508d5e     ; Jump over ELSE part
  end_if_05e7352edf16449191d004a9bbbdd8f3:    ; if_349653eb3b11465e8c382c4dea94c9db END
  else_67493256ee234d7f82e5858c2191d159:  ; Start ELSE block
  mov rax, qword [rbp + 40]
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
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000028
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp + 40]
    push rax
  mov rax, 0x0000000000000038
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
  end_else_a6dbfa5d0bb94445a4b280d59d508d5e: ; END of else_67493256ee234d7f82e5858c2191d159
  
  mov rax, qword [rbp - 88]
    push rax
  pop rax
    
    jmp func_4D6F6E6F436F7272757074_ba94032b046745c78f2ece00aa15b3f6_end
  func_4D6F6E6F436F7272757074_ba94032b046745c78f2ece00aa15b3f6_end:
    mov rsp, rbp
    pop rbp
    ret
module_746578745F6D6F6E6F_2e29c05eac084a75ad48eb9d06bd982c_end:
section .text
global ubytec_host_contract_Mono
ubytec_host_contract_Mono:
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
call func_4D6F6E6F_44b8dff44a8446d0b18e2027d072c202_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_MonoCorrupt
ubytec_host_contract_MonoCorrupt:
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
call func_4D6F6E6F436F7272757074_ba94032b046745c78f2ece00aa15b3f6_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,77,111,110,111,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,77,111,110,111,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,77,111,110,111,67,111,114,114,117,112,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,77,111,110,111,67,111,114,114,117,112,116,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
