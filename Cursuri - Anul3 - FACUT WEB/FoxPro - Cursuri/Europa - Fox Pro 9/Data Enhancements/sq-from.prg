*<>{485EF515-7A54-4A02-BABA-368936074027}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrate sub-query in FROM list (derived table)
*<>************************************************************************
#INCLUDE sqltests.h
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir)

CLOSE DATABASES ALL
OPEN DATABASE ( C_DIR_NORTHWIND + "northwind")

* Distinct Product Count for customers
SELECT c2.customerid, ;
	COUNT(DISTINCT D.productID) AS product_count ;
	FROM Customers c2 ;
	INNER JOIN Orders O ;
	ON  c2.customerid = O.customerid ;
	INNER JOIN OrderDetails D ;
	ON O.orderid = D.orderid ;
	GROUP BY c2.customerid ;
	ORDER BY product_count DESC ;
	INTO CURSOR temp

BROWSE LAST NOWAIT

* Customers who purchased as least 50% of products
SELECT ;
	C.customerid, ;
	P.product_count ;
	FROM Customers C, ;
	(SELECT c2.customerid, ;
	COUNT(DISTINCT D.productID) AS product_count ;
	FROM Customers c2 ;
	INNER JOIN Orders O ;
	ON  c2.customerid = O.customerid ;
	INNER JOIN OrderDetails D ;
	ON O.orderid = D.orderid ;
	GROUP BY c2.customerid) AS P ;
	WHERE c.customerid = p.customerid ;
	AND p.product_count >= (SELECT (COUNT(*)*.50) FROM Products) ;
	ORDER BY p.product_count DESC ;
	INTO CURSOR temp2
LIST OFF

BROWSE LAST NOWAIT

