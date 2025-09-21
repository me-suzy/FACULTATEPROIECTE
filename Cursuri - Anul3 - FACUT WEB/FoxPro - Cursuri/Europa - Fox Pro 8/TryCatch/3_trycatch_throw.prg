********************************************************************************
* 3_TryCatch_Throw.prg
* Description:	This program will show error handling functionality of 
* 				Try/Catch with using Throw to bubble up the error to a higher
*				error handler.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL oErr as Exception
LOCAL cStr as Character

TRY 
	* A procedure will be called that generates an error and Throw the error
	* back to this procedure
	ProcWithError()
	
CATCH TO oErr
	cStr = "Outer Exception Object" + CRLF + CRLF + ;
		"[  Error: ] " + STR(oErr.ErrorNo) + CRLF + ;
    	"[  LineNo: ] " + STR(oErr.LineNo) + CRLF + ; 
    	"[  Message: ] " + oErr.Message + CRLF + ; 
    	"[  Procedure: ] " + oErr.Procedure + CRLF + ; 
    	"[  Details: ] " + oErr.Details + CRLF + ; 
    	"[  StackLevel: ] " + STR(oErr.StackLevel) + CRLF + ; 
    	"[  LineContents: ] " + oErr.LineContents + CRLF + CRLF + ;
    	"   UserValue becomes inner exception Thrown from nested Try/Catch" + CRLF + ;
		"   [  Error: ] " + STR(oErr.UserValue.ErrorNo) + CRLF + ;
    	"   [  LineNo: ] " + STR(oErr.UserValue.LineNo) + CRLF + ; 
    	"   [  Message: ] " + oErr.UserValue.Message + CRLF + ; 
    	"   [  Procedure: ] " + oErr.UserValue.Procedure + CRLF + ; 
    	"   [  Details: ] " + oErr.UserValue.Details + CRLF + ; 
    	"   [  StackLevel: ] " + STR(oErr.UserValue.StackLevel) + CRLF + ; 
    	"   [  LineContents: ] " + oErr.UserValue.LineContents 
	MESSAGEBOX(cStr)
ENDTRY

* Code will execute after Try/Catch block even when there is a trapped error
MESSAGEBOX("Executing code after outer Try/Catch")

RETURN


* The procedure that will throw an error back to the caller.
PROCEDURE ProcWithError

	LOCAL x as Integer
	LOCAL oErr as Exception
	LOCAL cStr as Character

	TRY

		* An error will occur since the variable "y" is not defined.
		x = y

		* This line of code will never execute because the line above causes an 
		* error into the CATCH block.
		z = x

	* This is the structured block where the error will be thrown to the calling 
	* procedure.
	CATCH TO oErr
		THROW oErr

	ENDTRY

	* This line of code will never execute since the error was Thrown to the caller.
	z = 1

ENDPROC
