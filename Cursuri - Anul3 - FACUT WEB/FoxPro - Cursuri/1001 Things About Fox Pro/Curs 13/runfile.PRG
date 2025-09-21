**********************************************************************
* Program....: RunFile.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Open or Print a named file/document using windows association
**********************************************************************
LPARAMETERS tcDocName, tlPrint
LOCAL lnRetVal, lnShow, lcAction
*** Check Parameters
IF VARTYPE( tcDocName ) # "C" OR EMPTY(tcDocName)
    WAIT WINDOW "Must Pass a valid document name and extension" NOWAIT
    RETURN
ENDIF
*** Must have an Extension too
IF EMPTY( JUSTEXT( tcDocName ))
  WAIT WINDOW "Must Pass a valid document name and extension" NOWAIT
  RETURN
ENDIF

*** Check action, if tlPrint = .T., the "Print" otherwise "Open"
lcAction = IIF( tlPrint, "Print", "Open" )
lnShow   = IIF( tlPrint, 0, 5 )

*** Declare API function
DECLARE INTEGER ShellExecute IN Shell32.dll ;
	LONG HWnd, ;
	STRING cAction, ;
	STRING cFileName, ;
	STRING cParameters, ;
	STRING cPath, ;
	INTEGER nShowWindow

*** Now execute it
lnRetVal = ShellExecute( 0, lcAction, tcDocName, "", "", lnShow)

RETURN
