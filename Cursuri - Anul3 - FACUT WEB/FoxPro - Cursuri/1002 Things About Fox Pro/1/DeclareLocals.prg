**********************************************************************
* Program....: DeclareLocals.PRG
* Compiler...: Visual FoxPro 07.00.0000.9262 for Windows 
* Abstract...: Called from ON KEY LABEL ALT+6 DO DeclareLocals.prg
*								The OKL must be set 	up in the developers start up program. 
*								It inserts a local declaration for the variable that is 
*								under the cursor .
**********************************************************************
LOCAL lnHandle, lnResult, laEnv[ 25 ], lnSelStart, lcVarName, lcProgText, lnLines, laLines[ 1 ], lnCurLine
LOCAL loLocalInfo, lnLine
#DEFINE WORDDELIMITERS "!@#$%&*()-+=\[]:;'<>?/,. " + CHR( 9 )+ CHR( 13 ) + CHR( 10 )
*** Make sure FoxTools is loaded
SET LIBRARY TO FoxTools ADDITIVE
*** Get the whandle for the current window
lnHandle = _WonTop()
*** Find out what kind of window it is
*** If this is not a code editing window,
*** there is nothing to do
lnResult = _EdGetEnv( lnHandle, @laEnv )
*** In order for this to be a valid window,
*** Check the following array items:
*** [ 1 ] File Name is not empty
*** [ 2 ] File Size is greater than 0 bytes
*** [ 12 ] Is File ReadOnly ?
*** 0 - No
*** 1 - Yes
*** 2 - RW but opened RO
*** 3 - RO opened RO
*** [ 17 ] SelStart
*** [ 18 ] SelEnd
*** [ 25 ] Editor Session
*** 0 - Command Window
*** 1 - Program File
*** 2 - Text Editor
*** 8 - Menu Code Edit Window
*** 10 - Method Code Edit Window
*** 12 - Stored Proc in DBC
*** This returns 1 if successful in populating the array, 0 otherwise
IF ( lnResult = 0 ) OR;
	( laEnv[ 2 ] = 0 ) OR ;
	( laEnv[ 12 ] > 0 ) OR ;
	( laEnv[ 17 ] = 0 ) OR ;
	( NOT INLIST( laEnv[ 25 ], 1, 8, 10, 12 ) )
	RETURN
ENDIF

*** Get the current cursor position
lnSelStart = laEnv[ 17 ] 

*** Get the variable (if there is one) at the insertion point
lcVarName = GetVariable( lnHandle, lnSelStart, @laEnv )
IF EMPTY( lcVarName )
	*** Nothing to do
	RETURN
ENDIF

*** Get the contents of the editing window into an array
*** beware! if you have more than 65,000 lines of code,
*** this will crash
lcProgText = _EdGetStr( lnHandle, 0, laEnv[ 2 ] - 1 )
lnLines = ALINES( laLines, lcProgText )

*** Get the line number ( the number returned is 0-based )
*** in which the cursor is currently positioned
lnCurLine = _EdGetLNum( lnHandle, lnSelStart )

*** Now see if we have a "local" declaration already
*** loLocalInfo has 2 properties:
*** [ 1 ] nLineNo: The line number in the laLines array 
***				at which one of the following statements was encountered:
***				- LOCAL
***				- LPARAMETERS or PARAMETERS
***				- FUNCTION or PROTECTED FUNCTION
***				- PROCEDURE or PROTECTED PROCEDURES
***	or the value 1 if none of the above was found
***	[ 2 ] lLocal: True if this is a 'LOCAL' Declaration
loLocalInfo = GetLocalInfo( @laLines, lnCurLine )
IF VARTYPE( loLocalInfo ) # 'O'
	*** Mayday! MayDay! We are Fubar!
	RETURN
ENDIF

lnLine = loLocalInfo.nLineNo

*** See if we already have a local declaration
*** if we do, we are going to have to check for the
*** variable already declared
IF lolocalInfo.lLocal
	IF NOT( IsDeclared( lcVarName, @laLines, lnLine ) )
		*** See if we need to start a new local declaration
		*** we'll do it the same way CEE does and if the current line has more 
		*** than 100 characters, we'll start a new one
		IF LEN( ALLTRIM( laLines[ lnLine ] ) ) > 100
			InsertLocalDeclaration( lnHandle, lnSelStart, lnLine, lcVarName )
		ELSE
			UpdateLocalDeclaration( lnHandle, lnSelStart, @laLines, lnLine, lcVarName )
		ENDIF
	ENDIF
