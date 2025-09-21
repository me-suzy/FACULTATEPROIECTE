**********************************************************************
* Program....: ArToCurs.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Accepts an array and converts it into a cursor
**********************************************************************
LPARAMETERS taSceArray, tcCursorName
LOCAL ARRAY laStru[1]
LOCAL lnRows, lnCols, lnCnt, lcColNum, lnColSize, lcInstr
EXTERNAL ARRAY taSceArray

*** Check that we have an array as a parameter
*** NB Cannot use VarType() here in case array does NOT exist!
IF TYPE( "taSceArray[1]" ) = "U"
    ASSERT .F. MESSAGE "Must pass a valid Array to ArToCurs()"
    RETURN
ENDIF

*** Default Cursor Name to "arraycur" if nothing passed
lcCursor = IIF( VARTYPE( tcCursorName ) = "C" AND ! EMPTY( tcCursorName ), ;
                ALLTRIM( LOWER( tcCursorName )), "arraycur" )

*** Determine the size of the array
lnRows = ALEN(taSceArray,1)
lnCols = MAX( ALEN(taSceArray,2), 1 )
DIMENSION laStru(lnCols, 4)

*** Create the structure array
lcInstr = ""
FOR lnCnt = 1 TO lnCols
    *** Name Columns with the Data Type + Zero Padded number
    lcColNum = PADL( lnCnt, 5, "0" )
    laStru[ lnCnt, 1 ] = VARTYPE( taSceArray[ 1, lnCnt] ) + lcColNum  && Name
    laStru[ lnCnt, 2 ] = "C"                                       && Data Type
    *** Determine Maximum Column width needed
    lnColSize = 1
    FOR lnRowCnt = 1 TO lnRows
        lnColSize = MAX( lnColSize, LEN( TRANSFORM( taSceArray[lnRowCnt, lnCnt] )))
    NEXT
    laStru[ lnCnt, 3 ] = lnColSize                                 && Col Width
    laStru[ lnCnt, 4 ] = 0                                         && No Decimals
    *** Add the field to the Insert String
    IF ! EMPTY( lcInstr )
        lcInStr = lcInstr + ","
    ENDIF
	IF lnCols > 1
		lcInStr = lcInstr + "TRANSFORM(taSceArray[lnCnt," + ALLTRIM(STR( lnCnt)) + "])"
	ELSE
		lcInStr = lcInstr + "TRANSFORM(taSceArray[lnCnt" + "])"
	ENDIF
NEXT

*** Create the cursor from the structure array
CREATE CURSOR (lcCursor) FROM ARRAY laStru

*** Populate the cursor
FOR lnCnt = 1 TO lnRows
   INSERT INTO (lcCursor) VALUES ( &lcInStr )
NEXT
GO TOP IN (lcCursor)

*** Return Number of records
RETURN RECCOUNT( lcCursor )
