**********************************************************************
* Program....: ChkQuery.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Various ways of checking the results of a query
**********************************************************************
CLEAR
SET ALTERNATE TO QryRes.txt
SET ALTERNATE ON
*** Generate a Cursor as a result of a query
? "Run Query that generates a physical cursor"
? "=========================================="
SELECT CL.cliname, CO.consname ;
  FROM sqlcli CL ;
    LEFT OUTER JOIN sqlcon CO ;
    ON CO.clikey = CL.clisid ;
    ORDER BY cliname, consname ;
  INTO CURSOR curtest

? "Reccount: " + PADL( RECCOUNT( 'curtest' ), 3 )
? "_Tally:   " + PADL( _TALLY, 3 )
SELECT COUNT(*) FROM curtest INTO ARRAY laJunk
? "Count(*): " + PADL( laJunk[1], 3 )
SELECT COUNT(consname) FROM curtest INTO ARRAY laJunk
? "Count(consname): " + PADL( laJunk[1], 3 )
?
*** Generate a Cursor that creates a filtered view
? "Run Query that generates a filtered view"
? "========================================"
SELECT * ;
  FROM sqlcli CL ;
  WHERE cliname = "T" ;
  INTO CURSOR curtest

? "Reccount: " + PADL( RECCOUNT( 'curtest' ), 3 )
? "_Tally:   " + PADL( _TALLY, 3 )
SELECT COUNT(*) FROM DBF("curtest") INTO ARRAY laJunk
? "Count(*): " + PADL( laJunk[1], 3 )
SELECT COUNT(clisid) FROM DBF("curtest") INTO ARRAY laJunk
? "Count(clisid): " + PADL( laJunk[1], 3 )

*** Repeat query into a physical cursor
?
? "Repeat query into a physical cursor"
? "==================================="
SELECT * ;
  FROM sqlcli CL ;
  WHERE cliname = "T" ;
  INTO CURSOR curtest NOFILTER

? "Reccount: " + PADL( RECCOUNT( 'curtest' ), 3 )
? "_Tally:   " + PADL( _TALLY, 3 )
SELECT COUNT(*) FROM curtest INTO ARRAY laJunk
? "Count(*): " + PADL( laJunk[1], 3 )
SELECT COUNT(clisid) FROM curtest INTO ARRAY laJunk
? "Count(clisid): " + PADL( laJunk[1], 3 )
SET ALTERNATE OFF
SET ALTERNATE TO