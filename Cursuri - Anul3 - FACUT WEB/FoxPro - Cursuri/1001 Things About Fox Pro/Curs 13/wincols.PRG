**********************************************************************
* Program....: WinCols.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the number of colors available 
**********************************************************************
LOCAL lnHWND, lnBitsPixel, lnDeviceContext

*** Declare API Functions
DECLARE INTEGER GetActiveWindow IN WIN32API
DECLARE INTEGER GetDC IN Win32Api ;
				INTEGER nWHnd
DECLARE INTEGER GetDeviceCaps IN Win32Api ;	
				INTEGER nDeviceContext, ;
				INTEGER nValueToGet

*** Get the Windows Handle for the Active Window
lnHWND = GetActiveWindow()

*** Now get the number of available colors
*** First get the device context for the current window
lnDeviceContext = GetDC( lnHWND )

*** Then get number of color bits per pixel
lnBitsPixel = GetDeviceCaps( lnDeviceContext, 12)

*** Return Result
RETURN (2 ^ lnBitsPixel)
