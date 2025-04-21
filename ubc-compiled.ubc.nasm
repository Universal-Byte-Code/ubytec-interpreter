block_0: ; BLOCK start
  while_0: ; WHILE start
    mov rax, 2    ; Evaluate left
    cmp rax, 10   ; Compare with right
    je end_while_0    ; Jump if condition is false
    loop_0: ; LOOP start
      if_0: ; IF START
        mov rax, 0  ; Evalúa la parte izquierda
        cmp rax, 9  ; Compara con la parte derecha
        jne end_if_0   ; Salta si la condición es falsa
        nop   ; NOP
        jmp end_else_0     ; Jump over ELSE part
      end_if_0:    ; if_0 END
      else_0:  ; Start ELSE block
        nop   ; NOP
      end_else_0: ; END of else_0
      jmp loop_0 ; LOOP: continue iteration
    end_loop_0: ; END of loop_0
    switch_0: ; SWITCH: Salto múltiple
      branch_0: ; Start BRANCH block
        pop rax
        cmp rax, 30
        jne end_branch_0 ; Skip branch if condition fails
        nop   ; NOP
      end_branch_0: ; END of branch_0
      branch_1: ; Start BRANCH block
        pop rax
        cmp rax, 666
        jne end_branch_1 ; Skip branch if condition fails
        ud2   ; TRAP
      end_branch_1: ; END of branch_1
    end_switch_0: ; END of switch_0
    pop rax       ; Load loop counter
    dec rax       ; Decrement counter
    push rax      ; Store updated counter
    cmp rax, 0    ; Check if counter is zero
    je end_while_0 ; Exit loop if counter == 0
    jmp while_0 ; Continue loop if not zero
  end_while_0: ; END of while_0
end_block_0: ; END of block_0