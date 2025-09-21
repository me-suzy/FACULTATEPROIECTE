********************************************************************************
* 1_Grid_AutoFit.prg
* Description:	The AutoFit method allows developers to resize all columns or 
*				specific columns of a grid to automatically fit to show all
*				information in the column(s).
* Tip:	The autofit functionality only adjusts for the rows being displayed in
*		the form.  As the user scrolls down the grid, there could be columns
*		that need to be adjusted again to show all the data.
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

lcStr = "The grid before any auto fitting of columns."
MESSAGEBOX(lcStr)

* Autofit the Company column by calling the column's AutoFit method.
oForm.Grid1.Column2.AutoFit()

lcStr = "The grid after auto fitting the 'Company' column." + CRLF+CRLF + ;
		"The user can perform the same functionality of auto fitting" + ;
		" a column by double clicking the area between column headers" + ;
		" to resize the column to the left."
MESSAGEBOX(lcStr)

* Autofit all the columns of the grid by calling the grid's AutoFit method.
oForm.Grid1.AutoFit()

lcStr = "The grid after auto fitting of all the columns." + CRLF+CRLF + ;
		"The user can perform the same functionality of auto fitting" + ;
		" all the columns by double clicking on the upper left corner of the" + ;
		" grid in the small square just to the left of the first header."
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
