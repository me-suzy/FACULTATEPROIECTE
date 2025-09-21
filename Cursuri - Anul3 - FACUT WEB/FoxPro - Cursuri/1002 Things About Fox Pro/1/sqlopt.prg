***********************************************************************
* Program....: SQLOPT.PRG
* Compiler...: Visual FoxPro 07.00.0000.9262 for Windows 
* Purpose....: Illustrate the changes to SQL ShowPlan reporting
***********************************************************************
LOCAL lcOpt
*** Set up optimization (Join and Filter )reporting
*** Direct output to local variable
SYS(3054, 12, "lcOpt" )

*** Run the first query
SELECT CL.cclientid, CL.ccompany, CO.cfirst, CO.clast, PH.cnumber, LD.clddesc ;
  FROM  clients CL, contacts CO, phones PH, ludetail LD ;
 WHERE CL.iclientpk = CO.iclientfk ;
   AND CO.icontactpk = PH.icontactfk ;
   AND PH.iphonetypefk = LD.ildpk ;
   AND CL.ccountry = "USA" ;
  INTO CURSOR junk

*** Transfer contents of variable to file
STRTOFILE( lcOpt + CHR(13) + CHR(10), 'ChkOpt.txt' )

*** And then the second
SELECT * ;
  FROM clients ;
  WHERE ccountry = "USA" ;
  INTO CURSOR junk

*** Transfer these contents from variable to file
STRTOFILE( lcOpt, 'ChkOpt.txt', .T. )

*** Tidy up and review results
SYS(3054, 0)
CLOSE TABLES ALL
MODIFY FILE chkopt.txt NOWAIT


