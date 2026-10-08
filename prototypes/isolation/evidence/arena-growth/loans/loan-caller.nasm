  module_6172656E615F63616C6C6572_d23abf86a32c433ba60fcfad4ca6fe4f_start:
  ; Module: arena_caller v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 12:20:12Z
    ; Module UUID: d23abf86-a32c-433b-a60f-cfad4ca6fe4f


    section .bss

    section .text

    func_4172656E61496E6974_7325f9dfeed645bd9b734fc1cf89bef5_start:
    push rbp
      mov rbp, rsp
    if_09701102549f43a29ea689f0141da4c5: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_151991f841fd416ca628e44d7306ba0b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61496E6974_7325f9dfeed645bd9b734fc1cf89bef5_end
    end_if_151991f841fd416ca628e44d7306ba0b: ; END of if_09701102549f43a29ea689f0141da4c5
    
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
      
      jmp func_4172656E61496E6974_7325f9dfeed645bd9b734fc1cf89bef5_end
    func_4172656E61496E6974_7325f9dfeed645bd9b734fc1cf89bef5_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_start:
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
    while_3e7daf7c8f544c7cad7562668a089e99: ; WHILE start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jae end_while_5c369470a0db4d859f5fd23cca94d5da
    
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
    if_73a1e37f54d4484aba682a0e53667e7f: ; IF start
    pop rax
      test rax, rax
      je end_if_8e2db98d111346a697d5e4c2d068585b
    
      jmp end_else_bb7a7cf6b0a143c3a52ac267bad23beb     ; Jump over ELSE part
    end_if_8e2db98d111346a697d5e4c2d068585b:    ; if_73a1e37f54d4484aba682a0e53667e7f END
    else_dddedb8ff54f4468a81d7abf84bb7df8:  ; Start ELSE block
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
    if_0a5d999e821f433baa2068215506b2f6: ; IF start
    pop rax
      test rax, rax
      je end_if_c86bc77ded554a5184814436b356e343
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_end
    end_if_c86bc77ded554a5184814436b356e343: ; END of if_0a5d999e821f433baa2068215506b2f6
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_end
    end_else_bb7a7cf6b0a143c3a52ac267bad23beb: ; END of else_dddedb8ff54f4468a81d7abf84bb7df8
    
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
      jmp while_3e7daf7c8f544c7cad7562668a089e99 ; Reevaluate WHILE condition
    end_while_5c369470a0db4d859f5fd23cca94d5da: ; END of while_3e7daf7c8f544c7cad7562668a089e99
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_end
    func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61416C6C6F63_f51801c44a2e4ce7b6f26b46952d3171_start:
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
    if_9632b49717bb4236924e7f86df2dcb91: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_0bf5367a3ffc41608d4a85de89d2af01
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_f51801c44a2e4ce7b6f26b46952d3171_end
    end_if_0bf5367a3ffc41608d4a85de89d2af01: ; END of if_9632b49717bb4236924e7f86df2dcb91
    
    if_68d5419e92fe44338a2ae231bd4a2012: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jne end_if_6579e173430d45d3a5b0faf47d9dfc4c
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_f51801c44a2e4ce7b6f26b46952d3171_end
    end_if_6579e173430d45d3a5b0faf47d9dfc4c: ; END of if_68d5419e92fe44338a2ae231bd4a2012
    
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
    while_68939d28b69e4d3bb13c41d11d3c5299: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_8ab5ce580e0141a78bfcccf44a6875a4
    
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
    if_41b12b22f3a74b81b8be2906d2223de8: ; IF start
    pop rax
      test rax, rax
      je end_if_944b8bae4e89454c923a8caf07a467ad
    
      jmp end_else_8044bcf9c78a4a87ad4989499d24915e     ; Jump over ELSE part
    end_if_944b8bae4e89454c923a8caf07a467ad:    ; if_41b12b22f3a74b81b8be2906d2223de8 END
    else_cfd924ae51424ee298f6fc979e5ba89d:  ; Start ELSE block
    if_9b8156a586c84aedbaeba8e603da6f41: ; IF start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jb end_if_6273df1b817549e293522b8b474fcc88
    
    jmp end_while_8ab5ce580e0141a78bfcccf44a6875a4 ; BREAK
    end_if_6273df1b817549e293522b8b474fcc88: ; END of if_9b8156a586c84aedbaeba8e603da6f41
    
    end_else_8044bcf9c78a4a87ad4989499d24915e: ; END of else_cfd924ae51424ee298f6fc979e5ba89d
    
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
      jmp while_68939d28b69e4d3bb13c41d11d3c5299 ; Reevaluate WHILE condition
    end_while_8ab5ce580e0141a78bfcccf44a6875a4: ; END of while_68939d28b69e4d3bb13c41d11d3c5299
    
    if_d28b4b0440e040c79df951c95b819a9d: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_8bedd6be774643978ae761c241c57297
    
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
    if_c22d18c6f847420792c6bd73c4235720: ; IF start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jbe end_if_a136a039eecb43a18d7d0713f8d9b54b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_f51801c44a2e4ce7b6f26b46952d3171_end
    end_if_a136a039eecb43a18d7d0713f8d9b54b: ; END of if_c22d18c6f847420792c6bd73c4235720
    
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
      jmp end_else_419bee6c54644cfb82cc1e9ba3275291     ; Jump over ELSE part
    end_if_8bedd6be774643978ae761c241c57297:    ; if_d28b4b0440e040c79df951c95b819a9d END
    else_bc75984969bb404e9826afccc668a2e4:  ; Start ELSE block
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
    if_332d06541c8c4150b20f383e1368bbe9: ; IF start
    mov rax, qword [rbp - 64]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jb end_if_ba0c22e941de4d42a22734d5abfc63ef
    
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
    end_if_ba0c22e941de4d42a22734d5abfc63ef: ; END of if_332d06541c8c4150b20f383e1368bbe9
    
    end_else_419bee6c54644cfb82cc1e9ba3275291: ; END of else_bc75984969bb404e9826afccc668a2e4
    
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
    while_2f510bc50a5345f6839a5dae0bd66485: ; WHILE start
    mov rax, qword [rbp - 40]
      mov rcx, rax
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jae end_while_472a9e65e55d42f3b44e65715e339d7f
    
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
      jmp while_2f510bc50a5345f6839a5dae0bd66485 ; Reevaluate WHILE condition
    end_while_472a9e65e55d42f3b44e65715e339d7f: ; END of while_2f510bc50a5345f6839a5dae0bd66485
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_f51801c44a2e4ce7b6f26b46952d3171_end
    func_4172656E61416C6C6F63_f51801c44a2e4ce7b6f26b46952d3171_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6150696E_1806317aa59541d8af9a4c574fa474fb_start:
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
    call func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_dcc4bd0ba3414bdaa9e6ac541f761e6f: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_e5586832c8b74150b615b7667cf09c7d
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6150696E_1806317aa59541d8af9a4c574fa474fb_end
    end_if_e5586832c8b74150b615b7667cf09c7d: ; END of if_dcc4bd0ba3414bdaa9e6ac541f761e6f
    
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
    if_a2434ed1c7bb46d2b4602c468c28c4d2: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jb end_if_f3fdb9ce56be4fcb955dcc4be2bb1235
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6150696E_1806317aa59541d8af9a4c574fa474fb_end
    end_if_f3fdb9ce56be4fcb955dcc4be2bb1235: ; END of if_a2434ed1c7bb46d2b4602c468c28c4d2
    
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
      
      jmp func_4172656E6150696E_1806317aa59541d8af9a4c574fa474fb_end
    func_4172656E6150696E_1806317aa59541d8af9a4c574fa474fb_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61556E70696E_64f25430aed94371a64c4abf3bef5748_start:
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
    call func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_1016580bccbb4d21907ad5dc0ccea995: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_ac7b32791fb542379b90ef6367164020
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61556E70696E_64f25430aed94371a64c4abf3bef5748_end
    end_if_ac7b32791fb542379b90ef6367164020: ; END of if_1016580bccbb4d21907ad5dc0ccea995
    
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
    if_acd54bd7aac7464aa4e5e6f106a5658a: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_ee9b88e2ee024584a3830e34b9e9c566
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61556E70696E_64f25430aed94371a64c4abf3bef5748_end
    end_if_ee9b88e2ee024584a3830e34b9e9c566: ; END of if_acd54bd7aac7464aa4e5e6f106a5658a
    
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
      
      jmp func_4172656E61556E70696E_64f25430aed94371a64c4abf3bef5748_end
    func_4172656E61556E70696E_64f25430aed94371a64c4abf3bef5748_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6146726565_20ada29a5e40485aa1415a50286ce724_start:
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
    call func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_47f0deaef0e0465c89f250b60d9aa473: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_630b6c8824094e338ff5073b7d01eb86
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146726565_20ada29a5e40485aa1415a50286ce724_end
    end_if_630b6c8824094e338ff5073b7d01eb86: ; END of if_47f0deaef0e0465c89f250b60d9aa473
    
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
    if_d824ce30424943db8b216fea4107b6c2: ; IF start
    pop rax
      test rax, rax
      je end_if_0386327462fa472c82e5fd0bf388aeb7
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146726565_20ada29a5e40485aa1415a50286ce724_end
    end_if_0386327462fa472c82e5fd0bf388aeb7: ; END of if_d824ce30424943db8b216fea4107b6c2
    
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
    while_3b053cec2dbd4edaa85b2e08f618d68b: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_5760dbe497804db28df48b072cafa007
    
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
    if_1393e85d19be4d259f2d17163557d638: ; IF start
    pop rax
      test rax, rax
      je end_if_d05724a391914b33b15eccb8b758142a
    
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
      jmp end_else_cbb93baeac0e4276b7ee3c0ff920a271     ; Jump over ELSE part
    end_if_d05724a391914b33b15eccb8b758142a:    ; if_1393e85d19be4d259f2d17163557d638 END
    else_f2c8026fbd064a5ba8e5b9a03ce1d648:  ; Start ELSE block
    while_d0193ccd49714f9289f1f2956c02b9bb: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      jae end_while_c3915ce417114d75897da7c50f468185
    
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
    if_0ef1f0b2a26047e29157ef417615d66e: ; IF start
    pop rax
      test rax, rax
      je end_if_086bd5cf45314224aff8b1cc2014d613
    
    jmp end_while_c3915ce417114d75897da7c50f468185 ; BREAK
    end_if_086bd5cf45314224aff8b1cc2014d613: ; END of if_0ef1f0b2a26047e29157ef417615d66e
    
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
      jmp while_d0193ccd49714f9289f1f2956c02b9bb ; Reevaluate WHILE condition
    end_while_c3915ce417114d75897da7c50f468185: ; END of while_d0193ccd49714f9289f1f2956c02b9bb
    
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
    end_else_cbb93baeac0e4276b7ee3c0ff920a271: ; END of else_f2c8026fbd064a5ba8e5b9a03ce1d648
    
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
      jmp while_3b053cec2dbd4edaa85b2e08f618d68b ; Reevaluate WHILE condition
    end_while_5760dbe497804db28df48b072cafa007: ; END of while_3b053cec2dbd4edaa85b2e08f618d68b
    
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
      
      jmp func_4172656E6146726565_20ada29a5e40485aa1415a50286ce724_end
    func_4172656E6146726565_20ada29a5e40485aa1415a50286ce724_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_start:
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
    call func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_9239408c0dc14b36bbb7c7a2f2d0f857: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_d9a862f263334b1cb93a31fdcb90be37
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_end
    end_if_d9a862f263334b1cb93a31fdcb90be37: ; END of if_9239408c0dc14b36bbb7c7a2f2d0f857
    
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
    if_93cb2e49d64b42bb86352f57501eefa3: ; IF start
    pop rax
      test rax, rax
      je end_if_05c979742e4e4d3b9844e1ee6d33fe85
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_end
    end_if_05c979742e4e4d3b9844e1ee6d33fe85: ; END of if_93cb2e49d64b42bb86352f57501eefa3
    
    if_f8a9e76e170a4ae2942fb190e2df0b7e: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_c7e629d464af4b6ba5cda7994dc1c87b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_end
    end_if_c7e629d464af4b6ba5cda7994dc1c87b: ; END of if_f8a9e76e170a4ae2942fb190e2df0b7e
    
    if_e65d82f60fc2479db33b94dd2fb42a12: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jne end_if_3cef52ed164f4f779559390e521c111a
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_end
    end_if_3cef52ed164f4f779559390e521c111a: ; END of if_e65d82f60fc2479db33b94dd2fb42a12
    
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
    if_8495c07fa1fa41179ca7b272c82d3a10: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      ja end_if_c5eaeda7ee64408e9f29d31f981f2529
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    while_80d7e1314ced42a7987086101908979b: ; WHILE start
    mov rax, qword [rbp + 16]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_635281d03b754599b9caba8ceadaee0e
    
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
      jmp while_80d7e1314ced42a7987086101908979b ; Reevaluate WHILE condition
    end_while_635281d03b754599b9caba8ceadaee0e: ; END of while_80d7e1314ced42a7987086101908979b
    
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
      
      jmp func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_end
    end_if_c5eaeda7ee64408e9f29d31f981f2529: ; END of if_8495c07fa1fa41179ca7b272c82d3a10
    
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
    if_92a57b24c825479189103696b9a2ac97: ; IF start
    mov rax, qword [rbp - 64]
      mov rcx, rax
      mov rax, qword [rbp - 72]
      cmp rax, rcx
      jne end_if_5d0c865306714a49b14121825b1dd44d
    
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
    if_8b42115a5ef34b53b0b82192235f9dac: ; IF start
    mov rax, qword [rbp - 88]
      mov rcx, rax
      mov rax, qword [rbp - 80]
      cmp rax, rcx
      ja end_if_4965ab57d2ee4e5f884e0b03a1e8bbd0
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    while_218f449614ea4c1b836dce3584040210: ; WHILE start
    mov rax, qword [rbp - 56]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_f5848810ee53465d99fc73d6120fc093
    
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
      jmp while_218f449614ea4c1b836dce3584040210 ; Reevaluate WHILE condition
    end_while_f5848810ee53465d99fc73d6120fc093: ; END of while_218f449614ea4c1b836dce3584040210
    
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
      
      jmp func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_end
    end_if_4965ab57d2ee4e5f884e0b03a1e8bbd0: ; END of if_8b42115a5ef34b53b0b82192235f9dac
    
    end_if_5d0c865306714a49b14121825b1dd44d: ; END of if_92a57b24c825479189103696b9a2ac97
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call func_4172656E61416C6C6F63_f51801c44a2e4ce7b6f26b46952d3171_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_3827169764b1486a90b3e42816ec5381: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      jne end_if_1e587ae79c424c56ba7ee2e07c941db2
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_end
    end_if_1e587ae79c424c56ba7ee2e07c941db2: ; END of if_3827169764b1486a90b3e42816ec5381
    
    while_5ac91c9c58334b549103bb92c77afb7a: ; WHILE start
    mov rax, qword [rbp - 24]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_26d2e5aee6914da8a2cf17831d7d9b01
    
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
      jmp while_5ac91c9c58334b549103bb92c77afb7a ; Reevaluate WHILE condition
    end_while_26d2e5aee6914da8a2cf17831d7d9b01: ; END of while_5ac91c9c58334b549103bb92c77afb7a
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    call func_4172656E6146726565_20ada29a5e40485aa1415a50286ce724_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp - 32]
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_end
    func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61417070656E645570706572_0a4fd63da7874371b3a7fe9f24803dcc_start:
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
    if_63bf4ce1ad7c46379011a3f810a747f7: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jbe end_if_5ee03445915648c5bf57dcd0fa72cd59
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_0a4fd63da7874371b3a7fe9f24803dcc_end
    end_if_5ee03445915648c5bf57dcd0fa72cd59: ; END of if_63bf4ce1ad7c46379011a3f810a747f7
    
    if_b51b534582a642878f5198260d72f831: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_2501617f5a004e3b8d5542e953b5edda
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_0a4fd63da7874371b3a7fe9f24803dcc_end
    end_if_2501617f5a004e3b8d5542e953b5edda: ; END of if_b51b534582a642878f5198260d72f831
    
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
    if_a7373a284fef4f94a1b694cfccda6bf9: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jbe end_if_962111a81f79434d8e8e9c4bb5e9110f
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_0a4fd63da7874371b3a7fe9f24803dcc_end
    end_if_962111a81f79434d8e8e9c4bb5e9110f: ; END of if_a7373a284fef4f94a1b694cfccda6bf9
    
    if_6ab18839f62d430386bffc71d7bc8d36: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jne end_if_143a745475dd42619f7355eb8294162d
    
    if_9488ad76fc8240bcb538478ffb557066: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_889d385263fa4b3c9b79d274e314f343
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_0a4fd63da7874371b3a7fe9f24803dcc_end
    end_if_889d385263fa4b3c9b79d274e314f343: ; END of if_9488ad76fc8240bcb538478ffb557066
    
    mov rax, 0x0000000000000008
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
      jmp end_else_f4816295c0b44d138f292279af0683e4     ; Jump over ELSE part
    end_if_143a745475dd42619f7355eb8294162d:    ; if_6ab18839f62d430386bffc71d7bc8d36 END
    else_6f9dc1a2d0704b59a777790e5fecb43a:  ; Start ELSE block
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_d6816e297e594dabbdffccb04d8fabd2: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_b172a0a275284eecafee721ab362338d
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_0a4fd63da7874371b3a7fe9f24803dcc_end
    end_if_b172a0a275284eecafee721ab362338d: ; END of if_d6816e297e594dabbdffccb04d8fabd2
    
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
    if_1d42bbbd72674f5e95f04f62bd810ea9: ; IF start
    pop rax
      test rax, rax
      je end_if_631cb0344bd045a4a92334597f699a90
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_0a4fd63da7874371b3a7fe9f24803dcc_end
    end_if_631cb0344bd045a4a92334597f699a90: ; END of if_1d42bbbd72674f5e95f04f62bd810ea9
    
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
    if_6dc947e1556b40c18d1fc73d33e4bb06: ; IF start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jb end_if_36ffb114d2864192934c3a4b08fbcf95
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_0a4fd63da7874371b3a7fe9f24803dcc_end
    end_if_36ffb114d2864192934c3a4b08fbcf95: ; END of if_6dc947e1556b40c18d1fc73d33e4bb06
    
    end_else_f4816295c0b44d138f292279af0683e4: ; END of else_6f9dc1a2d0704b59a777790e5fecb43a
    
    while_9c2e369bf1044c24ae53758523c77db7: ; WHILE start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_97514122bce34ddfadd387a8ae3395cc
    
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
      jmp while_9c2e369bf1044c24ae53758523c77db7 ; Reevaluate WHILE condition
    end_while_97514122bce34ddfadd387a8ae3395cc: ; END of while_9c2e369bf1044c24ae53758523c77db7
    
    if_639756985a574a34adacdccf9d5ae1d9: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jne end_if_0d9aa5fd8e2443019bf467303ae002da
    
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61416C6C6F63_f51801c44a2e4ce7b6f26b46952d3171_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
      jmp end_else_a159fecbf81a42d6a006ff5d0bf05efe     ; Jump over ELSE part
    end_if_0d9aa5fd8e2443019bf467303ae002da:    ; if_639756985a574a34adacdccf9d5ae1d9 END
    else_973d171ac5124279b5a475803e1da4bd:  ; Start ELSE block
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_start
      add rsp, 24
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_else_a159fecbf81a42d6a006ff5d0bf05efe: ; END of else_973d171ac5124279b5a475803e1da4bd
    
    if_f9e6c5467e1b4e5785a9cb96e2a64e5b: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      jne end_if_50f67726bae744329db2244f3ae3dfe4
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_0a4fd63da7874371b3a7fe9f24803dcc_end
    end_if_50f67726bae744329db2244f3ae3dfe4: ; END of if_f9e6c5467e1b4e5785a9cb96e2a64e5b
    
    while_daa2260265544b188eec92e3b68fcff5: ; WHILE start
    mov rax, qword [rbp + 16]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_600f49a6b67e45f18b0ed8c87058d238
    
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
    if_f5ac471388cc42a4aaf6736f738e9ddd: ; IF start
    mov rcx, 97
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      jb end_if_9ff09249a3e84dfc8474d89c07d40e5e
    
    if_bad491c14d0e4d38a6ce01ad7c56cfbd: ; IF start
    mov rcx, 122
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      ja end_if_e47ba42581de4fe9a6ff14a2a00e9d36
    
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
    end_if_e47ba42581de4fe9a6ff14a2a00e9d36: ; END of if_bad491c14d0e4d38a6ce01ad7c56cfbd
    
    end_if_9ff09249a3e84dfc8474d89c07d40e5e: ; END of if_f5ac471388cc42a4aaf6736f738e9ddd
    
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
      jmp while_daa2260265544b188eec92e3b68fcff5 ; Reevaluate WHILE condition
    end_while_600f49a6b67e45f18b0ed8c87058d238: ; END of while_daa2260265544b188eec92e3b68fcff5
    
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
      
      jmp func_4172656E61417070656E645570706572_0a4fd63da7874371b3a7fe9f24803dcc_end
    func_4172656E61417070656E645570706572_0a4fd63da7874371b3a7fe9f24803dcc_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61496E766F6B65_2ab2bed91f674222902777fde7d2a866_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_a6eb2d4666a443b78365f6820dc8f4bc: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_3c1b7a1b9bea44098af72d4f79cde8c7
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E61496E766F6B65_2ab2bed91f674222902777fde7d2a866_end
    end_if_3c1b7a1b9bea44098af72d4f79cde8c7: ; END of if_a6eb2d4666a443b78365f6820dc8f4bc
    
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
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E6150696E_1806317aa59541d8af9a4c574fa474fb_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_d037dbf4854e40ac94554d34ff3a220e: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_4cadb11064034f909334441ffde6335b
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E61496E766F6B65_2ab2bed91f674222902777fde7d2a866_end
    end_if_4cadb11064034f909334441ffde6335b: ; END of if_d037dbf4854e40ac94554d34ff3a220e
    
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E6146726565_20ada29a5e40485aa1415a50286ce724_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000018
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
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_start
      add rsp, 24
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    mov rax, qword [rbp + 16]
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
      mov qword [rax], rcx
    if_6f248e2ea7b24721830a5d7d1d263cbe: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_070a3c0b091145ca9dee74ce01c55228
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_Touch
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    end_if_070a3c0b091145ca9dee74ce01c55228: ; END of if_6f248e2ea7b24721830a5d7d1d263cbe
    
    if_cbf5d493568e4f58a810956216eaa5de: ; IF start
    mov rcx, 1
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_d87bac5ae3704989b2f0bad9b1b53878
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_HeaderAttack
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    end_if_d87bac5ae3704989b2f0bad9b1b53878: ; END of if_cbf5d493568e4f58a810956216eaa5de
    
    if_e0fb29dfcdca4b15b36c1b79908e56b9: ; IF start
    mov rcx, 2
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_449ccbe86e284fc391185338ad678a65
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_Escape
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    end_if_449ccbe86e284fc391185338ad678a65: ; END of if_e0fb29dfcdca4b15b36c1b79908e56b9
    
    if_a7c7ef112fd944aa835353075b4818a5: ; IF start
    mov rcx, 3
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_02a33f9ed5f84a22ae31d4a7b65773b7
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_Spin
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    end_if_02a33f9ed5f84a22ae31d4a7b65773b7: ; END of if_a7c7ef112fd944aa835353075b4818a5
    
    if_edcdbc6416c54278bb69fd7a11bb50a1: ; IF start
    mov rcx, 4
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_40999250c8a3465388767eeca38ee5c1
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_Spin
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    end_if_40999250c8a3465388767eeca38ee5c1: ; END of if_edcdbc6416c54278bb69fd7a11bb50a1
    
    if_4a2097a7710741ae8eee46d56e817892: ; IF start
    mov rcx, 5
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_07a775f74127457389ab97166208b741
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_Negative
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    end_if_07a775f74127457389ab97166208b741: ; END of if_4a2097a7710741ae8eee46d56e817892
    
    if_624162d6faab41f281f451b5c91317c6: ; IF start
    mov rcx, 6
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_e6e831cb0ab9482fa53f4a179c3968e3
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_ReadOnly
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    end_if_e6e831cb0ab9482fa53f4a179c3968e3: ; END of if_624162d6faab41f281f451b5c91317c6
    
    if_365bf43dc39f45fa845c0ebc5e5220fd: ; IF start
    mov rcx, 7
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_21aba88516ff40ee98690de6ac04af20
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_Touch
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    end_if_21aba88516ff40ee98690de6ac04af20: ; END of if_365bf43dc39f45fa845c0ebc5e5220fd
    
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E61556E70696E_64f25430aed94371a64c4abf3bef5748_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    mov rax, qword [rbp - 40]
      push rax
    pop rax
      
      jmp func_4172656E61496E766F6B65_2ab2bed91f674222902777fde7d2a866_end
    func_4172656E61496E766F6B65_2ab2bed91f674222902777fde7d2a866_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4C6F616E4D61696E_eded1d51a10d450bbbbd22210a0eaaf2_start:
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
    mov rax, 0x00000000000003E8
      mov qword [rbp - 56], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 64], rax
    if_054a3f47f1f34e74936c3698f330dc44: ; IF start
    mov rcx, 1200
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_8dc0b01a26f44a33af3a3270bb2cc4bf
    
    mov rax, 0xFFFFFFFFFFFFFFF6
      push rax
    pop rax
      
      jmp func_4C6F616E4D61696E_eded1d51a10d450bbbbd22210a0eaaf2_end
    end_if_8dc0b01a26f44a33af3a3270bb2cc4bf: ; END of if_054a3f47f1f34e74936c3698f330dc44
    
    mov rax, qword [rbp + 40]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000090
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000400
      push rax
    call func_4172656E61496E6974_7325f9dfeed645bd9b734fc1cf89bef5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    call func_4172656E61416C6C6F63_f51801c44a2e4ce7b6f26b46952d3171_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_4f623b630caf4dd79be696e2d65e6072: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_d122110cd9a8488ba5272313b6cb4f68
    
    mov rax, 0xFFFFFFFFFFFFFFF5
      push rax
    pop rax
      
      jmp func_4C6F616E4D61696E_eded1d51a10d450bbbbd22210a0eaaf2_end
    end_if_d122110cd9a8488ba5272313b6cb4f68: ; END of if_4f623b630caf4dd79be696e2d65e6072
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000011
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    if_81d9411ebbcb430d904da34d28207f85: ; IF start
    mov rcx, 3
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_04de88e5eb6940e9a1b799e170990c22
    
    mov rax, 0x0000000000000019
      push rax
    pop rax
      
      mov qword [rbp - 56], rax
    end_if_04de88e5eb6940e9a1b799e170990c22: ; END of if_81d9411ebbcb430d904da34d28207f85
    
    if_db49933eb8524c8cbbdfadbdb735c21b: ; IF start
    mov rcx, 4
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_e386f9d30343461ebbc98de9e37a2192
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 56], rax
    end_if_e386f9d30343461ebbc98de9e37a2192: ; END of if_db49933eb8524c8cbbdfadbdb735c21b
    
    if_79c7f29651da4181aeced717aba6b289: ; IF start
    mov rcx, 7
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_a0f2538cdc4b46fe9ecac288d497fe99
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6150696E_1806317aa59541d8af9a4c574fa474fb_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    end_if_a0f2538cdc4b46fe9ecac288d497fe99: ; END of if_79c7f29651da4181aeced717aba6b289
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 56]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E61496E766F6B65_2ab2bed91f674222902777fde7d2a866_start
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 64], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 64]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6146696E64_b968d93e22bd475d9f4dd307810e2922_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000028
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 32]
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
    mov rax, 0x0000000000000030
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    if_3e89ae8705f444bfbcdbfb8758bceb31: ; IF start
    mov rcx, 7
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_496bfffffba84a49b1cda641c816db8c
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6146726565_20ada29a5e40485aa1415a50286ce724_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    if_a3fde2f62cb8480bb95d56fa713b886d: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      je end_if_707363c82c9e4288b00a691d2e4ca84a
    
    mov rax, 0xFFFFFFFFFFFFFFF4
      push rax
    pop rax
      
      jmp func_4C6F616E4D61696E_eded1d51a10d450bbbbd22210a0eaaf2_end
    end_if_707363c82c9e4288b00a691d2e4ca84a: ; END of if_a3fde2f62cb8480bb95d56fa713b886d
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61556E70696E_64f25430aed94371a64c4abf3bef5748_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    end_if_496bfffffba84a49b1cda641c816db8c: ; END of if_3e89ae8705f444bfbcdbfb8758bceb31
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, 0x00000000000003E8
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000050
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E61496E766F6B65_2ab2bed91f674222902777fde7d2a866_start
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000040
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 48]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000048
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000060
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
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000010
      push rax
    call func_4172656E61526573697A65_b8aa4a986b2c48c9aa5f727ad2e3b959_start
      add rsp, 24
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_415f6ed35487455786d0bcac2f3f866f: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_5df49810fa7c454f94e7407b68007bd7
    
    mov rax, 0xFFFFFFFFFFFFFFF3
      push rax
    pop rax
      
      jmp func_4C6F616E4D61696E_eded1d51a10d450bbbbd22210a0eaaf2_end
    end_if_5df49810fa7c454f94e7407b68007bd7: ; END of if_415f6ed35487455786d0bcac2f3f866f
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000080
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 40]
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 40]
      push rax
    call func_4172656E6146726565_20ada29a5e40485aa1415a50286ce724_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000038
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 48]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 64]
      push rax
    pop rax
      
      jmp func_4C6F616E4D61696E_eded1d51a10d450bbbbd22210a0eaaf2_end
    func_4C6F616E4D61696E_eded1d51a10d450bbbbd22210a0eaaf2_end:
      mov rsp, rbp
      pop rbp
      ret
