**********************************************************************
* Program....: ShoStPro.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Illustrate the problems when using multiple DBCs
**********************************************************************
*** Open up two database containers
CLEAR
OPEN DATA bCH07
OPEN DATA aCH07
*** Call the Store Procs
? "Current DBC = " + SET("DATABASE")
DO CheckStProc
*** Now make aCH07 current
SET DATA TO aCH07
? "Current DBC = " + SET("DATABASE")
DO CheckStProc
*** Now make bCH07 current
SET DATA TO bCH07
? "Current DBC = " + SET("DATABASE")
DO CheckStProc
*** Now make NO DBC current
SET DATABASE TO
? "Current DBC = " + SET("DATABASE")
DO CheckStProc

CLOSE ALL
RETURN

PROCEDURE CheckStProc
DO dummy
DO OnlyaCH07
DO OnlybCH07
