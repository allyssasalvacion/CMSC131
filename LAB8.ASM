TITLE LAB8 (.EXE FORMAT)
.MODEL SMALL
;-------------------------------------
.STACK 100H
;-------------------------------------
.DATA
	SRCFILENAME  	 DB 'file.txt', 00H
	DESTFILENAME     DB 'new.txt', 00H
	SRCFILEHANDLE	 DW ?
	DESTFILEHANDLE   DW ?

	SRCRECORD_STR    DB 1001 DUP ('$') 
	DESTRECORD_STR   DB 1001 DUP (' ')

	ERROR1_STR       DB 'Error in opening file.$'
  	ERROR2_STR    	 DB 'Error reading from file.$'
  	ERROR3_STR       DB 'No record read from file.$'

  	ERROR4_STR       DB 'Error in creating file.$'
  	ERROR5_STR       DB 'Error writing in file.$'
  	ERROR6_STR       DB 'Record not written properly.$'
;-------------------------------------
.CODE
	MAIN PROC FAR
		MOV AX, @DATA
  		MOV DS, AX
;-------------------------------------
  		;open file
  		MOV AH, 3DH           ;requst open file
  		MOV AL, 00            ;read only; 01 (write only); 10 (read/write)
  		LEA DX, SRCFILENAME
  		INT 21H
  		JC DISPLAY_ERROR1
  		MOV SRCFILEHANDLE, AX
;-------------------------------------
		;read file
  		MOV AH, 3FH            ;request read record
  		MOV BX, SRCFILEHANDLE  ;file handle
  		MOV CX, 1001           ;record length
  		LEA DX, SRCRECORD_STR  ;address of input area
  		INT 21H
  		JC DISPLAY_ERROR2
  		CMP AX, 00             ;zero bytes read?
  		JE DISPLAY_ERROR3
;-------------------------------------
		CALL CONVERT
;-------------------------------------
		;create file
  		MOV AH, 3CH            ;request create file
  		MOV CX, 00             ;normal attribute
  		LEA DX, DESTFILENAME   ;load path and file name
  		INT 21H
  		JC DISPLAY_ERROR4      ;if there's error in creating file, carry flag = 1, otherwise 0
  		MOV DESTFILEHANDLE, AX
;-------------------------------------
		;write file
  		MOV AH, 40H            ;request write record
  		MOV BX, DESTFILEHANDLE ;file handle
  		MOV CX, 1001           ;record length
  		LEA DX, DESTRECORD_STR ;address of output area
  		INT 21H
  		JC DISPLAY_ERROR5      ;if carry flag = 1, there's error in writing (nothing is written)
  		CMP AX, 1001           ;after writing, set AX to size of chars nga na write
  		JNE DISPLAY_ERROR5
;-------------------------------------
		;close file handle
  		MOV AH, 3EH             ;request close file
  		MOV BX, SRCFILEHANDLE   ;file handle
  		INT 21H
;-------------------------------------
		;close file handle
  		MOV AH, 3EH             ;request close file
  		MOV BX, DESTFILEHANDLE  ;file handle
  		INT 21H
;-------------------------------------
		CALL PRINT_CONSOLE
;-------------------------------------
		JMP EXIT
;-------------------------------------
		;ERROR STRINGS
		DISPLAY_ERROR1:
			MOV AH, 09
			LEA DX, ERROR1_STR
			INT 21H

			JMP EXIT

		DISPLAY_ERROR2:
			MOV AH, 09
			LEA DX, ERROR2_STR
			INT 21H

			JMP EXIT

		DISPLAY_ERROR3:
			MOV AH, 09
			LEA DX, ERROR3_STR
			INT 21H

			JMP EXIT

		DISPLAY_ERROR4:
			MOV AH, 09
			LEA DX, ERROR4_STR
			INT 21H

			JMP EXIT

		DISPLAY_ERROR5:
			MOV AH, 09
			LEA DX, ERROR5_STR
			INT 21H

			JMP EXIT

		DISPLAY_ERROR6:
			MOV AH, 09
			LEA DX, ERROR6_STR
			INT 21H

			JMP EXIT
;--------------------------------------
		EXIT:
			MOV AH, 4CH
			INT 21H
	MAIN ENDP
;--------------------------------------
	CONVERT PROC NEAR
		MOV CX, AX

		LEA SI, SRCRECORD_STR
		LEA DI, DESTRECORD_STR
;--------------------------------------
		L1:
			MOV AL, [SI]
			JMP UPPERCASE
		
		DECREASE:
			MOV [DI], AX
			INC SI					
			INC DI

			DEC CX
			CMP CX, 0
			JNE L1
			JE RETURN
;--------------------------------------
			UPPERCASE:
				CMP AL, 'A'
				JB LOWERCASE
				CMP AL, 'Z'
				JA LOWERCASE

				ADD AL, 20H 
				JMP DECREASE
;--------------------------------------
			LOWERCASE:
				CMP AL, 'a'
				JB DIGIT
				CMP AL, 'z'
				JA DIGIT

				SUB AL, 20H
				JMP DECREASE
;--------------------------------------
			DIGIT:
				CMP AL, '0'
				JB SPECIAL
				CMP AL, '9'
				JA SPECIAL

				JMP DECREASE
;--------------------------------------
			SPECIAL:
				MOV AL, ' '
				JMP DECREASE
;--------------------------------------
			RETURN:
				RET
	CONVERT ENDP
;--------------------------------------
	PRINT_CONSOLE PROC NEAR
		MOV AL, '$'
		MOV [DI], AX

		MOV AH, 09
		LEA DX, DESTRECORD_STR
		INT 21H
		RET
	PRINT_CONSOLE ENDP

;--------------------------------------
END MAIN