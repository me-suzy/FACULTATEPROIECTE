********************************************************************************
* 1_SubClassMember_Page.prg
* Description:	This program will show how to use member classes for a 
*				Pageframe.  This new features allows custom pages to be added
*				to a Pageframe at design time and run time.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
PUBLIC oForm as Form

* Create a form.
oForm = NEWOBJECT("form1")
oForm.Show()

* Set the Member Class properties to point to the location and class name to
* use when adding new pages.
oForm.Pageframe1.MemberClassLibrary = "1_subclassmember_page.prg"
oForm.Pageframe1.MemberClass = "CustomPage1"

* Add a page to the Pageframe object.  The class used will be 'CustomPage1'. 
oForm.Pageframe1.PageCount = 1

* Set the Member Class properties to point to another class name to use when
* adding subsequent pages to the Pageframe object.
oForm.Pageframe1.MemberClassLibrary = "1_subclassmember_page.prg"
oForm.Pageframe1.MemberClass = "CustomPage2"

* Add a page to the Pageframe object.  The class used will be 'CustomPage2'. 
oForm.Pageframe1.PageCount = 2

lcStr = "Two pages have been added to the Pageframe object.  The first page" + ;
		" istantiated from the 'CustomPage1' class.  The second page"  + ;
		" istantiated from a different class called 'CustomPage2'."

MESSAGEBOX(lcStr)

RETURN

* Form class used for this sample.
DEFINE CLASS form1 AS form
	Caption = "Form1"
	Name = "Form1"

	ADD OBJECT pageframe1 AS pageframe WITH ;
		PageCount = 0, ;
		Top = 40, ;
		Left = 12, ;
		Width = 241, ;
		Height = 169, ;
		Name = "Pageframe1"

ENDDEFINE

* Custom Page class for first page in the Pageframe
DEFINE CLASS CustomPage1 AS Page
	PROCEDURE Init	
		This.Caption = "CustomPage1"
		This.AddObject("Label1","label")
		This.Label1.Caption = "CustomPage1 Page class"
		This.Label1.AutoSize = .T.
		This.Label1.Visible = .T.
		This.AddObject("Combo1","combobox")
		This.Combo1.Picture = HOME(1) + "fox.bmp"
		This.Combo1.PictureSelectionDisplay = 2
		This.Combo1.RowSourceType = 1
		This.Combo1.Height = 24
		This.Combo1.Left = 23
		This.Combo1.Top = 20
		This.Combo1.Width = 192
		This.Combo1.AddItem("Apples")
		This.Combo1.AddItem("Oranges")
		This.Combo1.AddItem("Bananas")
		This.Combo1.Picture[1] = HOME(1) + "Fox.bmp"
		This.Combo1.Picture[2] = HOME(1) + "Fox.bmp"
		This.Combo1.Picture[3] = HOME(1) + "Fox.bmp"
		This.Combo1.Selected(1) = .t.
		This.Combo1.Visible = .t.
	ENDPROC
ENDDEFINE

* Custom Page class for second page in the Pageframe
DEFINE CLASS CustomPage2 AS Page
	PROCEDURE Init	
		This.Caption = "CustomPage2"
		This.AddObject("Label1","label")
		This.Label1.Caption = "CustomPage2 Page class"
		This.Label1.AutoSize = .T.
		This.Label1.Visible = .T.
		This.AddObject("Command1","commandbutton")
		This.Command1.Top = 20
		This.Command1.Left = 23
		This.Command1.Height = 27
		This.Command1.Width = 84
		This.Command1.Caption = "Command1"
		This.Command1.BackColor = RGB(255,128,192)
		This.Command1.Visible = .t.		
	ENDPROC
ENDDEFINE

