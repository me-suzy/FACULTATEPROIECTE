******************* Constant Definitions *************************
*** Registry root keys
#DEFINE HKEY_CLASSES_ROOT   -2147483648  && BITSET(0,31)+0 [0x80000000]
#DEFINE HKEY_CURRENT_USER   -2147483647  && BITSET(0,31)+1 [0x80000001]
#DEFINE HKEY_LOCAL_MACHINE  -2147483646  && BITSET(0,31)+2 [0x80000002]
#DEFINE HKEY_USERS          -2147483645  && BITSET(0,31)+3 [0x80000003]
#DEFINE HKEY_CURRENT_CONFIG -2147483643  && BITSET(0,31)+5 [0x80000005]
******************* End Constant Definitions **********************

***********************************************************************
*** Specialized sub class to deal with VFP Settings only
***********************************************************************
DEFINE CLASS xfoxreg AS xRegBase
  *** This.cVFPOpt points to the VFP Key
  cVFPOpt = "Software\Microsoft\VisualFoxPro\" + _VFP.Version + "\Options"

  FUNCTION Init()
    *** Set up to use HKEY_CURRENT_USER
    This.SetRootKey( 1 ) 
  ENDFUNC  

  FUNCTION SetFoxOption( tcItemName, tcItemValue )
    *** Set a specific FoxPro Options Item
    RETURN This.SetRegKey( tcItemName, tcItemValue, ;
                           This.cVFPOpt, This.nCurrentRoot )
  ENDFUNC

  FUNCTION GetFoxOption( tcItemName )
    *** Read an Item
    RETURN This.GetRegKey( tcItemName, This.cVFPOpt, ;
                           This.nCurrentRoot )
  ENDFUNC

  FUNCTION ListFoxOptions( taFoxOpts )
    *** Build an array of items (3rd param = Names Only!)
    RETURN This.ListOptions( @taFoxOpts, This.cVFPOpt, ;
                             .F., This.nCurrentRoot )
  ENDFUNC
ENDDEFINE

