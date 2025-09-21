**********************************************************************
* Program....: ListFields.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Illustrate use of GetUserChanges(), GetItem(), CurVal() and OldVal()
**********************************************************************
LOCAL lcChgFlds, lnCnt, lcCurFld
*** Open the Procedure file
SET PROC TO CH08 ADDITIVE
*** Open a Table and buffer it
USE demone
CURSORSETPROP("Buffering", 5, 'demone')
*** Make some changes
REPLACE d1Name WITH "William", d1City WITH "WallHouse"
*** Get list of changed fields
lcChgFlds = GetUserChanges( 'demone' )
*** Display Results
lnCnt = 0
DO WHILE .T.
    *** Retrieve field name
    lnCnt = lnCnt + 1
    lcCurFld = GETITEM( lcChgFlds, lnCnt )
    *** NULL return indicates end of the string
    IF ISNULL( lcCurFld )
        EXIT
    ENDIF
    *** Show field name
    ? "Field Name: " + CHR(9)
    ?? lcCurFld
    *** Show current Value
    ? "Actual Field Value     " + CHR(9)
    ?? &lcCurFld
    *** Current Disk Value
    ? "CURVAL() Value       " + CHR(9)
    ?? CURVAL( lcCurFld, 'demone' )
    *** Original Value
    ? "OLDVAL() Value       " + CHR(9)
    ?? OLDVAL( lcCurFld, 'demone' )
ENDDO
*** Lose changes
TABLEREVERT( .T., 'demone')
CLOSE TABLES ALL
