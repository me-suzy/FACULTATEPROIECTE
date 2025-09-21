********************************************************************************
* 1_XMLAdapter_LoadXML.prg
* Description:	This program will show how to read an XML file and create a 
*				cursor using the XMLAdapter class.
* Tip:	The LoadXML method can load XML from a file or from a variable by 
*		setting second parameter to a true to read from a file or false to read 
*		the XML from a variable.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcFile as String
LOCAL lcStr as String

CLOSE TABLES ALL

* Name of an XML file.
lcFile = "CustomerXML.xml"

* Create an XMLAdapter object to load the XML file into.
adapter = CREATEOBJECT("XMLAdapter")

* Read the XML file into the XMLAdapter object.
adapter.LoadXML(lcFile,.T.)

* Create a cursor from the contents of the XML file.
adapter.Tables(1).ToCursor()

* Display the XML file.
MODIFY FILE CustomerXML.xml NOEDIT NOWAIT

* Browse the table.
BROWSE NOWAIT

lcStr = "An XML file is imported in by using the XMLAdapter's LoadXML method." + ;
		"  Then a cursor is created based on the contents of the XML by" + ;
		" using the XMLAdapter's ToCursor method."
MESSAGEBOX(lcStr)

RETURN


