**********************************************************************
* Program....: Tips02.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Chapter 2 generic procedure file
**********************************************************************

**********************************************************************
* Program....: GetDays
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the number of whole days in a number of seconds
**********************************************************************
FUNCTION GetDays( tnElapsedSeconds )
RETURN INT(tnElapsedSeconds / 86400)

**********************************************************************
* Program....: GetHours
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the number of whole hours (less the number of
* ...........: whole days) in a number of seconds 
**********************************************************************
FUNCTION GetHours( tnElapsedSeconds )
RETURN INT(( tnElapsedSeconds % 86400 ) / 3600 )

**********************************************************************
* Program....: GetMinutes
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the number of whole minutes (less the number of
* ...........: whole days and whole hours) in a number of seconds
**********************************************************************
FUNCTION GetMinutes( tnElapsedSeconds )
RETURN INT(( tnElapsedSeconds % 3600 ) / 60 )

**********************************************************************
* Program....: GetSeconds
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the remaining number of whole seconds remaining
* ...........: in a number of seconds after extracting days, hours, 
*............: and minutes
**********************************************************************
FUNCTION GetSeconds( tnElapsedSeconds )
RETURN INT( tnElapsedSeconds % 60 )

**********************************************************************
* Program....: GetElaspsedTime1
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the number of days, hours, minutes, and seconds
* ...........: in a total number of seconds as elements in the array
*............: property of a parameter object defined in the class 
*............: library ch02.vcx
**********************************************************************
FUNCTION GetElapsedTime1( tnElapsedSeconds )
LOCAL laTime[4]

laTime[1] = INT( tnElapsedSeconds / 86400 )
laTime[2] = INT(( tnElapsedSeconds % 86400 ) / 3600 )
laTime[3] = INT(( tnElapsedSeconds % 3600 ) / 60 )
laTime[4] = INT( tnElapsedSeconds % 60 )
RETURN CREATEOBJECT( 'xParameters', @laTime )

**********************************************************************
* Program....: GetElaspsedTime2
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the number of days, hours, minutes, and seconds
* ...........: in a total number of seconds as separate properties of
*............: a parameter object created on the fly
**********************************************************************
FUNCTION GetElapsedTime2( tnElapsedSeconds )
LOCAL loObject

*** Make sure we have the class library loaded
IF 'ch02' $ SET('CLASSLIB')
*** Do nothing...class library is loaded
ELSE
	SET CLASSLIB TO ch02 ADDITIVE
ENDIF

loObject = CREATEOBJECT( 'Line' )
WITH loObject
  .AddProperty( 'nDays', INT( tnElapsedSeconds / 86400 ) )
  .AddProperty( 'nHours', INT(( tnElapsedSeconds % 86400 ) / 3600 ) )
  .AddProperty( 'nMins', INT(( tnElapsedSeconds % 3600 ) / 60 ) )
  .AddProperty( 'nSecs', INT( tnElapsedSeconds % 60 ) )
ENDWITH

RETURN loObject

**********************************************************************
* Program....: GetElaspsedTime3
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the number of days, hours, minutes, and seconds
* ...........: in a total number of seconds as a character string
**********************************************************************
FUNCTION GetElapsedTime3( tnElapsedSeconds )
RETURN PADL( INT( tnElapsedSeconds / 86400 ), 3 )+' Days ';
  + PADL( INT(( tnElapsedSeconds % 86400 ) / 3600 ), 2, '0' )+' Hrs ' ;
  + PADL( INT(( tnElapsedSeconds % 3600 ) / 60 ), 2, '0')+' Min ' ;
  + PADL( INT( tnElapsedSeconds % 60 ), 2, '0' )+' Sec '

**********************************************************************
* Program....: DateInWords
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: When passed a date, returns a formatted string
**********************************************************************
FUNCTION DateInWords( tdDate )
LOCAL lnDay, lnNdx, lcSuffix[31]
 
*** Initialize suffix for day 
lnDay = DAY( tdDate ) 
lnNdx = lnDay % 10

