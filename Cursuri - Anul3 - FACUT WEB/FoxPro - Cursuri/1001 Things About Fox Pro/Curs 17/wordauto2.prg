LOCAL loWord
LOCAL loDocument
LOCAL loRange
LOCAL loTable

#DEFINE ccCR  CHR(13)
#DEFINE ccTAB CHR(9)

OPEN DATABASE ch17
USE v_shortcontactlist IN 0 
SELECT v_shortcontactlist

lnRecCount = RECCOUNT("v_shortcontactlist")

loWord         = CREATEOBJECT("Word.Application")
loWord.Visible = .T.

* Create a new document using the default template "Normal"
loDocument     = loWord.Documents.Add() 
loRange        = loDocument.Range()

* Create a Word table with 1 extra row than data, and 3 columns
loTable = loWord.ActiveDocument.Tables.Add(loRange, lnRecCount + 1, 3)

WITH loTable
   WITH .Rows[1]
      .Cells[1].Range.InsertAfter("Name")
      .Cells[1].Range.Font.Name = "Tahoma"
      .Cells[2].Range.InsertAfter("Company")
      .Cells[2].Range.Font.Name = "Tahoma"
      .Cells[3].Range.InsertAfter("Email")
      .Cells[3].Range.Font.Name = "Tahoma"
      .Shading.Texture = 100
   ENDWITH

   SCAN
      WITH .Rows[RECNO()+1]
         .Cells[1].Range.InsertAfter(ALLTRIM(Last_Name) + ", " + ALLTRIM(First_name))
         .Cells[1].Range.Font.Name = "Tahoma"
         .Cells[1].Range.Font.Size = 10
         .Cells[2].Range.InsertAfter(ALLTRIM(Company_Name))
         .Cells[2].Range.Font.Name = "Tahoma"
         .Cells[2].Range.Font.Size = 10
         .Cells[3].Range.InsertAfter(ALLTRIM(Email_Name))
         .Cells[3].Range.Font.Name = "Tahoma"
         .Cells[3].Range.Font.Size = 10
      ENDWITH
   ENDSCAN
ENDWITH

lcDirectory = FULLPATH(CURDIR())

loWord.ActiveDocument.SaveAs(lcDirectory + "ContList.doc")
loWord.Quit()

RELEASE loDocRange
RELEASE loTable
RELEASE loRange
RELEASE loDocument
RELEASE loWord

RETURN

*: EOF :*