ELSE
	*** This is the first local declaration 
	InsertLocalDeclaration( lnHandle, lnSelStart, lnLine, lcVarName )
ENDIF

*************************************************************************
FUNCTION GetVariable( tnHandle, tnSelStart, taEnv )
*************************************************************************
LOCAL lnSelEnd, lcVarName, lcChar
*** It is possible that the cursor is positioned at the end
*** of the variable name. If it is, we must decrement 
lcChar = _EdGetChar( tnHandle, tnSelStart )
IF lcChar = '@'
	tnSelStart = tnSelStart + 1
ELSE
	IF AT( lcChar, WORDDELIMITERS ) > 0
		tnSelStart = tnSelStart - 1
	ENDIF
ENDIF

*** Go back one character from the insertion point
*** until we find the first delimiter character.
*** This will be the beginning of the word
DO WHILE AT( _EdGetChar( tnHandle, tnSelStart ), WORDDELIMITERS ) = 0 AND ;
	tnSelStart > 0
	tnSelStart = tnSelStart - 1
ENDDO
IF AT( _EdGetChar( tnHandle, tnSelStart ), WORDDELIMITERS ) > 0
	tnSelStart = tnSelStart + 1
ENDIF
*** Now find the end of the word
lnSelEnd = taEnv[ 18 ] 
lcchar = _EdGetChar( tnHandle, lnSelEnd )
IF lcChar = '@'
	lnSelEnd = lnSelEnd + 1
ENDIF

DO WHILE AT( _EdGetChar( tnHandle, lnSelEnd ), WORDDELIMITERS ) = 0 AND ;
	lnSelEnd < taEnv[ 2 ]
	lnSelEnd = lnSelEnd + 1
ENDDO
IF AT( _EdGetChar( tnHandle, lnSelEnd ), WORDDELIMITERS ) > 0
	lnSelEnd = lnSelEnd - 1
ENDIF
*** OK, so get the name of the variable
lcVarName = _EdGetStr( tnHandle, tnSelStart, lnSelEnd )

RETURN lcVarName

ENDFUNC

*******************************************************************
FUNCTION GetLocalInfo( taLines, tnCurLine )
*******************************************************************
LOCAL llFound, lnLine, lcCurrentLine, loLocalInfo

*** What we want to do is skip back a line at a time
*** from the current position in the file until we find
*** either a local declaration, a function or procedure declaration,
*** a Parameters or LParameters declaration,
*** or the first character in the editing window
llFound = .F.
FOR lnLine = tnCurLine + 1 TO 1 STEP -1
	*** get the current line, strip off leading spaces and tabs and force to upper case
	lcCurrentLine = UPPER( ALLTRIM( STRTRAN( taLines[ lnLine ] , CHR( 9 ), '' ) ) )
	DO CASE
		CASE LEFT( lcCurrentLine, 6 ) == 'LOCAL '
			*** See if the current line has a local declaration
			*** Make sure it is not a LOCAL ARRAY declaration
			IF NOT ( GETWORDNUM( lcCurrentLine, 2 ) == 'ARRAY' )
				*** Got it. We are finished
				llFound = .T.
				EXIT
			ENDIF
		CASE INLIST( LEFT( lcCurrentLine, 4 ), 'LPAR', 'PARA' )
			*** See if the current line has a parameters statement
			*** If it does, we need to insert a local declaration as
			*** the next line			
			EXIT
		CASE INLIST( LEFT( lcCurrentLine, 4 ), 'FUNC', 'PROC' )
			*** We have found a function or procedure statement
			*** that has no parameters, insert the local declaration
			*** as the next line
			EXIT
		CASE LEFT( lcCurrentLine, 10 ) == 'PROTECTED '
			*** See if we have found a protected function or procedure statement
			*** CEE didn't handle this, and it was really annoying, so we are going
			*** to see if we can
			IF INLIST( GETWORDNUM( lcCurrentLine, 2 ), 'FUNCTION', 'PROCEDURE' )
				*** Got it. We are finished
				EXIT
			ENDIF
		OTHERWISE
			*** Just keep looking until we either find something
			*** or get to the beginning of the code
	ENDCASE	
