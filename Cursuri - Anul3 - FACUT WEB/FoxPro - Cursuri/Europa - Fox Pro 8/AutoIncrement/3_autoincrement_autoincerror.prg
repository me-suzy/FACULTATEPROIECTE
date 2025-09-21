********************************************************************************
* 3_AutoIncrement_AutoIncError.prg
* Description:	This program will show how to use Scatter / Gather with auto
*				increment fields by setting the AutoIncError to 'OFF' in order
*				to suppress a Read-only error from being thrown.
* Tip:	The AutoIncError setting can be set globally by using SET AUTOINCERROR.
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

* Scatter the current record
SCATTER MEMVAR

* Set the AutoIncError setting for the cursor to OFF to suppress the error and
* ignore the replacement value when a value is copied into the auto increment 
* field.
CURSORSETPROP("AutoIncError","OFF")

* Append a new record and replace the fields with the values from the Scatter.
APPEND BLANK
GATHER MEMVAR

* Browse the table.
BROWSE NOWAIT

lcStr = "Auto Increment Table was altered to set the next auto increment value" + ;
		" to 100 and the increment step to 10"
MESSAGEBOX(lcStr)

* Restore environment.
USE
SELECT (lnSelect)

RETURN