IF NOT BETWEEN( lnNdx, 1, 3 )
  lcSuffix = 'th'
ELSE	
  IF INT( lnDay / 10 ) = 1
    lcSuffix = 'th'
  ELSE
    lcSuffix = SUBSTR( 'stndrd', ( 2 * lnNdx ) - 1, 2 )	
  ENDIF	
ENDIF

RETURN CDOW( tdDate ) + ', ' + CMONTH( tdDate ) + ;
  ' ' + ALLTRIM( STR( lnDay )) + lcSuffix + ;
  ', ' + ALLTRIM( STR( YEAR( tdDate )))

**********************************************************************
* Program....: CalcAge
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: When passed a birthday, return the age in years and 
* ...........: months a a formatted character string
**********************************************************************
FUNCTION CalcAge( tdDob, tdBaseDate )
*** Default Base Date to Today if empty
IF TYPE( "tdBaseDate" ) # "D" OR EMPTY(tdBaseDate)
  tdBaseDate = DATE()
ENDIF

LOCAL lnYrs, lnMth, lcRetVal, lnBaseYear, lnBaseMnth
lnYrs = YEAR( tdBaseDate ) - YEAR( tdDob )

*** Calculate this year's Birthday
ldCurBdy = DATE( YEAR( tdBaseDate ), MONTH( tdDob ), DAY( tdDob ) )

*** Calculate Age
IF ldCurBdy > tdBaseDate
  lnYrs = lnYrs - 1
  *** If the birthday is in the same month as the default base date
  *** then set the months to 11. Otherwise, subtract the base date's 
  *** month from the date of birth's month.
  IF MONTH( tdDob ) = MONTH( tdBaseDate )
    lnMth = 11
  ELSE
    lnMth = 12 - ( MONTH( tdDob ) - MONTH( tdBaseDate ) )
  ENDIF
ELSE
  lnMth = MONTH( tdBaseDate ) - MONTH( tdDob )
ENDIF

*** Format Output String
lcRetVal = PADL( lnYrs, 4 ) + " Years, " + PADL( lnMth, 2, '0' ) + " Month" + ;
  IIF( lnMth = 1, "", "s" )
RETURN ALLTRIM( lcRetVal )

**********************************************************************
* Program....: nthSomeDayOfMonth
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the date of a specific type of day; e.g., the
* ...........: second Tuesday in November of the year 2001
* ...........: nthSomedayOfMonth( 4, 3, 7, 2000 ) returns the date of
* ...........: the 3rd Wednesday in July of the year 2000
* Parameters.: tnDayNum: Day number 1=Sunday 7=Saturday
* ...........: tnWhich : Which one to find; 1st, 2nd, etc. 
* ...........:           If tnwhich > the number of this kind of day 
* ...........:           in the month, the last one is returned
* ...........: tnMonth : Month Number in which to find the day
* ...........: tnYear  : Year in which to find the day
**********************************************************************
FUNCTION nthSomedayOfMonth( tnDayNum, tnWhich, tnMonth, tnYear )
LOCAL ldDate, lnCnt

*** Start at the first day of the specified month
ldDate = DATE( tnYear, tnMonth, 01 )

*** Find the first one of the specified day of the week
DO WHILE DOW( ldDate ) # tnDayNum
	ldDate = ldDate + 1
ENDDO

*** Find the specified one of these...e.g, 2nd, 3rd, or last
IF tnWhich > 1
  lnCnt = 1
  DO WHILE lnCnt < tnWhich
    lnCnt = lnCnt + 1
    *** Move forward one week to get the next one of these in the month	
    ldDate = ldDate + 7
    *** Are we are still in the correct month?
    IF MONTH( ldDate ) # tnMonth
      *** If not, jump back to the last one of these we found and exit
      ldDate = ldDate - 7
      EXIT
    ENDIF
  ENDDO
ENDIF

RETURN ldDate

