* Program....: GenErr.PRG
* Version....: 1.0
* Author.....: Andy Kramek
* Date.......: September 4, 1998
* Notice.....: Copyright (c) 1998 Tightline Computers Ltd, All Rights Reserved.
* Compiler...: Visual FoxPro 05.00.00.0415 for Windows 
* Abstract...: ON ERROR DO GenErr WITH ERROR(), MESSAGE(), MESSAGE(1), PROGRAM(), LINENO()
* Changes....: Modified October 1998 to remove AQUA specific portions of code

LPARAMETERS tnError, tcMessage, tcMessage1, tcProgram, tnLineno
LOCAL lcOnError, lnError, lcMessage, lcMessage1, lcProgram, lnLineno, lcAction
LOCAL llLogError, llQuitApp, lcStr, lcProgPath, lcLogPath, lnCnt, lcAlias 

*** Set Application Name
IF TYPE("gcAppName") = "C" AND ! EMPTY(gcAppName)
	lcAppName = gcAppName
ELSE
	lcAppName = "1001 Things!"
ENDIF

*** Set Error Log Path
IF VARTYPE(gcErrPath) = "C"
	lcLogPath = gcErrPath
ELSE
	lcLogPath =  FULLPATH( CURDIR() )
***	lcLogPath =  SYS(5) + "\Connections\Errorlog"
ENDIF

#DEFINE DEF_APPNAME lcAppname
#DEFINE DEF_LOGPATH	lcLogPath

*** Switch-off error handler to stop recursive calls
lcOnError = ON('ERROR')
ON ERROR

*** Clean parameters
lnError    = IIF( !EMPTY(tnError),    tnError,    ERROR() )
lcMessage  = IIF( !EMPTY(tcMessage),  tcMessage,  MESSAGE() )
lcMessage1 = IIF( !EMPTY(tcMessage1), tcMessage1, MESSAGE(1) )
lcProgram  = IIF( !EMPTY(tcProgram),  tcProgram, '<unknown>' )
lnLineno   = IIF( !EMPTY(tnLineno),   tnLineno,  0 )

*** Initialise Local Variables
lcAction    = 'Quit'  && Default action is to quit app
llLogError  = .T.     && Should error be written to log
llQuitApp   = .T.     && Should app be terminated
lcProgPath = ''       && Program calling hierarchy
lcStr = ''            && User Error message text

