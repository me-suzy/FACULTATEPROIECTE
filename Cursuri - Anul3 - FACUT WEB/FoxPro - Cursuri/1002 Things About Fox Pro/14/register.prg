***********************************************************************
* Program....: REGISTER.PRG
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Wrapper to Select and Register DLL & EXE files
***********************************************************************
LPARAMETERS tlUnRegister, tcFile, tlNoShow
LOCAL llReg, lcTxt, lcFile, lcType, lnResult, lcCmd, lcParams, lcStr, lcMsg
*** Set the action flag based on first param
*** If EMPTY() assume .F., therefore REGISTER
*** IF NOT EMPTY() assume .T. and UN-REGISTER
llReg = IIF( EMPTY( tlUnRegister ), .F., .T. )
*** Set the GetFile Prompt accordingly 
lcTxt = IIF( tlUnRegister, "UN-Register", "Register" )
IF VARTYPE( tcFile ) = "C" AND NOT EMPTY( tcFile )
  *** We can assume we got a file name
  IF FILE( tcFile )
    *** And the file exists on the current search path
    lcFile = FULLPATH( tcFile )
  ELSE
    *** We need to get it's full name and location
    lcFile = GETFILE( 'DLL;EXE', lcTxt ) 
  ENDIF
ELSE
    *** Get the full name and location of the file
    lcFile = GETFILE( 'DLL;EXE', lcTxt ) 
ENDIF
*** Did we end up with a file?
IF EMPTY( lcFile )
  MESSAGEBOX( "No file specified to " +  lcTxt, 64, "Nothing to do" )
  RETURN
ENDIF
*** If we get this far we have a defined action, and a file name to work with
*** Set up the ShellExecute API function to run the process
DECLARE INTEGER ShellExecute IN SHELL32.DLL ;
        INTEGER lnHWnd, ;
        STRING lcAction, ;   
        STRING lcTarget, ;
        STRING lcExeParams, ;
        STRING lcDefDir, ;
        INTEGER lnShowWindow

*** Populate the File and Parameter variables depending on the task
lcType = JUSTEXT( lcFile )
IF llReg
  *** UNREGISTER
  IF lcType = "DLL"
    lcCmd = "REGSVR32"
    lcParams = " /s /u "  + lcFile
  ELSE
    lcCmd = lcFile
    lcParams = " /unregserver"
  ENDIF
ELSE
  *** REGISTER
  IF lcType = "DLL"
    lcCmd = "REGSVR32" 
    lcParams = " /s " + lcFile
  ELSE
    lcCmd = lcFile
    lcParams = " /regserver"
  ENDIF
ENDIF

*** Now Call ShellExecute to run the registration 
lnResult = ShellExecute( 0, 'open', lcCmd, lcParams, "", 1 )
*** Result >32 = Success, otherwise its an error code (see below for meaning)
IF lnResult <=32 AND NOT tlNoShow
  *** Show the error list
  TEXT TO lcStr NOSHOW
   0   The operating system is out of memory or resources. 
   1   The function is incorrect.
   2   The specified file was not found. 
   3   The specified path was not found. 
   5   Access denied
   8   Out of memory
  11   The .exe file is invalid (non-Win32® .exe or error in .exe image). 
  26   Sharing violation
  27   Association incomplete or invalid
  28   DDE request timed out
  29   DDE transaction failed 
  30   Other DDE transactions were being processed
  31   No application associated with file name extension or file is not printable
  32   DLL Not found
  ENDTEXT
  lcMsg = UPPER(lcTxt) + " Operation failed with Error: " + TRANSFORM( lnResult ) + CHR(13) + CHR(10)
  lcMsg = lcMsg + "Command Line = '" + lcCmd + " " + lcParams + "'" + CHR(13) + CHR(10)
  lcMsg = lcMsg + "  --------------------------<ERROR NUMBERS>--------------------------"+ CHR(13) + CHR(10)
  lcMsg = lcMsg + lcStr
  MESSAGEBOX( lcMsg, 16, 'API Call Failed' )
ENDIF
*** Return the result
RETURN lnResult