**********************************************************************
* Program....: MonthlySchedule
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Given a seed date and a number of months, returns a
* ...........: parameter object whose array property contains all the
* ...........: payment dates for the next n months         
**********************************************************************
FUNCTION MonthlySchedule ( tdStartDate, tnNumberOfMonths )
LOCAL laDates[1], lnCnt, ldDate, llOK, llUsed 

*** Make sure we have the class library loaded
IF 'Ch02' $ SET( 'CLASSLIB' )
*** Do nothing...class library is loaded
ELSE
  SET CLASSLIB TO Ch02 ADDITIVE
ENDIF
	
*** Make sure we have the Holidays table available
IF !USED( 'Holidays' )	
  USE Holidays In 0
  llUsed = .F.
ELSE
  llUsed = .T.
ENDIF
SELECT Holidays
SET ORDER TO dHoliday
			
FOR lnCnt = 1 TO tnNumberOfMonths
  *** we want to return the passed date as date[1]
  IF lnCnt > 1
    ldDate = GOMONTH( tdStartDate, lnCnt-1 )
  ELSE
    ldDate = tdStartDate
  ENDIF		
  *** Now we have to check to be sure that GoMonth didn't give us back a day 
  *** that is earlier than the seed date...can't do a direct debit BEFORE the
  *** specified date i.e., the 28th of the month
  IF DAY(tdStartDate) > 28
    IF BETWEEN( DAY( ldDate ),  28, DAY( tdStartDate ) - 1 )
      ldDate = ldDate + 1
    ENDIF	
  ENDIF
  llOK = .F.
  DO WHILE !llOK
    *** If current date is a Saturday, go to Monday
    IF DOW( ldDate ) = 7
      ldDate = ldDate + 2
    ELSE
      *** If current date is a Sunday, go to Monday
      IF DOW( ldDate ) = 1
        ldDate = ldDate + 1
      ENDIF
    ENDIF
    *** OK, now check for Holidays
    IF !SEEK( ldDate, 'Holidays', 'dHoliday' )
      llOK = .T.
    ELSE
      ldDate = ldDate + 1
    ENDIF
  ENDDO
  DIMENSION laDates[lnCnt]
  laDates[lnCnt] = ldDate
ENDFOR

IF !llUsed
  USE IN Holidays
ENDIF
	
RETURN CREATEOBJECT( 'xParameters', @laDates )

**********************************************************************
* Program....: BusinessDays
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Given a start date and a number of days, returns the 
* ...........: date that is that number of days in the future
**********************************************************************
FUNCTION BusinessDays ( tdStartDate, tnNumberOfDays )
LOCAL lnCnt, ldDate, llOK, llUsed 

*** Make sure we have the Holidays table available
IF !USED( 'Holidays' )	
  USE Holidays In 0
  llUsed = .F.
ELSE
  llUsed = .T.
ENDIF
SELECT Holidays
SET ORDER TO dHoliday

ldDate = tdStartDate			
FOR lnCnt = 1 TO tnNumberOfDays
  ldDate = ldDate + 1
  llOK = .F.
  DO WHILE !llOK
    *** If current date is a Saturday, go to Monday
    IF DOW( ldDate ) = 7
      ldDate = ldDate + 2
    ELSE
      *** If current date is a Sunday, go to Monday
      IF DOW( ldDate ) = 1
        ldDate = ldDate + 1
      ENDIF
    ENDIF
    *** OK, now check for Holidays
    IF !SEEK( ldDate, 'Holidays', 'dHoliday' )
      llOK = .T.
    ELSE
      ldDate = ldDate + 1
    ENDIF
  ENDDO
ENDFOR

IF !llUsed
  USE IN Holidays
ENDIF
	
RETURN ldDate

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
*** If no type passed -- display error message
*** the procedure is not clairvoyant
IF TYPE( 'tcType' ) = 'C'
	lcType = UPPER( ALLTRIM( tcType ) )
ELSE
	*** Type is a required parameter. Let the developer know
	ERROR 'Missing Parameter: Expression type is a required parameter to Str2Exp'
