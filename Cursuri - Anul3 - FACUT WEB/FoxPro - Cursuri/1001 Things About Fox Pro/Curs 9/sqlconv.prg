**********************************************************************
* Program....: SQLConv.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Converting data to character strings in SQL Query
**********************************************************************
*** Extract raw Customer/Invoice Information
SELECT  TRANSFORM( CL.cliname ) AS cliname, ;
        TRANSFORM( IN.invdate ) AS invdate, ;
        TRANSFORM( IN.invamt  ) AS invamt, ;
        TRANSFORM( IN.invpaid ) AS payment, ;
        TRANSFORM( invamt - invpaid ) AS invbal ;
  FROM sqlcli CL ;
    JOIN sqlinv IN ON IN.clikey = CL.clisid ;
  ORDER BY cliname ;
  INTO CURSOR curNumeric

*** Extract Customer/Invoice Information as "Currency"
SELECT  TRANSFORM( CL.cliname ) AS cliname, ;
        TRANSFORM( IN.invdate ) AS invdate, ;
        TRANSFORM( NTOM( IN.invamt  ) ) AS invamt, ;
        TRANSFORM( NTOM( IN.invpaid ) ) AS payment, ;
        TRANSFORM( NTOM( invamt - invpaid ) ) AS invbal ;
  FROM sqlcli CL ;
    JOIN sqlinv IN ON IN.clikey = CL.clisid ;
  ORDER BY cliname ;
  INTO CURSOR curCurrency
  
*** Use PADL() instead of TRANSFORM() to get the 'right' results 
SELECT  PADL( CL.cliname, 40 ) AS cliname, ;
        PADL( IN.invdate, 10 ) AS invdate, ;
        PADL( IN.invamt, 10 ) AS invamt, ;
        PADL( IN.invpaid, 10 ) AS payment, ;
        PADL( invamt - invpaid, 10 ) AS invbal ;
  FROM sqlcli CL ;
    JOIN sqlinv IN ON IN.clikey = CL.clisid ;
  ORDER BY cliname ;
  INTO CURSOR curCorrect

