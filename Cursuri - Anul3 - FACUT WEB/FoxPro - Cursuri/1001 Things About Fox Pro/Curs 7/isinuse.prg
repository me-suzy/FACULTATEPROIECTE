**********************************************************************
* Program....: IsInUse.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Tries to gain exclusive use of a table to see if the table
* ...........: is used by someone else
**********************************************************************
LPARAMETERS tcTable
LOCAL lcTable, lcOldError, llRetVal, lnWasUsedIn, lnWasOrder
*** Check parameters and ensure a table is available
IF EMPTY( tcTable ) OR VARTYPE( tcTable ) # 'C'
	MESSAGEBOX('No Table Passed to IsInUse()', 16, 'Aborting...')
	RETURN 
ELSE
    lcTable = UPPER( ALLTRIM( tcTable ))
ENDIF
*** If we have the table in use already, close it and note the fact!
llWasUsedHere = USED( lcTable )
IF llWasUsedHere
    *** We were using it, so find out where and save it
    lnWasUsedIn = SELECT( lcTable )
    lnWasOrder = ORDER( lcTable )
    lnWasRec = IIF( RECNO( lcTable ) > RECCOUNT( lcTable ), RECCOUNT( lcTable ), RECNO( lcTable ) )
    USE IN ( lcTable )
ELSE
    lnWasUsedIn = 0
    lnWasOrder = 0
    lnWasRec = 0
ENDIF
*** Save current error handling and disable it temporarily
lcOldError = ON( "ERROR" )
ON ERROR llRetVal = .T.
*** Try and use the table exlusively
USE ( lcTable ) IN 0 EXCLUSIVE
*** If we succeeded, close it again
IF ! llRetVal
    USE IN ( lcTable )
ENDIF
*** Restore the Error Handler
ON ERROR &lcOldError
*** If it was open, then reset it properly
IF llWasUsedHere
    USE ( lcTable ) AGAIN IN ( lnWasUsedIn ) ORDER ( lnWasOrder )
    IF lnWasRec # 0
        *** It was on a specific record
        GOTO ( lnWasRec ) IN ( lcTable )
    ELSE
        *** Just go to the first available record
        GO TOP IN ( lcTable )
    ENDIF
ENDIF
*** Return the result
RETURN llRetVal
