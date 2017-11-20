TITLE ASM1 (.EXE MODEL)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'
  MESSAGE DB "Coffee Break.","$"
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
  ;set DS to correct dataseg
  MOV AX, DATASEG
  MOV DS, AX

  MOV DX, OFFSET MESSAGE ;LEA DX, MESSAGE
  MOV AH, 09
  INT 21H

  ;terminate; return; exit
  MOV AH, 4CH
  INT 21H
CODESEG ENDS
END START
