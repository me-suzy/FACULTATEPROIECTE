********************************************************************************
* 1_FormsUI_GDIPlusImaging.prg
* Description:	This program will show how to use animated GIF images and how to
*				rotate/flip images using the new RotateFlip property.
* Tip:	The Image class now supports 12 different image formats.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
PUBLIC oForm as Form

* Create a form that contains an image
oForm = NEWOBJECT("form1")
oForm.Show()

* Set the Picture property of the Image object to an animated GIF.
oForm.Image1.Picture = HOME(4) + "Gifs\MorphFox.gif"

lcStr = "The animated image after setting the Picture property of the image."
MESSAGEBOX(lcStr)

* Display another image to use for RotateFlip.
*oForm.Image1.Picture = HOME(1) + "Fox.bmp"

* Iterate through all the options for RotateFlip and display the image.
FOR i = 0 TO 7
	* Set the RotateFlip property of the Image object to change the display of
	* the image.
	oForm.Image1.RotateFlip = i

	lcStr = "An image after setting the RotateFlip property of the image to " + ;
			TRANSFORM(i)
	MESSAGEBOX(lcStr)
ENDFOR

* Reset RotateFlip property to the default (none).
oForm.Image1.RotateFlip = 0

RETURN

* Form class used for this sample.
DEFINE CLASS form1 AS form
	Caption = "Form1"
	Name = "Form1"
	
	ADD OBJECT image1 AS image WITH ;
		Left = 100, ;
		Top = 75, ;
		Name = "Image1"

ENDDEFINE
