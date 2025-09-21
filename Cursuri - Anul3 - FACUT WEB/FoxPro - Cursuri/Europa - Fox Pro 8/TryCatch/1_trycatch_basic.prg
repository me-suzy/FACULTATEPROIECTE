********************************************************************************
* 1_TryCatch_Basic.prg
* Description:	This program will show the basic error handling functionality of
*				Try/Catch.
* Tip:	When in the source editor, type TRYEND{SPACE} and a TRY/ENDTRY block
*		will automatically be created via IntelliSense.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)
LOCAL x as Integer
LOCAL oErr as Exception
LOCAL cStr as Character

TRY

	* An error will occur since the variable "y" is not defined.
	x = y

	* This line of code will never execute because the line above causes an error
	* into the CATCH block.
	z = x

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

ENDTRY

* Code will execute after Try/Catch block even when there is a trapped error
MESSAGEBOX("Executing code after Try/Catch")

RETURN
