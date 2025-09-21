********************************************************************************
* 6_XMLAdapter_ApplyChanges.prg
* Description:	This program will import a Diffgram XML file and apply the 
*				changes to a cursor.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcFile as String
LOCAL lcStr as String

CLOSE TABLES ALL

* Open Northwind database.
OPEN DATABASE (_samples+"\northwind\northwind")
SELECT CustomerID, CompanyName ;
	FROM Customers;
	INTO CURSOR curCustomers READWRITE

* Name of an XML file.
lcFile = "DiffgramXML.xml"

* Create an XMLAdapter object to load the XML file into.
adapter = CREATEOBJECT("XMLAdapter")

* Read the XML file into the XMLAdapter object.
adapter.LoadXML(lcFile,.T.)

* Set the name of the Alias property to the name of the cursor to update.
adapter.Tables(1).Alias = "curCustomers"

* Apply the Diffgram changes to the cursor.
adapter.Tables(1).ApplyDiffgram()

* Display the XML file.
MODIFY FILE DiffgramXML.xml NOEDIT NOWAIT

* Browse the table.
GO TOP
BROWSE NOWAIT

lcStr = "An XML file in Diffgram format is imported in by using the XMLAdapter's" + ;
		" LoadXML method.  The the XMLAdapter's ApplyDiffgram method is called to" + ;
		" update the cursor with the contents of the XML file."
MESSAGEBOX(lcStr)

RETURN


