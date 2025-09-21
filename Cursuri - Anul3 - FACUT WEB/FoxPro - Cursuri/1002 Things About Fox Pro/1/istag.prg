**********************************************************************
* Program....: ISTAG.PRG
* Compiler...: Visual FoxPro 07.00.0000.9262 for Windows 
* Abstract...: Passed the name of an index tag returns true if it is a
* ...........: tag for the specified table. Uses table in the current
* ...........: work area if no table name is passed. 
**********************************************************************
FUNCTION IsTag( tcTagName, tcTable )
LOCAL ARRAY laTags[1]
LOCAL llRetVal
*** Did we get a tag name?
IF TYPE( 'tcTagName' ) # 'C'
  *** Error - must pass a Tag Name
  ERROR '9000: Must Pass a Tag Name when calling ISTAG()'
  RETURN .F.
ENDIF
*** How about a table alias?
IF TYPE( 'tcTable' ) = 'C' AND ! EMPTY( tcTable )
    *** Get all open indexes for the specified table
    ATagInfo( laTags, "", tcTable )
ELSE
    *** Get all open indexes for the current table
    ATagInfo( laTags, "" )
ENDIF

*** Do a Case Insensitive, Exact=ON, Scan of the first column of array
*** Return Whether the Tag is Found or not
RETURN ( ASCAN( laTags, tcTagName, -1, -1, 1, 7 ) > 0 )
