******************************************************************************
* Program....: IsAppRun.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Checks for a window which is created with a Unique ID by and 
* ...........: in  the application. Combination of Semaphore and API.
* ...........: Based on code originally posted in the Public Domain 
* ...........: by Christof Lange
******************************************************************************
FUNCTION IsAppRun( tcUniqueID )
LOCAL llRetVal, lcUniqueID
*** MUST pass an application ID to this function!
IF EMPTY(tcUniqueID) OR VARTYPE( tcUniqueID ) # "C"
    MESSAGEBOX( 'An Application Specific Character ID is mandatory' + CHR(13) ;
              + 'when calling the IsAppRun() function', 16, 'Developer Error' )
    RETURN .T.
ELSE
    *** Strip out any spaces
	lcUniqueID = STRTRAN( tcUniqueID, " " )
ENDIF

*** First check for the existence of the Semaphore window
IF WEXIST("_Semaphore_")
	RETURN .T.
ENDIF 

*** Look for an occurrence of this ID as a Window Name
DECLARE INTEGER FindWindow IN Win32Api AS FindApp String, String
IF FindApp( NULL, lcUniqueID ) > 0
    *** We found one!  Set Return Value
	llRetVal = .T.
ELSE
	*** Create a new window with this ID
	DEFINE WINDOW _Semaphore_ IN DESKTOP ;
			FROM 1,1 TO 2,2 ;
			TITLE lcUniqueID
ENDIF
*** Return Status Flag
RETURN llRetVal
