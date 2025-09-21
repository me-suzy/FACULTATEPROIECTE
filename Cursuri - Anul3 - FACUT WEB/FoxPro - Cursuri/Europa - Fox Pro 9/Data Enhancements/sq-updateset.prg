*<>{D712AD15-90F8-468D-B1B1-884147293413}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrate UPDATE with sub-query in SET
*<>************************************************************************
* UPDATE unitprice of products from mfg_msrp with 10% off MSRP
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir)

SET PROCEDURE TO sq-demoprocs.prg
SETUP()

* correlated sub-query in SET
* all records get touched, fields that don't match on are NULL.
? '* Update 1'
UPDATE products ;
	SET unitprice = ;
	(SELECT (msrp*.90) ;
	FROM mfg_msrp ;
	WHERE mfg_msrp.productID = products.productID ;
	AND mfg_msrp.discontinu = .F.)

ShowDif()
=TABLEREVERT(.T.)
Cleanup()