**********************************************************************
* Program....: GetUserChanges.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns a comma separated list of fields that have been changed
* ...........: by the user in the current row of the specified table
**********************************************************************
LPARAMETERS tcTable
LOCAL lcTable, lcRetVal, lnBuffMode, lcFldState, lnCnt, lcStatus 
*** Check the parameter, assume current alias if nothing passed
lcTable = IIF( VARTYPE(tcTable) # "C" OR EMPTY( tcTable ), ;
          ALIAS(), ALLTRIM( UPPER( tcTable )))
*** Check that the specified table name is used as an alias
IF EMPTY( lcTable ) OR ! USED( JUSTSTEM( lcTable) )
    *** Error - probably a developer error, so use an Error to report it!
    ERROR "9000: GetUserChanges() requires the alias of an open table" ;
            + CHR(13) + "be passed, or that the current work area should " ;
            + "contain an" + CHR(13) + "open table"
    RETURN .F.
ENDIF
lcRetVal = ''
*** Check the buffering status
lnBuffMode = CURSORGETPROP( 'Buffering', lcTable )
IF lnBuffMode = 1
    *** Not buffered, so can be no 'pending changes'
    RETURN lcRetVal
ENDIF
*** If we get this far, we have a buffered record which MAY have changes
*** So check for fields that have changed values
lcFldState = NVL( GETFLDSTATE( -1, lcTable ), "")
IF EMPTY( CHRTRAN( lcFldState, '1', ''))
    *** Nothing but '1', therefore nothing has changed 
    RETURN lcRetVal
ENDIF
*** So, we HAVE got at least one changed field! But we need to handle the 
*** DELETED flag indicator first. We can use "DELETED()" as the field name here!
IF ! INLIST( LEFT( lcFldState, 1), "1", "3" )
    lcRetVal = "DELETED()"
ENDIF
*** Now Get Rid of the Deleted Flag indicator
lcFldState = SUBSTR( lcFldState, 2 )
*** Get the field names for changed fields
FOR lnCnt = 1 TO FCOUNT()
    *** Loop through the fields
    lcStatus = SUBSTR( lcFldState, lnCnt, 1 )
    IF INLIST( lcStatus, "2", "4" )
        lcRetVal = lcRetVal + IIF( ! EMPTY( lcRetVal ), ",", "") + FIELD( lnCnt )
    ENDIF
NEXT
*** Return the list of changed fields
RETURN lcRetVal
