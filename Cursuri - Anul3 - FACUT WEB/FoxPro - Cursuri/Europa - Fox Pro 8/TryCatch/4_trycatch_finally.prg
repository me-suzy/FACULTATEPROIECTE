********************************************************************************
* 4_TryCatch_Finally.prg
* Description:	This program will show the error handling functionality of
*				Try/Catch that uses the Finally clause.  The Finally clause
*				executes no matter if the code in the Try fails or succeeds.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)
LOCAL x as Integer
LOCAL oErr as Exception
LOCAL cStr as Character

x = 0
DO WHILE x = 0
	TRY

		* An error will occur since the variable "y" is not defined.
		x = y

		MESSAGEBOX("No error occured in the Try block")
		
	* This is the structured block where the error is handled.
	CATCH TO oErr
		cStr = "Error occurred in CATCH block" + CRLF + CRLF + ;
			"[  Error: ] " + STR(oErr.ErrorNo) + CRLF + ;
	    	"[  LineNo: ] " + STR(oErr.LineNo) + CRLF + ; 
	    	"[  Message: ] " + oErr.Message + CRLF + ; 
	    	"[  Procedure: ] " + oErr.Procedure + CRLF + ; 
	    	"[  Details: ] " + oErr.Details + CRLF + ; 
	    	"[  StackLevel: ] " + STR(oErr.StackLevel) + CRLF + ; 
	    	"[  LineContents: ] " + oErr.LineContents
		MESSAGEBOX(cStr)

	FINALLY
		* Code will execute after Try/Catch block even when there is a trapped error
		MESSAGEBOX("Executing Final block inside the Try/Catch")

	ENDTRY
	
	* Define variable "y" to loop back into Try/Catch without an error
	y = 1
ENDDO

RETURN
