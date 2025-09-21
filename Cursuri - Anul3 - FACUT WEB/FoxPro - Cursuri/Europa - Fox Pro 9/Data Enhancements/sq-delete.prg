*<>{E3773698-A042-4091-BCBC-699681740760}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrate correlated delete.  (DELETE ... FROM ...)
*<>************************************************************************
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir) 

SET PROCEDURE TO sq-demoprocs.prg
Setup()

* DELETE records for items marked discontinued.
? '* Delete 1'
DELETE products ;
  FROM mfg_msrp ;
 WHERE mfg_msrp.productID = products.productID;
   AND mfg_msrp.discontinu = .t.

LIST OFF RECNO() FOR DELETED()
=TABLEREVERT(.T.)
Cleanup()