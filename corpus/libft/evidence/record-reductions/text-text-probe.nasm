  module_696F5F70726F6265_6882cbc92b424e48ab056f8d823c6848_start:
  ; Module: io_probe v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-06 01:35:02Z
    ; Module UUID: 6882cbc9-2b42-4e48-ab05-6f8d823c6848


    section .bss

    section .text

    func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
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
    if_540c0ca937034d7eb3df2905e123a6e2: ; IF start
    mov rcx, 1
      mov rax, qword [rbp + 56]
      cmp rax, rcx
      jne end_if_bff143c63afa42c189394f63764dfd5c
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
      jmp end_else_821fd3c723c245ad8ed245e6833f5a8c     ; Jump over ELSE part
    end_if_bff143c63afa42c189394f63764dfd5c:    ; if_540c0ca937034d7eb3df2905e123a6e2 END
    else_3bdf3274618c4b72b90b54ffbd93171d:  ; Start ELSE block
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    end_else_821fd3c723c245ad8ed245e6833f5a8c: ; END of else_3bdf3274618c4b72b90b54ffbd93171d
    pop rax
      
      mov qword [rbp - 8], rax
    if_6bff250d092e42dda72ea34c7c06ffc1: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_4ae67ee606f349cb9c47f91d58463e8b
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_end
    end_if_4ae67ee606f349cb9c47f91d58463e8b: ; END of if_6bff250d092e42dda72ea34c7c06ffc1
    mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
      mov rax, qword [rax]
      push rax
    if_00336529e210416fb0c12f337b18eb25: ; IF start
    pop rax
      test rax, rax
      je end_if_202945131ccb48259118807826a98241
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_end
    end_if_202945131ccb48259118807826a98241: ; END of if_00336529e210416fb0c12f337b18eb25
    mov rax, 0x0000000000000001
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_end
    func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_end:
      mov rsp, rbp
      pop rbp
      ret
    func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_start:
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
    if_d6049e550e384d6daed3f5107860c33a: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_79c47047042244f5a208fc1c50a35f7b
    mov rax, 0xFFFFFFFFFFFFFFFF
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_79c47047042244f5a208fc1c50a35f7b: ; END of if_d6049e550e384d6daed3f5107860c33a
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000200
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 16], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000048
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 24], rax
    while_91fa45c7e17a46f6b306da31910d4183: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_c59df599c3d844f188441ac73d51d55f
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x00000000000000A5
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_91fa45c7e17a46f6b306da31910d4183 ; Reevaluate WHILE condition
    end_while_c59df599c3d844f188441ac73d51d55f: ; END of while_91fa45c7e17a46f6b306da31910d4183
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x000000000000FFFF
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_start
      add rsp, 48
      push rax
    if_02466f4724c6472fa5e594c14009c5ba: ; IF start
    pop rax
      test rax, rax
      je end_if_5d306058780f444184eb31ff17d9906c
      jmp end_else_6dbf382ce59341b39e384098ddd1fe61     ; Jump over ELSE part
    end_if_5d306058780f444184eb31ff17d9906c:    ; if_02466f4724c6472fa5e594c14009c5ba END
    else_c2c666b0229e4bd69113fe1be520fb50:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_else_6dbf382ce59341b39e384098ddd1fe61: ; END of else_c2c666b0229e4bd69113fe1be520fb50
    mov rax, 0x0000000000000002
      push rax
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_start
      add rsp, 48
      push rax
    if_652b70429d3b47699fad67e32a04dee4: ; IF start
    pop rax
      test rax, rax
      je end_if_170371d9b6c94bccb3bd2ba9b6369157
      jmp end_else_9be4339db7b0443a8906d1bf5a431ba4     ; Jump over ELSE part
    end_if_170371d9b6c94bccb3bd2ba9b6369157:    ; if_652b70429d3b47699fad67e32a04dee4 END
    else_320c98987c3d48d49c19bc81706b6e12:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_else_9be4339db7b0443a8906d1bf5a431ba4: ; END of else_320c98987c3d48d49c19bc81706b6e12
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x0000000000000102
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_start
      add rsp, 48
      push rax
    if_47c3000216384838b2f614d4e0902cfe: ; IF start
    pop rax
      test rax, rax
      je end_if_cc4c331c1e23470d8acfb26ff4baa755
      jmp end_else_8df5734334d3442abb436799ef50edd7     ; Jump over ELSE part
    end_if_cc4c331c1e23470d8acfb26ff4baa755:    ; if_47c3000216384838b2f614d4e0902cfe END
    else_53eeffd4f5784819ae1fa7f4ec86871e:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_else_8df5734334d3442abb436799ef50edd7: ; END of else_53eeffd4f5784819ae1fa7f4ec86871e
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000001001
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_start
      add rsp, 48
      push rax
    if_1dfdbf7b3c58493f84d845ef65d11b1b: ; IF start
    pop rax
      test rax, rax
      je end_if_ac00e579af5740339f9e19870869fb29
      jmp end_else_e0afe40f143f4734aa2b6f244ff6a34b     ; Jump over ELSE part
    end_if_ac00e579af5740339f9e19870869fb29:    ; if_1dfdbf7b3c58493f84d845ef65d11b1b END
    else_9000c02086ae4622b4ad847b1ee5d0b2:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_else_e0afe40f143f4734aa2b6f244ff6a34b: ; END of else_9000c02086ae4622b4ad847b1ee5d0b2
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_start
      add rsp, 48
      push rax
    if_8e5e305d06e14f139a156f4b5e33b459: ; IF start
    pop rax
      test rax, rax
      je end_if_16754cad8039442fb5429530a4941657
      jmp end_else_eab94ee7da384b4db4f283f15907cca4     ; Jump over ELSE part
    end_if_16754cad8039442fb5429530a4941657:    ; if_8e5e305d06e14f139a156f4b5e33b459 END
    else_e1cf633ebc8b4463ba3eb33f40360d88:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_else_eab94ee7da384b4db4f283f15907cca4: ; END of else_e1cf633ebc8b4463ba3eb33f40360d88
    mov rax, 0x0000000000000002
      push rax
    mov rax, 0x0000000000000102
      push rax
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_start
      add rsp, 48
      push rax
    if_75127033523340e0816440b94f5f02b6: ; IF start
    pop rax
      test rax, rax
      je end_if_631ee1ec684a4a9cb4267adea7e4f432
      jmp end_else_0dfafb1235094b58a6050526be6b64a6     ; Jump over ELSE part
    end_if_631ee1ec684a4a9cb4267adea7e4f432:    ; if_75127033523340e0816440b94f5f02b6 END
    else_d665ac2e84ed43d591cc80dac2c3b0b3:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_else_0dfafb1235094b58a6050526be6b64a6: ; END of else_d665ac2e84ed43d591cc80dac2c3b0b3
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_b5dde772c0a1488c9b6b44f143e38355_start
      add rsp, 48
      push rax
    if_f8f9581436444b659bdf567bd3f55275: ; IF start
    pop rax
      test rax, rax
      je end_if_4446d11417824caa902b75d3e5f6d60e
      jmp end_else_fa794a823de240b5b24eb040298625ad     ; Jump over ELSE part
    end_if_4446d11417824caa902b75d3e5f6d60e:    ; if_f8f9581436444b659bdf567bd3f55275 END
    else_f317f68cd2a047b49043e01442e32383:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_else_fa794a823de240b5b24eb040298625ad: ; END of else_f317f68cd2a047b49043e01442e32383
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
    while_b3c8190cafcd4ffcaa17fcc608bdd7ca: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_ed7969a5d19a438dab02c6ce3433198f
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x00000000000000A5
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_55c7f92e306f4dd3990ce84f12dcb73d: ; IF start
    pop rax
      test rax, rax
      je end_if_6d6b20cd97974f878a5891deafe4be1a
    mov rax, 0xFFFFFFFFFFFFFFFD
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_6d6b20cd97974f878a5891deafe4be1a: ; END of if_55c7f92e306f4dd3990ce84f12dcb73d
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_b3c8190cafcd4ffcaa17fcc608bdd7ca ; Reevaluate WHILE condition
    end_while_ed7969a5d19a438dab02c6ce3433198f: ; END of while_b3c8190cafcd4ffcaa17fcc608bdd7ca
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
    if_b7e8eed8e00e40e096f7fcf225dc80d2: ; IF start
    pop rax
      test rax, rax
      je end_if_dd7c332a599b4c1dbca14074240e215e
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_dd7c332a599b4c1dbca14074240e215e: ; END of if_b7e8eed8e00e40e096f7fcf225dc80d2
    mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_1cc6a14dcaab46499a69ce4716daa317: ; IF start
    pop rax
      test rax, rax
      je end_if_882bd8db145b46acb3c7762f81919b9a
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_882bd8db145b46acb3c7762f81919b9a: ; END of if_1cc6a14dcaab46499a69ce4716daa317
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000003
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
    if_34bdb6b2f1e448669700661395a86e82: ; IF start
    pop rax
      test rax, rax
      je end_if_58e14484446c407caf0071eeb47abe48
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_58e14484446c407caf0071eeb47abe48: ; END of if_34bdb6b2f1e448669700661395a86e82
    mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_233a0a0986424d46a18ace3201a1ef34: ; IF start
    pop rax
      test rax, rax
      je end_if_30aab4de069a4ed4905fdfb4f8f7419f
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_30aab4de069a4ed4905fdfb4f8f7419f: ; END of if_233a0a0986424d46a18ace3201a1ef34
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000003
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
    if_9c5ffd9bc5a64a12acf05efe515d3bfe: ; IF start
    pop rax
      test rax, rax
      je end_if_040621e678ed4da98a12e56975ff785d
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_040621e678ed4da98a12e56975ff785d: ; END of if_9c5ffd9bc5a64a12acf05efe515d3bfe
    mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_d57769d76bec493a89f3e20326b39da5: ; IF start
    pop rax
      test rax, rax
      je end_if_182fca911ddd4b24897166907e643763
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_182fca911ddd4b24897166907e643763: ; END of if_d57769d76bec493a89f3e20326b39da5
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x0000000000000061
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_9a04c6630c8c4bb1b9c0117b5aae977c: ; IF start
    pop rax
      test rax, rax
      je end_if_20b6c20ff55a4389afc2ab55b1130185
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_20b6c20ff55a4389afc2ab55b1130185: ; END of if_9a04c6630c8c4bb1b9c0117b5aae977c
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000001
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x0000000000000062
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_81825757cdbe4da6beeb2cf47e156ee3: ; IF start
    pop rax
      test rax, rax
      je end_if_4b978a0ebe9e4c988ec4dc614aaf33eb
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_4b978a0ebe9e4c988ec4dc614aaf33eb: ; END of if_81825757cdbe4da6beeb2cf47e156ee3
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000002
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x0000000000000063
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_9c4cf167fa404084841a42d5894dcf61: ; IF start
    pop rax
      test rax, rax
      je end_if_d2e06395a9504c36895adc77f0256671
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_d2e06395a9504c36895adc77f0256671: ; END of if_9c4cf167fa404084841a42d5894dcf61
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
    while_c4e8689f2adc4708978f704a15c418b2: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_16a0e6563038466080b999290ead3219
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x00000000000000A5
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_849669f7168a447bba0e782cff2f5c27: ; IF start
    pop rax
      test rax, rax
      je end_if_aee991ede744407e83d95c9432ed55a2
    mov rax, 0xFFFFFFFFFFFFFFF9
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_aee991ede744407e83d95c9432ed55a2: ; END of if_849669f7168a447bba0e782cff2f5c27
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_c4e8689f2adc4708978f704a15c418b2 ; Reevaluate WHILE condition
    end_while_16a0e6563038466080b999290ead3219: ; END of while_c4e8689f2adc4708978f704a15c418b2
    mov rax, 0x0000000000000102
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000003
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    if_97078b363b5b4607b87a80595683f27f: ; IF start
    pop rax
      test rax, rax
      je end_if_85e615e4b7f946fb81e60d067b98d73b
    mov rax, 0xFFFFFFFFFFFFFFF8
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_85e615e4b7f946fb81e60d067b98d73b: ; END of if_97078b363b5b4607b87a80595683f27f
    mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_fb298bcb11f04a16b403c51c68a86475: ; IF start
    pop rax
      test rax, rax
      je end_if_b1c2a17f500646d88aba4251533c2db1
    mov rax, 0xFFFFFFFFFFFFFFF7
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    end_if_b1c2a17f500646d88aba4251533c2db1: ; END of if_fb298bcb11f04a16b403c51c68a86475
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000018
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      mov qword [rax], rcx
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end
    func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_end:
      mov rsp, rbp
      pop rbp
      ret
module_696F5F70726F6265_6882cbc92b424e48ab056f8d823c6848_end:

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
extern ubytec_bridge_read
ubytec_hostio_HostRead:
push rbp
mov rbp, rsp
mov rdi, [rbp+48]
mov rsi, [rbp+40]
mov rdx, [rbp+32]
mov rcx, [rbp+24]
mov r8, [rbp+16]
and rsp, -16
call ubytec_bridge_read
mov rsp, rbp
pop rbp
ret

section .text
extern ubytec_bridge_write
ubytec_hostio_HostWrite:
push rbp
mov rbp, rsp
mov rdi, [rbp+48]
mov rsi, [rbp+40]
mov rdx, [rbp+32]
mov rcx, [rbp+24]
mov r8, [rbp+16]
and rsp, -16
call ubytec_bridge_write
mov rsp, rbp
pop rbp
ret
section .text
global ubytec_host_contract_TextMain
ubytec_host_contract_TextMain:
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
call func_546578744D61696E_12abde0e280c4d1ebbb7f5809e467599_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,84,101,120,116,77,97,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,84,101,120,116,77,97,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
