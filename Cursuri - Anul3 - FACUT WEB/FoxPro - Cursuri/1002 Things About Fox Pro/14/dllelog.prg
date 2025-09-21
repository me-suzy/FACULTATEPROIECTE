***********************************************************************
* Program....: DLLELOG.PRG
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Illustrate the use of Error Logging in a Component
***********************************************************************
LOCAL loDll

*** Clear any old error log
IF FILE( 'errors.txt' )
  DELETE FILE errors.txt
  DELETE FILE repstatus.txt
ENDIF


*** Instantiate the DLL which is registered as "errtest"
loDll = CREATEOBJECT( 'errorlog.logonerror' )
*** Call the test method
lcRes = loDLL.TestLogging()
*** And write the results to a file
STRTOFILE( lcRes, 'errlog.txt' )
MODIFY FILE errlog.txt NOWAIT
*** Now call the Process logging method
lcRes = loDLL.ProcessReporting()
*** And write the results to a file
STRTOFILE( lcRes, 'repstatus.txt' )
MODIFY FILE repstatus.txt NOWAIT