module_6172656E615F63616C6C6572_d23abf86a32c433ba60fcfad4ca6fe4f_end:

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
ubytec_import_Touch:
 push rbp
 mov rbp,rsp
 push 1
 add rsp,8
 sub rsp,48
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
ubytec_import_HeaderAttack:
 push rbp
 mov rbp,rsp
 push 2
 add rsp,8
 sub rsp,48
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
ubytec_import_Escape:
 push rbp
 mov rbp,rsp
 push 3
 add rsp,8
 sub rsp,48
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
 mov rdi,3
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
ubytec_import_Spin:
 push rbp
 mov rbp,rsp
 push 4
 add rsp,8
 sub rsp,48
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
ubytec_import_Negative:
 push rbp
 mov rbp,rsp
 push 5
 add rsp,8
 sub rsp,48
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
 mov rdi,5
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
ubytec_import_ReadOnly:
 push rbp
 mov rbp,rsp
 push 6
 add rsp,8
 sub rsp,48
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
 mov rdi,6
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
global ubytec_host_contract_LoanMain
ubytec_host_contract_LoanMain:
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
call func_4C6F616E4D61696E_eded1d51a10d450bbbbd22210a0eaaf2_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,73,124,49,124,84,111,117,99,104,124,97,114,101,110,97,95,114,101,99,101,105,118,101,114,124,84,111,117,99,104,124,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,50,124,72,101,97,100,101,114,65,116,116,97,99,107,124,97,114,101,110,97,95,114,101,99,101,105,118,101,114,124,72,101,97,100,101,114,65,116,116,97,99,107,124,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,51,124,69,115,99,97,112,101,124,97,114,101,110,97,95,114,101,99,101,105,118,101,114,124,69,115,99,97,112,101,124,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,52,124,83,112,105,110,124,97,114,101,110,97,95,114,101,99,101,105,118,101,114,124,83,112,105,110,124,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,53,124,78,101,103,97,116,105,118,101,124,97,114,101,110,97,95,114,101,99,101,105,118,101,114,124,78,101,103,97,116,105,118,101,124,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,54,124,82,101,97,100,79,110,108,121,124,97,114,101,110,97,95,114,101,99,101,105,118,101,114,124,82,101,97,100,79,110,108,121,124,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,76,111,97,110,77,97,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,76,111,97,110,77,97,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
