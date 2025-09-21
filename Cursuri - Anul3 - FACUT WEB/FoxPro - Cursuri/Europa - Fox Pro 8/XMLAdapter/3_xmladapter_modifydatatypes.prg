********************************************************************************
* 3_XMLAdapter_ModifyDataTypes.prg
* Description:	This program will show how to alter data types stored in the 
*				DataTables inside the XMLAdapter class.
* Tip:	Changing the data types with the XMLAdapter class allows you to work 
*		with XML data that needs to	be altered before importing/exporting the 
*		contents to cursors.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcFile as String
LOCAL lcStr as String

CLOSE TABLES ALL

* Name of an XML file.
lcFile = "EmployeeXML.xml"

* Create an XMLAdapter object to load the XML file into.
adapter = CREATEOBJECT("XMLAdapter")

* Read the XML file into the XMLAdapter object.
adapter.LoadXML(lcFile,.T.)

* Data Type for the first field is changed from 'Integer' to 'Character'.
adapter.Tables(1).Fields(1).DataType = "C"
adapter.Tables(1).Fields(1).MaxLength = 6

* Create a cursor from the contents of the XML file.
adapter.Tables(1).ToCursor()

* Display the XML file.
MODIFY FILE EmployeeXML.xml NOEDIT NOWAIT

* Browse the table.
BROWSE NOWAIT

lcStr = "An XML file is imported in by using the XMLAdapter's LoadXML method." + ;
		"  Then the data type of the 'Employeeid' field is changed from 'Integer'" + ;
		" to 'Character'.  Finally a cursor is created using the XMLAdapter's" + ;
		" ToCursor method."
MESSAGEBOX(lcStr)

RETURN


