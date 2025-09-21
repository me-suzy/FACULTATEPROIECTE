**********************************************************************
* Program....: ClearAll.PRG
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Cleans up the Development environment
**********************************************************************
LOCAL lnCnt, lnCntUsed
LOCAL ARRAY laUsed[1]
*** Turn off error handling for now
ON ERROR *
*** Clear Screen
CLEAR
WAIT WINDOW 'Clearing... please wait...' NOWAIT
*** Roll Back Any Transactions
IF TXNLEVEL() > 0
	DO WHILE TXNLEVEL() > 0
		ROLLBACK
	ENDDO
ENDIF
*** Revert Tables and Close Them
FOR EACH loForm IN _Screen.Forms
	*** Find out what Datasession it is in
	lnDS = loForm.DataSessionID
	*** Has it any tables open?
	lnCntUsed = AUSED(laUsed, lnDS)
	IF lnCntUsed > 0
		SET DATASESSION TO (lnDS)
        *** If so, revert all uncommitted changes
	    FOR lnCnt = 1 TO lnCntUsed
		    SELECT (laUsed[lnCnt,2])
    		IF CURSORGETPROP('Buffering') > 1
	    		=TABLEREVERT( .T. )
	    	ENDIF
	    	USE
	    NEXT
	ENDIF
	*** And release the form
	loForm.Release()
NEXT
*** Now Close other tables and databases
CLOSE TABLES ALL
CLOSE DATA ALL
*** Release Memory Variables, Procedures 
*** and Class Libraries
CLEAR MEMORY
CLEAR ALL
SET PROCEDURE TO
SET CLASSLIB TO
*** Get the command window and system menu back
ACTIVATE WINDOW COMMAND
SET SYSMENU TO DEFAULT
*** Clear global settings
ON SHUTDOWN
ON ERROR
ON KEY
ON ESCAPE
*** Cancel any open programs
CANCEL