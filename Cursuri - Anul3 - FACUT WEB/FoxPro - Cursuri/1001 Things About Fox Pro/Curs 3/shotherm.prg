**********************************************************************
* Program....: ShoTherm.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Demonstration of the Thermometer bar class in ThermBar.VCX
**********************************************************************
*** Create and show the toolbar object
SET CLASSLIB TO thermBar ADDITIVE
oProg = CREATEOBJECT('tbrprog')
*** Set the initial parameters
*** Progress Value, Description and Title (in that order)
oProg.Update( 0, 'Illustrative Process', 'Progress Bar Demonstration' )
oProg.Visible = .T.
FOR lnCnt = 1 TO 100
    oProg.Update( lnCnt, "Processing " + PADL(lnCnt,3))
    FOR j = 1 TO (70000 + lnCnt)
    NEXT
NEXT
