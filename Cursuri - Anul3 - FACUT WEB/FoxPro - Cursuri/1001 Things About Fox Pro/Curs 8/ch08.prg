**********************************************************************
* Program....: CH08.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Chapter 2 generic procedure file
**********************************************************************

**********************************************************************
* Program....: Str2Exp
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Passed a string and a data type, return the expression
* ...........: after conversion to the specified data type
**********************************************************************
FUNCTION Str2Exp( tcExp, tcType )
*** Convert the passed string to the passed data type
LOCAL luRetVal, lcType

*** Remove double quotes (if any) 
tcExp = STRTRAN( ALLTRIM( tcExp ), CHR( 34 ), "" ) 
*** If no type passed -- map to expression type
lcType = IIF( TYPE( 'tcType' ) = 'C', UPPER( ALLTRIM( tcType ) ), TYPE( tcExp ) )
*** Convert from Character to type
DO CASE
  CASE INLIST( lcType, 'I', 'N' ) AND INT( VAL( tcExp ) ) == VAL( tcExp ) && Integer
    luRetVal = INT( VAL( tcExp ) )
  CASE INLIST( lcType, 'N', 'Y')                      && Numeric or Currency
    luRetVal = VAL( tcExp )
  CASE INLIST( lcType, 'C', 'M' )                     && Character or memo
    luRetVal = tcExp
  CASE lcType = 'L'                                   && Logical
    luRetVal = IIF( !EMPTY( tcExp ), .T., .F. )
  CASE lcType = 'D'                                   && Date 
    luRetVal = CTOD( tcExp )
  CASE lcType = 'T'                                   && DateTime 
    luRetVal = CTOT( tcExp )
  OTHERWISE
    *** There is no otherwise unless, of course, Visual FoxPro adds
    *** a new data type. In this case, the function must be modified 
ENDCASE
*** Return value as Data Type
RETURN luRetVal

**********************************************************************
* Program....: Str2Exp
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the passed expression a either a quoted or
* ...........: unquoted string depending on its data type in order to
* ...........: build SQL where clauses on the fly
**********************************************************************
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
    lcRetVal = '"' + ALLTRIM( tuExp ) + '"'
  CASE lcType = 'L'                                 && Logical
    lcRetVal = IIF( !EMPTY( tuExp ), '.T.', '.F.')
  CASE lcType = 'D'                                 && Date 
    lcRetVal = '"' + ALLTRIM( DTOC( tuExp ) ) + '"'
  CASE lcType = 'T'                                 && DateTime 
    lcRetVal = '"' + ALLTRIM( TTOC( tuExp ) ) + '"'
  OTHERWISE
    *** There is no otherwise unless, of course, Visual FoxPro adds
    *** a new data type. In this case, the function must be modified 
ENDCASE
*** Return value as character
RETURN lcRetVal

**********************************************************************
* Program....: IsTag
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Passed the name of an index tag returns true if it is a
* ...........: tag for the specified table. Uses table in the current
* ...........: work area if no table name is passed. 
**********************************************************************
FUNCTION IsTag( tcTagName, tcTable )
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
  SELECT (tcTable)
ENDIF
*** Check Tags    
FOR lnCnt = 1 TO TAGCOUNT()
  IF UPPER(ALLTRIM( tcTagName ) ) == UPPER( ALLTRIM( TAG( lnCnt ) ) )
    llRetVal = .T.
    EXIT
  ENDIF
NEXT
*** Restore Work Area
SELECT (lnSelect)
*** Return Whether Tag Found
RETURN llRetVal

**********************************************************************
* Program....: ContainsAlpha
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns .T. if the passed string contains at least one
* ...........: alphabetic character
**********************************************************************
FUNCTION ContainsAlpha( tcString )
RETURN LEN( CHRTRAN( UPPER( tcString ), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "" ) );
  # LEN( tcString )

**********************************************************************
* Program....: GetItem
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Extracts the specified element from a list
**********************************************************************
FUNCTION GetItem( tcList, tnItem, tcSepBy )
LOCAL lcRetVal, lnStPos, lnEnPos, lcSepBy
lcRetVal = ""
*** Default to Comma Separator if none specified
lcSep = IIF( VARTYPE(tcSepBy) # 'C' OR EMPTY( tcSepBy ), ',', tcSepBy )
*** Default to First Item if nothing specified
tnItem = IIF( TYPE( 'tnItem' ) # "N" OR EMPTY( tnItem ), 1, tnItem)
*** Add terminal separator to list to simplify search
tcList = ALLTRIM( tcList ) + lcSep
*** Determine the length of the required string
IF tnItem = 1
	lnStPos = 1
ELSE
	lnStPos = AT( lcSep, tcList, tnItem - 1 ) + 1
ENDIF
*** Find next separator
lnEnPos = AT( lcSep, tcList, tnItem )
IF lnEnPos = 0 OR (lnEnPos - lnStPos) = 0
	*** End of String
	lcRetVal = NULL
ELSE
    *** Extract the relevant item
	lcRetVal = SUBSTR( tcList, lnStPos, lnEnPos - lnStPos )
ENDIF
*** Return result
RETURN ALLTRIM(lcRetVal)

