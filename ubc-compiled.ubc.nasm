block_0: ; BLOCK start

  while_0: ; WHILE start
    mov rax, 2    ; Evaluate left
    cmp rax, 10   ; Compare with right
    je end_while_0    ; Jump if condition is false

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

    pop rax       ; Load loop counter
    dec rax       ; Decrement counter
    push rax      ; Store updated counter
    cmp rax, 0    ; Check if counter is zero
    je end_while_0 ; Exit loop if counter == 0
    jmp while_0 ; Otherwise, continue loop
  end_while_0: ; END of while_0


  pop rax   ; RETURN value
  ret
end_block_0: ; End of function => block_0

