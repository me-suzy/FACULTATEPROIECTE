**********************************************************************
* Program....: IsChanged.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns a logical value indicating whether a table has pending
* ...........: changes, whatever the buffer mode employed
**********************************************************************
LPARAMETERS tcTable
LOCAL lcTable, lnBuffMode, lnRecNo, llRetVal, lcFldState
*** Check the parameter, assume current alias if nothing passed
lcTable = IIF( VARTYPE(tcTable) # "C" OR EMPTY( tcTable ), ALIAS(), ALLTRIM( UPPER( tcTable )))
*** Check that the specified table name is used as an alias
IF EMPTY( lcTable ) OR ! USED( JUSTSTEM( lcTable) )
    *** We have an error - probably a developer error, so use an Error to report it!
    ERROR "9000: IsChanged() requires that the alias of an open table be" + CHR(13) ;
            + "passed, or that the current work area should contain an" + CHR(13) ;
            + "open table"
    RETURN .F.
ENDIF
*** Check the buffering status
lnBuffMode = CURSORGETPROP( 'Buffering', lcTable )
*** If no buffering, just return .F.
IF lnBuffMode = 1
    RETURN .F.
ENDIF
*** Now deal with the two buffer modes
IF INLIST( lnBuffMode, 2, 3 )
    *** If Row Buffered, use GetFldState()
    lcFldState = NVL( GETFLDSTATE( -1, lcTable ), "")
    *** If lcFldState contains anything but 1's then something has changed
    *** All 3's indicates an empty, appended record, but that is still a change!
    *** Use CHRTRAN to strip out 1's - and just see if anything is left.
    llRetVal = NOT EMPTY( CHRTRAN( lcFldState, "1", "") )
ELSE
    *** Find the record number of the first changed record.
    *** Appended records will have a record number which is negative
    *** so we must check for a return value of "NOT EQUAL TO 0", 
    *** rather than simply "GREATER THAN 0"
    llRetVal = ( GETNEXTMODIFIED( 0, lcTable ) # 0 )
ENDIF
RETURN lLRetVal
