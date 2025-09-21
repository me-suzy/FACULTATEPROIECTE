**********************************************************************
* Program....: SQLCalc.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Calculating Values in Queries
**********************************************************************
*** Simple Balance by Invoice
SELECT  CL.cliname, ;
        IN.invdate, ;
        IN.invamt, ;
        IN.invpaid, ;
        (invamt - invpaid) AS invbal ;
  FROM sqlcli CL ;
    JOIN sqlinv IN ON IN.clikey = CL.clisid ;
  ORDER BY cliname ;
  INTO CURSOR curInvBal

*** Current Balance by Customer (for those that have Invoices)
SELECT  CL.cliname, ;
        SUM( IN.invamt ) AS invtot, ;
        SUM( IN.invpaid ) AS paytot, ;
        SUM( invamt - invpaid ) AS cusbal ;
  FROM sqlcli CL ;
    JOIN sqlinv IN ON IN.clikey = CL.clisid ;
  GROUP BY CL.clisid ;
  ORDER BY cliname ;
  INTO CURSOR curCusBal

*** Current Balance by Customer (All customers)
*** Note: We will get NULL values if a customer has no invoices
*** Use NVL() to show 0.00 instead
SELECT  CL.cliname, ;
        NVL( SUM( IN.invamt ), 0) AS invtot, ;
        NVL( SUM( IN.invpaid ), 0) AS paytot, ;
        NVL( SUM( invamt - invpaid ), 0) AS cusbal ;
  FROM sqlcli CL ;
    LEFT OUTER JOIN sqlinv IN ON IN.clikey = CL.clisid ;
  GROUP BY CL.clisid ;
  ORDER BY cliname ;
  INTO CURSOR curAllCus

*** Populate Current Balance field as a post-process
*** for those that have Invoices
SELECT  CL.cliname, ;
        SUM( IN.invamt ) AS invtot, ;
        SUM( IN.invpaid ) AS paytot, ;
        $0 AS cusbal ;
  FROM sqlcli CL ;
    JOIN sqlinv IN ON IN.clikey = CL.clisid ;
  GROUP BY CL.clisid ;
  ORDER BY cliname ;
  INTO CURSOR transient

*** Make transient cursor writable
USE DBF( 'transient' ) AGAIN IN 0 ALIAS curNewBal
SELECT curNewBal
USE IN transient
*** Calculate Balance and Convert to currency
REPLACE ALL cusbal WITH NTOM( invtot - paytot )
GO TOP

