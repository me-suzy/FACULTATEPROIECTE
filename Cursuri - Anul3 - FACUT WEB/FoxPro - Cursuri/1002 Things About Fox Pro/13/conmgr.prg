***********************************************************************
* Program....: CONMGR.PRG
* Author.....: Andy Kramek
* Date.......: 21 November 2001
* Purpose....: Connection Manager Class Definition
***********************************************************************


DEFINE CLASS conmgr AS Session

  *** Give it a private datasession
  DataSession = 2
  *** An error collection
  DIMENSION aErrors[1] 
  *** Protected array of open connections
  PROTECTED ARRAY aCons[1]
  *** Protected property for connection count
  PROTECTED nConCnt
  nConCnt = 0
  *** Protected property for error handler setting
  PROTECTED cErrHandler
  cErrHandler = ""
   
  ********************************************************************
  *** [E] INIT(): Native Initialization Method
  ********************************************************************
  FUNCTION Init()
  LOCAL llRetVal
  WITH This
    *** Open lookup tables first
    llRetVal = .OpenLocalTables()

    RETURN llRetVal
  ENDWITH
  ENDFUNC

  ****************************************************************
  *** [E] GETCONN(): Return the first available, non-busy, handle
  ***              : -1 => No Connections, 0 => No Free Connection
  ****************************************************************
  FUNCTION GetConn
    LOCAL lnCnt, lnRetVal
    WITH This
      *** Check we have a connection defined
      IF EMPTY( .aCons[1,1] )
        This.LogError( "DSNMgr01", "No Connections Registered", PROGRAM() )
        RETURN -1
      ENDIF
      *** Loop through connection array
      FOR lnCnt = 1 TO .nConCnt
        *** Get Connection Handle
        lnRetVal = .aCons[lnCnt,1]
        *** Is connection busy?
        IF .IsBusy( lnRetVal )
          lnRetVal = 0
        ELSE
          *** Nope, so exit now
          EXIT
        ENDIF
      NEXT
      *** Set Error Message if needed
      IF lnRetVal < 1
        This.LogError( "DSNMGR02", "No Free Connections", PROGRAM() )
      ENDIF
      *** Return the Connection Handle
      RETURN lnRetVal
    ENDWITH
  ENDFUNC

  ****************************************************************
  *** [E] OPENCONN(): Attempt to Connect using 'connection name'
  ***               : -1 => Error, 0 => Unable to connect
  ****************************************************************
  FUNCTION OpenConn( tcConn )
  LOCAL lcConStr, lnHandle, lcDSN, lcUID, lcPwd
    *** Check the parameter is valid
    IF NOT This.ValidateParam( tcConn, "C" )
      *** Log the error
      This.LogError( "DSNMGR03", "Invalid Connection Name", PROGRAM() )
      *** Return "Failed to Connect" 
      RETURN -1
    ENDIF
    *** Find the connection name in the DSNConn Table
    IF NOT SEEK( UPPER( ALLTRIM( tcConn )), 'dsnconn', 'cconname' )
      *** Log the error
      This.LogError( "DSNMGR04", "Connection Name not recognised", PROGRAM() )
      *** Return "Failed to Connect" 
      RETURN -1
    ENDIF
    *** Get the connection details
    lcDSN = ALLTRIM( dsnconn.ccondsn )
    lcUID = ALLTRIM( dsnconn.cconuid )
    lcPwd = ALLTRIM( dsnconn.cconpswd )
    *** We're good so far, so build the connection string from the table
    *** NB: We must have DSN and UID, but there may be no password
    lcConStr = "'" + lcDSN + "','" + lcUID + ;
             + IIF( NOT EMPTY( lcPwd ), "','" + lcPwd + "'", "'" )
    *** Try and Connect (Disable Error handling first!)
    This.SetError( 'OFF' )
    lnHandle = SQLCONNECT( &lcConStr )
    This.SetError( 'ON' )
    *** If successful, try and update properties
    IF lnHandle > 0
      lnHandle = This.AddConnToList( lnHandle, lcDSN, lcUID, lcPWd ) 
    ELSE
      This.LogError( "DSNMGR05", "Unable to establish Connection", PROGRAM() )
    ENDIF
    *** Return result
    RETURN lnHandle
  ENDFUNC

  ****************************************************************
  *** [E] CLOSECONN() : Closes the specified connection
  ****************************************************************
  FUNCTION CloseConn( tnHandle )
    LOCAL lnIndex, lnRetVal, lcErrWas
    IF NOT This.ValidateParam( tnHandle, "N" )
      *** Log the error
      This.Logerror( "DSNMGR06", "Connection Handle is not valid", PROGRAM() )
      *** Return "Failed to DisConnect" code
      RETURN -1
    ENDIF
    IF tnHandle # 0
      *** Check the handle is valid
      IF ASCAN( This.aCons, tnHandle ) = 0
        *** Log the error
        This.Logerror( "DSNMGR07", "Connection Handle is not valid", PROGRAM() )
        *** Return "Failed to DisConnect" code
        RETURN -1
      ENDIF
      *** If closing a specific connection
      lnIndex = ASUBSCRIPT(This.aCons, ASCAN(This.aCons,tnHandle), 1)
    ELSE
      *** Closing ALL connections
      lnIndex = 0
    ENDIF
    *** Disable VFP Error Handling here
    This.SetError( "OFF" )
    IF lnIndex >= 0
      *** We have an Entry in our array
      lnRetVal = SQLDISCONNECT( tnHandle )
      IF lnRetVal > 0
        *** Successfully Disconnected so get rid of entry
        This.RemCon( lnIndex )
      ELSE
        *** Unable to disconnect
        *** Executing SQLDISCONNECT() within an asynchronous function sequence 
        *** or during a transaction will generate an error.  Possible return   
        *** values are 1 (Connection level error), 2 (Environment level error)
        lcMsgText = "Unable to terminate the specified connection" + CHR(13)
        IF lnRetVal = -1
          lcMsgText = lcMsgText + "ODBC Reported a Connection Level Error"
        ELSE
          lcMsgText = lcMsgText + "The Server has reported an Environment Error"
        ENDIF
        This.Logerror( "DSNMGR08", lcMsgText, PROGRAM() )
      ENDIF
    ELSE
        This.Logerror( "DSNMGR09", "Connection Handle is not valid", PROGRAM() )
        lnRetVal = -1
    ENDIF
    *** Restore Error Handling
    This.SetError('ON')
    RETURN lnRetVal > 0
  ENDFUNC

  ****************************************************************
  *** [P] ADDCONNTOLIST(): Updates Properties when new connection added
  ****************************************************************
  PROTECTED FUNCTION AddConnToList( tnHandle, tcDSN, tcUID, tcPWord )
    WITH This
      *** Increment the counter
      .IncCount()
      IF NOT .AddConn( tnHandle, tcDSN, tcUID, tcPWord )
        *** Cannot add connection, so disconnect
        SQLDISCONNECT( tnHandle )
        *** Return 'Unable to Connect' error
        RETURN -1
      ELSE
        RETURN tnHandle
      ENDIF
    ENDWITH
  ENDFUNC
  
  ****************************************************************
  *** [P] ADDCONN(): Add new Connection details to collection
  ***              : Connection must have been made first!
  ****************************************************************
   PROTECTED FUNCTION AddConn( tnHandle, tcDSN, tcUID, tcPWord )
    LOCAL lnCnt, llRetVal
    lnCnt = 0
    WITH This
      IF .nConCnt < 1
        This.LogError( "DSNMGR10", "Cannot add new connection", PROGRAM() )
        llRetVal = .F.
      ELSE
        lnCnt = .nConCnt
        *** Re-Dimension the array
        DIMENSION .aCons[ lnCnt, 4 ]
        .aCons[lnCnt, 1] = tnHandle
        .aCons[lnCnt, 2] = tcDSN
        .aCons[lnCnt, 3] = tcUID
        .aCons[lnCnt, 4] = tcPWord
        llRetVal = .T.
      ENDIF
    ENDWITH
    RETURN llRetVal
  ENDFUNC

  ****************************************************************
  *** [P] REMCONN() : Removes Connection details from collection
  ****************************************************************
   PROTECTED FUNCTION RemCon( tnRow )
    LOCAL llRetVal
    WITH This
      IF tnRow = 0 OR .nConCnt = 0
        *** If nothing in the counter, clear the array
        DIMENSION .aCons[ 1, 4 ]
        STORE "" to .aCons
        STORE 0 TO .nConCnt
        llRetVal = .T.
      ELSE
        *** Decrement the Counter
        This.DecCount()
        *** Re-Dimension the array
        ADEL( .aCons, tnRow )
        DIMENSION .aCons[ This.nConCnt, 4 ]
        llRetVal = .T.
      ENDIF
    ENDWITH
    RETURN llRetVal
  ENDFUNC

  ****************************************************************
  *** [P] ISBUSY(): Checks Connection Status
  ****************************************************************
  PROTECTED FUNCTION IsBusy( tnHandle )
    lnHandle = IIF( VARTYPE(tnHandle)="N", tnHandle, 0 )
    llRetVal = SQLGETPROP( lnHandle, "ConnectBusy" )
    RETURN llRetVal
  ENDFUNC

  ****************************************************************
  *** [P] INCCOUNT(): Increments Connection Count Property
  ***               : Returns new count value
  ****************************************************************
  PROTECTED FUNCTION IncCount
    WITH This
      .nConCnt = .nConCnt + 1
      RETURN .nConCnt
    ENDWITH
  ENDFUNC

  ****************************************************************
  *** [P] DECCOUNT(): Decrements Connection Count Property
  ***               : Returns new count value
  ****************************************************************
  PROTECTED FUNCTION DecCount
    WITH This
      .nConCnt = .nConCnt - 1
      .nConCnt = IIF( .nConCnt <= 0, 1, .nConCnt )
      RETURN .nConCnt
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
    IF ! USED("dsnconn")
      USE LOCFILE( "dsnconn", "dbf" ) IN 0 AGAIN
    ENDIF
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

  ****************************************************************
  *** [P] SETERROR(): Enable/Disable Error handling 
  ****************************************************************
  PROTECTED FUNCTION SetError( tcMode )
    LOCAL lcMode, lcOldError
    lcMode = IIF( !INLIST( tcMode, "OFF", "ON"), "ON", UPPER(ALLTRIM( tcMode )) )
    WITH This
      IF lcMode = "OFF"
        *** Save Current Handling
        This.cErrHandler = ON("ERROR")
        *** Disable error handling
        ON ERROR *
      ELSE
        *** Restore Error Handling
        lcOldError = This.cErrHandler
        ON ERROR &lcOldError
      ENDIF
    ENDWITH
  ENDFUNC

  ****************************************************************
  *** [P] DESTROY(): Close all open connections when destroyed
  ****************************************************************
  PROTECTED FUNCTION Destroy
    *** Just close all open connections 
    *** We're destroying the object anyway!
    SQLDISCONNECT( 0 )
  ENDFUNC

  ****************************************************************
  *** GetTables - Retrieve table information from a connection
  ****************************************************************
  FUNCTION GetTables( tnConn, tcCursor )
    LOCAL lcCursor
    *** If no cursor, use default name
    IF NOT This.ValidateParam( tcCursor,  "C" )
      lcCursor = "SQLTables"
    ELSE
      lcCursor = ALLTRIM( tcCursor )
    ENDIF
    *** We want Table information
    lnRes = SQLTABLES( tnConn, "TABLE", lcCursor)
    *** Return Status
    RETURN lnRes
  ENDFUNC
  
  ****************************************************************
  *** GetViews - Retrieve View information from a connection
  ****************************************************************
  FUNCTION GetViews( tnConn, tcCursor )
    LOCAL lcCursor
    *** If no cursor, use default name
    IF NOT This.ValidateParam( tcCursor,  "C" )
      lcCursor = "SQLViews"
    ELSE
      lcCursor = ALLTRIM( tcCursor )
    ENDIF
    *** We want Table information
    lnRes = SQLTABLES( tnConn, "VIEW", lcCursor)
    *** Return Status
    RETURN lnRes
  ENDFUNC
  
  ****************************************************************
  *** GetFields - Retrieve Field information for an object
  ****************************************************************
  FUNCTION GetFields( tnConn, tcTable, tcCursor )
    LOCAL lcCursor
    *** Table name is mandatory
    IF NOT This.ValidateParam( tcCursor,  "C" )
      This.LogError( "DSNMGR11", "Invalid Table Name", PROGRAM() )
      RETURN -1
    ENDIF
    *** If no cursor, use default name
    IF NOT This.ValidateParam( tcCursor,  "C" )
      lcCursor = "SQLCols"
    ELSE
      lcCursor = ALLTRIM( tcCursor )
    ENDIF
    *** Retrieve results in Fox Format      
    lnRes = SQLCOLUMNS( tnConn, tcTable, "FOXPRO", lcCursor )
    *** Return Status
    RETURN lnRes
  ENDFUNC

ENDDEFINE
