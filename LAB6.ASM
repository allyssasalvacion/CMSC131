;Allyssa S. Albores
TITLE LAB6 (COM)
      .MODEL  SMALL
      .STACK  64
      .CODE
      ORG   100H
      JMP   MAIN
TEMP        DB    ?
NEW_INPUT   DB    ?
ROW         DB    ?
COL         DB    ?
;-------------------------------------------
MAIN   PROC  FAR
      ;set DS to address of code segment
      MOV   AX, @CODE
      MOV   DS, AX

      MOV ROW, 0BH
      MOV COL, 0AH

      GAMELOOP:
        ;clear screen
        CALL  CLEAR_SCREEN
        CALL  CLEAR_SCREEN2

        ;set cursor
        MOV   DL, COL     ;row
        MOV   DH, ROW     ;column
        CALL  SET_CURSOR

        ;display char 'A' from register
        MOV   AL, 041H
        MOV   AH, 02H
        MOV   DL, AL
        INT   21H

        CALL  DELAY
        CALL  GET_KEY
        CALL  CHANGEDIRECTION
MAIN   ENDP        
;-------------------------------------------
CLEAR_SCREEN PROC  NEAR
      MOV   AX, 0600H ;full screen
      MOV   BH, 00H   ;black background (0), black foreground (0)
      MOV   CX, 0000H ;upper left row:column (0:0)
      MOV   DX, 184FH ;lower right row:column (24:79)
      INT   10H
      RET
CLEAR_SCREEN ENDP

CLEAR_SCREEN2 PROC NEAR
      MOV AX, 0600H   ;full screen
      MOV BH, 67H     ;orange background (6), white foreground (7)
      MOV CX, 0101H   ;upper left row:column (1:1)
      MOV DX, 174EH   ;lower right row:column (23:78)
      INT 10H
      RET
CLEAR_SCREEN2 ENDP
;-------------------------------------------
SET_CURSOR PROC  NEAR
      MOV   AH, 02H
      MOV   BH, 00
      INT   10H
      RET
SET_CURSOR ENDP
;-------------------------------------------
DELAY PROC NEAR
      MOV BP, 2 ;lower value faster
      MOV SI, 2 ;lower value faster
      
      DELAY2:
        DEC BP
        NOP
        JNZ DELAY2
        DEC SI
        CMP SI, 0
        JNZ DELAY2
        RET
DELAY ENDP
;-------------------------------------------  
CHANGEDIRECTION PROC NEAR
      CMP NEW_INPUT, 48H   ;up key
      JE UP
      CMP NEW_INPUT, 50H   ;down key
      JE DOWN
      CMP NEW_INPUT, 4DH   ;right key
      JE RIGHT
      CMP NEW_INPUT, 4BH   ;left key
      JE LEFT
      CMP NEW_INPUT, 01H   ;esc key
      JE ESCAPE
      JNE PAUSE

      UP:
        DEC ROW
        CMP ROW, 0
        JE  WRAPUP
        JMP GAMELOOP

      DOWN:
        INC ROW
        CMP ROW, 24
        JE  WRAPDOWN
        JMP GAMELOOP

      RIGHT:
        INC COL
        CMP COL, 79
        JE  WRAPRIGHT
        JMP GAMELOOP  

      LEFT:
        DEC COL
        CMP COL, 0
        JE  WRAPLEFT
        JMP GAMELOOP

      PAUSE:
        JMP GAMELOOP
        
      WRAPUP:
        MOV ROW, 23
        JMP GAMELOOP

      WRAPDOWN:
        MOV ROW, 1
        JMP GAMELOOP  
      
      WRAPRIGHT:
        MOV COL, 1  
        JMP GAMELOOP

      WRAPLEFT:
        MOV COL, 78
        JMP GAMELOOP 

      ESCAPE:
        MOV AH, 4CH
        INT 21H
CHANGEDIRECTION ENDP
;-------------------------------------------  
GET_KEY PROC NEAR 
      MOV   AH, 01H   ;check for input
      INT   16H

      JZ    LEAVETHIS

      MOV   AH, 00H   ;get input  MOV AH, 10H; INT 16H
      INT   16H

      MOV   NEW_INPUT, AH

      LEAVETHIS:
      RET
GET_KEY   ENDP  
END MAIN