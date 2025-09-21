LPARAMETERS tcTable, tcAction
SET STEP ON
LOCAL lnHdrKey, lcFieldList, lnCnt, lnItemsToDo, llOk
tcTable = UPPER( ALLTRIM ( tcTable ))
IF tcAction = "UPDATE"
    *** Build List of affected fields
    lnItemsToDo = OCCURS( "2", GETFLDSTATE( -1, tcTable ))
ELSE
    *** Do all fields
    lnItemsToDo = FCOUNT()
ENDIF
*** If no changes - just return
IF lnItemsToDo = 0
    RETURN .T.
ENDIF
*** Ensure Audit log tables are used and row-buffered
IF ! USED( 'logHdr' )
    USE logHdr AGAIN IN 0
ENDIF
IF ! USED( 'logItm')
    USE logItm AGAIN IN 0
ENDIF
IF CURSORGETPROP( 'Buffering', 'logHdr' ) # 3
    CURSORSETPROP( 'Buffering', 3, 'logHdr' )
ENDIF
IF CURSORGETPROP( 'Buffering', 'logItm' ) # 3
    CURSORSETPROP( 'Buffering', 3, 'logItm' )
ENDIF

*** Begin Transaction
BEGIN TRANSACTION
    *** Insert into Log Header
    INSERT INTO logHdr ;
        ( lHdrTabl, lHdrType, lHdrDate, lHdrUser ) ;
        VALUES ;
        ( tcTable, tcAction, DATETIME(), 'SYSTEM' )
    llOk = TABLEUPDATE( 0,  .F., 'logHdr' )
    *** Insert into Log Details
    IF llOk
        *** Get the Foreign Key
        lnHdrKey = logHdr.lHdrSId
        FOR lnCnt = 1 TO lnItemsToDo
            lcField = FIELDS( lnCnt )
            lcType = VARTYPE( &lcField )
            lcFVal = EXP2STR( OLDVAL( lcField, tcTable ) )
            lcTVal = EXP2STR( &lcField )
            *** Update the Items table
            INSERT INTO logItm ;
                ( lHdrKey, lItmFld, lItmFVal, lItmTVal, lItmType ) ;
                VALUES ;
                ( lnHdrKey, lcField, lcFVal, lcTVal, lcType )
            llOk = TABLEUPDATE( 0, .F., 'logItm' )
            *** Abort if fails
            IF ! llOk
                EXIT
            ENDIF
        NEXT
    ENDIF
*** End Transaction
IF llOk
    END TRANSACTION
ELSE
    ROLLBACK
ENDIF

FUNCTION Exp2Str( tuExp, tcType )
*** Convert the passed expression to string
LOCAL lcRetVal, lcType
*** If no type passed -- map to expression type
lcType=IIF( TYPE( 'tcType' )='C', UPPER( ALLTRIM( tcType ) ), TYPE( 'tuExp' ) )
*** Convert from type to char
DO CASE
  CASE INLIST( lcType, 'I', 'N' ) AND INT( tuExp ) = tuExp      && Integer
    lcRetVal = ALLTRIM( STR( tuExp, 16, 0 ) )
  CASE INLIST( lcType, 'N', 'Y' )                   && Numeric or Currency
    lcRetVal = ALLTRIM( PADL( tuExp, 32 ) )
  CASE lcType = 'C'                                 && Character
    lcRetVal = ALLTRIM( tuExp )
  CASE lcType = 'L'                                 && Logical
    lcRetVal = IIF( !EMPTY( tuExp ), '.T.', '.F.')
  CASE lcType = 'D'                                 && Date 
    lcRetVal = ALLTRIM( DTOC( tuExp ) )
  CASE lcType = 'T'                                 && DateTime 
    lcRetVal = ALLTRIM( TTOC( tuExp ) )
  OTHERWISE
    *** There is no otherwise unless, of course, Visual FoxPro adds
    *** a new data type. In this case, the function must be modified 
ENDCASE
*** Return value as character
RETURN lcRetVal
