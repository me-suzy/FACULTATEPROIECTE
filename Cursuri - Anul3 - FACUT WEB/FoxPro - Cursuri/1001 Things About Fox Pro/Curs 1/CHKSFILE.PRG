*******************************************************************************
* Program....: ChkSFile.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Checks for a Semaphore File, creates one if not found and 
* ...........: returns a flag
*******************************************************************************
FUNCTION ChkSFile( tcAppName )
LOCAL lcAppName, lcFile, lnHnd, llRetVal
set step on
*** Default lcAppName if nothing passed
lcAppName = IIF( EMPTY(tcAppName) OR VARTYPE( tcAppName ) # "C", ;
                'apprun', LOWER( ALLTRIM( tcAppName ) ) )
*** Force a TXT extension for the semaphore file in current directory
lcFile = (SYS(5) + CURDIR() + FORCEEXT( lcAppName, 'txt' ))
IF ! FILE( lcFile )
    *** File not found, so create it
    lnHnd = FCREATE( lcFile )
    IF lnHnd < 0
        *** Cannot create the file, some sort of error! Set Return Flag
        llRetVal = .T.
    ELSE
        *** Close the file
        FCLOSE( lnHnd )
    ENDIF    
ELSE
    *** Set Return Flag
    llRetVal = .T.
ENDIF
*** Return Status Flag
RETURN llRetVal
    
