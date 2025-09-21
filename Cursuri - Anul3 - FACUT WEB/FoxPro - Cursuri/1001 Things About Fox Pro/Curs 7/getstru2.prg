**********************************************************************
* Program....: GetStru2.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Replacement for List Structure Command
* ...........: Call with no params for currently selected table
* ...........: or pass a DBF File name (include extension) to force
* ...........: the specified table to be opened
**********************************************************************
LPARAMETERS tcTable
LOCAL lcTable, lnSelect, lnFields, lcFile, lnHnd, lnNextByte
LOCAL lcCDX, lcMem, lcDBC, lWasOpen, lcStr, lcAlias

*** Clean parameters and ensure a table is available
lcTable = IIF(EMPTY(tcTable) OR VARTYPE(tcTable)#'C', ALIAS(), UPPER(ALLTRIM(tcTable)))
IF EMPTY(lcTable)
	MESSAGEBOX('No Table Passed or Open', 16, 'Aborting...')
	RETURN
ENDIF

*** Force a DBF Extension on to the table if none supplied
IF EMPTY( JUSTEXT( lcTable ))
    lcTable = ALLTRIM( lcTable ) + ".DBF"
ENDIF
*** Open/Select Table if not the selected Alias
lnSelect = SELECT()
lcAlias = JUSTSTEM(lcTable)
lWasOpen = .T.
IF ! ALIAS() == lcAlias
	IF ! USED( lcAlias )
		IF FILE( lcTable )
			USE (lcTable) AGAIN IN 0
			lWasOpen = .F.
		ELSE
			MESSAGEBOX('Table Name ' + lcTable + ' Not Found', 16, 'Duff Name!' )
			RETURN
		ENDIF
	ENDIF
	SELECT (lcAlias)
ENDIF

*** Get field count and File Name
lnFields = FCOUNT()
lcFile = DBF()
*** Open an output file
lnHnd = FCREATE( lcAlias + '.TXT')
IF UPPER(JUSTEXT(lcFile)) = 'TMP'
	*** Details for Cursor (or View)
	CursorLst( lcAlias, lnHnd )
ELSE
	*** Details for Table 
	TableLst( lcFile, lnHnd)
ENDIF

*** Index Details
IndexLst( lnHnd )

*** Field Details
FieldLst( lnHnd )

*** Close Output File and Table
FCLOSE( lnHnd )
IF ! lWasOpen
	USE IN (lcAlias)
ENDIF

MODI FILE ( lcAlias + '.TXT') NOWAIT

*** Clean Up and Exit
SELECT ( lnSelect )
RETURN

*****************************************
* Get Info for Cursors
*****************************************
PROCEDURE CursorLst( tcFile, tnH )
LOCAL ARRAY laFlds[1]
LOCAL lcFile, lnFCount, lnCnt, llHasMemo, lcMem
lcFile = ALLTRIM( tcFile )
*** Check for Memo Fields
lnFCount = AFIELDS( laFlds )
FOR lnCnt = 1 TO lnFCount
	IF laFlds[lnCnt,2] = "M"
		llHasMemo = .T.
		EXIT
	ENDIF
NEXT
*** Compose Output
lcDBC = "Cursor cannot be associated with a DBC"
lcMem = IIF( llHasMemo, lcFile + '.FPT', 'No Memo Fields')
lcCDX = CDX(1)
lcCDX = IIF( EMPTY( lcCDX), 'No Structural Index', lcCDX )
*** Write out
lcStr = 'Structure For: ' + lcFile
FPUTS(tnH, lcStr )
FPUTS(tnH, REPLICATE('=', LEN(lcStr)))
FPUTS(tnH, 'DBC  : ' + lcDBC )
FPUTS(tnH, 'CDX  : ' + lcCDX )
FPUTS(tnH, 'Memo : ' + lcMem )
FPUTS(tnH, '')
RETURN

*****************************************
* Get DBC-Related Info for Tables/DBCs
*****************************************
PROCEDURE TableLst( tcFile, tnH )
LOCAL lcFile, lnDBCH, lnNextByte, lcCDX, lcMem, lcDBC, lnFields, lcAlias
lnFields = FCOUNT()
lcFile = ALLTRIM( tcFile )
lcAlias = JUSTSTEM(tcFile)
*** Close the table
USE
*** Re-Open DBF at low level
lnDBCH = FOPEN( lcFile )
*** Associated files
FSEEK(lnDBCH,28)
lnNextByte = ASC( FREAD(lnDBCH, 1))
IF lnNextByte = 7
	*** The specified file is actually a DBC, not a Table
	lcCDX = lcAlias + '.DCX'
	lcMem = lcAlias + '.DCT'
	lcDBC = lcAlias + '.DBC is a Database Container'
ELSE
	*** It's a table after all!
	lcCDX = IIF( lnNextByte%2 = 0, 'No Structural CDX', lcAlias + '.CDX')
	lcMem = IIF( lnNextByte%4 < 2, 'No Memo File',  lcAlias + '.FPT')
	*** So now Read DBC Backlink
	FSEEK(lnDBCH,(33+(lnFields*32)))
	lcDBC = UPPER(ALLTRIM(STRTRAN(FGETS( lnDBCH, 263), CHR(0))))
	lcDBC = IIF(! EMPTY( lcDBC ), lcDBC, "Not Part of a DBC" )
ENDIF
*** Close File and re-open as a table
FCLOSE( lnDBCH )
*** Write the header info for Tables/DBC
lcStr = 'Structure For: ' + lcFile
FPUTS(tnH, lcStr )
FPUTS(tnH, REPLICATE('=', LEN(lcStr)))
FPUTS(tnH, 'DBC  : ' + lcDBC )
FPUTS(tnH, 'CDX  : ' + lcCDX )
FPUTS(tnH, 'Memo : ' + lcMem )
FPUTS(tnH, '')
USE (lcFile)
RETURN

*****************************************
* List Index Details
*****************************************
PROCEDURE IndexLst( tnFileHandle )
LOCAL lnHnd, lnCnt, lcStr
lnHnd = tnFileHandle
*** Get Index Details
FPUTS( lnHnd, '' )
IF TAGCOUNT() > 0
	FPUTS(lnHnd, 'Associated Indexes' )
	FPUTS(lnHnd, '==================' )
	*** We have indexes
	*** NB Maybe we should save these to an array and sort it too!
	*** Primary first, then Candidate, then others?
	FOR lnCnt = 1 TO TAGCOUNT()
		lcStr = ""
		*** Check for PK
		IF PRIMARY( lnCnt )
			lcStr = "*** PRIMARY KEY: "
		ELSE
			*** Check for Candidate
			IF Candidate( lnCnt )
				lcStr = "(Candidate): "
			ENDIF
		ENDIF
		lcStr = CHR(9) + lcStr + TAG(lnCnt) + ": " + KEY(lnCnt)
		FPUTS(lnHnd, lcStr )
	NEXT
ELSE
	*** No Associated indexes
	FPUTS( lnHnd, 'No Associated Indexes' )
	FPUTS( lnHnd, '=====================' )
ENDIF
RETURN

*****************************************
* List Field Details
*****************************************
PROCEDURE FieldLst( tnFileHandle )
LOCAL ARRAY laFlds[1]
LOCAL lnHnd, lcStr, lnFields, lnCnt, lnMax

lnHnd = tnFileHandle

*** No DBC so just use AFIELDS()
*** Get the structure into an array
lnFields = AFIELDS( laFlds )
*** Table Details
FPUTS(lnHnd, CHR(13) + "Table Information" )
FPUTS(lnHnd, "=================" )
IF !EMPTY(laFlds[1,12])
	*** DBC Table Name
	lcStr = "Long Name: " + laFlds[1,12]
	FPUTS(lnHnd, lcStr )
ENDIF
IF !EMPTY(laFlds[1,16])
	*** Table Comment
	lcStr = "Comment: " + laFlds[1,16]
	FPUTS(lnHnd, lcStr )
ELSE
	lcStr = "No Comment Supplied"
	FPUTS(lnHnd, lcStr )
ENDIF
IF ! EMPTY(laFlds[1,10])
	lcStr = CHR(9) + 'Table Rule: ' + laFlds[lnCnt,10] ;
		+ ' (Error Message: ' ;
		+ IIF( EMPTY(laFlds[lnCnt,11]), 'VFP Default', laFlds[lnCnt,11] ) ;
		+ ')'
	FPUTS(lnHnd, lcStr )
ELSE
	lcStr = "No Table Rule"
	FPUTS(lnHnd, lcStr )
ENDIF
IF !EMPTY(laFlds[1,13])
	*** Insert Trigger
	lcStr = CHR(9) + "On Insert: " + laFlds[1,13]
	FPUTS(lnHnd, lcStr )
ELSE
	lcStr = "No Insert Trigger"
	FPUTS(lnHnd, lcStr )
ENDIF
IF !EMPTY(laFlds[1,14])
	*** Update Trigger
	lcStr = CHR(9) + "On Update: " + laFlds[1,14]
	FPUTS(lnHnd, lcStr )
ELSE
	lcStr = "No Update Trigger"
	FPUTS(lnHnd, lcStr )
ENDIF
IF !EMPTY(laFlds[1,15])
	*** Delete Trigger
	lcStr = CHR(9) + "On Delete: " + laFlds[1,15]
	FPUTS(lnHnd, lcStr )
ELSE
	lcStr = "No Delete Trigger"
	FPUTS(lnHnd, lcStr )
ENDIF

FPUTS(lnHnd, '' )
FPUTS(lnHnd, 'Field Details' )
FPUTS(lnHnd, '=============' )
lnMax = 0
*** Find longest Field Name
FOR lnCnt = 1 TO lnFields
	lnMax = MAX( lnMax, LEN(ALLTRIM(laFlds[lnCnt,1])))
NEXT

*** Output field Data
FOR lnCnt = 1 TO lnFields
	*** Field Definition
	***	Col 1 Field name
	***	Col 2 Field type
	***	Col 3 Field width
	***	Col 4 Decimal places
	***	Col 5 Null values allowed
	lcStr = CHR(9) + PADR(laFlds[lnCnt,1],lnMax) + CHR(9) ;
			+ laFlds[lnCnt,2] + " (" ;
			+ PADL( laFlds[lnCnt,3], 3 ) + ',' ;
			+ ALLTRIM( STR( laFlds[lnCnt,4] )) + ' )' + CHR(9) ;
			+ IIF( laFlds[lnCnt,5], 'NULL', 'NOT NULL' )
	FPUTS(lnHnd, lcStr )
	
	***	Col 9 Field default value
	***	Col 10 Field validation error text
	IF ! EMPTY( laFlds[lnCnt,9] )
		lcStr = CHR(9) + CHR(9) + 'Default: ' + laFlds[lnCnt,9] ;
				+ CHR(13) + CHR(9) + CHR(9) + '(Error Message: ' ;
				+ IIF( EMPTY(laFlds[lnCnt,10]), 'VFP Default', laFlds[lnCnt,10] ) ;
				+ ')'
    	FPUTS(lnHnd, lcStr )
	ENDIF
	
	***	Col 7 Field validation expression
	***	Col 8 Field validation text
	IF ! EMPTY( laFlds[lnCnt,7] )
		lcStr = CHR(9) + CHR(9) + 'Valid: ' + laFlds[lnCnt,7] ;
				+ CHR(13) + CHR(9) + CHR(9) + '(Error Message: ' ;
				+ IIF( EMPTY(laFlds[lnCnt,8]), 'VFP Default', laFlds[lnCnt,8] ) ;
				+ ')'
    	FPUTS(lnHnd, lcStr )
	ENDIF
NEXT

RETURN
