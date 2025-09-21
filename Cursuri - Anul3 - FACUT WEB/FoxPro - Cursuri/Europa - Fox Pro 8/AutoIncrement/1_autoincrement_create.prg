********************************************************************************
* 1_AutoIncrement_Create.prg
* Description:	This program will show how to create a table that contains an
*				auto increment field.
* Tip:	You can use the Table Designer to create the sturucture of your tables.
*		There is a new data type choice in the drop-down called 
*		'Integer(AutoInc)'.  You can also set the starting value and the 
*		increment value.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
LOCAL lnSelect as Integer

* Save environment and erase auto increment table.
lnSelect = SELECT()
SELECT 0
ERASE _AI_Table.dbf

* Create Auto Increment table setting the 'iID' column as an auto increment field
* with the starting value set to 1 and the increment value set to 1.
CREATE TABLE _AI_Table FREE ;
	( iID i AUTOINC NEXTVALUE 1 STEP 1, ;
	  CustName c(30))

* Insert three records into the table.  You do not assign any values to the auto
* increment field.
INSERT INTO _AI_Table (CustName) VALUES ("Jane Smith")
INSERT INTO _AI_Table (CustName) VALUES ("John Doe")
INSERT INTO _AI_Table (CustName) VALUES ("Greg Jones")
GO TOP

* Browse the table.
BROWSE NOWAIT

lcStr = "Auto Increment Table created with the starting value set to 1 and" + ;
		" the increment set to 1"
MESSAGEBOX(lcStr)

* Restore environment.
USE
SELECT (lnSelect)

RETURN
