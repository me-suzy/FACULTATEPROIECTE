LOCAL lnCnt, lnCntUsed, lnSessCnt, loObj
LOCAL ARRAY laSess[1], laUsed[1]

ON ERROR *

WAIT WINDOW 'Clearing... please wait...' NOWAIT

*** Revert Tables and Close Them
lnSess = ASESSIONS( laSess )
FOR lnCnt = 1 TO lnSess
    SET DATASESSION TO (laSess[lnCnt])
    *** Roll Back Any Transactions
    IF TXNLEVEL() > 0
        DO WHILE TXNLEVEL() > 0
            ROLLBACK
        ENDDO
    ENDIF
    lnCntUsed = AUSED(laUsed)
    FOR lnSessCnt = 1 TO lnCntUsed
        SELECT (laUsed[lnSessCnt,2])
        IF CURSORGETPROP('Buffering') > 1
            TABLEREVERT( .T. )
        ENDIF
        USE
    NEXT
NEXT

*** Close any open forms
IF _Screen.FormCount > 0
    FOR lnCnt = _Screen.FormCount TO 0 STEP -1
        loObj = _Screen.Forms[ lnCnt ]
        loObj.Release()
    NEXT
ENDIF

CLOSE DATA ALL
SET PROCEDURE TO
SET MESSAGE TO
CLEAR
SET SYSMENU TO DEFA
RELEASE ALL
_SCREEN.Caption = VERSION(1)
ON SHUTDOWN
ON ERROR
ACTIVATE WINDOW COMMAND
KEYBOARD 'CLEAR ALL' + '{ENTER}'
CANCEL
