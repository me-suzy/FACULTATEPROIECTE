***********************************************************************
* Program....: DLLERROR.PRG
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Illustrate the use of ComReturnError()
***********************************************************************
LOCAL loDll
ON ERROR DO errproc
*** Clear any old error log
IF FILE( 'errors.txt' )
  DELETE FILE errors.txt
ENDIF

*** Instantiate the DLL which is registered as "errtest"
loDll = CREATEOBJECT( 'errtest.StopOnErr' )
*** Try the MessageBox first...
loDll.ShowMsg()
*** Then the GenError
loDll.ShowMsg( 1214 ) 
*** ANd finally the custom Error
loDll.RaiseError()
ON ERROR
MODIFY FILE errors.txt NOWAIT
RETURN

FUNCTION ErrProc
LOCAL lnErrs, lnCnt, lcStr
LOCAL ARRAY laErr[1]
*** Get the details into an array
lnErrs = AERROR( laErr )
*** Write errors out to file
lcStr = ""
FOR lnCnt = 1 TO 7
  lcStr = lcStr + "[ Element " + TRANSFORM( lnCnt ) + "] = " + TRANSFORM( laErr[ lnCnt] ) + CHR(13) + CHR(10)
NEXT
*** Add a blank line to separate groups
lcStr = lcStr  + CHR(13) + CHR(10)
STRTOFILE( lcStr, 'errors.txt', 1 )
RETURN