ENDFOR
*** Return the number of the line that we stopped at
*** and flag that indicates whether or not this is a 'LOCAL' declaration
loLocalInfo = CREATEOBJECT( 'Line' )
IF VARTYPE( loLocalInfo ) = 'O'
	WITH loLocalInfo
		.AddProperty( 'nLineNo', lnLine )
		.AddProperty( 'lLocal', llFound )
	ENDWITH
ENDIF

RETURN loLocalInfo

ENDFUNC

********************************************************************
FUNCTION IsDeclared( 	tcVarName, taLines, tnLine )
********************************************************************
LOCAL llDeclared, lcLocalLines, lnLine, lnLocal, lcLine

llDeclared = .F.

*** See if we have more than a single local declaration
*** and if we do, get all the local lines into a single string
lcLocalLines = UPPER( ALLTRIM( taLines[ tnLine ] ) )
lnLine = tnLine - 1
FOR lnLocal = lnLine TO 1 STEP - 1
	lcLine = UPPER( ALLTRIM( taLines[ lnLocal ] ) )
	DO CASE
		CASE LEFT( lcLine, 6 ) == 'LOCAL '
			*** See if the current line has a local declaration
			*** Make sure it is not a LOCAL ARRAY declaration
			IF NOT ( GETWORDNUM( lcLine, 2 ) == 'ARRAY' )
				lcLocalLines = lcLocalLines + ' ' + lcLine
			ENDIF
	
		CASE INLIST( LEFT( lcLine, 4 ), 'LPAR', 'PARA' )
			*** See if the current line has a parameters statement
			*** If it does, we need to insert a local declaration as
			*** the next line			
			EXIT
		CASE INLIST( LEFT( lcLine, 4 ), 'FUNC', 'PROC' )
			*** We have found a function or procedure statement
			*** that has no parameters, insert the local declaration
			*** as the next line
			EXIT
		CASE LEFT( lcLine, 10 ) == 'PROTECTED '
			*** See if we have found a protected function or procedure statement
			*** CEE didn't handle this, and it was really annoying, so we are going
			*** to see if we can
			IF INLIST( GETWORDNUM( lcLine, 2 ), 'FUNCTION', 'PROCEDURE' )
				*** Got it. We are finished
				EXIT
			ENDIF
		OTHERWISE
			*** Just keep looking until we either find something
			*** or get to the beginning of the code
	ENDCASE	
ENDFOR
*** And see if we can find the current variable
*** in any of the local declarations
IF 	ATC( ' ' + tcVarName + ',', lcLocalLines ) > 0 OR ;
 		ATC( ' ' + tcVarName + ' ', lcLocalLines ) > 0 OR ;
		RIGHT( lcLocalLines, LEN( tcVarName ) ) == UPPER( tcVarName ) 
	llDeclared = .T.
	WAIT WINDOW tcVarName + ' Already Declared' NOWAIT
ENDIF
		
RETURN llDeclared
ENDFUNC

*****************************************************************************
FUNCTION	 InsertLocalDeclaration( tnHandle, tnSelStart, tnLine, tcVarName )
*****************************************************************************
LOCAL lnPos, lcStr, lnLen

lnPos = _EdGetLPos( tnHandle, tnLine ) 
_EdSetPos( tnHandle, lnPos )
*** Go ahead and insert the local declaration
lcStr = 'LOCAL ' + tcVarName 
lnLen = LEN( lcStr ) 
_EdInsert( tnHandle, lcStr, lnLen )
*** And Add a CR
_EdSendKey( tnHandle, 13 )
WAIT WINDOW 'Local Declaration Inserted' NOWAIT
*** And reposition the cursor
lnPos = tnSelStart + lnLen + 1
_EdSetPos( tnHandle, lnPos )

ENDFUNC

*************************************************************************************
FUNCTION 	UpdateLocalDeclaration( tnHandle, tnSelStart, taLines, tnLine, tcVarName )
*************************************************************************************
LOCAL lnPos, lcStr, lnLen

*** Get the position where we need to insert the variable
lnPos = _EdGetLPos( tnHandle, tnLine - 1 ) + LEN( taLines[ tnLine ] ) 
_EdSetPos( tnHandle, lnPos )
*** Go ahead and update the local declaration
lcStr = ', ' + tcVarName 
lnLen = LEN( lcStr ) 
_EdInsert( tnHandle, lcStr, lnLen )
WAIT WINDOW 'Local Declaration Inserted' NOWAIT
*** And reposition the cursor
lnPos = tnSelStart + lnLen
_EdSetPos( tnHandle, lnPos )

ENDFUNC