*** Do appropriate action (based on error)
DO CASE

	******<I/O Errors>**************************************************************
	CASE INLIST( lnError,1,15,17,19,41,50,54,55,114,1002,1166,1167,1551,1552,1553)  
		lcStr = DEF_APPNAME+' has reported a File or Input/Output Error.  This may'+CHR(13)+;
			'be caused by corrupt data or be due to an error at the Windows operating '+CHR(13)+;
			'system level.  Try re-booting your PC after exiting Windows, but if that '+CHR(13)+;
			'does not cure the problem you should contact Technical Support'
		lcAction = 'Quit'

	******<Memory Problems>**************************************************************
	CASE INLIST( lnError,22,43,1149,1150,1151,1308,1600,1881,1986)
		lcStr = DEF_APPNAME+' has run low on memory.  Quit one or more'+CHR(13)+ ;
				'applications or restart Windows.  You may also benefit'+CHR(13)+ ;
				'from re-booting your PC after exiting Windows'
		lcAction = 'QuitRB'

	******<Diskspace Problems>***********************************************************
	CASE INLIST( lnError,0056 )  && Not enough disk space for "<file name>"
		lcStr = DEF_APPNAME+' has run low on disk space.  Try increasing'+CHR(13)+ ;
			'the space on the hard-disk by removing unused files and'+CHR(13)+ ;
			're-start the application.  Contact system support if'+CHR(13)+ ;
			'you are unsure of what to do next.'
		lcAction = 'QuitRB'

	******<Printer Not Ready>*******************************************
	CASE INLIST( lnError,0125,1643,1644 )  && Printer is not ready
		lcStr = 'The selected printer is reporting "NOT READY".  Please'+CHR(13)+ ;
			'ensure printer is on-line and ready to print and press RETRY'+CHR(13)+ ;
			'to try again.'+CHR(13)+CHR(13)+ ;
			'If the printer appears to be ready to print and this error' +CHR(13)+;
			'is continually appearing, you may be experiencing network' +CHR(13)+;
			'problems and you should contact system support in this event.'
		llLogError = .F.
		lcAction = 'Retry'

	******<Feature Not Available>***************************************
	CASE INLIST( lnError,1001,1999)  && Feature is not avail
		lcStr = 'An attempt has been made to access a feature not available'+CHR(13)+;
			'in this version of the software.'
		lcAction = 'Quit'

	********************************************************************
	CASE INLIST( lnError,1098)  && User API Error from ERROR 'Error occurred...'
		&& error will be logged
		lcAction  = 'Nothing'  && just quit app

	********************************************************************
	CASE INLIST( lnError,1410 )  && Cannot write to disk -- check privs
		lcStr = DEF_APPNAME+' was unable to write temporary work files.'+CHR(13)+ ;
			'This may be due to a full temporary directory or'+CHR(13)+ ;
			'insufficient priviliges on a network drive.'
		llLogError = .F.
		lcAction = 'QuitRB'

	********************************************************************
	CASE INLIST(lnError,1462,1522, 1941)  && Bad unknown error, VFP will exit
		lcStr = DEF_APPNAME+' has experienced an internal error which'+CHR(13)+;
			'cannot be identified.  To absolutely ensure data integrity'+CHR(13)+;
			DEF_APPNAME+' will be safely closed down.'
		lcAction = 'QuitRB'

	********************************************************************
	CASE INLIST( lnError,1489)  && MULTILOCKS OFF -- set on and return
		WAIT WINDOW NOWAIT 'MULTILOCKS ENABLED'
		SET MULTILOCKS ON
		llQuitApp = .F.		&& error will be logged
		lcAction = 'Nothing'

	********************************************************************
	CASE INLIST( lnError,1545 )  && uncommited changes - revert
		*** Get table alias for bad table
		LOCAL lnStt, lnEnd, lcTable
		lnStt   = AT( '"', lcMessage )+1
		lnEnd   = AT( '"', lcMessage, 2 )-1
		lcTable = SUBSTR(lcMessage,lnStt,lnEnd-lnStt+1)
		=TABLEREVERT(.T.,lcTable)		&& error will be logged
		llQuitApp = .F.
		lcAction  = 'Nothing'
		
	********************************************************************
	CASE INLIST( lnError,1736)  && Cannot instantiate, may be low memory
		lcStr = DEF_APPNAME+' was unable to create an application object.  This may'+CHR(13)+;
			'be due to low memory or an invalid DLL library.  Quit one or more'+CHR(13)+;
			'applications or try restarting Windows.  You may also benefit'+CHR(13)+;
			' from re-booting your PC after exiting Windows'
		lcAction = 'QuitRB'

	********************************************************************
	CASE INLIST( lnError,1753)  && Invalid .DLL -- may be corrupt
		lcStr = 'Windows reports an error in one of its essential system files.'+CHR(13)+ ;
				'This has nothing to do with '+DEF_APPNAME+'. You can try re-booting '+CHR(13)+;
				'your PC after exiting Windows, to see if Windows can resolve the '+CHR(13)+;
				'problem, but the nature of this error may mean that you will need '+CHR(13)+;
				'to re-install the Windows Operating System.'
		lcAction = 'QuitRB'

	********************************************************************
	CASE INLIST( lnError,1907)  && Invalid drive -- check you are logged-on
		lcStr = DEF_APPNAME+' has referenced an invalid drive.  Please ensure'+CHR(13)+;
			'that you have logged-on to the network successfully.'+CHR(13)+;
			'Please try restarting Windows and you may also benefit'+CHR(13)+;
			'from re-booting your PC after exiting Windows'
		lcAction = 'QuitRB'

	********************************************************************
	CASE INLIST( lnError,1955)  && WIN.INI/Registry corrupt -- try re-booting
		lcStr = 'Windows reports an error in its .INI File and/or Registry.'+CHR(13)+ ;
				'This has nothing to do with '+DEF_APPNAME+'. You can try re-booting '+CHR(13)+;
				'your PC after exiting Windows, to see if Windows can resolve the '+CHR(13)+;
				'problem, but the nature of this error may mean that you will need '+CHR(13)+;
				'to re-install the Windows Operating System.'
		lcAction = 'QuitRB'

	********************************************************************
	CASE INLIST( lnError,1956,1957,1958)  && Unable to access printer
		lcStr = DEF_APPNAME+' cannot access the specified printer, although '+CHR(13)+ ;
			'the printer itself appears to be ready to print.'+CHR(13)+CHR(13)+ ;
			'There may, therefore be a system problem and should you contact' +CHR(13)+;
			'your Technical Support Personnel immediately.'
		llLogError = .T.
		lcAction = 'Quit'

	********* OTHER FOXPRO ERROR **********************************
	OTHERWISE
		lcStr = DEF_APPNAME + ' has reported an internal error - Number '+ALLTRIM(STR(lnError))+CHR(13)+ ;
			'Please report this number to your Technical Support Personnel'
		lcAction = 'Quit'

ENDCASE

