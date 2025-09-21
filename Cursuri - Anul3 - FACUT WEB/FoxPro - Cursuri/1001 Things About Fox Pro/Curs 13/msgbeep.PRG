**********************************************************************
* Program....: MsgBeep.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Play the specified system sound as a beep
*			   Note that the beep constants correspond to the MESSAGEBOX Icon constants
**********************************************************************
LPARAMETERS tnBeep

#DEFINE MB_OK                 0
#DEFINE MB_ICONSTOP           16
#DEFINE MB_ICONQUESTION       32
#DEFINE MB_ICONEXCLAMATION    48
#DEFINE MB_ICONINFORMATION    64

DECLARE INTEGER MessageBeep IN Win32API INTEGER
MessageBeep( tnBeep )
