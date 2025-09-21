********************************************************************************
* 5_XMLAdapter_CreateDiffgram.prg
* Description:	This program will create a read-write cursor and export the 
*				changed record to a Diffgram XML file.
* Tip:	The XMLAdapter class supports Diffgrams, which provide an efficient way 
*		of transferring data back and forth between applications.  Diffgrams are
*		a special type of an XML document that are formatted to only include 
*		information for changed data, rather than the entire set of data.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcFile as String
LOCAL lcXSDFile as String
LOCAL lcStr as String

CLOSE TABLES ALL
SET MULTILOCKS ON
ERASE Diffgram.xml

* Name of an XML file.
lcFile = "Diffgram.xml"

* Open Northwind database and create a read/write cursor from the 
* Customers table.
OPEN DATABASE (_samples+"\northwind\northwind")
SELECT CustomerID, CompanyName ;
	FROM Customers;
	INTO CURSOR curCustomers READWRITE

* Set table buffering on.
CURSORSETPROP("Buffering", 5)

* Locate a specific record and modify it.
LOCATE FOR CustomerID = "AROUT"
REPLACE CompanyName WITH "Around the Corner"

* Create an XMLAdapter object to load the XML file into.
adapter = CREATEOBJECT("XMLAdapter")

* Adds a new XMLTable object to the XMLAdapter Tables collection and the necessary
* XMLField objects to the XMLTable Fields collection based on the specified table 
* alias.
adapter.AddTableSchema("curCustomers")

* Set the IsDiffgram property of the XMLAdapter to output the XML in Diffgram format.
adapter.IsDiffgram = .T.

* Export the cursor into the XML file.
adapter.ToXML(lcFile,,.T.,.T.,.T.)

* Browse the table.
GO TOP
BROWSE NOWAIT

* Display the XML and XSD files.
MODIFY FILE Diffgram.xml NOEDIT NOWAIT

lcStr = "A cursor is selected from the Nothwind's database.  The XMLAdapter object" + ;
		" is set to export XML in Diffgram format by setting the IsDiffgram" + ;
		" property.  The XMLAdapter's ToXML method is called to generate the XML file."
MESSAGEBOX(lcStr)

RETURN


