**********************************************************************
* Program....: FindExec.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Returns the full path and file name of the windows exe
* ...........: which is associated with the specified function
**********************************************************************
LPARAMETERS tcExt
LOCAL lcRetVal, lcFileExt, lcFileName, lnFileHandle, lcPath, lcResBuff
STORE "" TO lcRetVal, lcFileExt, lcFileName, lcPath
*** Check that an extension is passed
IF VARTYPE( tcExt ) # "C" OR EMPTY( tcExt )
    ERROR "9000: Must pass a file extension to FindExec()"
    RETURN lcRetVal
ELSE
    lcFileExt = UPPER( ALLTRIM( tcExt ))
ENDIF

*** This function MUST have a file of the requisite type
*** So create one right here (just temporary)!
lcFileName = "DUMMY." + lcFileExt
lnFileHandle = FCREATE( lcFileName )
IF lnFileHandle < 1
    *** Cannot create file
    ERROR "9000: Unable to create file.  FindExec() must stop" ;
          + CHR(13) + "Check that you have the necessary rights for file creation"
    RETURN lcRetVal
ENDIF
FCLOSE( lnFileHandle )

*** Create the return value buffer and declare the API Function
lcResBuff = SPACE(128)
DECLARE INTEGER FindExecutable IN SHELL32 ;
         STRING @cFileName, ;
         STRING @cPath, ;
         STRING @cBuffer

*** Now call it with our dummy filename, and no path
lnRetVal = FindExecutable( @lcFileName, @lcPath, @lcResBuff)

*** Check the return value
lcMsgTxt = ""
DO CASE
    CASE lnRetVal = 0
        lcMsgTxt = "Out of memory or resources"
   CASE lnRetVal = 31
        lcMsgTxt = "No association for file type " + lcFileExt
   CASE lnRetVal = 2
        lcMsgTxt = "Specified file not found"
   CASE lnRetVal = 3
        lcMsgTxt = "Specified path not found"
   CASE lnRetVal = 11
        lcMsgTxt = "Invalid EXE format"
   OTHERWISE
        *** We got something back
        *** String is Null-terminated in the result buffer so:
        lcRetVal = LEFT(lcResBuff, AT(CHR(0), lcResBuff) - 1)
ENDCASE

*** Delete the dummy file we created.
DELETE FILE (lcFileName)

*** Display Results and return
IF ! EMPTY( lcMsgTxt )
    MESSAGEBOX( lcMsgTxt, 16, "FindExec Failed" )
ENDIF
RETURN lcRetVal
