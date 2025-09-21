*<>{1BA15FA6-7649-4C2E-A9A9-129477241670}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrates use of SELECT ... WITH (BUFFERING=<lExpr>)
*<>************************************************************************
#INCLUDE sqltests.h
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir)

CLOSE DATABASES ALL
SET EXCLUSIVE OFF
OPEN DATABASE ( C_DIR_NORTHWIND + "northwind")

SET MULTILOCKS ON
USE customers IN 0
CURSORSETPROP("BUFFERING",5,"customers")
UPDATE customers SET city="Seattle"

SELECT DISTINCT city FROM customers WITH (BUFFERING=.T.)
SELECT DISTINCT city FROM customers WITH (BUFFERING=.F.)

USE orders IN 0
CURSORSETPROP("BUFFERING",5,"orders")
UPDATE orders SET shipcity="Seattle"

* view buffer for both tables
SELECT DISTINCT c.city, o.shipcity ;
	FROM customers c WITH (BUFFERING=.T.) ;
	JOIN orders o WITH (BUFFERING=.T.) ;
	ON c.customerID = o.customerID

* view buffer for one table, unbuffered for the other
SELECT DISTINCT c.city, o.shipcity ;
	FROM customers c WITH (BUFFERING=.F.) ;
	JOIN orders o WITH (BUFFERING=.T.) ;
	ON c.customerID = o.customerID

* view unbuffered data for both tables
SELECT DISTINCT c.city, o.shipcity ;
	FROM customers c WITH (BUFFERING=.F.) ;
	JOIN orders o WITH (BUFFERING=.F.) ;
	ON c.customerID = o.customerID

=TABLEREVERT(.T.,'customers')
=TABLEREVERT(.T.,'orders')
