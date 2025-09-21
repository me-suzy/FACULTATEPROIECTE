**********************************************************************
* Program....: LkUpQry.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Query to correctly join tables using lookups
**********************************************************************
IF ! "CH09" $ DBC()
    OPEN DATA CH09
ENDIF
*** Standard Query Syntax
SELECT CU.cusname, AD.address, AD.city, BU.busdesc, RG.regdesc;
  FROM customer CU, address AD, bustype BU, region RG;
 WHERE AD.cuskey = CU.cussid ;
   AND BU.bussid = AD.buskey;
   AND RG.regsid = AD.regkey;
   INTO CURSOR result01 ;
   ORDER BY cusname, city

*** ANSI 92 Sequential Join Syntax
SELECT CU.cusname, AD.address, AD.city, BU.busdesc, RG.regdesc;
  FROM customer CU JOIN address AD ON AD.cuskey = CU.cussid ;
    JOIN bustype BU ON BU.bussid = AD.buskey ;
    JOIN region RG ON RG.regsid = AD.regkey ;
  INTO CURSOR result02 ;
  ORDER BY cusname, city
  

    
  

