********************************************************************************
* 3_Grid_CenterCheckbox.prg
* Description:	The checkbox class has a new property called Centered that 
*				when set to true will automatically center a checkbox inside a
*				column in a grid.
* Tip:	If the checkbox in not inside of a grid, then setting the Centered 
*		property to true will center the checkbox within its own control's
*		boundaries.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
PUBLIC oForm as Form

* Set location of where the sample data is stored
lcDataPath = _samples + "\Data\"

* Select records from the sample Customer table
SELECT product_id, discontinu FROM (lcDataPath + "Products") ;
	INTO CURSOR curProd
GO TOP

* Create a form that contains a grid with a chechbox column
oForm = NEWOBJECT("form1")
oForm.Show()

lcStr = "The grid before centering the checkbox column."
MESSAGEBOX(lcStr)

* To center the checkbox column, set the checkbox's Centered property to true.
oForm.Grid1.Column2.Check1.Centered = .t.
oForm.Refresh()

lcStr = "The grid after centering the column by setting the" + ;
		" checkbox's Centered property to true."
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
		RecordSource = "curProd", ;
		Top = 25, ;
		Width = 432, ;
		Name = "Grid1"
		
	PROCEDURE Init
		This.Grid1.Column2.AddObject("Check1","checkbox")
		This.Grid1.Column2.Check1.Caption = ""
		This.Grid1.Column2.CurrentControl = "Check1"
		This.Grid1.Column2.Sparse = .f.
	ENDPROC

ENDDEFINE
