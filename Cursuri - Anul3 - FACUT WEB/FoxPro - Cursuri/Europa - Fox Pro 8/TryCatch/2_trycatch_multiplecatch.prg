********************************************************************************
* Name:  2_TryCatch_MultipleCatch.prg
* Description:	This program will show the how to use multiple Catch statements
*				for error handling with Try/Catch.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)
LOCAL x as Integer
LOCAL oErr as Exception
LOCAL cStr as Character

TRY

	* An error will occur since the variable "y" is not defined.
	x = y

	* This line of code will never execute because the line above causes an error
	* into the Catch block.
	z = x

* This is the structured block where the error is handled if the When clause
* equates to true.
CATCH TO oErr WHEN oErr.ErrorNo = 12
	cStr = "Error occurred in CATCH block with WHEN oErr.ErrorNo = 12" + CRLF + CRLF + ;
		"[  Error: ] " + STR(oErr.ErrorNo) + CRLF + ;
    	"[  LineNo: ] " + STR(oErr.LineNo) + CRLF + ; 
    	"[  Message: ] " + oErr.Message + CRLF + ; 
    	"[  Procedure: ] " + oErr.Procedure + CRLF + ; 
    	"[  Details: ] " + oErr.Details + CRLF + ; 
    	"[  StackLevel: ] " + STR(oErr.StackLevel) + CRLF + ; 
    	"[  LineContents: ] " + oErr.LineContents
	MESSAGEBOX(cStr)

* This is the structured block where the error is handled if the When clause
* equates to true.
CATCH TO oErr WHEN oErr.ErrorNo = 225
	cStr = "Error occurred in CATCH block with WHEN oErr.ErrorNo = 225" + CRLF + CRLF + ;
		"[  Error: ] " + STR(oErr.ErrorNo) + CRLF + ;
    	"[  LineNo: ] " + STR(oErr.LineNo) + CRLF + ; 
    	"[  Message: ] " + oErr.Message + CRLF + ; 
    	"[  Procedure: ] " + oErr.Procedure + CRLF + ; 
    	"[  Details: ] " + oErr.Details + CRLF + ; 
    	"[  StackLevel: ] " + STR(oErr.StackLevel) + CRLF + ; 
    	"[  LineContents: ] " + oErr.LineContents
	MESSAGEBOX(cStr)

* If no specific Catch statement traps the error then this Catch will be called.
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

ENDTRY

* Code will execute after Try/Catch block even when there is a trapped error
MESSAGEBOX("Executing code after Try/Catch")

RETURN
