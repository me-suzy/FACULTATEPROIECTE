********************************************************************************
* 7_Grid_LockColumns.prg
* Description:	Grid columns can now be locked to always have certain columns
*				visible.
* Tip:	Users can right-click on the area between column headers to lock the
*		columns to the left.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
PUBLIC oForm as Form

* Set location of where the sample data is stored
lcDataPath = _samples + "\Data\"

* Select records from the sample Customer table
SELECT * FROM (lcDataPath + "Customer") ;
	INTO CURSOR curCust
GO TOP

* Create a form that contains a grid
oForm = NEWOBJECT("form1")
oForm.Show()

* Set the LockColumns property of a grid to the number of columns to lock.
oForm.Grid1.LockColumns = 2

lcStr = "The grid after locking the 'Cust_ID' and 'Company' columns by setting" + ;
		" the grid's LockColumns property to 2 (number of columns to" + ;
		" lock)." + CRLF+CRLF + ;
		"Users can right-click on the area between column headers to lock the" + ;
		" columns to the left."
MESSAGEBOX(lcStr)

RETURN

* Form class used for this sample.
DEFINE CLASS form1 AS form
	Height = 250
	Width = 583
	Caption = "Form1"
	Name = "Form1"

	ADD OBJECT grid1 AS grid WITH ;
		Height = 200, ;
		Left = 24, ;
		RecordSource = "curCust", ;
		Top = 25, ;
		Width = 532, ;
		Name = "Grid1"
ENDDEFINE
