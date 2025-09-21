**********************************************************************
* Program....: ConCat.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Illustrate the problem of concatenating character strings
* ...........: When one or other contains NULL values
**********************************************************************

*** Generate a cursor containing NULL values for consname
SELECT CL.cliname, CO.consname ;
  FROM sqlcli CL ;
    LEFT OUTER JOIN sqlcon CO ;
    ON CO.clikey = CL.clisid ;
    ORDER BY cliname, consname ;
  INTO CURSOR lojoin

*** Create a Formatted output
SELECT ( ALLTRIM( cliname ) + " CONTACT: " + ALLTRIM( consname )) AS Formatted;
  FROM lojoin ;
  INTO CURSOR Formatted NOFILTER

