********************************************************************************
* 4_Grid_AllowCellSelection.prg
* Description:	The grid's AllowCellSelection property when set to false, 
*				disables the ability for the user to enter contents in columns
*				but instead displays the row similar to a listbox.
* Tip:	This feature allows you to have the finer control of a grid to display
*		multiple columns for one row but not allow the selection of a column
*		when the user selects a row.
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

lcStr = "The grid before setting the AllowCellSelection property to false."
MESSAGEBOX(lcStr)

* Set the AllowCellSelection property to false to disable the ability to select
* columns in the grid.
oForm.Grid1.AllowCellSelection = .f.

lcStr = "The grid after setting the AllowCellSelection property to false." + CRLF+CRLF + ;
		"Click on different columns and notice how the entire row is selected."
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
