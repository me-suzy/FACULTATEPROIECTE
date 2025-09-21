*<>{AFF4461D-5295-4598-A8A8-894971752370}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrate sub-query in SELECT list (projection)
*<>************************************************************************
#INCLUDE sqltests.h
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir)

CLOSE DATABASES ALL
OPEN DATABASE ( C_DIR_NORTHWIND + "northwind")

* Sales by customer
SELECT ;
	C.customerid, ;
	C.companyname, ;
	SUM(D.quantity*D.unitprice) AS CustTotal ;
	FROM Customers C ;
	INNER JOIN Orders O ;
	ON  C.customerid = O.customerid ;
	INNER JOIN OrderDetails D ;
	ON O.orderid = D.orderid ;
	GROUP BY C.customerid, C.companyname

* Total Sales for all customers
SELECT SUM((quantity*unitprice)-discount);
	FROM OrderDetails

* Sales by customer with Pct of total sales
SELECT ;
	C.customerid, ;
	C.companyname, ;
	SUM(D.quantity*D.unitprice) AS CustTotal ,;
	(SUM(D.quantity*D.unitprice) / ;
	(SELECT SUM((quantity*unitprice)-discount) ;
	FROM OrderDetails D2))*100 AS PctTotal ;
	FROM Customers C ;
	INNER JOIN Orders O ;
	ON  C.customerid = O.customerid ;
	INNER JOIN OrderDetails D ;
	ON O.orderid = D.orderid ;
	GROUP BY C.customerid, C.companyname ;
	ORDER BY pctTotal DESC

