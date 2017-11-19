TITLE LAB3 (.EXE FORMAT)
.MODEL SMALL
;--------------------------------------
.STACK 32
;--------------------------------------
.DATA
	PROMPT0 DB "> Enter character: $"
	CASE0 DB 10, 13, "Upper Case Letter$"
	CASE1 DB 10, 13, "Lower Case Letter$"
	CASE2 DB 10, 13, "Digit$"
	CASE3 DB 10, 13, "Special Character$"
	INPUT DB ?, '$'
;--------------------------------------
.CODE
	MAIN:
		;initialize DS
		MOV AX, @DATA
		MOV DS, AX

		MOV AH, 09
		LEA DX, PROMPT0
		INT 21H

		MOV AH, 10H
		INT 16H
		MOV INPUT, AL

		MOV AH, 09
		LEA DX, INPUT
		INT 21H

		@UPPERCASE:
			CMP INPUT, "A"
			JB @LOWERCASE
			CMP INPUT, "Z"
			JA @LOWERCASE

			MOV AH, 09
			LEA DX, CASE0
			INT 21H

			JMP @EXIT

		@LOWERCASE:
			CMP INPUT, "a"
			JB @DIGIT
			CMP INPUT, "z"
			JA @DIGIT

			MOV AH, 09
			LEA DX, CASE1
			INT 21H

			JMP @EXIT

		@DIGIT:
			CMP INPUT, "0"
			JB @SPECIAL
			CMP INPUT, "9"
			JA @SPECIAL

			MOV AH, 09
			LEA DX, CASE2
			INT 21H

			JMP @EXIT

		@SPECIAL:
			MOV AH, 09
			LEA DX, CASE3
			INT 21H

			JMP @EXIT

		@EXIT:
			MOV AH, 4CH
			INT 21H

	END MAIN