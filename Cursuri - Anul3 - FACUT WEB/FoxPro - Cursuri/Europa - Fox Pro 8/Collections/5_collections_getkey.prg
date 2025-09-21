********************************************************************************
* 5_Collections_GetKey.prg
* Description:	This program will show the different ways to find items in the
*				collections by using the GetKey method.
* Tip:	The GetKey method allows you to find items based on the index or the
*		key.  If you use the index to find an item, the key is returned.  If the
*		key is used to find the item, the index integer is returned.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL loCollection as Collection
LOCAL lcItem as String
LOCAL lcStr as String
LOCAL lnItem as Integer

* Create a collection object.
loCollection = CREATEOBJECT("Collection")

* Add items to the collection.
loCollection.Add("Apples [FRUIT]", "FRUIT")
loCollection.Add("Sourdough Bread [GRAIN]", "GRAIN")
loCollection.Add("Chicken [POULTRY]", "POULTRY")
loCollection.Add("Almonds [NUTS]","NUTS")

* Find the third item in the collection.  This will return the Key value of the
* item in the collection.
lcItem = loCollection.GetKey(3)

lcStr = "The third item in the collection has the Key value of:" + CRLF+CRLF + lcItem
MESSAGEBOX(lcStr)

* Find the item in the collection that has the Key value of "POULTRY".  This will
* return the index of the item in the collection.
lnItem = loCollection.GetKey("POULTRY")

lcStr = "The index of the item in the collection which has 'POULTRY' as it's Key value is:" + CRLF+CRLF + TRANSFORM(lnItem)
MESSAGEBOX(lcStr)

RETURN
