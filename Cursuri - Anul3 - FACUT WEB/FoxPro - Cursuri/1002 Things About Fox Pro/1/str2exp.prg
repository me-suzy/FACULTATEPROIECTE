***********************************************************************
* Program....: STR2EXP.PRG
* Compiler...: Visual FoxPro 07.00.0000.9262 for Windows 
* Abstract...: Convert a string representation of data to the specified data type
***********************************************************************
FUNCTION Str2Exp( tcExp, tcType )
LOCAL lcExp, luRetVal, lcType, lcStr

*** Verify parameters
IF VARTYPE( tcExp ) # 'C'
	ASSERT .F. MESSAGE TRANSFORM( tcExp ) + ' is NOT a character expression and you MUST pass a character expression to Str2Exp!'
	RETURN tcExp
ENDIF
IF EMPTY( tcType )
	ASSERT .F. MESSAGE 'You MUST pass a data type to Str2Exp!'
	RETURN tcExp
ENDIF

*** If no type passed -- map to expression type
lcType = UPPER( ALLTRIM( tcType ) )
*** Remove any NULL characters, and leading/trailing spaces
lcExp = CHRTRAN( ALLTRIM( tcExp ), CHR( 0 ), '' )
*** Convert from Character to the correct type
DO CASE
  *** Integers
  CASE INLIST( lcType, 'I', 'N' ) AND INT( VAL( lcExp ) ) == VAL( lcExp ) 
    luRetVal = INT( VAL( lcExp ) )
  *** Other Numeric 
  CASE INLIST( lcType, 'N', 'B' )
    luRetVal = VAL( lcExp )
  *** Currency
  CASE lcType = "Y"
    luRetVal = NTOM( VAL( lcExp ))
  *** Character or memo
  CASE INLIST( lcType, 'C', 'M' ) 
    *** Remove delimiting marks if present.
    IF INLIST( LEFT(lcExp,1), CHR(91), CHR(34), CHR(39))
      *** We begin with a delimiter
      lcExp = SUBSTR( lcExp, 2 )
      *** So we should end with a delimiter
      IF INLIST( RIGHT(lcExp,1), CHR(93), CHR(34), CHR(39))
        lcExp = LEFT( lcExp, LEN( lcExp )- 1 )
      ENDIF
    ENDIF
    luRetVal = lcExp
  *** Logical
  CASE lcType = 'L'
    luRetVal = IIF( !EMPTY( CHRTRAN( lcExp, 'Ff0.', "" ) ), .T., .F.)
  *** Date
  CASE lcType = 'D' && Date
    *** Check for separators in the string
    IF CHRTRAN( lcExp, "/.-", "" ) == lcExp
      *** We are in yyyymmdd format
      lcStr = LEFT( lcExp, 4) + "," + SUBSTR( lcExp, 5, 2 ) + "," + RIGHT( lcExp, 2)
      luRetVal = DATE( &lcStr )
    ELSE
      *** We are in DTOC() format
      luRetVal = CTOD( lcExp )
    ENDIF
  *** DateTime
  CASE lcType = 'T' && DateTime 
    *** Check for date separators in the string
    IF CHRTRAN( lcExp, "/.-", "" ) == lcExp
      *** No separators so we have something other than TTOC() format
      IF LEN( lcExp ) > 8
        *** This one must be in yyyymmddhhmmss format
        *** So get the date part first
        lcStr = LEFT( lcExp, 4) + "," + SUBSTR( lcExp, 5, 2 ) + "," + SUBSTR( lcExp, 7, 2)
        *** and convert to the correct date string format
        lcStr = DTOC( DATE( &lcStr ))
        *** Now tack on the hours part
        lcStr = lcStr + " " + SUBSTR( lcExp, 9, 2 )
        *** Minutes
        IF LEN( lcExp ) > 10
          lcStr = lcStr + ":" + SUBSTR( lcExp, 11, 2 )
        ELSE
          lcStr = lcStr + ":00"
        ENDIF
        *** Seconds
        IF LEN( lcExp ) > 12
          lcStr = lcStr + ":" + SUBSTR( lcExp, 13, 2 )
        ELSE
          lcStr = lcStr + ":00"
        ENDIF
        luRetVal = CTOT( lcStr )
      ELSE  
        *** This must be a date in yyyymmdd format which we want to force to DateTime format
        lcStr = LEFT( lcExp, 4) + "," + SUBSTR( lcExp, 5, 2 ) + "," + RIGHT( lcExp, 2)
        luRetVal = DTOT( DATE( &lcStr )) 
      ENDIF
    ELSE
      *** We are already in TTOC() format
      luRetVal = CTOT( lcExp )
    ENDIF

  OTHERWISE
    *** We have an invalid combination of value and data type
    MESSAGEBOX( "Cannot convert " + lcExp + " to Data Type " + tcType, 16, "Conversion Failed " )
    luRetVal = lcExp
ENDCASE
*** Return value as Data Type
RETURN luRetVal
