**********************************************************************
* Program....: CreCur.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Creates a cursor based on the structure of the named table
* ...........: Removes anything but the basic structural information
**********************************************************************
LPARAMETERS tcSceTable, tcCursorName
LOCAL laFields[1]
LOCAL lcTable, lcTgtCur, lnSelect, llWasOpen, llRetVal, lnFields 
LOCAL lnRow, lnCol
STORE .T. TO llWasOpen, llRetVal

*** Clean parameters and ensure a table is available
IF EMPTY(tcSceTable) OR VARTYPE(tcSceTable)#'C'
    lcTable = ALIAS()
ELSE
    lcTable = UPPER(ALLTRIM(tcSceTable))
ENDIF
IF EMPTY(lcTable)
	MESSAGEBOX('No Table Passed or Open', 16, 'Aborting...')
	RETURN
ENDIF
*** Save current work area (the create cursor command will change it!)
lnSelect = SELECT()
*** Open the table if necessary and note the fact!
IF ! USED( lcTable )
    USE (lcTable) IN 0
    llWasOpen = .F.
ENDIF
*** Default the cursor name if none passed
IF EMPTY(tcCursorName) OR VARTYPE(tcCursorName)#'C'
    lcTgtCur = "CUR_" + UPPER(ALLTRIM(lcTable))
ELSE
    lcTgtCur = UPPER(ALLTRIM(tcCursorName))
ENDIF
*** Get the structure of the table
lnFields = AFIELDS( laFields, lcTable )
*** Now blank out everything after Column 6 of the array
FOR lnRow = 1 TO lnFields
    FOR lnCol = 7 TO ALEN( laFields, 2 )
        laFields[ lnRow, lnCol ] = ""   
    NEXT
NEXT
*** Create the Cursor
CREATE CURSOR (lcTgtCur) FROM ARRAY laFields
*** Get the Return value
llRetVal = USED( lcTgtCur )
*** Tidy Up
IF ! llWasOpen
    USE IN ( tcSceTable )
ENDIF
SELECT ( lnSelect )
RETURN lLRetVal
