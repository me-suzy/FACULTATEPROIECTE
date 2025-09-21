***********************************************************************
* Begin Extract From Registry.h
***********************************************************************
*** Operating System codes
#DEFINE OS_W32S      1
#DEFINE OS_NT      2
#DEFINE OS_WIN95     3
#DEFINE OS_MAC       4
#DEFINE OS_DOS       5
#DEFINE OS_UNIX      6
#DEFINE OS_WIN2K     7

*** DLL Paths for various operating systems
#DEFINE DLLPATH_32S    "\SYSTEM\"    &&used for ODBC only
#DEFINE DLLPATH_NT     "\SYSTEM32\"
#DEFINE DLLPATH_WIN95  "\SYSTEM\"
#DEFINE DLLPATH_WIN2K  "\SYSTEM32\"

*** DLL files used to read INI files
#DEFINE DLL_KERNEL_W32S  "W32SCOMB.DLL"
#DEFINE DLL_KERNEL_NT  "KERNEL32.DLL"
#DEFINE DLL_KERNEL_WIN95 "KERNEL32.DLL"
#DEFINE DLL_KERNEL_WIN2K "KERNEL32.DLL"

*** DLL files used to read registry
#DEFINE DLL_ADVAPI_W32S  "W32SCOMB.DLL"
#DEFINE DLL_ADVAPI_NT  "ADVAPI32.DLL"
#DEFINE DLL_ADVAPI_WIN95 "ADVAPI32.DLL"
#DEFINE DLL_ADVAPI_WIN2K "ADVAPI32.DLL"

*** DLL files used to read ODBC info
#DEFINE DLL_ODBC_W32S     "ODBC32.DLL"
#DEFINE DLL_ODBC_NT     "ODBC32.DLL"
#DEFINE DLL_ODBC_WIN95    "ODBC32.DLL"
#DEFINE DLL_ODBC_WIN2K    "ODBC32.DLL"

*** Registry roots
#DEFINE HKEY_CLASSES_ROOT   -2147483648  && BITSET(0,31)
#DEFINE HKEY_CURRENT_USER   -2147483647  && BITSET(0,31)+1
#DEFINE HKEY_LOCAL_MACHINE  -2147483646  && BITSET(0,31)+2
#DEFINE HKEY_USERS      -2147483645  && BITSET(0,31)+3

*** Misc
#DEFINE APP_PATH_KEY    "\Shell\Open\Command"
#DEFINE OLE_PATH_KEY    "\Protocol\StdFileEditing\Server"
#DEFINE VFP_OPTIONS_KEY   "Software\Microsoft\VisualFoxPro\7.0\Options"
#DEFINE VFP_OPTIONS_KEY1  "Software\Microsoft\VisualFoxPro\"
#DEFINE VFP_OPTIONS_KEY2  "\Options"
#DEFINE VFP_OPT32S_KEY    "VisualFoxPro\7.0\Options"
#DEFINE CURVER_KEY      "\CurVer"
#DEFINE ODBC_DATA_KEY     "Software\ODBC\ODBC.INI\"
#DEFINE ODBC_DRVRS_KEY    "Software\ODBC\ODBCINST.INI\"
#DEFINE SQL_FETCH_NEXT    1
#DEFINE SQL_NO_DATA     100

*** Error Codes
#DEFINE ERROR_SUCCESS     0  && OK
#DEFINE ERROR_EOF       259 && no more entries in key

*** Note these next error codes are specific to this Class, not DLL
#DEFINE ERROR_NOAPIFILE   -101  && DLL file to check registry not found
#DEFINE ERROR_KEYNOREG    -102  && key not registered
#DEFINE ERROR_BADPARM     -103  && bad parameter passed
#DEFINE ERROR_NOENTRY     -104  && entry not found
#DEFINE ERROR_BADKEY    -105  && bad key passed
#DEFINE ERROR_NONSTR_DATA   -106  && data type for value is not a data string
#DEFINE ERROR_BADPLAT     -107  && platform not supported
#DEFINE ERROR_NOINIFILE   -108  && DLL file to check INI not found
#DEFINE ERROR_NOINIENTRY  -109  && No entry in INI file
#DEFINE ERROR_FAILINI     -110  && failed to get INI entry
#DEFINE ERROR_NOPLAT    -111  && call not supported on this platform
#DEFINE ERROR_NOODBCFILE  -112  && DLL file to check ODBC not found
#DEFINE ERROR_ODBCFAIL    -113  && failed to get ODBC environment

