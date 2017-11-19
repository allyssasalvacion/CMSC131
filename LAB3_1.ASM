TITLE LAB3_1 (.EXE FORMAT)
.MODEL SMALL
;----------------------------------------
.STACK 100H
;----------------------------------------
.DATA
	ALERT0 DB "Too hot! Give yourself a shower.$"
	ALERT1 DB "You're good. Stay alert.$"
	ALERT2 DB "Oh no! You're freezing.$"

	TEMP_READING  DW 50
	;TEMP_READING  DW 100
	;TEMP_READING  DW 65263
	;TEMP_READING  DW 80
	;TEMP_READING  DW 30
	TEMP0  DW 30
	TEMP1  DW 80
;----------------------------------------
.CODE
	MAIN:
	;initialise DS
	MOV AX, @DATA
	MOV DS, AX

	@NORMALTEMP:
		CMP TEMP_READING, 30
		JLE @COLDTEMP  
		CMP TEMP_READING, 80
		JGE @HOTTEMP

		MOV AH, 09
		LEA DX, ALERT1
		INT 21H

		JMP @EXIT

	@COLDTEMP:
		MOV AH, 09
		LEA DX, ALERT2
		INT 21H

		JMP @EXIT

	@HOTTEMP:
		MOV AH, 09
		LEA DX, ALERT0
		INT 21H

		JMP @EXIT

	@EXIT:
		MOV AH, 4CH
		INT 21H	

	END MAIN