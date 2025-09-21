***********************************************************************
* Program....: GOTOREC.PRG
* Author.....: Andy Kramek
* Purpose....: Go to specified record - safely. Returns Record number
* ...........: or 0 if fails
***********************************************************************
FUNCTION GoToRec( tnRecordNumber, tcAlias )
LOCAL lnRetVal, lnSelect, lcAlias, lnRec
lnRetVal = 0
lnSelect = SELECT()
****************************************************************
*** Default Alias to currently selected if not passed
****************************************************************
lcAlias = IIF( VARTYPE(tcAlias) = "C" AND NOT EMPTY(tcAlias), UPPER(ALLTRIM(tcAlias)), ALIAS() )
lnRec = IIF( VARTYPE(tnRecordNumber) = "N" AND NOT EMPTY(tnRecordNumber), tnRecordNumber, 0 )
IF EMPTY( lnRec) OR EMPTY( lcAlias )
  *** Either no record number was passed or
  *** we cannot determine what table to use
  RETURN lnRetVal
ENDIF
****************************************************************
*** And select required alias
****************************************************************
IF NOT ALIAS() == lcAlias
  IF USED( lcAlias )
    SELECT (lcAlias)
  ELSE
    *** Specified Alias is not in use
    RETURN lnRetVal
  ENDIF
ENDIF
****************************************************************
*** Now do the LOCATE
****************************************************************
LOCATE FOR RECNO() = lnRec
lnRetVal = IIF( FOUND(), lnRec, 0 )
****************************************************************
*** Tidy Up and Return
****************************************************************
SELECT (lnSelect)
RETURN lnRetVal
