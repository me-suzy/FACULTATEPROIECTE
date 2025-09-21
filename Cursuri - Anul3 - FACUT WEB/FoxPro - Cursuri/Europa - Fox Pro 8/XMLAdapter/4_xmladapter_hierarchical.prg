********************************************************************************
* 4_XMLAdapter_Hierarchical.prg
* Description:	This program will show how load from an XML file hierarchical
*				data and generate multiple cursors.
* Tip:	This sample also demonstrates how an external schema file can be use.
*		The .NET Framework can generate hierarchical XML that can be used
*		imported into VFP by using the XMLAdapter class.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcFile as String
LOCAL lcXSDFile as String
LOCAL lcStr as String

CLOSE TABLES ALL

* Name of an XML file.
lcFile = "DotNET.xml"

* Name of an XSD file that contains the schema.
lcXSDFile = "DotNET.xsd"

* Create an XMLAdapter object to load the XML file into.
adapter = CREATEOBJECT("XMLAdapter")

* Set the XMLAdapter's XMLSchemaLocation property for where to find an external
* schema file.
adapter.XMLSchemaLocation = lcXSDFile

* Read the XML file into the XMLAdapter object.
adapter.LoadXML(lcFile,.T.)

* Iterate through all the XMLTables created from the XML file and generate
* cursors.
FOR EACH oXMLTable IN adapter.Tables
	* Create a cursor from one of the XMLTables created from the contents of the 
	* XML file.
	oXMLTable.ToCursor()
	
	* Browse the table.
	BROWSE NOWAIT
ENDFOR

* Display the XML and XSD files.
MODIFY FILE DotNET.xml NOEDIT NOWAIT
MODIFY FILE DotNET.xsd NOEDIT NOWAIT

lcStr = "An XML file containing data from three tables is imported in by using the" + ; 
		" XMLAdapter's LoadXML method.  Then three cursors are created based on" + ;
		" the contents of the XML by using the ToCursor method for each" + ;
		" XMLTable contained in the XMLAdapter object."
MESSAGEBOX(lcStr)

RETURN


