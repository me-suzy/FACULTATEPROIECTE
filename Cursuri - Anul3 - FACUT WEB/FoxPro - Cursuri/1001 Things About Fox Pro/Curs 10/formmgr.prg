**********************************************************************
* Program....: FormMgr.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Maintains a collection of Form Names, locally generated Instance
* ...........: Names (passed to Form) and Object References. Also manages any
* ...........: Toolbar associated with forms.
**********************************************************************

DEFINE CLASS xFrmMgr AS RELATION
    PROTECTED ARRAY aFmList[1,4], aTbList[1,3]
***    PROTECTED nFmIndex, nFmCount, nTbCount, nTbIndex
    nFmIndex = 0
    nFmCount = 0
    nTbCount = 0
    nTbIndex = 0

    FUNCTION Init
	    WITH This
    	    *** Initialise Properties
	        .aFmList = ""    && Form Collection
	        .nFmCount = 0    && Managed Form Count
	        .nFmIndex = 0    && Index into the Collection for current form
	        .aTbList = ""	 && Toolbar Collection
	        .nTbCount = 0    && Toolbar Count
	        .nTBIndex = 0    && Index into the Collection for current toolbar
	    ENDWITH
    ENDFUNC

	****************************************************************
	*** xFrmMgr::DoForm( tcFmName, tlIsClass, tuParm1, tuParm2, tuParm3 )
	*** Exposed Method to Run a Form
	*** Provision for 3 params, but normally would expect only 1 as
	*** A parameter object
	****************************************************************
    FUNCTION DoForm ( tcFmName, tlIsClass, tuParm1, tuParm2, tuParm3 )
    LOCAL lnFormParams, lcFmName, loFmRef, lnFmIdx, llRetVal, lnCnt
	    WITH This
	        *** Check Parameters
	        IF VARTYPE( tcFmName ) # "C"
	            *** Form name is not supplied!
	            ASSERT .F. MESSAGE ;
	                  "Name of a Form, or a Form Class," + CHR(13) ;
	                  + "Must be passed to Form Manager DoForm()"
	            RETURN .F.
	        ENDIF
	        *** Set Return Flag
	        llRetVal = .T.
	        *** Form Name and Type must be present, how many form params?
	        lnFormParams = PCOUNT() - 2
	        *** Generate an Instance Name and Object Reference
	        STORE SYS(2015) TO lcFmName, loFmRef
	        *** Check to see if we have this Form already?
	        .nFmIndex = .FmIdx(tcFmName)
	        *** If we have it, is it single instance
	        IF .nFmIndex > 0
	            *** Get a reference to the form and see if we can
	            *** have multiple instances of it.
	            loFmRef = .aFmList[.nFmIndex, 1]
	            WITH loFmRef
	                *** Check to see if the form is single-instance
	                IF .lOneInstance
	                    *** Restore form if minimised
	                    IF .WindowState > 0
	                        .WindowState  = 0
	                    ENDIF
	                    *** Force to top
	                    .AlwaysOnTop = .T.
	                    *** Activate the form
	                    .Activate()
	                    *** Cancel Force To Top
	                    .AlwaysOnTop = .F.
	                    *** Sort out Toolbars, pass the name of the required toolbar (if any)
	                    .SetToolBar( .aFmList[.nFmIndex, 4])
	                    *** And Exit right now
	                    RETURN llRetVal
	                ENDIF
	            ENDWITH
	        ENDIF
	        *** Either first run of the form, or a new instance is required
	        *** Create the parameter object
	        oParams = NEWOBJECT( "xParam", "genclass.vcx" )
	        WITH oParams
	            *** First the Instance Name
	            .AddProperty( 'cInsName', lcFmName )
	            *** Add a property count and any additional properties
	            .AddProperty( 'nParamCount', lnFormParams )
	            IF lnFormParams > 0
	                FOR lnCnt = 1 TO lnFormParams
	                    lcPName = "tuParm" + ALLTRIM(STR(lnCnt))
	                    .AddProperty( lcPName, &lcPName )
	                NEXT
	            ENDIF
	        ENDWITH
	        *** Instantiate the form
	        IF tlIsClass
	            *** Create as a class
	            loFmRef = CREATEOBJECT( tcFmName, oParams )
	        ELSE
	            *** Run as a Form using NAME and LINKED clauses
	            DO FORM (tcFmName) NAME loFmRef WITH oParams LINKED
	        ENDIF
	        *** Update the Collection with the new form details
	        IF VARTYPE( loFmRef ) = "O"
	            *** YEP - got a form, so increment form count and populate the collection
	            .nFmCount = .nFmCount + 1
	            DIMENSION .aFmList[.nFmCount, 4]
	            .aFmList[.nFmCount, 1] = loFmRef				&& Object Reference
	            .aFmList[.nFmCount, 2] = lcFmName				&& Instance Name
	            .aFmList[.nFmCount, 3] = tcFmName				&& Form Name
	            .aFmList[.nFmCount, 4] = UPPER( ALLTRIM ( loFmRef.cTbrName ))	&& Toolbar to use
	            *** Make this the Active Form
	            .nFmIndex = .nFmCount
	            *** Show the new form
	            loFmRef.Show()
	        ELSE
	            *** Form Initialisation failed for some reason
	            llRetVal = .F.
	        ENDIF
	        *** Finally sort out the toolbar requirement
	        IF llRetVal
	            .DoToolBar( .aFmList[.nFmCount, 4] )
	        ENDIF
	        RETURN llRetVal
	    ENDWITH
    ENDFUNC

	****************************************************************
	*** xFrmMgr::FormAction( tcAction, tcInsName )
	*** Exposed method for handling form requests
	****************************************************************
    FUNCTION FormAction( tcAction, tcInsName )
	    WITH This
	        LOCAL lnFmIndex
	        *** Do we have this form?
	        lnFmIndex  = 0
	        lnFmIndex  = .FmIdx(tcInsName)
	        *** If we have it
	        IF lnFmIndex > 0
	            DO CASE
	            CASE UPPER( tcAction ) = "ACTIVATE"
	                *** Make this the Active form
	                .nFmIndex = lnFmIndex
                    .SetToolBar( .aFmList[.nFmIndex, 4])
	            CASE UPPER( tcAction ) = "RELEASE"
	                *** Clear the form from the collection
	                .nFmIndex = lnFmIndex
	                .ClearForm( .aFmList[.nFmIndex, 1] )
	            OTHERWISE
	                ASSERT .F. ;
	                MESSAGE "Action: " + tcAction + " passed to Form Mgr " ;
	                + CHR(13) + "But is not recognised"
	                RETURN .F.
	            ENDCASE
	        ELSE
	            *** Form was not started by Form Manager
	            *** Nothing to do about it
	        ENDIF
	        RETURN
	    ENDWITH
    ENDFUNC

    ****************************************************************
    *** xFrmMgr::ReleaseAll
    *** Exposed method for releasing ALL forms held by the Form Manager
    *** Used when closing an application with forms still open
    ****************************************************************
    FUNCTION ReleaseAll
	    WITH THIS
	        LOCAL loFmRef, loTbRef
	        .nFmIndex = .nFmCount
	        *** Release All forms
	        DO WHILE .nFmIndex > 0
	            *** Check we still have a form object
	            loFmRef = .aFmList[.nFmIndex, 1]
	            IF VARTYPE( loFmRef ) = "O"
	                *** Release It
	                loFmRef.Release()
	            ENDIF
	            .nFmIndex = .nFmIndex - 1
	        ENDDO
	        *** Re-Initialise Forms Collection
	        DIMENSION .aFmList[1,4]
	        .nFmCount = 0
	        .nFmIndex = 0
	        .aFmList = ""
            *** Release all Toolbars
            .nTbIndex = .nTbCount
            DO WHILE .nTbIndex > 0
	            *** Check we still have a form object
	            loTbRef = .aTbList[.nTbIndex, 1]
	            IF VARTYPE( loTbRef ) = "O"
	                *** Release It
	                loTbRef.Release()
	            ENDIF
	            .nTbIndex = .nTbIndex - 1
	        ENDDO
	        *** Re-Initialise Toolbar Collection
	        DIMENSION .aTbList[1,3]
	        .nTbCount = 0
	        .nTbIndex = 0
	        .aTbList = ""
	        RETURN .T.
	    ENDWITH
    ENDFUNC

	****************************************************************
	*** xFrmMgr::ClearForm( toFmRef )
	*** Protected method to Remove a Form from the collection
	****************************************************************
    PROTECTED FUNCTION ClearForm(toFmRef)
        WITH This
            *** Cancel if not an Object
            IF Type('toFmRef') # "O" OR ISNULL(toFmRef)
                RETURN .F.
            ENDIF
            *** Check For an associated Toolbar
            lcTbName = .aFmList[.nFmIndex, 4]
            IF ! EMPTY( lcTbName )
                .ClearToolBar( lcTbName )
            ENDIF
            *** Clear the Form Collection Entry
            .nFmCount = .nFmCount - 1
            IF .nFmCount < 1
                *** Re-Initialise the Array if this was the last form
                DIMENSION .aFmList[1,4]
                .nFmCount = 0
                .nFmIndex = 0
                .aFmList  = ""
            ELSE
                *** Just Re-Dimension it
                =ADEL(.aFmList, .nFmIndex )
                DIMENSION .aFmList[.nFmCount ,4]
            ENDIF
            *** Re-Set the index = form count
            *** (The next form activation will re-set it anyway)
            .nFmIndex = .nFmCount
        ENDWITH
    ENDFUNC

	****************************************************************
	*** xFrmMgr::FmIdx( tuFmRef )
	*** Scan the Forms Collection for the Reference which may
	*** be either an object reference to a form or an instance name
	*** Returns the ROW number if found
	****************************************************************
    PROTECTED FUNCTION FmIdx(tuFmRef)
        WITH This
            LOCAL lnElem, lnIdx
            lnIdx = 0
            IF ! ISNULL(tuFmRef) AND .nFmCount > 0
                SET EXACT ON
                *** Scan the array
                IF TYPE("tuFmRef") = "O"
                    lnElem = ASCAN(.aFmList, tuFmRef.cInsName)
                ELSE
                    lnElem = ASCAN(.aFmList, tuFmRef)
                ENDIF
                *** Calculate the Row Number
                IF lnElem > 0
                    lnIdx = ASUBSCRIPT(.aFmList, lnElem, 1)
                ENDIF
                SET EXACT OFF
            ENDIF
            RETURN lnIdx
        ENDWITH
    ENDFUNC

	****************************************************************
	*** xFrmMgr::HideForms
	*** Exposed method to hide all forms held by the Form Manager
	*** Used When running Print Preview with multiple forms open
	****************************************************************
    FUNCTION HideForms
	    WITH This
	        LOCAL nIndex, loFmRef
	        nIndex = .nFmCount
	        *** Hide All forms
	        DO WHILE nIndex > 0
	            *** Check we still have a form object
	            loFmRef = .aFmList[nIndex, 1]
	            IF VARTYPE( loFmRef ) = "O"
	                *** Hide It
	                loFmRef.Visible = .F.
	            ENDIF
	            nIndex = nIndex - 1
	        ENDDO
	        *** Hide all toolbars
	        .SetToolBar( "" )
	    ENDWITH
    ENDFUNC

	****************************************************************
	*** xFrmMgr::ShowForms
	*** Exposed method to show all forms held by the Form Manager
	*** Used when closing Print Preview with multiple forms open
	****************************************************************
    FUNCTION ShowForms
	    WITH This
	        LOCAL nIndex, loFmRef
	        nIndex = 0
	        *** Show All forms
	        DO WHILE nIndex < .nFmCount
	            nIndex = nIndex + 1
	            *** Check we still have a form object
	            loFmRef = .aFmList[nIndex, 1]
	            IF VARTYPE( loFmRef ) = "O"
	                *** Show it
	                loFmRef.Visible = .T.
	            ENDIF
	        ENDDO
			*** Restore the last active Form
			.aFmList[ .nFmIndex, 1].Show()
	    ENDWITH
    ENDFUNC

    ****************************************************************
    *** xFrmMgr::DoToolBar( tcTbName )
    *** Protected method to create or set the named toolbar active
    *** Called when creating a form
    ****************************************************************
    PROTECTED FUNCTION DoToolBar( tcTbName )
        WITH This
            LOCAL lnTbIdx
            *** Do we need a toolbar at all?
            IF EMPTY( tcTbName )
                *** No ToolBar Required, hide all
                .SetToolBar( "" )
                RETURN
            ENDIF
            *** Check to see if we have the toolbar already
            lnTbIdx = .TbIdx( tcTbName )
            IF lnTbIdx > 0
                *** We already have this one, so activate it
                *** And increment its counter by one
                .aTbList[ lnTbIdx, 2] = .aTbList[ lnTbIdx, 2] + 1
            ELSE
                *** We need to create it and add it to the collection
                .nTbCount = .nTbCount + 1
                DIMENSION .aTbList[ .nTBCount, 3]
                .aTbList[ .nTbCount, 1] = CREATEOBJECT( tcTbName )    && Object Ref
                .aTbList[ .nTbCount, 2] = 1                           && Toolbar Counter
                .aTbList[ .nTbCount, 3] = UPPER( ALLTRIM( tcTbName )) && Toolbar Name
            ENDIF
            *** Make the toolbar the active one
            .nTbIndex = .nTbCount
            .SetToolBar( .aTbList[ .nTbCount, 3] )
        ENDWITH
    ENDFUNC
    
    ****************************************************************
    *** xFrmMgr::SetToolBar( tcTbrName )
    *** Protected method to make the named toolbar active
    *** Passing an empty string hides all toolbars
    *** Called when activating a form
    ****************************************************************
    PROTECTED FUNCTION SetToolBar( tcTbName )
        WITH This
            LOCAL lnCnt
            *** Loop through the toolbar collection and hide all but the required one
            FOR lnCnt = 1 TO .nTBCount
                DO CASE
                    CASE EMPTY( .aTbList[ lnCnt, 3 ] )
                        *** No toolbars defined - Do Nothing
                        *** Needed to avoid comparing to an empty string!
                    CASE EMPTY( tcTbName ) 
                        *** No Toolbar required, so hide it
                        .aTbList[lnCnt, 1].Hide()
                    CASE tcTbName == .aTbList[ lnCnt, 3 ]
                        *** We want this one, so show it
                        .aTbList[lnCnt, 1].Show()
                    OTHERWISE
                        *** Don't want this one, so hide it
                        .aTbList[lnCnt, 1].Hide()
                ENDCASE
            NEXT
        ENDWITH
    ENDFUNC

    ****************************************************************
    *** xFrmMgr::ClearToolBar( tcTbrName )
    *** Protected method to make the named toolbar active
    *** Passing an empty string hides all toolbars
    *** Called when activating a form
    ****************************************************************
    PROTECTED FUNCTION ClearToolBar( tcTbName )
        WITH This
            LOCAL lnIdx
            *** Find the row in the Toolbar Collection
            lnIdx = 0
            lnIdx = .TbIdx( tcTbName )
            IF lnIdx = 0
                *** This toolbar is not registered anyway
                RETURN
            ENDIF
            *** Decrement the counter
            .aTbList[ lnIdx, 2] = .aTbList[ lnIdx, 2] - 1
            IF .aTbList[ lnIdx, 2] = 0
                *** No Other Reference, so release the Toolbar
                .aTbList[ lnIdx, 1].Release()
                .nTbCount = .nTbCount - 1
                IF .nTbCount < 1
                    *** Re-Initialise the Array if this was the last one
                    DIMENSION .aTbList[1,3]
                    .nTbCount = 0
                    .nTbIndex = 0
                    .aTbList  = ""
                ELSE
                    *** Just Re-Dimension it
                    =ADEL(.aTbList, lnIdx )
                    DIMENSION .aTbList[.nTbCount , 3]
                ENDIF
            ENDIF
        ENDWITH
    ENDFUNC

	****************************************************************
	*** xFrmMgr::TbIdx( tcTbName )
	*** Scan the Toolbar Collection for the Reference which will
	*** be the name of the required Toolbar
	*** Returns the ROW number if found
	****************************************************************
    PROTECTED FUNCTION TbIdx(tcTbName)
        WITH This
            LOCAL lnElem, lnIdx
            lnIdx = 0
            *** Check we have a name, and at least one toolbar registered
            IF ! EMPTY(tcTbName) AND .nTbCount > 0
                SET EXACT ON
                *** Scan the array
                lnElem = ASCAN(.aTbList, tcTbName)
                *** Calculate the Row Number
                IF lnElem > 0
                    lnIdx = ASUBSCRIPT(.aTbList, lnElem, 1)
                ENDIF
                SET EXACT OFF
            ENDIF
            *** Return the relevant Row Number
            RETURN lnIdx
        ENDWITH
    ENDFUNC

ENDDEFINE
