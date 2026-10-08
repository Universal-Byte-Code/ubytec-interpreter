module_6C696266745F737472696E67735F6E6174697665_61c41523fd4949e9a968fd08bbdb9426_start:
; Module: libft_strings_native v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 13:30:29Z
  ; Module UUID: 61c41523-fd49-49e9-a968-fd08bbdb9426


  section .bss

  section .text

  func_537472696E674C656E677468_63e5bb578c2e44c2b51a4ff9def19c56_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  loop_eac476db593143f9ab5c3a2f5683e38e: ; LOOP start
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
  pop rax
    
    mov qword [rbp - 16], rax
  if_42580099e557447b869d713a87161da4: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_eafb42fe38134f79b0d8709cccb265ec
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    jmp func_537472696E674C656E677468_63e5bb578c2e44c2b51a4ff9def19c56_end
  end_if_eafb42fe38134f79b0d8709cccb265ec: ; END of if_42580099e557447b869d713a87161da4
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp loop_eac476db593143f9ab5c3a2f5683e38e ; LOOP: continue iteration
  end_loop_fa46bfb0e8c24471b659c555fd1b6037: ; END of loop_eac476db593143f9ab5c3a2f5683e38e
  
  func_537472696E674C656E677468_63e5bb578c2e44c2b51a4ff9def19c56_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F7374726E6C656E_86cc19a6add2486893e585828af5a1b9_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  loop_688a11588149430185cdbf6324fffd56: ; LOOP start
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setae al
    movzx eax, al
    push rax
  if_6825592327f743bbb54627ee13cc88d7: ; IF start
  pop rax
    test rax, rax
    je end_if_2c5f8b269a39416d8d9e79fd6c6e7245
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    jmp func_66745F7374726E6C656E_86cc19a6add2486893e585828af5a1b9_end
  end_if_2c5f8b269a39416d8d9e79fd6c6e7245: ; END of if_6825592327f743bbb54627ee13cc88d7
  
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
  pop rax
    
    mov qword [rbp - 16], rax
  if_15863d3e665f4d97b4166250df16a22c: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_36632fb282144a0db012f62dfc5bda4d
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    jmp func_66745F7374726E6C656E_86cc19a6add2486893e585828af5a1b9_end
  end_if_36632fb282144a0db012f62dfc5bda4d: ; END of if_15863d3e665f4d97b4166250df16a22c
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp loop_688a11588149430185cdbf6324fffd56 ; LOOP: continue iteration
  end_loop_f0ee83e50f2342e6bde4edd58c659257: ; END of loop_688a11588149430185cdbf6324fffd56
  
  func_66745F7374726E6C656E_86cc19a6add2486893e585828af5a1b9_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F737472636872_fd37a3145d2f48568b499ae25f110f35_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  movsxd rax, dword [rbp + 16]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    and rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  loop_a5f1e872130c4aabab7d7169bdd00b1a: ; LOOP start
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
  pop rax
    
    mov qword [rbp - 16], rax
  if_8b32b55e20fe407daee64924f2d01cab: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_b8ce256d9ada46ceae5a228ec3382e81
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_66745F737472636872_fd37a3145d2f48568b499ae25f110f35_end
  end_if_b8ce256d9ada46ceae5a228ec3382e81: ; END of if_8b32b55e20fe407daee64924f2d01cab
  
  if_c777bcce07274dc782308f44a09ef50c: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_bc559cfbc7674e3f83f628d1a62b3746
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F737472636872_fd37a3145d2f48568b499ae25f110f35_end
  end_if_bc559cfbc7674e3f83f628d1a62b3746: ; END of if_c777bcce07274dc782308f44a09ef50c
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp loop_a5f1e872130c4aabab7d7169bdd00b1a ; LOOP: continue iteration
  end_loop_e4b80af3c39946cc8ed6170b1f170a99: ; END of loop_a5f1e872130c4aabab7d7169bdd00b1a
  
  func_66745F737472636872_fd37a3145d2f48568b499ae25f110f35_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F73747272636872_05053cfc461a43fbba1088f0d9393b79_start:
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
  movsxd rax, dword [rbp + 16]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    and rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  loop_e158aa96245d4de8b42fa450ae809ce8: ; LOOP start
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
  pop rax
    
    mov qword [rbp - 16], rax
  if_9c49753690fa47fca23b856761a6c636: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_6969f20c181944aabb98b62328d7bfa7
  
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_if_6969f20c181944aabb98b62328d7bfa7: ; END of if_9c49753690fa47fca23b856761a6c636
  
  if_62993380c84f4fa7af6aa79618985012: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_823ace402c044783bcac5095e6a55b2d
  
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_66745F73747272636872_05053cfc461a43fbba1088f0d9393b79_end
  end_if_823ace402c044783bcac5095e6a55b2d: ; END of if_62993380c84f4fa7af6aa79618985012
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp loop_e158aa96245d4de8b42fa450ae809ce8 ; LOOP: continue iteration
  end_loop_4a159544fbe946d3814784526183e141: ; END of loop_e158aa96245d4de8b42fa450ae809ce8
  
  func_66745F73747272636872_05053cfc461a43fbba1088f0d9393b79_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F6D656D636872_ea50238ea79b468cab728353299715bf_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  movsxd rax, dword [rbp + 24]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    and rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  loop_1d2935589fd64571bd2c89e89fd36766: ; LOOP start
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setae al
    movzx eax, al
    push rax
  if_f369d11e3bdd4b61ba197278a85b146b: ; IF start
  pop rax
    test rax, rax
    je end_if_dffe6b35cb6046298fe614836b81fd59
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F6D656D636872_ea50238ea79b468cab728353299715bf_end
  end_if_dffe6b35cb6046298fe614836b81fd59: ; END of if_f369d11e3bdd4b61ba197278a85b146b
  
  mov rax, qword [rbp + 32]
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
    
    mov qword [rbp - 16], rax
  if_818cdc848ef243c7a5aad5eeb58d40be: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_1de6c7cf99fa4f788dbaf13383f83ad5
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_66745F6D656D636872_ea50238ea79b468cab728353299715bf_end
  end_if_1de6c7cf99fa4f788dbaf13383f83ad5: ; END of if_818cdc848ef243c7a5aad5eeb58d40be
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp loop_1d2935589fd64571bd2c89e89fd36766 ; LOOP: continue iteration
  end_loop_f843a88fef43430dad0bb89ab96a74bb: ; END of loop_1d2935589fd64571bd2c89e89fd36766
  
  func_66745F6D656D636872_ea50238ea79b468cab728353299715bf_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F7374726E636D70_174064a0267c4814a61d04135b3dcb49_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  loop_a9158e28a47d43eea2fb7821e142e3ab: ; LOOP start
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setae al
    movzx eax, al
    push rax
  if_25e882d218284147b37b058db1ee4c60: ; IF start
  pop rax
    test rax, rax
    je end_if_437ddacba38f4decadfcaaa13107201c
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F7374726E636D70_174064a0267c4814a61d04135b3dcb49_end
  end_if_437ddacba38f4decadfcaaa13107201c: ; END of if_25e882d218284147b37b058db1ee4c60
  
  mov rax, qword [rbp + 32]
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
    
    mov qword [rbp - 16], rax
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
  pop rax
    
    mov qword [rbp - 24], rax
  if_75cf42fceb974121bb38f93909f35f52: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    je end_if_35ade806d5b141768b99ba7db1c18be6
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F7374726E636D70_174064a0267c4814a61d04135b3dcb49_end
  end_if_35ade806d5b141768b99ba7db1c18be6: ; END of if_75cf42fceb974121bb38f93909f35f52
  
  if_443bdd1d0e78459e90e851dc929c4049: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_89a457de831e4547b7b1d6df0fbde43c
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    movsxd rax, eax
    jmp func_66745F7374726E636D70_174064a0267c4814a61d04135b3dcb49_end
  end_if_89a457de831e4547b7b1d6df0fbde43c: ; END of if_443bdd1d0e78459e90e851dc929c4049
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp loop_a9158e28a47d43eea2fb7821e142e3ab ; LOOP: continue iteration
  end_loop_f7c4aea5372c4a67a236b2ce819c77e0: ; END of loop_a9158e28a47d43eea2fb7821e142e3ab
  
  func_66745F7374726E636D70_174064a0267c4814a61d04135b3dcb49_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F7374726C637079_f67a1583dc5749b7aa089435775ac34c_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  mov rax, qword [rbp + 24]
    push rax
  call func_537472696E674C656E677468_63e5bb578c2e44c2b51a4ff9def19c56_start
    add rsp, 8
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_ab914f8ee17b46c2b2af7eff622e0c0f: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_4bd0daf5d3b444f9a89751577c416675
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    jmp func_66745F7374726C637079_f67a1583dc5749b7aa089435775ac34c_end
  end_if_4bd0daf5d3b444f9a89751577c416675: ; END of if_ab914f8ee17b46c2b2af7eff622e0c0f
  
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    dec rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    seta al
    movzx eax, al
    push rax
  if_99148e9ba9cf4bbfa863f2848aafddef: ; IF start
  pop rax
    test rax, rax
    je end_if_4aa04d5f02234490996ef2cb341d7e8a
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  end_if_4aa04d5f02234490996ef2cb341d7e8a: ; END of if_99148e9ba9cf4bbfa863f2848aafddef
  
  while_bdefbefe2d8f4629a71b23d3d51ca4f6: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_bdbc96f17ce84555b598db67f773d065
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 24]
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
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp while_bdefbefe2d8f4629a71b23d3d51ca4f6 ; Reevaluate WHILE condition
  end_while_bdbc96f17ce84555b598db67f773d065: ; END of while_bdefbefe2d8f4629a71b23d3d51ca4f6
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 16]
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
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    jmp func_66745F7374726C637079_f67a1583dc5749b7aa089435775ac34c_end
  func_66745F7374726C637079_f67a1583dc5749b7aa089435775ac34c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F7374726C636174_7fa621fe3c48418281600d581127584c_start:
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
  call func_537472696E674C656E677468_63e5bb578c2e44c2b51a4ff9def19c56_start
    add rsp, 8
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_66745F7374726E6C656E_86cc19a6add2486893e585828af5a1b9_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  if_a9e1986cadb64c919fa6239352c6d58f: ; IF start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_ed7d2d6832bc4c0787adc2636ffc9c1c
  
  mov rax, qword [rbp + 16]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_66745F7374726C636174_7fa621fe3c48418281600d581127584c_end
  end_if_ed7d2d6832bc4c0787adc2636ffc9c1c: ; END of if_a9e1986cadb64c919fa6239352c6d58f
  
  mov rax, qword [rbp + 16]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    dec rax
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    seta al
    movzx eax, al
    push rax
  if_56d429e1489e4a78aaaf9dbdf7780a3d: ; IF start
  pop rax
    test rax, rax
    je end_if_189618e7b5f4496fa9034f1f6fdbc3a3
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  end_if_189618e7b5f4496fa9034f1f6fdbc3a3: ; END of if_56d429e1489e4a78aaaf9dbdf7780a3d
  
  while_65fd17628a124295956eeeb243598f04: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jae end_while_cfa8e05197cb4c77abc4c2610e6b50c1
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 16]
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
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 32]
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
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp while_65fd17628a124295956eeeb243598f04 ; Reevaluate WHILE condition
  end_while_cfa8e05197cb4c77abc4c2610e6b50c1: ; END of while_65fd17628a124295956eeeb243598f04
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 16]
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
  mov rax, 0x0000000000000000
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_66745F7374726C636174_7fa621fe3c48418281600d581127584c_end
  func_66745F7374726C636174_7fa621fe3c48418281600d581127584c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F7374726E737472_0219e9cee1fd439c872a365f70e31e3f_start:
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
  mov rax, qword [rbp + 24]
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  if_a8b4e6853b644c11b54bc6f2a8763907: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jne end_if_fe5728d0e12843898e2ad7a55a5b37d8
  
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    
    jmp func_66745F7374726E737472_0219e9cee1fd439c872a365f70e31e3f_end
  end_if_fe5728d0e12843898e2ad7a55a5b37d8: ; END of if_a8b4e6853b644c11b54bc6f2a8763907
  
  loop_ec230c58fd8649f28b953cbbdee1d2d0: ; LOOP start
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setae al
    movzx eax, al
    push rax
  if_209937f2f8a54bf9a53da0c11d4f599f: ; IF start
  pop rax
    test rax, rax
    je end_if_eb6b1f7881ec43808b9c7d41bd18efb3
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F7374726E737472_0219e9cee1fd439c872a365f70e31e3f_end
  end_if_eb6b1f7881ec43808b9c7d41bd18efb3: ; END of if_209937f2f8a54bf9a53da0c11d4f599f
  
  mov rax, qword [rbp + 32]
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
    
    mov qword [rbp - 32], rax
  if_623d10b59be14d909c73770f11a066ab: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_87a6fb65198e4815b12438de8e9f43bd
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F7374726E737472_0219e9cee1fd439c872a365f70e31e3f_end
  end_if_87a6fb65198e4815b12438de8e9f43bd: ; END of if_623d10b59be14d909c73770f11a066ab
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  loop_71a9d02f55294aca9c2f3dc4e5cbdbf2: ; LOOP start
  mov rax, qword [rbp + 24]
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
  pop rax
    
    mov qword [rbp - 40], rax
  if_11f5b1a06d394e75b59a73a16ef92008: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jne end_if_b3d2dc2e52fe4af09a2b8a12c0790858
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_66745F7374726E737472_0219e9cee1fd439c872a365f70e31e3f_end
  end_if_b3d2dc2e52fe4af09a2b8a12c0790858: ; END of if_11f5b1a06d394e75b59a73a16ef92008
  
  mov rax, qword [rbp - 8]
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
  mov rax, qword [rbp + 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setae al
    movzx eax, al
    push rax
  if_03c7b144cb074148b4827b4f9e103cf4: ; IF start
  pop rax
    test rax, rax
    je end_if_26bd4dad12e94471b54a22aab3df530c
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F7374726E737472_0219e9cee1fd439c872a365f70e31e3f_end
  end_if_26bd4dad12e94471b54a22aab3df530c: ; END of if_03c7b144cb074148b4827b4f9e103cf4
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_48bf9ed869114611b0a543c45af1bd60: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_41990bf4f38945adb7eb1c53eb7b7a2e
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F7374726E737472_0219e9cee1fd439c872a365f70e31e3f_end
  end_if_41990bf4f38945adb7eb1c53eb7b7a2e: ; END of if_48bf9ed869114611b0a543c45af1bd60
  
  if_0982645ebefa452595a955606ddd226b: ; IF start
  mov rax, qword [rbp - 40]
    mov rcx, rax
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    je end_if_306bba156d5944beb40c9dcbb79687c4
  
  jmp end_loop_12006c5e412f468baa80ee463146843b ; BREAK
  end_if_306bba156d5944beb40c9dcbb79687c4: ; END of if_0982645ebefa452595a955606ddd226b
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
    jmp loop_71a9d02f55294aca9c2f3dc4e5cbdbf2 ; LOOP: continue iteration
  end_loop_12006c5e412f468baa80ee463146843b: ; END of loop_71a9d02f55294aca9c2f3dc4e5cbdbf2
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp loop_ec230c58fd8649f28b953cbbdee1d2d0 ; LOOP: continue iteration
  end_loop_3ebe73daa9aa43108219b63e78525db2: ; END of loop_ec230c58fd8649f28b953cbbdee1d2d0
  
  func_66745F7374726E737472_0219e9cee1fd439c872a365f70e31e3f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61496E6974_6f4a5d15b4054aae8c68dc6f4f3a1f12_start:
  push rbp
    mov rbp, rsp
  if_78ef2f8114be4364a32506d404486ff6: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_e581947de8b84f95841c6910b3fe903d
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61496E6974_6f4a5d15b4054aae8c68dc6f4f3a1f12_end
  end_if_e581947de8b84f95841c6910b3fe903d: ; END of if_78ef2f8114be4364a32506d404486ff6
  
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
    
    jmp func_4172656E61496E6974_6f4a5d15b4054aae8c68dc6f4f3a1f12_end
  func_4172656E61496E6974_6f4a5d15b4054aae8c68dc6f4f3a1f12_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146696E64_b399bcc1d9f04d439e87599152f0a683_start:
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
  while_aa37e92e86d44f4e86fe565eaaa7f12b: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_4339506d39ac4ca096fdf372ad3dc04d
  
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
  if_13428f7653824923bc8e1e231fa141fc: ; IF start
  pop rax
    test rax, rax
    je end_if_4ff6a31365b8412f8c4757cf42c2ac53
  
    jmp end_else_d5c2115dcfee44cdae13faefb0944869     ; Jump over ELSE part
  end_if_4ff6a31365b8412f8c4757cf42c2ac53:    ; if_13428f7653824923bc8e1e231fa141fc END
  else_1eb349052f9e465e9b98970e62badb86:  ; Start ELSE block
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
  if_81d19f55c0534650ac7baf2fe5304bf8: ; IF start
  pop rax
    test rax, rax
    je end_if_9cfc41b108ab476ca648dcc92ed63d2b
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_b399bcc1d9f04d439e87599152f0a683_end
  end_if_9cfc41b108ab476ca648dcc92ed63d2b: ; END of if_81d19f55c0534650ac7baf2fe5304bf8
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_b399bcc1d9f04d439e87599152f0a683_end
  end_else_d5c2115dcfee44cdae13faefb0944869: ; END of else_1eb349052f9e465e9b98970e62badb86
  
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
    jmp while_aa37e92e86d44f4e86fe565eaaa7f12b ; Reevaluate WHILE condition
  end_while_4339506d39ac4ca096fdf372ad3dc04d: ; END of while_aa37e92e86d44f4e86fe565eaaa7f12b
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_b399bcc1d9f04d439e87599152f0a683_end
  func_4172656E6146696E64_b399bcc1d9f04d439e87599152f0a683_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_start:
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
  if_57ea8f37e06644dd8a34ae4a9923838c: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_4eedb53ab0b440ccbb09bdcd8b168c7d
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_end
  end_if_4eedb53ab0b440ccbb09bdcd8b168c7d: ; END of if_57ea8f37e06644dd8a34ae4a9923838c
  
  if_bc865c51228548ab8907d6ba1d7c7bc2: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_760e094249d040179702372d2777121c
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_end
  end_if_760e094249d040179702372d2777121c: ; END of if_bc865c51228548ab8907d6ba1d7c7bc2
  
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
  while_c0beaae7fa6f4931b9c68af5a60a7587: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_2e816aaf07ad45f993981fd407320fc2
  
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
  if_4d0c30c8f2e34f169bece4372e9136fb: ; IF start
  pop rax
    test rax, rax
    je end_if_57570400b40542889aff2e0e848ff060
  
    jmp end_else_26de601116ff421a806fadcd9344c257     ; Jump over ELSE part
  end_if_57570400b40542889aff2e0e848ff060:    ; if_4d0c30c8f2e34f169bece4372e9136fb END
  else_3fb1f103dc9742e8ba79d7e358753256:  ; Start ELSE block
  if_1867d8ca2af249db91a7b07d397f0548: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jb end_if_b40d2abf355b47e3a8bd74d960379789
  
  jmp end_while_2e816aaf07ad45f993981fd407320fc2 ; BREAK
  end_if_b40d2abf355b47e3a8bd74d960379789: ; END of if_1867d8ca2af249db91a7b07d397f0548
  
  end_else_26de601116ff421a806fadcd9344c257: ; END of else_3fb1f103dc9742e8ba79d7e358753256
  
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
    jmp while_c0beaae7fa6f4931b9c68af5a60a7587 ; Reevaluate WHILE condition
  end_while_2e816aaf07ad45f993981fd407320fc2: ; END of while_c0beaae7fa6f4931b9c68af5a60a7587
  
  if_3258cbf34bc144a88d16066ffd17fef4: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jne end_if_ce04f7024faa48e79d261f4ff35f7ecf
  
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
  if_a61433f39f214ec285be9bb3c67a9e6a: ; IF start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jbe end_if_f5f549aaf56948f991299653c551d70b
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_end
  end_if_f5f549aaf56948f991299653c551d70b: ; END of if_a61433f39f214ec285be9bb3c67a9e6a
  
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
    jmp end_else_6768f4e571894bc0864c9d6fdb4fbf6c     ; Jump over ELSE part
  end_if_ce04f7024faa48e79d261f4ff35f7ecf:    ; if_3258cbf34bc144a88d16066ffd17fef4 END
  else_b48ee9ca6ca14aee855d30379b389e84:  ; Start ELSE block
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
  if_83458b8e07a446309fde03277c68e77b: ; IF start
  mov rax, qword [rbp - 64]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jb end_if_d8dae553bc344e34a2586cebee57baec
  
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
  end_if_d8dae553bc344e34a2586cebee57baec: ; END of if_83458b8e07a446309fde03277c68e77b
  
  end_else_6768f4e571894bc0864c9d6fdb4fbf6c: ; END of else_b48ee9ca6ca14aee855d30379b389e84
  
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
  while_84d97ca06a4446c48c734af289bf6151: ; WHILE start
  mov rax, qword [rbp - 40]
    mov rcx, rax
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jae end_while_c37d1a58d2ea4ec98cc75441661b1ebb
  
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
    jmp while_84d97ca06a4446c48c734af289bf6151 ; Reevaluate WHILE condition
  end_while_c37d1a58d2ea4ec98cc75441661b1ebb: ; END of while_84d97ca06a4446c48c734af289bf6151
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_end
  func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6150696E_5752051321b343f1af031a23116b6d0c_start:
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
  call func_4172656E6146696E64_b399bcc1d9f04d439e87599152f0a683_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_67498a7297db43de91ed4f408c2453d0: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_5faa97fc92ec488095489839d77defd9
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_5752051321b343f1af031a23116b6d0c_end
  end_if_5faa97fc92ec488095489839d77defd9: ; END of if_67498a7297db43de91ed4f408c2453d0
  
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
  if_4643574b6db6401bb07108a60db3d5ae: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jb end_if_7eb5d261f612420c8f7d6eadd4d320fd
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_5752051321b343f1af031a23116b6d0c_end
  end_if_7eb5d261f612420c8f7d6eadd4d320fd: ; END of if_4643574b6db6401bb07108a60db3d5ae
  
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
    
    jmp func_4172656E6150696E_5752051321b343f1af031a23116b6d0c_end
  func_4172656E6150696E_5752051321b343f1af031a23116b6d0c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61556E70696E_7caf5a48915e4e18b7a8aaaa9e376556_start:
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
  call func_4172656E6146696E64_b399bcc1d9f04d439e87599152f0a683_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_3eaac9088cd0401caaf8e6695bae5e0c: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_d60fcdaa8052420096905fbcb90fe551
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_7caf5a48915e4e18b7a8aaaa9e376556_end
  end_if_d60fcdaa8052420096905fbcb90fe551: ; END of if_3eaac9088cd0401caaf8e6695bae5e0c
  
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
  if_35cb44dd2fd9428aa54fae47f05f29e4: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_0fcf0201fc2e43f9979039ac0395afaf
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_7caf5a48915e4e18b7a8aaaa9e376556_end
  end_if_0fcf0201fc2e43f9979039ac0395afaf: ; END of if_35cb44dd2fd9428aa54fae47f05f29e4
  
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
    
    jmp func_4172656E61556E70696E_7caf5a48915e4e18b7a8aaaa9e376556_end
  func_4172656E61556E70696E_7caf5a48915e4e18b7a8aaaa9e376556_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146726565_e0be15c5942b4806b7257a2965f4abcf_start:
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
  call func_4172656E6146696E64_b399bcc1d9f04d439e87599152f0a683_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_5310575c935d4819a4b108e484f57755: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_e7d25211f6e14f7ab5cb2abeb4ef92df
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_e0be15c5942b4806b7257a2965f4abcf_end
  end_if_e7d25211f6e14f7ab5cb2abeb4ef92df: ; END of if_5310575c935d4819a4b108e484f57755
  
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
  if_1124ebe1039a449cb4b81781d83ac997: ; IF start
  pop rax
    test rax, rax
    je end_if_3c7e58b3d90b48c18c26f94f3994e844
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_e0be15c5942b4806b7257a2965f4abcf_end
  end_if_3c7e58b3d90b48c18c26f94f3994e844: ; END of if_1124ebe1039a449cb4b81781d83ac997
  
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
  while_11d7976f978f4e9c9da2e0ad2cc242c6: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_b12e83f287e94cbbaccffaf8249001b7
  
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
  if_eb25dc65a17848368eed884366ed67e3: ; IF start
  pop rax
    test rax, rax
    je end_if_3c27519280fa453a803ea1e9043a8aab
  
  mov rax, qword [rbp - 48]
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp end_else_8b4b0048983046f480a5b2d0094729bf     ; Jump over ELSE part
  end_if_3c27519280fa453a803ea1e9043a8aab:    ; if_eb25dc65a17848368eed884366ed67e3 END
  else_b70a03bc3309478c9a0aa962424f77cf:  ; Start ELSE block
  while_0587cf35048942e79824b9b59a3e0ef1: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    jae end_while_d9964060d4484f7e927c7e6eb93f7ad6
  
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
  if_88c36680776e4fe9b77c92249f02c852: ; IF start
  pop rax
    test rax, rax
    je end_if_62860d6a8b9b4469a54da6d69228c374
  
  jmp end_while_d9964060d4484f7e927c7e6eb93f7ad6 ; BREAK
  end_if_62860d6a8b9b4469a54da6d69228c374: ; END of if_88c36680776e4fe9b77c92249f02c852
  
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
    jmp while_0587cf35048942e79824b9b59a3e0ef1 ; Reevaluate WHILE condition
  end_while_d9964060d4484f7e927c7e6eb93f7ad6: ; END of while_0587cf35048942e79824b9b59a3e0ef1
  
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
  end_else_8b4b0048983046f480a5b2d0094729bf: ; END of else_b70a03bc3309478c9a0aa962424f77cf
  
  mov rax, qword [rbp - 48]
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp while_11d7976f978f4e9c9da2e0ad2cc242c6 ; Reevaluate WHILE condition
  end_while_b12e83f287e94cbbaccffaf8249001b7: ; END of while_11d7976f978f4e9c9da2e0ad2cc242c6
  
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
    
    jmp func_4172656E6146726565_e0be15c5942b4806b7257a2965f4abcf_end
  func_4172656E6146726565_e0be15c5942b4806b7257a2965f4abcf_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61526573697A65_c1d6d7cf5d2c4c58a4adf424c08cb40a_start:
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
  call func_4172656E6146696E64_b399bcc1d9f04d439e87599152f0a683_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_bdfba163b256400994e035ebaed511cc: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_0db07f0e3cb04a72976941600ddbb159
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_c1d6d7cf5d2c4c58a4adf424c08cb40a_end
  end_if_0db07f0e3cb04a72976941600ddbb159: ; END of if_bdfba163b256400994e035ebaed511cc
  
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
  if_63f0fd4a04c745c6a172e2ee596797e5: ; IF start
  pop rax
    test rax, rax
    je end_if_000b6a9aeee84eb7ba94a87c82185bc8
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_c1d6d7cf5d2c4c58a4adf424c08cb40a_end
  end_if_000b6a9aeee84eb7ba94a87c82185bc8: ; END of if_63f0fd4a04c745c6a172e2ee596797e5
  
  if_d65dbba7bf8348b1b7701e810ec2c685: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_c56a25297ce64219bbdc252cb1f02ce8
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_c1d6d7cf5d2c4c58a4adf424c08cb40a_end
  end_if_c56a25297ce64219bbdc252cb1f02ce8: ; END of if_d65dbba7bf8348b1b7701e810ec2c685
  
  if_56dd6e283780471cb9544d3884e1fa14: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_527054a9046143449c49de79e5e2dd22
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_c1d6d7cf5d2c4c58a4adf424c08cb40a_end
  end_if_527054a9046143449c49de79e5e2dd22: ; END of if_56dd6e283780471cb9544d3884e1fa14
  
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
  if_a57ae2c91a634ee6803ef6ecb471d198: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    ja end_if_cb0626f4585c498c88117c5be9cf1447
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  while_3dd12e5d6b6445ca9b9a87645675256f: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_4b2fadb7cdaf40399a2f371bfe48d7a1
  
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
    jmp while_3dd12e5d6b6445ca9b9a87645675256f ; Reevaluate WHILE condition
  end_while_4b2fadb7cdaf40399a2f371bfe48d7a1: ; END of while_3dd12e5d6b6445ca9b9a87645675256f
  
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
    
    jmp func_4172656E61526573697A65_c1d6d7cf5d2c4c58a4adf424c08cb40a_end
  end_if_cb0626f4585c498c88117c5be9cf1447: ; END of if_a57ae2c91a634ee6803ef6ecb471d198
  
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
  if_e8053de3126344699f86d36c6076fd4b: ; IF start
  mov rax, qword [rbp - 64]
    mov rcx, rax
    mov rax, qword [rbp - 72]
    cmp rax, rcx
    jne end_if_9263def807dd4e6188c852b498e985d3
  
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
  if_9407ae20643e4886a1043424d5e33114: ; IF start
  mov rax, qword [rbp - 88]
    mov rcx, rax
    mov rax, qword [rbp - 80]
    cmp rax, rcx
    ja end_if_d77a32a1931e42dcb6b9617d8b232591
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  while_6015196e9efe43d4a8d3f3d3d9fb82c7: ; WHILE start
  mov rax, qword [rbp - 56]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_045ea2a6133243d1809e17bd55593dcc
  
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
    jmp while_6015196e9efe43d4a8d3f3d3d9fb82c7 ; Reevaluate WHILE condition
  end_while_045ea2a6133243d1809e17bd55593dcc: ; END of while_6015196e9efe43d4a8d3f3d3d9fb82c7
  
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
    
    jmp func_4172656E61526573697A65_c1d6d7cf5d2c4c58a4adf424c08cb40a_end
  end_if_d77a32a1931e42dcb6b9617d8b232591: ; END of if_9407ae20643e4886a1043424d5e33114
  
  end_if_9263def807dd4e6188c852b498e985d3: ; END of if_e8053de3126344699f86d36c6076fd4b
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_4afd8f5b9e314bd1ae0041e263cf5aab: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_892c8e812bfc42b58e59b817fed1aa62
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_c1d6d7cf5d2c4c58a4adf424c08cb40a_end
  end_if_892c8e812bfc42b58e59b817fed1aa62: ; END of if_4afd8f5b9e314bd1ae0041e263cf5aab
  
  while_2bb164b17b5448239808013f68a807e0: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_fe3facec2cb242db9d3379754be3894c
  
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
    jmp while_2bb164b17b5448239808013f68a807e0 ; Reevaluate WHILE condition
  end_while_fe3facec2cb242db9d3379754be3894c: ; END of while_2bb164b17b5448239808013f68a807e0
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  call func_4172656E6146726565_e0be15c5942b4806b7257a2965f4abcf_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_c1d6d7cf5d2c4c58a4adf424c08cb40a_end
  func_4172656E61526573697A65_c1d6d7cf5d2c4c58a4adf424c08cb40a_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61417070656E645570706572_5133d3f4190a451a99b861ee69eefa11_start:
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
  if_8abc46d06f8e4d2bb8151342d0dd437f: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jbe end_if_8053c8206cef42c88d40de0e1bc475a6
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_5133d3f4190a451a99b861ee69eefa11_end
  end_if_8053c8206cef42c88d40de0e1bc475a6: ; END of if_8abc46d06f8e4d2bb8151342d0dd437f
  
  if_06b5230c2fd848458b49d5e50204e6e3: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_8704693f78454a2dbff04e08bb8e86e2
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_5133d3f4190a451a99b861ee69eefa11_end
  end_if_8704693f78454a2dbff04e08bb8e86e2: ; END of if_06b5230c2fd848458b49d5e50204e6e3
  
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
  if_4818aafd2c6a4946ac4c79c72426b948: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_e38d27e4b7bd4dbc93651750dac29462
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_5133d3f4190a451a99b861ee69eefa11_end
  end_if_e38d27e4b7bd4dbc93651750dac29462: ; END of if_4818aafd2c6a4946ac4c79c72426b948
  
  if_86f8f46f90cc436fa47c6b7e2c424e1c: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_7fd90912f6114f52959b13e3d7294980
  
  if_a940e4a59a7d4c86b69584a844f6bec9: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    je end_if_e7b1d303a89b4af5a65451640777db00
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_5133d3f4190a451a99b861ee69eefa11_end
  end_if_e7b1d303a89b4af5a65451640777db00: ; END of if_a940e4a59a7d4c86b69584a844f6bec9
  
  mov rax, 0x0000000000000008
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp end_else_cf7c8c1644d346a7baf2312ee42b5117     ; Jump over ELSE part
  end_if_7fd90912f6114f52959b13e3d7294980:    ; if_86f8f46f90cc436fa47c6b7e2c424e1c END
  else_3f642e47467c4ab5ae3b12ca6983785f:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  call func_4172656E6146696E64_b399bcc1d9f04d439e87599152f0a683_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  if_0482223300464cb8a928c4df5032ad63: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_a9439790a948482c89560d070db14d20
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_5133d3f4190a451a99b861ee69eefa11_end
  end_if_a9439790a948482c89560d070db14d20: ; END of if_0482223300464cb8a928c4df5032ad63
  
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
  if_e20b092d2e964b14a3b490cf766d7f3c: ; IF start
  pop rax
    test rax, rax
    je end_if_76d5cd53fb5b4f82a139aacc55d28e9a
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_5133d3f4190a451a99b861ee69eefa11_end
  end_if_76d5cd53fb5b4f82a139aacc55d28e9a: ; END of if_e20b092d2e964b14a3b490cf766d7f3c
  
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
  if_13bc285ca3fe4fe0bd618f923aa2c47e: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jb end_if_fb38f074050a422aa982e7faf74f8af9
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_5133d3f4190a451a99b861ee69eefa11_end
  end_if_fb38f074050a422aa982e7faf74f8af9: ; END of if_13bc285ca3fe4fe0bd618f923aa2c47e
  
  end_else_cf7c8c1644d346a7baf2312ee42b5117: ; END of else_3f642e47467c4ab5ae3b12ca6983785f
  
  while_1b0c5eebd9164cf4a0b46b4ce0b77f15: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_e93215953f9f41f6b2f27aaebcd2fc51
  
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
    jmp while_1b0c5eebd9164cf4a0b46b4ce0b77f15 ; Reevaluate WHILE condition
  end_while_e93215953f9f41f6b2f27aaebcd2fc51: ; END of while_1b0c5eebd9164cf4a0b46b4ce0b77f15
  
  if_f3fb12a7d4744daa87cfd4ec9d0c0601: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_00bda4fb6a4e416c84d377da1f5e9822
  
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp end_else_92176674acd54e438dbfcbdd2a775ed6     ; Jump over ELSE part
  end_if_00bda4fb6a4e416c84d377da1f5e9822:    ; if_f3fb12a7d4744daa87cfd4ec9d0c0601 END
  else_af550f4fb05b42898a98427d97d1d6f7:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61526573697A65_c1d6d7cf5d2c4c58a4adf424c08cb40a_start
    add rsp, 24
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_else_92176674acd54e438dbfcbdd2a775ed6: ; END of else_af550f4fb05b42898a98427d97d1d6f7
  
  if_7e5ebd2e9901464e9f9b8311b746b020: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_a572a658bf984292bdaa519bbbc5a51f
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_5133d3f4190a451a99b861ee69eefa11_end
  end_if_a572a658bf984292bdaa519bbbc5a51f: ; END of if_7e5ebd2e9901464e9f9b8311b746b020
  
  while_a19249a1622142f7815bbb4c43d8ed63: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_5b024deb715842a287b74d7b96ef8481
  
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
  if_5bacf1ae1e384bbe888a7eb6ea1cc269: ; IF start
  mov rcx, 97
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    jb end_if_32f6890505804066a2107d7693ca0967
  
  if_ce2c4a3e608b4cae9e7b1415d579207c: ; IF start
  mov rcx, 122
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    ja end_if_357c93bf935f42169b6a87fc9bfc52f2
  
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
  end_if_357c93bf935f42169b6a87fc9bfc52f2: ; END of if_ce2c4a3e608b4cae9e7b1415d579207c
  
  end_if_32f6890505804066a2107d7693ca0967: ; END of if_5bacf1ae1e384bbe888a7eb6ea1cc269
  
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
    jmp while_a19249a1622142f7815bbb4c43d8ed63 ; Reevaluate WHILE condition
  end_while_5b024deb715842a287b74d7b96ef8481: ; END of while_a19249a1622142f7815bbb4c43d8ed63
  
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
    
    jmp func_4172656E61417070656E645570706572_5133d3f4190a451a99b861ee69eefa11_end
  func_4172656E61417070656E645570706572_5133d3f4190a451a99b861ee69eefa11_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F7374726475705F6172656E61_a0bce292e6b74a4b9ab9751e62f339b7_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  mov rax, qword [rbp + 16]
    push rax
  call func_537472696E674C656E677468_63e5bb578c2e44c2b51a4ff9def19c56_start
    add rsp, 8
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000010000
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setae al
    movzx eax, al
    push rax
  if_7aeb02033d854cde98e8837f89cbab78: ; IF start
  pop rax
    test rax, rax
    je end_if_dea2be4673a74a78aa7cfbbef8453cb9
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F7374726475705F6172656E61_a0bce292e6b74a4b9ab9751e62f339b7_end
  end_if_dea2be4673a74a78aa7cfbbef8453cb9: ; END of if_7aeb02033d854cde98e8837f89cbab78
  
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  call func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  if_455a710093404548be8d85d419d05864: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_8afe47bc93344e748690c18b06908cb5
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F7374726475705F6172656E61_a0bce292e6b74a4b9ab9751e62f339b7_end
  end_if_8afe47bc93344e748690c18b06908cb5: ; END of if_455a710093404548be8d85d419d05864
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  call func_66745F7374726C637079_f67a1583dc5749b7aa089435775ac34c_start
    add rsp, 24
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_66745F7374726475705F6172656E61_a0bce292e6b74a4b9ab9751e62f339b7_end
  func_66745F7374726475705F6172656E61_a0bce292e6b74a4b9ab9751e62f339b7_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F7375627374725F6172656E61_ca98da5307ed430b81da7dc0b01ef167_start:
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
  mov rax, qword [rbp + 32]
    push rax
  call func_537472696E674C656E677468_63e5bb578c2e44c2b51a4ff9def19c56_start
    add rsp, 8
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setae al
    movzx eax, al
    push rax
  if_418a1623862848019a280e0b29bf3255: ; IF start
  pop rax
    test rax, rax
    je end_if_6afa191b987e4ccaaa9537b0d45d909f
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    mov qword [rbp + 16], rax
    jmp end_else_76b28bd392244790b9298e1bef3b5e48     ; Jump over ELSE part
  end_if_6afa191b987e4ccaaa9537b0d45d909f:    ; if_418a1623862848019a280e0b29bf3255 END
  else_a81d51f8dc3a478a9eb442df0d704d5e:  ; Start ELSE block
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  pop rcx
    pop rax
    sub rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp + 16]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    seta al
    movzx eax, al
    push rax
  if_5702a69ea9c34f68b779aafc62d744e8: ; IF start
  pop rax
    test rax, rax
    je end_if_f34803f7579c4893b1e2fd3497c17810
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    mov qword [rbp + 16], rax
  end_if_f34803f7579c4893b1e2fd3497c17810: ; END of if_5702a69ea9c34f68b779aafc62d744e8
  
  end_else_76b28bd392244790b9298e1bef3b5e48: ; END of else_a81d51f8dc3a478a9eb442df0d704d5e
  
  mov rax, qword [rbp + 16]
    push rax
  mov rax, 0x0000000000010000
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setae al
    movzx eax, al
    push rax
  if_278c5754ffe24ef88378c926e3509c2a: ; IF start
  pop rax
    test rax, rax
    je end_if_4851a7d4a9fe48a9ba1521e0021aa808
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F7375627374725F6172656E61_ca98da5307ed430b81da7dc0b01ef167_end
  end_if_4851a7d4a9fe48a9ba1521e0021aa808: ; END of if_278c5754ffe24ef88378c926e3509c2a
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  pop rax
    inc rax
    push rax
  call func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  if_0e0c95a92d2e423387909d5a4ccb70a2: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jne end_if_541e1ecf782d4f5e916fd41b0c1010a1
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F7375627374725F6172656E61_ca98da5307ed430b81da7dc0b01ef167_end
  end_if_541e1ecf782d4f5e916fd41b0c1010a1: ; END of if_0e0c95a92d2e423387909d5a4ccb70a2
  
  while_f211805b2edb4f3c8ca852899bfdfac0: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jae end_while_fa2fe78dfbfa4f039a385e6ae001d6bb
  
  mov rax, qword [rbp - 24]
    push rax
  mov rax, qword [rbp - 32]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
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
    movzx eax, byte [rax]
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp while_f211805b2edb4f3c8ca852899bfdfac0 ; Reevaluate WHILE condition
  end_while_fa2fe78dfbfa4f039a385e6ae001d6bb: ; END of while_f211805b2edb4f3c8ca852899bfdfac0
  
  mov rax, qword [rbp - 24]
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
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    jmp func_66745F7375627374725F6172656E61_ca98da5307ed430b81da7dc0b01ef167_end
  func_66745F7375627374725F6172656E61_ca98da5307ed430b81da7dc0b01ef167_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F7374726A6F696E5F6172656E61_f74642558c2e40a08ab646813e724b1d_start:
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
  mov rax, qword [rbp + 24]
    push rax
  call func_537472696E674C656E677468_63e5bb578c2e44c2b51a4ff9def19c56_start
    add rsp, 8
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  mov rax, qword [rbp + 16]
    push rax
  call func_537472696E674C656E677468_63e5bb578c2e44c2b51a4ff9def19c56_start
    add rsp, 8
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 8]
    push rax
  mov rax, 0x0000000000010000
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setae al
    movzx eax, al
    push rax
  if_5784504642d94891abad9704e72d2ae8: ; IF start
  pop rax
    test rax, rax
    je end_if_2e0a4bdc72974f7f947ea07ee8ca41cc
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F7374726A6F696E5F6172656E61_f74642558c2e40a08ab646813e724b1d_end
  end_if_2e0a4bdc72974f7f947ea07ee8ca41cc: ; END of if_5784504642d94891abad9704e72d2ae8
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, 0x0000000000010000
    push rax
  pop rcx
    pop rax
    cmp rax, rcx
    setae al
    movzx eax, al
    push rax
  if_0b972538261b48958ec1c444390b205d: ; IF start
  pop rax
    test rax, rax
    je end_if_4a6a0be530474de6b44442f75db4c7b6
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F7374726A6F696E5F6172656E61_f74642558c2e40a08ab646813e724b1d_end
  end_if_4a6a0be530474de6b44442f75db4c7b6: ; END of if_0b972538261b48958ec1c444390b205d
  
  mov rax, qword [rbp - 8]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_a42708a3bf124826ba3fcd381b6fe82e: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_c44b05f512fb4743b434517b1a371dcd
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_66745F7374726A6F696E5F6172656E61_f74642558c2e40a08ab646813e724b1d_end
  end_if_c44b05f512fb4743b434517b1a371dcd: ; END of if_a42708a3bf124826ba3fcd381b6fe82e
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_66745F7374726C637079_f67a1583dc5749b7aa089435775ac34c_start
    add rsp, 24
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, qword [rbp + 16]
    push rax
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    inc rax
    push rax
  call func_66745F7374726C637079_f67a1583dc5749b7aa089435775ac34c_start
    add rsp, 24
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_66745F7374726A6F696E5F6172656E61_f74642558c2e40a08ab646813e724b1d_end
  func_66745F7374726A6F696E5F6172656E61_f74642558c2e40a08ab646813e724b1d_end:
    mov rsp, rbp
    pop rbp
    ret