*** Get filename for errorlog
lcLogName = DEF_LOGPATH +'E'+SUBSTR(SYS(2015), 3, 10)+'.TXT'

*** Log error, if required
IF llLogError
	SET ALTERNATE TO &lcLogName ADDITIVE
	SET ALTERNATE ON
	SET CONSOLE OFF
	? '********* NEW ERROR: '+TTOC(DATETIME())+' *******************'
	? 'Error : '+STR(tnError,4)+': '+tcMessage
	? '        at line '+ALLTRIM(STR(tnLineno,10))+' in '+lcProgram
	? 'Source: '+lcMessage1
	?
	? 'User  : ' + SYS(0)
	?
	? '--- User Message'
	? lcStr
	?
	? '--- Clipboard contents'
	? _CLIPTEXT
	?
	? '--- Memory dump: LIST MEMORY'
	LIST MEMORY LIKE *
	?
	? '--- Object dump: LIST OBJECTS'
	LIST OBJECTS
	?
	? '--- Data Session status: LIST STATUS'
	LIST STATUS
	?
	? '--- Data Dump'
	?
	lnSelect = SELECT()
	LOCAL ARRAY laUsed[1]
	FOR lnCnt = 1 TO AUSED(laUsed)
		SELECT (laUsed[lnCnt,2])  && work area no.
		? 'Table: '+ALIAS()
		? REPLICATE('-',69)
		lnRec = RECNO()
		? SPACE(5)+'Record #'+ALLTRIM(STR(lnRec))
		IF CURSORGETPROP('Buffering')>1 AND ('3'$GETFLDSTATE(-1) OR '4'$GETFLDSTATE(-1))
			?? SPACE(5)+'  ** APPENDED **'
		ENDIF
		IF CURSORGETPROP('Buffering')>1 AND GETFLDSTATE(0)%2 = 0
			IF DELETED()
				?? SPACE(5)+'  ** DELETED **'
			ELSE
				?? SPACE(5)+'  ** UNDELETED **'
			ENDIF
		ENDIF
			
		FOR lnFld = 1 TO FCOUNT()
			lcFVal = PADR(ConvToStr(EVAL(FIELD(lnFld))),25)
			IF CURSORGETPROP('Buffering')>1
				?  SPACE(5)+ ;
					IIF(INLIST(GETFLDSTATE(lnFld),2,4),' *','  ')+ ' '+ ;
						TYPE(FIELD(lnFld))+' '+ ;
						PADR( FIELD(lnFld)+' ',25,'.' )+' '+ ;
						IIF( ISNULL(EVAL(FIELD(lnFld))), '.NULL.', lcFVal )
			ELSE
				?  SPACE(5)+'   '+TYPE(FIELD(lnFld))+' '+ ;
						PADR( FIELD(lnFld)+' ',25,'.' )+' '+ ;
						IIF( ISNULL(EVAL(FIELD(lnFld))), '.NULL.', lcFVal )
			ENDIF
		NEXT
		?
	NEXT
	?
	? '--- Calling chain'
	lnCnt = 1
	DO WHILE !EMPTY(PROGRAM(lnCnt))
		lcProgPath = lcProgPath + PROGRAM(lnCnt) + CHR(13)+CHR(10)
		lnCnt = lnCnt + 1
	ENDDO
	? lcProgPath
	?
	SET CONSOLE ON
	SET ALTERNATE OFF
	SET ALTERNATE TO
ENDIF

WAIT CLEAR

*** Put-up correct prompt
DO CASE
CASE UPPER(lcAction) = 'QUITRB'
	=ShoQuitRBErr( lcStr, lnError )
CASE UPPER(lcAction) = 'QUIT'
	=ShoQuitErr(lcStr, lnError)
CASE UPPER(lcAction) = 'RETRY'
	*** Decide whether app should quit or not
	IF ShoRetryErr( lcStr )
		llQuitApp = .F.
	ENDIF
CASE UPPER(lcAction) = 'NOTHING'
	*** Do.... nothing!
ENDCASE

*** Either retry or quit application
IF llQuitApp
	*** Now Quit the Application
	IF VERSION(2) = 0
		*** Release Public Variables and Close All open forms
		=ClearDown()
		*** Runtime Shutdown
		ON SHUTDOWN
		QUIT
	ELSE
		*** Development Shutdown
		IF MESSAGEBOX('Do you wish to suspend '+DEF_APPNAME+' ?', 32+4, ;
											'Debug Mode: Error has occurred!')=6  && yes
			WAIT WINDOW NOWAIT 'Suspended.'
			SUSPEND
		ELSE
			WAIT WINDOW NOWAIT 'Cancelled.'
			*** Release Public Variables and Close All open forms
			=ClearDown()
			CLEAR EVENTS
			CANCEL
		ENDIF
	ENDIF
