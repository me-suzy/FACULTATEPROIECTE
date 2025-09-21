********************************************************************************
* 2_AutoIncrement_Alter.prg
* Description:	This program will show how to alter an existing table to change
*				the auto increment's next value and increment step.
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
CREATE TABLE AI_Table FREE ;
	( iID i AUTOINC NEXTVALUE 1 STEP 1, ;
	  CustName c(30))

* Insert three records into the table.  You do not assign any values to the auto
* increment field.
INSERT INTO AI_Table (CustName) VALUES ("Jane Smith")
INSERT INTO AI_Table (CustName) VALUES ("John Doe")
INSERT INTO AI_Table (CustName) VALUES ("Greg Jones")
GO TOP

* Browse the table.
BROWSE NOWAIT

lcStr = "Auto Increment Table created with the starting value set to 1 and" + ;
		" the increment set to 1"
MESSAGEBOX(lcStr)

* Alter the table to set the next auto increment value inserted to be 100 and
* incrementing step to be 10.
ALTER TABLE AI_Table ALTER COLUMN iID i AUTOINC NEXTVALUE 100 STEP 10

* Insert three more records into the table.
INSERT INTO AI_Table (CustName) VALUES ("Jay Lewis")
INSERT INTO AI_Table (CustName) VALUES ("Steve Appleton")
INSERT INTO AI_Table (CustName) VALUES ("Ken Garvy")
GO TOP

* Browse the table.
BROWSE NOWAIT

lcStr = "Auto Increment Table was altered to set the next auto increment value" + ;
		" to 100 and the increment step to 10"
MESSAGEBOX(lcStr)

* Restore environment.
USE
SELECT (lnSelect)

RETURN