***********************************************************************
* Begin Registry Class Definition
***********************************************************************
DEFINE CLASS xRegBase AS xObjBase
  *** Set up custom properties
  nCurrentRoot = HKEY_CURRENT_USER  && Default Registry Root Key
  nCurrentKey  = 0    && ID of the currently open Registry key
  lDoneDLLs    = .F.  && Flag set when API Calls loaded
  lCreateKey   = .F.  && Flag stops keys being created by "Open" calls

  ********************************************************************
  *** [E] DELETEKEY(): Delete the specified sub key and all contents
  *** tnKeyID is the handle of an open registry key
  *** tcValueName is the Sub key or Value within that key to delete
  *** NOTE: The RegDeleteKey() API function used here unequivocally deletes 
  *** the specified entry and all children! If we ever need a more
  *** sophisticated delete, amend this method to use SHDeleteEmptyKey
  *** and include it (in Shell Common library, Shlwapi.dll) in LoadAPICalls()
  ********************************************************************
  FUNCTION DeleteKey( tcValueName, tnParentKey  )
  LOCAL llRetVal
    WITH This
      *** If not passed, set default for Parent Key
      IF NOT .ValidateParam( tnParentKey, "N" ) 
        tnParentKey = IIF( .nCurrentKey > 0, .nCurrentKey, .nCurrentRoot )
      ENDIF
      *** Check API Functions are loaded
      IF NOT .lDoneDLLs
        .LoadAPICalls()
      ENDIF
      *** If a key is already open, close it
      .CloseKey()
      *** Just Try and Delete it
      lnStatus = RegDeleteKey( tnParentKey, tcValueName )
      STORE (lnStatus = 0) TO llRetVal
      IF llRetVal
        This.LogError( 100000, 'Unable to delete value: ' + tcValueName, PROGRAM() )
      ENDIF
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [E] ISKEY(): Returns Logical value indicating existence of a key
  ***            : 2nd Param is the ID of the parent key (defaults to current key)
  ********************************************************************
  FUNCTION IsKey( tcSubKey, tnParentKey  )
  LOCAL llRetVal, lnCurKey
    WITH This
      *** Check API Functions are loaded
      IF NOT .lDoneDLLs
        .LoadAPICalls()
      ENDIF
      *** If not passed, set default for Parent Key
      IF NOT .ValidateParam( tnParentKey, "N" ) 
        tnParentKey = IIF( .nCurrentKey > 0, .nCurrentKey, .nCurrentRoot )
      ENDIF
      *** Save the current key and then try and open the specified key
      lnCurKey = .nCurrentKey
      llRetVal = This.OpenKey( tcSubKey, tnParentKey )
      IF llRetVal 
        *** Close it and restore the previous handle
        .CloseKey()
        .nCurrentKey = lnCurKey
      ENDIF
      *** Return a logical Value for this one
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [E] SETROOTKEY(): Sets the specified Root key as current
  ********************************************************************
  *** Yes, we are using magic numbers here, but easier ones than Windows
  ***   1 = HKEY_CURRENT_USER   -2147483647  && BITSET(0,31)+1
  ***   2 = HKEY_LOCAL_MACHINE  -2147483646  && BITSET(0,31)+3
  ***   3 = HKEY_USERS          -2147483645  && BITSET(0,31)+2
  ***   4 = HKEY_CLASSES_ROOT   -2147483648  && BITSET(0,31)+0
  ***   5 = HKEY_CURRENT_CONFIG -2147483643  && BITSET(0,31)+5
  ********************************************************************
  FUNCTION SetRootKey( tnRootKey )
    LOCAL llRetVal
    WITH This
      IF NOT .ValidateParam( tnRootKey, "N" )
        *** Default to HKEY_CURRENT_USER
        tnRootKey = 1
      ENDIF
      *** Check Operating System Version and populate root key properties accordingly
      llRetVal = .ChkVersion( tnRootKey )
      IF NOT llRetVal
        *** Not running in windows! Log an Error
        .LogError( 100000, "Requires MS Windows based Operating SYstem" )
      ELSE
        *** Check API Functions are loaded
        IF NOT .lDoneDLLs
          .LoadAPICalls()
        ENDIF
      ENDIF
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [E] SETREGKEY(): Sets a value for the specified registry key
  ********************************************************************
  FUNCTION SetRegKey( tcItemName, tcItemVal, tcSubKey, tlAutoCreate, tnParentKey )
  LOCAL llOk
    WITH This
      *** If not passed, set default for Parent Key
      IF NOT .ValidateParam( tnParentKey, "N" ) 
        tnParentKey = IIF( .nCurrentKey > 0, .nCurrentKey, .nCurrentRoot )
      ENDIF
      *** Check API Functions are loaded
      IF NOT .lDoneDLLs
        .LoadAPICalls()
      ENDIF
      *** Does the specified Key exist?
      IF NOT This.IsKey( tcSubKey, tnParentKey  )
        *** Did we want to create it?
        IF tlAutoCreate OR .lCreateKey
          *** Create the key and open it
          llOk = .CreateKey( tcSubKey, tnParentKey  )
        ELSE
          .LogError( 100000, "Key does not exist, and auto-create is not set: " + tcSubKey, PROGRAM() )
        ENDIF
      ELSE
        *** Open parent key and make it "current"
        llOk = .OpenKey( tcSubKey, tnParentKey )
      ENDIF
      *****************************************************
      *** llOK is only .T. if a key was successfully opened
      *****************************************************
      IF llOk
        *** If we got some data, just set it, otherwise just exit out having opened the key
        IF NOT EMPTY( tcItemName )
          *** Set data for the value
          llOk = .SetKeyValue( tcItemName, tcItemVal )
          IF NOT llOK
            .LogError( 100000, "Cannot set value for specified key: " + tcItemName, PROGRAM() )
          ENDIF
          *** Close the key at the end of this call
          .CloseKey()
        ENDIF
      ELSE
        .LogError( 100000, "Cannot open specified key: " + tcSubKey, PROGRAM() )
      ENDIF
      RETURN llOk
    ENDWIT
  ENDFUNC

  ********************************************************************
  *** [E] GETREGKEY(): Gets the value for the specified registry key
  ********************************************************************
  FUNCTION GetRegKey( tcItemName, tcSubKey, tnParentKey )
  LOCAL llOK, lcItemVal
    WITH This
      *** If not passed, set default for Parent Key
      IF NOT .ValidateParam( tnParentKey, "N" ) 
        tnParentKey = IIF( .nCurrentKey > 0, .nCurrentKey, .nCurrentRoot )
      ENDIF
      *** Check API Functions are loaded
      IF NOT .lDoneDLLs
        .LoadAPICalls()
      ENDIF
      *** Open the key first
      llOK = .OpenKey( tcSubKey, tnParentKey)
      IF llOK
        *** If it opened, get the value
        lcItemVal = ""
        llOK = .GetKeyValue( tcItemName, @lcItemVal )
        IF NOT llOK
          .LogError( 100000, "Cannot get the value for specified key: " + tcSubKey, PROGRAM() )
        ENDIF
      ELSE
        .LogError( 100000, "Cannot open specified key: " + tcSubKey, PROGRAM() )
      ENDIF
      *** Close the key at the end of this call
      .CloseKey()
      RETURN lcItemVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [E] LISTOPTIONS(): Build an array with all entries for a key
  *** taRegItems = Array to populate, passed by reference
  ********************************************************************
  FUNCTION ListOptions( taRegItems, tcKeyName, tlNamesOnly, tnParentKey )
  LOCAL llRetVal
    WITH This
      *** We need to determine which parent key handle to use first!
      *** If nothing passed, default to Root Key if no key is current
      IF NOT .ValidateParam( tnParentKey, "N" ) 
        tnParentKey = IIF( .nCurrentKey > 0, .nCurrentKey, .nCurrentRoot )
      ELSE
        *** However, If we got a Zero, close any open keys
        *** And define the Root Key as parent
        IF tnParentKey == 0
          .CloseKey()
          tnParentKey = .nCurrentRoot
        ENDIF  
      ENDIF
      *** Check API Functions are loaded
      IF NOT .lDoneDLLs
        .LoadAPICalls()
      ENDIF
      *** Did we get a key name to evaluate?
      IF NOT EMPTY( tcKeyName )
        *** Try and open the key, but do not create if not there
        llRetVal = This.OpenKey( tcKeyName, tnParentKey )
      ELSE
        *** If no key was passed, we want the listing for the root key
        *** so just set both llRetVal and tlNamesOnly to .T.
        STORE .T. TO llRetVal, tlNamesOnly
        *** And set current key to the current Root Key
        .nCurrentKey = .nCurrentRoot
      ENDIF     
      IF llRetVal
        IF tlNamesOnly
          *** We only want the Key Names
          llRetVal = This.ListKeyNames( @taRegItems )
        ELSE
          *** We want both Names and Values
          llRetVal = This.ListKeyValues( @taRegItems )
        ENDIF
      ENDIF
      RETURN llRetVal     
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [E] INIT(): Initialize Root key if passed, or leave at default
  ********************************************************************
  FUNCTION Init( tnRootkey )
    RETURN This.SetRootKey ( tnRootKey )    
  ENDFUNC

  ********************************************************************
  *** [E] DESTROY(): Releases opened DLLs explicitly
  ********************************************************************
  FUNCTION Destroy()
    IF This.lDoneDLLs
      *** Note: Although named CLEAR DLLS, this command actually releases the 
      *** named function only, not the entire DLL. So we need to reference
      *** each function we opened, explicitly in this method even though they
      *** are all in the same physical DLL file (ADVAPI.DLL)
      CLEAR DLLS RegOpenKeyEx, RegCreateKeyEx, RegCloseKey, RegDeleteKey
      CLEAR DLLS RegSetValueEx, RegQueryValueEx, RegEnumKeyEx, RegEnumValue
    ENDIF  
  ENDFUNC

  ********************************************************************
  *** [P] OPENKEY(): Open specified registry key and make it 'current'
  ********************************************************************
  PROTECTED FUNCTION OpenKey( tcSubKey, tnParentKey )
  LOCAL lnSubKey, llKeyWas, lnErrNum , lnStatus
    *** Initialize the key buffer
    STORE 0 TO lnSubKey, lnStatus
    WITH This
      *** If not passed, set default for Parent Key
      IF NOT .ValidateParam( tnParentKey, "N" ) 
        tnParentKey = IIF( .nCurrentKey > 0, .nCurrentKey, .nCurrentRoot )
      ENDIF
      IF VARTYPE( tcSubKey ) # 'C' OR EMPTY( tcSubKey )
        *** Default to Null String
        tcSubKey = ""
      ELSE
        *** Remove Leading and or Trailing "\"
        tcSubKey = This.CleanKey( tcSubKey )
      ENDIF
      *** Make sure we don't have a key open already
      .CloseKey()
      *** Now go ahead and open the key
      lnErrNum = RegOpenKeyEx( tnParentKey, tcSubKey, 0, 63, @lnSubKey)
      *** What did we get
      STORE (lnErrNum = 0) TO llRetVal
      IF llRetVal
        *** Key is open so make it current
        .nCurrentKey = lnSubKey
      ENDIF
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] CREATEKEY(): Create a new entry in the registry key hierarchy 
  ********************************************************************
  PROTECTED FUNCTION CreateKey( tcSubKey, tnParentKey)
  LOCAL lnSubKey, lnParent, lnIndex, lnPos, llRetVal, lcCurKey, lnRetVal, lnStatus
  WITH This
    *** Initialize variables properly
    STORE 0 TO lnSubKey, lnParent, lnIndex
    *** Remove Leading and or Trailing "\"
    lcSubKey = This.CleanKey( tcSubKey )
    *** Initialize the parent key too
    lnParent = tnParentKey
    *** Work back through the key's parents until we find one that exists
    lnIndex = 0
    DO WHILE .T.
      *** If we have been given a root key as a parent, try and find an 
      *** existing key in the path specified, otherwise we lnparent must
      *** be the handle to an already open key
      IF lnParent < 1
        lnIndex = lnIndex + 1 
        lnPos = RAT( "\", lcSubkey, lnIndex )
        IF lnPos = 0
          *** Reached the end of the string, so exit anyway
          llRetVal = .F.
          EXIT
        ENDIF
        *** Extract the key component and see if it exists
        lcCurKey = LEFT( lcSubKey, lnPos - 1 )
        IF NOT .IsKey( lcCurKey, lnParent ) 
          *** Try the parent of this key
          LOOP
        ENDIF
        **************************************************************
        *** If we get here, we have a key (lcCurKey) and a parent (lnParent)
        *** Now we need to Open that key and then create the sub-keys in
        *** turn until we reach the end of the originally required key
        **************************************************************
        .OpenKey( lcCurKey, lnParent )
      ELSE
        *** Set the current key to an empty string to avoid errors below
        lcCurKey = ""
        *** And fornce current key to this parent key too
        .nCurrentKey = lnParent
      ENDIF
      *** This.nCurrentKey now points to the Parent, so we can create the sub key(s)
      DO WHILE .T.
        *** We need to create a sub key
        lnParent = .nCurrentKey
        *** Remove the currently open key from the required string
        lcSubKey = STRTRAN( lcSubKey, lcCurKey + "\" )
        lnPos = AT( "\", lcSubkey, 1 )
        *** Extract the required sub key component
        lcCurKey = IIF( lnPos > 0, LEFT( lcSubKey, lnPos - 1 ), lcSubKey )
        *** Initialize API Call buffers
        STORE 0 TO lnSubKey, lnStatus
        *** Try to create the key and open it, returns the Handle to the new key in lnSubKey
        lnRetVal = RegCreateKeyEx( lnParent, @lcCurKey, 0, 0, 0, 63, 0, @lnSubKey, @lnStatus )
        IF lnRetVal # 0
          This.LogError( 100000, 'Unable to create Sub Key: ' + lcSubKey, PROGRAM() )
          EXIT
        ENDIF
        *** Key was created, set the .nCurrentKey
        .nCurrentKey = lnSubKey
        IF lcCurKey = lcSubKey  
          *** No more sub keys required, so exit
          llRetVal = .T.
          EXIT
        ENDIF
      ENDDO
      *** If we reach here, we're done anyway
      EXIT        
    ENDDO
    RETURN llRetVal        
  ENDWITH
  ENDFUNC


  ********************************************************************
  *** [P] CLEANKEY(): Remove unwanted characters from key name
  ********************************************************************
  PROTECTED FUNCTION CleanKey(tcKey)
    LOCAL lcKey
    lcKey = ALLTRIM( tcKey )
    *** Remove leading trailing separators
    lcKey = IIF( LEFT( lcKey, 1 ) $ "/\", SUBSTR( lcKey, 2 ), lcKey )
    lcKey = IIF( RIGHT( lcKey, 1 ) $ "/\", LEFT( lcKey, LEN( lcKey ) -1 ), lcKey )
    *** Force all separators to "\"
    lcKey = STRTRAN( lcKey, "/", "\" )
    RETURN lcKey
  ENDFUNC

  ********************************************************************
  *** [P] CLOSEKEY(): Closes whichever key is defined as 'current'
  ********************************************************************
  PROTECTED FUNCTION CloseKey()
    WITH This
      *** Unequivocally close the current key if one is set
      IF .nCurrentKey > 0
        RegCloseKey( .nCurrentKey )
      ENDIF
      .nCurrentKey = 0
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] GETKEYVALUE(): Get a Value from a key
  *** tcKeyName = key name to retrieve
  *** tcKeyValue Must be passed by reference to store return value
  ********************************************************************
  PROTECTED FUNCTION GetKeyValue( tcKeyName, tcKeyValue )
  LOCAL llRetVal, lnReserved, lnDataType, lnKeyLen, lcKeyVal
    WITH This
      *** Check Params first
      IF VARTYPE( .nCurrentKey ) # 'N' OR EMPTY( .nCurrentKey )
        .LogError( 100000, "No registry key is set as current", PROGRAM())
        RETURN llRetVal
      ENDIF
      IF VARTYPE( tcKeyName ) # "C"
        .LogError( 100000, "Key name is required to set values", PROGRAM())
        RETURN llRetVal
      ENDIF
      *** Initialise the variables we need here
      lnReserved = 0  && Always 0!!!
      lnDataType = 0  && Initialize to 0
      lnKeyLen = 256  && Always 256
      lcKeyVal = SPACE( 256 )
      *** And call the function
      lnStatus = RegQueryValueEx( .nCurrentKey, tcKeyName, lnReserved, @lnDataType, @lcKeyVal, @lnKeyLen )
      STORE( lnStatus = 0 ) TO llRetVal 
      IF llRetVal
        *** Get the value that was returned and pass it back
        tcKeyValue = .RegToFox( lnDataType, lcKeyVal, lnKeyLen )
      ENDIF
      *** Return Success/Failure
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] SETKEYVALUE(): Sets the specified key value 
  *** tcKeyName = Key to set
  *** tcValue = Value to set
  ********************************************************************
  PROTECTED FUNCTION SetKeyValue( tcKeyName, tuValue )
  LOCAL llRetVal, lnValueSize, lnDType
    WITH This
      DO CASE
        CASE VARTYPE( This.nCurrentKey  ) # 'N' OR EMPTY( This.nCurrentKey )
          .LogError( 100000, "No Registry key is currently open", PROGRAM())
        CASE VARTYPE( tcKeyName ) # "C" OR EMPTY( tcKeyName )  
          .LogError( 100000, "Key name is required to set values", PROGRAM())
        CASE NOT INLIST( VARTYPE( tuValue ), "C", "N" )
          .LogError( 100000, "Only String or Numeric values can be set", PROGRAM())
        OTHERWISE
          llRetVal = .T.
      ENDCASE
      *** Convert data and set datatype and length correctly
      tuValue = .FoxToReg( tuValue, @lnDType, @lnValueSize )
      lnValueSize = LEN( tuValue )
      IF llRetVal
        *** Ensure we have the DLLs loaded
        
        *** Try and set the value here
        lnStatus = RegSetValueEx( This.nCurrentKey, tcKeyName, 0, lnDType, tuValue, lnValueSize)
        STORE (lnStatus = 0 ) TO llRetVal
      ENDIF
      *** Return Success/Failure
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] LISTKEYNAMES(): Populate array with Sub Key Names for the current key
  *** taKeyNames = Array to populate, passed by reference
  ********************************************************************
  PROTECTED FUNCTION ListKeyNames( taKeyNames )
  LOCAL lnIndex, lnKeySize, lcNewKey, lnOptions, lnClass, lcClass
  LOCAL lcRetTime, lnStatus, llRetVal
    WITH This
      *** Check API Functions are loaded
      IF NOT .lDoneDLLs
        .LoadAPICalls()
      ENDIF
      *** Retrieves the list of Key names into the specified array
      lnIndex = 0
      DIMENSION taKeyNames[1]
      DO WHILE .T.
        *** Initialise the Parameters
        lnKeySize = 250  && Key Name Buffer length
        lcNewKey  = SPACE( lnKeySize ) && Key name buffer
        lnOptions = 0  && Future use
        lnClass   = 0  && Future use
        lcClass   = 0  && Future use
        lcRetTime = SPACE( lnKeySize ) && Last Return Time
        *** Get key name for this index item
        lnStatus = RegEnumKeyEx( This.nCurrentKey, lnIndex, @lcNewKey, @lnKeySize, ;
                                     lnOptions, lcClass, lnClass, @lcRetTime)
        IF lnStatus # 0
          *** Either error, or no more, exit either way
          EXIT
        ENDIF
        ******************************************
        *** Process the result if we get this far:
        ******************************************
        *** Remove the NULL terminator    
        lcNewKey = ALLTRIM( CHRTRAN( lcNewKey, CHR(0), '') )
        *** Increment the Key Index 
        *** Remember, API Collections are 0-based but VFP uses 1-based arrays
        lnIndex = lnIndex + 1
        *** Re-dimension the array and add the result
        DIMENSION taKeyNames[ lnIndex ]
        taKeyNames[ lnIndex ] =  lcNewKey
      ENDDO
      *** If we simply got to the end, it's OK
      IF INLIST( lnStatus, 0, 259 )
        llRetVal = .T.
      ELSE
        .LogError( 100000, "Cannot build key list", PROGRAM() )
      ENDIF
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] LISTKEYVALUES(): Populate array with SubKeys & Values for the current key
  *** taKeyValues = Array to populate, passed by reference
  ********************************************************************
  PROTECTED FUNCTION ListKeyValues( taKeyValues)
  LOCAL lnIndex, lnKeyLen, lcKeyBuff, lnOptions, lnDType
  LOCAL lnDatLen, lcDatBuff, lnStatus, lcStr, lnCnt, llRetVal
    WITH This
      *** Check API Functions are loaded
      IF NOT .lDoneDLLs
        .LoadAPICalls()
      ENDIF
      lnIndex = 0
      DO WHILE .T.
        *** Initialise the parameters here for each call
        lnKeyLen  = 250                && Key Name Buffer length
        lcKeyBuff = SPACE( lnKeyLen )  && Key name buffer
        lnOptions = 0                  && Future use
        lnDType   = 0                  && Data Type
        lnDatLen  = 250                && Data Buffer Length
        lcDatBuff = SPACE( lnDatLen )  && Data Buffer
        *** And now call for the curent Index
        lnStatus = RegEnumValue( This.nCurrentKey, lnIndex, @lcKeyBuff, @lnKeyLen, ;
                                 lnOptions, @lnDType, @lcDatBuff, @lnDatLen )
   
        IF lnStatus # 0
          *** Either error, or no more, exit either way
          EXIT
        ENDIF
        ******************************************
        *** Process the result if we get this far:
        ******************************************
        *** Increment the Key Index 
        *** Remember, API Collections are 0-based but VFP uses 1-based arrays
        lnIndex = lnIndex + 1
        *** Re-dimension the Array
        DIMENSION taKeyValues[ lnIndex, 2]
        *** Get the Name First
        taKeyValues[ lnIndex, 1] = LEFT( lcKeyBuff, lnKeyLen )
        *** And the Value
        taKeyValues[ lnIndex, 2] = .RegToFox( lnDType, lcDatBuff, lnDatLen )
      ENDDO
      *** If we simply got to the end, it's OK
      IF INLIST( lnStatus, 0, 259 )
        llRetVal = .T.
      ELSE
        .LogError( 100000, "Cannot build key list", PROGRAM() )
      ENDIF
      RETURN llRetVal
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] FOXTOREG(): Convert VFP Data to Registry Equivalents
  ********************************************************************
  PROTECTED FUNCTION FoxToReg( tuValue, tnType )
  LOCAL lcRegVal, lnCnt
  IF VARTYPE( tuValue ) = "N" 
    *** Need to format this up as a double word string
    lcRegVal = ""
    FOR lnCnt = 24 TO 0 STEP -8
      *** Get the value for each byte
      lcRegVal = CHR( INT( tuValue / ( 2^lnCnt ) ) ) + lcRegVal
      *** Now we just need the remainder
      tuValue = MOD( tuValue, ( 2^lnCnt ) )
    NEXT
    *** Set the correct data type
    tnType = 4  && Constant Name = REG_DWORD
  ELSE
    *** Strings must be null-terminated
    lcRegVal = tuValue + CHR(0)
    tnType = 1  && Constant Name = REG_SZ
  ENDIF
  RETURN lcRegVal

  ********************************************************************
  *** [P] REGTOFOX(): Convert Registry Data Types to VFP Equivalents
  ********************************************************************
  PROTECTED FUNCTION RegToFox( tnDType, tcDataBuff, tnDataLen )
  LOCAL luRetVal, lcStr, lnCnt
    DO CASE
       CASE tnDType = 1  && Constant Name = REG_SZ
         *** This is a NULL-terminated Character String
         luRetVal = CHRTRAN( LEFT( tcDataBuff, tnDataLen ), CHR(0), '')
       CASE tnDType = 4  && Constant Name = REG_DWORD
         *** This is a 32-bit number
         luRetVal = 0
         FOR lnCnt = 1 TO tnDataLen
           lcbit = PADL( ASC( SUBSTR( tcDataBuff, lnCnt, 1 ) ), 4, '0' )
           luRetVal = VAL( lcBit ) + luRetVal
         NEXT
       OTHERWISE
         *** Some form of binary data (Constant Name = REG_BINARY)
         luRetVal = "Binary Data"
    ENDCASE
    RETURN luRetVal
  ENDFUNC

  ********************************************************************
  *** [P] CHKVERSION(): Ensure we are in Windows, set version defaults
  ********************************************************************
  PROTECTED FUNCTION ChkVersion( tnRootKey )
    LOCAL llRetVal
    WITH This
      *** Check operating system variables and return error if NOT windows
      llRetVal = (NOT _DOS) AND (NOT _UNIX) AND (NOT _MAC)
      *** If we're OK, set the Root key
      IF llRetVal
        DO CASE
          CASE tnRootKey = 1 
            .nCurrentRoot = HKEY_CURRENT_USER
          CASE tnRootKey = 2 
            .nCurrentRoot = HKEY_LOCAL_MACHINE
          CASE tnRootKey = 3 
            .nCurrentRoot = HKEY_USERS
          CASE tnRootKey = 4 
            .nCurrentRoot = HKEY_CLASSES_ROOT
          CASE tnRootKey = 5
            .nCurrentRoot = HKEY_CURRENT_CONFIG
          OTHERWISE 
            *** This is the default
            .nCurrentRoot = HKEY_CURRENT_USER
        ENDCASE  
      ENDIF
    ENDWITH
    RETURN llRetVal 
  ENDFUNC

  ********************************************************************
  *** [P] LOADAPICALLS(): Load registry management functions (ONCE)
  ********************************************************************
  PROTECTED FUNCTION LoadAPICalls
    IF This.lDoneDLLs
      *** DLLs have already been loaded, just bale out here
      RETURN
    ENDIF

    *** Open the specified key. Non-zero return indicates failure
    DECLARE INTEGER RegOpenKeyEx IN Win32API ;
      INTEGER lnHKey, ;  && Handle to an already open key
      STRING @lcSubKey, ;  && Subkey name
      INTEGER lnOptions, ; && Reserved (must be = 0)
      INTEGER lnSAM, ;   && Security access mask
      INTEGER @lnResult  && Handle to specified key
        *** Security Access Mask Settings
        ***  1 = Constant KEY_QUERY_VALUE 
        ***  2 = Constant KEY_SET_VALUE
        ***  4 = Constant KEY_CREATE_SUB_KEY
        ***  8 = Constant KEY_ENUMERATE_SUB_KEYS
        *** 16 = Constant KEY_NOTIFY 
        *** 32 = Constant KEY_CREATE_LINK
        *** 63 = Constant KEY_ALL_ACCESS

    *** Create and/or Open the specified key. Non-zero return indicates failure
    DECLARE INTEGER RegCreateKeyEx IN Win32API ;
      INTEGER lnHKey, ;     && Handle to an already open key
      STRING @lcSubKey, ;   && Sub-key name
      INTEGER lnOptions, ;  && Reserved (must be = 0)
      STRING lcClass, ;     && Class string (Future use, pass Null String)
      INTEGER lnOptions, ;  && Special options
      INTEGER lnSAM, ;      && Security access mask (see above)
      STRING lcSecAttrib, ; && Pass NULL for Defaults
      INTEGER @lnResult, ;  && Handle to specified key
      INTEGER @lnStatus     && Key Status ( 1 = New Key, 2 = Opened Existing)
        *** Special Options
        *** 0 = Constant REG_OPTION_NON_VOLATILE    Key is preserved when system is rebooted
        *** 1 = Constant REG_OPTION_VOLATILE        Key is not preserved when system is rebooted
        *** 4 = Constant REG_OPTION_BACKUP_RESTORE  Open for backup or restore special access rules privilege required

    *** Close the specified key
    DECLARE Integer RegCloseKey IN Win32API ;
      INTEGER lnHKey        && Handle to an already open key

    *** Delete the specified Sub Key
    DECLARE Integer RegDeleteKey IN Win32API ;
      INTEGER lnHKey, ;     && Handle to an already open key
      STRING @lcSubKey      && Subkey name

    *** Sets and/or Adds the specified value to a key
    DECLARE Integer RegSetValueEx IN Win32API ;
      INTEGER lnHKey, ;     && Handle to an already open key
      STRING @lcValName, ;  && ValueName (If NULL or "", sets the DEFAULT value)
      INTEGER lnOptions, ;  && Reserved (must be = 0)
      INTEGER lnDataType, ; && Data Type to Store
      STRING @lcData, ;     && Pointer to Data to be inserted
      INTEGER lnData        && Length of the data string

        *** Registry Data Types
        *** REG_NONE                0  && No defined value type
        *** REG_SZ                  1  && A null-terminated string. 
        *** REG_EXPAND_SZ           2  && A null-terminated string that contains unexpanded references to environment variables (for example, "%PATH%").  
        *** REG_BINARY              3  && Binary data in any form
        *** REG_DWORD               4  && 32-bit number
        *** REG_DWORD_LITTLE_ENDIAN 4  && 32-bit number (same as REG_DWORD)
        *** REG_DWORD_BIG_ENDIAN    5  && 32-bit number (See MSDN for Explanation - made no sense to me!)
        *** REG_LINK                6  && A Unicode symbolic link. Used internally; applications should not use this type
        *** REG_MULTI_SZ            7  && An array of null-terminated strings, terminated by two null characters
        *** REG_RESOURCE_LIST       8  && A device-driver resource list

    *** Get Data Type and Value for the specified item in a key
    DECLARE Integer RegQueryValueEx IN Win32API ;
      INTEGER lnHKey, ;      && Handle to an already open key
      STRING lcValName, ;    && ValueName (If NULL or "", sets the DEFAULT value)
      INTEGER lnOptions, ;   && Reserved (must be = 0)
      INTEGER @lnDataType, ; && Buffer to receive Registry Data Type of the Value
      STRING @lcData, ;      && Buffer to receive the Value
      INTEGER @lnData        && Buffer to receive the length of the returned Value

    *** Enumerates subkeys of the specified open registry key. 
    *** The function retrieves the name of one subkey each time it is called. 
    *** Returns 259 (#DEFINE ERROR_NO_MORE_ITEMS) When no more items exist
    DECLARE Integer RegEnumKeyEx IN Win32API ;
      INTEGER lnHKey, ;     && Handle to an already open key
      INTEGER lnSubKey, ;   && Index into the Subkeys
      STRING @lcData, ;     && Buffer to receive the Name of the specified sub-key
      INTEGER @lnData, ;    && Buffer to receive the length of the returned Value
      INTEGER lnOptions, ;  && Reserved (must be = 0)
      STRING lcClass, ;     && Class string (Future use, pass Null String)
      INTEGER lnClass, ;    && Size of Class String Buffer (Future use, pass NULL )
      STRING @lcTime        && Buffer to receive last write time
      
    *** Enumerates the values for the specified open registry key. 
    *** Copies one indexed value name and data for the key each time it is called. 
    *** Returns 259 (#DEFINE ERROR_NO_MORE_ITEMS) When no more items exist
    DECLARE INTEGER RegEnumValue IN Win32API ;
      INTEGER lnhKey, ;      && Handle to an already open key
      INTEGER lnSubKey, ;    && Index into the Subkeys
      STRING @lcData, ;      && Buffer to receive the Name of the specified sub-key
      INTEGER @lnData, ;     && Buffer to receive the length of the returned Value
      INTEGER lnOptions, ;   && Reserved (must be = 0)
      INTEGER @lnDataType, ; && Buffer to receive Registry Data Type of the Value
      STRING @lcData, ;      && Buffer to receive the Value
      INTEGER @lnData        && Buffer to receive the length of the returned Value

    *** Set Flag to avoid re-loading things over and over again
    This.lDoneDLLs = .T.
    RETURN 
  ENDFUNC

ENDDEFINE

***********************************************************************
*** Root Class Definitions
***********************************************************************
DEFINE CLASS xObjBase AS xCus
  *** Set Flag when Error Message File is in use
  lErrorMsg = .F.
  *** And an Error Collection
  DIMENSION aErrors[1] 

  *******************************************************************
  *** [P] ADDERRORS(): Calls the GetErrors() method of the object passed 
  *** and adds its Error collection to that of the caller 
  *******************************************************************
  PROTECTED FUNCTION AddErrors( toObject )
    LOCAL loErrObj, lnErrs
    *** Check Parameters
    IF VARTYPE( toObject ) # 'O'
      ASSERT .F. MESSAGE 'This is another Brain Dead Programmer Error!' + CHR( 13 ) +;
        'You MUST pass an object reference to the AddErrors Method!' + CHR( 13 ) +;
        'Have a nice day now...'
      RETURN .F.
    ENDIF
    *** Call the specified object's GetErrors() method
    loErrObj = toObject.GetErrors()
    WITH This
      *** Has it got any errors?
      lnErrs = loErrObj.nErrorCount
      IF lnErrs > 0
        *** If so, add them to the current Collection
        FOR lnCnt = 1 TO lnErrs
          .LogError( loErrObj.aErrors[lnCnt, 1], ;
              loErrObj.aErrors[lnCnt, 2], ;
              loErrObj.aErrors[lnCnt, 3] )
        ENDFOR
      ENDIF
    ENDWITH
    RETURN
  ENDFUNC

  *******************************************************************
  *** ERROR(): Define the Error Method
  *** Add the error to the internal errors array
  *******************************************************************
  FUNCTION Error( nError, cMethod, nLine )
    *** Log the error
    This.LogError( nError, MESSAGE(), cMethod )
    RETURN
  ENDFUNC
  
  *******************************************************************
  *** GETERRORS(): Extracts errors from the aErrors collection, 
  *** packages them up in an object, and returns it
  *******************************************************************
  FUNCTION GetErrors 
    LOCAL lnErrCnt, loParamObj, lcErrName, lcErrDets, lnCnt
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

  ********************************************************************
  *** [E] INIT(): Standard Initialization Method
  ********************************************************************
  FUNCTION Init()
    *** Do we have an Error Message Table available
    This.lErrorMsg = This.OpenLocalTable("ErrorMsg")
  ENDFUNC

  *******************************************************************
  *** [P] LOGERROR(): Standard Log Error Method
  *** Called from the Error method...
  *** Adds the error to its internal errors collection 
  *******************************************************************
  PROTECTED FUNCTION LogError( tnErrNum, tcErrMsg, tcMethod )
    LOCAL lnSelect, lnErrCnt, lcText, lcErrNum
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
      IF This.lErrorMsg 
        IF SEEK( lcErrNum, "ErrorMsg", "cErrNum" ) 
          *** Get the Text fromt the file
          lcText = ALLTRIM( ErrorMsg.cErrText )
        ENDIF
      ENDIF
      .AErrors[ lnErrCnt, 2 ] = lcText + IIF( EMPTY( tcErrMsg) , "", " " + ALLTRIM( tcErrMsg ) )
      .AErrors[ lnErrCnt, 3 ] = IIF( EMPTY( tcMethod) , "", ALLTRIM( tcMethod ) )
    ENDWITH
    *** Just Return Success!
    RETURN .T.
  ENDFUNC

  *******************************************************************
  *** RELEASE(): Standard Release Method
  *******************************************************************
  FUNCTION Release
    RELEASE This
  ENDFUNC

  *******************************************************************
  *** SHOWERRORS(): Display contents of, and clear, Error Collection
  *******************************************************************
  FUNCTION ShowErrors()
  LOCAL lnSelect, loErr, lcTxt, lcDispTxt
    *** Save Work Area
    lnSelect = SELECT()
    loErr = This.GetErrors()
    lcTxt = ""
    IF loErr.nErrorCount = 0
      *** No errors to display
      lcDispTxt = "No Errors were recorded"
      MESSAGEBOX( lcDispTxt, 64, "Error Report")
      RETURN
    ELSE
      FOR lnCnt = 1 TO loErr.nErrorCount
        lcTxt = lcTxt + IIF( NOT EMPTY( lcTxt ), CHR(13)+CHR(10), "" )
        *** Error Number
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
      STRTOFILE( lcTxt + CHR(13) + CHR(10), "errTxt.txt", .T. )
    ENDIF
    *** Tidy Up
    SELECT (lnSelect)
    RETURN
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

ENDDEFINE

***********************************************************************
*** "Buffer" Class Definition
***********************************************************************
DEFINE CLASS xCus AS CUSTOM

  *** Hide unwanted Properties
  PROTECTED Height, HelpContextID, Picture, Readexpression, Readmethod, SaveAsClass 
  PROTECTED ShowWhatsThis, WhatsThisHelp, WhatsThisHelpID, Width, Writeexpression, WriteMethod

ENDDEFINE
