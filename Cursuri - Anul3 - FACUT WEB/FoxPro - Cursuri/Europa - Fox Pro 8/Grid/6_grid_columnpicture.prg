********************************************************************************
* 6_Grid_ColumnPicture.prg
* Description:	Grid columns can now have a header that contains a picture.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
LOCAL lcDataPath as String
PUBLIC oForm as Form

* Set location of where the sample data is stored
lcDataPath = _samples + "\Data\"

* Select records from the sample Customer table
SELECT cust_id, company, contact FROM (lcDataPath + "Customer") ;
	INTO CURSOR curCust
GO TOP

* Create a form that contains a grid
oForm = NEWOBJECT("form1")
oForm.Show()

* Change the height of the grid's headers to accomodate the picture.
oForm.Grid1.HeaderHeight = 22

* Set the Picture property of the header to an image.
oForm.Grid1.Column2.Header1.Picture = _samples + "\Classes\Watch.bmp"

lcStr = "The grid after setting the Picture property of the header."
MESSAGEBOX(lcStr)

RETURN

* Form class used for this sample.
DEFINE CLASS form1 AS form
	Height = 250
	Width = 483
	Caption = "Form1"
	Name = "Form1"
	
	ADD OBJECT grid1 AS grid WITH ;
		Height = 200, ;
		Left = 24, ;
		RecordSource = "curCust", ;
		Top = 25, ;
		Width = 432, ;
		Name = "Grid1"
		
ENDDEFINE
