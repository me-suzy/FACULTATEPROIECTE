********************************************************************************
* 4_EventBinding_Forms.prg
* Description:	This program will show how you can bind the AfterRowColChange
*				event of a grid to another form to refresh the associated child
*				data for the current record.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

PUBLIC oForm1
PUBLIC oForm2
PUBLIC cDataPath
LOCAL lnSelect as Integer

* Save environment.
lnSelect = SELECT()
SELECT 0

* Set location of where the sample data is stored
cDataPath = _samples + "\Data\"

* Select records from the sample Customer table
SELECT cust_id, company, contact FROM (cDataPath + "Customer") ;
	INTO CURSOR curCust
GO TOP

* Create an instance of the Orders Form.
oForm2=NEWOBJECT("Form2")
oForm2.Show()

* Create an instance of the Customers Form.
oForm1=NEWOBJECT("Form1")
oForm1.Show()

* Bind the AfterRowColChange event of the Customers form's grid to the Orders
* form's RefreshData method.  This method refreshed the orders for the customer
* selected on the Customer's form.
BINDEVENT(oForm1.Grid1,"AfterRowColChange",oForm2,"RefreshData")

lcStr = "Move around to different records in the Customers form and see how the" + ;
		" Orders form is updated to reflect the current customer's orders.  The" + ;
		" AfterRowColChange event for the grid that displays the customer records" + ;
		" is bound to the refreshing of data in the Orders form."
MESSAGEBOX(lcStr)

* Restore environment.
USE
SELECT (lnSelect)

RETURN


* Customer Form class used for this sample.
DEFINE CLASS Form1 AS form
	Height = 250
	Width = 483
	Caption = "Customers"
	Name = "Form1"

	ADD OBJECT Grid1 AS grid WITH ;
		Height = 200, ;
		Left = 24, ;
		RecordSource = "curCust", ;
		Top = 25, ;
		Width = 432, ;
		Name = "Grid1"
		
		
ENDDEFINE

* Order Form class used for this sample.
DEFINE CLASS Form2 AS form
	Height = 250
	Width = 483
	Top = 300
	Caption = "Orders"
	Name = "Form2"
	
	ADD OBJECT grid1 AS grid WITH ;
		Height = 200, ;
		Left = 24, ;
		Top = 25, ;
		Width = 432, ;
		Name = "Grid1"

	PROCEDURE Init
		* Refresh the order information displayed in the Orders grid.
		This.RefreshData()
	ENDPROC
	
	PROCEDURE RefreshData
		PARAMETERS tRowCol
		
		* Select the Orders associated with the selected Customer.
		SELECT * FROM (cDataPath + "Orders") ;
			WHERE Cust_ID = curCust.Cust_ID ;
			INTO CURSOR curOrders

		* Set the Orders grid's RecordSource property to the selected orders.
		This.Grid1.RecordSource = "curOrders"
		
		* Autofit all the Order information in the grid.
		This.Grid1.AutoFit()
		
		* Refresh the Order form.
		this.Refresh()
	ENDPROC
	
ENDDEFINE
