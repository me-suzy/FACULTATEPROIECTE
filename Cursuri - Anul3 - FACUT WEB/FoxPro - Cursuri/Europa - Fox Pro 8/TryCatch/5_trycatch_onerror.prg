********************************************************************************
* 5_TryCatch_OnError.prg
* Description:	This program will use Try/Catch error handling along with ON
*				ERROR.
********************************************************************************
ON ERROR MESSAGEBOX("ON ERROR is handling the error")
DO Proc1
ON ERROR
RETURN

PROCEDURE Proc1
	Proc2()
ENDPROC

PROCEDURE Proc2
	TRY
		* Call a procedure that causes an error.
		Proc3()
	
	* The CATCH block will never get executed since the WHEN phrase will never
	* equate to true.
	CATCH TO oErr WHEN .F.

	ENDTRY
ENDPROC

PROCEDURE Proc3
	* An error will occur since the variable "y" is not defined.
	x = y
ENDPROC

