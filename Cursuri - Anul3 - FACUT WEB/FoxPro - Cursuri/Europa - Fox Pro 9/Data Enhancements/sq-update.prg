*<>{6CB48F6D-099A-4922-9090-241693301612}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrate correlated UPDATE (UPDATE ... FROM ..)
*<>************************************************************************
* UPDATE unitprice of products from mfg_msrp with 10% off MSRP
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir)

SET PROCEDURE TO sq-demoprocs.prg
SETUP()

* correlated update
* only records that match are touched
? '* Update 2'
UPDATE products ;
	SET unitprice = mfg_msrp.msrp*.90 ;
	FROM mfg_msrp ;
	WHERE mfg_msrp.productID = products.productID;
	AND mfg_msrp.discontinu = .F.

ShowDif()
=TABLEREVERT(.T.)
Cleanup()
