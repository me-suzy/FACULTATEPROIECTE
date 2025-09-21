******************************************************************************
* Program....: EnvSet.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Class definition for setting environmental options. Instantiating
* ...........: the class sets the required options. The GetOption() method shows
* ...........: how the object can be used to retrieve settings as well.
******************************************************************************

DEFINE CLASS cusEnvSet AS custom
	*****************************************************************************
  *** Init merely calls the SetOptions() method
  *****************************************************************************
	PROCEDURE Init
		This.SetOptions()
	ENDPROC
	*****************************************************************************
  *** Sets Required Environmental options
  *****************************************************************************
	PROCEDURE SetOptions
		*** Locking and Environment
		SET TALK OFF
		SET MULTILOCKS ON
		SET REPROCESS TO AUTOMATIC
		SET DELETED ON
		SET SAFETY OFF
		SET BELL OFF
		SET ECHO OFF
		SET NOTIFY OFF
		SET CONFIRM OFF
		SET EXACT OFF
		SET REFRESH TO 60,60
		SET STATUS BAR ON
		*** Path
		IF TYPE("gcAppPath") = "U" OR EMPTY(gcAppPath)
			RELEASE gcAppPath
			PUBLIC gcAppPath
			gcAppPath = SET("PATH")
		ENDIF
		SET PATH TO (gcAppPath)
		*** Date and Currency
		SET CENTURY	ON
		SET CENTURY TO 19 ROLLOVER 75
		SET DATE TO BRITISH
		SET CURRENCY LEFT
		SET CURRENCY TO "£"
	ENDPROC
	*****************************************************************************
  *** Returns current setting of an environment option
  *****************************************************************************
	PROCEDURE GetOption( tcOption )
		LOCAL luRetVal, lcOption
		STORE "" TO luRetVal
		lcOption = UPPER(ALLTRIM( tcOption ))
		*** If we were given a setting, get its current status
		*** NOTE: If really needed this method would require more
		*** options because not every setting can simply be returned
		*** by the SET() function - but this illustrates the point!
		IF VARTYPE( lcOption ) = "C" AND ! EMPTY( lcOption )
			luRetVal = SET( lcOption )
		ENDIF
		RETURN luRetVal		
	ENDPROC
ENDDEFINE
