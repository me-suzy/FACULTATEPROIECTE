********************************************************************************
* 5_FormsUI_EnableHyperLinks.prg
* Description:	This program will show how to use display hyperlinks for Textbox
*				and Editbox controls by setting the EnableHyperLinks property.
* Tip:	To jump to the hyperlink in your browser, position the mouse over the
*		hyperlink then hold the CTRL key and click on the link.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
PUBLIC oForm as Form

* Create a form that contains a Textbox and a Editbox control.
oForm = NEWOBJECT("form1")
oForm.Show()

lcStr = "EnableHyperLinks property for both controls is set to FALSE." + ;
		"  The text does NOT show as hyperlinks."
MESSAGEBOX(lcStr)

* Display images to use for PicturePosition.
oForm.Text1.EnableHyperLinks = .T.
oForm.Edit1.EnableHyperLinks = .T.

lcStr = "EnableHyperLinks property for both controls is set to TRUE." + ;
		"  The text now shows as hyperlinks."
MESSAGEBOX(lcStr)

RETURN

* Form class used for this sample.
DEFINE CLASS form1 AS form
	Caption = "Form1"
	Name = "Form1"
	Width = 440
	
	ADD OBJECT text1 AS textbox WITH ;
		Height = 50, ;
		Width = 400, ;
		Left = 20, ;
		fontsize = 12, ;
		Value = "http://msdn.com/vfoxpro", ;
		Name = "Text1"

	ADD OBJECT edit1 AS editbox WITH ;
		Top = 100, ;
		Height = 100, ;
		Width = 400, ;
		Left = 20, ;
		fontsize = 12, ;
		Value = "http://msdn.microsoft.com/vfoxpro/community/related", ;
		Name = "Edit1"

ENDDEFINE
