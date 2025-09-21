********************************************************************************
* 3_SubClassMember_Grid.prg
* Description:	This program will show how to use member classes for grid
*				columns and column headers.  This new features allows custom
*				columns and headers to be added	to a Grid at run time.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
LOCAL lcDataPath as String
PUBLIC oForm as Form

CLOSE TABLES ALL

* Set location of where the sample data is stored
lcDataPath = _samples + "\Data\"

* Select records from the sample Customer table
SELECT cust_id, company, contact FROM (lcDataPath + "Customer") ;
	INTO CURSOR curCust
GO TOP

* Create a form.
oForm = NEWOBJECT("form1")
oForm.Show()

* Set the grid's header height.
oForm.Grid1.HeaderHeight = 50

* Set the Member Class properties to point to the location and class name to
* use when adding new columns.
oForm.Grid1.MemberClassLibrary = "3_subclassmember_grid.prg"
oForm.Grid1.MemberClass = "CustomColumn1"

* Add a column and its associated custom header class to the Grid. 
oForm.Grid1.ColumnCount = 1

* Set the Member Class properties to point to another class name to use when
* adding subsequent columns to the Grid.
oForm.Grid1.MemberClassLibrary = "3_subclassmember_grid.prg"
oForm.Grid1.MemberClass = "CustomColumn2"

*!*	* Add another column and its custom header class. 
oForm.Grid1.ColumnCount = 2

lcStr = "Two custom columns have been added to the Grid object.  Each column" + ;
		" has its own custom header member class."

MESSAGEBOX(lcStr)

RETURN

* Form class used for this sample.
DEFINE CLASS form1 AS form
	Caption = "Form1"
	Name = "Form1"
	Width = 400

	ADD OBJECT grid1 AS grid WITH ;
		Height = 200, ;
		Left = 24, ;
		ColumnCount = 0, ;
		Top = 25, ;
		Width = 350, ;
		RecordSource = "curCust", ;
		Name = "Grid1"

ENDDEFINE

* Custom Column class for first column in the Grid
DEFINE CLASS CustomColumn1 AS Column
	BackColor = RGB(255,0,0)
	FontBold = .T.
	Width = 150
	HeaderClassLibrary = "3_subclassmember_grid.prg"
	HeaderClass = "CustomHeader1"
	PROCEDURE Init	
		This.ControlSource = "curCust.company"
	ENDPROC
ENDDEFINE

* Custom Column class for second column in the Grid
DEFINE CLASS CustomColumn2 AS Column
	BackColor = RGB(0,255,0)
	FontItalic = .T.
	Width = 150
	HeaderClassLibrary = "3_subclassmember_grid.prg"
	HeaderClass = "CustomHeader2"
	PROCEDURE Init	
		This.ControlSource = "curCust.contact"
	ENDPROC
ENDDEFINE

* Custom Header class for first column in the Grid
DEFINE CLASS CustomHeader1 AS Header
	Caption = "CustomHeader1"
	Picture = _samples + "\Classes\Watch.bmp"
ENDDEFINE

* Custom Header class for second column in the Grid
DEFINE CLASS CustomHeader2 AS Header
	Caption = "CustomHeader2"
	Picture = HOME(0) + "Fox.bmp"
ENDDEFINE