ENDIF
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
* Program....: Exp2Str
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
RETURN LEN( CHRTRAN( UPPER( tcString ), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "" ) ) ;
  # LEN( tcString )

**********************************************************************
* Program....: NumToStr
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Convert number into a text string
* Notes......: Handles Numbers up to 99,999,999 and will accommodate
* ...........: negative numbers.  Decimals are rounded to Two Places
* ...........: And returned as 'and xxxx hundredths'
************************************************************************
FUNCTION NumToStr
LPARAMETERS tnvalue
LOCAL lnHund, lnThou, lnHTho, lnMill, lnInt, lnDec
LOCAL llDecFlag, llHFlag, llTFlag, llMFlag, llNegFlag
LOCAL lcRetVal

*** Evaluate Parameters
DO CASE
	CASE TYPE('tnValue') # 'N'
		RETURN('')
	CASE tnvalue = 0
		RETURN 'Zero'
	CASE tnvalue < 0
		llNegFlag = .T.
		tnvalue = ABS(tnvalue)
	OTHERWISE
		llNegFlag = .F.
ENDCASE

*** Initialise Variables
STORE .F. TO llHFlag,llTFlag,llMFlag
STORE 0 TO lnHund, lnThou, lnMill
STORE "" TO lcRetVal
lnInt = INT(tnvalue)					&& Integer Portion

*** Check for Decimals
IF MOD( tnValue, 1) # 0					&& We Have Decimals
	lnDec = ROUND(MOD(tnvalue,1),2)		&& Decimals Portion
	llDecFlag = .T.
ELSE
	llDecFlag = .F.
ENDIF

*** Do the Integer Portion
DO WHILE .T.
	DO CASE
		CASE lnInt < 100			&& TENS
			IF EMPTY(lcRetVal)
				lcRetVal = lcRetVal + ALLTRIM(con_tens(lnInt))
			ELSE
				IF RIGHT(lcRetVal,5)#" and "
					lcRetVal = lcRetVal+' and '
				ENDIF	
				lcRetVal = lcRetVal + ALLTRIM(con_tens(lnInt))
			ENDIF
		CASE lnInt < 1000			&& HUNDREDS
			lnHund = INT(lnInt/100)
			lnInt = lnInt - (lnHund*100)
			lcRetVal = lcRetVal + ALLTRIM(con_tens(lnHund)) + " Hundred"
			IF lnInt # 0
				lcRetVal = lcRetVal+" and "
				LOOP
			ENDIF
		CASE lnInt < 100000			&& THOUSANDS
			lnThou = INT(lnInt/1000)
			lnInt = lnInt - (lnThou*1000)
			lcRetVal = lcRetVal + ALLTRIM(con_tens(lnThou)) + " Thousand"
			IF lnInt # 0
				lcRetVal = lcRetVal + " "
				LOOP
			ENDIF
		CASE lnInt < 1000000		&& Hundred Thousands
			lnHTho = INT(lnInt/100000)
			lnInt = lnInt - (lnHTho * 100000)
			lcRetVal = lcRetVal + ALLTRIM(con_tens(lnHTho)) + " Hundred"
			IF lnInt # 0
				lcRetVal = lcRetVal + " and "
				LOOP
			ELSE
				lcRetVal = lcRetVal + " Thousand"
			ENDIF
		CASE lnInt < 100000000		&& Millions
			lnMill = INT(lnInt/1000000)
			lnInt = lnInt - (lnMill * 1000000)
			lcRetVal = lcRetVal + ALLTRIM(con_tens(lnMill)) + " Million"
			IF lnInt # 0
				lcRetVal = lcRetVal + ", "
				LOOP
			ENDIF
	ENDCASE
	EXIT
ENDDO

*** Handle Decimals
IF llDecFlag
	lnDec = lnDec * 100
	lcRetVal = lcRetVal + " and " + ALLTRIM(con_tens(lnDec)) + ' Hundredths'
ENDIF

*** Handle Negative Numbers
IF llNegFlag
	lcRetVal = "[MINUS " + ALLTRIM(lcRetVal) + "]"
