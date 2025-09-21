LOCAL loWord
LOCAL loDocument
LOCAL loRange

#DEFINE ccCR  CHR(13)
#DEFINE ccTAB CHR(9)

OPEN DATABASE ch17

USE v_shortcontactlist

loWord         = CREATEOBJECT("Word.Application")
loWord.Visible = .T.

* Create a new document using the default template "Normal"
loDocument     = loWord.Documents.Add() 
loRange        = loDocument.Range()

loRange.ParagraphFormat.Alignment = 1  && Center
loRange.InsertAfter("1001 Things You Wanted to Know About VFP" + ccCR)
loRange.InsertAfter("Word Contacts Report" + ccCR)

loRange.InsertAfter(ccCR)
loRange.ParagraphFormat.Alignment = 0  && Right
loRange.InsertAfter("Name" + ccTAB + ccTAB)
loRange.InsertAfter("Company" + ccTAB + ccTAB)
loRange.InsertAfter("Email" + ccCR)

SCAN
   loRange.InsertAfter(ALLTRIM(Last_Name) + ", " + ALLTRIM(First_name) + ccTAB + ccTAB)
   loRange.InsertAfter(ALLTRIM(Company_Name) + ccTAB + ccTAB)
   loRange.InsertAfter(ALLTRIM(Email_Name) + ccCR)
ENDSCAN

loRange.Font.Name = "Tahoma"
loRange.Font.Size = 10

lcDirectory = FULLPATH(CURDIR())

loWord.ActiveDocument.SaveAs(lcDirectory + "ContList.doc")
loWord.Quit()

RELEASE loRange
RELEASE loDocument
RELEASE loWord

RETURN

*: EOF :*