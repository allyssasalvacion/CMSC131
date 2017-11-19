TITLE NAMES (.EXE FORMAT)
.MODEL SMALL
;-------------------------------------
.STACK 32
;-------------------------------------
.DATA
	PROMPT0 DB ">Enter initial of first name: $"
	PROMPT1 DB 10, 13, ">Enter initial of middle name: $"
	PROMPT2 DB 10, 13, ">Enter initial of last name: $"

	MESSAGE0  DB 10, 13, 10, 13, "Initial of you first name is "
	INITIAL0  DB ?
	MESSAGE1  DB ", middle name is "
	INITIAL1  DB ?
	MESSAGE2  DB " and last name is "
	INITIAL2  DB ?
	MESSAGE3  DB "!$"
;-------------------------------------
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
		MOV INITIAL0, AL

		MOV AH, 09
		LEA DX, PROMPT1
		INT 21H

		MOV AH, 10H
		INT 16H
		MOV INITIAL1, AL

		MOV AH, 09
		LEA DX, PROMPT2
		INT 21H

		MOV AH, 10H
		INT 16H
		MOV INITIAL2, AL

		;print
		MOV AH, 09H
		LEA DX, MESSAGE0
		INT 21H

		;exit
		MOV AH, 4CH
		INT 21H 

	END MAIN