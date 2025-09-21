********************************************************************************
* 6_TryCatch_ClassInMethod.prg
* Description:	This program will show executing code contained in a Try/Catch
*				inside of a method of a class that also has an Error method.
*				Code executed inside a Try block are caught by the Catch block
*				and not the Class's Error method.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

x=NEWOBJECT("MyClass")
x.Proc1()
RETURN

DEFINE CLASS MyClass AS Session

	PROCEDURE Proc1
		LOCAL x as Integer
		LOCAL oErr as Exception
		LOCAL cStr as Character
		TRY
			* An error will occur since the variable "y" is not defined.
			x = y
		CATCH TO oErr
			cStr = "Error occurred in CATCH block inside of the Class's Proc1 method" + CRLF + CRLF + ;
				"[  Error: ] " + STR(oErr.ErrorNo) + CRLF + ;
		    	"[  LineNo: ] " + STR(oErr.LineNo) + CRLF + ; 
		    	"[  Message: ] " + oErr.Message + CRLF + ; 
		    	"[  Procedure: ] " + oErr.Procedure + CRLF + ; 
		    	"[  Details: ] " + oErr.Details + CRLF + ; 
		    	"[  StackLevel: ] " + STR(oErr.StackLevel) + CRLF + ; 
		    	"[  LineContents: ] " + oErr.LineContents
			MESSAGEBOX(cStr)

		ENDTRY
	ENDPROC

	* The error will not be handled here since the code is contained inside a
	* Try/Catch.
	PROCEDURE Error(nError, cMethod, nLine)
	ENDPROC

ENDDEFINE
