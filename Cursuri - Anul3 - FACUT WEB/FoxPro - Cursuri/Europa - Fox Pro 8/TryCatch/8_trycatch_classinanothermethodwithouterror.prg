********************************************************************************
* 8_TryCatch_ClassInAnotherMethodWithoutError.prg
* Description:	This program will show calling another method of a class while
*				contained in a Try/Catch.  The class does not have an Error
*				method.  Calls made to other methods will be handled by the Try/
*				Catch when there is no Error method contained in the class.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

x=NEWOBJECT("MyClass")
x.Proc1()
RETURN

DEFINE CLASS MyClass AS Session

	PROCEDURE Proc1
		TRY
			* Call a method of the class that will generate an error.  The error
			* will be processed by the Try/Catch.
			This.Proc2()

		* The error will be handled here since the class does not contain an Error
		* method.
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
	
	PROCEDURE Proc2
		LOCAL x as Integer
	
		* An error will occur since the variable "y" is not defined.
		x = y
	ENDPROC

ENDDEFINE
