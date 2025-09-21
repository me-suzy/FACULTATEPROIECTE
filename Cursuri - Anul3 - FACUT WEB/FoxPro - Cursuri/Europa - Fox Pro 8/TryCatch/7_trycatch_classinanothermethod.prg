********************************************************************************
* 7_TryCatch_ClassInAnotherMethod.prg
* Description:	This program will show calling another method of a class while
*				contained in a Try/Catch.  The class also has an Error method.
*				Calls made to other methods are caught by the Class's Error
*				method.
* Tip: 	You can now trap errors inside of the Error Method of a class by
*		wrapping your error code inside of a Try/Catch.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

x=NEWOBJECT("MyClass")
x.Proc1()
RETURN

DEFINE CLASS MyClass AS Session

	PROCEDURE Proc1
		TRY
			* Call a method of the class that will generate an error.  The error
			* will be processed by the Error method of the class.
			This.Proc2()

		* The error will not be handled here since the class contains an Error method.
		CATCH
		
		ENDTRY
	ENDPROC
	
	PROCEDURE Proc2
		LOCAL x as Integer
	
		* An error will occur since the variable "y" is not defined.
		x = y
	ENDPROC

	* The error will be handled here.
	PROCEDURE Error(nError, cMethod, nLine)
		LOCAL cStr as Character
		TRY
			cStr = "Error in Proc2 is handled in the Error Method of the Class" + CRLF + CRLF + ;
				"[  Error: ] " + STR(nError) + CRLF + ;
		    	"[  Method: ] " + cMethod + CRLF + ; 
		    	"[  LineNo: ] " + STR(nLine) 
			MESSAGEBOX(cStr)

			* A new error is generated here that will be trapped by the Catch in
			* the Error method.
			USE BadTableName

		CATCH TO oErr
			cStr = "A second error occured inside a Try/Catch in the Error method and is handled by the CATCH block" + CRLF + CRLF + ;
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

ENDDEFINE
