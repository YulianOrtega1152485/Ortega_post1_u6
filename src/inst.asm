; lab6_instrucciones.asm
; Compilar: nasm -f bin lab6_instrucciones.asm -o lab6_instrucciones.com

org 100h

; ───────── DATOS ─────────
jmp inicio

valor_a   dw 45
valor_b   dw 12
resultado dw 0
contador  db 5
mascara   db 0Fh

; ───────── CÓDIGO ─────────
inicio:

; ===== BLOQUE 1: TRANSFERENCIA =====
    MOV ax, [valor_a]
    MOV bx, [valor_b]

    MOV cx, ax
    MOV dx, bx

    LEA si, [valor_a]
    MOV ax, [si]

    XCHG cx, dx
    XCHG cx, dx

    PUSH ax
    MOV ax, 0FFFFh
    POP ax

; ===== BLOQUE 2: ARITMÉTICA =====
    MOV ax, [valor_a]
    ADD ax, [valor_b]     ; AX = 57
    MOV [resultado], ax

    MOV ax, [valor_b]
    SUB ax, [valor_a]

    MOV ax, [valor_a]
    INC ax
    DEC ax

    MOV al, 10
    MOV bl, 7
    MUL bl

    MOV ax, 100
    MOV bl, 7
    DIV bl

; ===== BLOQUE 3: LÓGICA =====
    MOV al, 0B7h
    AND al, [mascara]

    MOV al, 0B7h
    OR al, 0F0h

    MOV al, 0AAh
    XOR al, 0FFh

    XOR bx, bx

    MOV al, 0B7h
    TEST al, 01h

    MOV al, 08h
    SHL al, 2
    SHR al, 1

; ===== BLOQUE 4: CONTROL DE FLUJO =====
    MOV ax, [valor_a]
    CMP ax, [valor_b]
    JG mayor
    JE igual

    XOR cx, cx
    JMP fin_cmp

mayor:
    MOV cx, 1
    JMP fin_cmp

igual:
    MOV cx, 2

fin_cmp:

; ===== BUCLE SUMA =====
    XOR ax, ax
    MOV cx, 5
    MOV bx, 1

bucle_suma:
    ADD ax, bx
    INC bx
    LOOP bucle_suma
    ; AX = 15

; ===== FIN =====
    INT 20h