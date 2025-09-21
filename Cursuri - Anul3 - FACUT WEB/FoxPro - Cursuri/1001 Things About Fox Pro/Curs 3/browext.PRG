**********************************************************************
* Program....: BrowExt.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Decorator for standard Browse Command that restores the
* ...........: field name in place of the Caption in the Browse Window
**********************************************************************
*** This Version only works in VFP5 or later
LOCAL lnCnt
BROWSE NAME oBrowse NOWAIT
FOR EACH loCol IN oBrowse.Columns
    loCol.Header1.Caption = PROPER( SUBSTR(loCol.ControlSource, RAT('.',loCol.ControlSource)+1 ))
NEXT

*!*	*** This version will work in ALL versions of VFP
*!*	LOCAL lnCnt
*!*	BROWSE NAME oBrowse NOWAIT
*!*	FOR lnCnt = 1 TO oBrowse.Columncount
*!*	    oBrowse.Columns[lnCnt].Header1.Caption = PROPER(FIELD(lnCnt))
*!*	NEXT
