********************************************************************************
* 4_Collections_RemoveItems.prg
* Description:	This program will show how to remove items from a collection.
* Tip:	You can remove all the items in a collection by passing in "-1" as a
*		parameter to the Remove method.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL loCollection as Collection
LOCAL lcItem as String
LOCAL lcStr as String

* Create a collection object.
loCollection = CREATEOBJECT("Collection")

* Add items to the collection.
loCollection.Add("Apples [FRUIT]", "FRUIT")
loCollection.Add("Sourdough Bread [GRAIN]", "GRAIN")
loCollection.Add("Chicken [POULTRY]", "POULTRY")
loCollection.Add("Almonds [NUTS]","NUTS")

* Display all items in the collection.
lcStr = "Collection items:"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Remove an item based on it's index
loCollection.Remove(3)

* Display items after removing the third item.
lcStr = "Items contained in the collection after removing the third item:"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Remove an item based on it's key
loCollection.Remove("GRAIN")

* Display items after removing the item with the Key 'GRAIN'.
lcStr = "Items contained in the collection after removing the item with the Key 'GRAIN':"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Remove the rest of the items in the collection
loCollection.Remove(-1)

* Display the Count of items in the collection which is zero.
lcStr = "All items in the collection have been removed by passing a '-1' to the Remove method"+CRLF+CRLF
lcStr = lcStr + "Collection's Count: " + TRANSFORM(loCollection.Count)
MESSAGEBOX(lcStr)

RETURN