ENDIF
RETURN lcRetVal

***********************************************
*** Sub Function for NumToStr: Handle the TENS
***********************************************
FUNCTION Con_Tens
LPARAMETERS tndvalue
LOCAL lcStrVal, lcStrTeen
STORE '' TO lcStrVal,lcStrTeen
DO CASE
	CASE tnDValue < 20
		RETURN(con_teens(tnDValue))
	CASE tnDValue < 30
		lcStrVal = 'Twenty'
		tnDValue = tnDValue - 20
	CASE tnDValue < 40
		lcStrVal = 'Thirty'
		tnDValue = tnDValue - 30
	CASE tnDValue < 50
		lcStrVal = 'Forty'
		tnDValue = tnDValue - 40
	CASE tnDValue < 60
		lcStrVal = 'Fifty'
		tnDValue = tnDValue - 50
	CASE tnDValue < 70
		lcStrVal = 'Sixty'
		tnDValue = tnDValue - 60
	CASE tnDValue < 80
		lcStrVal = 'Seventy'
		tnDValue = tnDValue - 70
	CASE tnDValue < 90
		lcStrVal = 'Eighty'
		tnDValue = tnDValue - 80
	CASE tnDValue < 100
		lcStrVal = 'Ninety'
		tnDValue = tnDValue - 90
ENDCASE
lcStrTeen = con_teens(tnDValue)
IF LEN(lcStrTeen) # 0           && there was something there
	lcStrVal = lcStrVal + '-' + lcStrTeen
ENDIF
RETURN TRIM(lcStrVal)

***********************************************
*** Sub Function for NumToStr: Handle the Units/Teens
***********************************************
FUNCTION Con_Teens
LPARAMETERS tntvalue
DO CASE
	CASE tntvalue = 0
		RETURN('')
	CASE tntvalue = 1
		RETURN('One ')
	CASE tntvalue = 2
		RETURN('Two ')
	CASE tntvalue = 3
		RETURN('Three ')
	CASE tntvalue = 4
		RETURN('Four ')
	CASE tntvalue = 5
		RETURN('Five ')
	CASE tntvalue = 6
		RETURN('Six ')
	CASE tntvalue = 7
		RETURN('Seven ')
	CASE tntvalue = 8
		RETURN('Eight ')
	CASE tntvalue = 9
		RETURN('Nine ')
	CASE tntvalue = 10
		RETURN('Ten ')
	CASE tntvalue = 11
		RETURN('Eleven ')
	CASE tntvalue = 12
		RETURN('Twelve ')
	CASE tntvalue = 13
		RETURN('Thirteen ')
	CASE tntvalue = 14
		RETURN('Fourteen ')
	CASE tntvalue = 15
		RETURN('Fifteen ')
	CASE tntvalue = 16
		RETURN('Sixteen ')
	CASE tntvalue = 17
		RETURN('Seventeen ')
	CASE tntvalue = 18
		RETURN('Eighteen ')
	CASE tntvalue = 19
		RETURN('Nineteen ')
ENDCASE

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

**********************************************************************
* Program....: AEnCode
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Encrypt a Password
**********************************************************************
FUNCTION AEnCode(tcKeyWord)
LOCAL lcRaw, lnVar, lcEnc
IF TYPE('tcKeyWord') # "C" OR EMPTY(tcKeyWord)
	*** Must pass a character key to this process
    ERROR( "9000: A Character string is the required parameter for AEnCode" )
	RETURN ""
ENDIF	
lcRaw = UPPER(ALLTRIM(tcKeyWord))	&& Keyword
lnVar = INT(RAND() * 10)			&& Random Number Key: 0 - 9
lcEnc = ALLTRIM(STR(lnVar))			&& Encrypted string starts with key #
*** Parse the Keyword and encrypt each character
*** Using its ASCII code + 17 + Random Key + Position in Keyword
FOR lnCnt = 1 TO LEN(lcRaw)
	lcChar = SUBSTR(lcRaw, lnCnt,1)
	lcEnc = lcEnc + CHR( ASC(lcChar) + 17 + lnVar + lnCnt + 1)
