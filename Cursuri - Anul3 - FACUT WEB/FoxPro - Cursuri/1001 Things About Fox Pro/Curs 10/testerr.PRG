**********************************************************************
* Program....: TestErr.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Test Error Logging System
**********************************************************************
*** Create the logging object
RELEASE goErrorLog
PUBLIC goErrorLog
goErrorlog = NEWOBJECT( 'xErrLog', 'errorlog.prg', NULL )

*** Set up error handler
ON ERROR DO TrackErr WITH SET("DATASESSION"), PROGRAM(), LINENO() 

*** Now generate an error (Column sqlcon does not exist!)
SELECT * ;
  FROM sqlinv ;
 WHERE sqlcon = "A" ;
 INTO CURSOR cur_temp
 