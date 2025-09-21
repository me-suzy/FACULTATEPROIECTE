********************************************************************************
* 1_EmptyClass_Basic.prg
* Description:	This program will show how to add and remove properties to an
*				instance of an Empty class.
* Tip:	The Empty class is the lightest weight class available.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL loEmpty as Empty
LOCAL lnCnt as Integer
LOCAL lnItem as Integer
LOCAL lcStr as String

* Create a collection object.
loEmpty = CREATEOBJECT("Empty")

* The Empty object has no members
lnCnt = AMEMBERS(aEmpty,loEmpty)

lcStr = "There are no members when an Empty class is instantiated." + CRLF+CRLF + ;
		"Number of members:  " + TRANSFORM(lnCnt)
MESSAGEBOX(lcStr)

* Adding properties to the Empty object
ADDPROPERTY(loEmpty,"FirstName","John")
ADDPROPERTY(loEmpty,"LastName","Smith")
ADDPROPERTY(loEmpty,"Company","ABC Company")

* Display the added members
AMEMBERS(aEmpty,loEmpty)
lcStr = "Three properties added to the Empty object:"+CRLF+CRLF
FOR lnItem = 1 TO ALEN(aEmpty)
	lcStr = lcStr + aEmpty(lnItem) + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Remove LastName property
REMOVEPROPERTY(loEmpty,"LastName")

* Display the members after removing a property
AMEMBERS(aEmpty,loEmpty)
lcStr = "The 'LastName' property is removed from the Empty object:"+CRLF+CRLF
FOR lnItem = 1 TO ALEN(aEmpty)
	lcStr = lcStr + aEmpty(lnItem) + CRLF
ENDFOR
MESSAGEBOX(lcStr)

RETURN
