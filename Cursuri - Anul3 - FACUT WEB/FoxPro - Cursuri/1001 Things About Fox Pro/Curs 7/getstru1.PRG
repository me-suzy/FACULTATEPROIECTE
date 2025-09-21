**********************************************************************
* Program....: GetStru1.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Use AFIELDS() to get the proper structure of a table
* ...........: Assumes that a table is open in the current work area
**********************************************************************
LOCAL ARRAY laFlds[1]
LOCAL lcAlias, lnFlds, lnHnd, lnCnt, lcStr, lnMax
lcAlias = ALIAS()
*** Make sure we have something
IF EMPTY(lcAlias)
    *** Generate a 'No Table is Open' Error
    ERROR 52
    RETURN
ENDIF
*** Get the structure of the table into an array
lnFlds = AFIELDS( laFlds )
***********************************************************
*** NOTE: We could also use STRTOFILE() here (new in VFP6)
*** but the following code will work in all versions of VFP
***********************************************************
*** Open an output file for low-level write
lnHnd = FCREATE( lcAlias + ".TXT")
*** Did we open it?
IF lnHnd < 1
    *** Generate "unable to create file" error
    ERROR 102, lcAlias + ".TXT"
    RETURN
ENDIF

*** Write out a header
lcStr = "Structure For: " + DBF()
FPUTS( lnHnd, lcStr )
lnMax = LEN(lcStr)
lcStr = REPLICATE('=', lnMax)
FPUTS( lnHnd, lcStr )
***	Col 12 Long table name
IF ! EMPTY( laFlds[1,12] )
    FPUTS( lnHnd, "Long Name: " + laFlds[1,12] )
ENDIF
***	Col 16 Table comment
IF ! EMPTY( laFlds[1,16] )
    FPUTS( lnHnd, "Comment:   " + laFlds[1,16] )
ENDIF

*** Find longest Field Name
lnMax = 0
FOR lnCnt = 1 TO lnFlds
	lnMax = MAX( lnMax, LEN(ALLTRIM(laFlds[lnCnt,1])))
NEXT

*** Output field Data
FPUTS( lnHnd, "" )
FPUTS( lnHnd, "Field Definitions" )
FPUTS( lnHnd, "=================" )
FOR lnCnt = 1 TO lnFlds
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

*** Close Output File
FCLOSE( lnHnd )

*** Open it in a window
MODIFY FILE (lcAlias + ".TXT") NOWAIT
