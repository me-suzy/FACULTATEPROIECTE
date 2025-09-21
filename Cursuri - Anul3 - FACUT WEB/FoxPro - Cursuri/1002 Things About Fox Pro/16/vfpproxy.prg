DEFINE CLASS VFPProxy AS SESSION OLEPUBLIC 
cCurDir = ""

FUNCTION INIT
	*** Set the default directory
	LOCAL lcProgram, lnStartPos, lnEndPos, lcDefault, lcPath
	*** Get the current path
	lcProgram = SYS( 16 )
	lnStartPos = AT( '\', lcProgram )
	lnEndPos = RAT( '\', lcProgram )

	*** Check to see if we have a drive mapped or if we have a UNC path
	IF SUBSTR( lcProgram, lnStartPos - 1, 1 ) = ":"
		lnStartPos = lnStartPos - 2
	ENDIF
	lnLen = lnEndPos - lnStartPos + 1
	lcDefault = SUBSTR( lcProgram, lnStartPos,lnLen )
  SET DEFAULT TO ( lcDefault )
  IF EMPTY( This.cCurDir )
  		This.cCurDir = lcDefault
  	ENDIF
		SET RESOURCE OFF
		SET EXCLUSIVE OFF
		SET CENTURY ON
		SET CPDIALOG OFF
		SET DELETED ON
		SET EXACT OFF
		SET SAFETY OFF
		SET REPROCESS TO 2 SECONDS		
	RETURN DODEFAULT()

ENDFUNC

FUNCTION Execute( tcCommand, tcFile )
	LOCAL luRetVal, lcFile
	lcFile = This.cCurDir + tcFile
	IF '.PRG' $ UPPER( lcFile )
		SET PROCEDURE TO &lcFile		

		luRetVal = &tcCommand
			
		SET PROCEDURE TO 
		CLEAR PROGRAM &lcFile
			
		RETURN luRetVal
	ELSE
		RETURN .F.
	ENDIF
	
ENDDEFINE