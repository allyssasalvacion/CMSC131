TITLE LOOP (.EXE FORMAT)
.MODEL SMALL
;---------------------------------------------
.STACK 100H
;---------------------------------------------
.DATA
    MESSAGE1 DB 'Digits:$'
    MESSAGE2 DB 0AH, 0DH, 'Uppercase:$'
    MESSAGE3 DB 0AH, 0DH, 'Lowercase:$' 
;---------------------------------------------
.CODE
    START:
      MOV AX, @DATA
      MOV DS, AX

      ;set counter
      MOV CX, 10

      ;set to display data starting at char 48
      MOV BL, 48

      MOV AH, 09
      LEA DX, MESSAGE1
      INT 21H

      DISPLAY_CHAR:
        MOV AH, 02 ;(can only print one byte/char)
        MOV DL, 32
        INT 21H

        MOV AH, 02 ;(can only print one byte/char)
        MOV DL, BL
        INT 21H

        INC BL
        LOOP DISPLAY_CHAR

      ;set counter
      MOV CX, 26

      ;set to display data starting at char 64
      MOV BL, 65

      MOV AH, 09
      LEA DX, MESSAGE2
      INT 21H

      DISPLAY_CHAR2:
        MOV AH, 02 ;(can only print one byte/char)
        MOV DL, 32
        INT 21H

        MOV AH, 02 ;(can only print one byte/char)
        MOV DL, BL
        INT 21H

        INC BL
        LOOP DISPLAY_CHAR2

      ;set counter
      MOV CX, 26

      ;set to display data starting at char 64
      MOV BL, 97

      MOV AH, 09
      LEA DX, MESSAGE3
      INT 21H

      DISPLAY_CHAR3:
        MOV AH, 02 ;(can only print one byte/char)
        MOV DL, 32
        INT 21H

        MOV AH, 02 ;(can only print one byte/char)
        MOV DL, BL
        INT 21H

        INC BL
        LOOP DISPLAY_CHAR3
  
      EXIT:
        MOV AH, 4CH
        INT 21H

    END START