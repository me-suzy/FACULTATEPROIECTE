**********************************************************************
* Program....: MsgMgr.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Class Definition for Message Handler
**********************************************************************

DEFINE CLASS xMsgMgr AS FORMSET
    PROTECTED FormCount, Visible, DataSession, nDSId
    FormCount   = 0        && Don't allow any forms
    Visible     = .F.      && Keep the Formset invisible
    DataSession = 2        && In a Private Datasession
    nDSId      = 1        && Default DS to 1
    
    PROCEDURE Init
        WITH This
            *** Open up the message table
            IF ! USED('msgtable')
                USE msgtable IN 0 AGAIN SHARED ALIAS msgtable
            ENDIF
            *** Save Message Handler's DataSession 
            .nDSId = .DataSessionID
        ENDWITH
    ENDPROC    

    PROCEDURE ShoMsg( tnMsgNum )
        LOCAL lnOrigDS, lnRetVal
        WITH This
            *** Message Number must be numeric
            IF VARTYPE( tnMsgNum ) # "N"
                ERROR "9000: A valid numeric parameter must be passed to ShoMsg()"
                *** Return Error Indicator
                RETURN -1
            ENDIF
            *** Switch to Mesage Handler's DS
            lnOrigDS = SET("DATASESSION")
            SET DATASESSION TO (.nDSId )
            *** Locate Required Message Details
            IF SEEK( tnMsgNum, 'msgtable', 'msgnum' )
                *** Call Appropriate Handler for this message based on Type
                lnRetVal = .GetMsgStyle()
            ELSE
                *** Message Number not Valid
                ERROR "9000: Message Number " + ALLTRIM(STR( tnMsgNum )) + " Not Recognised"
                *** Return Error Indicator
                lnRetVal = -1
            ENDIF
            *** Restore Original DS and Return
            SET DATASESSION TO (lnOrigDS)
            RETURN lnRetVal
        ENDWITH
    ENDPROC

    ********************************************************************
    *** MsgMgr::GetMsgStyle() - Check Message Type and call appropriate handler
    ********************************************************************
    PROTECTED PROCEDURE GetMsgStyle
        *** Check the current message type and call correct handler with
        *** any necessary parameters
        LOCAL lcMsgTyp, lnRetVal
        lcMsgTyp = msgtable.msgtyp
        DO CASE
           CASE lcMsgTyp = "E"
                *** Standard Error = "STOP" + "OK" button
                lnRetVal = .DoMsgBox( 16 )
           CASE lcMsgTyp = "W"
                *** Standard Warning = "EXCLAMATION" + "OK/Cancel" button
                lnRetVal = .DoMsgBox( 49 )
           CASE lcMsgTyp = "I"
                *** Standard Information = "INFO" + OK Button
                lnRetVal = .DoMsgBox( 64 )
           CASE lcMsgTyp = "C"
                *** Standard Confirmation = "QUESTION" + Yes/No Options
                lnRetVal = .DoMsgBox( 36 )
           CASE lcMsgTyp = "X"
                *** Wait Window Centred
                lnRetVal = .DoWait(.T.)
           CASE lcMsgTyp = "Y"
                *** Wait Window at Top Right
                lnRetVal = .DoWait()
           CASE lcMsgTyp = "Z"
                *** Status Bar Message
                lnRetVal = .DoStat()
           OTHERWISE
                *** No Display Required - Return Success
				lnRetVal = 1
        ENDCASE
        *** Return Display Type
        RETURN lnRetVal
    ENDPROC

    ********************************************************************
    *** MsgMgr::DoMsgBox( tnParam ) - Call Message Box to display message
    *** Return Button used to close Message Box
    ********************************************************************
    PROTECTED PROCEDURE DoMsgBox( tnParam )
        LOCAL lnRetVal, lcTxt, lcTit
        *** Get Message and Title from table
        lcTxt = ALLTRIM( msgtable.msgtxt )
        lcTit = ALLTRIM( msgtable.msgtit )
        *** Set Default Button - Store in Table as 1, 2 or 3
		IF ! EMPTY(msgtable.msgbtn)
			lnParam = tnParam + ((msgtable.msgbtn - 1) * 256)	
		ELSE
			lnParam = tnParam
		ENDIF
        lnRetVal = MESSAGEBOX( lcTxt, lnParam, lcTit )
        RETURN lnRetVal
    ENDPROC
    
    ********************************************************************
    *** MsgMgr::DoWait( tlCenter ) - Display Wait Window Message
    *** No Specific Return Value
    ********************************************************************
    PROTECTED PROCEDURE DoWait( tlCenter )
        LOCAL lcTxt
        *** Get Message from table
        lcTxt = ALLTRIM( msgtable.msgtit )
        IF tlCenter
            LOCAL lnTexLen, lnRows, lnAvgChar, lcDispText, lnCnt, lcLine, lnCol, lnRow 
            *** Calculate the size of the message
            SET MEMOWIDTH TO 80
            _MLINE = 0
            lnTexLen = 0
            lnRows = MEMLINES(lcTxt)

            *** Calculate the text size for positioning
            lnAvgChar = FONTMETRIC(6, 'Arial', 8) / FONTMETRIC(6, _SCREEN.FontName, _SCREEN.FontSize )
            lcDispText = ''
            *** Find longest row of text in the message
            FOR lnCnt = 1 TO lnRows
                lcLine = ' ' + MLINE(lcTxt, 1, _MLINE) + ' '
                lcDispText = IIF(! EMPTY(lcDispText), CHR(13), "") + lcDispText + lcLine 
                lnTexLen = MAX( TXTWIDTH(lcLine,'MS Sans Serif',8,'B')+4, lnTexLen)  && 4 is border
            NEXT
            *** Work out position for window based on longest row
            lnCol = INT((SCOLS() - lnTexLen * lnAvgChar )/2)
            lnRow = INT((SROWS() - lnRows)/2)
            *** Show Window centered
            WAIT WINDOW lcDispText AT lnRow, lnCol NOWAIT
        ELSE
            *** Simple Wait Window at Top/Right
            WAIT WINDOW lcTxt NOWAIT
        ENDIF
        *** Return 'Success'
        RETURN 1
    ENDPROC

    ********************************************************************
    *** MsgMgr::DoStat() - Display Status Bar Message
    *** No Specific Return Value
    ********************************************************************
    PROTECTED PROCEDURE DoStat()
        LOCAL lcTxt
        *** Get Message from table
        lcTxt = ALLTRIM( msgtable.msgtit )
		SET MESSAGE TO lcTxt
        *** Return 'Success'
        RETURN 1
    ENDPROC

ENDDEFINE