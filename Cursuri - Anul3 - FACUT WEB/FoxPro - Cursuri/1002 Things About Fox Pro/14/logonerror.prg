***********************************************************************
* Program....: LOGONERROR.PRG
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Illustrate Error Logging in a COM component
***********************************************************************

DEFINE CLASS LogOnError AS combase OLEPUBLIC

  ********************************************************************
  *** [E] TESTLOGGING(): Exposed method to test error logging
  ********************************************************************
  FUNCTION TestLogging()
  LOCAL lcRetStr
    WITH This
      *** Call the various methods that raise the errors
      .RaiseError()
      .GenError( 45 )
      .ShowMsg()
      *** Now get the errors into a string to return them
      lcRetStr = IIF( .nErrorCount > 0, .GetErrors(), "" )
      RETURN lcRetStr        
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [E] PROCESSREPORTING(): Illustrate the use of LogError() for process reporting
  ********************************************************************
  FUNCTION ProcessReporting()
  LOCAL lnCnt, lcRetStr
    WITH This
      *** Run a "10-Step" process
      FOR lnCnt = 1 TO 10
        .LogError( "Status", "Processing Step " + TRANSFORM( lnCnt ), _VFP.ServerName + PROGRAM())
      NEXT
      *** Now get the "errors" into a string to return them
      lcRetStr = IIF( .nErrorCount > 0, .GetErrors(), "" )
      RETURN lcRetStr        
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] RAISEERROR(): Raise a custom Error Message using ERROR command
  ********************************************************************
  PROTECTED FUNCTION RaiseError() AS VOID
    LOCAL lcErrString
    lcErrString = "An exception error was raised by " + _VFP.ServerName
    ERROR lcErrString
  ENDFUNC

  ********************************************************************
  *** [P] SHOWMSG(): Attempt to display a Windows MessageBox
  ********************************************************************
  PROTECTED FUNCTION ShowMsg() As VOID
    MESSAGEBOX( "This is a modal dialog", 16, "Whoops!" )
    RETURN
  ENDFUNC
  
  ********************************************************************
  *** [P] GENERROR(): Raise a VFP Error explicitly
  ********************************************************************
  PROTECTED FUNCTION GenError( tnErrNum AS Integer ) AS VOID
    IF VARTYPE( tnErrNum ) = "N" AND NOT EMPTY( tnErrNum )
      lnErr = tnErrnum
    ELSE
      lnErr = 12
    ENDIF
    ERROR( lnErr )     
  ENDFUNC

ENDDEFINE
