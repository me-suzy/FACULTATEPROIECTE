****************************************************
* Program....: ISTAG.PRG
* Version....: 1.0
* Author.....: Andy Kramek/Marcia G. AKins
* Date.......: March 6, 1999
* Notice.....: Copyright (c) 1999 Tightline Computers Ltd, All Rights Reserved.
* Compiler...: Visual FoxPro 05.00.00.0415 for Windows 
* Abstract...: Returns .T. if the specified TAG name exists
****************************************************
PROCEDURE ISTAG( tcTagName, tcTable )
LOCAL lnCnt, llRetVal, lnSelect

IF TYPE( 'tcTagName' ) # 'C'
    *** Error - must pass a Tag Name
    ERROR '9000: Must Pass a Tag Name when calling ISTAG()'
    RETURN .F.
ENDIF

*** Save Work Area Number
lnSelect = SELECT()
IF TYPE('tcTable') = 'C' AND ! EMPTY( tcTable )
    *** If a table specified, select it
    SELECT lcTable
ENDIF
*** Check Tags    
FOR lnCnt = 1 TO TAGCOUNT()
    IF UPPER(ALLTRIM( tcTagName )) == UPPER( ALLTRIM( TAG( lnCnt ) ))
        llRetVal = .T.
        EXIT
    ENDIF
NEXT
*** Restore Work Area
SELECT (lnSelect)
*** Return Whether Tag Found
RETURN llRetVal