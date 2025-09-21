*******************************************************************************
* Program....: OnceOnly.prg
* Version....: 1.0
* Author.....: Andy Kramek
* Date.......: August 16, 1999
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Checks for an instance ofthe current application window and,
* ...........: if found, quits the application and activates the original
*******************************************************************************
FUNCTION OnceOnly
LOCAL lnHWND, lcTitle, llRetVal
set step on
*** Set UP API Calls
Declare Integer FindWindow IN Win32Api AS FindApp String, String
Declare BringWindowToTop   IN Win32APi AS MakeTop Integer
Declare ShowWindow         IN Win32Api AS ShowWin Integer, Integer
	  
*** Get the current Screen Caption
lcTitle = _Screen.Caption

*** Change it to avoid finding THIS instance
_Screen.Caption = SYS(3)

*** Now locate another instance
lnHWND = FindApp( NULL, lcTitle )

*** And restore the original caption
_Screen.Caption = lcTitle

*** Check the results
IF lnHWND > 0
    *** We have found something!
    *** So make it uppermost and maximize it (ShowWin => 3)
	MakeTop( lnHWND )
	ShowWin( lnHWND, 3 )
    *** Set the Return Value
    llRetVal = .T.
ENDIF

*** Return Status for action
RETURN llRetVal
