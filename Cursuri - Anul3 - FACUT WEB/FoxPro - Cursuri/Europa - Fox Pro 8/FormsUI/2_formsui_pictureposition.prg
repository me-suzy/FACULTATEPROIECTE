********************************************************************************
* 2_FormsUI_PicturePosition.prg
* Description:	This program will show how to use the PicturePosition property
*				for Command buttons, Checkboxes, and Option buttons.  The
*				property allows for you to define the location of where the 
*				image will display on the control.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
PUBLIC oForm as Form

* Create a form that contains a Command button, Checkbox, and Option button.
oForm = NEWOBJECT("form1")
oForm.Show()

* Display images to use for PicturePosition.
oForm.Command1.Picture = HOME(1) + "Fox.bmp"
oForm.Check1.Picture = HOME(1) + "Fox.bmp"
oForm.Option1.Picture = HOME(1) + "Fox.bmp"

* Iterate through all the options for PicturePosition and display the image.
FOR i = 0 TO 13
	* Set the PicturePosition property of the different objects to change the 
	* location of the image.
	oForm.Command1.PicturePosition = i
	oForm.Check1.PicturePosition = i
	oForm.Option1.PicturePosition = i
	oForm.Refresh()

	lcStr = "An image after setting the PicturePosition property of the image to " + ;
			TRANSFORM(i)
	MESSAGEBOX(lcStr)
ENDFOR

* Reset PicturePosition property to the default.
oForm.Command1.PicturePosition = 13
oForm.Check1.PicturePosition = 13
oForm.Option1.PicturePosition = 13

RETURN

* Form class used for this sample.
DEFINE CLASS form1 AS form
	Caption = "Form1"
	Name = "Form1"
	
	ADD OBJECT command1 AS commandbutton WITH ;
		Height = 50, ;
		Width = 120, ;
		Name = "Command1"

	ADD OBJECT check1 AS checkbox WITH ;
		Left = 150, ;
		Height = 50, ;
		Width = 120, ;
		Style = 1, ;
		Name = "Check1"

	ADD OBJECT option1 AS optionbutton WITH ;
		Top = 100, ;
		Height = 50, ;
		Width = 120, ;
		Style = 1, ;
		Name = "Option1"

ENDDEFINE
