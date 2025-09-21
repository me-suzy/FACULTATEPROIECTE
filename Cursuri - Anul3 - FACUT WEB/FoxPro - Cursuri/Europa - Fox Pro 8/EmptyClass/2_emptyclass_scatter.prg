********************************************************************************
* 2_EmptyClass_Scatter.prg
* Description:	This program will show how to use the Scatter/Gather and 
*				Insert Into functions to copy records from one cursor to another
*				cursor that has a different table structure.
* Tip:	Using the Empty class allows you to work with data from different tables
*		where the field names or types may not be the same.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL loEmpty as Empty
LOCAL lnCnt as Integer
LOCAL lnItem as Integer
LOCAL lcStr as String
LOCAL lcDataPath as String
LOCAL lnSelect as Integer

* Save environment.
lnSelect = SELECT()
SELECT 0

* Set location of where the sample data is stored
lcDataPath = _samples + "\Data\"

* Create a collection object.
loEmpty = CREATEOBJECT("Empty")

* Select records from the sample Customer table
SELECT cust_id, company FROM (lcDataPath + "Customer") ;
	WHERE LEFT(cust_id,1) = "A" INTO CURSOR curOrigCust
GO TOP

* Create a new cursor that has a different table structure then
* the original table to show how the Empty class can be used to 
* map different tables for transferring data.
CREATE CURSOR curNewCust (ID c(6), COMPANY c(40))

* Scatter fields from the current record to the Empty object
SELECT curOrigCust
SCATTER NAME loEmpty ADDITIVE

* Display the added members
AMEMBERS(aEmpty,loEmpty)
lcStr = "Empty object after using SCATTER to add the current record" + ;
		" as properties to the object:"+CRLF+CRLF
FOR lnItem = 1 TO ALEN(aEmpty)
	lcStr = lcStr + "Property: " + aEmpty(lnItem) + "      Value: " + ;
			EVALUATE("loEmpty." + aEmpty(lnItem)) + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Add a property to the Empty object that matches the name of the field in the new
* cursor.
ADDPROPERTY(loEmpty,"ID")

* Populate the new property (ID) with the value in original cursor's 
* property (CUST_ID).
loEmpty.ID = loEmpty.Cust_ID

* Display the added members
AMEMBERS(aEmptyNew,loEmpty)
lcStr = "Empty object after using SCATTER to add the current record as properties" + ;
		" to the object:"+CRLF+CRLF
FOR lnItem = 1 TO ALEN(aEmptyNew)
	lcStr = lcStr + "Property: " + aEmptyNew(lnItem) + "      Value: " + ;
	EVALUATE("loEmpty." + aEmptyNew(lnItem)) + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Add a new record to the new cursor by using the GATHER function.  The properties of 
* the Empty object that have the same name as fields in the new cursor will be populated.
SELECT curNewCust
APPEND BLANK
GATHER NAME loEmpty

* Browse the new cursor to see the newly added record.
BROWSE NOWAIT

lcStr = "The new cursor contains a different field name (ID) from the original" + ;
		" cursor (CUST_ID)." + ;
		"  The Empty object can be used to map fields from one table to another by creating" + ;
		" new properties in the Empty object." + ;
		"  The record from the original cursor is added by using the GATHER function."
MESSAGEBOX(lcStr)

* Change the value of the Company property in the Empty object to then add a 
* second record to the new cursor.
loEmpty.Company = "ABC Company"

* The INSERT INTO function is called to demonstrate another way to add records to a 
* cursor from an Empty object.  The properties of the Empty object that have the same 
* name as fields in the new cursor will be populated. 
INSERT INTO curNewCust FROM NAME loEmpty

* Browse the new cursor to see both records added.
GO TOP
BROWSE NOWAIT

lcStr = "The new cursor had a second record added by using the INSERT INTO with" + ;
		" the Empty object."
MESSAGEBOX(lcStr)

* Restore environment.
USE
SELECT (lnSelect)

RETURN
