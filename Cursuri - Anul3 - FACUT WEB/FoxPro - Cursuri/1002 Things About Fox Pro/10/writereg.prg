***********************************************************************
* Program....: WRITEREG.PRG
* Date.......: 04 February 2002
* Compiler...: Visual FoxPro 07.00.0000.9465 for Windows 
* Purpose....: Example program to create a set of keys for an application
***********************************************************************
LOCAL oReg, llRetVal, lcSubKey, lcValue, luData
*** Define a few values here
#DEFINE loc_AppName   "MFDemo"
#DEFINE loc_KeyRoot   "SoftWare\MegaFox\DemoApp"
#DEFINE loc_RegKey    "\Registration"
#DEFINE loc_SetKey    "\Defaults"
#DEFINE loc_MRoot     2 && This is our internal ID for HKEY_LOCAL_MACHINE
#DEFINE loc_URoot     1 && This is our internal ID for HKEY_CURRENT_USER

*** Create the registry object first
oReg = NEWOBJECT( 'xRegBase', 'mfregistry.prg' )
WITH oReg
  ********************************************************************
  *** Do the registration key: First set the correct Root Key
  ********************************************************************
  llRetVal = .SetRootKey( loc_MRoot )
  IF NOT llRetVal
    *** Could not set key, display reasons and exit
    oReg.ShowErrors()
    RETURN llRetVal
  ENDIF
  ********************************************************************
  *** Next Set up the "Registration" information
  ********************************************************************
  lcSubKey = loc_KeyRoot + loc_RegKey
  lcValue  = loc_AppName
  luData   = "MFDEM-CH10S-WR1T5"
  llRetVal = oReg.SetRegKey( lcValue, luData, lcSubKey, .T. )
  IF NOT llRetVal
    *** Could not create Registration data, display reasons and exit
    oReg.ShowErrors()
    RETURN llRetVal
  ENDIF
  ********************************************************************
  *** Now set up to do the "User Defaults" in the same way
  ********************************************************************
  llRetVal = .SetRootKey( loc_URoot )
  IF NOT llRetVal
    *** Could not set key, display reasons and exit
    oReg.ShowErrors()
    RETURN llRetVal
  ENDIF
  ********************************************************************
  *** Create the necessary key here
  ********************************************************************
  lcSubKey = loc_KeyRoot + loc_SetKey
  lcValue  = "Installed"
  luData   = TTOC( DATETIME() )
  llRetVal = oReg.SetRegKey( lcValue, luData, lcSubKey, .T. )
  IF NOT llRetVal
    *** Could not set key, display reasons and exit
    oReg.ShowErrors()
    RETURN llRetVal
  ENDIF
  ********************************************************************
  *** Now let's get a couple of User Settings and set them as defaults
  *** We could, of course, use ListOptions() and get a bunch at once but...
  ********************************************************************
  *** Read the Country setting from the International section
  lcSubKey = "Control Panel\International"
  lcValue  = "sCountry"
  luData   = oReg.Getregkey( lcValue, lcSubKey )
  *** And write it out to our key
  lcSubKey = loc_KeyRoot + loc_SetKey
  lcValue  = "Country"
  llRetVal = oReg.SetRegKey( lcValue, luData, lcSubKey, .T. )
  IF NOT llRetVal
    *** Could not set key, display reasons and exit
    oReg.ShowErrors()
    RETURN llRetVal
  ENDIF
  *** Read the Highlighting settings from the Colors section
  *** Background Color
  lcSubKey = "Control Panel\Colors"
  lcValue  = "HiLight"
  luData   = oReg.Getregkey( lcValue, lcSubKey )
  *** And write it out to our key
  lcSubKey = loc_KeyRoot + loc_SetKey
  lcValue  = "SelectedBackColor"
  luData   = EVALUATE( "RGB(" + STRTRAN( luData, " ", "," ) + ")")
  llRetVal = oReg.SetRegKey( lcValue, luData, lcSubKey, .T. )
  IF NOT llRetVal
    *** Could not set key, display reasons and exit
    oReg.ShowErrors()
    RETURN llRetVal
  ENDIF
  *** Foreground Color
  lcSubKey = "Control Panel\Colors"
  lcValue  = "HilightText"
  luData   = oReg.Getregkey( lcValue, lcSubKey )
  *** And write it out to our key
  lcSubKey = loc_KeyRoot + loc_SetKey
  lcValue  = "SelectedForeColor"
  luData   = EVALUATE( "RGB(" + STRTRAN( luData, " ", "," ) + ")")
  llRetVal = oReg.SetRegKey( lcValue, luData, lcSubKey, .T. )
  IF NOT llRetVal
    *** Could not set key, display reasons and exit
    oReg.ShowErrors()
    RETURN llRetVal
  ENDIF
   
ENDWITH

    
