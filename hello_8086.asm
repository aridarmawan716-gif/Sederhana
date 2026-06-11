.MODEL SMALL
.STACK 100H

.DATA
    msg DB 'Hello, World!$'

.CODE
MAIN PROC
    ; 1. Inisialisasi Segmen Data
    MOV AX, @DATA
    MOV DS, AX

    ; 2. Cetak Teks ke Layar
    MOV AH, 09H         
    LEA DX, msg         
    INT 21H             

    ; 3. Keluar dari Program
    MOV AH, 4CH         
    MOV AL, 00H         
    INT 21H             

MAIN ENDP
END MAIN

