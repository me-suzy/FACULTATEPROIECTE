***********************************************************************
* Program....: GETITEM.PRG
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Extracts the specified element from a list
**********************************************************************
FUNCTION GetItem( tcList, tnItem, tcSepBy )
LOCAL lcRetVal, lcSepBy
lcRetVal = ""
*** Default to Comma Separator if none specified
lcSep = IIF( VARTYPE(tcSepBy) # 'C' OR EMPTY( tcSepBy ), ',', tcSepBy )
*** Default to First Item if nothing specified
tnItem = IIF( TYPE( 'tnItem' ) # "N" OR EMPTY( tnItem ), 1, tnItem)
*** If we have exceeded the length of the string, return NULL
IF tnItem > GETWORDCOUNT( tcList, lcSep )
    lcRetVal = NULL
ELSE
    *** Get the specified item
    lcRetVal = GETWORDNUM( tcList, tnItem, lcSep )
ENDIF
*** Return result
RETURN ALLTRIM(lcRetVal)
