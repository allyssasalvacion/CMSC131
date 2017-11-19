TITLE LAB2 (.EXE FORMAT)
.MODEL SMALL
;----------------------------------------
.STACK 32
;----------------------------------------
.DATA
	LINE0 DB 10, 13, "***********  ***********  **         *      ******"
	LINE1 DB 10, 13, "*                 *       * *        *     *      *"
	LINE2 DB 10, 13, "*                 *       *  *       *    *        *"
	LINE3 DB 10, 13, "*                 *       *   *      *   *          *"
	LINE4 DB 10, 13, "*                 *       *    *     *  *            *"
	LINE5 DB 10, 13, "*   *******       *       *     *    *  *            *"
	LINE6 DB 10, 13, "*         *       *       *      *   *   *          *"
	LINE7 DB 10, 13, "*         *       *       *       *  *    *        *"
	LINE8 DB 10, 13, "*         *       *       *        * *     *      *"
	LINE9 DB 10, 13, "***********  ***********  *         **      ******$" 
;----------------------------------------
.CODE
	MAIN:
		;initialize DS
		MOV AX, @DATA
		MOV DS, AX

		MOV AH, 09
		LEA DX, LINE0
		INT 21H

		;exit
		MOV AH, 4CH
		INT 21H
	END MAIN


