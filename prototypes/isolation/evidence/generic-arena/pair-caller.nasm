  module_67656E657269635F70616972_1d4ca7766e4d4b86963d7e3e37947b40_start:
  ; Module: generic_pair v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 11:32:37Z
    ; Module UUID: 1d4ca776-6e4d-4b86-963d-7e3e37947b40


    section .bss

    section .text

    func_506169724D61696E_c90120f862aa49349950f4b10a2d635f_start:
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
    mov rax, 0x0000000000000004
      mov qword [rbp - 72], rax
    mov rax, 0x0000000000000002
      mov qword [rbp - 80], rax
    mov rax, 0x0000000000000008
      mov qword [rbp - 88], rax
    mov rax, 0x0000000000000008
      mov qword [rbp - 96], rax
    mov rax, 0x00000000000003E8
      mov qword [rbp - 104], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 112], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 120], rax
    if_5d1e034c3fac46918f35782ea5ff024c: ; IF start
    mov rcx, 2208
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_9572a7598669459fb7e60c245d2f96ef
    
    mov rax, 0xFFFFFFFFFFFFFFF6
      push rax
    pop rax
      
      jmp func_506169724D61696E_c90120f862aa49349950f4b10a2d635f_end
    end_if_9572a7598669459fb7e60c245d2f96ef: ; END of if_5d1e034c3fac46918f35782ea5ff024c
    
    mov rax, qword [rbp + 40]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 56], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000080
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000800
      push rax
    call func_4172656E61496E6974_efc14a0094464917a6b56f2ceac3a4e5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000010
      push rax
    call func_4172656E61416C6C6F63_ec0fb70ba742464daae6ce9f54846c80_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000010
      push rax
    call func_4172656E61416C6C6F63_ec0fb70ba742464daae6ce9f54846c80_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    while_2509498a7415424a8b4131f5eec64aca: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 64]
      cmp rax, rcx
      jae end_while_f0cf2d0b7b1346448ede1ded1d852bdb
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 64]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 64]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000061
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 64], rax
      jmp while_2509498a7415424a8b4131f5eec64aca ; Reevaluate WHILE condition
    end_while_f0cf2d0b7b1346448ede1ded1d852bdb: ; END of while_2509498a7415424a8b4131f5eec64aca
    
    if_c6cc9613b1a843b39371a1ca972ead27: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_2e219ecd78eb444ea829b78067c4e83d
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_if_2e219ecd78eb444ea829b78067c4e83d: ; END of if_c6cc9613b1a843b39371a1ca972ead27
    
    if_f6a800a36f1c4589bf611644b2f399ae: ; IF start
    mov rcx, 2
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_2f250c0e6d08454c98d17b75dc3af80d
    
    mov rax, qword [rbp - 48]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000010000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    end_if_2f250c0e6d08454c98d17b75dc3af80d: ; END of if_f6a800a36f1c4589bf611644b2f399ae
    
    if_ac78f3b36665409fbeaced657f65d9f9: ; IF start
    mov rcx, 3
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_8fe83d8162f54b4e9426cc4268082a32
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    end_if_8fe83d8162f54b4e9426cc4268082a32: ; END of if_ac78f3b36665409fbeaced657f65d9f9
    
    if_a4b89a171b6c4ecb91af0ae705e82920: ; IF start
    mov rcx, 20
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_192a794a5f644a54a6033a0d5346d48b
    
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    mov rax, qword [rbp - 40]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x000000000000FFFF
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    end_if_192a794a5f644a54a6033a0d5346d48b: ; END of if_a4b89a171b6c4ecb91af0ae705e82920
    
    if_f16e616565e747bf817209b3b7e7e489: ; IF start
    mov rcx, 4
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_ae401fd34a234ea8b283e907ec682633
    
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_if_ae401fd34a234ea8b283e907ec682633: ; END of if_f16e616565e747bf817209b3b7e7e489
    
    if_54fc98148f714a99b9d61907b72db30f: ; IF start
    mov rcx, 6
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_83f5f6a858194f05afcd59a34b5cefa7
    
    mov rax, 0x0000000000000019
      push rax
    pop rax
      
      mov qword [rbp - 104], rax
    end_if_83f5f6a858194f05afcd59a34b5cefa7: ; END of if_54fc98148f714a99b9d61907b72db30f
    
    if_66a001cd50524ff8a0b6d955bb4bba1f: ; IF start
    mov rcx, 7
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_4aee7eb401614b2385d9d699bf139e93
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 104], rax
    end_if_4aee7eb401614b2385d9d699bf139e93: ; END of if_66a001cd50524ff8a0b6d955bb4bba1f
    
    if_bfd50881e50c4865bfbd704dee4e1ceb: ; IF start
    mov rcx, 10
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_66e35539d56745b0b0cd029b9f5d423c
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
    end_if_66e35539d56745b0b0cd029b9f5d423c: ; END of if_bfd50881e50c4865bfbd704dee4e1ceb
    
    if_97197886f41b4d2cb67a2baeaec85a21: ; IF start
    mov rcx, 11
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_3e032b45fc994b3e8e0f542b913832d9
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    end_if_3e032b45fc994b3e8e0f542b913832d9: ; END of if_97197886f41b4d2cb67a2baeaec85a21
    
    if_1093fe54a9524827808c549e8dc062df: ; IF start
    mov rcx, 12
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_f5047aba98ad4acfb48f9a74e0501258
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 96], rax
    end_if_f5047aba98ad4acfb48f9a74e0501258: ; END of if_1093fe54a9524827808c549e8dc062df
    
    if_79674fbd3daa4c2caf71a290c4ff9b66: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_08772f23a34a428a993922a660fa421c
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_08772f23a34a428a993922a660fa421c: ; END of if_79674fbd3daa4c2caf71a290c4ff9b66
    
    if_68e36b3e03af418ebf191cced6f24dca: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_a86709c62d4444528cbb3a88145e729a
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_a86709c62d4444528cbb3a88145e729a: ; END of if_68e36b3e03af418ebf191cced6f24dca
    
    if_06bb605a03c64b8396d8b1576923dcc3: ; IF start
    mov rcx, 2
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_a746d38d495a4ecd9a18543f2259effb
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_a746d38d495a4ecd9a18543f2259effb: ; END of if_06bb605a03c64b8396d8b1576923dcc3
    
    if_81e1fa14ec7b4d259ea8a0aedce5b8ff: ; IF start
    mov rcx, 3
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_d9c416d2d06c477b86b7a9368193ef5e
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_d9c416d2d06c477b86b7a9368193ef5e: ; END of if_81e1fa14ec7b4d259ea8a0aedce5b8ff
    
    if_5d5ca33db5104df98da54c1884b0212a: ; IF start
    mov rcx, 4
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_dbacb6b994434ac799855f762b3fbf4c
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_dbacb6b994434ac799855f762b3fbf4c: ; END of if_5d5ca33db5104df98da54c1884b0212a
    
    if_7891f7935b6d4fdba9740a4f2321d41d: ; IF start
    mov rcx, 5
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_d05ad9e85f71495abc20aa93c228d225
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_d05ad9e85f71495abc20aa93c228d225: ; END of if_7891f7935b6d4fdba9740a4f2321d41d
    
    if_218a40f940354726ae57d2c3d2466262: ; IF start
    mov rcx, 6
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_9493664398ed4c0eaf1a854af192b8ef
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_9493664398ed4c0eaf1a854af192b8ef: ; END of if_218a40f940354726ae57d2c3d2466262
    
    if_c01921046e2c434ba38dc7d96a5bc7c3: ; IF start
    mov rcx, 7
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_ed2ccd6398a44dd581bff939f41587c4
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_ed2ccd6398a44dd581bff939f41587c4: ; END of if_c01921046e2c434ba38dc7d96a5bc7c3
    
    if_b34b439b4b1b41a281dd01084fb5da96: ; IF start
    mov rcx, 8
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_fb05faaf20aa47139dc4edc7249a0bde
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_fb05faaf20aa47139dc4edc7249a0bde: ; END of if_b34b439b4b1b41a281dd01084fb5da96
    
    if_79a9e2a898c84cf3a614fa0ac77f7107: ; IF start
    mov rcx, 9
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_8ef1a1604e514a5a8d6f42de23d16dcd
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_8ef1a1604e514a5a8d6f42de23d16dcd: ; END of if_79a9e2a898c84cf3a614fa0ac77f7107
    
    if_32ed79f2e2f549b2bf1fab2de5fdd407: ; IF start
    mov rcx, 10
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_e3c64eef2cb84badadafe4c09242016b
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_e3c64eef2cb84badadafe4c09242016b: ; END of if_32ed79f2e2f549b2bf1fab2de5fdd407
    
    if_f9d279d185214ce1994cbc085ef51cef: ; IF start
    mov rcx, 11
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_034b30dc7a7e4855844109dc5a81f37e
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_034b30dc7a7e4855844109dc5a81f37e: ; END of if_f9d279d185214ce1994cbc085ef51cef
    
    if_62dceaeaa1734bf497757618da351468: ; IF start
    mov rcx, 12
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_352a8974044046d098c696316e1d85db
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_352a8974044046d098c696316e1d85db: ; END of if_62dceaeaa1734bf497757618da351468
    
    if_288b1a5a6b6e490896c737d68ba8320f: ; IF start
    mov rcx, 13
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_24685ce2c8464c489cb5e964b81d283d
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_24685ce2c8464c489cb5e964b81d283d: ; END of if_288b1a5a6b6e490896c737d68ba8320f
    
    if_2db9a37558e042e680b7fd8b733d6fc4: ; IF start
    mov rcx, 14
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_58f15a12bde94198aa3f46675aff99c0
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_58f15a12bde94198aa3f46675aff99c0: ; END of if_2db9a37558e042e680b7fd8b733d6fc4
    
    if_fbc5b9f3c2704c50b50ffcf43dd40163: ; IF start
    mov rcx, 15
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_57fcbe7f3fe64fcf849b7b7e1f2f13cf
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_57fcbe7f3fe64fcf849b7b7e1f2f13cf: ; END of if_fbc5b9f3c2704c50b50ffcf43dd40163
    
    if_c55e799a109d480cbf886bdb16632579: ; IF start
    mov rcx, 16
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_8ff3ff87d2034f1296338cc2a13b14ad
    
    mov rax, 0xFFFFFFFFFFFFFFEF
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, 0x0000000100000001
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_start
      add rsp, 96
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_8ff3ff87d2034f1296338cc2a13b14ad: ; END of if_c55e799a109d480cbf886bdb16632579
    
    if_f9c2e570bc004ab6a0659ae3469cabad: ; IF start
    mov rcx, 17
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_79ed9ffabcfe44fd9121cfaacbb5b7fb
    
    mov rax, 0xFFFFFFFFFFFFFFEF
      push rax
    mov rax, 0x0000000100000001
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5363616C6172_7af892bf453f49c5a4b92212ef939b46_start
      add rsp, 32
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_79ed9ffabcfe44fd9121cfaacbb5b7fb: ; END of if_f9c2e570bc004ab6a0659ae3469cabad
    
    if_23f0e89cf2224a018fcb3edeb59160db: ; IF start
    mov rcx, 18
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_84408c03d98a4968bb776ed06071b981
    
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F456D707479_558c4dd15a5341ea9ee71c70091a5537_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_84408c03d98a4968bb776ed06071b981: ; END of if_23f0e89cf2224a018fcb3edeb59160db
    
    if_aacefca0a97a497e9515508937a06d88: ; IF start
    mov rcx, 19
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_7aa3ca21c91d483695696b49f41c2592
    
    mov rax, 0xFFFFFFFFFFFFFFEF
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, 0x0000000100000001
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, 0x000000000000000A
      push rax
    mov rax, 0xFFFFFFFFFFFFFFFD
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_start
      add rsp, 112
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_7aa3ca21c91d483695696b49f41c2592: ; END of if_aacefca0a97a497e9515508937a06d88
    
    if_1e0eeba1c355495b878e6ce1dcb0c739: ; IF start
    mov rcx, 20
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_f5f64a2ed5894208b786bf1f8ec34117
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_f5f64a2ed5894208b786bf1f8ec34117: ; END of if_1e0eeba1c355495b878e6ce1dcb0c739
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 120]
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
    mov rax, qword [rbp - 40]
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
      mov qword [rax], rcx
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
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
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 64], rax
    while_90bbae888417421bbbe5f9dbe1a614f3: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 64]
      cmp rax, rcx
      jae end_while_70e930dfee044133ab80a96c053e88af
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000050
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
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 64]
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
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 64], rax
      jmp while_90bbae888417421bbbe5f9dbe1a614f3 ; Reevaluate WHILE condition
    end_while_70e930dfee044133ab80a96c053e88af: ; END of while_90bbae888417421bbbe5f9dbe1a614f3
    
    if_d61453cc6a7a4f34acca3bba09002c56: ; IF start
    mov rcx, 20
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_8110a360096240b29c2f7573034c1b14
    
    mov rax, qword [rbp - 40]
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
    end_if_8110a360096240b29c2f7573034c1b14: ; END of if_d61453cc6a7a4f34acca3bba09002c56
    
    if_c97f3ff383ac40d7990f18ad4dc80f28: ; IF start
    mov rcx, 2
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_10965b47ae0546148bd30e246309e2e2
    
    mov rax, qword [rbp - 48]
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
    end_if_10965b47ae0546148bd30e246309e2e2: ; END of if_c97f3ff383ac40d7990f18ad4dc80f28
    
    if_818618ce92fe43808aa89c4b4b8b2934: ; IF start
    mov rcx, 3
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_004730644030496485776853941d81f6
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    end_if_004730644030496485776853941d81f6: ; END of if_818618ce92fe43808aa89c4b4b8b2934
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, 0x0000000000000010
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, 0x0000000000000010
      push rax
    mov rax, 0x0000000000000010
      push rax
    mov rax, 0x00000000000003E8
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000038
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000030
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 112]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6146726565_42979701b115472484dbcb92e13ef673_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000040
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 112]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E6146726565_42979701b115472484dbcb92e13ef673_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000048
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 112]
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
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 120]
      push rax
    pop rax
      
      jmp func_506169724D61696E_c90120f862aa49349950f4b10a2d635f_end
    func_506169724D61696E_c90120f862aa49349950f4b10a2d635f_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61496E6974_efc14a0094464917a6b56f2ceac3a4e5_start:
    push rbp
      mov rbp, rsp
    if_ad1d5e98174348fc944e353fd3927544: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_992565e0391a4e3fad1dffd462897cee
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61496E6974_efc14a0094464917a6b56f2ceac3a4e5_end
    end_if_992565e0391a4e3fad1dffd462897cee: ; END of if_ad1d5e98174348fc944e353fd3927544
    
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
      
      jmp func_4172656E61496E6974_efc14a0094464917a6b56f2ceac3a4e5_end
    func_4172656E61496E6974_efc14a0094464917a6b56f2ceac3a4e5_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start:
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
    while_3dc8aad0a64d492ca7d8c618a44a8c82: ; WHILE start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jae end_while_7b29afbf5d0d4db0b997abbed7503391
    
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
    if_4f041084a9a749eb966f44c0c19a99a6: ; IF start
    pop rax
      test rax, rax
      je end_if_66ef3a03c0574541a4a25e716535c10f
    
      jmp end_else_de0e8859f04a4cc483eb882ffc250818     ; Jump over ELSE part
    end_if_66ef3a03c0574541a4a25e716535c10f:    ; if_4f041084a9a749eb966f44c0c19a99a6 END
    else_9c3852d242e141609e7dce4a0b2df7f4:  ; Start ELSE block
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
    if_dea7cb4e72644ccc8a3f44087576cc5c: ; IF start
    pop rax
      test rax, rax
      je end_if_0472e64193524bff93b15425bc37efd7
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_end
    end_if_0472e64193524bff93b15425bc37efd7: ; END of if_dea7cb4e72644ccc8a3f44087576cc5c
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_end
    end_else_de0e8859f04a4cc483eb882ffc250818: ; END of else_9c3852d242e141609e7dce4a0b2df7f4
    
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
      jmp while_3dc8aad0a64d492ca7d8c618a44a8c82 ; Reevaluate WHILE condition
    end_while_7b29afbf5d0d4db0b997abbed7503391: ; END of while_3dc8aad0a64d492ca7d8c618a44a8c82
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_end
    func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61416C6C6F63_ec0fb70ba742464daae6ce9f54846c80_start:
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
    if_cea2ad47ac77462cbb1c1912cff9628b: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_d8f755ca31ef45bfaa938482456e598e
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_ec0fb70ba742464daae6ce9f54846c80_end
    end_if_d8f755ca31ef45bfaa938482456e598e: ; END of if_cea2ad47ac77462cbb1c1912cff9628b
    
    if_78ba7b6b775a479dbe3121bbfdf76cfd: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jne end_if_8c2a14137015436989217c6b702c7371
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_ec0fb70ba742464daae6ce9f54846c80_end
    end_if_8c2a14137015436989217c6b702c7371: ; END of if_78ba7b6b775a479dbe3121bbfdf76cfd
    
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
    while_ee4431ac54f44b5eacfa776cdbc46d1b: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_ae45943cb6e143779dfde1adc6d61fec
    
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
    if_195d30d5db9547129ca97f6ed10cda52: ; IF start
    pop rax
      test rax, rax
      je end_if_4b22f2870b5e43e29f28854176a24755
    
      jmp end_else_eaad33adbb324dce9159ecf4efb81c87     ; Jump over ELSE part
    end_if_4b22f2870b5e43e29f28854176a24755:    ; if_195d30d5db9547129ca97f6ed10cda52 END
    else_03ec00f12e1446e9a4c35858f7e0a2f7:  ; Start ELSE block
    if_4c1a8e503a9e4f98adca531eeff2da93: ; IF start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jb end_if_cd37ae021e2b4ebcbaf4639833ffb551
    
    jmp end_while_ae45943cb6e143779dfde1adc6d61fec ; BREAK
    end_if_cd37ae021e2b4ebcbaf4639833ffb551: ; END of if_4c1a8e503a9e4f98adca531eeff2da93
    
    end_else_eaad33adbb324dce9159ecf4efb81c87: ; END of else_03ec00f12e1446e9a4c35858f7e0a2f7
    
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
      jmp while_ee4431ac54f44b5eacfa776cdbc46d1b ; Reevaluate WHILE condition
    end_while_ae45943cb6e143779dfde1adc6d61fec: ; END of while_ee4431ac54f44b5eacfa776cdbc46d1b
    
    if_6814b489fc724ad6a8d318f0cfb4842f: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_98498d96f79b4ce4ba99d277062fae2a
    
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
    if_cd0d70968aa24ac89568e12cbdf2b0f4: ; IF start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jbe end_if_03a7a5c47fec441f827ab607960c11c5
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_ec0fb70ba742464daae6ce9f54846c80_end
    end_if_03a7a5c47fec441f827ab607960c11c5: ; END of if_cd0d70968aa24ac89568e12cbdf2b0f4
    
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
    end_if_98498d96f79b4ce4ba99d277062fae2a: ; END of if_6814b489fc724ad6a8d318f0cfb4842f
    
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
    while_648023f6fe7b4bb4a8ebb50cd1a9949e: ; WHILE start
    mov rax, qword [rbp - 40]
      mov rcx, rax
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jae end_while_d9d3caa5a1524e9b903aedd063affa71
    
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
      jmp while_648023f6fe7b4bb4a8ebb50cd1a9949e ; Reevaluate WHILE condition
    end_while_d9d3caa5a1524e9b903aedd063affa71: ; END of while_648023f6fe7b4bb4a8ebb50cd1a9949e
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_ec0fb70ba742464daae6ce9f54846c80_end
    func_4172656E61416C6C6F63_ec0fb70ba742464daae6ce9f54846c80_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start:
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
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_839bc02e269140ae8f70b4fd09dab85c: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_ce4f7de44c58425985b5f200bb1078a9
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6150696E_53f9670684be444e968555b0d127b10b_end
    end_if_ce4f7de44c58425985b5f200bb1078a9: ; END of if_839bc02e269140ae8f70b4fd09dab85c
    
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
    if_f44662f3eb184caebb30b09b0ce2a100: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jb end_if_90fa53c37dbf45b38284537cd621fb55
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6150696E_53f9670684be444e968555b0d127b10b_end
    end_if_90fa53c37dbf45b38284537cd621fb55: ; END of if_f44662f3eb184caebb30b09b0ce2a100
    
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
      
      jmp func_4172656E6150696E_53f9670684be444e968555b0d127b10b_end
    func_4172656E6150696E_53f9670684be444e968555b0d127b10b_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start:
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
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_b675c5fdf98a4466889ddd1cfe13f4e8: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_e640c323cbf746fea3085e63b7576fc3
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_end
    end_if_e640c323cbf746fea3085e63b7576fc3: ; END of if_b675c5fdf98a4466889ddd1cfe13f4e8
    
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
    if_fe8d107aff8943b088ab9e379e21280d: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_8a2d043baa584544ab83b980c7a8ccbf
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_end
    end_if_8a2d043baa584544ab83b980c7a8ccbf: ; END of if_fe8d107aff8943b088ab9e379e21280d
    
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
      
      jmp func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_end
    func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6146726565_42979701b115472484dbcb92e13ef673_start:
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
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_e186940deca54ad5b835da57c1a5e9c7: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_9bc6610fad814988ae00c84bbb1db8a4
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146726565_42979701b115472484dbcb92e13ef673_end
    end_if_9bc6610fad814988ae00c84bbb1db8a4: ; END of if_e186940deca54ad5b835da57c1a5e9c7
    
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
    if_a283ce6b320d4fbb909300d9e95eb212: ; IF start
    pop rax
      test rax, rax
      je end_if_5665a88ac8284f369b312cb03372088c
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146726565_42979701b115472484dbcb92e13ef673_end
    end_if_5665a88ac8284f369b312cb03372088c: ; END of if_a283ce6b320d4fbb909300d9e95eb212
    
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
    while_4c61d87ebc144d51ab8be5fcfe647890: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_45253f1cb15d4091b459fb675aa5e51f
    
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
    if_4003dba3a1034670b9213106e887139d: ; IF start
    pop rax
      test rax, rax
      je end_if_437ebefe4f7b432fb597e430e54cf037
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_if_437ebefe4f7b432fb597e430e54cf037: ; END of if_4003dba3a1034670b9213106e887139d
    
      jmp while_4c61d87ebc144d51ab8be5fcfe647890 ; Reevaluate WHILE condition
    end_while_45253f1cb15d4091b459fb675aa5e51f: ; END of while_4c61d87ebc144d51ab8be5fcfe647890
    
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
      
      jmp func_4172656E6146726565_42979701b115472484dbcb92e13ef673_end
    func_4172656E6146726565_42979701b115472484dbcb92e13ef673_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61526573697A65_66cd23f586d049f4baf90b1754dd2ce6_start:
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
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_1cfae030b62f42f0b5a56c2df6b1b6d5: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_ba790e6cdb804e889cfe0852748c85e4
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_66cd23f586d049f4baf90b1754dd2ce6_end
    end_if_ba790e6cdb804e889cfe0852748c85e4: ; END of if_1cfae030b62f42f0b5a56c2df6b1b6d5
    
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
    if_e2fa67b606b049e48efb36908ac8106b: ; IF start
    pop rax
      test rax, rax
      je end_if_d7cfbd8df6a94416ae04d21c4d2d5af2
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_66cd23f586d049f4baf90b1754dd2ce6_end
    end_if_d7cfbd8df6a94416ae04d21c4d2d5af2: ; END of if_e2fa67b606b049e48efb36908ac8106b
    
    if_bafd33e188f8401bab7d5350c7bf5bf3: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_2537d33af8b04962aae6738c524c78c6
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_66cd23f586d049f4baf90b1754dd2ce6_end
    end_if_2537d33af8b04962aae6738c524c78c6: ; END of if_bafd33e188f8401bab7d5350c7bf5bf3
    
    if_378124245c69491e9fe0ff11d90b8929: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jne end_if_ebd8c12fb5cc4d2481634a0616715052
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_66cd23f586d049f4baf90b1754dd2ce6_end
    end_if_ebd8c12fb5cc4d2481634a0616715052: ; END of if_378124245c69491e9fe0ff11d90b8929
    
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
    if_d981e7511f2c4ec5aa427e417fddbe3b: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      ja end_if_3e2feba07394488c900df3ba83e69697
    
    if_0fbd6aa531c5424881efb7661ac30b8f: ; IF start
    mov rax, qword [rbp - 24]
      mov rcx, rax
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_4ddbe921a1b04c39aa52de63f4234a5e
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    while_f9709581b5124718bcc0609e99792525: ; WHILE start
    mov rax, qword [rbp + 16]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_696e6c18121b44dcadf6af703c379030
    
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
      jmp while_f9709581b5124718bcc0609e99792525 ; Reevaluate WHILE condition
    end_while_696e6c18121b44dcadf6af703c379030: ; END of while_f9709581b5124718bcc0609e99792525
    
    end_if_4ddbe921a1b04c39aa52de63f4234a5e: ; END of if_0fbd6aa531c5424881efb7661ac30b8f
    
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
      
      jmp func_4172656E61526573697A65_66cd23f586d049f4baf90b1754dd2ce6_end
    end_if_3e2feba07394488c900df3ba83e69697: ; END of if_d981e7511f2c4ec5aa427e417fddbe3b
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call func_4172656E61416C6C6F63_ec0fb70ba742464daae6ce9f54846c80_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_8d8c4f92de1544bc9ce12e55d9f63f15: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      jne end_if_c7fd7006d5b1447688f74384bb63e76c
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_66cd23f586d049f4baf90b1754dd2ce6_end
    end_if_c7fd7006d5b1447688f74384bb63e76c: ; END of if_8d8c4f92de1544bc9ce12e55d9f63f15
    
    while_97409b88e79d4677b31937ee4a2858a5: ; WHILE start
    mov rax, qword [rbp - 24]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_57229e216a364a32a4bc09a6b656d889
    
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
      jmp while_97409b88e79d4677b31937ee4a2858a5 ; Reevaluate WHILE condition
    end_while_57229e216a364a32a4bc09a6b656d889: ; END of while_97409b88e79d4677b31937ee4a2858a5
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    call func_4172656E6146726565_42979701b115472484dbcb92e13ef673_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp - 32]
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_66cd23f586d049f4baf90b1754dd2ce6_end
    func_4172656E61526573697A65_66cd23f586d049f4baf90b1754dd2ce6_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61417070656E645570706572_317ba23f20d141c682f068e26aab66b6_start:
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
    if_1486b74d86284a70bf7590a62f2082df: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jbe end_if_8ead2f1de69b424eb93a8176cc1767ef
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_317ba23f20d141c682f068e26aab66b6_end
    end_if_8ead2f1de69b424eb93a8176cc1767ef: ; END of if_1486b74d86284a70bf7590a62f2082df
    
    if_1132b5527dec4dbc81e96e1e1bd6ff49: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_29de77c5592045e89e9818e80d2eeef0
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_317ba23f20d141c682f068e26aab66b6_end
    end_if_29de77c5592045e89e9818e80d2eeef0: ; END of if_1132b5527dec4dbc81e96e1e1bd6ff49
    
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
    if_f46fe57f1674425d8e37a0ca0f819295: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jbe end_if_9ac4efde852a460183732392dd691385
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_317ba23f20d141c682f068e26aab66b6_end
    end_if_9ac4efde852a460183732392dd691385: ; END of if_f46fe57f1674425d8e37a0ca0f819295
    
    if_3aae1059422c4a3b8649c1fde67f899d: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jne end_if_25905437de6b42a892c252da6bf0dd5a
    
    if_1cc6c88ca4be479a90525aa52ac06af7: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_8d2b29dbed3c4c8abab0e029620a596a
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_317ba23f20d141c682f068e26aab66b6_end
    end_if_8d2b29dbed3c4c8abab0e029620a596a: ; END of if_1cc6c88ca4be479a90525aa52ac06af7
    
    mov rax, 0x0000000000000008
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
      jmp end_else_6183fcc363eb48fa89e751d18d2dbf76     ; Jump over ELSE part
    end_if_25905437de6b42a892c252da6bf0dd5a:    ; if_3aae1059422c4a3b8649c1fde67f899d END
    else_770e9ad893e24380b3c2472a1a62ff8b:  ; Start ELSE block
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_475e8b78f37f4d98bba65a60ccc3501e: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_decd8acb28aa45fda4ad937b2702a1f7
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_317ba23f20d141c682f068e26aab66b6_end
    end_if_decd8acb28aa45fda4ad937b2702a1f7: ; END of if_475e8b78f37f4d98bba65a60ccc3501e
    
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
    if_b52f7047eb5147e6aab7ebe3b18451dd: ; IF start
    pop rax
      test rax, rax
      je end_if_2bfc0fc73b7148ca9471533f9569f25b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_317ba23f20d141c682f068e26aab66b6_end
    end_if_2bfc0fc73b7148ca9471533f9569f25b: ; END of if_b52f7047eb5147e6aab7ebe3b18451dd
    
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
    if_1f43257289514bff9c3a5d4fa3651707: ; IF start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jb end_if_fa5408dd7bd541a4a03c1daeddd4a08d
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_317ba23f20d141c682f068e26aab66b6_end
    end_if_fa5408dd7bd541a4a03c1daeddd4a08d: ; END of if_1f43257289514bff9c3a5d4fa3651707
    
    end_else_6183fcc363eb48fa89e751d18d2dbf76: ; END of else_770e9ad893e24380b3c2472a1a62ff8b
    
    while_1dbc83e596b94d42bec11e0e4313fca7: ; WHILE start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_343f498b04f24b2096845f8f0c354100
    
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
      jmp while_1dbc83e596b94d42bec11e0e4313fca7 ; Reevaluate WHILE condition
    end_while_343f498b04f24b2096845f8f0c354100: ; END of while_1dbc83e596b94d42bec11e0e4313fca7
    
    if_98cb677e93bd4b8a8bc8c42826173a46: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jne end_if_925ce93946e342ba94798cea198c3f2c
    
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61416C6C6F63_ec0fb70ba742464daae6ce9f54846c80_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
      jmp end_else_381b29f3608d481785253e87c122a935     ; Jump over ELSE part
    end_if_925ce93946e342ba94798cea198c3f2c:    ; if_98cb677e93bd4b8a8bc8c42826173a46 END
    else_644c4a2c9d8b460fb03ed70fd7596cb3:  ; Start ELSE block
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61526573697A65_66cd23f586d049f4baf90b1754dd2ce6_start
      add rsp, 24
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_else_381b29f3608d481785253e87c122a935: ; END of else_644c4a2c9d8b460fb03ed70fd7596cb3
    
    if_fc53b158dc324821a2ab6918e8ce01ec: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      jne end_if_943ec46b386c4966802449e37eb9147e
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_317ba23f20d141c682f068e26aab66b6_end
    end_if_943ec46b386c4966802449e37eb9147e: ; END of if_fc53b158dc324821a2ab6918e8ce01ec
    
    while_c580fa0de7d34279804cae8afd336c0f: ; WHILE start
    mov rax, qword [rbp + 16]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_451e2874e7224df099fe0c8675efbaab
    
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
    if_6fba7f66d3b042be9fc734deab6ef139: ; IF start
    mov rcx, 97
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      jb end_if_3bac918880a74c5c9cad4b8c9183867b
    
    if_0edcad9011294f869da66006ff192bed: ; IF start
    mov rcx, 122
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      ja end_if_3e1b3dab08404ef7a0d9973c3d898be0
    
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
    end_if_3e1b3dab08404ef7a0d9973c3d898be0: ; END of if_0edcad9011294f869da66006ff192bed
    
    end_if_3bac918880a74c5c9cad4b8c9183867b: ; END of if_6fba7f66d3b042be9fc734deab6ef139
    
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
      jmp while_c580fa0de7d34279804cae8afd336c0f ; Reevaluate WHILE condition
    end_while_451e2874e7224df099fe0c8675efbaab: ; END of while_c580fa0de7d34279804cae8afd336c0f
    
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
      
      jmp func_4172656E61417070656E645570706572_317ba23f20d141c682f068e26aab66b6_end
    func_4172656E61417070656E645570706572_317ba23f20d141c682f068e26aab66b6_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_2b294805a9e945b5876f0c187cd955ef: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_e070de2b26ca44898177de8a7c9afa1f
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_end
    end_if_e070de2b26ca44898177de8a7c9afa1f: ; END of if_2b294805a9e945b5876f0c187cd955ef
    
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
      
      mov qword [rbp - 16], rax
    if_6a086cea804c4209a695cee16ccac00c: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_1d676d2d7ab54be2a4e0cc85b8776785
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_end
    end_if_1d676d2d7ab54be2a4e0cc85b8776785: ; END of if_6a086cea804c4209a695cee16ccac00c
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_aa9dd2434a8a443c93b95891d17162c4: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_ce261e7bb46245f6903c4b99b2919ca4
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_end
    end_if_ce261e7bb46245f6903c4b99b2919ca4: ; END of if_aa9dd2434a8a443c93b95891d17162c4
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_1d388df4191e4d73b272abb6042e62a1: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_cf71b901fbf44d2d95e3d3f1c6194f02
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_end
    end_if_cf71b901fbf44d2d95e3d3f1c6194f02: ; END of if_1d388df4191e4d73b272abb6042e62a1
    
    mov rax, qword [rbp - 24]
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
      
      mov qword [rbp - 32], rax
    if_46652c9016bb4cae9646c61cf489b671: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_aa49e8aad91e4ef5b2853f5c924be19b
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_end
    end_if_aa49e8aad91e4ef5b2853f5c924be19b: ; END of if_46652c9016bb4cae9646c61cf489b671
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_9863081fd87a4887866724e44a481327: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_34820f5c7ebc4189ada78dfa92f80155
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_end
    end_if_34820f5c7ebc4189ada78dfa92f80155: ; END of if_9863081fd87a4887866724e44a481327
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_655d739fc7604e879d9f25d248f89c31: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_63c88266a0d24217af69fedf38f2a65b
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_end
    end_if_63c88266a0d24217af69fedf38f2a65b: ; END of if_655d739fc7604e879d9f25d248f89c31
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_16dea494e6e647afb155b9949f13ffbd: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_bd714191b37c443faf096753dd4d4b2c
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_end
    end_if_bd714191b37c443faf096753dd4d4b2c: ; END of if_16dea494e6e647afb155b9949f13ffbd
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_DualWrite
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_end
    func_4172656E615F4475616C5772697465_ffa3761ba7a44bcdb7582c3cb71901ff_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_b420c1c405c9476fb6346e6960aed532: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_c17bb9524d7d452c987864b1a539f39e
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_end
    end_if_c17bb9524d7d452c987864b1a539f39e: ; END of if_b420c1c405c9476fb6346e6960aed532
    
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
      
      mov qword [rbp - 16], rax
    if_4b40db35791548bc909936d2fd05fbcc: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_df325b582c2b47aa9568f883035942d9
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_end
    end_if_df325b582c2b47aa9568f883035942d9: ; END of if_4b40db35791548bc909936d2fd05fbcc
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_62e82e6477d644d8976f29d185defe4e: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_01f5e92809a640498065a8c361fc8f82
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_end
    end_if_01f5e92809a640498065a8c361fc8f82: ; END of if_62e82e6477d644d8976f29d185defe4e
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_786ee1caf70344e2b0d472df615ca51c: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_e103bb159b054c7981c01a448af7dd3d
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_end
    end_if_e103bb159b054c7981c01a448af7dd3d: ; END of if_786ee1caf70344e2b0d472df615ca51c
    
    mov rax, qword [rbp - 24]
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
      
      mov qword [rbp - 32], rax
    if_1421d89039a649c9956e8648fdaaf489: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_0dee24761e3c4f268cb209b71cd624c2
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_end
    end_if_0dee24761e3c4f268cb209b71cd624c2: ; END of if_1421d89039a649c9956e8648fdaaf489
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_4aa597ce296544959b940f1f443fdd4d: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_4c7611b5ff90478ca35e75f4752ae4a4
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_end
    end_if_4c7611b5ff90478ca35e75f4752ae4a4: ; END of if_4aa597ce296544959b940f1f443fdd4d
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_e6f827b5fa73486f82c98fffe7ba09d0: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_231b6c40209f41f8b7aff9b500a68866
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_end
    end_if_231b6c40209f41f8b7aff9b500a68866: ; END of if_e6f827b5fa73486f82c98fffe7ba09d0
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_49e497c06227431098a2656f610f1892: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_bff8d2e0960e473cbb0777324d157a2d
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_end
    end_if_bff8d2e0960e473cbb0777324d157a2d: ; END of if_49e497c06227431098a2656f610f1892
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Reverse
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_end
    func_4172656E615F52657665727365_a699ba39827340a292dfa0f3e28ccb24_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_c0370ad90ab44b7094d379f6b9c33559: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_18e2b8ce2ace4d0196b1344e10ff7994
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_end
    end_if_18e2b8ce2ace4d0196b1344e10ff7994: ; END of if_c0370ad90ab44b7094d379f6b9c33559
    
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
      
      mov qword [rbp - 16], rax
    if_1f77ec0cd33a470ab20bb29d5648d774: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_299b83ec2f40422ca2e2e27488ef00f9
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_end
    end_if_299b83ec2f40422ca2e2e27488ef00f9: ; END of if_1f77ec0cd33a470ab20bb29d5648d774
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_d1d3e6edc19d4ba182fc32894044383e: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_fceccf9659a747d3bcb8b6813bb2a767
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_end
    end_if_fceccf9659a747d3bcb8b6813bb2a767: ; END of if_d1d3e6edc19d4ba182fc32894044383e
    
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_938637dc812245c09ba36663e2ec25fd: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_c59205ff60124d86b3449f23477f97aa
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_end
    end_if_c59205ff60124d86b3449f23477f97aa: ; END of if_938637dc812245c09ba36663e2ec25fd
    
    mov rax, qword [rbp - 24]
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
      
      mov qword [rbp - 32], rax
    if_dfd30c54d14a4d28a0a17222e069c523: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_56dc7d917e3b41bb8318235a3c0ce93e
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_end
    end_if_56dc7d917e3b41bb8318235a3c0ce93e: ; END of if_dfd30c54d14a4d28a0a17222e069c523
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_a7be47d62ade4107b3c5a9eb9f377b02: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jbe end_if_a24a7b4c207f4180ac81778ba8e29d92
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_end
    end_if_a24a7b4c207f4180ac81778ba8e29d92: ; END of if_a7be47d62ade4107b3c5a9eb9f377b02
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_e51780cb4b7e49bab2e1bbc4114210c9: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_2e1e366eab7d43f382ff5155df62bef8
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_end
    end_if_2e1e366eab7d43f382ff5155df62bef8: ; END of if_e51780cb4b7e49bab2e1bbc4114210c9
    
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_114877f079ee4541b697864bfe92d34e: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_6dac281242a84a77b5c1a0150d826cce
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_end
    end_if_6dac281242a84a77b5c1a0150d826cce: ; END of if_114877f079ee4541b697864bfe92d34e
    
    mov rax, qword [rbp + 104]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Mixed
      add rsp, 64
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_end
    func_4172656E615F4D69786564_e5197e5502af40bb9d65b63e45d6c783_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F5363616C6172_7af892bf453f49c5a4b92212ef939b46_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, 0x0000000000000001
      mov qword [rbp - 16], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Scalar
      add rsp, 32
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      
      jmp func_4172656E615F5363616C6172_7af892bf453f49c5a4b92212ef939b46_end
    func_4172656E615F5363616C6172_7af892bf453f49c5a4b92212ef939b46_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F456D707479_558c4dd15a5341ea9ee71c70091a5537_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, 0x0000000000000001
      mov qword [rbp - 16], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Empty
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      
      jmp func_4172656E615F456D707479_558c4dd15a5341ea9ee71c70091a5537_end
    func_4172656E615F456D707479_558c4dd15a5341ea9ee71c70091a5537_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 112]
      push rax
    mov rax, qword [rbp + 104]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_bd84c6879e13443c9213230dd2949ebd: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_2047130f415d48528b5267fbecf80ef3
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_end
    end_if_2047130f415d48528b5267fbecf80ef3: ; END of if_bd84c6879e13443c9213230dd2949ebd
    
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
      
      mov qword [rbp - 16], rax
    if_b220343ada96449690cf245df1b40013: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 96]
      cmp rax, rcx
      jbe end_if_cef9042fe0444846813f8846ac3e5d08
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_end
    end_if_cef9042fe0444846813f8846ac3e5d08: ; END of if_b220343ada96449690cf245df1b40013
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 96]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_2d229b1683864c87a831372e6bcae7d6: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 88]
      cmp rax, rcx
      jbe end_if_ccd621a360714d14998d000cec7a1427
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_end
    end_if_ccd621a360714d14998d000cec7a1427: ; END of if_2d229b1683864c87a831372e6bcae7d6
    
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 64]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_2a0ca0a39e0542f58445ae2b4ec0b6b8: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_3531a05256ef49d2a1f5a9c5b4ef80a0
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_end
    end_if_3531a05256ef49d2a1f5a9c5b4ef80a0: ; END of if_2a0ca0a39e0542f58445ae2b4ec0b6b8
    
    mov rax, qword [rbp - 24]
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
      
      mov qword [rbp - 32], rax
    if_a15297e341fd483da7f4f806e70be3d9: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 56]
      cmp rax, rcx
      jbe end_if_0786c906974c43489567202010fecf64
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_end
    end_if_0786c906974c43489567202010fecf64: ; END of if_a15297e341fd483da7f4f806e70be3d9
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_c324cd4943964cee995336b1fd92f381: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_bd7f4991b3ff4b579282729413619293
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_end
    end_if_bd7f4991b3ff4b579282729413619293: ; END of if_c324cd4943964cee995336b1fd92f381
    
    mov rax, qword [rbp + 112]
      push rax
    mov rax, qword [rbp + 104]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_0688e1e72e3b48bd92bb3a6ddf8c5d62: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_60eadcec7d864420b405fb4aa1f94b08
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_end
    end_if_60eadcec7d864420b405fb4aa1f94b08: ; END of if_0688e1e72e3b48bd92bb3a6ddf8c5d62
    
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 64]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_ed78143ac0e94b7399727d4890c03c55: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_b5d576fb26a84662a09ce8db7ad1816c
    
    mov rax, qword [rbp + 112]
      push rax
    mov rax, qword [rbp + 104]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_end
    end_if_b5d576fb26a84662a09ce8db7ad1816c: ; END of if_ed78143ac0e94b7399727d4890c03c55
    
    mov rax, qword [rbp + 120]
      push rax
    mov rax, qword [rbp + 104]
      push rax
    mov rax, qword [rbp + 96]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Six
      add rsp, 80
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 64]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 112]
      push rax
    mov rax, qword [rbp + 104]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_end
    func_4172656E615F536978_4237f917ddd945ef9925e78469a40970_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_b0217e9ae3c84235b84781266e9cef63: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_d30fca3a800e42d091641f734d87a8ca
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_end
    end_if_d30fca3a800e42d091641f734d87a8ca: ; END of if_b0217e9ae3c84235b84781266e9cef63
    
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
      
      mov qword [rbp - 16], rax
    if_7ccd2157df3246babba06fbaa995a4ae: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_744e3c896b444499bc7f8c85f9e4e965
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_end
    end_if_744e3c896b444499bc7f8c85f9e4e965: ; END of if_7ccd2157df3246babba06fbaa995a4ae
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_a72f796c193c42dab49d90071dd14a07: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_8d325fe30e6d4305a23e057b46a5e2f8
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_end
    end_if_8d325fe30e6d4305a23e057b46a5e2f8: ; END of if_a72f796c193c42dab49d90071dd14a07
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_fc326229e16f4b74b379bae2ec7e9863: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_98d18fd39e294593bdbeabc810b1a9ad
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_end
    end_if_98d18fd39e294593bdbeabc810b1a9ad: ; END of if_fc326229e16f4b74b379bae2ec7e9863
    
    mov rax, qword [rbp - 24]
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
      
      mov qword [rbp - 32], rax
    if_ae547d41ca904e7b9c329c73c0fc480d: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_6aa1bde9007049bbb1a0321e7a752dcf
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_end
    end_if_6aa1bde9007049bbb1a0321e7a752dcf: ; END of if_ae547d41ca904e7b9c329c73c0fc480d
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_ebd2551c631a4d21a3ee3383e65fbc5f: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_b49f62df4d8f415bb0ac9a9cd750c545
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_end
    end_if_b49f62df4d8f415bb0ac9a9cd750c545: ; END of if_ebd2551c631a4d21a3ee3383e65fbc5f
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_2da4e3061b7f417a95a9b92c699df0e0: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_0f9b8a8b07b542c1bd2a5c4346c7b873
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_end
    end_if_0f9b8a8b07b542c1bd2a5c4346c7b873: ; END of if_2da4e3061b7f417a95a9b92c699df0e0
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_e677c74e180f4f61b367cb8cc0846d99: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_a117ac6562eb422d8bd48c6083ea7198
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_end
    end_if_a117ac6562eb422d8bd48c6083ea7198: ; END of if_e677c74e180f4f61b367cb8cc0846d99
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Copy
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_end
    func_4172656E615F436F7079_4712b03515de4b53a19cba11295ec850_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_78d1793bb22e4c4c9cacc67c501bf2d0: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_095e0334485641ae9517793f33a53f5a
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_end
    end_if_095e0334485641ae9517793f33a53f5a: ; END of if_78d1793bb22e4c4c9cacc67c501bf2d0
    
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
      
      mov qword [rbp - 16], rax
    if_848317bdbcef49a7811b51fe97829b2c: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_fa4cd7708d34454294b178aac7a54df5
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_end
    end_if_fa4cd7708d34454294b178aac7a54df5: ; END of if_848317bdbcef49a7811b51fe97829b2c
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_930039c7b47d4fa9b25a26c009a63111: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_f95787551bc147e7a38258350a30c97f
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_end
    end_if_f95787551bc147e7a38258350a30c97f: ; END of if_930039c7b47d4fa9b25a26c009a63111
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_35b6e8d4b17f4b9d85d68f0c056b540c: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_84c7c5d7900e4d3abd2132981e1bd8f5
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_end
    end_if_84c7c5d7900e4d3abd2132981e1bd8f5: ; END of if_35b6e8d4b17f4b9d85d68f0c056b540c
    
    mov rax, qword [rbp - 24]
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
      
      mov qword [rbp - 32], rax
    if_f595562d509147afa60abc4e85513ddf: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_d2e4d97116dd414db704e31d3bd472fc
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_end
    end_if_d2e4d97116dd414db704e31d3bd472fc: ; END of if_f595562d509147afa60abc4e85513ddf
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_c700286003ff46859af4d6b6efcbd5c9: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_1c4f059db0634e85a55e372ec5d74ae9
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_end
    end_if_1c4f059db0634e85a55e372ec5d74ae9: ; END of if_c700286003ff46859af4d6b6efcbd5c9
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_fe13cc92918e4d2bbbff69eca83801a8: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_ffc4497720d74591b085c0c6a5c9ac21
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_end
    end_if_ffc4497720d74591b085c0c6a5c9ac21: ; END of if_fe13cc92918e4d2bbbff69eca83801a8
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_fcbd0eb83be84ec891053356b33fb5e0: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_fe3244edcc4d4c53b93b3fc2f627967a
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_end
    end_if_fe3244edcc4d4c53b93b3fc2f627967a: ; END of if_fcbd0eb83be84ec891053356b33fb5e0
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Partial
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_end
    func_4172656E615F5061727469616C_1fd518f212644c39866f7b166c3b3c32_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_e1decf21bae44a909d07138e34ae0158: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_7d82917f599d41cf85219619ff9d6749
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_end
    end_if_7d82917f599d41cf85219619ff9d6749: ; END of if_e1decf21bae44a909d07138e34ae0158
    
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
      
      mov qword [rbp - 16], rax
    if_3a30b5fd143f401baadbe29ae2284b6a: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_cac3d06bcf454ae98ed515fa74cabc98
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_end
    end_if_cac3d06bcf454ae98ed515fa74cabc98: ; END of if_3a30b5fd143f401baadbe29ae2284b6a
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_90344a9c56864b08bb8ac4cc8c2628fe: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_4fbab40b0f2145bb900cf9e369ead3fe
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_end
    end_if_4fbab40b0f2145bb900cf9e369ead3fe: ; END of if_90344a9c56864b08bb8ac4cc8c2628fe
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_44c496b339964e4c8defe074131a2101: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_44a1abc8bb4440098b0bd86e6fc9262b
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_end
    end_if_44a1abc8bb4440098b0bd86e6fc9262b: ; END of if_44c496b339964e4c8defe074131a2101
    
    mov rax, qword [rbp - 24]
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
      
      mov qword [rbp - 32], rax
    if_f1144dd5898c4699ac45c46a3749481a: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_b992155226d4453296b50bfafe9ba28a
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_end
    end_if_b992155226d4453296b50bfafe9ba28a: ; END of if_f1144dd5898c4699ac45c46a3749481a
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_31ec5c5c6937426ab6ac89cb6a63e57e: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_6e8f61feca424087bbc87d53e682a39a
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_end
    end_if_6e8f61feca424087bbc87d53e682a39a: ; END of if_31ec5c5c6937426ab6ac89cb6a63e57e
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_2feb20708aa4472385ac3e579c60c011: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_d434dc30d0df4dba917505275b1d8a93
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_end
    end_if_d434dc30d0df4dba917505275b1d8a93: ; END of if_2feb20708aa4472385ac3e579c60c011
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_19346a32753b4853bee972e42baa414e: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_d0566ee1dc5949cfb3122fb6c641c453
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_end
    end_if_d0566ee1dc5949cfb3122fb6c641c453: ; END of if_19346a32753b4853bee972e42baa414e
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Spin
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_end
    func_4172656E615F5370696E_ae47c138d2de4442bd92264f02423618_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_69250048ad6044a3860d0450d3086f0c: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_67b71b05baa740c5ae95cf7209ef185e
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_end
    end_if_67b71b05baa740c5ae95cf7209ef185e: ; END of if_69250048ad6044a3860d0450d3086f0c
    
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
      
      mov qword [rbp - 16], rax
    if_86e6928e89114b04bfa13b528cb93f70: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_783f55c4ee5a44a096642e3394bc5a8a
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_end
    end_if_783f55c4ee5a44a096642e3394bc5a8a: ; END of if_86e6928e89114b04bfa13b528cb93f70
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_a7690824b4dc418ab61d8d3b7a6f9dba: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_c3334c4060f0419a9d39395a4f91b116
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_end
    end_if_c3334c4060f0419a9d39395a4f91b116: ; END of if_a7690824b4dc418ab61d8d3b7a6f9dba
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_c8dd85fe9a414999926ae25d9f36ef88_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_0feeeb4e9dec45b58bc37459245198e3: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_a3898c4c9ffb4bf494b7f6c70c6c8c1b
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_end
    end_if_a3898c4c9ffb4bf494b7f6c70c6c8c1b: ; END of if_0feeeb4e9dec45b58bc37459245198e3
    
    mov rax, qword [rbp - 24]
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
      
      mov qword [rbp - 32], rax
    if_139195749d70475885be49aba61700d6: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_5d6e0dcc890749d0a420e9622978e170
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_end
    end_if_5d6e0dcc890749d0a420e9622978e170: ; END of if_139195749d70475885be49aba61700d6
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_3dab626ca2d9482eb6a6c8ccb2fca52d: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_a62e4ba9684f4e8398cafd8b8f8d41c3
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_end
    end_if_a62e4ba9684f4e8398cafd8b8f8d41c3: ; END of if_3dab626ca2d9482eb6a6c8ccb2fca52d
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_06cbfb9e459d4e349c0fe7f6c08d5de1: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_905acbc9e8034964b2d582eed350153b
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_end
    end_if_905acbc9e8034964b2d582eed350153b: ; END of if_06cbfb9e459d4e349c0fe7f6c08d5de1
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_53f9670684be444e968555b0d127b10b_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_839e170207f6418db0d480725a78382d: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_52d6960bff7a495aa1d98219c9c59d3d
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_end
    end_if_52d6960bff7a495aa1d98219c9c59d3d: ; END of if_839e170207f6418db0d480725a78382d
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Negative
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_153a1aeec2904f1b904d9295373cf581_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_end
    func_4172656E615F4E65676174697665_31878e11837740198fc0fca77c8f4f45_end:
      mov rsp, rbp
      pop rbp
      ret
