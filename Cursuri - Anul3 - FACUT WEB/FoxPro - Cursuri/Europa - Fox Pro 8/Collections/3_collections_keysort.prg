********************************************************************************
* 3_Collections_KeySort.prg
* Description:	This program will show the different ways to sort collections by
*				using the KeySort property.
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

* Sort the items in the collections by setting the KeySort property to 
* 0 - Index Ascending.
loCollection.KeySort = 0

* Display all items in the collection.
lcStr = "Collection items are sorted by setting KeySort property to 0 - 'Index Ascending':"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Sort the items in the collections by setting the KeySort property to 
* 1 - Index Descending.
loCollection.KeySort = 1

* Display all items in the collection.
lcStr = "Collection items are sorted by setting KeySort property to 1 - 'Index Descending':"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Sort the items in the collections by setting the KeySort property to 
* 2 - Key Ascending.
loCollection.KeySort = 2

* Display all items in the collection.
lcStr = "Collection items are sorted by setting KeySort property to 2 - 'Key Ascending':"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

* Sort the items in the collections by setting the KeySort property to 
* 3 - Key Descending.
loCollection.KeySort = 3

* Display all items in the collection.
lcStr = "Collection items are sorted by setting KeySort property to 3 - 'Key Descending':"+CRLF+CRLF
FOR EACH lcItem IN loCollection
   lcStr = lcStr + lcItem + CRLF
ENDFOR
MESSAGEBOX(lcStr)

RETURN
