********************************************************************************
* 1_Collections_AddNewItems.prg
* Description:	This program will show how to add new items to a collection.
* Tip:	You can insert before or after an item by using the third or fourth
*		parameter respectively.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL loCollection as Collection
LOCAL lcItem as String
LOCAL lcStr as String

* Create a collection object.
loCollection = CREATEOBJECT("Collection")

* Add the item called "Apples".
loCollection.Add("Apples")

loCollection.Add("Sourdough Bread")

* Display the two items added.
lcStr = "Items contained in the collection after adding two:"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Add "Chicken" item before the second item - "Sourdough Bread".
loCollection.Add("Chicken",,2)

* Display items after inserting the "Chicken" item.
lcStr = "Items contained in the collection after inserting 'Chicken' before 'Sourdough Bread':"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Add "Almonds" item after the first item - "Apples".
loCollection.Add("Almonds",,,1)

* Display items after inserting the "Almonds" item.
lcStr = "Items contained in the collection after inserting 'Almonds' after 'Apples':"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

RETURN
