********************************************************************************
* 4_FormsUI_TabOrientation.prg
* Description:	This program will show how to use Pageframe's TabOrientation to
*				control where the tabs display.  There are four locations that
*				can be set.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
PUBLIC oForm as Form

* Create a form that contains a Pageframe.
oForm = NEWOBJECT("form1")
oForm.Show()

* Iterate through all the options for TabOrientation property of the Pageframe.
FOR i = 0 TO 3
	* Set the TabOrientation property to change the location of the tabs.
	oForm.Pageframe1.TabOrientation = i

	lcStr = "The Pageframe after setting the TabOrientation property to " + ;
			TRANSFORM(i)
	MESSAGEBOX(lcStr)
ENDFOR

RETURN

* Form class used for this sample.
DEFINE CLASS form1 AS form
	Caption = "Form1"
	Name = "Form1"
	fontsize = 16

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

ENDDEFINE
