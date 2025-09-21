**********************************************************************
* Program....: GetWCol.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the Red, Green, and Blue color values for a 
* ...........: given numbered Windows Object Color
**********************************************************************
LPARAMETERS tnObjectNumber
*** Check Parameter
IF VARTYPE( tnObjectNumber ) # "N" OR ! BETWEEN( tnObjectNumber, 0, 28)
    WAIT WINDOW "Must pass windows color number between 0 and 28" NOWAIT
    RETURN
ENDIF

*** Get the required color setting
DECLARE INTEGER GetSysColor IN Win32API ;
				INTEGER nObject
lnWinCol = GetSysColor(tnObjectNumber)

*** Convert to RGB Values
lnSq256 = 256 ^ 2
lnRedGrn = MOD( lnWinCol, lnSq256 )

*** Now get the individual components
lcBlue   = TRANSFORM( INT( lnWinCol/lnSq256 ) )
lcGreen  = TRANSFORM( INT( lnRedGrn/256) )
lcRed    = TRANSFORM( MOD( lnRedGrn,256) )

*** Return RGB string
RETURN (lcRed + "," + lcGreen + "," + lcBlue)

*!* Here are the color numbers (from WINUSER.H):
*!*	 #define COLOR_SCROLLBAR         0
*!*	 #define COLOR_BACKGROUND        1
*!*	 #define COLOR_ACTIVECAPTION     2
*!*	 #define COLOR_INACTIVECAPTION   3
*!*	 #define COLOR_MENU              4
*!*	 #define COLOR_WINDOW            5
*!*	 #define COLOR_WINDOWFRAME       6
*!*	 #define COLOR_MENUTEXT          7
*!*	 #define COLOR_WINDOWTEXT        8
*!*	 #define COLOR_CAPTIONTEXT       9
*!*	 #define COLOR_ACTIVEBORDER      10
*!*	 #define COLOR_INACTIVEBORDER    11
*!*	 #define COLOR_APPWORKSPACE      12
*!*	 #define COLOR_HIGHLIGHT         13
*!*	 #define COLOR_HIGHLIGHTTEXT     14
*!*	 #define COLOR_BTNFACE           15
*!*	 #define COLOR_BTNSHADOW         16
*!*	 #define COLOR_GRAYTEXT          17
*!*	 #define COLOR_BTNTEXT           18
*!*	 #define COLOR_INACTIVECAPTIONTEXT 19
*!*	 #define COLOR_BTNHIGHLIGHT      20
*!*	 #define COLOR_3DDKSHADOW        21
*!*	 #define COLOR_3DLIGHT           22
*!*	 #define COLOR_INFOTEXT          23
*!*	 #define COLOR_INFOBK            24
*!*	 #define COLOR_HOTLIGHT                  26
*!*	 #define COLOR_GRADIENTACTIVECAPTION     27
*!*	 #define COLOR_GRADIENTINACTIVECAPTION   28
*!*  #DEFINE COLOR_DESKTOP           COLOR_BACKGROUND
*!*	 #DEFINE COLOR_3DFACE            COLOR_BTNFACE
*!*  #DEFINE COLOR_3DSHADOW          COLOR_BTNSHADOW
*!*  #DEFINE COLOR_3DHIGHLIGHT       COLOR_BTNHIGHLIGHT
*!*  #DEFINE COLOR_3DHILIGHT         COLOR_BTNHIGHLIGHT
*!*  #DEFINE COLOR_BTNHILIGHT        COLOR_BTNHIGHLIGHT
