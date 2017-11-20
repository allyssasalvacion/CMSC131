TITLE ASM1 (.EXE MODEL)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'
  INPUT1 DB ?
  INPUT2 DB ?
  INPUT3 DB ?
  INPUT4 DB ?
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
  ;set DS to correct dataseg
  MOV AX, DATASEG
  MOV DS, AX

  ; first char
  MOV AH, 10H
  INT 16H
  MOV INPUT1, AL

  ; second char
  MOV AH, 10H
  INT 16H
  MOV INPUT2, AL

  ; third char
  MOV AH, 10H
  INT 16H
  MOV INPUT3, AL

  MOV AL, '$'
  MOV INPUT4, AL
  ; MOV INPUT4, '$'

  ; print chars
  LEA DX, INPUT1
  MOV AH, 09H
  INT 21H

  ;terminate; return; exit
  MOV AH, 4CH
  INT 21H
CODESEG ENDS
END START
