**********************************************************************
* Program....: TrackErr.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Program called by ON ERROR to log Error Details
* ...........: ON ERROR DO TrackErr WITH SET("DATASESSION"), PROGRAM(), LINENO()
**********************************************************************
LPARAMETERS tnDSID, tcProgram, tnLineNo
LOCAL lcNextAction, lcUserMsg

*** Call Logging Method
IF VARTYPE( goErrorLog ) = "O"
    goErrorLog.LogError( tnDSID, tcProgram, tnLineNo )

    *** Now check the results
    lcNextAction = goErrorLog.cNextAction       && Next Action Required
    lcUserMsg    = goErrorLog.cUserMsg         && User Mesage Text

    *** Take Whatever Action is appropriate
    *** Typically this would be to display a Message for the user
    *** And either Re-Try or Close Down
    MESSAGEBOX( lcUserMsg, 16, "Application Error" )
ELSE
    MESSAGEBOX( "Error Logging is not Available", 16, "System Error" )
ENDIF
