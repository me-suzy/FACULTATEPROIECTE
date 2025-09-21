*<>{EC42EFC0-A32E-45F0-ADAD-556687734571}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrate TOP N with GROUP BY
*<>************************************************************************
#INCLUDE sqltests.h
CLOSE DATABASES ALL
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir)

OPEN DATABASE ( C_DIR_NORTHWIND + "northwind")

* Distinct Product Count for customers
SELECT c.customerid, ;
	COUNT(DISTINCT D.productID) AS product_count ;
	FROM Customers c ;
	INNER JOIN Orders O ;
	ON  c.customerid = O.customerid ;
	INNER JOIN OrderDetails D ;
	ON O.orderid = D.orderid ;
	GROUP BY c.customerid ;
	ORDER BY product_count DESC ;
	INTO CURSOR temp

BROWSE LAST NOWAIT

* Top 9 Distinct Product Count for Customers
SELECT TOP 9 ;
	c.customerid, ;
	COUNT(DISTINCT D.productID) AS product_count ;
	FROM Customers c ;
	INNER JOIN Orders O ;
	ON  c.customerid = O.customerid ;
	INNER JOIN OrderDetails D ;
	ON O.orderid = D.orderid ;
	GROUP BY c.customerid ;
	ORDER BY product_count DESC ;
	INTO CURSOR temp1

BROWSE LAST NOWAIT

* TOP N example as sub-query with order by
* /// get a better example
SELECT Companyname ;
	FROM Customers ;
	WHERE customerid IN ;
	( SELECT TOP 9 ;
	c2.customerid ;
	FROM Customers c2 ;
	ORDER BY customerid )
