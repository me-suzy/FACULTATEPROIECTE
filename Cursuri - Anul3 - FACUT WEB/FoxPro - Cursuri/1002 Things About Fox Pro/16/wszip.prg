***********************************************************************
* Program....: WSZIP.PRG
* Author.....: Andy Kramek
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: ZipCode Component suitable for exposing as a Web Service
* Interface..: ISZIPVALID( <cZip> ) 
* ...........:           Returns -1 (Error), 0 (Invalid), 1 (Valid)
* ...........: GETZIPLINE( <cZip> )
* ...........:           Returns [<City>,<State>,<Zip>] for Valid Zipcodes
* ...........: GETZIPLOCN( <cZip> )
* ...........:           Returns [<Lat/Long>] for Valid Zipcodes
* ...........: GETZIPAREACODE( <cZip> )
* ...........:           Returns [<AreaCode> (<TimeZone>)] for Valid Zipcodes
* ...........: GETZIPFORCITY( <cCity>[, <cState>] )
* ...........:           Returns XML stream with all results for City or City/state
***********************************************************************
DEFINE CLASS xZipCodes AS combase OLEPUBLIC
  *** Set the name of the Error Table to Use
  cErrTable = "ZipErrors"
  *** Stores the physical path to the Data 
  cDataDir = ""

  ********************************************************************
  *** [E] ISZIPVALID(): Check Zip; Returns 1 = OK, 0 = Invalid, -1 = Error
  ********************************************************************
  FUNCTION IsZipValid( tcZipCode AS String ) AS Integer
  LOCAL lnRetVal
    WITH This
      *** Did we get a String Parameter?
      IF NOT .ValidateZip( tcZipCode )
        lnRetVal = -1
      ELSE
        *** All right we got a non-empty String, so can we find it in the ZipCode table
        lnRetVal = IIF( SEEK( tcZipCode, 'zipcodes', 'czipcode' ), 1, 0 )
      ENDIF
      *** Just return the result
      RETURN lnRetVal
    ENDWITH  
  ENDFUNC

  ********************************************************************
  *** [E] GETZIPLINE(): Returns City, State, Zip address line for a valid zip code
  ********************************************************************
  FUNCTION GetZipLine( tcZipCode AS String ) AS String
  LOCAL lcRetVal
    WITH This
      *** Did we get a String Parameter?
      IF NOT .ValidateZip( tcZipCode )
        lcRetVal = ""
      ELSE
        *** All right we got a non-empty String, so can we find it in the ZipCode table
        IF SEEK( tcZipCode, 'zipcodes', 'czipcode' )
          lcRetVal = ALLTRIM( zipcodes.czipcity ) + ", " ;
                   + UPPER( zipcodes.czipstate ) + ", " ;
                   + ALLTRIM( zipcodes.czipcode)
        ELSE
          lcRetVal = ""
        ENDIF
      ENDIF
      *** Just return the result
      RETURN lcRetVal    
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [E] GETZIPLOCN(): Returns Lat/Long for a valid zip code
  ********************************************************************
  FUNCTION GetZipLocn( tcZipCode AS String ) AS String
  LOCAL lcRetVal
    WITH This
      *** Did we get a String Parameter?
      IF NOT .ValidateZip( tcZipCode )
        lcRetVal = ""
      ELSE
        *** All right we got a non-empty String, so can we find it in the ZipCode table
        IF SEEK( tcZipCode, 'zipcodes', 'czipcode' )
          lcRetVal = ALLTRIM( zipcodes.cziplat) + " " ;
                   + ALLTRIM( zipcodes.cziplong)
        ELSE
          lcRetVal = ""
        ENDIF
      ENDIF
      *** Just return the result
      RETURN lcRetVal    
    ENDWITH
  ENDFUNC
  
  ********************************************************************
  *** [E] GETZIPAREACODE(): Return Area Code/TimeZone for a valid ZipCode
  ********************************************************************
  FUNCTION GetZipAreaCode(tcZipCode AS String) AS String
  LOCAL lcRetVal
    WITH This
      *** Did we get a String Parameter?
      IF NOT .ValidateZip( tcZipCode )
        lcRetVal = ""
      ELSE
        *** All right we got a non-empty String, so can we find it in the ZipCode table
        IF SEEK( tcZipCode, 'zipcodes', 'czipcode' )
          lcZone  = ALLTRIM( zipcodes.cTimeZone )
          lcZName = " (" + lcZone + IIF( lcZone = "+4", ' Atlantic', ;
                                        IIF( lcZone = '+5', ' Eastern', ;
                                        IIF( lcZone = '+6', ' Central', ;
                                        IIF( lcZone = '+7', ' Mountain', ;
                                        IIF( lcZone = '+8', ' Pacific', '')))))
          lcRetVal = ALLTRIM( zipcodes.careacode ) ;
                   + IIF( EMPTY( lcZName ), " (Zone GMT " + lcZone + ")", lcZName + " Standard Time)")
        ELSE
          lcRetVal = ""
        ENDIF
      ENDIF
      *** Just return the result
      RETURN lcRetVal    
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [E] GETZIPFORCITY(): Return the zip code for the specified city/State if found
  ********************************************************************
  FUNCTION GetZipForCity(tcCity AS String, tcState AS String) AS String
  LOCAL lcRetVal, lcState, lcCity , lcWhere
    lcRetVal = ""
    WITH This
      *** Did we get a State?
      IF NOT .ValidateParam( tcState, "C" ) OR EMPTY( tcState )
        lcState = ""
      ELSE
        lcState = UPPER(ALLTRIM( tcState )) 
      ENDIF
      *** Did we get a City?
      IF NOT .ValidateParam( tcCity, "C" ) OR EMPTY( tcCity )
        lcCity = ""
      ELSE
        lcCity = UPPER(ALLTRIM( tcCity )) 
      ENDIF
      *** What do we have? Build a WHERE clause for the SQL
      lcWhere = IIF( NOT EMPTY( lcCity ), "UPPER( czipcity ) == lcCity", "" )
      lcWhere = lcWhere + IIF( NOT EMPTY( lcState ), " AND UPPER( czipstate ) == lcState", "" )
      IF NOT EMPTY( lcWhere )
        *** Get all candidate results
        SELECT czipcity, czipstate, czipcode ;
          FROM zipcodes ;
         WHERE &lcWhere ;
          INTO CURSOR curres
        *** Did we get anything?
        IF _TALLY > 0
          *** Dump reesults as XML
          CURSORTOXML( "curres", "lcRetVal" )
        ENDIF
      ENDIF
      *** Just return the result
      RETURN lcRetVal    
    ENDWITH
  ENDFUNC
  
  ********************************************************************
  *** [E] INIT(): Attempts to open zip table
  ********************************************************************
  FUNCTION Init()
    WITH This
      *** Open the ErrorLog Table
      DODEFAULT()
      *** And try to open the ZipCodes Table
      *** If it fails an error will be logged anyway
      This.SetUpData()
      *** We are running in a Private Data Session and need EXACT = ON
      *** For searches in this case, otherwise 729 = "729xx"
      SET EXACT ON
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] SETUPDATA(): Open Local copy of the ZipCode Table
  ********************************************************************
  PROTECTED FUNCTION SetUpData()
    LOCAL llOk, lcPath
    *** We need to get the path....
    IF "DLL" $ UPPER(_VFP.ServerName)
      *** Running as a Web Service
      lcPath = JUSTPATH(_VFP.ServerName )
    ELSE
      *** Running as a VFP Class
      lcPath = FULLPATH( CURDIR() )
    ENDIF
    *** Now we can open it
    WITH This
      *** Set the Directory property
      .cDataDir = lcPath
      llOK = .OpenLocalTable( "zipcodes", 3 )
      RETURN llOk
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] VALIDATEZIP(): Check that ZipCode table is available and
  ***                  : the Parameter is not an empty string
  ********************************************************************
  PROTECTED FUNCTION ValidateZip( tcZipCode )
  LOCAL llRetVal
    WITH This
      *** Is the ZipCode Table open
      IF NOT .SetUpData()
        RETURN llRetVal
      ENDIF
      *** Did we get a String Parameter?
      IF NOT .ValidateParam( tcZipCode, "C" )
        *** Log the error and exit
        .LogError( 9002, "String Expected", PROGRAM() )
        RETURN llRetVal
      ENDIF
      *** OK, it was a character String, but was it empty?
      IF EMPTY( tcZipCode )
        *** Log the error and exit
        .LogError( 9002, "Must pass Zipcode as a non-empty String", PROGRAM() )
      ELSE
        llRetVal = .T.
      ENDIF
      RETURN llRetVal
    ENDWITH
  ENDFUNC

ENDDEFINE