module_67656E657269635F70616972_1d4ca7766e4d4b86963d7e3e37947b40_end:

section .text
extern ubytec_bridge_call
ubytec_module_invoke:
    push rbp
    mov rbp, rsp
    mov rdi, [rbp+56]
    mov rsi, [rbp+48]
    mov rdx, [rbp+40]
    mov rcx, [rbp+32]
    mov r8, [rbp+24]
    mov r9, [rbp+16]
    and rsp, -16
    call ubytec_bridge_call
    mov rsp, rbp
    pop rbp
    ret
section .text
ubytec_import_DualWrite:
 push rbp
 mov rbp,rsp
 push 1
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],1
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],1
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,1
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Reverse:
 push rbp
 mov rbp,rsp
 push 2
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],2
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],1
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,2
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Mixed:
 push rbp
 mov rbp,rsp
 push 3
 add rsp,8
 sub rsp,96
 mov qword [rbp-96],4
 mov rax,[rbp+72]
 mov [rbp-88],rax
 mov qword [rbp-80],0
 mov qword [rbp-72],2
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],3
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov qword [rbp-32],0
 mov qword [rbp-24],1
 mov rax,[rbp+40]
 mov [rbp-16],rax
 mov rax,[rbp+32]
 mov [rbp-8],rax
 extern ubytec_bridge_many
 mov rdi,3
 lea rsi,[rbp-96]
 mov rdx,4
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Scalar:
 push rbp
 mov rbp,rsp
 push 4
 add rsp,8
 sub rsp,48
 mov qword [rbp-48],4
 mov rax,[rbp+40]
 mov [rbp-40],rax
 mov qword [rbp-32],0
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,4
 lea rsi,[rbp-48]
 mov rdx,2
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Empty:
 push rbp
 mov rbp,rsp
 push 5
 add rsp,8
 sub rsp,24
 extern ubytec_bridge_many
 mov rdi,5
 lea rsi,[rbp-24]
 mov rdx,0
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Six:
 push rbp
 mov rbp,rsp
 push 6
 add rsp,8
 sub rsp,144
 mov qword [rbp-144],4
 mov rax,[rbp+88]
 mov [rbp-136],rax
 mov qword [rbp-128],0
 mov qword [rbp-120],1
 mov rax,[rbp+80]
 mov [rbp-112],rax
 mov rax,[rbp+72]
 mov [rbp-104],rax
 mov qword [rbp-96],3
 mov rax,[rbp+64]
 mov [rbp-88],rax
 mov qword [rbp-80],0
 mov qword [rbp-72],2
 mov rax,[rbp+56]
 mov [rbp-64],rax
 mov rax,[rbp+48]
 mov [rbp-56],rax
 mov qword [rbp-48],3
 mov rax,[rbp+40]
 mov [rbp-40],rax
 mov qword [rbp-32],0
 mov qword [rbp-24],4
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,6
 lea rsi,[rbp-144]
 mov rdx,6
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Copy:
 push rbp
 mov rbp,rsp
 push 7
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],1
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],2
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,7
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Partial:
 push rbp
 mov rbp,rsp
 push 8
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],1
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],2
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,8
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Spin:
 push rbp
 mov rbp,rsp
 push 9
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],1
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],2
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,9
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Negative:
 push rbp
 mov rbp,rsp
 push 10
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],1
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],2
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,10
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
global ubytec_host_contract_PairMain
ubytec_host_contract_PairMain:
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
call func_506169724D61696E_c90120f862aa49349950f4b10a2d635f_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,73,124,49,124,68,117,97,108,87,114,105,116,101,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,68,117,97,108,87,114,105,116,101,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,50,124,82,101,118,101,114,115,101,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,82,101,118,101,114,115,101,124,76,111,97,110,82,101,97,100,44,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,51,124,77,105,120,101,100,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,77,105,120,101,100,124,73,110,116,54,52,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,76,111,97,110,87,114,105,116,101,58,73,110,116,54,52,10,73,124,52,124,83,99,97,108,97,114,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,83,99,97,108,97,114,124,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,53,124,69,109,112,116,121,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,69,109,112,116,121,124,58,73,110,116,54,52,10,73,124,54,124,83,105,120,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,83,105,120,124,73,110,116,54,52,44,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,73,110,116,54,52,58,73,110,116,54,52,10,73,124,55,124,67,111,112,121,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,67,111,112,121,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,56,124,80,97,114,116,105,97,108,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,80,97,114,116,105,97,108,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,57,124,83,112,105,110,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,83,112,105,110,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,49,48,124,78,101,103,97,116,105,118,101,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,78,101,103,97,116,105,118,101,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,80,97,105,114,77,97,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,80,97,105,114,77,97,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
