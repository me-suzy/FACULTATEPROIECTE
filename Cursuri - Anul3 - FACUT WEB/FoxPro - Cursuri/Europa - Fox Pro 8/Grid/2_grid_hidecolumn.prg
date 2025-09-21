********************************************************************************
* 2_Grid_HideColumn.prg
* Description:	Grid columns now have a Visible property to allow developers to 
*				hide specific columns.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
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

lcStr = "The grid before hiding a column."
MESSAGEBOX(lcStr)

* Set the Visible property of a column to false to hide it.
oForm.Grid1.Column2.Visible = .f.

lcStr = "The grid after hiding the 'Company' column by setting the column's" + ;
 		" Visible property to false."
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
