***********************************************************************
* Program....: GenHTMLbyProxy
* Author.....: Marcia G. Akins
* Date.......: 13 February 2002
* Notice.....: Copyright (c) 2002 Tightline Computers Inc, All Rights Reserved.
* Compiler...: Visual FoxPro 07.00.0000.9400 for Windows 
* Purpose....: Called by proxy dll to generate web pages
***********************************************************************
FUNCTION PassItOn( tcParms )
LOCAL loPageGen, lcHTML, lcCmd
*** Create an  instance of the HTML generator
loPageGen = NEWOBJECT( 'SesGenPage', 'GenerateHTML.prg' )
*** Pass it on
IF VARTYPE( loPageGen ) = 'O'
  *** Construct the method call
  lcCmd = 'loPageGen.' + tcParms
  lcHTML = &lcCmd
ELSE
	lcHTML = FILETOSTR( 'Error.txt' )
ENDIF
RETURN lcHTML
	
