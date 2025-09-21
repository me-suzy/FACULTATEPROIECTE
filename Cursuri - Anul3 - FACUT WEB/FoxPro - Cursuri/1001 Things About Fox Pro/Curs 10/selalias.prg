**********************************************************************
* Program....: SelAlias.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Class to Select a specific Work area and restore it
* ...........: Use as a local object to change work area.  
* ...........: When released will restore the previous work area
* ...........: Accepts two parameters, the first is the Alias and is mandatory
* ...........: The second is the name of the table.  If not passed, assumed to be the
* ...........: same as the Alias you are using.
* ...........: loSel = CREATEOBJECT( 'xRelSelect', <Alias> [|<File Name>])
**********************************************************************

DEFINE CLASS xSelAlias AS RELATION
	PROTECTED nOldArea
	nOldArea = 0
	PROTECTED lWasOpen	
	lWasOpen = .T.
	PROTECTED cAlias
	cAlias = ''
	PROCEDURE INIT( tcAlias, tcTable )
		LOCAL llRetVal
		*** No Alias Passed - Bail Out
		IF ! VARTYPE( tcAlias ) = "C"
		    ASSERT .F. MESSAGE "Must Pass an Alias Name to Work Area Selector"
			RETURN .F.
		ENDIF
		tcAlias = UPPER( ALLTRIM( tcAlias ))
		IF VARTYPE( tcTable ) # "C" OR EMPTY( tcTable )
			tcTable = tcAlias
		ELSE
			tcTable = UPPER( ALLTRIM( tcTable ))
		ENDIF
		*** If already in correct work area - do nothing
		IF UPPER(ALLTRIM( ALIAS() )) == tcAlias
			RETURN .F.
		ENDIF
		*** If Specified Alis not open - Open it
		IF ! USED( tcAlias )
			USE (tcTable) AGAIN IN 0 ALIAS (tcAlias) SHARED
			*** And Check!
			llRetVal = USED( tcAlias )
			*** If Forced Open, Note the fact
			IF llRetVal
				This.lWasOpen = .F.
			ENDIF
		ELSE
			llRetVal = .T.
		ENDIF
		*** IF OK, save current work area and
		*** Now Move to the specified Work Area
		IF llRetVal
			This.nOldArea = SELECT()
			SELECT (tcAlias)
			This.cAlias = tcAlias
		ENDIF
		*** Return Status		
		RETURN llRetVal
	ENDPROC
	
	PROCEDURE DESTROY
		WITH This
			*** If table opened by this object, close it
			IF ! .lWasOpen
				USE IN (This.cAlias)
			ENDIF
	        *** Restore Previous work area
			IF ! EMPTY( .nOldArea )
				SELECT ( .nOldArea )
			ENDIF
		ENDWITH
	ENDPROC
	
	PROCEDURE ERROR( nError, cMethod, nLine )
		*** Trap for Invalid File Name
		IF nError = 1	&& File does not exist
			LOCAL lcTxt
			lcTxt = This.Class + '.' + cMethod +': Specified Alias Not Recognised'
			MESSAGEBOX( lcTxt, 16, 'System Error' )
			llRetVal = .F.
		ENDIF
	ENDPROC
ENDDEFINE
