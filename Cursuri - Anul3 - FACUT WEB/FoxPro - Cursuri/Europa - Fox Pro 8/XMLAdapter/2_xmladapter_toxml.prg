********************************************************************************
* 2_XMLAdapter_ToXML.prg
* Description:	This program will show how to export a cursor to an XML file 
*				using the XMLAdapter class.
* Tip:	The ToXML method can export a cursor to an XML file or store to a 
*		variable by setting the third parameter to a true to write to a file or 
*		false to store the XML to a variable.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcFile as String
LOCAL lcStr as String

CLOSE DATABASES ALL
CLOSE TABLES ALL
ERASE Employee.xml

* Open Northwind database and create a cursor from the Employees table.
OPEN DATABASE (_samples+"\northwind\northwind")
SELECT employeeid, lastname ;
	FROM Employees;
	INTO CURSOR curEmployees

* Create an XMLAdapter object to export the cursor into an XML file.
adapter = CREATEOBJECT("XMLAdapter")

* Adds a new XMLTable object to the XMLAdapter Tables collection and the necessary
* XMLField objects to the XMLTable Fields collection based on the specified table 
* alias.
adapter.AddTableSchema("curEmployees")

* Name of an XML file.
lcFile = "Employee.xml"

* Export the cursor into the XML file.
adapter.ToXML(lcFile,,.T.)

* Browse the table.
GO TOP
BROWSE NOWAIT

* Display the XML file.
MODIFY FILE Employee.xml NOEDIT NOWAIT

lcStr = "A cursor is selected from the Nothwind's database.  Then the XMLAdapter" + ;
		" object adds the cursor's schema to objects inside of itself by calling" + ;
		" the AddTableSchema method.  The XMLAdapter's ToXML method is " + ;
		" called to generate the XML file."
MESSAGEBOX(lcStr)

RETURN


