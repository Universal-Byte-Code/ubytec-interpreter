module_6172656E615F74657374_b0272aa06d284f5eb0b08688e5512e6a_start:
; Module: arena_test v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 09:53:23Z
  ; Module UUID: b0272aa0-6d28-4f5e-b0b0-8688e5512e6a


  section .bss

  section .text

  func_4172656E61496E6974_a5df40c1b2f74683959449404238963f_start:
  push rbp
    mov rbp, rsp
  if_d0fdd1af01ed49b08ea716bae94bad9e: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_a523fe50ff6e411cbfb1bdfe50fbc8c2
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61496E6974_a5df40c1b2f74683959449404238963f_end
  end_if_a523fe50ff6e411cbfb1bdfe50fbc8c2: ; END of if_d0fdd1af01ed49b08ea716bae94bad9e
  
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
    
    jmp func_4172656E61496E6974_a5df40c1b2f74683959449404238963f_end
  func_4172656E61496E6974_a5df40c1b2f74683959449404238963f_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_start:
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
  while_d779952a20564533b5f58745128983f5: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jae end_while_88e73be1e84b445e8a6153bc5331c7c0
  
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
  if_f989912754de4b86922bc907433e21b2: ; IF start
  pop rax
    test rax, rax
    je end_if_ce98f2f6dc21400b93f040570e2676c4
  
    jmp end_else_3d6177774bf242adb40842fb34649c2d     ; Jump over ELSE part
  end_if_ce98f2f6dc21400b93f040570e2676c4:    ; if_f989912754de4b86922bc907433e21b2 END
  else_8aa7a951a5b149fa813198a24c2f6f4f:  ; Start ELSE block
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
  if_3247eeae31784dd7928707eff698f0a4: ; IF start
  pop rax
    test rax, rax
    je end_if_bba26083ea704b4dac856c8e73c9d580
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_end
  end_if_bba26083ea704b4dac856c8e73c9d580: ; END of if_3247eeae31784dd7928707eff698f0a4
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_end
  end_else_3d6177774bf242adb40842fb34649c2d: ; END of else_8aa7a951a5b149fa813198a24c2f6f4f
  
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
    jmp while_d779952a20564533b5f58745128983f5 ; Reevaluate WHILE condition
  end_while_88e73be1e84b445e8a6153bc5331c7c0: ; END of while_d779952a20564533b5f58745128983f5
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_end
  func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61416C6C6F63_89868ef6bef640efaa4ec92afac43eb1_start:
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
  if_6774d96d16834fba9645b4515cdd0902: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_7b5a42ee05dc41df8fe70a2454d329b9
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_89868ef6bef640efaa4ec92afac43eb1_end
  end_if_7b5a42ee05dc41df8fe70a2454d329b9: ; END of if_6774d96d16834fba9645b4515cdd0902
  
  if_2fc627b7ffce4cd8ac998d67a94f29f0: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_346ce74332a3432cb2d84b4bf7b5411d
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_89868ef6bef640efaa4ec92afac43eb1_end
  end_if_346ce74332a3432cb2d84b4bf7b5411d: ; END of if_2fc627b7ffce4cd8ac998d67a94f29f0
  
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
  while_7eb9a1ee676e480b840f6951914fb495: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_9430b835886a4fc392d4f9933ac31774
  
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
  if_3ac82c796537464ca7dc4a0e5d861bce: ; IF start
  pop rax
    test rax, rax
    je end_if_2afddd9892f74fb68bca05a16845c850
  
    jmp end_else_a7af06fe6cef43609abbf15eb18ba68b     ; Jump over ELSE part
  end_if_2afddd9892f74fb68bca05a16845c850:    ; if_3ac82c796537464ca7dc4a0e5d861bce END
  else_d5cd4523f29f4506a8052d30226543f7:  ; Start ELSE block
  if_6b844a10141142c38772b5a4b0dbde50: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jb end_if_8d2e82a32b2b4c398d78b04e4fe7d31a
  
  jmp end_while_9430b835886a4fc392d4f9933ac31774 ; BREAK
  end_if_8d2e82a32b2b4c398d78b04e4fe7d31a: ; END of if_6b844a10141142c38772b5a4b0dbde50
  
  end_else_a7af06fe6cef43609abbf15eb18ba68b: ; END of else_d5cd4523f29f4506a8052d30226543f7
  
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
    jmp while_7eb9a1ee676e480b840f6951914fb495 ; Reevaluate WHILE condition
  end_while_9430b835886a4fc392d4f9933ac31774: ; END of while_7eb9a1ee676e480b840f6951914fb495
  
  if_1bdc347815094ce496e866db620eb03b: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jne end_if_a835dc8df3914d339f552d84f55581fb
  
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
  if_e757e542f3704745aea6c12fa97b053d: ; IF start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jbe end_if_96c1f411824d4d4ca3db2ba38c0ec6ee
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_89868ef6bef640efaa4ec92afac43eb1_end
  end_if_96c1f411824d4d4ca3db2ba38c0ec6ee: ; END of if_e757e542f3704745aea6c12fa97b053d
  
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
  end_if_a835dc8df3914d339f552d84f55581fb: ; END of if_1bdc347815094ce496e866db620eb03b
  
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
  while_ad0fc6f5a83c4f7a9d46a518b9a69425: ; WHILE start
  mov rax, qword [rbp - 40]
    mov rcx, rax
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jae end_while_27ed911986a941fc8786835a7f74815a
  
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
    jmp while_ad0fc6f5a83c4f7a9d46a518b9a69425 ; Reevaluate WHILE condition
  end_while_27ed911986a941fc8786835a7f74815a: ; END of while_ad0fc6f5a83c4f7a9d46a518b9a69425
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, 0x0000000000000020
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_4172656E61416C6C6F63_89868ef6bef640efaa4ec92afac43eb1_end
  func_4172656E61416C6C6F63_89868ef6bef640efaa4ec92afac43eb1_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6150696E_bc47a917b4fa47f0899b6cb080231a71_start:
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
  call func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_a9503ac6759a49f69224a13bc6ad9192: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_d5abc782671d4156b5506e870bedc643
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_bc47a917b4fa47f0899b6cb080231a71_end
  end_if_d5abc782671d4156b5506e870bedc643: ; END of if_a9503ac6759a49f69224a13bc6ad9192
  
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
  if_8e5d532e823d4a17b62e33c5758c2153: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jb end_if_0e4098646a584d0c8c70fe12e8667542
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6150696E_bc47a917b4fa47f0899b6cb080231a71_end
  end_if_0e4098646a584d0c8c70fe12e8667542: ; END of if_8e5d532e823d4a17b62e33c5758c2153
  
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
    
    jmp func_4172656E6150696E_bc47a917b4fa47f0899b6cb080231a71_end
  func_4172656E6150696E_bc47a917b4fa47f0899b6cb080231a71_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61556E70696E_f18d63fcb49d43b69dd0bd93e7255b3d_start:
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
  call func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_9cc59d6d7c1346b3a0c726a93f25c506: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_851595e6cf97442e8130647670317fa6
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_f18d63fcb49d43b69dd0bd93e7255b3d_end
  end_if_851595e6cf97442e8130647670317fa6: ; END of if_9cc59d6d7c1346b3a0c726a93f25c506
  
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
  if_04061eae67d64db18a36f16c54d9db77: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_f857b1d9cb0c4fcd95ff815169e33496
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61556E70696E_f18d63fcb49d43b69dd0bd93e7255b3d_end
  end_if_f857b1d9cb0c4fcd95ff815169e33496: ; END of if_04061eae67d64db18a36f16c54d9db77
  
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
    
    jmp func_4172656E61556E70696E_f18d63fcb49d43b69dd0bd93e7255b3d_end
  func_4172656E61556E70696E_f18d63fcb49d43b69dd0bd93e7255b3d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6146726565_820d1059ae7745e9a84f66df5bd6b371_start:
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
  call func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_dfa46dbbf1564ae0a1fbcb3c54a96730: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_4daa51f5482f44479b920c8d2052e7c3
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_820d1059ae7745e9a84f66df5bd6b371_end
  end_if_4daa51f5482f44479b920c8d2052e7c3: ; END of if_dfa46dbbf1564ae0a1fbcb3c54a96730
  
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
  if_c227f59875284df3a3b63547f0a6ec6a: ; IF start
  pop rax
    test rax, rax
    je end_if_35652cb1427c4e368362c9548b4ec691
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6146726565_820d1059ae7745e9a84f66df5bd6b371_end
  end_if_35652cb1427c4e368362c9548b4ec691: ; END of if_c227f59875284df3a3b63547f0a6ec6a
  
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
  while_3c81357cd82b4527b24133634ba1f640: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_68bd1278f6d144d09aff2d45fc251c7a
  
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
  if_5c39c20d8b4942e6b386ff17478cc4ad: ; IF start
  pop rax
    test rax, rax
    je end_if_dc2a497a8cfe4752a0966da4d05a614e
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_if_dc2a497a8cfe4752a0966da4d05a614e: ; END of if_5c39c20d8b4942e6b386ff17478cc4ad
  
    jmp while_3c81357cd82b4527b24133634ba1f640 ; Reevaluate WHILE condition
  end_while_68bd1278f6d144d09aff2d45fc251c7a: ; END of while_3c81357cd82b4527b24133634ba1f640
  
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
    
    jmp func_4172656E6146726565_820d1059ae7745e9a84f66df5bd6b371_end
  func_4172656E6146726565_820d1059ae7745e9a84f66df5bd6b371_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61526573697A65_15c35eeec2f04ce2bd1367c292fd1ae0_start:
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
  call func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
  if_a6bc63663cc94bc59e761a9e506bb6e5: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jne end_if_90d2bb87e62e4977a0dfbc75458ece50
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_15c35eeec2f04ce2bd1367c292fd1ae0_end
  end_if_90d2bb87e62e4977a0dfbc75458ece50: ; END of if_a6bc63663cc94bc59e761a9e506bb6e5
  
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
  if_2b3f52d55cf84a9284df9c92ae12844a: ; IF start
  pop rax
    test rax, rax
    je end_if_c3ebb14f18744e47b3b7f04448478b38
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_15c35eeec2f04ce2bd1367c292fd1ae0_end
  end_if_c3ebb14f18744e47b3b7f04448478b38: ; END of if_2b3f52d55cf84a9284df9c92ae12844a
  
  if_c000ee210a1c485fb2e73b1b7ff76af5: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_d2f82396335b42d284483bc7c0edec44
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_15c35eeec2f04ce2bd1367c292fd1ae0_end
  end_if_d2f82396335b42d284483bc7c0edec44: ; END of if_c000ee210a1c485fb2e73b1b7ff76af5
  
  if_7fc5434123f1439fb75de29ec3cb7c82: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jne end_if_2885de2d87684e0380985ae8f715582a
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_15c35eeec2f04ce2bd1367c292fd1ae0_end
  end_if_2885de2d87684e0380985ae8f715582a: ; END of if_7fc5434123f1439fb75de29ec3cb7c82
  
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
  if_9ad0fb7ad32f411a8e0f3b02e60ab247: ; IF start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    ja end_if_b10e76606927472d886474d68e433097
  
  if_8429b13d95284a4bb3e7ada001424498: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_101973e40d1249679154deddc297d38b
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 40], rax
  while_defbaa5326e44f17b0e8b3ac5d0fe31f: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_1f4c89ca35934cd5b533c4b48a84c9be
  
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
    jmp while_defbaa5326e44f17b0e8b3ac5d0fe31f ; Reevaluate WHILE condition
  end_while_1f4c89ca35934cd5b533c4b48a84c9be: ; END of while_defbaa5326e44f17b0e8b3ac5d0fe31f
  
  end_if_101973e40d1249679154deddc297d38b: ; END of if_8429b13d95284a4bb3e7ada001424498
  
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
    
    jmp func_4172656E61526573697A65_15c35eeec2f04ce2bd1367c292fd1ae0_end
  end_if_b10e76606927472d886474d68e433097: ; END of if_9ad0fb7ad32f411a8e0f3b02e60ab247
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_4172656E61416C6C6F63_89868ef6bef640efaa4ec92afac43eb1_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  if_13953c4e82dd47a7b629e19ce29fc4b9: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_1cf8752dd94044c782343715e45d1f35
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_15c35eeec2f04ce2bd1367c292fd1ae0_end
  end_if_1cf8752dd94044c782343715e45d1f35: ; END of if_13953c4e82dd47a7b629e19ce29fc4b9
  
  while_a3e18a43435f42fab808cdb01353f5a1: ; WHILE start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_d6b588367f824dea8903d9fb4bb8e502
  
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
    jmp while_a3e18a43435f42fab808cdb01353f5a1 ; Reevaluate WHILE condition
  end_while_d6b588367f824dea8903d9fb4bb8e502: ; END of while_a3e18a43435f42fab808cdb01353f5a1
  
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  call func_4172656E6146726565_820d1059ae7745e9a84f66df5bd6b371_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 48], rax
  mov rax, qword [rbp - 32]
    push rax
  pop rax
    
    jmp func_4172656E61526573697A65_15c35eeec2f04ce2bd1367c292fd1ae0_end
  func_4172656E61526573697A65_15c35eeec2f04ce2bd1367c292fd1ae0_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_start:
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
  if_29ae2694f532412189969732703f902c: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jbe end_if_ea029fafdb52462fb456e98fdaa7b678
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_end
  end_if_ea029fafdb52462fb456e98fdaa7b678: ; END of if_29ae2694f532412189969732703f902c
  
  if_43e680bd4656489eb6142abc4084d895: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp + 16]
    cmp rax, rcx
    jbe end_if_9c444c781a764c9a8a505edc38ada285
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_end
  end_if_9c444c781a764c9a8a505edc38ada285: ; END of if_43e680bd4656489eb6142abc4084d895
  
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
  if_ba5e498f8af7424b84a3ef9a018724cd: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_3c74c5c2b51a4b6e94b00229ae2d7847
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_end
  end_if_3c74c5c2b51a4b6e94b00229ae2d7847: ; END of if_ba5e498f8af7424b84a3ef9a018724cd
  
  if_2cd5e1900f9e4dcda50624bdbf5453bf: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_8c4e2b251df642eab2646bde08977901
  
  if_2aa93dd112d2452f9fadd788da3a585f: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    je end_if_24a1acb93c7c404ebe28dde7be4685df
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_end
  end_if_24a1acb93c7c404ebe28dde7be4685df: ; END of if_2aa93dd112d2452f9fadd788da3a585f
  
  mov rax, 0x0000000000000008
    push rax
  pop rax
    
    mov qword [rbp - 24], rax
    jmp end_else_8095a181c58c4ab4a66801e454379b0b     ; Jump over ELSE part
  end_if_8c4e2b251df642eab2646bde08977901:    ; if_2cd5e1900f9e4dcda50624bdbf5453bf END
  else_38da0642f6da48e28cd6cdb9da55cc6f:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  call func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  if_28b301c1e06c4af89fcdf03bd55985f0: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jne end_if_00640d6c94ac4efb9e7576ae45942669
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_end
  end_if_00640d6c94ac4efb9e7576ae45942669: ; END of if_28b301c1e06c4af89fcdf03bd55985f0
  
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
  if_2fde7bc0a1cc4775a704889a5c31494c: ; IF start
  pop rax
    test rax, rax
    je end_if_5cd942962acf45dea64a0bbd6109d9c0
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_end
  end_if_5cd942962acf45dea64a0bbd6109d9c0: ; END of if_2fde7bc0a1cc4775a704889a5c31494c
  
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
  if_431dbafe4d1145b5b6c3f4c92768268f: ; IF start
  mov rax, qword [rbp - 48]
    mov rcx, rax
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jb end_if_77773d5be5b244939f9b3ae8deb74455
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_end
  end_if_77773d5be5b244939f9b3ae8deb74455: ; END of if_431dbafe4d1145b5b6c3f4c92768268f
  
  end_else_8095a181c58c4ab4a66801e454379b0b: ; END of else_38da0642f6da48e28cd6cdb9da55cc6f
  
  while_cf2276e65eb8476b823aeb6358ef8891: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jae end_while_95875d1ff9b4441eb0ffc4a2fceea121
  
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
    jmp while_cf2276e65eb8476b823aeb6358ef8891 ; Reevaluate WHILE condition
  end_while_95875d1ff9b4441eb0ffc4a2fceea121: ; END of while_cf2276e65eb8476b823aeb6358ef8891
  
  if_13276ec55c1c4e37814a4e43ceeb55e6: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_4c4c22455b8f4d95a29d1b154cef68ed
  
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61416C6C6F63_89868ef6bef640efaa4ec92afac43eb1_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
    jmp end_else_89f7b0ceb561412aac12e1f3cb84a26d     ; Jump over ELSE part
  end_if_4c4c22455b8f4d95a29d1b154cef68ed:    ; if_13276ec55c1c4e37814a4e43ceeb55e6 END
  else_cdfe3871eaa54ac2b4becc099d75d620:  ; Start ELSE block
  mov rax, qword [rbp + 48]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 24]
    push rax
  call func_4172656E61526573697A65_15c35eeec2f04ce2bd1367c292fd1ae0_start
    add rsp, 24
    push rax
  pop rax
    
    mov qword [rbp - 32], rax
  end_else_89f7b0ceb561412aac12e1f3cb84a26d: ; END of else_cdfe3871eaa54ac2b4becc099d75d620
  
  if_a17bf15ad4d44a978053bb8a2c6ed781: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    jne end_if_224d8104a5644367be32f10a753a9dfc
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_end
  end_if_224d8104a5644367be32f10a753a9dfc: ; END of if_a17bf15ad4d44a978053bb8a2c6ed781
  
  while_fbcdd67eb3f243fda8af9c205d9ac2e8: ; WHILE start
  mov rax, qword [rbp + 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_6b3dcdaf4e5948819feda0f89d182789
  
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
  if_a33fae5824404b1bb4ff0e3d9e25ff16: ; IF start
  mov rcx, 97
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    jb end_if_4528addc47264871aa9fe5283b2f129f
  
  if_0f45430b10e14311a0085ef35f1e984e: ; IF start
  mov rcx, 122
    mov rax, qword [rbp - 48]
    cmp rax, rcx
    ja end_if_51851684132e42b9a46d82c05f1fea94
  
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
  end_if_51851684132e42b9a46d82c05f1fea94: ; END of if_0f45430b10e14311a0085ef35f1e984e
  
  end_if_4528addc47264871aa9fe5283b2f129f: ; END of if_a33fae5824404b1bb4ff0e3d9e25ff16
  
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
    jmp while_fbcdd67eb3f243fda8af9c205d9ac2e8 ; Reevaluate WHILE condition
  end_while_6b3dcdaf4e5948819feda0f89d182789: ; END of while_fbcdd67eb3f243fda8af9c205d9ac2e8
  
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
    
    jmp func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_end
  func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4172656E6154657374_9c94110c83864ed39ad31a95209b1bd2_start:
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
  if_85dc549665514667a4bef3e79724ffae: ; IF start
  mov rcx, 192
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jae end_if_339d6f6eecdf423f82c91fe22f944c41
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6154657374_9c94110c83864ed39ad31a95209b1bd2_end
  end_if_339d6f6eecdf423f82c91fe22f944c41: ; END of if_85dc549665514667a4bef3e79724ffae
  
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
  if_3769bd56da774fd3aab80a593d4a1de5: ; IF start
  mov rcx, 65536
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_eaaa25811145467d9efeee6af8740f7b
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6154657374_9c94110c83864ed39ad31a95209b1bd2_end
  end_if_eaaa25811145467d9efeee6af8740f7b: ; END of if_3769bd56da774fd3aab80a593d4a1de5
  
  if_e10ec7c751b54341b82f5aeeef22665d: ; IF start
  mov rcx, 512
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jbe end_if_41f41a6424d8496fa76c3ebb0f3af7b5
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6154657374_9c94110c83864ed39ad31a95209b1bd2_end
  end_if_41f41a6424d8496fa76c3ebb0f3af7b5: ; END of if_e10ec7c751b54341b82f5aeeef22665d
  
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
  if_c78f282713e0448dbd4f529c0e0facb2: ; IF start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    je end_if_cc9160b895bf45329784984ad3b0c8e6
  
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4172656E6154657374_9c94110c83864ed39ad31a95209b1bd2_end
  end_if_cc9160b895bf45329784984ad3b0c8e6: ; END of if_c78f282713e0448dbd4f529c0e0facb2
  
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
  call func_4172656E61496E6974_a5df40c1b2f74683959449404238963f_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  while_38d759c7ecc4461aa944f5fb0193bfc7: ; WHILE start
  mov rax, qword [rbp - 16]
    mov rcx, rax
    mov rax, qword [rbp - 40]
    cmp rax, rcx
    jae end_while_4f6c49050947437ab58ceb59f01b9824
  
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
  if_06ad45f5cc97486eabf0aed119a65dfb: ; IF start
  mov rcx, 16
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    jae end_if_bc91a6e4965e4e8e961b29a5d991751e
  
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
  if_b2de26542e9e4cf5a80afbf35ebb1a0b: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 104]
    cmp rax, rcx
    je end_if_805c5c80c2ec40e9a4231f7044e3b502
  
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
  end_if_805c5c80c2ec40e9a4231f7044e3b502: ; END of if_b2de26542e9e4cf5a80afbf35ebb1a0b
  
  if_2a165d3067084c20ac5c265345a1a598: ; IF start
  mov rcx, 1
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_7e1ceae6bc50464292148f6d870b48fa
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  call func_4172656E61416C6C6F63_89868ef6bef640efaa4ec92afac43eb1_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_70c325dcc573446d9ee9f81db4d64ca3: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    je end_if_475b5e9e179a49b08a15a00e2e061e58
  
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
  end_if_475b5e9e179a49b08a15a00e2e061e58: ; END of if_70c325dcc573446d9ee9f81db4d64ca3
  
  end_if_7e1ceae6bc50464292148f6d870b48fa: ; END of if_2a165d3067084c20ac5c265345a1a598
  
  if_f786bd82576d43858b5aa49820714b70: ; IF start
  mov rcx, 2
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_02345df8befb46c6af1cec130b2f95db
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  mov rax, qword [rbp - 72]
    push rax
  call func_4172656E61526573697A65_15c35eeec2f04ce2bd1367c292fd1ae0_start
    add rsp, 24
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_40efccb7780f4e84afe0cfd5c92a7455: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    je end_if_aaa66173fff74473bb5ca796f7a11f31
  
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
  end_if_aaa66173fff74473bb5ca796f7a11f31: ; END of if_40efccb7780f4e84afe0cfd5c92a7455
  
  end_if_02345df8befb46c6af1cec130b2f95db: ; END of if_f786bd82576d43858b5aa49820714b70
  
  if_2d22070993de4ea8aff262198a6a827a: ; IF start
  mov rcx, 3
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_0ceccf93cc814a58bcf125a778b99da0
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  call func_4172656E6146726565_820d1059ae7745e9a84f66df5bd6b371_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_e02227cb5aa14eee9e601dee8d041c31: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    je end_if_3d30bd799e3d404c93c195c981987007
  
  mov rax, qword [rbp - 96]
    push rax
  mov rax, 0x0000000000000000
    push rax
  pop rcx
    pop rax
    mov qword [rax], rcx
  end_if_3d30bd799e3d404c93c195c981987007: ; END of if_e02227cb5aa14eee9e601dee8d041c31
  
  end_if_0ceccf93cc814a58bcf125a778b99da0: ; END of if_2d22070993de4ea8aff262198a6a827a
  
  if_6f7a198f057f450d8b38c8e1d792f66e: ; IF start
  mov rcx, 4
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_b0f58dd241f548ecbe4c6eaa2cedb47c
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  call func_4172656E6150696E_bc47a917b4fa47f0899b6cb080231a71_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_b0f58dd241f548ecbe4c6eaa2cedb47c: ; END of if_6f7a198f057f450d8b38c8e1d792f66e
  
  if_00b611ea4bcf4fdb9366b3c4ae07af0d: ; IF start
  mov rcx, 5
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_f3e265eef00347839adc820f4721c04e
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  call func_4172656E61556E70696E_f18d63fcb49d43b69dd0bd93e7255b3d_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_f3e265eef00347839adc820f4721c04e: ; END of if_00b611ea4bcf4fdb9366b3c4ae07af0d
  
  if_2e5b36b9467a448faa725b7d140e2543: ; IF start
  mov rcx, 7
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_3ca9b57386724dbc9c5d68c54140cadb
  
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
  call func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_dee8f66f516c4f6ebbd15e7c4b0294fa: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    je end_if_ddd302069ca448d9b5673b18cd524355
  
  mov rax, 0x0000000000000001
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  end_if_ddd302069ca448d9b5673b18cd524355: ; END of if_dee8f66f516c4f6ebbd15e7c4b0294fa
  
  end_if_3ca9b57386724dbc9c5d68c54140cadb: ; END of if_2e5b36b9467a448faa725b7d140e2543
  
  if_7c41a7d8a2c04d1d9edc714f16af1f94: ; IF start
  mov rcx, 6
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_d911c474e7e54d568584bc992f519403
  
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 104]
    push rax
  call func_4172656E6146696E64_b931806d82e849afbf3a33c3bd137160_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 112], rax
  if_46d56547a83d49d88ec98473f0cf288c: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 112]
    cmp rax, rcx
    je end_if_5ae4e0d27c6f4aec90dd25e439d8acd9
  
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
  if_d472802785ea4ddbbebc69f5b64956e3: ; IF start
  mov rax, qword [rbp - 120]
    mov rcx, rax
    mov rax, qword [rbp - 72]
    cmp rax, rcx
    jae end_if_28ff2cfd630e46ebbc73a69a0b7b20bd
  
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
  end_if_28ff2cfd630e46ebbc73a69a0b7b20bd: ; END of if_d472802785ea4ddbbebc69f5b64956e3
  
  end_if_5ae4e0d27c6f4aec90dd25e439d8acd9: ; END of if_46d56547a83d49d88ec98473f0cf288c
  
  end_if_d911c474e7e54d568584bc992f519403: ; END of if_7c41a7d8a2c04d1d9edc714f16af1f94
  
  if_a8a9e19cfc0849928d90c2f716bac76e: ; IF start
  mov rcx, 8
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_e6d31aed1e6d4df7bf82a5ff8d4f4b6b
  
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
  call func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_start
    add rsp, 40
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  if_26b95262a823451db082a0c07b13dd43: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 88]
    cmp rax, rcx
    je end_if_d2a0b21dec1b4007a7843e56c5cbab06
  
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
  end_if_d2a0b21dec1b4007a7843e56c5cbab06: ; END of if_26b95262a823451db082a0c07b13dd43
  
  end_if_e6d31aed1e6d4df7bf82a5ff8d4f4b6b: ; END of if_a8a9e19cfc0849928d90c2f716bac76e
  
  end_if_bc91a6e4965e4e8e961b29a5d991751e: ; END of if_06ad45f5cc97486eabf0aed119a65dfb
  
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
    jmp while_38d759c7ecc4461aa944f5fb0193bfc7 ; Reevaluate WHILE condition
  end_while_4f6c49050947437ab58ceb59f01b9824: ; END of while_38d759c7ecc4461aa944f5fb0193bfc7
  
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
    
    jmp func_4172656E6154657374_9c94110c83864ed39ad31a95209b1bd2_end
  func_4172656E6154657374_9c94110c83864ed39ad31a95209b1bd2_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5465787447726F77_0f94a00adc5449569355634cce007c0f_start:
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
  if_b407b1fb63684603b4b182e72a0a799d: ; IF start
  mov rcx, 64
    mov rax, qword [rbp + 32]
    cmp rax, rcx
    jae end_if_bd9abe0b0f414019a3bd024e0927a1a9
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_0f94a00adc5449569355634cce007c0f_end
  end_if_bd9abe0b0f414019a3bd024e0927a1a9: ; END of if_b407b1fb63684603b4b182e72a0a799d
  
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
  if_949965aff3204ac683f35347c375902b: ; IF start
  mov rcx, 16384
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jbe end_if_54c790bfc8864351b5c25c975a72b8de
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_0f94a00adc5449569355634cce007c0f_end
  end_if_54c790bfc8864351b5c25c975a72b8de: ; END of if_949965aff3204ac683f35347c375902b
  
  if_4aa256e6442a40d5b62d137bebae61c0: ; IF start
  mov rcx, 32768
    mov rax, qword [rbp - 16]
    cmp rax, rcx
    jbe end_if_a8155ebb7ff14704b2fd10ff259fdf2f
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_0f94a00adc5449569355634cce007c0f_end
  end_if_a8155ebb7ff14704b2fd10ff259fdf2f: ; END of if_4aa256e6442a40d5b62d137bebae61c0
  
  if_a7ad437ca296472f99d4c55b01e9ad3c: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jne end_if_5130144a7e5a442dbd4b82ecd2494a03
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_0f94a00adc5449569355634cce007c0f_end
  end_if_5130144a7e5a442dbd4b82ecd2494a03: ; END of if_a7ad437ca296472f99d4c55b01e9ad3c
  
  if_b13ba21e4a454ada832635b60aacbf46: ; IF start
  mov rcx, 256
    mov rax, qword [rbp - 24]
    cmp rax, rcx
    jbe end_if_2a870b930d844a09814def0ba9c4a13f
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_0f94a00adc5449569355634cce007c0f_end
  end_if_2a870b930d844a09814def0ba9c4a13f: ; END of if_b13ba21e4a454ada832635b60aacbf46
  
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
  if_9e3c2bc8aaa74a09b4762838b4a89c38: ; IF start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 32]
    cmp rax, rcx
    je end_if_2cf35c093b4940f39fbf04641049d68f
  
  mov rax, 0xFFFFFFFFFFFFFFF6
    push rax
  pop rax
    
    jmp func_5465787447726F77_0f94a00adc5449569355634cce007c0f_end
  end_if_2cf35c093b4940f39fbf04641049d68f: ; END of if_9e3c2bc8aaa74a09b4762838b4a89c38
  
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
  call func_4172656E61496E6974_a5df40c1b2f74683959449404238963f_start
    add rsp, 16
    push rax
  pop rax
    
    mov qword [rbp - 88], rax
  loop_4c765ee882f0421096e2d11124eb131f: ; LOOP start
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
  if_602aefa711e34d9dbb5d0a083086d3ab: ; IF start
  mov rax, qword [rbp - 24]
    mov rcx, rax
    mov rax, qword [rbp - 64]
    cmp rax, rcx
    jbe end_if_dcefe9d7118a4e77996cc363273a4bd0
  
  mov rax, qword [rbp - 24]
    push rax
  pop rax
    
    mov qword [rbp - 64], rax
  end_if_dcefe9d7118a4e77996cc363273a4bd0: ; END of if_602aefa711e34d9dbb5d0a083086d3ab
  
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
  call func_4172656E61417070656E645570706572_939c594b4e8248d2a8499fa692eb6569_start
    add rsp, 40
    push rax
  pop rax
    
    mov qword [rbp - 80], rax
  if_69c983fe4a744773ac959fdf61655714: ; IF start
  mov rcx, 0
    mov rax, qword [rbp - 80]
    cmp rax, rcx
    jne end_if_98ebd09d2bc641eb8d0a23633a3cd846
  
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
    
    jmp func_5465787447726F77_0f94a00adc5449569355634cce007c0f_end
  end_if_98ebd09d2bc641eb8d0a23633a3cd846: ; END of if_69c983fe4a744773ac959fdf61655714
  
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
  if_c209153ce9c548489a90c0ceca4589aa: ; IF start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 56]
    cmp rax, rcx
    jne end_if_90993eef33f3419fb1e5b44b12f98f14
  
  jmp end_loop_7844f83d44aa41b78ecc62d2c3815e9d ; BREAK
  end_if_90993eef33f3419fb1e5b44b12f98f14: ; END of if_c209153ce9c548489a90c0ceca4589aa
  
    jmp loop_4c765ee882f0421096e2d11124eb131f ; LOOP: continue iteration
  end_loop_7844f83d44aa41b78ecc62d2c3815e9d: ; END of loop_4c765ee882f0421096e2d11124eb131f
  
  while_d35efeb39f064f8e982e242bdc90ebb5: ; WHILE start
  mov rax, qword [rbp - 8]
    mov rcx, rax
    mov rax, qword [rbp - 96]
    cmp rax, rcx
    jae end_while_58fbb0805c5c42aba0401b8fc4dbe053
  
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
    jmp while_d35efeb39f064f8e982e242bdc90ebb5 ; Reevaluate WHILE condition
  end_while_58fbb0805c5c42aba0401b8fc4dbe053: ; END of while_d35efeb39f064f8e982e242bdc90ebb5
  
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
    
    jmp func_5465787447726F77_0f94a00adc5449569355634cce007c0f_end
  func_5465787447726F77_0f94a00adc5449569355634cce007c0f_end:
    mov rsp, rbp
    pop rbp
    ret
module_6172656E615F74657374_b0272aa06d284f5eb0b08688e5512e6a_end:
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
call func_4172656E6154657374_9c94110c83864ed39ad31a95209b1bd2_start
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
call func_5465787447726F77_0f94a00adc5449569355634cce007c0f_start
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
