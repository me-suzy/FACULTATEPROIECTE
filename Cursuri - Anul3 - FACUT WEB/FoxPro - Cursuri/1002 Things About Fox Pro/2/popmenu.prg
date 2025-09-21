***********************************************************************
* Program....: DOMENU.PRG
* Author.....: Andy Kramek
* Date.......: 06 October 2001
* Notice.....: Copyright (c) 2001 Tightline Computers Ltd, All Rights Reserved.
* Compiler...: Visual FoxPro 07.00.0000.9262 for Windows 
* Purpose....: Dynamically create MPR file from data
***********************************************************************
LPARAMETERS tcMenuName
#DEFINE CRLF CHR(13) + CHR(10)
LOCAL loMenu
loMenu = CREATEOBJECT( 'xPopMenu', tcMenuName )

DEFINE CLASS xPopMenu AS Session

    *** Set properties
    DataSession = 2
    
    PROCEDURE INIT( tcMenuName )
        LOCAL lcScript

        *** Have we got this menu definition
        IF This.GetMenuDef( tcMenuName )
            lcScript = This.BuildMenu( tcMenuName )
            EXECSCRIPT( lcScript )
            RETURN .F.
        ELSE
            *** No such Menu defined - abort instantiation
            RETURN .F.
        ENDIF
    ENDPROC
    
    ********************************************************************
    *** [P] BUILDMENU(): Build the Menu script from the content of the cursor
    ********************************************************************
    PROTECTED FUNCTION BuildMenu( tcMenuName )
        LOCAL lcName, lcScript
        lcScript = ""
        lcName = LOWER( ALLTRIM( tcMenuName ))
        *** Process all menu records for Bars
        lcScript = lcScript + This.GetBars( lcName ) 
        *** Then for the required actions
        lcScript = lcScript + This.GetActions( lcName )
        *** And add on the Activate command
        lcScript = lcScript + "ACTIVATE POPUP " + lcName 
        RETURN lcScript
    ENDFUNC

    ********************************************************************
    *** [P] GETACTIONS(): Write On Selection  statements into the menu
    ********************************************************************
    PROTECTED FUNCTION GetActions( tcMenuName )
    LOCAL lcScript, lcBarNum, lcAction
        lcScript = ""
        SELECT curMenu
        GO TOP
        SCAN
            *** Do we have an action defined
            IF EMPTY( curmenu.mbaraction )
                LOOP
            ENDIF
            *** Sequence Number
            lcBarNum = TRANSFORM( curmenu.iLnkSeq )
            *** Action        
            lcAction = "[" + ALLTRIM( curmenu.mbaraction ) + "]"
            *** Need to embed all CRLF chars
            lcAction = STRTRAN( lcAction, CHR(13)+CHR(10), "] + CHR(13)  + CHR(10) + [" )
            lcAction = STRTRAN( lcAction, CHR(10)+CHR(13), "] + CHR(13)  + CHR(10) + [" )
            lcAction = STRTRAN( lcAction, CHR(13), "] + CHR(13) + [" )
            lcAction = STRTRAN( lcAction, CHR(10), "] + CHR(10) + [" )
            *** Build the statement
            lcScript = lcScript + "ON SELECTION BAR " + lcBarnum ;
                     + " OF " + tcMenuName ;
                     + " EXECSCRIPT( " + lcAction + ")" + CRLF
        ENDSCAN
        RETURN lcScript
    ENDFUNC

    ********************************************************************
    *** [P] GETBARS(): Write Menu Bar definitions
    ********************************************************************
    PROTECTED FUNCTION GetBars( tcMenuName )
    LOCAL lcBardef, lcTxt, lcBarNum, lcSkip
        *** Preamble here
        lcBarDef = "DEFINE POPUP " + tcMenuName + " SHORTCUT RELATIVE FROM MROW(),MCOL()" + CRLF
        SELECT curMenu
        GO TOP
        SCAN
            *** Prompt here
            lcTxt = "[" + ALLTRIM( curmenu.cbartext ) + "]"
            *** Sequence Number
            lcBarNum = TRANSFORM( curmenu.iLnkSeq )
            *** Skip For
            IF NOT EMPTY( curmenu.mbarskip )
                lcSkip = "SKIP FOR " + ALLTRIM( curmenu.mbarskip )
            ELSE
                lcSkip = ""
            ENDIF
            *** Definition
            lcBarDef = lcBarDef + "DEFINE BAR " + lcBarNum ;
                     + " OF " + tcMenuName ;
                     + " PROMPT " + lcTxt ;
                     + lcSkip + CRLF
        ENDSCAN
        RETURN lcBarDef
    ENDFUNC

    ********************************************************************
    *** [P] GETMENUDEF(): Get menu definition into a local cursor
    ********************************************************************
    PROTECTED FUNCTION GetMenuDef(tcMenuName)
        LOCAL lcMenuName
        lcMenuName = UPPER( ALLTRIM( tcMenuName ))
        *** Populate the cursor
        SELECT MB.cbartext, MB.mbaraction, MB.mbarskip, ML.ilnkseq ;
          FROM mnunames MN, mnubars MB, mnulink ML ;
         WHERE MB.ibarpk = ML.ilnkbarfk ;
           AND ML.ilnknamfk = MN.imenupk ;
           AND UPPER( ALLTRIM( MN.cmenuname ) ) == lcMenuName ;
           AND NOT DELETED( 'mnulink' ) ;
          INTO CURSOR curMenu ;
          ORDER BY ML.ilnkseq
        *** Did we get anything?
        RETURN (_TALLY > 0)
    ENDFUNC
ENDDEFINE
