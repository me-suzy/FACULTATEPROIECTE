********************************************************************************
* 2_Collections_AddNewItemsWithKey.prg
* Description:	This program will show how to add new items to a collection.
* Tip:	When adding a new item to the collections, use the optional Key
*		parameter to provide a unique id for each item.  You can then sort and
*		find items based on the Key.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL loCollection as Collection
LOCAL lcItem as String
LOCAL lcStr as String

* Create a collection object.
loCollection = CREATEOBJECT("Collection")

* Add the item called "Apples" with a Key of "FRUIT".
loCollection.Add("Apples", "FRUIT")

loCollection.Add("Sourdough Bread", "GRAIN")

* Display the two items added.
lcStr = "Items contained in the collection after adding two:"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Add "Chicken" item before the Key "GRAIN".
loCollection.Add("Chicken", "POULTRY", "GRAIN")

* Display items after inserting the "Chicken" item.
lcStr = "Items contained in the collection after inserting 'Chicken' before 'Sourdough Bread':"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Add "Almonds" item after the Key "FRUIT".
loCollection.Add("Almonds","NUTS",,"FRUIT")

* Display items after inserting the "Almonds" item.
lcStr = "Items contained in the collection after inserting 'Almonds' after 'Apples':"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

RETURN
