********************************************************************
*/* NAME:		MBOXPROC.PRG
*/* FUNCTION:	Message Box Manager Class
*/* CALLING:	Sets up Public Variable "goMsgMgr"
*/* 				Call ShoMsg() method to display Message
*/* USES:		MESSAGEB.DBF
*/* 				msgnum	I4		Candidate key
*/* 				msgtyp	C1		Display Type (C, E, I, W, X, Y, Z)
*/* 				msgtxt	C254	Message Text IN QUOTES
*/* 				msgtit	C60	Title text - NO QUOTES
*/*
*/* COPYRIGHT:	1996: Andy Kramek, Tightline Computers Ltd, Tel: 0121 744 4208
*/* MODIFIED:	30/06/96 Added EVAL() to allow multiple line output
*/*				12/08/96	Added Wait Window Type (X)
*/*							and Centred Wait Window Type (Y)
*/*				16/11/96 Added Status Bar Message Type
********************************************************************
SET PROCEDURE TO mboxproc ADDITIVE
RELEASE goMsgMgr
PUBLIC goMsgMgr
goMsgMgr = CREATEOBJECT("xMsgMgr")

DEFINE CLASS xMsgMgr AS CUSTOM
	
	cAppName = ""
	
	PROCEDURE Init
		This.cAppName = IIF( TYPE('gcAppName') # "C", 'Development', ALLTRIM(gcAppName) )
	ENDPROC
	
	PROCEDURE ShoMsg(tnMsgNum, tuP1, tuP2, tuP3, tuP4, tuP5, tuP6, tuP7, tuP8, tuP9)
		LOCAL lcMsgTxt, lcMsgTit, lnRetVal, lnPlaceHolders, lnOldWorkArea

		lcMsgTxt = ""

		*** 1st Parameter MUST be numeric
		IF TYPE("tnMsgNum") # "N"
			lnMsgTyp = 16
			lcMsgTit = "Developer Error"
			lcMsgTxt = "ERROR: Invalid Message Manager Call with " + CHR(13) ;
				+ IIF[TYPE("tnMsgNum") # "N", "Param 1 Missing or Not Numeric",    "Called Message #: " + ALLTRIM(STR(tnMsgNum))]
			= MESSAGEBOX(lcMsgTxt, lnMsgTyp, lcMsgTit)
			RETURN .F.
		ENDIF
		
		*** Check Message Table is Open
		IF ! USED('messageb')
			USE messageb ORDER 1 AGAIN IN 0 ALIAS messageb SHARED
		ENDIF
		
		*** Initialise Return Value to 0
		lnRetVal = 0
		
		*** Is Message Number Valid?
		IF ! SEEK(tnMsgNum, 'messageb', 'msgnum')
			*** No Message found... Handle Situation
			lnMsgTyp = 16
			lcMsgTit = "Developer Error"
			lcMsgTxt = "ERROR: Invalid Message Manager Call with " + CHR(13) ;
				+ IIF[TYPE("tnMsgNum") # "N", "Param 1 Missing or Not Numeric",    "Called Message #: " + ALLTRIM(STR(tnMsgNum))] + CHR(13) ;
				+ IIF[TYPE("tcMsgTxt") # "C", "Param 2 Omitted or Not Character", "Called With: " + tcMsgTxt] + CHR(13) ;
				+ IIF[TYPE("tnMsgTyp") # "N", "Param 3 Omitted or Not Numeric",   "Called Type # : " + ALLTRIM(STR(tnMsgTyp))]
		ELSE
			*** What Type of messagebox do we need
			DO CASE
								
				CASE messageb.msgtyp = "E"
				*** Standard Error = "STOP" + "OK" button
				lnMsgTyp = 16
				
				CASE messageb.msgtyp = "W"
				*** Standard Warning = "EXCLM" plus OK/Cancel Options
				lnMsgTyp = 49

				CASE messageb.msgtyp = "I"
				*** Standard Information = "INF" + OK Button
				lnMsgTyp = 64

				CASE messageb.msgtyp = "C"
				*** Standard Confirmation = "QUEST" + Yes/No Options
				lnMsgTyp = 36
				
				CASE messageb.msgtyp = "X"
				*** Wait Window Centred
				lnMsgTyp = 99

				CASE messageb.msgtyp = "Y"
				*** Wait Window at Top Right
				lnMsgTyp = 98

				CASE messageb.msgtyp = "Z"
				*** Status Bar Message
				lnMsgTyp = 97

			ENDCASE	
		ENDIF

		*** Set Default Button - Store in Table as 1, 2 or 3
		IF ! EMPTY(messageb.msgbtn)
			lnMsgTyp = lnMsgTyp + ((messageb.msgbtn - 1) * 256)	
		ENDIF
			
		lcMsgTit = This.cAppName + " : " + ALLTRIM(messageb.msgtit)

		*** Check Message Parameters
		IF PCOUNT() = 1	&& Default Message Only
			IF lnmsgtyp > 90
				lcMsgTxt = EVAL(ALLTRIM(messageb.msgtxt))
			ELSE
				lcMsgTxt = ALLTRIM(STR(messageb.msgnum)) + ": " + EVAL(ALLTRIM(messageb.msgtxt))
			ENDIF
			lnPlaceHolders = OCCURS("<", lcmsgtxt)
			*** Check for placeholders and remove them if necessary
			IF lnPlaceHolders > 0
				FOR lnCnt = 1 TO lnPlaceHolders
					lcmsgtxt = STRTRAN(lcMsgTxt, "<" + ALLTRIM(STR(lnCnt)) + ">")
				NEXT
			ENDIF
		ELSE
			*** Have Additional Params so check what
			lnPlaceHolders = 0
			lcMsgTxt = EVAL(ALLTRIM(messageb.msgtxt))
			*** Check for placeholders and remove them if necessary
			lnPlaceHolders = OCCURS("<", lcmsgtxt)
			IF lnPlaceHolders > 0
				FOR lnCnt = 1 TO lnPlaceHolders
					lcParm = "tuP" + ALLTRIM(STR(lnCnt))
					IF EMPTY(&lcParm)
						lcmsgtxt = STRTRAN(lcMsgTxt, "<" + ALLTRIM(STR(lnCnt)) + ">")
					ELSE
						lcmsgtxt = STRTRAN(lcMsgTxt, "<" + ALLTRIM(STR(lnCnt)) + ">", &lcParm)
					ENDIF
				NEXT
			ELSE
				*** Text has no placeholders
				lcMsgTxt = ALLTRIM(tuP1)
			ENDIF

			IF lnmsgtyp <= 90
				lcMsgTxt = ALLTRIM(STR(messageb.msgnum)) + ": " + lcMsgTxt
			ENDIF
		ENDIF
																			
		*** Strip out any double spaces
		lcmsgtxt = STRTRAN(lcMsgTxt, "  ", " ")

		*** Insert Carriage Returns for any " // "
		IF OCCURS("//", lcmsgtxt) > 0
			lcmsgtxt = "'" + STRTRAN(lcMsgTxt, " // ", " ' + CHR(13) + '") + "'"
			lcMsgTxt = EVAL(lcMsgTxt)
		ENDIF
		
		*** Run the Message Box
		DO CASE
		CASE lnMsgTyp = 98		&& Wait Window at Top Right
				WAIT WINDOW lcMsgTxt NOWAIT
				lnRetVal = 0
				
		CASE lnMsgTyp = 99		&& Wait Window Centred
			lcMsgTxt = CHR(13) + This.cAppName + " : "+lcMsgTxt + CHR(13)
			SET MEMOWIDTH TO 80
			_MLINE = 0
			lnTexLen = 0
			lnRows = MEMLINES(lcMsgTxt)
			
			*** Calculate the text size for positioning
			*** VFP V5.0 uses Arial as default messagebox font
			lnAvgChar = FONTMETRIC(6, 'Arial', 8) / FONTMETRIC(6, _SCREEN.FontName, _SCREEN.FontSize )

*************** VFP V3.0 uses MS Sans Serif as default messagebox font *********************************************
***			lnAvgChar = FONTMETRIC(6, 'MS Sans Serif', 8, 'B') / FONTMETRIC(6, _SCREEN.FontName, _SCREEN.FontSize )
********************************************************************************************************************
			lcDispText = ''
			FOR ii = 1 TO lnRows
				lcTxt = '     ' + MLINE(lcMsgTxt, 1, _MLINE) + '     '
				lcDispText = lcDispText + lcTxt + CHR(13)
				lnTexLen = MAX( TXTWIDTH(lcTxt,'MS Sans Serif',8,'B')+4, lnTexLen)  && 4 is border
			NEXT
			
			lnCol = INT((SCOLS() - lnTexLen * lnAvgChar )/2)
			lnRow = INT((SROWS() - lnRows)/2)
			
			WAIT WINDOW lcDispText AT lnRow, lnCol NOWAIT
				
		CASE lnMsgTyp = 97		&& Status Bar Message
			*** Turn Status Bar on if necessary
			IF SET("STATUS BAR") = "OFF"
				SET STATUS BAR ON
			ENDIF
				
			*** Paint message
			SET MESSAGE TO lcMsgTxt
							
		OTHERWISE		&& Custom Message Box
			lnRetVal = MESSAGEBOX(lcMsgTxt, lnMsgTyp, lcMsgTit)

		ENDCASE
		
		*** Return Value
		RETURN lnRetVal	

	ENDPROC

ENDDEFINE
