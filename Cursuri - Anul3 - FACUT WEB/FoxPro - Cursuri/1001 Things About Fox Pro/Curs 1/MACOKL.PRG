******************************************************************************
* Program....: MACOKL.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Illustrate the difference between a keyboard macro
* ...........: and an On Key Label command
******************************************************************************
*** Define an On Key Label
ON KEY LABEL F10 SUSPEND
CLEAR
*** Initialise Key Buffer
LOCAL lnKey
lnKey = 0
*** Start Loop
DO WHILE .T.
    *** Check for 'x' to exit
    ? "Inside an OKL loop"
    @ 10,10 GET lnKey PICT "99"
    READ
    IF lnKey = 99
        EXIT
    ENDIF
ENDDO
*** Clear the OKL
ON KEY LABEL F10
CLEAR

*** Now define a Function Key Macro
SET FUNCTION 10 TO "SUSPEND;"
*** Initialise Key Buffer
lnKey = 0
*** Start Loop
DO WHILE .T.
    *** Check for 'x' to exit
    ? "Inside a F10 loop"
    @ 10,10 GET lnKey PICT "99"
    READ
    IF lnKey = 99
        EXIT
    ENDIF
ENDDO
*** Clear the macro
SET FUNCTION 10 TO ""