NEXT
RETURN lcEnc	

**********************************************************************
* Program....: ADeCode
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Decodes a password encrypted with AEnCode()
**********************************************************************
FUNCTION ADeCode(tcKeyWord)
LOCAL lcRaw, lnVar, lcEnc
IF TYPE('tcKeyWord') # "C" OR EMPTY(tcKeyWord)
	*** Must pass a character key to this process
    ERROR( "9000: An Encrypted string is the required parameter for ADeCode" )
	RETURN ""
ENDIF	
lcEnc = ALLTRIM(tcKeyWord)			&& Keyword
lnVar = VAL(LEFT(lcEnc,1))			&& Encryption Key
lcRaw = ""							&& Decoded Password
*** Parse the Keyword and decrypt each character
*** Using its ASCII code + 17 + Random Key + Position in Keyword
FOR lnCnt = 2 TO LEN(lcEnc)
	lcChar = SUBSTR(lcEnc, lnCnt, 1)
	lcRaw = lcRaw + CHR( ASC(lcChar) - (17 + lnVar + lnCnt) )
NEXT
RETURN lcRaw

**********************************************************************
* Program....: GoSafe.PRG
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Wrapper around the GOTO command
**********************************************************************
FUNCTION GoSafe( tnRecNum, tcAlias, tlShoMsg )
LOCAL ARRAY laErrs[1]
LOCAL lcAlias, lnCount, lnCurRec, lnErrCnt, lLRetVal
*** Check parameter is numeric and valid
IF VARTYPE( tnRecNum ) # "N" OR EMPTY( tnRecNum )
    ERROR "9000: A valid numeric parameter must be passed to GoSafe()"
    RETURN .F.
ENDIF
*** Default alias to current alias if not specified
IF VARTYPE( tcAlias) #"C" OR EMPTY( tcAlias )
    lcAlias = ALIAS()
ELSE
    lcAlias = UPPER( ALLTRIM( tcAlias ))
ENDIF
*** Check that we have got the specified Alias
IF EMPTY( lcAlias ) OR ! USED( lcAlias )
    ERROR "GoSafe: No table was specified or the specified table is not open"
    RETURN .F.
ENDIF
*** Get Max No records and the currently selected
*** record number in the specified alias
lnCount = RECCOUNT( lcAlias )

IF lnCount < 1
    RETURN .F.
ELSE
    lnCurRec = RECNO( lcAlias )
ENDIF    
*** Save Error handling and turn off error trapping for now
lcOldError = ON("ERROR")
ON ERROR *
*** Now try and GO to the required record
GOTO tnRecNum IN (lcAlias)
*** Did we succeed?
IF RECNO( lcAlias ) # tnRecNum 
    *** Check for Errors
    lnErrCnt = AERROR( laErrs )
    IF lnErrCnt > 0 AND tlShoMsg
        DO CASE
            CASE laErrs[1,1] = 5
                *** Record Out of Range
                lcErrTxt = 'Record Number ' + ALLTRIM(PADL(tnRecNum, 32)) ;
                            + ' is not available in Alias: ' + lcAlias
            CASE laErrs[1,1] = 20
                *** Record Not in Index
                lcErrTxt = 'Record Number ' + ALLTRIM(PADL(tnRecNum, 32)) ;
                            + ' is not in the Index for Alias: ' + lcAlias ;
                            + CHR(13) + 'Table needs to be Re-Indexed'
            OTHERWISE
                *** An unexpected error
                lcErrTxt = 'An unexpected error prevented the GOTO succeeding'
        ENDCASE
        MESSAGEBOX( lcErrTxt, 16, 'Command Failed' )
    ENDIF
    *** Restore the original record
    GOTO lnCurRec IN (lcAlias)    
    llRetVal = .F.
ELSE
    llRetVal = .T.
ENDIF
*** Restore Error Handler
ON ERROR &lcOldError
RETURN llRetVal

