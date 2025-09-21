**********************************************************************
* Program....: ChgCursor.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Changes the specified cursor to the specified .cur or .ani file 
**********************************************************************
LPARAMETERS tcCursorFile, tnCursorType
LOCAL lcNewCursor

*** Define constants for cusor types (taken from Winuser.h
#DEFINE OCR_NORMAL          32512
#DEFINE OCR_IBEAM           32513
#DEFINE OCR_WAIT            32514
#DEFINE OCR_CROSS           32515
#DEFINE OCR_UP              32516
#DEFINE OCR_SIZENWSE        32642
#DEFINE OCR_SIZENESW        32643
#DEFINE OCR_SIZEWE          32644
#DEFINE OCR_SIZENS          32645
#DEFINE OCR_SIZEALL         32646
#DEFINE OCR_NO              32648
#DEFINE OCR_HAND            32649
#DEFINE OCR_APPSTARTING     32650

SET ASSERTS ON

ASSERT VARTYPE( tcCursorFile ) = 'C' MESSAGE 'Must Pass a File Name to ChgCursor.Prg'
ASSERT VARTYPE( tnCursorType ) = 'N' MESSAGE 'Must Pass a Numeric Cursor Type to ChgCursor.Prg'

*** Validate Parameters
IF INLIST( JUSTEXT( tcCursorFile ), 'CUR', 'ANI' )
	IF FILE( tcCursorFile )
		DECLARE INTEGER LoadCursorFromFile in Win32Api String
		DECLARE SetSystemCursor in Win32Api Integer, Integer
 
		lcNewCursor = LoadCursorFromFile( tcCursorFile )
		SetSystemCursor( lcNewCursor, tnCursorType )
	ENDIF
ENDIF