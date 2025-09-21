********************************************************************************
* 3_FormsUI_Themes.prg
* Description:	This program will show how to use Themes.  Themes can be turned
*				off/on for each control to give you finer control of how the 
*				controls display.
* Tips:	You must be running Windows XP or higher to use this example.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
PUBLIC oForm as Form

* Check for Windows XP or higher.
IF (VAL(OS(3)) = 5 AND VAL(OS(4)) = 0) OR VAL(OS(3)) < 5
	MESSAGEBOX("You must have Windows XP or higher to use this example.")
	RETURN
ENDIF

* Create a form.
oForm = NEWOBJECT("form1")
oForm.Show()

* Turn Themes on globally.
SYS(2700,1)

lcStr = "Themes turned ON globally"
MESSAGEBOX(lcStr)

* Turn OFF Themes for the form
oForm.Themes = .F.

lcStr = "Turned OFF Themes for the form"
MESSAGEBOX(lcStr)

oForm.Themes = .T.

* Turn ON Themes for the PageFrame
oForm.Command1.Themes = .F.

lcStr = "Turned ON Themes for Form but turned OFF Themes for the Command button" + ;
		CRLF+CRLF + "Themes can be turned off/on for each control to give you finer" + ;
		" control of how the controls display."
MESSAGEBOX(lcStr)

RETURN

* Form class used for this sample.
DEFINE CLASS form1 AS form
	Caption = "Form1"
	Name = "Form1"

	ADD OBJECT pageframe1 AS pageframe WITH ;
		PageCount = 2, ;
		Top = 40, ;
		Left = 12, ;
		Width = 241, ;
		Height = 169, ;
		Name = "Pageframe1", ;
		Page1.Caption = "Page1", ;
		Page1.Name = "Page1", ;
		Page2.Caption = "Page2", ;
		Page2.Name = "Page2"

	PROCEDURE Init
		This.Pageframe1.Page1.AddObject("Combo1","combobox")
		This.Pageframe1.Page1.Combo1.Picture = HOME(1) + "fox.bmp"
		This.Pageframe1.Page1.Combo1.PictureSelectionDisplay = 2
		This.Pageframe1.Page1.Combo1.RowSourceType = 1
		This.Pageframe1.Page1.Combo1.Height = 24
		This.Pageframe1.Page1.Combo1.Left = 23
		This.Pageframe1.Page1.Combo1.Top = 20
		This.Pageframe1.Page1.Combo1.Width = 192
		This.Pageframe1.Page1.Combo1.AddItem("Apples")
		This.Pageframe1.Page1.Combo1.AddItem("Oranges")
		This.Pageframe1.Page1.Combo1.AddItem("Bananas")
		This.Pageframe1.Page1.Combo1.Picture[1] = HOME(1) + "Fox.bmp"
		This.Pageframe1.Page1.Combo1.Picture[2] = HOME(1) + "Fox.bmp"
		This.Pageframe1.Page1.Combo1.Picture[3] = HOME(1) + "Fox.bmp"
		This.Pageframe1.Page1.Combo1.Selected(1) = .t.
		This.Pageframe1.Page1.Combo1.Visible = .t.

		This.AddObject("Command1","commandbutton")
		This.Command1.Top = 5
		This.Command1.Left = 23
		This.Command1.Height = 27
		This.Command1.Width = 84
		This.Command1.Caption = "Command1"
		This.Command1.BackColor = RGB(255,128,192)
		This.Command1.Visible = .t.		
	ENDPROC
ENDDEFINE
