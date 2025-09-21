********************************************************************************
* 2_SubClassMember_Groups.prg
* Description:	This program will show how to use member classes for Command 
*				Groups and Option Groups.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
PUBLIC oForm as Form

* Create a form.
oForm = NEWOBJECT("form1")
oForm.Show()

* Set the Member Class properties to point to the location and class name to
* use when adding new command buttons and option buttons.
oForm.CommandGroup1.MemberClassLibrary = "2_subclassmember_groups.prg"
oForm.CommandGroup1.MemberClass = "CustomCommand1"
oForm.OptionGroup1.MemberClassLibrary = "2_subclassmember_groups.prg"
oForm.OptionGroup1.MemberClass = "CustomOption1"

* Add a command button and option button to their respective group object.  
* The class used will be 'CustomCommand1' and 'CustomOption1'.
oForm.CommandGroup1.ButtonCount = 1
oForm.OptionGroup1.ButtonCount = 1

* Set the Member Class properties to point to another class name to use when
* adding subsequent buttons to the CommandGroup and OptionGroup objects.
oForm.CommandGroup1.MemberClassLibrary = "2_subclassmember_groups.prg"
oForm.CommandGroup1.MemberClass = "CustomCommand2"
oForm.OptionGroup1.MemberClassLibrary = "2_subclassmember_groups.prg"
oForm.OptionGroup1.MemberClass = "CustomOption2"

* Add a command button and option button to their respective group object.  
* The class used will be 'CustomCommand2' and 'CustomOption2'.
oForm.CommandGroup1.ButtonCount = 2
oForm.OptionGroup1.ButtonCount = 2

lcStr = "Command buttons and Option buttons have been added dynamically using" + ;
		" different member classes."

MESSAGEBOX(lcStr)

RETURN

* Form class used for this sample.
DEFINE CLASS form1 AS form
	Caption = "Form1"
	Name = "Form1"

	ADD OBJECT CommandGroup1 AS commandgroup WITH ;
		ButtonCount = 0, ;
		Top = 40, ;
		Left = 10, ;
		Width = 140, ;
		Height = 100, ;
		Name = "CommandGroup1"

	ADD OBJECT OptionGroup1 AS optiongroup WITH ;
		ButtonCount = 0, ;
		Top = 40, ;
		Left = 170, ;
		Width = 140, ;
		Height = 100, ;
		Name = "OptionGroup1"
ENDDEFINE

* Custom Page class for first page in the Pageframe
DEFINE CLASS CustomCommand1 AS CommandButton
	PROCEDURE Init	
		This.Caption = "CustomCommand1"
		This.BackColor = RGB(255,0,0)
		This.Height = 27
		This.Width = 130
		This.Visible = .t.
	ENDPROC
ENDDEFINE

* Custom Page class for second page in the Pageframe
DEFINE CLASS CustomCommand2 AS CommandButton
	PROCEDURE Init	
		This.Caption = "CustomCommand2"
		This.BackColor = RGB(0,255,0)
		This.Height = 27
		This.Width = 130
		This.Visible = .t.
	ENDPROC
ENDDEFINE

* Custom Page class for first page in the Pageframe
DEFINE CLASS CustomOption1 AS OptionButton
	PROCEDURE Init	
		This.Caption = "CustomOption1"
		This.BackColor = RGB(255,0,0)
		This.Height = 27
		This.Width = 130
		This.Visible = .t.
	ENDPROC
ENDDEFINE

* Custom Page class for second page in the Pageframe
DEFINE CLASS CustomOption2 AS OptionButton
	PROCEDURE Init	
		This.Caption = "CustomOption2"
		This.BackColor = RGB(0,255,0)
		This.Height = 27
		This.Width = 130
		This.Visible = .t.
	ENDPROC
ENDDEFINE
