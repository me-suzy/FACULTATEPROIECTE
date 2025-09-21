******************************************************************************************
*** Program: Factory.prg
*** Written by Marcia G. Akins 
*** Abstract: Abtract facotry responsible for onjecr instantiation
*** Parameters: keyword from classes table to look up class info and up to 4 optional parameters
*** Compiler: Visual FoxPro 07.00.0000.9262 for Windows
*****************************************************************************************
DEFINE CLASS factory AS custom

lWIPTable = .F.

******************************************************
FUNCTION Init()
**********************************************
	
IF NOT USED( 'Classes' )
	USE Classes AGAIN IN 0
ENDIF

IF NOT USED( 'WIPclasses' )
	IF FILE( 'WIPclasses.dbf' )
		USE WIPclasses IN 0
		This.lWIPTable = .T.
	ENDIF
ELSE
	This.lWIPTable = .T.
ENDIF

ENDFUNC
	
**********************************************
FUNCTION GetClassInfo( tcKey )
**********************************************
LOCAL lcKey, llFound, lnSelect, loClassInfo

IF EMPTY( tcKey )
	RETURN ''
ENDIF
		
lcKey = UPPER( ALLTRIM( tcKey ) )

*** Check to see if the developers are using a local classes table
*** to test work in progress. If there is one, use the information
*** from the local table	if it is there. Only check the application
*** classes table if the keyword can't be found in the local one
lnSelect = SELECT()
IF This.lWIPTable
	SELECT WIPclasses
	LOCATE FOR UPPER( ALLTRIM( cKey ) ) == lcKey
	llFound = NOT EOF()		
ENDIF
		
*** Now check the application classes table if
*** we need to
IF NOT llFound
	SELECT Classes
	LOCATE FOR UPPER( ALLTRIM( cKey ) ) == lcKey
	llFound = NOT EOF()			
ENDIF
		
*** Package up class details in an object
*** to send back to the caller
IF llFound 
	SCATTER NAME loClassInfo FIELDS cClassName, cLibrary
	loClassInfo.cClassName = UPPER( ALLTRIM( loClassInfo.cClassName ) )
 	loClassInfo.cLibrary = UPPER( ALLTRIM( loClassInfo.cLibrary ) )
ELSE  
	loClassInfo = .NULL.
ENDIF
SELECT ( lnSelect )		

RETURN loClassInfo
	
ENDFUNC
	
****************************************************************************
FUNCTION New( tcKey, tuParam1, tuParam2, tuParam3, tuParam4 )
*****************************************************************************
LOCAL loClassInfo, lcLibType, lcCommand, lnParm, lnParmCount, loObject

*** Make sure we got a keyword
IF EMPTY( tcKey )
	RETURN .NULL.
ENDIF

*** Get the class information
loClassInfo = This.GetClassInfo( tcKey )
		
*** Make sure keyword was found in classes table
IF ISNULL( loClassInfo ) 
	RETURN .NULL.
ENDIF
		
*** Is this class in a vcx or a prg?
lcLibType = This.ChkLibType( loClassInfo.cLibrary )
		
IF EMPTY( lcLibType ) 
	RETURN .NULL.
ELSE
	loClassInfo.cLibrary = FORCEEXT( loClassInfo.cLibrary, lcLibType )
ENDIF

lcCommand = 'NewObject( "' + loClassInfo.cClassName + '", "' + loClassInfo.cLibrary + '"'

*** Now tack the parameters on to the end of the command
*** if any were passed	
lnParmCount = PCOUNT() - 1
IF  lnParmCount > 0
	lcCommand = lcCommand + ', ""'
	FOR lnParm = 1 TO  lnParmCount
		lcCommand = lcCommand + ', tuParam' + TRANSFORM( lnParm )
	ENDFOR
ENDIF
lcCommand = lcCommand + ' )'

loObject = &lcCommand

RETURN loObject
					
ENDFUNC
	
*****************************************************************************
FUNCTION ChkLibType( tcLibrary )
*****************************************************************************
LOCAL lcLibType

*** Checks for file extension on library name, and
*** figures out what it should be if not supplied
lcLibType = UPPER( JUSTEXT( tcLibrary ) )

IF NOT EMPTY( lcLibType ) 
	lcLibType = IIF( FILE( tcLibrary ), lcLibType, '' )
ELSE
	*** See if we have a vcx here
	lcLibType = IIF( FILE( FORCEEXT( tcLibrary,'VCX' ) ), 'VCX', '' )
	IF EMPTY ( lcLibType )
		lcLibType = IIF( FILE( FORCEEXT( tcLibrary,'PRG' ) ), 'PRG', '' )
	ENDIF
ENDIF		
		
RETURN lcLibType

ENDDEFINE


