*<>{5423AD26-1650-4C60-9494-106326121290}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrates various uses of CursorSetProp("REFRESH")
*<>************************************************************************
#INCLUDE sqltests.h
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir) 

* setup
CLEAR
CLOSE DATABASES ALL
RELEASE WINDOWS ALT
ERASE ALT.txt

* create program to run in 2nd instance
TEXT TO cPrg NOSHOW
SET ALTERNATE TO alt.txt
SET ALTERNATE ON
ON ERROR ? "*** ERROR *** ", ERROR(), MESSAGE(), MESSAGE(1)

? "* VFP default"
USE ( C_DIR_NORTHWIND + "northwind!customers") SHARED
ShowCGP()

? 'CursorSetProp("Refresh",-1,0)'
? "* Always read data from disk, scoped to data session."
CURSORSETPROP("Refresh",-1,0)
ShowCGP()

? '* Close / open customers - new cursors respect session seting (-1).'
USE IN customers
USE ( C_DIR_NORTHWIND + "northwind!customers") SHARED
ShowCGP()

? 'CursorSetProp("Refresh",-2)'
? '* Use global SET REFRESH values:', CAST(SET("REFRESH") AS C(1)), ',', CAST(SET("REFRESH") AS C(1))
?? ' for the current cursor.'
CURSORSETPROP("Refresh",-2)
ShowCGP()

? 'CursorSetProp("Refresh",.5,"customers")'
? "* Refresh buffers every .5 seconds in the customers table"
CURSORSETPROP("Refresh",.5,"customers")
ShowCGP()

SET ALTERNATE TO
SET ALTERNATE OFF
FLUSH (FULLPATH("alt.txt") FORCE
EXECSCRIPT(m.cStr)

FUNCTION ShowCGP
   * show the various states of CursorGetProp("Refresh")
   ? CURSORGETPROP("Refresh",0), 'CursorGetProp("Refresh",0)','           * session setting'
   ? CURSORGETPROP("Refresh"), 'CursorGetProp("Refresh")','             * current cursor'
   ? CURSORGETPROP("Refresh","Customers"), 'CursorGetProp("Refresh","Customers")',' * customers'
   ? ''
ENDFUNC
ENDTEXT

ERASE testcsp_refresh.*
STRTOFILE(m.cPrg,"testcsp_refresh.prg")

WAIT WINDOW "One moment..." NOWAIT
o=NEWOBJECT("visualfoxpro.application.9")
o.DOCMD("CD [" + SYS(5) + CURDIR() + "]")
o.DOCMD("do testcsp_refresh.prg")
o.QUIT

WAIT CLEAR
IF FILE("alt.txt")
	MODIFY FILE ALT.txt NOWAIT
ENDIF
