********************************************************************************
* 3_EventBinding_RaiseEvent.prg
* Description:	This program will show how you can raise an event from a custom
*				method by using the RaiseEvent function.  The sample will show
*				how to write an entry in a log file every time a report is 
*				printed.
* Tip:	You can use it for raising native events and methods.  When you directly
*		call native methods, their associated event is not raised.  By using the
*		RaiseEvent function you can also ensure the event will be raised.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

PUBLIC oPrint
PUBLIC oLog

* Create an instance of the PrintClass that is used to print reports.
oPrint=NEWOBJECT("PrintClass")

* Create an instance of the LogClass that is used to log entries when the reports
* are printed.
oLog=NEWOBJECT("LogClass")

* Raise the PrintReport method of the PrintClass object.
RAISEEVENT(oPrint,"PrintReport")

* Bind the PrintReport method of the PrintClass object to the LogClass object's
* LogEvent method.
BINDEVENT(oPrint,"PrintReport",oLog,"LogEvent")

* Print a report.
oPrint.PrintReport()

* Display the log generated.
MODIFY FILE log.txt NOWAIT

lcStr = "A report has been requested to be printed by calling the oPrint's" + ;
		" PrintReport method.  That method raises an event using the RaiseEvent" + ;
		" function to call the Log class's LogEvent method.  This method writes" + ;
		" an entry into a log text file as shown here."
MESSAGEBOX(lcStr)

RELEASE oPrint
RELEASE oLog

RETURN


* The class that will handle the printing reports.
DEFINE CLASS PrintClass AS Session

	PROCEDURE PrintReport
		* Code to handle printing of a report
		*
	ENDPROC

ENDDEFINE


* The class that will handle the logging of entries when the reports are printed.
DEFINE CLASS LogClass AS Session
   
   PROCEDURE LogEvent
   		* Write the log entry to a log file.
   		STRTOFILE("Report Printed at " + TRANSFORM(DATETIME()), ;
   			"Log.txt")

   		RETURN
   	ENDPROC
   	
ENDDEFINE