module_6C696266745F737472696E67735F6E6174697665_61c41523fd4949e9a968fd08bbdb9426_end:
section .text
global ubytec_host_contract_ft_strchr
ubytec_host_contract_ft_strchr:
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
call func_66745F737472636872_fd37a3145d2f48568b499ae25f110f35_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ft_strrchr
ubytec_host_contract_ft_strrchr:
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
call func_66745F73747272636872_05053cfc461a43fbba1088f0d9393b79_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ft_memchr
ubytec_host_contract_ft_memchr:
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
call func_66745F6D656D636872_ea50238ea79b468cab728353299715bf_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ft_strnlen
ubytec_host_contract_ft_strnlen:
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
call func_66745F7374726E6C656E_86cc19a6add2486893e585828af5a1b9_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ft_strncmp
ubytec_host_contract_ft_strncmp:
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
call func_66745F7374726E636D70_174064a0267c4814a61d04135b3dcb49_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ft_strlcpy
ubytec_host_contract_ft_strlcpy:
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
call func_66745F7374726C637079_f67a1583dc5749b7aa089435775ac34c_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ft_strlcat
ubytec_host_contract_ft_strlcat:
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
call func_66745F7374726C636174_7fa621fe3c48418281600d581127584c_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ft_strnstr
ubytec_host_contract_ft_strnstr:
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
call func_66745F7374726E737472_0219e9cee1fd439c872a365f70e31e3f_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ft_strdup_arena
ubytec_host_contract_ft_strdup_arena:
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
call func_66745F7374726475705F6172656E61_a0bce292e6b74a4b9ab9751e62f339b7_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ft_substr_arena
ubytec_host_contract_ft_substr_arena:
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
call func_66745F7375627374725F6172656E61_ca98da5307ed430b81da7dc0b01ef167_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ft_strjoin_arena
ubytec_host_contract_ft_strjoin_arena:
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
call func_66745F7374726A6F696E5F6172656E61_f74642558c2e40a08ab646813e724b1d_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
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
call func_4172656E61496E6974_6f4a5d15b4054aae8c68dc6f4f3a1f12_start
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
call func_4172656E61416C6C6F63_3350fe6c74814f88bd134eaed98a5e7b_start
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
call func_4172656E6146726565_e0be15c5942b4806b7257a2965f4abcf_start
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
call func_4172656E6150696E_5752051321b343f1af031a23116b6d0c_start
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
call func_4172656E61556E70696E_7caf5a48915e4e18b7a8aaaa9e376556_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,102,116,95,115,116,114,99,104,114,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,102,116,95,115,116,114,99,104,114,124,85,73,110,116,54,52,44,73,110,116,51,50,58,85,73,110,116,54,52,10,69,124,102,116,95,115,116,114,114,99,104,114,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,102,116,95,115,116,114,114,99,104,114,124,85,73,110,116,54,52,44,73,110,116,51,50,58,85,73,110,116,54,52,10,69,124,102,116,95,109,101,109,99,104,114,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,102,116,95,109,101,109,99,104,114,124,85,73,110,116,54,52,44,73,110,116,51,50,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,102,116,95,115,116,114,110,108,101,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,102,116,95,115,116,114,110,108,101,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,102,116,95,115,116,114,110,99,109,112,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,102,116,95,115,116,114,110,99,109,112,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,51,50,10,69,124,102,116,95,115,116,114,108,99,112,121,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,102,116,95,115,116,114,108,99,112,121,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,102,116,95,115,116,114,108,99,97,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,102,116,95,115,116,114,108,99,97,116,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,102,116,95,115,116,114,110,115,116,114,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,102,116,95,115,116,114,110,115,116,114,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,102,116,95,115,116,114,100,117,112,95,97,114,101,110,97,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,102,116,95,115,116,114,100,117,112,95,97,114,101,110,97,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,102,116,95,115,117,98,115,116,114,95,97,114,101,110,97,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,102,116,95,115,117,98,115,116,114,95,97,114,101,110,97,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,102,116,95,115,116,114,106,111,105,110,95,97,114,101,110,97,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,102,116,95,115,116,114,106,111,105,110,95,97,114,101,110,97,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,73,110,105,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,73,110,105,116,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,65,108,108,111,99,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,65,108,108,111,99,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,70,114,101,101,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,70,114,101,101,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,80,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,80,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,65,114,101,110,97,85,110,112,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,114,101,110,97,85,110,112,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
