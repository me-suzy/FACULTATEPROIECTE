***********************************************************************
* Program....: DELETEREG.PRG
* Date.......: 04 February 2002
* Compiler...: Visual FoxPro 07.00.0000.9465 for Windows 
* Purpose....: Example program to delete the set of keys created by WriteReg
***********************************************************************
LOCAL oReg, llRetVal, lcSubKey
*** Define Root Key values here
#DEFINE loc_MRoot     2 && This is our internal ID for HKEY_LOCAL_MACHINE
#DEFINE loc_URoot     1 && This is our internal ID for HKEY_CURRENT_USER

*** Create the registry object first
oReg = NEWOBJECT( 'xRegBase', 'mfregistry.prg' )
WITH oReg
  ********************************************************************
  *** Delete the registration key: First set the correct Root Key
  *** Note that you cannot skip levels, each level must be deleted individually
  ********************************************************************
  llRetVal = .SetRootKey( loc_MRoot )
  IF NOT llRetVal
    *** Could not set key, display reasons and exit
    .ShowErrors()
    RETURN llRetVal
  ENDIF
  
  ********************************************************************
  *** Define the lowest level key here
  ********************************************************************
  lcSubKey = "SOFTWARE\MegaFox\DemoApp\Registration"
  DelKey( lcSubKey, oReg )

  ********************************************************************
  *** Now set up to delete the "User Defaults"
  ********************************************************************
  llRetVal = .SetRootKey( loc_URoot )
  IF NOT llRetVal
    *** Could not set key, display reasons and exit
    oReg.ShowErrors()
    RETURN llRetVal
  ENDIF

  ********************************************************************
  *** Define the lowest level key here
  ********************************************************************
  lcSubKey = "SOFTWARE\MegaFox\DemoApp\Defaults"
  DelKey( lcSubKey, oReg )
ENDWITH
  

FUNCTION DelKey( tcKeyName, toReg )
LOCAL lcSubKey, lnPos
lcSubKey = tcKeyName
DO WHILE .T.
  *** Try to delete lowest level key
  llRetVal = toReg.DeleteKey( lcSubKey )
  IF NOT llRetVal
    *** Nothing left to delete
    EXIT
  ENDIF
  *** Now work back to the parent key
  lnPos = RAT( "\", lcSubKey ) - 1
  lcSubKey = LEFT( lcSubKey, lnPos )
ENDDO
RETURN