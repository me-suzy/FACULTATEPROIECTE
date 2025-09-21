SET ALTERNATE TO alt.txt
SET ALTERNATE ON
ON ERROR ? "*** ERROR *** ", ERROR(), MESSAGE(), MESSAGE(1)

? "* VFP default"
USE ( ADDBS(JUSTPATH(SYS(16,0)))+ "northwind\" + "northwind!customers") SHARED
ShowCGP()

? 'CursorSetProp("Refresh",-1,0)'
? "* Always read data from disk, scoped to data session."
CURSORSETPROP("Refresh",-1,0)
ShowCGP()

? '* Close / open customers - new cursors respect session seting (-1).'
USE IN customers
USE ( ADDBS(JUSTPATH(SYS(16,0)))+ "northwind\" + "northwind!customers") SHARED
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