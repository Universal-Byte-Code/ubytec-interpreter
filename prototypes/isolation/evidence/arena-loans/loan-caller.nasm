  module_6172656E615F63616C6C6572_2d03f8c333194be1852e7874ca39591e_start:
  ; Module: arena_caller v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 10:09:36Z
    ; Module UUID: 2d03f8c3-3319-4be1-852e-7874ca39591e


    section .bss

    section .text

    func_4172656E61496E6974_0ba395dc1c7e42f3b4964f7321f67259_start:
    push rbp
      mov rbp, rsp
    if_3b12baa06a9d4d789f869142f4efc78f: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_6ef8dd9434d54415a77d36b8b09060f6
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61496E6974_0ba395dc1c7e42f3b4964f7321f67259_end
    end_if_6ef8dd9434d54415a77d36b8b09060f6: ; END of if_3b12baa06a9d4d789f869142f4efc78f
    
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
      
      jmp func_4172656E61496E6974_0ba395dc1c7e42f3b4964f7321f67259_end
    func_4172656E61496E6974_0ba395dc1c7e42f3b4964f7321f67259_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_start:
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
    while_e7fdd13b11914ec4ad9ae7bb853d7e69: ; WHILE start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jae end_while_3ce035e22a7941b29709c4b6fcab76b0
    
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
    if_ba213b7bbb51464190b645316bb4a883: ; IF start
    pop rax
      test rax, rax
      je end_if_d906de77257c437bbe6f5e33722dffe7
    
      jmp end_else_9fd4b386cd0a40b2a7dc52539b157793     ; Jump over ELSE part
    end_if_d906de77257c437bbe6f5e33722dffe7:    ; if_ba213b7bbb51464190b645316bb4a883 END
    else_3c4c9f8ec6c341bb92b36d14c59805ed:  ; Start ELSE block
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
    if_383c8883b30340e0856f126f3d40adae: ; IF start
    pop rax
      test rax, rax
      je end_if_7aed20a62b8f4c4182859eeea69f5e8d
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_end
    end_if_7aed20a62b8f4c4182859eeea69f5e8d: ; END of if_383c8883b30340e0856f126f3d40adae
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_end
    end_else_9fd4b386cd0a40b2a7dc52539b157793: ; END of else_3c4c9f8ec6c341bb92b36d14c59805ed
    
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
      jmp while_e7fdd13b11914ec4ad9ae7bb853d7e69 ; Reevaluate WHILE condition
    end_while_3ce035e22a7941b29709c4b6fcab76b0: ; END of while_e7fdd13b11914ec4ad9ae7bb853d7e69
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_end
    func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61416C6C6F63_80f027a96a7c4238b6f614bdddd58c2d_start:
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
    if_3ac2842d45894c96915037d93f98d558: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_e4116ef0d6ce4c1586a47cb435b47759
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_80f027a96a7c4238b6f614bdddd58c2d_end
    end_if_e4116ef0d6ce4c1586a47cb435b47759: ; END of if_3ac2842d45894c96915037d93f98d558
    
    if_7e6f964acedf47e6a6e8db965ab6bce8: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jne end_if_5045cea648434e4084addfed43fee53b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_80f027a96a7c4238b6f614bdddd58c2d_end
    end_if_5045cea648434e4084addfed43fee53b: ; END of if_7e6f964acedf47e6a6e8db965ab6bce8
    
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
    while_4c5f0ff663c046289ef41125b4347d83: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_e37a107759d14cd5a3471f898228efb3
    
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
    if_7ee5637ea97644d1b461567d05d3536c: ; IF start
    pop rax
      test rax, rax
      je end_if_4c061bc3f2bc488db167abb3ca085463
    
      jmp end_else_570b3e1789184d468582015257be7ebb     ; Jump over ELSE part
    end_if_4c061bc3f2bc488db167abb3ca085463:    ; if_7ee5637ea97644d1b461567d05d3536c END
    else_47951aca72ef4223adc655c672cd7a01:  ; Start ELSE block
    if_ffabdfea11314b3b90efc9309febbe97: ; IF start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jb end_if_5694b8bb36d14d64957def963fbde798
    
    jmp end_while_e37a107759d14cd5a3471f898228efb3 ; BREAK
    end_if_5694b8bb36d14d64957def963fbde798: ; END of if_ffabdfea11314b3b90efc9309febbe97
    
    end_else_570b3e1789184d468582015257be7ebb: ; END of else_47951aca72ef4223adc655c672cd7a01
    
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
      jmp while_4c5f0ff663c046289ef41125b4347d83 ; Reevaluate WHILE condition
    end_while_e37a107759d14cd5a3471f898228efb3: ; END of while_4c5f0ff663c046289ef41125b4347d83
    
    if_51a54dc63b3c43fb91f22ffbc697fbf9: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_6aa013122b124f92a5b9ae815f6fc23b
    
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
    if_36c4eb227f7248adbf48bdff2aaa0eef: ; IF start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jbe end_if_ce313948fcbe4b69a6ecfb61a4297835
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_80f027a96a7c4238b6f614bdddd58c2d_end
    end_if_ce313948fcbe4b69a6ecfb61a4297835: ; END of if_36c4eb227f7248adbf48bdff2aaa0eef
    
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
    end_if_6aa013122b124f92a5b9ae815f6fc23b: ; END of if_51a54dc63b3c43fb91f22ffbc697fbf9
    
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
    while_22bfdd79c24e4dc5a4e40f09e3820ea5: ; WHILE start
    mov rax, qword [rbp - 40]
      mov rcx, rax
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jae end_while_ee53eeb0846842dbbebc3623c04763f8
    
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
      jmp while_22bfdd79c24e4dc5a4e40f09e3820ea5 ; Reevaluate WHILE condition
    end_while_ee53eeb0846842dbbebc3623c04763f8: ; END of while_22bfdd79c24e4dc5a4e40f09e3820ea5
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_80f027a96a7c4238b6f614bdddd58c2d_end
    func_4172656E61416C6C6F63_80f027a96a7c4238b6f614bdddd58c2d_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6150696E_b217c48950f749e180d7bbd05b3b267d_start:
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
    call func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_21581e6c40304565bafafab6aaa1f2e0: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_40d8ebf043f9448cb3eed74f8f632c05
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6150696E_b217c48950f749e180d7bbd05b3b267d_end
    end_if_40d8ebf043f9448cb3eed74f8f632c05: ; END of if_21581e6c40304565bafafab6aaa1f2e0
    
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
    if_9fd2d81b02db47b0afa0f46608e1f934: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jb end_if_8000824f290143d2adc4d9b9fa93be0b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6150696E_b217c48950f749e180d7bbd05b3b267d_end
    end_if_8000824f290143d2adc4d9b9fa93be0b: ; END of if_9fd2d81b02db47b0afa0f46608e1f934
    
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
      
      jmp func_4172656E6150696E_b217c48950f749e180d7bbd05b3b267d_end
    func_4172656E6150696E_b217c48950f749e180d7bbd05b3b267d_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61556E70696E_10ce7a9086e443c0a5ac42b74548fb2d_start:
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
    call func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_2da7dcadad6248f8aa4d75194de9fc81: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_9d187d2e710d4f91bae261daba4bee17
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61556E70696E_10ce7a9086e443c0a5ac42b74548fb2d_end
    end_if_9d187d2e710d4f91bae261daba4bee17: ; END of if_2da7dcadad6248f8aa4d75194de9fc81
    
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
    if_3f58d629c5eb430a9ce3fc5d140d39ed: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_c1b89f4ddb12481ab02d832a055aced3
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61556E70696E_10ce7a9086e443c0a5ac42b74548fb2d_end
    end_if_c1b89f4ddb12481ab02d832a055aced3: ; END of if_3f58d629c5eb430a9ce3fc5d140d39ed
    
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
      
      jmp func_4172656E61556E70696E_10ce7a9086e443c0a5ac42b74548fb2d_end
    func_4172656E61556E70696E_10ce7a9086e443c0a5ac42b74548fb2d_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6146726565_815e63aab4e14de7887f4da13a600205_start:
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
    call func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_fa3ee9e8e25a4b2eb130e92f5cc9835d: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_1e9e70ef4c1e47ad86b5a08b8452b499
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146726565_815e63aab4e14de7887f4da13a600205_end
    end_if_1e9e70ef4c1e47ad86b5a08b8452b499: ; END of if_fa3ee9e8e25a4b2eb130e92f5cc9835d
    
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
    if_ed56a21bb1674964b09341085f787d13: ; IF start
    pop rax
      test rax, rax
      je end_if_0a2ff6b04c5748458f69ff5ea2e97dc5
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146726565_815e63aab4e14de7887f4da13a600205_end
    end_if_0a2ff6b04c5748458f69ff5ea2e97dc5: ; END of if_ed56a21bb1674964b09341085f787d13
    
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
    while_d51a79ddaaf34e8cafee022c890cd756: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_99c0c8d66af345c48e476da7420eabb8
    
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
    if_e3636fce1471406192502e837ba236d7: ; IF start
    pop rax
      test rax, rax
      je end_if_077cf3e5dc6e413b824971f7f971d8c4
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_if_077cf3e5dc6e413b824971f7f971d8c4: ; END of if_e3636fce1471406192502e837ba236d7
    
      jmp while_d51a79ddaaf34e8cafee022c890cd756 ; Reevaluate WHILE condition
    end_while_99c0c8d66af345c48e476da7420eabb8: ; END of while_d51a79ddaaf34e8cafee022c890cd756
    
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
      
      jmp func_4172656E6146726565_815e63aab4e14de7887f4da13a600205_end
    func_4172656E6146726565_815e63aab4e14de7887f4da13a600205_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_start:
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
    call func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_3751755523164300bc4af1f0015ffbf8: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_39d736d136b64e72b6555ef3f98dadf3
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_end
    end_if_39d736d136b64e72b6555ef3f98dadf3: ; END of if_3751755523164300bc4af1f0015ffbf8
    
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
    if_b373a12056134f4d995dacf49be5f246: ; IF start
    pop rax
      test rax, rax
      je end_if_e3094bad8b6140f9ad42c27ead300c77
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_end
    end_if_e3094bad8b6140f9ad42c27ead300c77: ; END of if_b373a12056134f4d995dacf49be5f246
    
    if_b755f70faf354974bf0ab6a48c8a83c8: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_71cba6ec82014c49ade5621d6997c3af
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_end
    end_if_71cba6ec82014c49ade5621d6997c3af: ; END of if_b755f70faf354974bf0ab6a48c8a83c8
    
    if_8db7e5f7215e446c956d342e56b866af: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jne end_if_20ac8d52fe0144ccbe760016a259413f
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_end
    end_if_20ac8d52fe0144ccbe760016a259413f: ; END of if_8db7e5f7215e446c956d342e56b866af
    
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
    if_a2065d1456d649babd8b420c710bfd47: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      ja end_if_3336bf1856084ff19ce667956e5e90c0
    
    if_4a6a8b46f9a440d89873af10e31bfb42: ; IF start
    mov rax, qword [rbp - 24]
      mov rcx, rax
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_d6cec3ee98a4402cb92c7e3f91e75dff
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    while_7005dab069d4471e8457d733b6e6bc6a: ; WHILE start
    mov rax, qword [rbp + 16]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_fabfb33198ec4ec0941c1d72e381e14e
    
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
      jmp while_7005dab069d4471e8457d733b6e6bc6a ; Reevaluate WHILE condition
    end_while_fabfb33198ec4ec0941c1d72e381e14e: ; END of while_7005dab069d4471e8457d733b6e6bc6a
    
    end_if_d6cec3ee98a4402cb92c7e3f91e75dff: ; END of if_4a6a8b46f9a440d89873af10e31bfb42
    
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
      
      jmp func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_end
    end_if_3336bf1856084ff19ce667956e5e90c0: ; END of if_a2065d1456d649babd8b420c710bfd47
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call func_4172656E61416C6C6F63_80f027a96a7c4238b6f614bdddd58c2d_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_32336d5c6fd640b7bc7e3d77a2f95e66: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      jne end_if_a704eb30393240fc97b61d84df4afbb6
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_end
    end_if_a704eb30393240fc97b61d84df4afbb6: ; END of if_32336d5c6fd640b7bc7e3d77a2f95e66
    
    while_20f369ed9092458f8b057c3d03cd7c36: ; WHILE start
    mov rax, qword [rbp - 24]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_6c5392c6fb5646f287e9d519a866fc7a
    
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
      jmp while_20f369ed9092458f8b057c3d03cd7c36 ; Reevaluate WHILE condition
    end_while_6c5392c6fb5646f287e9d519a866fc7a: ; END of while_20f369ed9092458f8b057c3d03cd7c36
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    call func_4172656E6146726565_815e63aab4e14de7887f4da13a600205_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp - 32]
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_end
    func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61417070656E645570706572_ac1a5570ae344c05ba198abba9fe0185_start:
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
    if_bef66b149e5140779c6eaf1c172aa02c: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jbe end_if_9ceea8156cae4121a83c64914276c71e
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_ac1a5570ae344c05ba198abba9fe0185_end
    end_if_9ceea8156cae4121a83c64914276c71e: ; END of if_bef66b149e5140779c6eaf1c172aa02c
    
    if_a3cc71b1351c43978db4d3c028e14e18: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_ff45bf23d05641f99e8f54929a503fff
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_ac1a5570ae344c05ba198abba9fe0185_end
    end_if_ff45bf23d05641f99e8f54929a503fff: ; END of if_a3cc71b1351c43978db4d3c028e14e18
    
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
    if_0afa9894057845e0914670883362cdc7: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jbe end_if_bcc9945920574f10acc5c7659e457775
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_ac1a5570ae344c05ba198abba9fe0185_end
    end_if_bcc9945920574f10acc5c7659e457775: ; END of if_0afa9894057845e0914670883362cdc7
    
    if_b2411ef377744d649510fb9f10e63654: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jne end_if_9d351ab5a7b74720a7651586a3e3247d
    
    if_219d355942774147ac0e4b0381ab4a78: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_51b1dff91e114e1bbbcd5c9fce111f6a
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_ac1a5570ae344c05ba198abba9fe0185_end
    end_if_51b1dff91e114e1bbbcd5c9fce111f6a: ; END of if_219d355942774147ac0e4b0381ab4a78
    
    mov rax, 0x0000000000000008
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
      jmp end_else_b50fff4921404995a4abe2732b011d56     ; Jump over ELSE part
    end_if_9d351ab5a7b74720a7651586a3e3247d:    ; if_b2411ef377744d649510fb9f10e63654 END
    else_f613d06cc474489a93ed8cd8327720aa:  ; Start ELSE block
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_5d06295806624d5699f3de3e11e185fe: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_a0993adfbd3d4d1bbc0d9a99be4e965f
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_ac1a5570ae344c05ba198abba9fe0185_end
    end_if_a0993adfbd3d4d1bbc0d9a99be4e965f: ; END of if_5d06295806624d5699f3de3e11e185fe
    
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
    if_14e84978b286472995a3552c8e4d8f01: ; IF start
    pop rax
      test rax, rax
      je end_if_2e289e034af64edc8c9f808602003310
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_ac1a5570ae344c05ba198abba9fe0185_end
    end_if_2e289e034af64edc8c9f808602003310: ; END of if_14e84978b286472995a3552c8e4d8f01
    
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
    if_1e67c002fe7c40498dbacfe60eb11567: ; IF start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jb end_if_414a6acb5a1e4778a30d89856c456ea2
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_ac1a5570ae344c05ba198abba9fe0185_end
    end_if_414a6acb5a1e4778a30d89856c456ea2: ; END of if_1e67c002fe7c40498dbacfe60eb11567
    
    end_else_b50fff4921404995a4abe2732b011d56: ; END of else_f613d06cc474489a93ed8cd8327720aa
    
    while_22406d1c82994f4db5116639f0248772: ; WHILE start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_d5c13f77a3e746468c4a07141e8dd08a
    
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
      jmp while_22406d1c82994f4db5116639f0248772 ; Reevaluate WHILE condition
    end_while_d5c13f77a3e746468c4a07141e8dd08a: ; END of while_22406d1c82994f4db5116639f0248772
    
    if_941f61fae87f45c08c396db4452f6460: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jne end_if_28f403e37dfb4d949e2445635cdd5e5c
    
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61416C6C6F63_80f027a96a7c4238b6f614bdddd58c2d_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
      jmp end_else_7bbfa896956049f6908bc884e884dc1d     ; Jump over ELSE part
    end_if_28f403e37dfb4d949e2445635cdd5e5c:    ; if_941f61fae87f45c08c396db4452f6460 END
    else_050d14dd7b074c0aba2eea55799dae85:  ; Start ELSE block
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_start
      add rsp, 24
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_else_7bbfa896956049f6908bc884e884dc1d: ; END of else_050d14dd7b074c0aba2eea55799dae85
    
    if_e114461ad56c475c8a7a68d8181cfa2c: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      jne end_if_af5ab93f0daf44db92a7405c7a39ff67
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_ac1a5570ae344c05ba198abba9fe0185_end
    end_if_af5ab93f0daf44db92a7405c7a39ff67: ; END of if_e114461ad56c475c8a7a68d8181cfa2c
    
    while_bc229a9fccc04ad4a8449913b5274104: ; WHILE start
    mov rax, qword [rbp + 16]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_ec177f82b2c64532b00a3e88579c9e3c
    
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
    if_b9a90762fe53435caa4d360a92a1cc63: ; IF start
    mov rcx, 97
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      jb end_if_68b517c06f0e4e549680e72145f11841
    
    if_e0a05152a8db48cfaf4c9f9d42cebbd3: ; IF start
    mov rcx, 122
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      ja end_if_f9aabf0c4934479186c03dbe6d54f8ff
    
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
    end_if_f9aabf0c4934479186c03dbe6d54f8ff: ; END of if_e0a05152a8db48cfaf4c9f9d42cebbd3
    
    end_if_68b517c06f0e4e549680e72145f11841: ; END of if_b9a90762fe53435caa4d360a92a1cc63
    
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
      jmp while_bc229a9fccc04ad4a8449913b5274104 ; Reevaluate WHILE condition
    end_while_ec177f82b2c64532b00a3e88579c9e3c: ; END of while_bc229a9fccc04ad4a8449913b5274104
    
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
      
      jmp func_4172656E61417070656E645570706572_ac1a5570ae344c05ba198abba9fe0185_end
    func_4172656E61417070656E645570706572_ac1a5570ae344c05ba198abba9fe0185_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61496E766F6B65_5ea9e2a805fd4bdba58da9b7ea07c455_start:
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
    call func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_600610b64b044aa48fb3e92ac381953b: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_5ed9405346d8489ca06681c3ca970b1b
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E61496E766F6B65_5ea9e2a805fd4bdba58da9b7ea07c455_end
    end_if_5ed9405346d8489ca06681c3ca970b1b: ; END of if_600610b64b044aa48fb3e92ac381953b
    
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
    call func_4172656E6150696E_b217c48950f749e180d7bbd05b3b267d_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_46c766ff2649463fb27e920ff64bff60: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_8ae31bf095914253809e00d70d060865
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E61496E766F6B65_5ea9e2a805fd4bdba58da9b7ea07c455_end
    end_if_8ae31bf095914253809e00d70d060865: ; END of if_46c766ff2649463fb27e920ff64bff60
    
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E6146726565_815e63aab4e14de7887f4da13a600205_start
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
    call func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_start
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
    if_3105f2106f1545de808ae9fd47213022: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_5bd6037d7e524e99ba05a2ce544511aa
    
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
    end_if_5bd6037d7e524e99ba05a2ce544511aa: ; END of if_3105f2106f1545de808ae9fd47213022
    
    if_2e42d401a89c49e9a6e90d76b00ded02: ; IF start
    mov rcx, 1
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_042c9ba0c59f4a7584b712abb813ebff
    
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
    end_if_042c9ba0c59f4a7584b712abb813ebff: ; END of if_2e42d401a89c49e9a6e90d76b00ded02
    
    if_758d6b2ac8cd477c8822c79706ac74a9: ; IF start
    mov rcx, 2
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_0ac03a72281846c4a549a85d038d98e7
    
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
    end_if_0ac03a72281846c4a549a85d038d98e7: ; END of if_758d6b2ac8cd477c8822c79706ac74a9
    
    if_75cbb4edce504fff8de694f61dcc68b5: ; IF start
    mov rcx, 3
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_8f7a6ad7857d4c7595c35332bb548a5c
    
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
    end_if_8f7a6ad7857d4c7595c35332bb548a5c: ; END of if_75cbb4edce504fff8de694f61dcc68b5
    
    if_529197bb7f114bb7950c537faab74619: ; IF start
    mov rcx, 4
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_a445328d09d7492fb69491eb764af953
    
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
    end_if_a445328d09d7492fb69491eb764af953: ; END of if_529197bb7f114bb7950c537faab74619
    
    if_31be769f366c4c04893b1793823dc05e: ; IF start
    mov rcx, 5
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_5471aa15b827409b993a3f0e4940e38c
    
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
    end_if_5471aa15b827409b993a3f0e4940e38c: ; END of if_31be769f366c4c04893b1793823dc05e
    
    if_25d5f8ec6ff44051b20788c3b6b610eb: ; IF start
    mov rcx, 6
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_5014fb3f8b114bc29c6f19f7bd09428b
    
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
    end_if_5014fb3f8b114bc29c6f19f7bd09428b: ; END of if_25d5f8ec6ff44051b20788c3b6b610eb
    
    if_f5c3ebb3eb944e7fbc0b8d4f579adaa1: ; IF start
    mov rcx, 7
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jne end_if_43c0be6d219646d7bd8bb34281fc9c77
    
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
    end_if_43c0be6d219646d7bd8bb34281fc9c77: ; END of if_f5c3ebb3eb944e7fbc0b8d4f579adaa1
    
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E61556E70696E_10ce7a9086e443c0a5ac42b74548fb2d_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    mov rax, qword [rbp - 40]
      push rax
    pop rax
      
      jmp func_4172656E61496E766F6B65_5ea9e2a805fd4bdba58da9b7ea07c455_end
    func_4172656E61496E766F6B65_5ea9e2a805fd4bdba58da9b7ea07c455_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4C6F616E4D61696E_28c30a3cfda04f4492a1687051c2242b_start:
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
    if_54af5cdd87ac4f54be9972d56cb51ebb: ; IF start
    mov rcx, 1200
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_a82a740239ca43b29300ebdba1ae46b4
    
    mov rax, 0xFFFFFFFFFFFFFFF6
      push rax
    pop rax
      
      jmp func_4C6F616E4D61696E_28c30a3cfda04f4492a1687051c2242b_end
    end_if_a82a740239ca43b29300ebdba1ae46b4: ; END of if_54af5cdd87ac4f54be9972d56cb51ebb
    
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
    call func_4172656E61496E6974_0ba395dc1c7e42f3b4964f7321f67259_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    call func_4172656E61416C6C6F63_80f027a96a7c4238b6f614bdddd58c2d_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_98c99fc65f274e04b705b70eca15359f: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_a90bc60341fc436e91df7427bd5fb86b
    
    mov rax, 0xFFFFFFFFFFFFFFF5
      push rax
    pop rax
      
      jmp func_4C6F616E4D61696E_28c30a3cfda04f4492a1687051c2242b_end
    end_if_a90bc60341fc436e91df7427bd5fb86b: ; END of if_98c99fc65f274e04b705b70eca15359f
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000011
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    if_b4e7a7ab3bc44ab6b74379df8f5c0dc7: ; IF start
    mov rcx, 3
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_5fb60e3b3f0745b18808b35cf9bf2e5d
    
    mov rax, 0x0000000000000019
      push rax
    pop rax
      
      mov qword [rbp - 56], rax
    end_if_5fb60e3b3f0745b18808b35cf9bf2e5d: ; END of if_b4e7a7ab3bc44ab6b74379df8f5c0dc7
    
    if_e6cec849e506456c9049b00db9856fe8: ; IF start
    mov rcx, 4
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_30e51b491ed44694a5c5c7ed0d5cd743
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 56], rax
    end_if_30e51b491ed44694a5c5c7ed0d5cd743: ; END of if_e6cec849e506456c9049b00db9856fe8
    
    if_ae07deeb6a4e46768239fb7a506c1dd0: ; IF start
    mov rcx, 7
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_7ecd03d2a0da4e5e964ffbe56ac6194b
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6150696E_b217c48950f749e180d7bbd05b3b267d_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    end_if_7ecd03d2a0da4e5e964ffbe56ac6194b: ; END of if_ae07deeb6a4e46768239fb7a506c1dd0
    
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
    call func_4172656E61496E766F6B65_5ea9e2a805fd4bdba58da9b7ea07c455_start
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
    call func_4172656E6146696E64_9f6fd913549541c4958af247e85f6e29_start
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
    if_5b03d017a7a64e8bac43ef029d4f786f: ; IF start
    mov rcx, 7
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_b7c586f277334129a50569b53d221ffa
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6146726565_815e63aab4e14de7887f4da13a600205_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    if_469c239f649a4ad1ac99f5c8eeea5fb2: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      je end_if_31dca7298ba24292af1281012cf95dcf
    
    mov rax, 0xFFFFFFFFFFFFFFF4
      push rax
    pop rax
      
      jmp func_4C6F616E4D61696E_28c30a3cfda04f4492a1687051c2242b_end
    end_if_31dca7298ba24292af1281012cf95dcf: ; END of if_469c239f649a4ad1ac99f5c8eeea5fb2
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61556E70696E_10ce7a9086e443c0a5ac42b74548fb2d_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    end_if_b7c586f277334129a50569b53d221ffa: ; END of if_5b03d017a7a64e8bac43ef029d4f786f
    
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
    call func_4172656E61496E766F6B65_5ea9e2a805fd4bdba58da9b7ea07c455_start
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
    call func_4172656E61526573697A65_267aa8727b38497782c620c6fb98fb1b_start
      add rsp, 24
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_9bbe59c49c364078becae560ef140eb3: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_634edc8d84e54a9bad5b9d446ec3b004
    
    mov rax, 0xFFFFFFFFFFFFFFF3
      push rax
    pop rax
      
      jmp func_4C6F616E4D61696E_28c30a3cfda04f4492a1687051c2242b_end
    end_if_634edc8d84e54a9bad5b9d446ec3b004: ; END of if_9bbe59c49c364078becae560ef140eb3
    
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
    call func_4172656E6146726565_815e63aab4e14de7887f4da13a600205_start
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
      
      jmp func_4C6F616E4D61696E_28c30a3cfda04f4492a1687051c2242b_end
    func_4C6F616E4D61696E_28c30a3cfda04f4492a1687051c2242b_end:
      mov rsp, rbp
      pop rbp
      ret
module_6172656E615F63616C6C6572_2d03f8c333194be1852e7874ca39591e_end:

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
call func_4C6F616E4D61696E_28c30a3cfda04f4492a1687051c2242b_start
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
