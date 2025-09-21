***********************************************************************
* Program....: DSNMGR.PRG
* Author.....: Andy Kramek
* Date.......: 21 November 2001
* Purpose....: DSN Manager Class Definition
***********************************************************************
DEFINE CLASS dsnmgr AS Session

  *** Give it a Private Datasession
  DataSession = 2
  *** An Error Collection
  DIMENSION aErrors[1] 
  *** And a reference to Registry Manager
  PROTECTED oReg
  oReg = NULL
  
  ********************************************************************
  *** [E] INIT(): Native Initialization Method
  ********************************************************************
  FUNCTION Init()
  LOCAL llRetVal
  WITH This
    *** Open lookup tables first
    llRetVal = .OpenLocalTables()
    IF llRetVal
      *** Set up associated procedure files
      llRetVal = .SetProcFiles()
    ENDIF
    IF llRetVal
      *** Instantiate the Registry Manager with (2) -> HKEY_LOCAL_MACHINE
      .oReg = NEWOBJECT( 'RegMgr', 'regmgr.prg', NULL, 2 )
      llRetVal = VARTYPE( .oReg ) = "O"
    ENDIF
    RETURN llRetVal
  ENDWITH
  ENDFUNC

  ********************************************************************
  *** [E] ISCONNVALID(): Check that a connection is defined and ensure the DSN is in place
  ********************************************************************
  FUNCTION IsConnValid( tcConnName, tlNoCreate)
  LOCAL lnOldDs, llRetVal, lcMsg, lnStatus
    llRetVal = .T.
    WITH This
      *** Connection name must be a Character String
      llRetVal = .ValidateParam( tcConnName, 'C' )
      IF NOT llRetVal           
        *** Invalid Connection name, return immediately
        RETURN llRetVal
      ENDIF
      *** Next see if we have the Connection Details
      lnOldDS = SET( 'DataSession' )
      SET DATASESSION TO .DataSessionId
      SET EXACT ON
      llRetVal = SEEK( UPPER( ALLTRIM( tcConnName )), 'dsnconn', 'cconname' )
      SET EXACT OFF
      IF llRetVal           
        *** Next get the DSN name and check to see if it exists
        lnStatus = .CheckDSN( dsnconn.cConDSN )
        IF lnStatus = 1
          *** DSN Exists, all is good
          llRetVal = .T.
        ELSE
          IF lnStatus = 0
            *** DSN does not exist, should we try and create it?
            IF ! EMPTY( tlNoCreate )
              *** Nope! We've been told not to so bale out here
              llRetVal = .F.
            ELSE
              *** Try and create the DSN
              llRetVal = .MakeDsn( dsnconn.cConDSN )
            ENDIF
          ELSE
            *** There was an error - which will have been logged already
            llRetVal = .F.
          ENDIF
        ENDIF
      ELSE
        *** Connection name not defined
        .LogError( "DSNMgr02", "Connection " + tcConnName + " not defined in DSNConn.dbf", PROGRAM() )
        llRetVal = .F.
      ENDIF
      SET DATASESSION TO lnOldDS
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] MAKEDSN(): Create an entry in the Registry for the DSN 
  *** if the settings can be located in DSNSetup.dbf and the driver
  *** is installed on the local machine.
  ********************************************************************
  PROTECTED FUNCTION MakeDSN(tcDSNName)
  LOCAL llRetVal, lcMsg, lcDSN, lcDriver
    lcDSN = UPPER( ALLTRIM( tcDSNName))
    WITH This
      *** Have we got settings for this DSN defined?
      SET EXACT ON
      llRetVal = SEEK( lcDSN, 'dsnsetup', 'cdsnname' )
      SET EXACT OFF
      IF NOT llRetVal
        *** No set up defined, so not much more we can do here
        lcMsg = "Cannot create DSN: no settings defined for " + lcDSN
        .LogError( "DSNMgr05", lcMsg, PROGRAM() )
        RETURN llRetVal
      ENDIF
      *** OK, now we need the file name for the specified driver - and to check that it is installed
      lcDriver = .GetDriverFile( ALLTRIM( dsnsetup.cdsndriver ) )
      llRetVal = NOT EMPTY( lcDriver)
      IF llRetVal
        *** Create a parameter object for the DSN Definition
        loDSNDef = CREATEOBJECT( 'line' )
        WITH loDSNDef
          .AddProperty( 'cDSN', lcDSN )
          .AddProperty( 'cDesc', ALLTRIM( dsnsetup.cdsndesc ) )
          .AddProperty( 'cDatabase', ALLTRIM( dsnsetup.cdsndbase ) )
          .AddProperty( 'cServer', ALLTRIM( dsnsetup.cdsnserver ) )
          .AddProperty( 'cDriver', ALLTRIM( dsnsetup.cdsndriver ) )
          .AddProperty( 'cDFile', ALLTRIM( lcDriver ) )
        ENDWITH
        llRetVal = .WriteDSN( loDSNDef )
      ENDIF
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] WRITEDSN(): Create the registry entries for a new DSN
  ********************************************************************
  PROTECTED FUNCTION WriteDSN( toDSNDef )
  LOCAL llRetVal, lcName, lcDatabase, lcDriver, lcServer, lcDescrip, lnStatus, lcMsg
    llRetVal = .T.
    *** Unpack the parameter object
    WITH toDSNDef
      lcName     = ALLTRIM( .cDSN )
      lcDatabase = ALLTRIM( .cDatabase )
      lcDriver   = ALLTRIM( .cDriver )
      lcDFile    = ALLTRIM( .cDFile )
      lcServer   = ALLTRIM( .cServer )
      lcDescrip  = ALLTRIM( .cDesc )
    ENDWITH
    WITH This.oReg
      *** Create the Key (Last param allows creation if not already present)
      lnStatus = .OpenKey( 'SOFTWARE\ODBC\ODBC.INI\' + lcName , .nUserKey, .T. )
      IF lnStatus # 0
        lcMsg = "Cannot open, or create, Registry Key: " + 'SOFTWARE\ODBC\ODBC.INI\' + lcName
        This.LogError( "DSNMgr09", lcMsg, PROGRAM() )
        llRetVal = .F.
      ELSE
        *** Add the lower level keys
        lnKey = .nCurrentKey
        lnStatus = IIF( lnStatus = 0, .SetKeyValue( 'Database', lcDatabase ), lnStatus)
        lnStatus = IIF( lnStatus = 0, .SetKeyValue( 'Driver', lcDFile ), lnStatus)
        lnStatus = IIF( lnStatus = 0, .SetKeyValue( 'Server', lcServer ), lnStatus)
        lnStatus = IIF( lnStatus = 0, .SetKeyValue( 'Description', lcDescrip), lnStatus)
        llRetVal = (lnStatus = 0)
      ENDIF
      IF llRetVal
        *** Add the entry to put the DSN Into the ODBC Administrator too
        lnStatus = .OpenKey( 'SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources', .nUserKey, .T. )
        IF lnStatus # 0
          lcMsg = "Cannot Write DSN Details to Registry "
          This.LogError( "DSNMgr10", lcMsg, PROGRAM() )
          llRetVal = .F.
        ELSE
          *** Add the detail key
          lnKey = .nCurrentKey
          lnStatus = IIF( lnStatus = 0, .SetKeyValue( lcName, lcDriver ), lnStatus)
          llRetVal = (lnStatus = 0)
        ENDIF
      ENDIF
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] GETDRIVERFILE(): Check the specified driver is installed, 
  *** and if so, return the path/filename for the driver file
  ********************************************************************
  PROTECTED FUNCTION GetDriverFile( tcDriverName )
  LOCAL ARRAY laSettings[1]
  LOCAL lcRetVal, lnOK, lcMsg
    lcRetVal = ""
    WITH This.oReg
      *** Open the key (Sets property on Reg Mgr)
      lnOK = .OpenKey(  'SOFTWARE\ODBC\ODBCINST.INI\' + tcDriverName, .nUserKey )
      IF lnOK = 0
        *** Get the list of defined DSNs
        lnOK = .enumkeyvalues( @laSettings )
        *** And close the Key (good practice!)
        .CloseKey()
      ELSE
        *** This is an error condition, so bale out straight away
        lcMsg = "Could not open Registry Key 'SOFTWARE\ODBC\ODBCINST.INI\' + tcDriverName"
        This.LogError( "DSNMGR07", lcMsg, PROGRAM() )
        RETURN lcRetVal
      ENDIF
      IF lnOK = 0
        *** If we got a list back, check it: Case Insensitive; Return row number; Exact ON
        lnOK = ASCAN( laSettings, 'Driver', 1, 0, 1, 15 )
        *** Do we have the DSN defined already?
        lcRetVal = IIF( lnOK > 0, ALLTRIM( laSettings[ lnOk,2] ), "" )
      ELSE
        *** We got an error here too
        lcMsg = "Could not retrieve settings for 'SOFTWARE\ODBC\ODBCINST.INI\'" + tcDriverName
        This.LogError( "DSNMGR08", lcMsg, PROGRAM() )
      ENDIF
      RETURN lcRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] CHECKDSN(): Check Registry for specified DSN Name
  *** Return Value is numeric:
  ***     -1 = Error
  ***      0 = DSN does not exist
  ***      1 = DSN exists
  ********************************************************************
  PROTECTED FUNCTION CheckDSN(tcDSNName)
  LOCAL ARRAY laDSNs[1]
  LOCAL lnRetVal, lnOK, lcMsg
    WITH This.oReg 
      *** Open the key (Sets property on Reg Mgr)
      lnOK = .OpenKey(  'SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources', .nUserKey )
      IF lnOK = 0
        *** Get the list of defined DSNs
        lnOK = .enumkeyvalues( @laDSNs )
        *** And close the Key (good practice!)
        .CloseKey()
      ELSE
        *** This is an error condition, so bale out straight away
        lcMsg = "Could not open Registry Key 'SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources'"
        This.LogError( "DSNMGR03", lcMsg, PROGRAM() )
        RETURN -1
      ENDIF
      IF lnOK = 0
        *** If we got a list back, check it: Case Insensitive; Return row number; Exact ON
        lnOK = ASCAN( laDSNs, ALLTRIM( tcDSNName ), 1, 0, 1, 15 )
        *** Do we have the DSN defined already?
        lnRetVal = IIF( lnOK > 0, 1, 0 )
      ELSE
        *** We got an error here too
        lcMsg = "Could not retrieve values for 'SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources'"
        This.LogError( "DSNMGR04", lcMsg, PROGRAM() )
        lnRetVal = -1
      ENDIF
      RETURN lnRetVal
    ENDWITH
  ENDFUNC

  *******************************************************************
  *** [P] VALIDATEPARAM(): Check that a value has the specified type
  *** Logs an error and returns .F. if not
  *******************************************************************
  PROTECTED FUNCTION ValidateParam( tuTestParm, tuReqType )
    LOCAL llRetVal, lcCallBy, lcMsg
    *** See who called us!
    lcCallBy = PROGRAM( PROGRAM(-1) -1 )
    llRetVal = .T.
    *** If not an object
    IF tuReqType # "O"
      *** Check for Type Only - program must handle EMPTY() values itself
      IF VARTYPE( tuTestParm ) # UPPER( tuReqType )
        lcMsg = 'Invalid Parameter Passed to '
        llRetVal = .F.
      ENDIF
    ELSE
      *** It is an object so, check For both Type and ISNULL()
      IF VARTYPE( tuTestParm ) # "O" OR ISNULL( tuTestParm )
         lcMsg = 'Invalid Object Reference Passed to '
         llRetVal = .F.
      ENDIF
    ENDIF
    IF NOT llRetVal
      *** Log the Error
      This.LogError( "DSNMgr01", lcMsg, lcCallBy )
      *** If in Dev Mode give the developer a message
      ASSERT .F. MESSAGE lcMsg + lcCallBy
    ENDIF
    *** Return Result
    RETURN llRetVal  
  ENDFUNC

  *******************************************************************
  *** [E] ERROR(): Define the Error Method
  *** Add the error to the internal errors array
  *******************************************************************
  FUNCTION Error( nError, cMethod, nLine )
    IF VERSION( 2 ) = 0
      *** We are in 
      SET STEP ON
    ENDIF
    *** But still log the error anyway
    This.LogError( nError, MESSAGE(), cMethod )
    RETURN
  ENDFUNC
  
  *******************************************************************
  *** [E] GETERRORS(): Extracts errors from the aErrors collection, 
  *** packages them up in an object, and returns it
  *******************************************************************
  FUNCTION GetErrors 
  LOCAL loParamObj, lnErrCnt, lnCnt
    *** Create the parameter object
    loParamObj = CREATEOBJECT( 'relation' )
    *** Check if we have any errors
    lnErrCnt = ALEN( This.AErrors, 1 )
    IF lnErrCnt = 1 AND EMPTY( This.AErrors[1,1] )
      *** No Errors Pending
      loParamObj.AddProperty( 'nErrorCount', 0 )
    ELSE
      *** Populate the Parameter Object here
      WITH loParamObj
        .AddProperty( 'nErrorCount', lnErrCnt )
        .AddProperty( 'aErrors[1]', "" )
        *** Now Get the 5 Logged Details
        FOR lnCnt = 1 TO lnErrCnt
          *** Add a row to the error array
          DIMENSION .aErrors[lnCnt, 3]
          *** Log the error as Character Strings
          .aErrors[lnCnt, 1] = TRANSFORM( This.AErrors[ lnCnt , 1] )  && Error Number
          .aErrors[lnCnt, 2] = TRANSFORM( This.AErrors[ lnCnt , 2] )  && Error Message
          .aErrors[lnCnt, 3] = TRANSFORM( This.AErrors[ lnCnt , 3] )  && Prog/Method
        NEXT
      ENDWITH
    ENDIF
    *** Clear the Error Collection
    DIMENSION This.AErrors[1,3]
    This.AErrors = ""
    *** Return Errors
    RETURN loParamObj
  ENDFUNC

  ********************************************************************
  *** [P] OPENLOCALTABLES(): Open the tables used by the DSN Manager
  *** Always called from Init to open lookup tables
  ********************************************************************
  PROTECTED FUNCTION OpenLocalTables()
    IF ! USED( "dsnsetup" )
      USE LOCFILE( "dsnsetup", "dbf" ) IN 0 AGAIN
    ENDIF
    IF ! USED("dsnconn")
      USE LOCFILE( "dsnconn", "dbf" ) IN 0 AGAIN
    ENDIF
  ENDFUNC

  ********************************************************************
  *** [P] SETPROCFILES(): Ensure that associated procedure files are open
  ********************************************************************
  PROTECTED FUNCTION SetProcFiles()
  LOCAL llRetVal
    llRetVal = .T.
    WITH This
      *** Need the Registry PRogram
      IF NOT 'REGMGR' $ UPPER( SET("Procedure") )
        SET PROCEDURE TO LOCFILE( 'regmgr.prg', 'prg' )
        llRetVal = 'REGMGR' $ UPPER( SET("Procedure") )
      ENDIF
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  *******************************************************************
  *** [P] LOGERROR(): Standard Log Error Method
  *** Called from the Error method. Adds error to errors collection 
  *******************************************************************
  PROTECTED FUNCTION LogError( tnErrNum, tcErrMsg, tcMethod )
  LOCAL lcErrNum, lcText, lnErrCnt
    lcErrNum = TRANSFORM( tnErrNum )
    lcText = ""
    WITH This
      *** How many Errors currently?
      lnErrCnt = ALEN( .AErrors, 1 )
      *** If only one row, is it actually an error?
      IF lnErrCnt = 1 AND EMPTY( .Aerrors[ 1, 1 ] )
        *** Nope - set error count = 1
        lnErrCnt = 1
      ELSE
        *** We already have at least one error,
        *** so increment the counter
        lnErrCnt = lnErrCnt + 1
      ENDIF
      *** Re-Dimension the Collection
      DIMENSION .AErrors[ lnErrCnt, 3 ]
      *** And Populate the current row
      .AErrors[ lnErrCnt, 1 ] = lcErrNum
      .AErrors[ lnErrCnt, 2 ] = lcText + IIF( EMPTY( tcErrMsg) , "", " " + ALLTRIM( tcErrMsg ) )
      .AErrors[ lnErrCnt, 3 ] = IIF( EMPTY( tcMethod) , "", ALLTRIM( tcMethod ) )
    ENDWITH
    *** Just Return Success!
    RETURN .T.
  ENDFUNC

  ********************************************************************
  *** [E] SHOWERRORS(): Retrieve and display Errors
  *** USE ONLY WHEN DEBUGGING - NEVER CALLED AT RUN TIME
  ********************************************************************
  FUNCTION ShowErrors()
  LOCAL loErr, lcTxt, lcDispTxt, lnCnt
    loErr = This.GetErrors()
    lcTxt = ""
    IF loErr.nErrorCount = 0
      *** No errors to display
      lcDispTxt = "No Errors were recorded"
      MESSAGEBOX( lcDispTxt, 64, "Error Report")
      RETURN
    ELSE
      FOR lnCnt = 1 TO loErr.nErrorCount
        *** ADD CRLF if we already have some text
        lcTxt = lcTxt + IIF( NOT EMPTY( lcTxt ), CHR(13) + CHR(10), "" )
        *** Get the Error detail here
        lcTxt = lcTxt + ALLTRIM( TRANSFORM( loErr.aErrors[ lnCnt,1 ] )) + ": "
        lcTxt = lcTxt + ALLTRIM( loErr.aErrors[ lnCnt, 2 ] )
        IF ! EMPTY( loErr.aErrors[ lnCnt, 3 ] )
          lcTxt = lcTxt + " (" + ALLTRIM( loErr.aErrors[ lnCnt, 3 ] ) + ")"
        ENDIF
      NEXT
      lcDispTxt = lcTxt + CHR(13) + CHR(10) + CHR(13) + CHR(10)
      lcDispTxt = lcDispTxt + "Save these errors to FILE (ErrTxt.txt)?"
    ENDIF    
    *** Display Error Messages
    IF MESSAGEBOX( lcDispTxt, 32 + 4 + 256, "Error Report") = 6 &&YES
      *** Save to file if required
      lcTxt = "Errors Recorded at: " + TTOC( DATETIME() ) + CHR(13) + CHR(10) + lcTxt 
      STRTOFILE( lcTxt + CHR(13) + CHR(10), "ErrTxt.txt", .T. )
    ENDIF
    *** Tidy Up
    RETURN
  ENDFUNC

ENDDEFINE
