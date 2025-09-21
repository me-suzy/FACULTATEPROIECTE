*<>{D3FF79AB-9F7B-4402-A2A2-813719351883}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrate CAST data-type conversion
*<>************************************************************************
#INCLUDE sqltests.h

LOCAL cType,  lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir) 
OPEN DATABASE ( C_DIR_NORTHWIND + "northwind")

SELECT o.*, d.* ;
	FROM Orders o ;
	JOIN OrderDetails d ;
	ON o.orderID = d.orderID ;
	INTO CURSOR Sales

cType = "Integer"

SELECT TOP 20 ;
	CustomerID, ;
	CAST((unitprice*quantity)-discount AS N(8,4))AS f_number_8x4, ;
	CAST((unitprice*quantity)-discount AS B NOT NULL) AS f_double, ;
	CAST((unitprice*quantity)-discount AS CURRENCY) AS f_money, ;
	CAST((unitprice*quantity)-discount AS (m.cType)) AS f_integer, ;
	CAST((unitprice*quantity)-discount AS C(10)) AS f_character, ;
	CAST((unitprice*quantity)-discount AS V) AS f_varchar, ;
	CAST(NULL AS (m.cType)) AS f_IntegerNull ;
	FROM Sales ;
	ORDER BY CustomerID

