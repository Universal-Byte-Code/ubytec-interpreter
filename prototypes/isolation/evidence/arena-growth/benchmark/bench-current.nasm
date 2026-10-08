module_6172656E615F62656E6368_2d1ed8b0e5b34907830aa8aa6936da03_start:
; Module: arena_bench v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 12:18:31Z
  ; Module UUID: 2d1ed8b0-e5b3-4907-830a-a8aa6936da03


  section .bss

  section .text

  func_4172656E61496E6974_8d96f52304af4f99a3529ad90f181d87_start:
  push rbp
    mov rbp, rsp
  if_e377a062aa5b4ed09fa72ef07dc0efee: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_958cc1d6f22940729e1a4e10d0d729bb
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61496E6974_8d96f52304af4f99a3529ad90f181d87_end
  end_if_958cc1d6f22940729e1a4e10d0d729bb: ; END of if_e377a062aa5b4ed09fa72ef07dc0efee
  
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
    
    jmp func_4172656E61496E6974_8d96f52304af4f99a3529ad90f181d87_end
  func_4172656E61496E6974_8d96f52304af4f99a3529ad90f181d87_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146696E64_a4e3d0ef81a8485bafbbcf1618d576bd_start:
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
  while_613c3af786c048a092745090f122856b: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_78857e8de4514d30a3e637e03205f891
  
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
  if_b7e6ed211d264c159b4396ccd9b1eb3e: ; IF start
  pop rax
    test rax, rax
    je end_if_cc0d2be330be447c88ee18be689d36fe
  
    jmp end_else_05c5822106974bc5ba00abbea35f785e     ; Jump over ELSE part
  end_if_cc0d2be330be447c88ee18be689d36fe:    ; if_b7e6ed211d264c159b4396ccd9b1eb3e END
  else_91f7d998068c4926941dcb6495ae2a27:  ; Start ELSE block
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
  if_4dd2911950164d559fd5cdea3ec3f388: ; IF start
  pop rax
    test rax, rax
    je end_if_d3b4b508f2554aa48030cf695ed4fd3f
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_a4e3d0ef81a8485bafbbcf1618d576bd_end
  end_if_d3b4b508f2554aa48030cf695ed4fd3f: ; END of if_4dd2911950164d559fd5cdea3ec3f388
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_a4e3d0ef81a8485bafbbcf1618d576bd_end
  end_else_05c5822106974bc5ba00abbea35f785e: ; END of else_91f7d998068c4926941dcb6495ae2a27
  
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
    jmp while_613c3af786c048a092745090f122856b ; Reevaluate WHILE condition
  end_while_78857e8de4514d30a3e637e03205f891: ; END of while_613c3af786c048a092745090f122856b
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_a4e3d0ef81a8485bafbbcf1618d576bd_end
  func_4172656E6146696E64_a4e3d0ef81a8485bafbbcf1618d576bd_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61416C6C6F63_d8e31ca651024c50917a2ac565db9531_start:
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
  if_7c269bd6ff0e416982b135fb4c31ee31: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_fa68a5b99e2c45c19cc13ca531bc3f48
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_d8e31ca651024c50917a2ac565db9531_end
  end_if_fa68a5b99e2c45c19cc13ca531bc3f48: ; END of if_7c269bd6ff0e416982b135fb4c31ee31
  
  if_88ca8031f1364d99b89feb3733749734: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_f0d67e44505c4230b26258bbe2157b44
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_d8e31ca651024c50917a2ac565db9531_end
  end_if_f0d67e44505c4230b26258bbe2157b44: ; END of if_88ca8031f1364d99b89feb3733749734
  
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
  while_5329bbc765be419aa1da0342ea378bf6: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_95bfc6089c914cebabfb062514e558f6
  
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
  if_d202d1048bc4475e820db67cb58471fc: ; IF start
  pop rax
    test rax, rax
    je end_if_4eb2b6d88cd0475b89a8fa010605a3c6
  
    jmp end_else_7b6efdca48414fc3ae7b3a502d3a62db     ; Jump over ELSE part
  end_if_4eb2b6d88cd0475b89a8fa010605a3c6:    ; if_d202d1048bc4475e820db67cb58471fc END
  else_0f241eca8cb144ccab28c90ae739a445:  ; Start ELSE block
  if_2055bec12c6544ca8bd766954e9a8874: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jb end_if_4bc0a2113d084990b82fe3e8d218b9d1
  
  jmp end_while_95bfc6089c914cebabfb062514e558f6 ; BREAK
  end_if_4bc0a2113d084990b82fe3e8d218b9d1: ; END of if_2055bec12c6544ca8bd766954e9a8874
  
  end_else_7b6efdca48414fc3ae7b3a502d3a62db: ; END of else_0f241eca8cb144ccab28c90ae739a445
  
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
    jmp while_5329bbc765be419aa1da0342ea378bf6 ; Reevaluate WHILE condition
  end_while_95bfc6089c914cebabfb062514e558f6: ; END of while_5329bbc765be419aa1da0342ea378bf6
  
  if_904cb59872714330a37f5a40cf554bfa: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jne end_if_c4fa0b8872aa423aa37171375377774a
  
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
  if_8e676cebb8aa42fe84e8c3a21720466b: ; IF start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jbe end_if_c3e5ea41a65e4d90af15edaafc553221
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_d8e31ca651024c50917a2ac565db9531_end
  end_if_c3e5ea41a65e4d90af15edaafc553221: ; END of if_8e676cebb8aa42fe84e8c3a21720466b
  
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
    jmp end_else_c6f42a66f7ad4b7ea0e205a911e12d11     ; Jump over ELSE part
  end_if_c4fa0b8872aa423aa37171375377774a:    ; if_904cb59872714330a37f5a40cf554bfa END
  else_cd9213b144524ee7b986b210c9f8fac4:  ; Start ELSE block
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
  if_a7b7950727274b819d8f393a85f3fe8a: ; IF start
  mov rax, qword [rbp - 64]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jb end_if_309ffd25ec94420bbd3fb04031bde930
  
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
  end_if_309ffd25ec94420bbd3fb04031bde930: ; END of if_a7b7950727274b819d8f393a85f3fe8a
  
  end_else_c6f42a66f7ad4b7ea0e205a911e12d11: ; END of else_cd9213b144524ee7b986b210c9f8fac4
  
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
  while_966245112734452e913b2fba79844e52: ; WHILE start
  mov rax, qword [rbp - 40]
    mov rcx, rax
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jae end_while_a50128559de34cadbcea33194b313df5
  
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
    jmp while_966245112734452e913b2fba79844e52 ; Reevaluate WHILE condition
  end_while_a50128559de34cadbcea33194b313df5: ; END of while_966245112734452e913b2fba79844e52
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_d8e31ca651024c50917a2ac565db9531_end
  func_4172656E61416C6C6F63_d8e31ca651024c50917a2ac565db9531_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6150696E_f8aa890808d649ffa2f41dbc22935718_start:
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
  call func_4172656E6146696E64_a4e3d0ef81a8485bafbbcf1618d576bd_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_b48219894bd549a1a384495bada61b70: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_087caa8739e442149ae705d91ca2c73d
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_f8aa890808d649ffa2f41dbc22935718_end
  end_if_087caa8739e442149ae705d91ca2c73d: ; END of if_b48219894bd549a1a384495bada61b70
  
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
  if_5b0169f4164144139ed093b4c7e54633: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jb end_if_03614230d4764b3ead0edc3aca38ea8a
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_f8aa890808d649ffa2f41dbc22935718_end
  end_if_03614230d4764b3ead0edc3aca38ea8a: ; END of if_5b0169f4164144139ed093b4c7e54633
  
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
    
    jmp func_4172656E6150696E_f8aa890808d649ffa2f41dbc22935718_end
  func_4172656E6150696E_f8aa890808d649ffa2f41dbc22935718_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61556E70696E_4a0431025d3149c7a36cd865b2a1446f_start:
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
  call func_4172656E6146696E64_a4e3d0ef81a8485bafbbcf1618d576bd_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_3abeade410b24be1aa08bf0551c95318: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_a27a7179c1da4940af480fa55ad46440
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_4a0431025d3149c7a36cd865b2a1446f_end
  end_if_a27a7179c1da4940af480fa55ad46440: ; END of if_3abeade410b24be1aa08bf0551c95318
  
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
  if_39f34164d2b1483a97007177ba10d6d1: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_7a4d759a47a244a5bcd13a09258348ef
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_4a0431025d3149c7a36cd865b2a1446f_end
  end_if_7a4d759a47a244a5bcd13a09258348ef: ; END of if_39f34164d2b1483a97007177ba10d6d1
  
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
    
    jmp func_4172656E61556E70696E_4a0431025d3149c7a36cd865b2a1446f_end
  func_4172656E61556E70696E_4a0431025d3149c7a36cd865b2a1446f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146726565_5dd6e98e4b3f4a08b5ac78fe9a79a34d_start:
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
  call func_4172656E6146696E64_a4e3d0ef81a8485bafbbcf1618d576bd_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_7fceb8abd3b14a82baa4c84108bf8671: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_9db5b43a8fae408db0af00dfa4f14181
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_5dd6e98e4b3f4a08b5ac78fe9a79a34d_end
  end_if_9db5b43a8fae408db0af00dfa4f14181: ; END of if_7fceb8abd3b14a82baa4c84108bf8671
  
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
  if_7f228b5355d3471f9c2a0497ed97e9c5: ; IF start
  pop rax
    test rax, rax
    je end_if_772cbf67376f493d9f5d7c7dcaaa72ea
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_5dd6e98e4b3f4a08b5ac78fe9a79a34d_end
  end_if_772cbf67376f493d9f5d7c7dcaaa72ea: ; END of if_7f228b5355d3471f9c2a0497ed97e9c5
  
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
  while_a89ae30a6aef46c7b767aa765b4a834d: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_1da0a0779dce4210a4c484664c33cad5
  
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
  if_2d338c478f45407480e143f1c4eb38f8: ; IF start
  pop rax
    test rax, rax
    je end_if_43303b69fd3f47c7a2be902a872fc808
  
  mov rax, qword [rbp - 48]
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp end_else_b66c013373a244eba14a11af2cf27398     ; Jump over ELSE part
  end_if_43303b69fd3f47c7a2be902a872fc808:    ; if_2d338c478f45407480e143f1c4eb38f8 END
  else_22eae8132fcc4649853d2eb8e58110d9:  ; Start ELSE block
  while_8130135163f34e9c83f7175e7cacfaac: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    jae end_while_5d6b5ef69e304b4586ad4fff6096216f
  
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
  if_d03bc6c996c04aee9fc2ec0314237925: ; IF start
  pop rax
    test rax, rax
    je end_if_e1b6f548dec84a79b838390399044bd6
  
  jmp end_while_5d6b5ef69e304b4586ad4fff6096216f ; BREAK
  end_if_e1b6f548dec84a79b838390399044bd6: ; END of if_d03bc6c996c04aee9fc2ec0314237925
  
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
    jmp while_8130135163f34e9c83f7175e7cacfaac ; Reevaluate WHILE condition
  end_while_5d6b5ef69e304b4586ad4fff6096216f: ; END of while_8130135163f34e9c83f7175e7cacfaac
  
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
  end_else_b66c013373a244eba14a11af2cf27398: ; END of else_22eae8132fcc4649853d2eb8e58110d9
  
  mov rax, qword [rbp - 48]
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp while_a89ae30a6aef46c7b767aa765b4a834d ; Reevaluate WHILE condition
  end_while_1da0a0779dce4210a4c484664c33cad5: ; END of while_a89ae30a6aef46c7b767aa765b4a834d
  
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
    
    jmp func_4172656E6146726565_5dd6e98e4b3f4a08b5ac78fe9a79a34d_end
  func_4172656E6146726565_5dd6e98e4b3f4a08b5ac78fe9a79a34d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_start:
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
  call func_4172656E6146696E64_a4e3d0ef81a8485bafbbcf1618d576bd_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_d95fb7321e0a43f4a01552f755af4263: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_3d533942d2674f538b7cb655d93be52c
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_end
  end_if_3d533942d2674f538b7cb655d93be52c: ; END of if_d95fb7321e0a43f4a01552f755af4263
  
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
  if_8724492e40934b3fb01ecff52a450bce: ; IF start
  pop rax
    test rax, rax
    je end_if_9c97f4afbecf4b6b93d26add54cf1a73
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_end
  end_if_9c97f4afbecf4b6b93d26add54cf1a73: ; END of if_8724492e40934b3fb01ecff52a450bce
  
  if_79f6d8d34ccf4df48e0161bc5e8c68fc: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_2be273b296fa4eaeb641cce9c6c144e5
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_end
  end_if_2be273b296fa4eaeb641cce9c6c144e5: ; END of if_79f6d8d34ccf4df48e0161bc5e8c68fc
  
  if_8509a8847f024dc9bb9b4295594c1868: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_818ad3df8d794db793b251c62787e577
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_end
  end_if_818ad3df8d794db793b251c62787e577: ; END of if_8509a8847f024dc9bb9b4295594c1868
  
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
  if_18b3dd9527e64844ae46c65592788037: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    ja end_if_6d1862fbe9ad4c4d8fce6a441855e39d
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  while_74bc14b11fe64b28866e8dabc1f5f598: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_13b6af51d18d44b3ae6e499b07a63a6f
  
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
    jmp while_74bc14b11fe64b28866e8dabc1f5f598 ; Reevaluate WHILE condition
  end_while_13b6af51d18d44b3ae6e499b07a63a6f: ; END of while_74bc14b11fe64b28866e8dabc1f5f598
  
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
    
    jmp func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_end
  end_if_6d1862fbe9ad4c4d8fce6a441855e39d: ; END of if_18b3dd9527e64844ae46c65592788037
  
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
  if_867562bec6764998884c060b09157683: ; IF start
  mov rax, qword [rbp - 64]
    mov rcx, rax
    mov rax, qword [rbp - 72]
    cmp rax, rcx
    jne end_if_bbcf834a108e4b89a3f2a72971b93e49
  
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
  if_46b1ebee2e1f4a2184145982c48fa7d2: ; IF start
  mov rax, qword [rbp - 88]
    mov rcx, rax
    mov rax, qword [rbp - 80]
    cmp rax, rcx
    ja end_if_adb7a2a0e6ad42ad8a2cb0cf189cd677
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  while_b28cc53640404ee5b97a59d3f400fffc: ; WHILE start
  mov rax, qword [rbp - 56]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_40bdd342285546d290ecb06899e70cc3
  
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
    jmp while_b28cc53640404ee5b97a59d3f400fffc ; Reevaluate WHILE condition
  end_while_40bdd342285546d290ecb06899e70cc3: ; END of while_b28cc53640404ee5b97a59d3f400fffc
  
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
    
    jmp func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_end
  end_if_adb7a2a0e6ad42ad8a2cb0cf189cd677: ; END of if_46b1ebee2e1f4a2184145982c48fa7d2
  
  end_if_bbcf834a108e4b89a3f2a72971b93e49: ; END of if_867562bec6764998884c060b09157683
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_4172656E61416C6C6F63_d8e31ca651024c50917a2ac565db9531_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_2ad50d5d5b9645f3b363b7884e90738c: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_de8545b64fc145948bae54c3dd8ff0f7
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_end
  end_if_de8545b64fc145948bae54c3dd8ff0f7: ; END of if_2ad50d5d5b9645f3b363b7884e90738c
  
  while_52a3542ce52b4e40b63bc6c734567762: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_93aece3ffbbc4323970278adcd5212b9
  
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
    jmp while_52a3542ce52b4e40b63bc6c734567762 ; Reevaluate WHILE condition
  end_while_93aece3ffbbc4323970278adcd5212b9: ; END of while_52a3542ce52b4e40b63bc6c734567762
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  call func_4172656E6146726565_5dd6e98e4b3f4a08b5ac78fe9a79a34d_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_end
  func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_start:
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
  if_efadb261073b465cbdbeed57d6cfd7fc: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jbe end_if_275d832748f9471d8cabe044fb15b882
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_end
  end_if_275d832748f9471d8cabe044fb15b882: ; END of if_efadb261073b465cbdbeed57d6cfd7fc
  
  if_390d0f6e1048458a9edd8134c1e27ba5: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_5bbd5c461f714473a3139767c7d0293b
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_end
  end_if_5bbd5c461f714473a3139767c7d0293b: ; END of if_390d0f6e1048458a9edd8134c1e27ba5
  
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
  if_6b9cde63645d4cc2a91917c73871372b: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_c3a428b9adc54c5eab29344e8ae62867
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_end
  end_if_c3a428b9adc54c5eab29344e8ae62867: ; END of if_6b9cde63645d4cc2a91917c73871372b
  
  if_d8b3b3ac8d8b42efb1703d3d07df9d34: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_d3438b3140d24b19a67c63b9ca809977
  
  if_6d37330a7ed64e2083704f47eabd548f: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    je end_if_b0d14e40bd324cb58fe8b1a2a472b202
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_end
  end_if_b0d14e40bd324cb58fe8b1a2a472b202: ; END of if_6d37330a7ed64e2083704f47eabd548f
  
  mov rax, 0x0000000000000008
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp end_else_19a39503840148138750a7e539e67e80     ; Jump over ELSE part
  end_if_d3438b3140d24b19a67c63b9ca809977:    ; if_d8b3b3ac8d8b42efb1703d3d07df9d34 END
  else_dd12524572ac4f53bab96da9d6fc0d8e:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  call func_4172656E6146696E64_a4e3d0ef81a8485bafbbcf1618d576bd_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  if_694bc529826e41d692dc038cc741e14e: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_e9ac1cdbb5544a399123900dd18ca8a0
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_end
  end_if_e9ac1cdbb5544a399123900dd18ca8a0: ; END of if_694bc529826e41d692dc038cc741e14e
  
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
  if_eeb53e2918bf4275ae2d46b3ef5ed685: ; IF start
  pop rax
    test rax, rax
    je end_if_604b424b7aaa4f3bb63b75c21cfc1a33
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_end
  end_if_604b424b7aaa4f3bb63b75c21cfc1a33: ; END of if_eeb53e2918bf4275ae2d46b3ef5ed685
  
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
  if_588ecf5910214dd0afed9c3b9ca0b26c: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jb end_if_a62c64d3b7204891a2b591b97dc01b87
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_end
  end_if_a62c64d3b7204891a2b591b97dc01b87: ; END of if_588ecf5910214dd0afed9c3b9ca0b26c
  
  end_else_19a39503840148138750a7e539e67e80: ; END of else_dd12524572ac4f53bab96da9d6fc0d8e
  
  while_5b4c00130c9e4605a3dcc0bd72ceba88: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_ab1cd99f7b7742b19242668773a2d704
  
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
    jmp while_5b4c00130c9e4605a3dcc0bd72ceba88 ; Reevaluate WHILE condition
  end_while_ab1cd99f7b7742b19242668773a2d704: ; END of while_5b4c00130c9e4605a3dcc0bd72ceba88
  
  if_47ff52b127894e9f94e05a64bc2ebc12: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_90d200090c8f44dca21b4d2f6ceb6166
  
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61416C6C6F63_d8e31ca651024c50917a2ac565db9531_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp end_else_8b3c585cf2bd4e2b8c2e0069e8833e00     ; Jump over ELSE part
  end_if_90d200090c8f44dca21b4d2f6ceb6166:    ; if_47ff52b127894e9f94e05a64bc2ebc12 END
  else_152acd245f2142cf8fcbf204e42f19d8:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_start
    add rsp, 24
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_else_8b3c585cf2bd4e2b8c2e0069e8833e00: ; END of else_152acd245f2142cf8fcbf204e42f19d8
  
  if_2fce139ad65847e796c6b85fec011c33: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_e834d48a6c974cb9bae31b02d3f8e97e
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_end
  end_if_e834d48a6c974cb9bae31b02d3f8e97e: ; END of if_2fce139ad65847e796c6b85fec011c33
  
  while_f89c2b33cdc0454fb2bc7c0e91ae304c: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_2ee55928ec5e4ab9a74c437ae4f9885f
  
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
  if_7eef593e19cd42a08fda60458c3e6b44: ; IF start
  mov rcx, 97
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    jb end_if_f662b6b97a0e44859c07fae66110a430
  
  if_56c1ca8bc48047e2bace6a4ce82ad4d0: ; IF start
  mov rcx, 122
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    ja end_if_70ba95e8d2a1435e9b7070a225318f13
  
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
  end_if_70ba95e8d2a1435e9b7070a225318f13: ; END of if_56c1ca8bc48047e2bace6a4ce82ad4d0
  
  end_if_f662b6b97a0e44859c07fae66110a430: ; END of if_7eef593e19cd42a08fda60458c3e6b44
  
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
    jmp while_f89c2b33cdc0454fb2bc7c0e91ae304c ; Reevaluate WHILE condition
  end_while_2ee55928ec5e4ab9a74c437ae4f9885f: ; END of while_f89c2b33cdc0454fb2bc7c0e91ae304c
  
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
    
    jmp func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_end
  func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_end:
    mov rsp, rbp
    pop rbp
    ret
module_6172656E615F62656E6368_2d1ed8b0e5b34907830aa8aa6936da03_end:
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
call func_4172656E61496E6974_8d96f52304af4f99a3529ad90f181d87_start
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
call func_4172656E61416C6C6F63_d8e31ca651024c50917a2ac565db9531_start
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
call func_4172656E6146726565_5dd6e98e4b3f4a08b5ac78fe9a79a34d_start
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
call func_4172656E61526573697A65_a895250098ab42eab758ee73eb8b2992_start
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
call func_4172656E61417070656E645570706572_696a1805aff44830b7bd80c195b6f110_start
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
call func_4172656E6146696E64_a4e3d0ef81a8485bafbbcf1618d576bd_start
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
call func_4172656E6150696E_f8aa890808d649ffa2f41dbc22935718_start
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
call func_4172656E61556E70696E_4a0431025d3149c7a36cd865b2a1446f_start
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
