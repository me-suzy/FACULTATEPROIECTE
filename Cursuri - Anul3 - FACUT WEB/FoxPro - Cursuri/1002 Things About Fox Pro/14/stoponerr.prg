***********************************************************************
* Program....: StopOnErr.prg
* Author.....: Andy Kramek
* Date.......: 26 April 2002
* Notice.....: Copyright (c) 2002 Tightline Computers Ltd, All Rights Reserved
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Simple DLL that uses COMRETURNERROR() for error handling
***********************************************************************
DEFINE CLASS StopOnErr AS SESSION OLEPUBLIC

  ********************************************************************
  *** [E] ERROR(): Example of error handling using COMRETURNERROR()
  ********************************************************************
  FUNCTION Error( tnError, tcMethod, tnLine )
    LOCAL lcErrStr
    lcErrStr = "Error " + TRANSFORM( tnError ) + ": " ;
             + MESSAGE() ;
             + " Occurred at Line " + TRANSFORM( tnLine ) ;
             + " of " + ALLTRIM( tcMethod )
    COMRETURNERROR( lcErrStr, _VFP.ServerName )
  ENDFUNC

  ********************************************************************
  *** [E] RAISEERROR(): Raise a custom Error Message using ERROR command
  ********************************************************************
  FUNCTION RaiseError()
    LOCAL lcErrString
    lcErrString = "An exception error was raised by " + _VFP.ServerName
    ERROR lcErrString
  ENDFUNC

  ********************************************************************
  *** [E] SHOWMSG(): Attempt to display a Windows MessageBox
  ********************************************************************
  FUNCTION ShowMsg() As VOID
    MESSAGEBOX( "This is a modal dialog", 16, "Whoops!" )
    RETURN
  ENDFUNC
  
  ********************************************************************
  *** [E] GENERROR(): Raise a VFP Error explicitly
  ********************************************************************
  FUNCTION GenError( tnErrNum AS Integer ) AS VOID
    IF VARTYPE( tnErrNum ) = "N" AND NOT EMPTY( tnErrNum )
      lnErr = tnErrnum
    ELSE
      lnErr = 12
    ENDIF
    ERROR( lnErr )     
  ENDFUNC
ENDDEFINE