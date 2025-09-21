**********************************************************************
* Program....: DPathMgr.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Uses lookup table to get correct paths for tables
* ...........: at run time, set the paths in DE Cursor Object
* ...........: Call from BeforeOpenTables Method of a Form DE
* ...........: Expects a reference to the DE to be passed:
* ...........: loPathSet = NEWOBJECT( 'dPathMgr', 'dpathmgr.prg', NULL, THIS ) 
**********************************************************************

DEFINE CLASS DPathMgr AS relation
    *** Define Protected Properties ***
    *** Array for list of Cursors
	PROTECTED aCursors[1]
    aCursors[1] = NULL
    *** Object Reference to the DE
	PROTECTED oDe
    oDe = NULL
    
    PROCEDURE Init( toDe )
        LOCAL lnCursors
        *** Check the parameter
        IF VARTYPE( toDe ) = "O"
            *** Have a valid Object reference
            This.oDe = toDe
            IF LOWER( This.oDE.BaseClass ) # "dataenvironment"
                *** But it's not a DE!
				ASSERT .F. MESSAGE "DPathMgr Class Requires a reference to the " ;
                        + CHR(13) + "DataEnvironment Object which calls it."
                RETURN .F.
            ENDIF
        ELSE
            *** Whoops - Not even an Object
            RETURN .F.       
        ENDIF

        *** How many cursors are there?
        lnCursors = This.GetTables()
        IF lnCursors < 1
            *** Nothing to do - so just return OK
            RETURN
        ENDIF
        
        *** Check for DataPath Table and open it if necessary
        IF ! This.OpenRefTable()
            *** Cannot find the reference table
            RETURN .F.
        ENDIF
    
        *** Set the paths for the Cursors
        This.SetPaths( lnCursors )
        RETURN 
    ENDPROC
    
    PROTECTED PROCEDURE openreftable
	    *** Open up the Reference table
		IF ! USED('DataPath')
		  USE datapath AGAIN IN 0 SHARED NOUPDATE
		ENDIF
		RETURN USED( 'DataPath' )
    ENDPROC
    
    PROTECTED PROCEDURE GetTables
    	LOCAL ARRAY laObj[1]
        LOCAL lnObjCnt, lnCnt, loObj, lnRows, lcObjName
        *** Get a list of all objects in the DE
        lnObjCnt = AMEMBERS( laObj, This.oDe, 2)
        *** Scan the list
        lnRows = 0
        FOR lnCnt = 1 TO lnObjCnt
            *** Check if this object is actually a Cursor
            loObj = EVAL( "This.oDe." + laObj[lnCnt] )
            IF loObj.BaseClass = "Cursor"
                *** It is, so save its reference to the internal array
                *** Add a new row to the cursors array
                lnRows = lnRows + 1
                DIMENSION This.aCursors[ lnRows, 1]
                This.aCursors[lnRows] = loObj
            ENDIF
        NEXT
        *** Return Number of Cursors
        RETURN lnRows
    ENDPROC
    
    PROTECTED PROCEDURE SetPaths( tnCursors )
        LOCAL lnCnt, loObj, lcTable
        *** Scan the list
        FOR lnCnt = 1 TO tnCursors
 			*** Retrieve the Object Reference from the array
            loObj = This.aCursors[lnCnt]
            *** Find the Table Name
            lcTable = UPPER( JUSTSTEM( loObj.CursorSource ))
            *** Look up the name in the reference table which lists 
            *** where the data should be taken from
            IF SEEK( lcTable, "datapath", "ctable")
                *** We have a reference for this table!
                IF ! EMPTY( set_dbc )
                    *** We have a bound table
                    loObj.Database  = ALLTRIM( ADDBS( datapath.set_path )) ;
                                    + ALLTRIM( DataPath.set_dbc )
                    loObj.CursorSource = ALLTRIM(DataPath.set_table)
                ELSE
                    *** Must be a free table
                    loObj.Database =  ""
                    loObj.CursorSource  = ALLTRIM( ADDBS( datapath.set_path )) ;
                                        + ALLTRIM( DataPath.set_table )
                ENDIF
            ENDIF
        NEXT
    ENDPROC

ENDDEFINE
