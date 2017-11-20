;reference PDF (4th edition) p. 108 Writing .COM Programs

TITLE ASM1 (SIMPLIFIED EXE)
.MODEL SMALL
;---------------------------------------------
.STACK 32
;---------------------------------------------
.DATA
  MESSAGE DB "HELLO WORLD!!!$"
;---------------------------------------------
.CODE
  MOV AX, @data
  MOV DS, AX
  LEA DX, MESSAGE
  MOV AH, 9
  INT 21H
  MOV AH, 4CH
  INT 21H

END
