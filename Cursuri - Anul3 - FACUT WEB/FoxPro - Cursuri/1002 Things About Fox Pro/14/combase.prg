***********************************************************************
* Program....: COMBASE.PRG
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Root Class for building DLLs for COM and Web Services
* ...........: Sub classes of this class can be declared OLEPUBLIC
*******************************************************************
DEFINE CLASS combase AS Session OLEPUBLIC

  *** Define the Errors collection
  PROTECTED ARRAY AErrors[1]
  *** And the Counter for the Errors Collection
  PROTECTED nErrorCount
  nErrorCount = 0
  *** Name of the table which contains error messages
  *** Note that we assume that the Tag on Message Number is always TAG(1)
  cErrTable = ""
  *** We set this flag from the Init() if an error lookup table is defined
  PROTECTED lErrorMsg
  lErrorMsg = .F.

  ********************************************************************
  *** [E] INIT(): Standard Initialization Method
  ********************************************************************
  FUNCTION Init() AS VOID
    WITH This
      *** Cal the EnvSet Method to set any environmental values
      .EnvSet()
      *** Has an error message table been defined?
      IF NOT EMPTY( .cErrTable )
        *** Yes, one has, so open it locally
        .lErrorMsg = .OpenLocalTable( .cErrTable, 3 )
      ENDIF
    ENDWITH
  ENDFUNC
    
  ********************************************************************
  *** [E] RELEASE(): Standard Release method
  ********************************************************************
  FUNCTION Release() AS VOID
      This.CleanUp()
  ENDFUNC

  *******************************************************************
  *** [E] GETERRORS(): Extracts errors from the aErrors collection, 
  *** packages them up as an XML String which is usable by XMLTOCURSOR()
  *******************************************************************
  FUNCTION GetErrors() AS STRING
    #DEFINE CRLF CHR(13) + CHR(10)
    LOCAL lnErrCnt, lcXMLStr, lcErrName, lcErrDets, lnCnt
    WITH This
      *** Create the XML String Variable
      lcXMLStr = "<ERRORLOG>" + CRLF
      *** Check if we have any errors
      lnErrCnt = .nErrorCount
      IF lnErrCnt > 0
        *** Loop through the array and process them
        FOR lnCnt = 1 TO lnErrCnt
          *** Add the open tag
          lcXMLStr = lcXMLStr + "  <ERRORS>" + CRLF
          *** Add the intermediate tags
          lcXMLStr = lcXMLStr + "    <COUNT>" + PADL( lnCnt, 3, '0' ) +  + "</COUNT>" + CRLF
          lcXMLStr = lcXMLStr + "    <ERRNUM>" + TRANSFORM( This.AErrors[lnCnt, 1] ) + "</ERRNUM>" + CRLF
          lcXMLStr = lcXMLStr + "    <ERRMSG>" + TRANSFORM( This.AErrors[lnCnt, 2] ) + "</ERRMSG>" + CRLF 
          lcXMLStr = lcXMLStr + "    <ERROCC>" + TRANSFORM( This.AErrors[lnCnt, 3] ) + "</ERROCC>" + CRLF
          *** Add the closing tag
          lcXMLStr = lcXMLStr + "  </ERRORS>" + CRLF
        NEXT
      ELSE
        *** Just return a single counter record
        lcXMLStr = lcXMLStr + "  <ERRORS>" + CRLF
        lcXMLStr = lcXMLStr + "    <COUNT>000</COUNT>" + CRLF
        lcXMLStr = lcXMLStr + "  </ERRORS>" + CRLF
      ENDIF
      *** Close the file off
      lcXMLStr = lcXMLStr + "</ERRORLOG>" + CRLF
      *** Clear the Error Collection
      DIMENSION This.AErrors[1,3]
      .AErrors = ""
      .nErrorCount = 0
      *** Return Errors
      RETURN lcXMLStr
    ENDWITH
    #UNDEF CRLF
  ENDFUNC

  ********************************************************************
  *** [P] ENVSET(): Set Environmental Parameters as needed
  ********************************************************************
  PROTECTED FUNCTION EnvSet()
  LOCAL llRetVal
    SET BELL OFF
    SET LOGERRORS OFF
    *** Default behavior is to enable buffering
    SET MULTILOCKS ON
  ENDFUNC

  ********************************************************************
  *** [P] CleanUp(): Called from Release()
  ********************************************************************
  PROTECTED FUNCTION CleanUp()
    This.CloseLocalTables()
    RELEASE This
  ENDFUNC

  *******************************************************************
  *** [P] ERROR(): Define the Error Method
  *** Add the error to the internal errors array
  *******************************************************************
  PROTECTED FUNCTION Error( nError, cMethod, nLine )
    *** Log the error
    This.LogError( nError, MESSAGE(), cMethod )
    RETURN
  ENDFUNC

  *******************************************************************
  *** [P] LOGERROR(): Standard Log Error Method
  *** Called from the Error method...
  *** Adds the error to its internal errors collection 
  *******************************************************************
  PROTECTED FUNCTION LogError( tnErrNum, tcErrMsg, tcMethod)
  LOCAL lnSelect, lnErrCnt, lcText, lcErrNum, lcIndex
    lcErrNum = TRANSFORM( tnErrNum )
    lcText = ""
    WITH This
      *** Increment the Error Counter (always initialized to 0)
      lnErrCnt = .nErrorCount + 1
      *** Re-Dimension the Collection
      DIMENSION .AErrors[ lnErrCnt, 3 ]
      *** And Populate the current row
      .AErrors[ lnErrCnt, 1 ] = lcErrNum
      IF .lErrorMsg
        *** We have an Error Table defined, and we always
        *** assume the first tag is the one on Message Number!
        lcIndex = ORDER( .cErrTable, 1 )
        IF SEEK( lcErrNum, .cErrTable, lcIndex ) 
          *** Get the Text fromt the file
          lcText = ALLTRIM( ErrorMsg.cErrText )
        ENDIF
      ENDIF
      *** Add the input error message tot he retrieved text (if anything)
      .AErrors[ lnErrCnt, 2 ] = lcText + IIF( EMPTY( tcErrMsg) , "", " " + ALLTRIM( tcErrMsg ) )
      *** And log the Method name too
      .AErrors[ lnErrCnt, 3 ] = IIF( EMPTY( tcMethod) , "", ALLTRIM( tcMethod ) )
      *** Finally update the error counter
      .nErrorCount = lnErrCnt
    ENDWITH
    *** Just Return Success!
    RETURN .T.
  ENDFUNC

  *******************************************************************
  *** [P] GETITEM(): Protected Method to Extract the specified element 
  *** from a separated list Returns NULL when end of list is reached
  *******************************************************************
  PROTECTED FUNCTION GetItem( tcList AS String, tnItem AS Integer, tcSepBy AS Character ) AS String 
    LOCAL luRetVal, lcSep, lnItem, lnCnt
    luRetVal = ""
    *** Default to Comma Separator if none specified
    lcSep = IIF( VARTYPE( tcSepBy ) # 'C' OR EMPTY( tcSepBy ), ',', tcSepBy )
    *** Default to First Item if nothing specified
    lnItem = IIF( TYPE( 'tnItem' ) # "N" OR EMPTY( tnItem ), 1, tnItem)
    lnCnt = GETWORDCOUNT( tcList, lcSep )
    IF lnItem <= lnCnt
      luRetVal = GETWORDNUM( tcList, lnItem, lcSep )
    ELSE
      luRetVal = NULL
    ENDIF
    *** Return result (Yes, you CAN ALLTRIM a NULL!)
    RETURN ALLTRIM(luRetVal)
  ENDFUNC

  *******************************************************************
  *** [P] OPENLOCALTABLE(): Opens the specified local VFP Table
  *******************************************************************
  PROTECTED FUNCTION OpenLocalTable( tcTable, tnMode )
    LOCAL lcAlias, llRetVal, lcOldErr
    *** Check we got a valid character string
    IF ! This.ValidateParam( tcTable, 'C' )
      RETURN .F.
    ENDIF
    *** Get the table and alias names
    lcAlias = JUSTSTEM( tcTable )
    *** Disable Error Handling
    lcOldErr = ON( "ERROR" )
    ON ERROR *
    *** Check that we have the tables open
    IF ! USED( lcAlias )
      USE ( tcTable ) IN 0 AGAIN SHARED
      llRetVal = USED( lcAlias )
    ELSE
      *** Table is available
      llRetVal = .T.
    ENDIF
    IF llRetVal AND VARTYPE( tnMode ) = 'N'
      *** Did we get a Buffer Mode?
      IF BETWEEN( tnMode, 1, 5 )
        *** Set Buffering on the table to the specified mode
        CURSORSETPROP( 'BUFFERING', tnMode, lcAlias )
      ENDIF
    ENDIF
    *** Log the error if we can't get it
    IF ! llRetVal
      *** Cannot open Source Table
      This.LogError( This.Name, "Unable to open local table " + tcTable, LOWER( PROGRAM() ) )
    ENDIF
    *** Restore Error Handling
    ON ERROR &lcOldErr
    *** Return Status
    RETURN llRetVal
  ENDFUNC

  ********************************************************************
  *** [P] CLOSELOCALTABLES()(): Close the error log table
  ********************************************************************
  PROTECTED FUNCTION CloseLocalTables()
    WITH This
      IF .lErrorMsg
        USE IN ( .cErrTable )
      ENDIF
    ENDWITH
  ENDFUNC

  *******************************************************************
  *** [P] VALIDATEPARAM(): Check that a value has the specified type
  *** Logs an error and returns .F. if not
  *******************************************************************
  PROTECTED FUNCTION ValidateParam( tuTestParm AS Variant, tuReqType AS Character ) AS Variant
    LOCAL llRetVal, lcCallBy
    llRetVal = .T.
    *** Check for Type Only - program must handle EMPTY() values itself
    IF VARTYPE( tuTestParm ) # UPPER( tuReqType )
      llRetVal = .F.
    ENDIF
    *** Unless it's an object
    IF tuReqType = "O"
      llRetVal = NOT ISNULL( tuTestParm )
    ENDIF
    *** Return Result
    RETURN llRetVal  
  ENDFUNC

ENDDEFINE