ELSE
	*** Restore error handler
	ON ERROR &lcOnError
	RETRY
ENDIF

*** Open the Error Log Table if it isn't open already
llOk = .F.
IF ! USED( 'errorlog' )
	USE errorlog AGAIN SHARED IN 0 ALIAS errorlog
ENDIF
*** Insert the Error Summary Record
DO WHILE ! llOk
    INSERT INTO errorlog (;
        logdtime, logerrnum, logerrprog, logerrline, logerruser, logerrtxt;
        ) VALUES ( ;
        DATETIME(), tnError, lcProgram, tnLineno, SYS(0), lcLogName ;
        )
	*** Commit the Error    
    llOk = TABLEUPDATE( 1, .F., "errorlog" )
    IF ! llOk
        TABLEREVERT( .T., "errorlog" )
    ENDIF
ENDDO        

RETURN

********* Show Retry Error *****************************************
FUNCTION ShoRetryErr( tcStr )
	RETURN ( MESSAGEBOX(tcStr,48+5,DEF_APPNAME+' : Do You Wish To Retry ?')=4 )  && .T. for retry
ENDFUNC

********* Show Quit+Rollback Error *********************************
FUNCTION ShoQuitRBErr( tcStr, tnError )
	LOCAL lcStr
	lcStr = tcStr +CHR(13)+CHR(13)+;
			'If you were part-way through an update it is possible that' +CHR(13)+ ;
			'your last changes have been rolled-back to ensure the' +CHR(13)+ ;
			'integrity of the data.'
	=ShoQuitErr( lcStr, tnError )
ENDFUNC

********* Show quit error + exit ***********************************
FUNCTION ShoQuitErr( tcStr, tnError )
	LOCAL lcStr
	*** Report error
	lcStr = 'An error has occurred in the '+DEF_APPNAME+' application and you' +CHR(13)+ ;
			'should notify system support of this as soon as possible:'+CHR(13)+CHR(13)+;
			tcStr +CHR(13)+CHR(13)+;
			'Selecting OK will allow the application to safely close-down.'
	= MESSAGEBOX( lcStr, 16+0, DEF_APPNAME+' : System Error Message '+ALLTRIM(STR(tnError)) )
ENDFUNC

********* Clear Down Open Forms ***********************************
FUNCTION ClearDown
	*** Close All Forms
	FOR lnCnt = _Screen.FormCount TO 1 STEP -1
		_Screen.Forms[lnCnt].Release()
	NEXT
	*** Close Any Open Transactions in default DS
	IF TXNLEVEL() > 0
		DO WHILE TXNLEVEL() > 0
			ROLLBACK
		ENDDO
	ENDIF
	*** Close anyTables in Default DS
	LOCAL ARRAY laUsed[1]
	IF AUSED(laUsed) > 0
		FOR lnCnt = 1 TO ALEN( laUsed,1 )
			lcAlias = laUsed[lnCnt,1]
			*** Revert it if necessary
			IF CURSORGETPROP( 'Buffering', lcAlias )>1
				=TABLEREVERT(.T., lcAlias )
			ENDIF
			*** Close it
			USE IN ( lcAlias )
		NEXT
	ENDIF
	*** Release Public Variables
	RELEASE ALL EXTENDED
ENDFUNC

********* Convert a value to a string equivalent *******************
FUNCTION ConvToStr( tuExp, tcType )
	LOCAL lcRetVal, lcType
	*** If no type passed -- map to expression type
	lcType = IIF( TYPE('tcType')='C', UPPER(ALLTRIM(tcType)), TYPE('tuExp') )
	*** Convert from type to char
	DO CASE
	CASE INLIST(lcType, 'I', 'N') AND INT(tuExp)=tuExp && Integer
		lcRetVal = ALLTRIM(STR(tuExp,16,0))
	CASE INLIST(lcType, 'N', 'Y')	&& Numeric or Currency
		lcRetVal = ALLTRIM(PADL(tuExp,32))
	CASE lcType = 'C'  && Character
		lcRetVal = "'" + ALLTRIM( tuExp ) + "'"
	CASE lcType = 'L'  && Logical
		lcRetVal = IIF(!EMPTY(tuExp),'.T.','.F.')
	CASE lcType = 'D'  && Date 
		lcRetVal = "'" + ALLTRIM( DTOC( tuExp ) ) + "'"
	CASE lcType = 'T'  && DateTime 
		lcRetVal = "'" + ALLTRIM( TTOC( tuExp ) ) + "'"
	ENDCASE
	*** Return value as character
	RETURN lcRetVal
ENDFUNC
