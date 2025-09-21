**********************************************************************
* Program....: ShoList.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Demonstration of the Listbox Progress class in ListProg.VCX
**********************************************************************
*** Create and show the toolbar object
SET CLASSLIB TO listprog ADDITIVE
oProg = CREATEOBJECT('tbrproglist')
*** Set the Toolbar Caption and Show It
oProg.Caption = "Reporting Process Progress"
oProg.Visible = .T.
*** Progress Items
oProg.Update( TIME() + ": Initialising Process" )
Waitabit(1)
oProg.Update( TIME() + ": Opening Data Files" )
Waitabit(1.5)
oProg.Update( TIME() + ": Starting Data Import" )
Waitabit(1.5)
oProg.Update( TIME() + ": Calculating Totals" )
Waitabit(1.5)
*** Additional Parameter does an Overwrite rather than adding new items!!!
oProg.Update( TIME() + ": Processing Record " + PADL(0,3))
FOR lnCnt = 1 TO 10
    oProg.Update( TIME() + ": Processing Record " + PADL(lnCnt,3), .T.)
    Waitabit(.5)
NEXT
oProg.Update( TIME() + ": Closing Data Files" )
Waitabit(1.5)
oProg.Update( TIME() + ": Completed" )
Waitabit(2)

PROCEDURE waitabit( lnTime )
LOCAL lnCnt
INKEY (lnTime, 'H')
RETURN