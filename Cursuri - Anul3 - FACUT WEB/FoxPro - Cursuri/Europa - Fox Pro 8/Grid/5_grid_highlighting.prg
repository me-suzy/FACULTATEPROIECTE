********************************************************************************
* 5_Grid_Highlighting.prg
* Description:	The grid now offers five properties which affect how selected
*				rows and individual columns display for colors.  The the 
*				HighlightStyle property determines if the other highlighting 
*				properties will be used to determine how the grid will be 
*				displayed.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
PUBLIC oForm as Form

* Set location of where the sample data is stored
lcDataPath = _samples + "\Data\"

* Select records from the sample Customer table
SELECT cust_id, company FROM (lcDataPath + "Customer") ;
	INTO CURSOR curCust
GO TOP

* Create a form that contains a grid
oForm = NEWOBJECT("form1")
oForm.Show()

* Set the HighlightStyle property to 2 which allows the grid's highlighting colors
* to persist even when the grid does not have focus.
oForm.Grid1.HighlightStyle = 2

* Set the HighlightForeColor property to 'yellow' which determines the forecolor 
* of the selected row.
oForm.Grid1.HighlightForeColor = RGB(255,255,0)

* Set the HighlightBackColor property to 'blue' which determines the backcolor 
* of the selected row.
oForm.Grid1.HighlightBackColor = RGB(0,0,255)

* Set the SelectedItemForeColor property to 'red' which determines the forecolor 
* of the selected column for the selected row.
oForm.Grid1.SelectedItemForeColor = RGB(255,0,0)

* Set the SelectedItemBackColor property to 'green' which determines the backcolor 
* of the selected column for the selected row.
oForm.Grid1.SelectedItemBackColor = RGB(0,255,0)

lcStr = "The grid after setting the highlighting properties." + CRLF+CRLF + ;
		"Move to different columns/rows and notice how the colors change as you move."
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
