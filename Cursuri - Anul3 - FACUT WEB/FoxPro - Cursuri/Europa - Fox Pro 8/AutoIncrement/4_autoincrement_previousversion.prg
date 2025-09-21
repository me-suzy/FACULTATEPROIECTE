********************************************************************************
* 4_AutoIncrement_PreviousVersion.prg
* Description:	This program will show how to make a table that uses auto
*				increment compatible with prior versions of Visual FoxPro.
* Tip:	Only Visual FoxPro version 8.0 or greater support auto increment.  The
*		table needs to be alters to convert the auto increment field type to
*		integer to be opened with prior versions.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String

* Close all tables and erase auto increment table.
CLOSE TABLES ALL
ERASE AI_Table.dbf

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
ALTER TABLE AI_Table ALTER COLUMN iID i

* Insert three more records into the table.
INSERT INTO AI_Table (CustName) VALUES ("Jay Lewis")
INSERT INTO AI_Table (CustName) VALUES ("Steve Appleton")
INSERT INTO AI_Table (CustName) VALUES ("Ken Garvy")
GO TOP

* Browse the table.
BROWSE NOWAIT

lcStr = "The table has been altered to change the field type to Integer to support" + ;
		" prior versions of Visual FoxPro.  Three more records have been added and" + ;
		" notice that the auto increment is not supported.  This table can now be" + ;
		" openned in prior versions of Visual FoxPro."
MESSAGEBOX(lcStr)

RETURN