*** Data types for keys
#DEFINE REG_SZ        1  && Data string
#DEFINE REG_BINARY      3  && Binary data in any form.
#DEFINE REG_DWORD       4  && A 32-bit number.

*** Data types labels
#DEFINE REG_BINARY_LOC    "*Binary*"      && Binary data in any form.
#DEFINE REG_DWORD_LOC     "*Dword*"      && A 32-bit number.
#DEFINE REG_UNKNOWN_LOC   "*Unknown type*"  && unknown type

*** FoxPro ODBC drivers
#DEFINE FOXODBC_25      "FoxPro Files (*.dbf)"
#DEFINE FOXODBC_26      "Microsoft FoxPro Driver (*.dbf)"
#DEFINE FOXODBC_30      "Microsoft Visual FoxPro Driver"
***********************************************************************
* End Extract From Registry.h
* Begin Registry Class Definition
***********************************************************************
DEFINE CLASS RegMgr AS custom
  *** Set up the properties
  nUserKey = HKEY_CURRENT_USER
  nCurrentKey = 0
  nVersion = 7
  cVFPOpt  = VFP_OPTIONS_KEY
  cRegDLLFile = ""
  cINIDLLFile = ""
  cODBCDLLFile = ""
  cAppPathKey = ""
  lLoadedDLLs = .F.
  lLoadedINIs = .F.
  lLoadedODBCs = .F.
  lCreateKey = .F.
  lhaderror = .F.

  PROCEDURE Init( tnRootKey )
	  IF VARTYPE(tnRootKey) # "N" OR EMPTY( tnRootKey )
	  	*** Default to HKEY_CURRENT_USER
			  tnRootKey = 1
    ENDIF
    *** Check Operating System Version and populate properties
    IF ! This.ChkVersion( tnRootKey )
      *** Not running in windows!
      RETURN .F.
    ENDIF
  ENDPROC

  PROCEDURE ChkVersion( tnRootKey )
    WITH This
    	DO CASE
    		CASE tnRootKey = 1 
    			.nUserKey = HKEY_CURRENT_USER
    		CASE tnRootKey = 2 
    			.nUserKey = HKEY_LOCAL_MACHINE
    		CASE tnRootKey = 3 
    			.nUserKey = HKEY_USERS
    		CASE tnRootKey = 4 
    			.nUserKey = HKEY_CLASSES_ROOT
    		OTHERWISE 
    			*** This is the default
    			.nUserKey = HKEY_CURRENT_USER
    	ENDCASE	
			*** Store VFP Root Path
      .cVFPOpt = VFP_OPTIONS_KEY1 + _VFP.VERSION + VFP_OPTIONS_KEY2
			*** Check operating system version
      DO CASE
        CASE _DOS OR _UNIX OR _MAC
          RETURN .F.
        CASE ATC("Windows 5", OS(1)) # 0
          *** Windows 2000
          This.nVersion = OS_WIN2K
          This.cRegDLLFile = DLL_ADVAPI_WIN2K
          This.cINIDLLFile = DLL_KERNEL_WIN2K
          This.cODBCDLLFile = DLL_ODBC_WIN2K
        CASE ATC("Windows NT",OS(1)) # 0
          This.nVersion = OS_NT
          This.cRegDLLFile = DLL_ADVAPI_NT
          This.cINIDLLFile = DLL_KERNEL_NT  
          This.cODBCDLLFile = DLL_ODBC_NT
        OTHERWISE
          * Windows 95 or Windows 98 (Both Versions)
          This.nVersion = OS_WIN95
          This.cRegDLLFile = DLL_ADVAPI_WIN95
          This.cINIDLLFile = DLL_KERNEL_WIN95
          This.cODBCDLLFile = DLL_ODBC_WIN95
      ENDCASE
    ENDWITH
    RETURN .T.
  ENDPROC
  
  PROCEDURE Error( nError, cMethod, nLine )
     This.lhaderror = .T.
		DODEFAULT()
  ENDPROC

  PROCEDURE LoadAPICalls
    *** Loads the functions needed for Registry Management
    IF This.lLoadedDLLs
      RETURN ERROR_SUCCESS
    ENDIF

    DECLARE INTEGER RegOpenKey IN Win32API ;
      INTEGER nHKey, STRING @cSubKey, INTEGER @nResult

    IF This.lhaderror && error loading library
      RETURN -1
    ENDIF

		*** Open the specified key. Non-zero return indicates failure
		*** Required for backward compatibility
		DECLARE INTEGER RegOpenKey IN Win32API ;
			INTEGER lnHKey, ;   && Handle to an already open key
			STRING @lcSubKey, ; && Sub-key name
			Integer @lnResult   && Handle to specified key

		*** Open the specified key. Non-zero return indicates failure
		DECLARE INTEGER RegOpenKeyEx IN Win32API ;
		  INTEGER lnHKey, ;  && Handle to an already open key
		  STRING @lcSubKey, ;  && Subkey name
		  INTEGER lnOptions, ; && Reserved (must be = 0)
		  INTEGER lnSAM, ;   && Security access mask
		  INTEGER @lnResult  && Handle to specified key
		*** Security Access Mask Settings
		***KEY_QUERY_VALUE = 1
		***KEY_SET_VALUE = 2
		***KEY_CREATE_SUB_KEY = 4
		***KEY_ENUMERATE_SUB_KEYS = 8
		***KEY_NOTIFY = 16
		***KEY_CREATE_LINK = 32

		*** Create and/or Open the specified key. Non-zero return indicates failure
		*** Required for backward compatibility
		DECLARE INTEGER RegCreateKey IN Win32API ;
		  INTEGER lnHKey, ;   && Handle to an already open key
		  STRING @lcSubKey, ;   && Sub-key name
		  INTEGER @lnResult   && Handle to specified key

		*** Create and/or Open the specified key. Non-zero return indicates failure
		DECLARE INTEGER RegCreateKeyEx IN Win32API ;
		  INTEGER lnHKey, ;   && Handle to an already open key
		  STRING @lcSubKey, ;   && Sub-key name
		  INTEGER lnOptions, ;  && Reserved (must be = 0)
		  STRING lcClass, ;   && Class string (Future use, pass Null String)
		  INTEGER lnOptions, ;  && Special options
		  INTEGER lnSAM, ;    && Security access mask (see above)
		  STRING lcSecAttrib, ; && Pass NULL for Defaults
		  INTEGER @lnResult, ;  && Handle to specified key
		  INTEGER @lnStatus   && Key Status ( 1 = New Key, 2 = Opened Existing)

		*** Special Options
		*** REG_OPTION_NON_VOLATILE   0  && Key is preserved when system is rebooted
		*** REG_OPTION_VOLATILE     1  && Key is not preserved when system is rebooted
		*** REG_OPTION_BACKUP_RESTORE   4  && Open for backup or restore special access rules privilege required

		*** Close the specified key
		DECLARE Integer RegCloseKey IN Win32API ;
		  INTEGER lnHKey    && Handle to an already open key

		*** Delete the specified Sub Key
		DECLARE Integer RegDeleteKey IN Win32API ;
		  INTEGER lnHKey, ;   && Handle to an already open key
		  STRING @lcSubKey  && Subkey name

		*** Sets and/or Adds the specified value to a key
		DECLARE Integer RegSetValueEx IN Win32API ;
		  INTEGER lnHKey, ;   && Handle to an already open key
		  STRING @lcValName, ;  && ValueName (If NULL or "", sets the DEFAULT value)
		  INTEGER lnOptions, ;  && Reserved (must be = 0)
		  INTEGER lnDataType, ; && Data Type to Store
		  STRING @lcData, ;   && Pointer to Data to be inserted
		  INTEGER lnData    && Length of the data string

		*** Registry Data Types
		*** REG_NONE             0  && No defined value type
		*** REG_SZ               1  && A null-terminated string. 
		*** REG_EXPAND_SZ          2  && A null-terminated string that contains unexpanded references to environment variables (for example, "%PATH%").  
		*** REG_BINARY             3  && Binary data in any form
		*** REG_DWORD            4  && 32-bit number
		*** REG_DWORD_LITTLE_ENDIAN      4  && 32-bit number (same as REG_DWORD)
		*** REG_DWORD_BIG_ENDIAN       5  && 32-bit number (See MSDN for Explanation - made no sense to me!)
		***	REG_LINK             6  && A Unicode symbolic link. Used internally; applications should not use this type
		***	REG_MULTI_SZ           7  && An array of null-terminated strings, terminated by two null characters
		***	REG_RESOURCE_LIST        8  && A device-driver resource list

		*** Get Data Type and Value for the specified item in a key
		DECLARE Integer RegQueryValueEx IN Win32API ;
		  INTEGER lnHKey, ;    && Handle to an already open key
		  STRING lcValName, ;  && ValueName (If NULL or "", sets the DEFAULT value)
		  INTEGER lnOptions, ;   && Reserved (must be = 0)
		  INTEGER @lnDataType, ; && Buffer to receive Registry Data Type of the Value
		  STRING @lcData, ;    && Buffer to receive the Value
		  INTEGER @lnData    && Buffer to receive the length of the returned Value

		*** Enumerates subkeys of the specified open registry key. The function retrieves the name of one subkey each time it is called. 
		*** Returns ERROR_NO_MORE_ITEMS = 0x259 (601) When no more items exist
		*** Required for backward compatibility
		DECLARE Integer RegEnumKey IN Win32API ;
		  INTEGER lnHKey, ;    && Handle to an already open key
		  INTEGER lnSubKey, ;  && Index into the Subkeys
		  STRING @lcData, ;    && Buffer to receive the Name of the specified sub-key
		  INTEGER lnData     && Length of the data string buffer

		*** Enumerates subkeys of the specified open registry key. 
		*** The function retrieves the name of one subkey each time it is called. 
		*** Returns ERROR_NO_MORE_ITEMS = 0x259 (601) When no more items exist
		DECLARE Integer RegEnumKeyEx IN Win32API ;
		  INTEGER lnHKey, ;    && Handle to an already open key
		  INTEGER lnSubKey, ;  && Index into the Subkeys
		  STRING @lcData, ;    && Buffer to receive the Name of the specified sub-key
		  INTEGER @lnData, ;   && Buffer to receive the length of the returned Value
		  INTEGER lnOptions, ;   && Reserved (must be = 0)
		  STRING lcClass, ;    && Class string (Future use, pass Null String)
		  INTEGER lnClass, ;   && Size of Class String Buffer (Future use, pass NULL )
		  STRING @lcTime     && Buffer to receive last write time

		*** Enumerates the values for the specified open registry key. 
		*** The function copies one indexed value name and data block for the key each time it is called. 
		*** Returns ERROR_NO_MORE_ITEMS = 0x259 (601) When no more items exist
		DECLARE Integer RegEnumValue IN Win32API ;
		  INTEGER lnHKey, ;    && Handle to an already open key
		  INTEGER lnSubKey, ;  && Index into the Subkeys
		  STRING @lcData, ;    && Buffer to receive the Name of the specified sub-key
		  INTEGER @lnData, ;   && Buffer to receive the length of the returned name
		  INTEGER lnOptions, ;   && Reserved (must be = 0)
		  INTEGER @lnDataType, ; && Buffer to receive Registry Data Type of the Value
		  STRING @lcData, ;    && Buffer to receive the Value
		  INTEGER @lnData    && Buffer to receive the length of the returned Value

    *** Set Flag to avoid re-loading things over and over again
    This.lLoadedDLLs = .T.
    RETURN ERROR_SUCCESS
  ENDPROC

  FUNCTION IsKey( tcKeyName, tnRegKey )
    *** Check existence of a key
    LOCAL llRetVal, lnErrNum
    *** Try and open the key
    lnErrNum = This.OpenKey( tcKeyName, tnRegKey)
    IF lnErrNum  = ERROR_SUCCESS
      *** Close the key
      This.CloseKey()
      llRetVal = .T.
    ENDIF
    *** Return a logical Value for this one
    RETURN lLRetVal
  ENDFUNC

  PROCEDURE OpenKey( tcSubKey, tnParentKey, tlCreateKey )
    *** Open a registry key and make it 'current'
    LOCAL lnErrCode, lnSubKey, lnPCount, llKeyWas
    STORE 0 TO lnErrNum, lnSubKey 
    lnPCount = PCOUNT()

    *** Check parameters
    IF VARTYPE( tnParentKey ) # "N" OR EMPTY( tnParentKey )
      *** Default to Class Root
      tnParentKey = HKEY_CLASSES_ROOT
    ENDIF

    IF VARTYPE( tcSubKey ) # 'C' OR EMPTY( tcSubKey )
      *** Default to Null String
      tcSubKey = ""
    ENDIF
    
    *** Check API Functions
    lnErrNum = This.LoadAPICalls()
    IF lnErrNum # ERROR_SUCCESS
      RETURN lnErrNum
    ENDIF

    *** Now go ahead and open the key
    IF tlCreateKey
      *** Allow Key Creation
      *** Save the default setting
      llKeyWas = This.lCreateKey
      This.lCreateKey = tlCreateKey
      *** Create the key if it isn't already there
      lnErrNum = RegCreateKey( tnParentKey, tcSubKey, @lnSubKey )
      *** Restore the original setting
      This.lCreateKey = llKeyWas
    ELSE
      *** Open it only if there, otherwise error!
      lnErrNum = RegOpenKey( tnParentKey, tcSubKey, @lnSubKey)
    ENDIF

    IF lnErrNum # ERROR_SUCCESS
      RETURN lnErrNum
    ENDIF

    *** If we get here, it was opened, so make it current
    This.nCurrentKey = lnSubKey
    RETURN ERROR_SUCCESS
  ENDPROC

  PROCEDURE CloseKey()
    *** Closes the current key
    =RegCloseKey(This.nCurrentKey)
    This.nCurrentKey =0
  ENDPROC

  PROCEDURE SetRegKey( tcOptName, tcOptVal, tcKeyPath, tnUserKey )
    *** Opens the specified key and sets the named value
    LOCAL liPos, lcOptKey, lcOption, lnErrNum
    liPos = 0
    lcOption = ""
    lnErrNum = ERROR_SUCCESS

    *** Open registry key and make it "current"
    lnErrNum = This.OpenKey( tcKeyPath, tnUserKey )
    IF lnErrNum # ERROR_SUCCESS
      RETURN lnErrNum
    ENDIF

    *** Set Key value
     lnErrNum = This.SetKeyValue( tcOptName, tcOptVal )

    *** And Close the key
     This.CloseKey()
     RETURN lnErrNum
  ENDPROC

  PROCEDURE GetRegKey( tcKeyItem, tcKeyValue, tcSubKey, tnParentKey )
    *** Return the value of the specified key
    lnPos = 0
    lcOption = ""
    lnErrNum = ERROR_SUCCESS

    *** Open the key first
    lnErrNum = This.OpenKey( tcSubKey, tnParentKey)
    IF lnErrNum # ERROR_SUCCESS
      RETURN lnErrNum
    ENDIF

    *** If it opened, get the value
    lnErrNum = This.GetKeyValue( tcKeyItem, @tcKeyValue)

    *** Close the key
    This.CloseKey()
    RETURN lnErrNum
  ENDPROC

  PROCEDURE GetKeyValue( tcKeyItem, tcKeyValue )
    LOCAL lnHkey, lnReserved, lnDataType, lnKeyLen, lcKeyVal, lnErrNum
    *** tcKeyItem = element to retrieve
    *** tcKeyValue must be passed by reference to store return value
    *** Get a String Value from a key (REG_SZ Only)

    *** Check Params first
    IF VARTYPE( THIS.nCurrentKey )#'N' OR THIS.nCurrentKey = 0
      RETURN ERROR_BADKEY
    ENDIF
    IF VARTYPE( tcKeyItem ) # "C"
      RETURN ERROR_BADPARM
    ENDIF

    *** Initialise the variables we need here
    lnHkey = This.nCurrentKey
    lnReserved = 0  && Always 0!!!
    lnDataType = 0
    lnKeyLen = 256
    lcKeyVal = SPACE( lnKeyLen )
    *** And call the function
    lnErrNum = RegQueryValueEx( lnHKey, tcKeyItem, lnReserved, @lnDataType, @lcKeyVal, @lnKeyLen )
    IF lnErrNum # ERROR_SUCCESS
      RETURN lnErrNum
    ENDIF

    *** Check that we got a data string
    IF lnDataType # REG_SZ
      RETURN ERROR_NONSTR_DATA
    ENDIF
    *** Otherwise get the value that was returned and pass it back
    tcKeyValue = LEFT( lcKeyVal, (lnKeyLen - 1) )
    RETURN ERROR_SUCCESS
  ENDPROC

  PROCEDURE SetKeyValue( tcKeyItem, tcValue )
    *** Sets the specified key value (Strings only)
    LOCAL lnValueSize 

    DO CASE
      CASE VARTYPE( This.nCurrentKey  ) # 'N' OR EMPTY( This.nCurrentKey )
        RETURN ERROR_BADKEY
      CASE VARTYPE( tcKeyItem ) # "C" OR VARTYPE( tcValue ) # "C"
        RETURN ERROR_BADPARM
      CASE EMPTY( tcKeyItem ) OR EMPTY( tcValue )
        RETURN ERROR_BADPARM
    ENDCASE

    *** Strings must be null-terminated
    tcValue = tcValue + CHR(0)
    lnValueSize = LEN( tcValue )

    *** And try and set the value here
    lnErrNum = RegSetValueEx( This.nCurrentKey, tcKeyItem, 0, REG_SZ, tcValue, lnValueSize)
    IF lnErrNum # ERROR_SUCCESS
      RETURN lnErrNum
    ENDIF

    RETURN lnErrNum
  ENDPROC

  PROCEDURE DeleteKey( tnUserKey, tcKeyPath )
    *** Delete the specified key
	  LOCAL lnErrNum
	  lnErrNum = ERROR_SUCCESS
	  lnErrNum = RegDeleteKey( tnUserKey, tcKeyPath)
	  RETURN lnErrNum
  ENDPROC

   PROCEDURE EnumOptions( taRegItems, tcKeyPath, tnUserKey, tlEnumKeys )
    *** Build an array with all entries for a key
    lnErrNum = ERROR_SUCCESS
    IF PCOUNT() < 4 OR VARTYPE( tlEnumKeys ) # "L"
      tlEnumKeys = .F.
    ENDIF

    *** First, open the key and make it current
    lnErrNum = This.OpenKey( tcKeyPath,tnUserKey)
    IF lnErrNum # ERROR_SUCCESS
      RETURN lnErrNum
    ENDIF

    *** OK, now go through the keys
    IF tlEnumKeys
      *** Names Only 
      lnErrNum = This.EnumKeys( @taRegItems )
    ELSE
      *** Names and Values
      lnErrNum = This.EnumKeyValues( @taRegItems )
    ENDIF

    *** Close the Key immediately
    This.CloseKey()
    RETURN lnErrNum
  ENDPROC


   PROCEDURE EnumKeys( taKeyNames )
     LOCAL lnIndex, lnKeySize, lcNewKey, lnBufSize, lcBuffer, lcRetTime
     *** Retrieves the list of Key names into the specified array
     lnIndex = 0
     DIMENSION taKeyNames[1]
     DO WHILE .T.
      *** Initialise the Parameters
      lnKeySize = 100
      lcNewKey  = SPACE( lnKeySize )
      lnBufSize = 100
      lcBuffer  = SPACE( lnBuffSize )
      lcRetTime = SPACE( lnBuffSize )
      *** Get key name for current index item
      lnErrNum = RegEnumKeyEx( This.nCurrentKey, lnIndex, @lcNewKey, @lnKeySize, ;
                   0, @lcBuffer, @lnBuffSize, @lcRetTime)
      DO CASE
        CASE lnErrNum = ERROR_EOF
          *** No more to process
          EXIT
        CASE lnErrNum # ERROR_SUCCESS
          *** Failed
          EXIT
      ENDCASE
      *** Remove NULL terminator    
      lcNewKey = ALLTRIM( CHRTRAN( lcNewKey, CHR(0), '') )
      
      *** Add result to the Array
      lnALen = ALEN( ALEN( taKeyNames ) )
      IF !EMPTY(taKeyNames[1])
        lnAlen = lnAlen + 1
      ENDIF
      DIMENSION taKeyNames[ lnAlen ]
      taKeyNames[ALEN(taKeyNames)] =  lcNewKey
      
      *** Increment the Key Index
      lnIndex = lnIndex + 1
    ENDDO
    *** If we simply got to the end, it's OK
    IF lnErrNum = ERROR_EOF AND  lnIndex # 0
      lnErrNum = ERROR_SUCCESS
    ENDIF
    RETURN lnErrNum
  ENDPROC

  PROCEDURE EnumKeyValues( taKeyValues)
  LOCAL lnHKey, lnIndex, lnKeyLen, lcKeyBuff, lnDType, lnDatLen, lcDatBuff, lcStr
    *** Names and Values for items within a key
    *** Check we have a key to work with
    IF VARTYPE( This.nCurrentKey ) # 'N' OR EMPTY( This.nCurrentKey )
      RETURN ERROR_BADKEY
    ENDIF

    *** Not supported by Win32s
    IF This.nversion = OS_W32S
      RETURN ERROR_BADPLAT
    ENDIF

    *** Work through the key here
		lnHKey = This.nCurrentKey
    lnIndex = 0
    DO WHILE .T.
      *** Initialise the parameters here for each call
			lnKeyLen  = 256
			lcKeyBuff = SPACE( lnKeyLen )
			lnDType   = 0
			lnDatLen  = 256
			lcDatBuff = SPACE( lnDatLen )		
			*** And now call for the curent Index
      lnErrNum = RegEnumValue( lnHKey, lnIndex, @lcKeyBuff, @lnKeyLen, 0, ;
                               @lnDType, @lcDatBuff, @lnDatLen)
			*** Check Results
      DO CASE
        CASE lnErrNum = ERROR_EOF
          *** No more to process
          EXIT
        CASE lnErrNum # ERROR_SUCCESS
          *** Failed
          EXIT
      ENDCASE
      *** Increment the Index
      lnIndex = lnIndex + 1

      *** Reset the Array
      DIMENSION taKeyValues[ lnIndex, 2]
      *** Get the Name First
      taKeyValues[ lnIndex, 1] = LEFT( lcKeyBuff, lnKeyLen )
      *** Now get value (convert as needed)
      DO CASE
        CASE lnDType = REG_SZ
          *** Character String
          taKeyValues[ lnIndex, 2] = CHRTRAN( LEFT( lcDatBuff, lnDatLen ), CHR(0), '')
        CASE lnDType = REG_DWORD
          *** Convert the return value
					lcStr = ""
          FOR lnCnt = 1 TO lnDatLen
             lcStr = lcStr + PADL( ASC( SUBSTR(lcDatBuff, lnCnt, 1 ) ), 4, '0')
          NEXT
          taKeyValues[ nKeyEntry,2] = lcStr
        OTHERWISE
          taKeyValues[ nKeyEntry,2] = REG_UNKNOWN_LOC
      ENDCASE
    ENDDO

    *** If we simply got to the end, it's OK
    IF lnErrNum = ERROR_EOF AND  lnIndex # 0
      lnErrNum = ERROR_SUCCESS
    ENDIF
    RETURN lnErrNum
  ENDPROC
ENDDEFINE
