  module_6172656E615F737472657373_f98db8e3d66449bfa8d42cee995aa753_start:
  ; Module: arena_stress v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 12:44:46Z
    ; Module UUID: f98db8e3-d664-49bf-a8d4-2cee995aa753


    section .bss

    section .text

    func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_start:
    push rbp
      mov rbp, rsp
    sub rsp, 112
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
    if_f3dbc59389914ab0b99cc2abd78cddf5: ; IF start
    mov rcx, 8352
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_cf5081631bda42f8abea8b19992e8e78
    
    mov rax, 0xFFFFFFFFFFFFFFF6
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_cf5081631bda42f8abea8b19992e8e78: ; END of if_f3dbc59389914ab0b99cc2abd78cddf5
    
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
    mov rax, 0x0000000000002000
      push rax
    call func_4172656E61496E6974_2af00264884a48f79835bbee2e41d685_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_fec2ce6f09b14ad5bdf3329a28db0483: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_d775c16354c041dab28d0315125352e3
    
    mov rax, 0xFFFFFFFFFFFFFFF5
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_d775c16354c041dab28d0315125352e3: ; END of if_fec2ce6f09b14ad5bdf3329a28db0483
    
    while_023d0f8e609e437ba7b1516ad70eb9a0: ; WHILE start
    mov rcx, 1024
      mov rax, qword [rbp - 64]
      cmp rax, rcx
      jae end_while_98d4760fd6934d608c3689dbc8f30f7e
    
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000040
      push rax
    pop rcx
      pop rax
      cqo
      idiv rcx
      push rdx
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      imul rax, rcx
      push rax
    mov rax, 0x0000000000000040
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000030
      push rax
    pop rcx
      pop rax
      cqo
      idiv rcx
      push rdx
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 56], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 48]
      push rax
    call func_4172656E61416C6C6F63_afccbce81fdf4619a9cbb9d6b2d1f720_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_937ac6a10d464d89a71c232d1e941c73: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_f6c43943666b46b8b16e2726675314e7
    
    mov rax, 0xFFFFFFFFFFFFFFF0
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_f6c43943666b46b8b16e2726675314e7: ; END of if_937ac6a10d464d89a71c232d1e941c73
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 48]
      push rax
    call func_4172656E61416C6C6F63_afccbce81fdf4619a9cbb9d6b2d1f720_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_27f8776bf1a34dcdafb3262f008cdb78: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_99186d1e024246b5a16e41bf73f25afb
    
    mov rax, 0xFFFFFFFFFFFFFFEF
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_99186d1e024246b5a16e41bf73f25afb: ; END of if_27f8776bf1a34dcdafb3262f008cdb78
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
    while_64a47b2f9c7841ac9ef1fb64a4682328: ; WHILE start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp - 72]
      cmp rax, rcx
      jae end_while_52bbc31b4e4f49749fb727da77c9ae7c
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000011
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 64]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x00000000000000FB
      push rax
    pop rcx
      pop rax
      cqo
      idiv rcx
      push rdx
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 72]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
      jmp while_64a47b2f9c7841ac9ef1fb64a4682328 ; Reevaluate WHILE condition
    end_while_52bbc31b4e4f49749fb727da77c9ae7c: ; END of while_64a47b2f9c7841ac9ef1fb64a4682328
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000002000
      push rax
    call func_4172656E61416C6C6F63_afccbce81fdf4619a9cbb9d6b2d1f720_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_0cfbfb31cf3146b59de4180760e79871: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_ba98d9f65a9d45a882817f58d2c681d5
    
    mov rax, 0xFFFFFFFFFFFFFFEE
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_ba98d9f65a9d45a882817f58d2c681d5: ; END of if_0cfbfb31cf3146b59de4180760e79871
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000002000
      push rax
    call func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_start
      add rsp, 24
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_f89130bd9bf648bcb3b6243463384572: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_fbcd0b2557204fe290077e64efc81234
    
    mov rax, 0xFFFFFFFFFFFFFFED
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_fbcd0b2557204fe290077e64efc81234: ; END of if_f89130bd9bf648bcb3b6243463384572
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_8d609c423363469495d3d735dd7fc9f6: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_7bcf85367f424d4cac3a2b607459db94
    
    mov rax, 0xFFFFFFFFFFFFFFEC
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_7bcf85367f424d4cac3a2b607459db94: ; END of if_8d609c423363469495d3d735dd7fc9f6
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E6146726565_6f206e1b6b98415495582c42ef8cc995_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_804d7b48a00e48c8a1402313475407ff: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_c6eb6db05efa4ffda093e84a330a605f
    
    mov rax, 0xFFFFFFFFFFFFFFEB
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_c6eb6db05efa4ffda093e84a330a605f: ; END of if_804d7b48a00e48c8a1402313475407ff
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 48]
      push rax
    call func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_start
      add rsp, 24
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_ba7c6ac4641e485f9e9dc4cca95ce073: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_a1db73b5f2b443f59a442a633a8de69f
    
    mov rax, 0xFFFFFFFFFFFFFFEA
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_a1db73b5f2b443f59a442a633a8de69f: ; END of if_ba7c6ac4641e485f9e9dc4cca95ce073
    
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      cqo
      idiv rcx
      push rdx
    pop rax
      
      mov qword [rbp - 88], rax
    if_d8f81018e92e46a4a96126e6bed231b7: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      jne end_if_213dbfcd27e44081ad43e2773467ae9b
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 56]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 56]
      push rax
    mov rax, qword [rbp - 56]
      push rax
    mov rax, 0x00000000000003E8
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000040
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    if_2f6284f0c9d24246ba4af07e4d037b05: ; IF start
    mov rcx, 2
      mov rax, qword [rbp - 112]
      cmp rax, rcx
      je end_if_7c53ea647ef8441590a9bb2123492293
    
    mov rax, 0xFFFFFFFFFFFFFFE9
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_7c53ea647ef8441590a9bb2123492293: ; END of if_2f6284f0c9d24246ba4af07e4d037b05
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_16862edfda4a495483edae2560f4ac7c: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_0297b190ba8f47db8d3d27f62ec6bc91
    
    mov rax, 0xFFFFFFFFFFFFFFF4
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_0297b190ba8f47db8d3d27f62ec6bc91: ; END of if_16862edfda4a495483edae2560f4ac7c
    
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
    pop rax
      
      mov qword [rbp - 88], rax
    if_a12ae0a9560348ce9fd31c95f6f47142: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_9e5e8606aca241f1a3e48b8df8b46c5e
    
    mov rax, 0xFFFFFFFFFFFFFFF3
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_9e5e8606aca241f1a3e48b8df8b46c5e: ; END of if_a12ae0a9560348ce9fd31c95f6f47142
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_c61264be314d41db98e6c67b7aa66765: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_6ef3466f338141c7b33d091b26d399af
    
    mov rax, 0xFFFFFFFFFFFFFFF2
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_6ef3466f338141c7b33d091b26d399af: ; END of if_c61264be314d41db98e6c67b7aa66765
    
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
    pop rax
      
      mov qword [rbp - 88], rax
    if_9986a9eee906400fa216fed9a0afd199: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_613e4d23b21e433289d2c1427379ac1e
    
    mov rax, 0xFFFFFFFFFFFFFFF1
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_613e4d23b21e433289d2c1427379ac1e: ; END of if_9986a9eee906400fa216fed9a0afd199
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
    while_68cdff1d57ea4ae4bbb6277427e276b6: ; WHILE start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp - 72]
      cmp rax, rcx
      jae end_while_ed855a86e47944f9a6115c4ea8f8e416
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_c98dfdb176194ea2a760191ffb8e7699: ; IF start
    mov rcx, 17
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_01314247f0074311bf3880d4ea10c36d
    
    mov rax, 0xFFFFFFFFFFFFFFE8
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_01314247f0074311bf3880d4ea10c36d: ; END of if_c98dfdb176194ea2a760191ffb8e7699
    
    mov rax, qword [rbp - 64]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x00000000000000FB
      push rax
    pop rcx
      pop rax
      cqo
      idiv rcx
      push rdx
    pop rax
      
      mov qword [rbp - 80], rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_5cce48deba7c4815ac1ce32277fb13e7: ; IF start
    mov rax, qword [rbp - 80]
      mov rcx, rax
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_4c2eaed5ed02402dbb2aaad93ca17a09
    
    mov rax, 0xFFFFFFFFFFFFFFE6
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_4c2eaed5ed02402dbb2aaad93ca17a09: ; END of if_5cce48deba7c4815ac1ce32277fb13e7
    
    mov rax, qword [rbp - 72]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
      jmp while_68cdff1d57ea4ae4bbb6277427e276b6 ; Reevaluate WHILE condition
    end_while_ed855a86e47944f9a6115c4ea8f8e416: ; END of while_68cdff1d57ea4ae4bbb6277427e276b6
    
    mov rax, qword [rbp - 96]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 96], rax
    end_if_213dbfcd27e44081ad43e2773467ae9b: ; END of if_d8f81018e92e46a4a96126e6bed231b7
    
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000080
      push rax
    pop rcx
      pop rax
      cqo
      idiv rcx
      push rdx
    pop rax
      
      mov qword [rbp - 88], rax
    if_350fc54d8b184312bde2d041292800a6: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      jne end_if_8def1c49f9264d11837445f3c1b0556f
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 56]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 56]
      push rax
    mov rax, qword [rbp - 56]
      push rax
    mov rax, 0x0000000000000019
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000040
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    if_49773de4265b4fc2a689d43cd29ca79e: ; IF start
    mov rcx, 3
      mov rax, qword [rbp - 112]
      cmp rax, rcx
      je end_if_9ad7346340c44445bfa34ec9bd0ea529
    
    mov rax, 0xFFFFFFFFFFFFFFE7
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_9ad7346340c44445bfa34ec9bd0ea529: ; END of if_49773de4265b4fc2a689d43cd29ca79e
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_f6a600f67f4249f399255368e5d7698f: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_7c5d1410ab5c4ac38fe941fe85649992
    
    mov rax, 0xFFFFFFFFFFFFFFF4
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_7c5d1410ab5c4ac38fe941fe85649992: ; END of if_f6a600f67f4249f399255368e5d7698f
    
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
    pop rax
      
      mov qword [rbp - 88], rax
    if_463bb59d559044efb911ec3e75085b48: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_753bd305a1654404a28d6fafbb325334
    
    mov rax, 0xFFFFFFFFFFFFFFF3
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_753bd305a1654404a28d6fafbb325334: ; END of if_463bb59d559044efb911ec3e75085b48
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_00d20e00e5df4247b0fe72d264eeb043: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_ade40df0742f4e278c87353c56377598
    
    mov rax, 0xFFFFFFFFFFFFFFF2
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_ade40df0742f4e278c87353c56377598: ; END of if_00d20e00e5df4247b0fe72d264eeb043
    
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
    pop rax
      
      mov qword [rbp - 88], rax
    if_4258e4a56617453daf6cfda8eba691dd: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_05f2540c61454ea198f5bc9aabbefdb2
    
    mov rax, 0xFFFFFFFFFFFFFFF1
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_05f2540c61454ea198f5bc9aabbefdb2: ; END of if_4258e4a56617453daf6cfda8eba691dd
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
    while_8a4b3653d7f347f48d670a34a01eed9e: ; WHILE start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp - 72]
      cmp rax, rcx
      jae end_while_9d41ad23ebd745bc9a4880185f7f079f
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_fc4c7890931b49f1982684c36c9f7d78: ; IF start
    mov rcx, 17
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_262607ee4f424ab88f6210870fcb8eec
    
    mov rax, 0xFFFFFFFFFFFFFFE8
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_262607ee4f424ab88f6210870fcb8eec: ; END of if_fc4c7890931b49f1982684c36c9f7d78
    
    mov rax, qword [rbp - 64]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x00000000000000FB
      push rax
    pop rcx
      pop rax
      cqo
      idiv rcx
      push rdx
    pop rax
      
      mov qword [rbp - 80], rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_c5c2b008a006482383c4fe4f17b2ad2d: ; IF start
    mov rax, qword [rbp - 80]
      mov rcx, rax
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_e6a2a4fc4d694c43a9268fa6eff44090
    
    mov rax, 0xFFFFFFFFFFFFFFE6
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_e6a2a4fc4d694c43a9268fa6eff44090: ; END of if_c5c2b008a006482383c4fe4f17b2ad2d
    
    mov rax, qword [rbp - 72]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
      jmp while_8a4b3653d7f347f48d670a34a01eed9e ; Reevaluate WHILE condition
    end_while_9d41ad23ebd745bc9a4880185f7f079f: ; END of while_8a4b3653d7f347f48d670a34a01eed9e
    
    mov rax, qword [rbp - 104]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 104], rax
    end_if_8def1c49f9264d11837445f3c1b0556f: ; END of if_350fc54d8b184312bde2d041292800a6
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 56]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 56]
      push rax
    mov rax, qword [rbp - 56]
      push rax
    mov rax, 0x00000000000003E8
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000040
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    if_f75f32ea21bb4fc195d24a3a5d1bec9a: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 112]
      cmp rax, rcx
      je end_if_b07c6a49f0574c11bb11c4eb8d3944c4
    
    mov rax, 0xFFFFFFFFFFFFFFE5
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_b07c6a49f0574c11bb11c4eb8d3944c4: ; END of if_f75f32ea21bb4fc195d24a3a5d1bec9a
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_77f525fce0cb4f14b8c82b1b8fdf2c47: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_df142c37e26149f493df753bd82594b9
    
    mov rax, 0xFFFFFFFFFFFFFFF4
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_df142c37e26149f493df753bd82594b9: ; END of if_77f525fce0cb4f14b8c82b1b8fdf2c47
    
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
    pop rax
      
      mov qword [rbp - 88], rax
    if_ea5f40eda4fe46c98c4c0fca03cd38cf: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_42e5ec2f13284e33907ddd8bb5f7383b
    
    mov rax, 0xFFFFFFFFFFFFFFF3
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_42e5ec2f13284e33907ddd8bb5f7383b: ; END of if_ea5f40eda4fe46c98c4c0fca03cd38cf
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_acb92ca374994023bf94130af651962e: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_4e3675a701464887af8206c62b0f90a0
    
    mov rax, 0xFFFFFFFFFFFFFFF2
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_4e3675a701464887af8206c62b0f90a0: ; END of if_acb92ca374994023bf94130af651962e
    
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
    pop rax
      
      mov qword [rbp - 88], rax
    if_44f0153f93a14f4bb8fb3e3daf5639f5: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_7a686de369f2458f8639d82229804c0b
    
    mov rax, 0xFFFFFFFFFFFFFFF1
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_7a686de369f2458f8639d82229804c0b: ; END of if_44f0153f93a14f4bb8fb3e3daf5639f5
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000040
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_d19f6a34913a421e9e545605c4d39bcc: ; IF start
    mov rax, qword [rbp - 56]
      mov rcx, rax
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_9013da55d9f04c4695faaa4ea4449ef8
    
    mov rax, 0xFFFFFFFFFFFFFFE4
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_9013da55d9f04c4695faaa4ea4449ef8: ; END of if_d19f6a34913a421e9e545605c4d39bcc
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
    while_a10241ef95d340df9da7d7cf5cc073aa: ; WHILE start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp - 72]
      cmp rax, rcx
      jae end_while_c8ff9d0cdca34588abecc30d89a717a9
    
    mov rax, qword [rbp - 64]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x00000000000000FB
      push rax
    pop rcx
      pop rax
      cqo
      idiv rcx
      push rdx
    pop rax
      
      mov qword [rbp - 80], rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_da040b334b3243318cd33cebdbef0763: ; IF start
    mov rax, qword [rbp - 80]
      mov rcx, rax
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_a72bf2011d4a4b70bf6e733b430ad2a7
    
    mov rax, 0xFFFFFFFFFFFFFFE3
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_a72bf2011d4a4b70bf6e733b430ad2a7: ; END of if_da040b334b3243318cd33cebdbef0763
    
    if_efd48dda43cf4dcf9dc39a30fbf31078: ; IF start
    mov rax, qword [rbp - 56]
      mov rcx, rax
      mov rax, qword [rbp - 72]
      cmp rax, rcx
      jae end_if_ee747ad69ad04cf59892b7ab7a4207d8
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_96ff8f1ad38c4d14affd779de56ecd0e: ; IF start
    mov rax, qword [rbp - 80]
      mov rcx, rax
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_095b305460534d0f86619be9cd0b9b3f
    
    mov rax, 0xFFFFFFFFFFFFFFE2
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_095b305460534d0f86619be9cd0b9b3f: ; END of if_96ff8f1ad38c4d14affd779de56ecd0e
    
      jmp end_else_1d19c16a06404eb5a5f5954aec47d3ce     ; Jump over ELSE part
    end_if_ee747ad69ad04cf59892b7ab7a4207d8:    ; if_efd48dda43cf4dcf9dc39a30fbf31078 END
    else_70dd7cd0f09340f7b2fae889adcb8166:  ; Start ELSE block
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_84b20e52fd1543a1a04f97274feda9a8: ; IF start
    mov rcx, 17
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_bb6bec1b75594fe8a30655334e2dacab
    
    mov rax, 0xFFFFFFFFFFFFFFE1
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_bb6bec1b75594fe8a30655334e2dacab: ; END of if_84b20e52fd1543a1a04f97274feda9a8
    
    end_else_1d19c16a06404eb5a5f5954aec47d3ce: ; END of else_70dd7cd0f09340f7b2fae889adcb8166
    
    mov rax, qword [rbp - 72]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
      jmp while_a10241ef95d340df9da7d7cf5cc073aa ; Reevaluate WHILE condition
    end_while_c8ff9d0cdca34588abecc30d89a717a9: ; END of while_a10241ef95d340df9da7d7cf5cc073aa
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_b249eacb8d7e4449a5b90f4fa97fe132: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_a6781c845c8444a698a3ddf0db6ca462
    
    mov rax, 0xFFFFFFFFFFFFFFE0
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_a6781c845c8444a698a3ddf0db6ca462: ; END of if_b249eacb8d7e4449a5b90f4fa97fe132
    
    mov rax, qword [rbp - 48]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    call func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_start
      add rsp, 24
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_9b897fdd9def4bcd8c303adb78a1871b: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      jne end_if_fb7ed32b61a84a9fb1aa0b91d1102997
    
    mov rax, 0xFFFFFFFFFFFFFFDF
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_fb7ed32b61a84a9fb1aa0b91d1102997: ; END of if_9b897fdd9def4bcd8c303adb78a1871b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
    while_999e824247004b489b14fa63de81aa7c: ; WHILE start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp - 72]
      cmp rax, rcx
      jae end_while_b1fb40fea72542f18813d0327b6762c0
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_1d07e67c24ba47119c76fcb1e634e422: ; IF start
    mov rax, qword [rbp - 56]
      mov rcx, rax
      mov rax, qword [rbp - 72]
      cmp rax, rcx
      jae end_if_e90a5bbfe9eb4e1cb07cde609dd1c4b0
    
    mov rax, qword [rbp - 64]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x00000000000000FB
      push rax
    pop rcx
      pop rax
      cqo
      idiv rcx
      push rdx
    pop rax
      
      mov qword [rbp - 80], rax
    if_3454c19cfba7428db75367e9106110da: ; IF start
    mov rax, qword [rbp - 80]
      mov rcx, rax
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_3ef45033f8c944d0ab0328639828e6ed
    
    mov rax, 0xFFFFFFFFFFFFFFDE
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_3ef45033f8c944d0ab0328639828e6ed: ; END of if_3454c19cfba7428db75367e9106110da
    
      jmp end_else_9532937f7f8f4382b8b0d1a8f1a7d906     ; Jump over ELSE part
    end_if_e90a5bbfe9eb4e1cb07cde609dd1c4b0:    ; if_1d07e67c24ba47119c76fcb1e634e422 END
    else_947277bed5354736b6b6f0671e6bf1e5:  ; Start ELSE block
    if_a27b1487f04d40cea27acb36b28f41d9: ; IF start
    mov rcx, 17
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_446aa152bccb4f709e544dac1794911b
    
    mov rax, 0xFFFFFFFFFFFFFFDD
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_446aa152bccb4f709e544dac1794911b: ; END of if_a27b1487f04d40cea27acb36b28f41d9
    
    end_else_9532937f7f8f4382b8b0d1a8f1a7d906: ; END of else_947277bed5354736b6b6f0671e6bf1e5
    
    mov rax, qword [rbp - 72]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
      jmp while_999e824247004b489b14fa63de81aa7c ; Reevaluate WHILE condition
    end_while_b1fb40fea72542f18813d0327b6762c0: ; END of while_999e824247004b489b14fa63de81aa7c
    
    mov rax, qword [rbp - 48]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 56], rax
    while_fbf73254592d493a91757acc9cc535f8: ; WHILE start
    mov rax, qword [rbp - 56]
      mov rcx, rax
      mov rax, qword [rbp - 72]
      cmp rax, rcx
      jae end_while_34c99a33ac804753a68fdbb0ad88f803
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_034a9f705df34664a0d2690569de5326: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_e99e21d8ff164a34b82447f6d139c5fc
    
    mov rax, 0xFFFFFFFFFFFFFFDC
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_e99e21d8ff164a34b82447f6d139c5fc: ; END of if_034a9f705df34664a0d2690569de5326
    
    mov rax, qword [rbp - 72]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
      jmp while_fbf73254592d493a91757acc9cc535f8 ; Reevaluate WHILE condition
    end_while_34c99a33ac804753a68fdbb0ad88f803: ; END of while_fbf73254592d493a91757acc9cc535f8
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6146726565_6f206e1b6b98415495582c42ef8cc995_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_a04f93d9564d443098cd50a188dbb12d: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_5a7f4b2bafeb44f3ad6404df66d77db5
    
    mov rax, 0xFFFFFFFFFFFFFFDB
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_5a7f4b2bafeb44f3ad6404df66d77db5: ; END of if_a04f93d9564d443098cd50a188dbb12d
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    call func_4172656E6146726565_6f206e1b6b98415495582c42ef8cc995_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    if_d21c333928074b78b91219476b9a3672: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_6b944c0a09c94b659ebf5cc4fece0bcd
    
    mov rax, 0xFFFFFFFFFFFFFFDA
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_6b944c0a09c94b659ebf5cc4fece0bcd: ; END of if_d21c333928074b78b91219476b9a3672
    
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
      
      mov qword [rbp - 88], rax
    if_ac37889d61d34b4e834744975f2a4eb7: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 88]
      cmp rax, rcx
      je end_if_e05283ae9b7349c78848a22f25b8cc96
    
    mov rax, 0xFFFFFFFFFFFFFFD9
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    end_if_e05283ae9b7349c78848a22f25b8cc96: ; END of if_ac37889d61d34b4e834744975f2a4eb7
    
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
      jmp while_023d0f8e609e437ba7b1516ad70eb9a0 ; Reevaluate WHILE condition
    end_while_98d4760fd6934d608c3689dbc8f30f7e: ; END of while_023d0f8e609e437ba7b1516ad70eb9a0
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000000
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
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 96]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 104]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 64]
      push rax
    pop rax
      
      jmp func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end
    func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61496E6974_2af00264884a48f79835bbee2e41d685_start:
    push rbp
      mov rbp, rsp
    if_313ab023b08e4cc18ee83473f544791a: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_fcc7d332c31a4230880e35c513a134b5
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61496E6974_2af00264884a48f79835bbee2e41d685_end
    end_if_fcc7d332c31a4230880e35c513a134b5: ; END of if_313ab023b08e4cc18ee83473f544791a
    
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
      
      jmp func_4172656E61496E6974_2af00264884a48f79835bbee2e41d685_end
    func_4172656E61496E6974_2af00264884a48f79835bbee2e41d685_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start:
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
    while_4da97785c74d4d4895578f64fe9f47b8: ; WHILE start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jae end_while_4e5f99685676457996d94ec907753427
    
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
    if_2fc08d7805f844be9ad12152874f20aa: ; IF start
    pop rax
      test rax, rax
      je end_if_fc5096ea41cb4ab19577eabb64a5ce58
    
      jmp end_else_cead9901dabb42ad9e1e937193b3d4ba     ; Jump over ELSE part
    end_if_fc5096ea41cb4ab19577eabb64a5ce58:    ; if_2fc08d7805f844be9ad12152874f20aa END
    else_c864920d7d4a4d2882540dffdacab220:  ; Start ELSE block
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
    if_a321400b980f44b0a165b1b7f1256f49: ; IF start
    pop rax
      test rax, rax
      je end_if_49792381290847fd83b5131eb273bc32
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_end
    end_if_49792381290847fd83b5131eb273bc32: ; END of if_a321400b980f44b0a165b1b7f1256f49
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_end
    end_else_cead9901dabb42ad9e1e937193b3d4ba: ; END of else_c864920d7d4a4d2882540dffdacab220
    
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
      jmp while_4da97785c74d4d4895578f64fe9f47b8 ; Reevaluate WHILE condition
    end_while_4e5f99685676457996d94ec907753427: ; END of while_4da97785c74d4d4895578f64fe9f47b8
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_end
    func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61416C6C6F63_afccbce81fdf4619a9cbb9d6b2d1f720_start:
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
    if_4180afbc367145959bf6dd72f323dfab: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_b5c3c483766647fa9e4ae6847162a6ca
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_afccbce81fdf4619a9cbb9d6b2d1f720_end
    end_if_b5c3c483766647fa9e4ae6847162a6ca: ; END of if_4180afbc367145959bf6dd72f323dfab
    
    if_cfdb6dfec034433b913ce3c82707382e: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jne end_if_55f22af854f3469a982269df89307cec
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_afccbce81fdf4619a9cbb9d6b2d1f720_end
    end_if_55f22af854f3469a982269df89307cec: ; END of if_cfdb6dfec034433b913ce3c82707382e
    
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
    while_61bb9e03ff094b45bb8132e6336fff5a: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_7f20fe4a350544efb1b2507f0eb33971
    
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
    if_f467745f725b4f0db85baadb735b162b: ; IF start
    pop rax
      test rax, rax
      je end_if_96dbef64a259485287b7f266be981a10
    
      jmp end_else_701eadde3b7940cdba9f34b799272f3a     ; Jump over ELSE part
    end_if_96dbef64a259485287b7f266be981a10:    ; if_f467745f725b4f0db85baadb735b162b END
    else_ca1bf55053e04774a21007e370bfe4fa:  ; Start ELSE block
    if_551064aa95674df28a0e6c4949838ac7: ; IF start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jb end_if_8cba8573656a4494bf201a05c7006e48
    
    jmp end_while_7f20fe4a350544efb1b2507f0eb33971 ; BREAK
    end_if_8cba8573656a4494bf201a05c7006e48: ; END of if_551064aa95674df28a0e6c4949838ac7
    
    end_else_701eadde3b7940cdba9f34b799272f3a: ; END of else_ca1bf55053e04774a21007e370bfe4fa
    
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
      jmp while_61bb9e03ff094b45bb8132e6336fff5a ; Reevaluate WHILE condition
    end_while_7f20fe4a350544efb1b2507f0eb33971: ; END of while_61bb9e03ff094b45bb8132e6336fff5a
    
    if_b3c67aa928e24e80b60ab1768697a065: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_ae68c1428c42488182f417f1554744ce
    
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
    if_4a039b201a7a4e6ba8362c90f7a1897f: ; IF start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jbe end_if_8ae50e29bf264a90b8f464a1fcace089
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_afccbce81fdf4619a9cbb9d6b2d1f720_end
    end_if_8ae50e29bf264a90b8f464a1fcace089: ; END of if_4a039b201a7a4e6ba8362c90f7a1897f
    
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
      jmp end_else_29f0b52c9fc84874817c5f905c64c473     ; Jump over ELSE part
    end_if_ae68c1428c42488182f417f1554744ce:    ; if_b3c67aa928e24e80b60ab1768697a065 END
    else_a010b6bfa7594680b1f73d1d53e546de:  ; Start ELSE block
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
    if_0eb80b73222647478be5533169abd5f9: ; IF start
    mov rax, qword [rbp - 64]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jb end_if_e4f79763e8c54fbbb2e5ca77ec32a5c3
    
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
    end_if_e4f79763e8c54fbbb2e5ca77ec32a5c3: ; END of if_0eb80b73222647478be5533169abd5f9
    
    end_else_29f0b52c9fc84874817c5f905c64c473: ; END of else_a010b6bfa7594680b1f73d1d53e546de
    
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
    while_51310bde315042acb1fd6b901e10faba: ; WHILE start
    mov rax, qword [rbp - 40]
      mov rcx, rax
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jae end_while_9f049cf9daba4d1386e4f6fa61b24f38
    
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
      jmp while_51310bde315042acb1fd6b901e10faba ; Reevaluate WHILE condition
    end_while_9f049cf9daba4d1386e4f6fa61b24f38: ; END of while_51310bde315042acb1fd6b901e10faba
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_afccbce81fdf4619a9cbb9d6b2d1f720_end
    func_4172656E61416C6C6F63_afccbce81fdf4619a9cbb9d6b2d1f720_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_start:
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
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_d13b0d147e2e43a9bd62b237d066ea15: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_1c1dc230e0944de9a2481ac5bc91c48b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_end
    end_if_1c1dc230e0944de9a2481ac5bc91c48b: ; END of if_d13b0d147e2e43a9bd62b237d066ea15
    
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
    if_74baee298f814a9fb27312bf49f89c26: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jb end_if_60a87570da1e4215a6a84b9ddb08a403
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_end
    end_if_60a87570da1e4215a6a84b9ddb08a403: ; END of if_74baee298f814a9fb27312bf49f89c26
    
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
      
      jmp func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_end
    func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_start:
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
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_69053e03ea404ef289e2bba5f45912e1: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_01300c73bfb24bb98e483f0e0f4f34b1
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_end
    end_if_01300c73bfb24bb98e483f0e0f4f34b1: ; END of if_69053e03ea404ef289e2bba5f45912e1
    
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
    if_c634a01c26634351bc17888eb37a5862: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_8e620b1a7fbe4df0a20f8157397473e8
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_end
    end_if_8e620b1a7fbe4df0a20f8157397473e8: ; END of if_c634a01c26634351bc17888eb37a5862
    
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
      
      jmp func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_end
    func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6146726565_6f206e1b6b98415495582c42ef8cc995_start:
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
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_2c6711c8d3b341e5bc1858c3664b806e: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_38ff3c99c9504c27b6393bc0a17d0a70
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146726565_6f206e1b6b98415495582c42ef8cc995_end
    end_if_38ff3c99c9504c27b6393bc0a17d0a70: ; END of if_2c6711c8d3b341e5bc1858c3664b806e
    
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
    if_cbfa60a1f0b34b84bcbcaa56f5939c89: ; IF start
    pop rax
      test rax, rax
      je end_if_d34b8335874e48cd82b4696e6bae048b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146726565_6f206e1b6b98415495582c42ef8cc995_end
    end_if_d34b8335874e48cd82b4696e6bae048b: ; END of if_cbfa60a1f0b34b84bcbcaa56f5939c89
    
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
    while_3620465a44774033b5b0c48500190769: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_35b84263c7e048b68e85af6d61d3d361
    
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
    if_691fb131db394fe3a5928a13fb31a304: ; IF start
    pop rax
      test rax, rax
      je end_if_e5e29f71d873424697dd8ae09e7731de
    
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
      jmp end_else_64b7fc13bd1d4922a8f78296e06414bb     ; Jump over ELSE part
    end_if_e5e29f71d873424697dd8ae09e7731de:    ; if_691fb131db394fe3a5928a13fb31a304 END
    else_e79a30f552554d7c942c185c172366fd:  ; Start ELSE block
    while_64a170079ea946a5b28626c0c67293b8: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      jae end_while_6aa759f749d242c582a3793e7fbc9858
    
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
    if_00e29c5eddf748cb935e4b4dbf0a95c2: ; IF start
    pop rax
      test rax, rax
      je end_if_6c9e914706b34b0aac8f7f1dffa132fc
    
    jmp end_while_6aa759f749d242c582a3793e7fbc9858 ; BREAK
    end_if_6c9e914706b34b0aac8f7f1dffa132fc: ; END of if_00e29c5eddf748cb935e4b4dbf0a95c2
    
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
      jmp while_64a170079ea946a5b28626c0c67293b8 ; Reevaluate WHILE condition
    end_while_6aa759f749d242c582a3793e7fbc9858: ; END of while_64a170079ea946a5b28626c0c67293b8
    
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
    end_else_64b7fc13bd1d4922a8f78296e06414bb: ; END of else_e79a30f552554d7c942c185c172366fd
    
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
      jmp while_3620465a44774033b5b0c48500190769 ; Reevaluate WHILE condition
    end_while_35b84263c7e048b68e85af6d61d3d361: ; END of while_3620465a44774033b5b0c48500190769
    
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
      
      jmp func_4172656E6146726565_6f206e1b6b98415495582c42ef8cc995_end
    func_4172656E6146726565_6f206e1b6b98415495582c42ef8cc995_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_start:
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
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_81051a1b09324344badd90baaa4ba405: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_d2cb519f10a4422a9208a858b2d9da80
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_end
    end_if_d2cb519f10a4422a9208a858b2d9da80: ; END of if_81051a1b09324344badd90baaa4ba405
    
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
    if_72f1b46b95734aff84b6fa3cb7bf64de: ; IF start
    pop rax
      test rax, rax
      je end_if_f316f73303504a4baccfc8699f8c0873
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_end
    end_if_f316f73303504a4baccfc8699f8c0873: ; END of if_72f1b46b95734aff84b6fa3cb7bf64de
    
    if_09c408542bf64adf8b3b4683ebd8b319: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_4075c15949354fe4aacb638994ae8b90
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_end
    end_if_4075c15949354fe4aacb638994ae8b90: ; END of if_09c408542bf64adf8b3b4683ebd8b319
    
    if_3c4b80adab37431785a8d3dcc78e65c5: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jne end_if_1a0a667250324da28768fbbb8b433605
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_end
    end_if_1a0a667250324da28768fbbb8b433605: ; END of if_3c4b80adab37431785a8d3dcc78e65c5
    
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
    if_207b84bd4ffb4f5da3a6de1cc5c3a484: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      ja end_if_c373de18037d4e018f0a59cfc0ce787c
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    while_5c5b90515c8a445db008ad8449b7582b: ; WHILE start
    mov rax, qword [rbp + 16]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_9467056f1215420cb5c1e0a847320f2e
    
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
      jmp while_5c5b90515c8a445db008ad8449b7582b ; Reevaluate WHILE condition
    end_while_9467056f1215420cb5c1e0a847320f2e: ; END of while_5c5b90515c8a445db008ad8449b7582b
    
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
      
      jmp func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_end
    end_if_c373de18037d4e018f0a59cfc0ce787c: ; END of if_207b84bd4ffb4f5da3a6de1cc5c3a484
    
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
    if_7d15d3a7a28649a080d4e8adee4aeb38: ; IF start
    mov rax, qword [rbp - 64]
      mov rcx, rax
      mov rax, qword [rbp - 72]
      cmp rax, rcx
      jne end_if_568b5b97e35c456facee412419314eb9
    
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
    if_f61b8786cdee4a1b84639ab0c0011d5b: ; IF start
    mov rax, qword [rbp - 88]
      mov rcx, rax
      mov rax, qword [rbp - 80]
      cmp rax, rcx
      ja end_if_689db207f78b43a68e49d1c15923a74d
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    while_515bbd007c7846e697c02fbdf33ecd51: ; WHILE start
    mov rax, qword [rbp - 56]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_725717469abe44ae848796ff0444358e
    
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
      jmp while_515bbd007c7846e697c02fbdf33ecd51 ; Reevaluate WHILE condition
    end_while_725717469abe44ae848796ff0444358e: ; END of while_515bbd007c7846e697c02fbdf33ecd51
    
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
      
      jmp func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_end
    end_if_689db207f78b43a68e49d1c15923a74d: ; END of if_f61b8786cdee4a1b84639ab0c0011d5b
    
    end_if_568b5b97e35c456facee412419314eb9: ; END of if_7d15d3a7a28649a080d4e8adee4aeb38
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call func_4172656E61416C6C6F63_afccbce81fdf4619a9cbb9d6b2d1f720_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_c68613bc21fc40eba915d0104f202649: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      jne end_if_0c16519314c24dc6b34a52a504f3c613
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_end
    end_if_0c16519314c24dc6b34a52a504f3c613: ; END of if_c68613bc21fc40eba915d0104f202649
    
    while_c3c9b7e6035a49968afb46dc7953bb65: ; WHILE start
    mov rax, qword [rbp - 24]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_f1e9727317c047f8bb63d2cdf2857a19
    
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
      jmp while_c3c9b7e6035a49968afb46dc7953bb65 ; Reevaluate WHILE condition
    end_while_f1e9727317c047f8bb63d2cdf2857a19: ; END of while_c3c9b7e6035a49968afb46dc7953bb65
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    call func_4172656E6146726565_6f206e1b6b98415495582c42ef8cc995_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp - 32]
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_end
    func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61417070656E645570706572_9ff99de075ff40928a6b7b4dcc599e5d_start:
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
    if_3a4f058f0a474a1db75a1c085f11365c: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jbe end_if_60a03628cd0644178bdfae647f20db7b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9ff99de075ff40928a6b7b4dcc599e5d_end
    end_if_60a03628cd0644178bdfae647f20db7b: ; END of if_3a4f058f0a474a1db75a1c085f11365c
    
    if_c13d5186100d4b03b66b92d6f1993a49: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_57228a219378499baa7bb587c3fa3d82
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9ff99de075ff40928a6b7b4dcc599e5d_end
    end_if_57228a219378499baa7bb587c3fa3d82: ; END of if_c13d5186100d4b03b66b92d6f1993a49
    
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
    if_2b495491bd2448a88bf22dcfa0685dac: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jbe end_if_72ad148e30784ba1aabbebbc24877176
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9ff99de075ff40928a6b7b4dcc599e5d_end
    end_if_72ad148e30784ba1aabbebbc24877176: ; END of if_2b495491bd2448a88bf22dcfa0685dac
    
    if_20b5c91ebcd7422f92b1bc51b9ea31fe: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jne end_if_71a050de6edd4249bf63043a055f5a13
    
    if_71f8040d18bc4418a3beaa808eb1b7fc: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_719b8feaf6a1443bb8b697f0707369c5
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9ff99de075ff40928a6b7b4dcc599e5d_end
    end_if_719b8feaf6a1443bb8b697f0707369c5: ; END of if_71f8040d18bc4418a3beaa808eb1b7fc
    
    mov rax, 0x0000000000000008
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
      jmp end_else_c7613ad9ae484984825bf256c95e7c1d     ; Jump over ELSE part
    end_if_71a050de6edd4249bf63043a055f5a13:    ; if_20b5c91ebcd7422f92b1bc51b9ea31fe END
    else_8c85f7d4106245adbeb352f5725804eb:  ; Start ELSE block
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_65376a23201b4f188192e0f2fcd3887d: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_1fa4c323942f49dbb37ff109a84a9d7b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9ff99de075ff40928a6b7b4dcc599e5d_end
    end_if_1fa4c323942f49dbb37ff109a84a9d7b: ; END of if_65376a23201b4f188192e0f2fcd3887d
    
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
    if_b5632cd50899496bae54d39f0a4255a3: ; IF start
    pop rax
      test rax, rax
      je end_if_e8ffb30d880d48ef8f0945e3fefe81b5
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9ff99de075ff40928a6b7b4dcc599e5d_end
    end_if_e8ffb30d880d48ef8f0945e3fefe81b5: ; END of if_b5632cd50899496bae54d39f0a4255a3
    
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
    if_7ca43699b3ad4a6bb78418d4244d5dbb: ; IF start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jb end_if_2df4c672816d45328a829dfb1ed62eaf
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9ff99de075ff40928a6b7b4dcc599e5d_end
    end_if_2df4c672816d45328a829dfb1ed62eaf: ; END of if_7ca43699b3ad4a6bb78418d4244d5dbb
    
    end_else_c7613ad9ae484984825bf256c95e7c1d: ; END of else_8c85f7d4106245adbeb352f5725804eb
    
    while_9f3b8b21c1ab41208f93b6af31f2ad4d: ; WHILE start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_574fe82d47ae4abe92a15940069beac3
    
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
      jmp while_9f3b8b21c1ab41208f93b6af31f2ad4d ; Reevaluate WHILE condition
    end_while_574fe82d47ae4abe92a15940069beac3: ; END of while_9f3b8b21c1ab41208f93b6af31f2ad4d
    
    if_39d31adfdb0a49a0b3396e4ef7426831: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jne end_if_ebc4177225c84055a98af80194ffd738
    
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61416C6C6F63_afccbce81fdf4619a9cbb9d6b2d1f720_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
      jmp end_else_7618cf05c44e4bb8afd7061425733b36     ; Jump over ELSE part
    end_if_ebc4177225c84055a98af80194ffd738:    ; if_39d31adfdb0a49a0b3396e4ef7426831 END
    else_09557d138c8c4e2e98afbda133277253:  ; Start ELSE block
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61526573697A65_dd2f0494f3bc43b7a715be90f5e7953c_start
      add rsp, 24
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_else_7618cf05c44e4bb8afd7061425733b36: ; END of else_09557d138c8c4e2e98afbda133277253
    
    if_46a337ff455a4c2db5485a211c973f15: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      jne end_if_b9828e0cb59544918c20898adefddc17
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9ff99de075ff40928a6b7b4dcc599e5d_end
    end_if_b9828e0cb59544918c20898adefddc17: ; END of if_46a337ff455a4c2db5485a211c973f15
    
    while_fb5940bb2f0d4772aecfba130921609e: ; WHILE start
    mov rax, qword [rbp + 16]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_08905d040bb143a094d688fc80a4a408
    
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
    if_441c323b396643abaa4fbcbef3132497: ; IF start
    mov rcx, 97
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      jb end_if_48a9ae1ba14e4140b77f303c8ffaf01f
    
    if_78f63a3b87814fed831b90027267c969: ; IF start
    mov rcx, 122
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      ja end_if_138024f6e8b341a586c636cc6e5e4ef2
    
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
    end_if_138024f6e8b341a586c636cc6e5e4ef2: ; END of if_78f63a3b87814fed831b90027267c969
    
    end_if_48a9ae1ba14e4140b77f303c8ffaf01f: ; END of if_441c323b396643abaa4fbcbef3132497
    
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
      jmp while_fb5940bb2f0d4772aecfba130921609e ; Reevaluate WHILE condition
    end_while_08905d040bb143a094d688fc80a4a408: ; END of while_fb5940bb2f0d4772aecfba130921609e
    
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
      
      jmp func_4172656E61417070656E645570706572_9ff99de075ff40928a6b7b4dcc599e5d_end
    func_4172656E61417070656E645570706572_9ff99de075ff40928a6b7b4dcc599e5d_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_start:
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
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_cb3530a30ea244cbb560caae94d82836: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_edb9cd2f8ff44ebab7d1f0e5c678e696
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_end
    end_if_edb9cd2f8ff44ebab7d1f0e5c678e696: ; END of if_cb3530a30ea244cbb560caae94d82836
    
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
    if_a5a728f834244969bbaae33e3fbf4629: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_f2b59f5b029549b5b379c047f85acc85
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_end
    end_if_f2b59f5b029549b5b379c047f85acc85: ; END of if_a5a728f834244969bbaae33e3fbf4629
    
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
    if_ae7180fc46fe42dd9a90cec9b4fc3dd2: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_c8dfcebbb04f41f0a7a3d72581cc7654
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_end
    end_if_c8dfcebbb04f41f0a7a3d72581cc7654: ; END of if_ae7180fc46fe42dd9a90cec9b4fc3dd2
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_60e3be902a8c4caea0435561021179ed: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_d74a5be7b8a4444daca71d2361bed5e9
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_end
    end_if_d74a5be7b8a4444daca71d2361bed5e9: ; END of if_60e3be902a8c4caea0435561021179ed
    
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
    if_2d19424bfd5a421aa954161aebfb5904: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_e421dbe03218425e93d1ffab045b9703
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_end
    end_if_e421dbe03218425e93d1ffab045b9703: ; END of if_2d19424bfd5a421aa954161aebfb5904
    
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
    if_ae3a7f966a8d48a7910fbf51aa5d713d: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_2e7b922bafa64030a51ce364ca4a7a90
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_end
    end_if_2e7b922bafa64030a51ce364ca4a7a90: ; END of if_ae3a7f966a8d48a7910fbf51aa5d713d
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_9924ee0246534011bb1309330926ac90: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_e257fb85bc01416da1bf6992997d9ab8
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_end
    end_if_e257fb85bc01416da1bf6992997d9ab8: ; END of if_9924ee0246534011bb1309330926ac90
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_a337e9aad18e427facd2c2225a84257d: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_80e2520d0f00476bbd1532d880bca5f9
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_end
    end_if_80e2520d0f00476bbd1532d880bca5f9: ; END of if_a337e9aad18e427facd2c2225a84257d
    
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
    call func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_end
    func_4172656E615F436F7079_0f208d7cc0cc488ebfa1694ca0f5b817_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_start:
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
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_7319cb8464b4474797f8846dfe90c4c0: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_363db15af1434c6e9312cdf3cc390fa4
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_end
    end_if_363db15af1434c6e9312cdf3cc390fa4: ; END of if_7319cb8464b4474797f8846dfe90c4c0
    
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
    if_f8a94b07bcec42d1b5cf5e4acf1ed5f1: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_dff9089b73794df6af5f9f1f93a519f0
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_end
    end_if_dff9089b73794df6af5f9f1f93a519f0: ; END of if_f8a94b07bcec42d1b5cf5e4acf1ed5f1
    
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
    if_eb1d9a0b043b4f1ead8e198aa8d4c198: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_216837b8a50c43a8acb9721fd32f0076
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_end
    end_if_216837b8a50c43a8acb9721fd32f0076: ; END of if_eb1d9a0b043b4f1ead8e198aa8d4c198
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_bbb7fb528c774cfcb12de83390cb8aea: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_9b0b6dd3856a4cd086f95e308faacb1d
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_end
    end_if_9b0b6dd3856a4cd086f95e308faacb1d: ; END of if_bbb7fb528c774cfcb12de83390cb8aea
    
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
    if_1a9fee5bb4f4403d8d158ce9e8d0ed81: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_98a7c76c84014d908bced0a4c85876a4
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_end
    end_if_98a7c76c84014d908bced0a4c85876a4: ; END of if_1a9fee5bb4f4403d8d158ce9e8d0ed81
    
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
    if_aa01c7ac52974bc6ab89bbd81f915d6a: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_ca1cab1d564943179f12260752efd0ef
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_end
    end_if_ca1cab1d564943179f12260752efd0ef: ; END of if_aa01c7ac52974bc6ab89bbd81f915d6a
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_91cb5f2937f54a8487392969421d39e7: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_1f5ec1ccac784efbb26e90b623c5d5b0
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_end
    end_if_1f5ec1ccac784efbb26e90b623c5d5b0: ; END of if_91cb5f2937f54a8487392969421d39e7
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_856c2ce12f3a492fbe62691d4ef81801: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_5c4763c7c0954ace9c14dcf61a04bac3
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_end
    end_if_5c4763c7c0954ace9c14dcf61a04bac3: ; END of if_856c2ce12f3a492fbe62691d4ef81801
    
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
    call func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_end
    func_4172656E615F5061727469616C_3c514475f1f644f49394eb64806cb179_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_start:
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
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_930f376bf92242568b1329e56876c5fe: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_8d4d07e958da406e99e4ec119d15fbe8
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_end
    end_if_8d4d07e958da406e99e4ec119d15fbe8: ; END of if_930f376bf92242568b1329e56876c5fe
    
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
    if_334479343ee2414bae67c6dd865d7ae2: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_fe04d567fb43456aa0f67a652d62d517
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_end
    end_if_fe04d567fb43456aa0f67a652d62d517: ; END of if_334479343ee2414bae67c6dd865d7ae2
    
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
    if_c5f4aa88b8b44a948beb2f8d54141283: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_664fc85ad1e04e9fadb6689778dac1bc
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_end
    end_if_664fc85ad1e04e9fadb6689778dac1bc: ; END of if_c5f4aa88b8b44a948beb2f8d54141283
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_5827a1ad76f048e8a2a20882c60d525f_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_0febb5c6eb9343f39f56c69cee834975: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_5f31340925dd4904b0a93f1a34b7740c
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_end
    end_if_5f31340925dd4904b0a93f1a34b7740c: ; END of if_0febb5c6eb9343f39f56c69cee834975
    
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
    if_ab142354d96f4e7fb56a0fe33430c3b0: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_bae2ce704e6c4ae39292ef05db97d393
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_end
    end_if_bae2ce704e6c4ae39292ef05db97d393: ; END of if_ab142354d96f4e7fb56a0fe33430c3b0
    
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
    if_d92e6f6b9d11450098dd957d010a1bf4: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_71e9efa5a9e949a0847634c1b477d80c
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_end
    end_if_71e9efa5a9e949a0847634c1b477d80c: ; END of if_d92e6f6b9d11450098dd957d010a1bf4
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_7da47de372e04306933e58066a4a6c76: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_4e203d164aa44eff9c07e350bfa7fd82
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_end
    end_if_4e203d164aa44eff9c07e350bfa7fd82: ; END of if_7da47de372e04306933e58066a4a6c76
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_6563559e6a304f0fb170f87320edd481_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_cd3387f8f3a946b0b22728fc518e1d6d: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_9b99e110a7a84a9483d2eaa1cb06627b
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_end
    end_if_9b99e110a7a84a9483d2eaa1cb06627b: ; END of if_cd3387f8f3a946b0b22728fc518e1d6d
    
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
    call func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_4797e36834bc4284bdb59f8210f9b979_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_end
    func_4172656E615F5370696E_a27c002c871e4437acebc1fb2ddae2dc_end:
      mov rsp, rbp
      pop rbp
      ret
module_6172656E615F737472657373_f98db8e3d66449bfa8d42cee995aa753_end:

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
ubytec_import_Copy:
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
ubytec_import_Partial:
 push rbp
 mov rbp,rsp
 push 2
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
ubytec_import_Spin:
 push rbp
 mov rbp,rsp
 push 3
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
 mov rdi,3
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
global ubytec_host_contract_StressMain
ubytec_host_contract_StressMain:
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
call func_5374726573734D61696E_6177af00ee2d4b508d4bbd3ec539ff58_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,73,124,49,124,67,111,112,121,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,67,111,112,121,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,50,124,80,97,114,116,105,97,108,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,80,97,114,116,105,97,108,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,51,124,83,112,105,110,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,83,112,105,110,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,83,116,114,101,115,115,77,97,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,116,114,101,115,115,77,97,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
