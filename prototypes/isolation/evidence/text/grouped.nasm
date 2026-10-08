module_746578745F67726F75706564_428b5a24ac4f4d2f90cf466ce3c6de84_start:
; Module: text_grouped v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 09:11:01Z
  ; Module UUID: 428b5a24-ac4f-4d2f-90cf-466ce3c6de84


  section .bss

  section .text

  func_66745F69737370616365_bceb69bbd22f4dd2b808004d7190575c_start:
  push rbp
    mov rbp, rsp
  if_05757d32b1b448b5807417276e41a395: ; IF start
  mov rcx, 32
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jne end_if_696628c35d704cb8a7b93eb9141da844
  
  mov rax, 0x0000000000000001
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_bceb69bbd22f4dd2b808004d7190575c_end
  end_if_696628c35d704cb8a7b93eb9141da844: ; END of if_05757d32b1b448b5807417276e41a395
  
  if_ca105b88e66e403aa14e851612853440: ; IF start
  mov rcx, 9
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jge end_if_ddaa7ffdf6bc40adb7ed900837152a0f
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_bceb69bbd22f4dd2b808004d7190575c_end
  end_if_ddaa7ffdf6bc40adb7ed900837152a0f: ; END of if_ca105b88e66e403aa14e851612853440
  
  if_ceb4b8393d334979b6df659ad3d675d3: ; IF start
  mov rcx, 13
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jle end_if_c1b23d4701644b77bf05f93cb5002556
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_bceb69bbd22f4dd2b808004d7190575c_end
  end_if_c1b23d4701644b77bf05f93cb5002556: ; END of if_ceb4b8393d334979b6df659ad3d675d3
  
  mov rax, 0x0000000000000001
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F69737370616365_bceb69bbd22f4dd2b808004d7190575c_end
  func_66745F69737370616365_bceb69bbd22f4dd2b808004d7190575c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F746F7570706572_4341111f8f9c4bf4b413cd566a80df24_start:
  push rbp
    mov rbp, rsp
  if_da5378eba0a94101bc00d30955a56ae3: ; IF start
  mov rcx, 97
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jge end_if_315a6888ccaf4566a3fbf1e1e7395994
  
  movsxd rax, dword [rbp + 16]
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F746F7570706572_4341111f8f9c4bf4b413cd566a80df24_end
  end_if_315a6888ccaf4566a3fbf1e1e7395994: ; END of if_da5378eba0a94101bc00d30955a56ae3
  
  if_5e37abec0ad04327875e70978854e14a: ; IF start
  mov rcx, 122
    movsxd rax, dword [rbp + 16]
    cmp rax, rcx
    jle end_if_7311b9042624431abb453966d6e7be61
  
  movsxd rax, dword [rbp + 16]
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F746F7570706572_4341111f8f9c4bf4b413cd566a80df24_end
  end_if_7311b9042624431abb453966d6e7be61: ; END of if_5e37abec0ad04327875e70978854e14a
  
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
    jmp func_66745F746F7570706572_4341111f8f9c4bf4b413cd566a80df24_end
  func_66745F746F7570706572_4341111f8f9c4bf4b413cd566a80df24_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F6D656D637079_43b33632438d47498ed83aa0092d883e_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_a650f03cbd814efe8e13b43275c5be86: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_e79145ccd20c4693a8627f51c04e3136
  
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
    jmp while_a650f03cbd814efe8e13b43275c5be86 ; Reevaluate WHILE condition
  end_while_e79145ccd20c4693a8627f51c04e3136: ; END of while_a650f03cbd814efe8e13b43275c5be86
  
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    
    jmp func_66745F6D656D637079_43b33632438d47498ed83aa0092d883e_end
  func_66745F6D656D637079_43b33632438d47498ed83aa0092d883e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5363616E4669656C6473_6684cb78eabb4673bf98aabe65826d0c_start:
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
  loop_e88630d93416496783cc3d8957174b0a: ; LOOP start
  if_07f93c194ac244cfa398443255ee70dd: ; IF start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jb end_if_833102ede03345e3a03045329746d959
  
  jmp end_loop_65947a0a717f43d990793c8a5229b2b0 ; BREAK
  end_if_833102ede03345e3a03045329746d959: ; END of if_07f93c194ac244cfa398443255ee70dd
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  while_d37511e5aa8d4acaa16fcabaf5c8fbd9: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_83594e78bd8c438787c4648d99c8c34b
  
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
  if_5dfba881eb0f4176b5f1be69dcb59f09: ; IF start
  mov rcx, 44
    movsxd rax, dword [rbp - 40]
    cmp rax, rcx
    jne end_if_d7c9e0235908435ab37a9d8ed31ee9a8
  
  jmp end_while_83594e78bd8c438787c4648d99c8c34b ; BREAK
  end_if_d7c9e0235908435ab37a9d8ed31ee9a8: ; END of if_5dfba881eb0f4176b5f1be69dcb59f09
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_d37511e5aa8d4acaa16fcabaf5c8fbd9 ; Reevaluate WHILE condition
  end_while_83594e78bd8c438787c4648d99c8c34b: ; END of while_d37511e5aa8d4acaa16fcabaf5c8fbd9
  
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
  while_27fa420bff764b419be2af99e1e13410: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_8531928152d342709dcc306d161d55c7
  
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
  call func_66745F69737370616365_bceb69bbd22f4dd2b808004d7190575c_start
    add rsp, 8
    push rax
  pop rax
    movsxd rax, eax
    mov qword [rbp - 48], rax
  if_e84f5e5da3be4cd5bd102ab21f9c60de: ; IF start
  mov rcx, 0
    movsxd rax, dword [rbp - 48]
    cmp rax, rcx
    jne end_if_77c6747be4c040cd8ff421c9d5534f81
  
  jmp end_while_8531928152d342709dcc306d161d55c7 ; BREAK
  end_if_77c6747be4c040cd8ff421c9d5534f81: ; END of if_e84f5e5da3be4cd5bd102ab21f9c60de
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp while_27fa420bff764b419be2af99e1e13410 ; Reevaluate WHILE condition
  end_while_8531928152d342709dcc306d161d55c7: ; END of while_27fa420bff764b419be2af99e1e13410
  
  while_ca892acbb0af45ffa5e5bfc96f006168: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_6f7ba70b21fa486cbfce5ad782f20603
  
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
  call func_66745F69737370616365_bceb69bbd22f4dd2b808004d7190575c_start
    add rsp, 8
    push rax
  pop rax
    movsxd rax, eax
    mov qword [rbp - 48], rax
  if_44831cfe6f024be1885c1bebef2e44fa: ; IF start
  mov rcx, 0
    movsxd rax, dword [rbp - 48]
    cmp rax, rcx
    jne end_if_e2f2c34bb0cc4f75b0fff713001a74ae
  
  jmp end_while_6f7ba70b21fa486cbfce5ad782f20603 ; BREAK
  end_if_e2f2c34bb0cc4f75b0fff713001a74ae: ; END of if_44831cfe6f024be1885c1bebef2e44fa
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    dec rax
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp while_ca892acbb0af45ffa5e5bfc96f006168 ; Reevaluate WHILE condition
  end_while_6f7ba70b21fa486cbfce5ad782f20603: ; END of while_ca892acbb0af45ffa5e5bfc96f006168
  
  if_5013fad0e3cb427fa540fb17ea475f72: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_if_2e03a05741fc439d879249ad01e5b32a
  
  if_94bc52a7c81b40a996285deb2bf3c10a: ; IF start
  mov rax, qword [rbp + 24]
    mov rcx, rax
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jb end_if_d7d1a5796be940ecbae167411f1b0bbf
  
  mov rax, 0xFFFFFFFFFFFFFFF5
    push rax
  pop rax
    
    jmp func_5363616E4669656C6473_6684cb78eabb4673bf98aabe65826d0c_end
  end_if_d7d1a5796be940ecbae167411f1b0bbf: ; END of if_94bc52a7c81b40a996285deb2bf3c10a
  
  if_def09b1f2d6d49dcbcc5ae4ef8dbf414: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    je end_if_679ebfbdcc0f49ff8c9c5ed75ff4766d
  
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
  end_if_679ebfbdcc0f49ff8c9c5ed75ff4766d: ; END of if_def09b1f2d6d49dcbcc5ae4ef8dbf414
  
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_if_2e03a05741fc439d879249ad01e5b32a: ; END of if_5013fad0e3cb427fa540fb17ea475f72
  
    jmp loop_e88630d93416496783cc3d8957174b0a ; LOOP: continue iteration
  end_loop_65947a0a717f43d990793c8a5229b2b0: ; END of loop_e88630d93416496783cc3d8957174b0a
  
  if_2ed70d690c0047e6a92c1131cd86a97f: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    je end_if_179609586ff14b6a898b4e4256af41c8
  
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  end_if_179609586ff14b6a898b4e4256af41c8: ; END of if_2ed70d690c0047e6a92c1131cd86a97f
  
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_5363616E4669656C6473_6684cb78eabb4673bf98aabe65826d0c_end
  func_5363616E4669656C6473_6684cb78eabb4673bf98aabe65826d0c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_50617273654669656C6473_39c939bcbbe04dfd8411322d3129918d_start:
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
  call func_5363616E4669656C6473_6684cb78eabb4673bf98aabe65826d0c_start
    add rsp, 40
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_f948c3908576418abbdafe788304c3a5: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jge end_if_9234ccfb2d0d4aecb88d709cf786b37c
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    jmp func_50617273654669656C6473_39c939bcbbe04dfd8411322d3129918d_end
  end_if_9234ccfb2d0d4aecb88d709cf786b37c: ; END of if_f948c3908576418abbdafe788304c3a5
  
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
  call func_5363616E4669656C6473_6684cb78eabb4673bf98aabe65826d0c_start
    add rsp, 40
    push rax
  pop rax
    
    jmp func_50617273654669656C6473_39c939bcbbe04dfd8411322d3129918d_end
  func_50617273654669656C6473_39c939bcbbe04dfd8411322d3129918d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_557070657254657874_b4f58d514ffb4935ac04f8e87949aff0_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_bff9cd405f2e4dcc8bd8de1ce49fa01d: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_39d756cb696845c1924d93ee00fd0c49
  
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
  call func_66745F746F7570706572_4341111f8f9c4bf4b413cd566a80df24_start
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
    jmp while_bff9cd405f2e4dcc8bd8de1ce49fa01d ; Reevaluate WHILE condition
  end_while_39d756cb696845c1924d93ee00fd0c49: ; END of while_bff9cd405f2e4dcc8bd8de1ce49fa01d
  
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    
    jmp func_557070657254657874_b4f58d514ffb4935ac04f8e87949aff0_end
  func_557070657254657874_b4f58d514ffb4935ac04f8e87949aff0_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_start:
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
  if_7939cbafe337418490217fd6449eaba2: ; IF start
  mov rcx, 32
    mov rax, qword [rbp + 24]
    cmp rax, rcx
    jae end_if_3b5df677dc834de88aa3ea2fbbc7da49
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_3b5df677dc834de88aa3ea2fbbc7da49: ; END of if_7939cbafe337418490217fd6449eaba2
  
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
  if_59fddd32b5554ee5ab140ae9c3670f7e: ; IF start
  mov rcx, 256
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jbe end_if_c54dd79308254c66999b41f9e9f6d983
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_c54dd79308254c66999b41f9e9f6d983: ; END of if_59fddd32b5554ee5ab140ae9c3670f7e
  
  if_2fde7d640d474d54bea803f01dee5a1c: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_41f3d638bff6473e8a07a20378204f0f
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_41f3d638bff6473e8a07a20378204f0f: ; END of if_2fde7d640d474d54bea803f01dee5a1c
  
  if_8c9c10d823b349daa2cce535ef2c8458: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jbe end_if_29419301ab8a4d8f80ee9d30c138fca4
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_29419301ab8a4d8f80ee9d30c138fca4: ; END of if_8c9c10d823b349daa2cce535ef2c8458
  
  if_abb7a2719a274a7ab88622a144d0f5f4: ; IF start
  mov rax, qword [rbp - 32]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jbe end_if_cc230d978edd4285b09830c24215ea53
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_cc230d978edd4285b09830c24215ea53: ; END of if_abb7a2719a274a7ab88622a144d0f5f4
  
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
  if_c8e1e70895cc40fb8de38e1b14461dfa: ; IF start
  mov rax, qword [rbp + 24]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jbe end_if_80d819c6e06b40c1bd707d8f014bb404
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_80d819c6e06b40c1bd707d8f014bb404: ; END of if_c8e1e70895cc40fb8de38e1b14461dfa
  
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
  if_74c97e99690e48b6ad97eeba0ef707ca: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jbe end_if_06e2f3ec316f4d1380d8139198dfd72d
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_06e2f3ec316f4d1380d8139198dfd72d: ; END of if_74c97e99690e48b6ad97eeba0ef707ca
  
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
  if_522cbbe9f35344d783551eecd3d295f2: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_4156fa5e4c214180ab94901c1e1cf4bc
  
  mov rax, 0xFFFFFFFFFFFFFFF4
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_4156fa5e4c214180ab94901c1e1cf4bc: ; END of if_522cbbe9f35344d783551eecd3d295f2
  
  if_519aa779731e47879e4c3214af7dadf6: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_77009e73c13c4bcd9455e645d2789533
  
  mov rax, 0xFFFFFFFFFFFFFFF4
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_77009e73c13c4bcd9455e645d2789533: ; END of if_519aa779731e47879e4c3214af7dadf6
  
  if_919dae4d1dd243c1aa660634e2d62818: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    je end_if_64a25b6e920342e984f2a59ec7af9122
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    dec rax
    push rax
  pop rax
    
    mov qword [rbp - 56], rax
  end_if_64a25b6e920342e984f2a59ec7af9122: ; END of if_919dae4d1dd243c1aa660634e2d62818
  
  while_955fe68d7a2a4b5e87decbc3bdabf0cd: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    jae end_while_cb2b568cdc71402ab24fe1d2ee2b79d6
  
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
  if_2205e7c4a0374672a9c9ce11a3d3965a: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 72]
    cmp rax, rcx
    jbe end_if_699563d64bf04aa0b3a00fbd349e475a
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_699563d64bf04aa0b3a00fbd349e475a: ; END of if_2205e7c4a0374672a9c9ce11a3d3965a
  
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
  if_e7e7cdb8478b4f70a6ddd37b520cc791: ; IF start
  mov rax, qword [rbp - 88]
    mov rcx, rax
    mov rax, qword [rbp - 80]
    cmp rax, rcx
    jbe end_if_8c84f61d53634b4c9c67abccfcb7b3b8
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_8c84f61d53634b4c9c67abccfcb7b3b8: ; END of if_e7e7cdb8478b4f70a6ddd37b520cc791
  
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
    jmp while_955fe68d7a2a4b5e87decbc3bdabf0cd ; Reevaluate WHILE condition
  end_while_cb2b568cdc71402ab24fe1d2ee2b79d6: ; END of while_955fe68d7a2a4b5e87decbc3bdabf0cd
  
  if_80365b4f087e4166b8f45c34c2efd608: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jb end_if_564a075f5f354981b60ac4abdf36384b
  
  mov rax, 0xFFFFFFFFFFFFFFF4
    push rax
  pop rax
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  end_if_564a075f5f354981b60ac4abdf36384b: ; END of if_80365b4f087e4166b8f45c34c2efd608
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    mov qword [rbp - 64], rax
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  while_9c7dae5b2b754973860b0be63578c623: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    jae end_while_57e68e3fe83544ad9a703ca1edc3913f
  
  if_ed536fc7f055441eaaf925db3e064ee7: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    je end_if_19956ef50cec4844ba7a92365470c800
  
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
  end_if_19956ef50cec4844ba7a92365470c800: ; END of if_ed536fc7f055441eaaf925db3e064ee7
  
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
  call func_66745F6D656D637079_43b33632438d47498ed83aa0092d883e_start
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
    jmp while_9c7dae5b2b754973860b0be63578c623 ; Reevaluate WHILE condition
  end_while_57e68e3fe83544ad9a703ca1edc3913f: ; END of while_9c7dae5b2b754973860b0be63578c623
  
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
    
    jmp func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end
  func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_end:
    mov rsp, rbp
    pop rbp
    ret
  func_52756E54657874_a3d333292d5645808e9310c616c75be0_start:
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
  call func_50617273654669656C6473_39c939bcbbe04dfd8411322d3129918d_start
    add rsp, 32
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_c7a8a848297248cb9aa5e26be1034acd: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jge end_if_8c988672ec314e46abbe0ddceb262bbc
  
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_52756E54657874_a3d333292d5645808e9310c616c75be0_end
  end_if_8c988672ec314e46abbe0ddceb262bbc: ; END of if_c7a8a848297248cb9aa5e26be1034acd
  
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  call func_557070657254657874_b4f58d514ffb4935ac04f8e87949aff0_start
    add rsp, 24
    push rax
  add rsp, 8
  if_e88a6d0d867241499a27f9c2096ae4af: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    je end_if_7f4b1844521d439983e5b5039d282a30
  
  if_bbded57e9cd7405096246d2a3e3c609a: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_5b2c3d360999431d91c1b5b13c6ab1ef
  
  mov rax, 0xFFFFFFFFFFFFFFF3
    push rax
  pop rax
    
    jmp func_52756E54657874_a3d333292d5645808e9310c616c75be0_end
  end_if_5b2c3d360999431d91c1b5b13c6ab1ef: ; END of if_bbded57e9cd7405096246d2a3e3c609a
  
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
  end_if_7f4b1844521d439983e5b5039d282a30: ; END of if_e88a6d0d867241499a27f9c2096ae4af
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 56]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  call func_4275696C6454657874_3924acc8e0f94cb39d02df0d8828f7bc_start
    add rsp, 32
    push rax
  pop rax
    
    jmp func_52756E54657874_a3d333292d5645808e9310c616c75be0_end
  func_52756E54657874_a3d333292d5645808e9310c616c75be0_end:
    mov rsp, rbp
    pop rbp
    ret
module_746578745F67726F75706564_428b5a24ac4f4d2f90cf466ce3c6de84_end:
section .text
global ubytec_host_contract_RunText
ubytec_host_contract_RunText:
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
push r8
push r9
call func_52756E54657874_a3d333292d5645808e9310c616c75be0_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,82,117,110,84,101,120,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,82,117,110,84,101,120,116,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
