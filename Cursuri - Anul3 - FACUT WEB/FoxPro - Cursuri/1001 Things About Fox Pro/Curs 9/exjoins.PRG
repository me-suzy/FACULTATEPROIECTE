**********************************************************************
* Program....: ExJoins.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Illustrate results of the various join types available
**********************************************************************

*** Inner Join
SELECT CL.cliname, CO.consname ;
  FROM sqlcli CL ;
    JOIN sqlcon CO ;
    ON CO.clikey = CL.clisid ;
    ORDER BY cliname, consname ;
  INTO CURSOR ijoin
?
? "Inner Join Produces " + PADL( _TALLY, 3) + " Rows"

*** LEFT Outer Join
SELECT CL.cliname, CO.consname ;
  FROM sqlcli CL ;
    LEFT OUTER JOIN sqlcon CO ;
    ON CO.clikey = CL.clisid ;
    ORDER BY cliname, consname ;
  INTO CURSOR lojoin

?
? "LEFT Outer Join Produces " + PADL( _TALLY, 3) + " Rows"

*** RIGHT Outer Join
SELECT CL.cliname, CO.consname ;
  FROM sqlcli CL ;
    RIGHT OUTER JOIN sqlcon CO ;
    ON CO.clikey = CL.clisid ;
    ORDER BY cliname, consname ;
  INTO CURSOR rojoin

?
? "RIGHT Outer Join Produces " + PADL( _TALLY, 3) + " Rows"

*** FULL Outer Join
SELECT CL.cliname, CO.consname;
  FROM sqlcli CL ;
    FULL JOIN sqlcon CO ;
    ON CO.clikey = CL.clisid ;
    ORDER BY cliname, consname ;
  INTO CURSOR fuljoin

?
? "FULL Join Produces " + PADL( _TALLY, 3) + " Rows"

