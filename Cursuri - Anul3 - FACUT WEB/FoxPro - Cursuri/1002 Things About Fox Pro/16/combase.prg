***********************************************************************
* Program....: combase.prg
* Author.....: Andy Kramek
* Notice.....: Copyright (c) 2002 Tightline Computers Ltd, All Rights Reserved
* Purpose....: Base Class Definitions for COM and Web Sevice Components
*******************************************************************
*** COMBASE Class: Root Class for building DLLs for COM and Web Services
*******************************************************************
DEFINE CLASS combase AS Session OLEPUBLIC

  *** Get rid of Properties that we really don't need
  PROTECTED BaseClass, Class, ClassLibrary, Parent, ParentClass 
  *** Define the Errors collection
  PROTECTED ARRAY AErrors[1]
  *** Name of the table which contains error messages
  *** We assume that the Tag on Message Number is the first one defined
  PROTECTED cErrTable
  cErrTable = ""
  *** We set this flag from the Init() if an error lookup table is defined
  PROTECTED lErrorMsg
  lErrorMsg = .F.
  *** Use this property to store the location of the Data Directory to use
  PROTECTED cDataDir
  cDataDir = ""

  ********************************************************************
  *** [E] INIT(): Standard Initialization Method
  ********************************************************************
  FUNCTION Init()
    WITH This
      *** Set MultiLocks ON (why the heck they are OFF by default in the 
      *** SESSION CLASS whose main function is for COM development beats us)!
      SET MULTILOCKS ON
      IF NOT EMPTY( .cErrTable )
        *** Do we have an Error Message Table available
        .lErrorMsg = .OpenLocalTable( .cErrTable, 3 )
        *** Clear the error if one was triggered 
        .GetErrors()
      ENDIF
    ENDWITH
  ENDFUNC
    
  *******************************************************************
  *** [E] RELEASE(): Standard Release Method 
  *******************************************************************
  FUNCTION Release() AS VOID
      *** Absolutely kill
    This.Destroy()
  ENDFUNC

  *******************************************************************
  *** [P] ERROR(): Define the Error Method
  *** Add the error to the internal errors array
  *******************************************************************
  PROTECTED FUNCTION Error( nError AS Integer , cMethod AS String , nLine AS Integer ) AS Boolean
    *** Log the error
    This.LogError( nError, MESSAGE(), cMethod )
    RETURN
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
      lnErrCnt = ALEN( This.AErrors, 1 )
      IF lnErrCnt >= 1 AND NOT EMPTY( This.AErrors[1,1] )
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
    ENDWITH
    *** Clear the Error Collection
    DIMENSION This.AErrors[1,3]
    This.AErrors = ""
    *** Return Errors
    RETURN lcXMLStr
    #UNDEF CRLF
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
      IF .lErrorMsg
        *** Assume the first tag is the first one!
        lcIndex = TAG( .cErrTable, 1, .cErrTable )
        IF SEEK( lcErrNum, .cErrTable, lcIndex ) 
          *** Get the Text from the file. Parameter will be added anyway
          lcText = ALLTRIM( EVALUATE( This.cErrTable + ".cErrText" ))
        ENDIF
      ENDIF
      .AErrors[ lnErrCnt, 2 ] = lcText + IIF( EMPTY( tcErrMsg) , "", " " + ALLTRIM( tcErrMsg ) )
      .AErrors[ lnErrCnt, 3 ] = IIF( EMPTY( tcMethod) , "", ALLTRIM( tcMethod ) )
    ENDWITH
    *** Just Return Success!
    RETURN .T.
  ENDFUNC

  *******************************************************************
  *** [P] GETITEM(): Protected Method to Extract the specified element 
  *** from a separated list Returns NULL when end of list is reached
  *******************************************************************
  PROTECTED FUNCTION GetItem( tcList, tnItem, tcSepBy )
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
    LOCAL lcTable, lcAlias, llRetVal, lcOldErr
    *** Check we got a valid character string
    IF ! This.ValidateParam( tcTable, 'C' )
      RETURN .F.
    ENDIF
    *** Get the table and alias names
    lcTable = JUSTFNAME( tcTable )
    *** If a data Directory is specified, prepend it 
    IF NOT EMPTY( This.cDataDir )
      lcTable = ADDBS( ALLTRIM( This.cDataDir )) + lcTable
    ENDIF
    lcAlias = JUSTSTEM( lcTable )
    *** Disable Error Handling
    lcOldErr = ON( "ERROR" )
    ON ERROR *
    *** Check that we have the tables open
    IF ! USED( lcAlias )
      USE ( lcTable ) IN 0 AGAIN SHARED
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
      This.LogError( 9001, tcTable, LOWER( PROGRAM() ) )
    ENDIF
    *** Restore Error Handling
    ON ERROR &lcOldErr
    *** Return Status
    RETURN llRetVal
  ENDFUNC
 
  *******************************************************************
  *** [P] VALIDATEPARAM(): Check that a value has the specified type
  *** Logs an error and returns .F. if not
  *******************************************************************
  PROTECTED FUNCTION ValidateParam( tuTestParm, tuReqType )
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

  *******************************************************************
  *** And hide the methods that we really don't want as well
  *******************************************************************
  PROTECTED FUNCTION ReadExpression()
  ENDFUNC

  PROTECTED FUNCTION ReadMethod()
  ENDFUNC
  
  PROTECTED FUNCTION WriteExpression()
  ENDFUNC

ENDDEFINE