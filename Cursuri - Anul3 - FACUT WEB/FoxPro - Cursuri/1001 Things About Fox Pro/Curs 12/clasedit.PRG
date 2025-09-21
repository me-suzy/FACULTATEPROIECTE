**********************************************************************
* Program....: ClasEdit.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Runs the SCX/VCX Editor inside a loop until no file
*............: is selected in the GetFile() Dialog
**********************************************************************
LOCAL lcSceFile
CLEAR
CLEAR ALL
CLOSE ALL

*** Close any open libraries
SET CLASSLIB TO

*** And SCX/VCX Files
IF USED('vcxedit')
	USE IN vcxedit
ENDIF

*** Initialise the control variable
DO WHILE .T.
	*** Get Source File Name
	lcSceFile = GETFILE( 'SCX;VCX' )
	IF EMPTY(lcSceFile)
		EXIT
	ENDIF

	*** Open Source file and set buffer mode to Optimistic Table
	USE (lcSceFile) IN 0 ALIAS vcxedit EXCLUSIVE
	CURSORSETPROP( 'Buffering', 5 )

	*** Run the form
	DO FORM ClasEdit WITH lcSceFile
	READ EVENTS

    *** Compile the SCX/VCX File
    IF JUSTEXT( lcSceFile ) = "SCX"
        COMPILE FORM (lcSceFile)
    ELSE
        COMPILE CLASSLIB (lcSceFile)
    ENDIF
ENDDO
