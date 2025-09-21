*-----------------------------------
* IS_CUSTOMIZER.PRG
*
* AUTHOR: Trevor Hancock
* CREATED: 05/11/01 06:48:10 PM
* ABSTRACT: This code, when called from the TOOLS menu
*           will allow the addition of selected text in an editor
*           window to the intellisense table
*-----------------------------------
LPARAMETERS AssignOnKey AS Boolean

IF PARAMETERS() = 1 AND AssignOnKey
	AssignOnKey(SYS(16))
	RETURN .T.
ENDIF


#DEFINE CRLF						CHR(13) + CHR(10)
#DEFINE HKEY_CURRENT_USER		-2147483647
#DEFINE REG_SZ   					1
#DEFINE REG_MODIFER				[IS_CUSTOMIZER_ONKEY_MODIFER]
#DEFINE REG_ONKEY					[IS_CUSTOMIZER_ONKEY_KEY]
#DEFINE REG_VFP7					[Software\Microsoft\VisualFoxPro\7.0]

*!*	Check for selected text by checking the SKIP FOR state of the
*!* Copy pad on the Edit menu
IF SKPBAR('_medit',_MED_COPY)
	MESSAGEBOX("You do not have any text selected." + ;
		" Select a block of code or a command and try again",0+64,"Whoops!")
	RETURN .F.
ENDIF

LOCAL lcFC_Top AS STRING, lcFC_Bottom AS STRING, ;
	lcFC_Insert AS STRING, lcFC_String AS STRING, ;
	loIS_Form AS OBJECT

PUBLIC gcFC_Abrev AS STRING, gcFC_Expanded, gcFC_CODE AS STRING, ;
	gcFC_LocationBlock AS STRING, gbCancel AS Boolean

gbCancel = .T.

*!* Copy the selected text to the clipboard.
SYS(1500,[_med_copy],[_medit])
*!* Open the FOXCODE table for searching/addition.
USE (_FOXCODE) AGAIN IN 0 SHARED ALIAS [FC]
*!* Create the form that allows for customization (defined below)
*loIS_Form = NEWOBJECT([FCFORM],[WORK.VCX],[],_CLIPTEXT,SYS(16))
loIS_Form = NEWOBJECT([FCFORM],SYS(16),[],_CLIPTEXT,SYS(16))
loIS_Form.SHOW(1)

*!* If gbCancel, the user canceled the form by controlbox or the Cancel cmdbutton.
IF gbCancel
	USE IN FC
	RETURN .F.
ENDIF

*!* If the _CLIPTEXT contents has carriage returns or is longer than
*!* 26 chars (the length of the EXAPNDED field in _FOXCODE), than
*!* we make this a CMD instead.
IF CHR(13) $ gcFC_CODE OR LEN(gcFC_CODE) > 26
*!*		The gcFC_LocationBlock string is built in the customize form.
*!*		It contains the numbers of the possible locations for the code
*!*		and was selected by checking the checkboxes on the form
	gcFC_LocationBlock = IIF(EMPTY(gcFC_LocationBlock),[], ;
		[IF !INLIST(oFoxcode.Location,] + gcFC_LocationBlock + [)] + CRLF + ;
		[    RETURN "] + gcFC_Abrev + ["] + CRLF + ;
		[ENDIF])

	lcFC_Top = ;
		[LPARAMETERS oFoxcode] + CRLF + ;
		gcFC_LocationBlock + CRLF + ;
		[oFoxcode.valuetype = "V"] + CRLF + ;
		[LOCAL lcFCCode AS STRING] + CRLF + ;
		[TEXT TO lcFCCode TEXTMERGE NOSHOW]  + CRLF

	lcFC_Bottom = ;
		[ENDTEXT] + CRLF + ;
		[RETURN lcFCCode]

	lcFC_String = lcFC_Top + gcFC_CODE + CRLF + lcFC_Bottom

 lcFC_Insert = [INSERT INTO FC (TYPE,Abbrev,Cmd,DATA,TimeStamp,Source, Save, Uniqueid) VALUES ('U',']+ ;
  gcFC_Abrev + [','{}',lcFC_String,DATETIME(),"TH IntelliSense AddIn",.T., SYS(2015))]
ELSE
 lcFC_Insert = [INSERT INTO FC (TYPE,Abbrev,Expanded,TimeStamp,Source, Save, Uniqueid) VALUES ('U','] + ;
  gcFC_Abrev + [',gcFC_Expanded,DATETIME(),"TH IntelliSense AddIn",.T., SYS(2015))]
ENDIF

*!* Insert the CMD or Abbrev/Expanded combo into FoxCode.
*!* Close it, then clean up.
&lcFC_Insert
USE IN FC
RELEASE loFC_DS
RELEASE gcFC_Abrev, gcFC_Expanded, gcFC_CODE, gcFC_LocationBlock, gbCancel


PROCEDURE READ_REG_SZ
	LPARAMETERS nKey, cSubKey, cValue

* This function reads a REG_SZ value from the registry. If successful,
* it will return the value read. If not successful, it will return an empty string.
* nKey The root key to open. It can be any of the constants defined below.
*  #DEFINE HKEY_CLASSES_ROOT           -2147483648
*  #DEFINE HKEY_CURRENT_USER           -2147483647
*  #DEFINE HKEY_LOCAL_MACHINE          -2147483646
*  #DEFINE HKEY_USERS                  -2147483645
* cSubKey The SubKey to open.
* cValue The value that is going to be read.

* Constants that are needed for Registry functions
* WIN 32 API functions that are used
	DECLARE INTEGER RegOpenKey IN Win32API ;
		INTEGER nHKey, STRING @cSubKey, INTEGER @nResult
	DECLARE INTEGER RegQueryValueEx IN Win32API ;
		INTEGER nHKey, STRING lpszValueName, INTEGER dwReserved,;
		INTEGER @lpdwType, STRING @lpbData, INTEGER @lpcbData
	DECLARE INTEGER RegCloseKey IN Win32API INTEGER nHKey

* Local variables used
	LOCAL nErrCode      && Error Code returned from Registry functions
	LOCAL nKeyHandle    && Handle to Key that is opened in the Registry
	LOCAL lpdwValueType && Type of Value that we are looking for
	LOCAL lpbValue      && The data stored in the value
	LOCAL lpcbValueSize && Size of the variable
	LOCAL lpdwReserved  && Reserved Must be 0

* Initialize the variables
	nKeyHandle = 0
	lpdwReserved = 0
	lpdwValueType = REG_SZ
	lpbValue = ""

	nErrCode = RegOpenKey(nKey, cSubKey, @nKeyHandle)
* If the error code isn't 0, then the key doesn't exist or can't be opened.
	IF (nErrCode # 0) THEN
		RETURN ""
	ENDIF

	lpcbValueSize = 1
* Get the size of the data in the value
	nErrCode=RegQueryValueEx(nKeyHandle, cValue, lpdwReserved, @lpdwValueType, @lpbValue, @lpcbValueSize)

* Make the buffer big enough
	lpbValue = SPACE(lpcbValueSize)
	nErrCode=RegQueryValueEx(nKeyHandle, cValue, lpdwReserved, @lpdwValueType, @lpbValue, @lpcbValueSize)

	=RegCloseKey(nKeyHandle)
	IF (nErrCode # 0) THEN
		RETURN ""
	ENDIF

	lpbValue = LEFT(lpbValue, lpcbValueSize - 1)
	RETURN lpbValue
ENDPROC

PROCEDURE WRITE_REG_SZ
	LPARAMETERS  nKey, cSubKey, cValue, cValueToWrite
* This function writes a REG_SZ value to the registry. If successful,
* its will return .T.. If not successful, it will return .F..

* nKey The root key to open. It can be any of the constants defined below
*#DEFINE HKEY_CLASSES_ROOT           -2147483648
*#DEFINE HKEY_CURRENT_USER           -2147483647
*#DEFINE HKEY_LOCAL_MACHINE          -2147483646
*#DEFINE HKEY_USERS                  -2147483645
* cSubKey The SubKey to open.
* cValueToWrite The value being written to the registry.

* Constants that are needed for Registry functions


* WIN 32 API functions that are used
	DECLARE INTEGER RegOpenKey IN Win32API ;
		INTEGER nHKey, STRING @cSubKey, INTEGER @nResult
	DECLARE INTEGER RegSetValueEx IN Win32API ;
		INTEGER hKey, STRING lpszValueName, INTEGER dwReserved,;
		INTEGER fdwType, STRING lpbData, INTEGER cbData
	DECLARE INTEGER RegCloseKey IN Win32API INTEGER nHKey

* Local variables used
	LOCAL nErrCode      && Error Code returned from Registry functions
	LOCAL nKeyHandle    && Handle to Key that is opened in the Registry
	LOCAL lpdwValueType && Type of Value that we are looking for
	LOCAL lpbValue      && The data stored in the value
	LOCAL lpcbValueSize && Size of the variable
	LOCAL lpdwReserved  && Reserved Must be 0

* Initialize the variables
	nKeyHandle = 0
	lpdwReserved = 0
	lpdwValueType = REG_SZ
	lpbValue = cValueToWrite

	nErrCode = RegOpenKey(nKey, cSubKey, @nKeyHandle)
* If the error code isn't 0, then the key doesn't exist or can't be opened.
	IF (nErrCode # 0) THEN
		RETURN .F.
	ENDIF

	lpcbValueSize = LEN(lpbValue)   && Store the length of the string
	nErrCode=RegSetValueEx(nKeyHandle, cValue, lpdwReserved, lpdwValueType, lpbValue, lpcbValueSize)

	=RegCloseKey(nKeyHandle)
	IF (nErrCode # 0) THEN
		RETURN .F.
	ENDIF
	RETURN .T.
ENDPROC




PROCEDURE AssignOnKey
	LPARAMETERS ThisProgramName as String
	LOCAL lcModifer AS STRING, lcOnKey AS STRING, lcOnKeyCmd AS STRING
	lcModifer = READ_REG_SZ(HKEY_CURRENT_USER, REG_VFP7, REG_MODIFER)
	lcOnKey = READ_REG_SZ(HKEY_CURRENT_USER, REG_VFP7, REG_ONKEY)
	IF !EMPTY(lcModifer)
		lcOnKeyCmd = [ON KEY LABEL ] + ALLTRIM(lcModifer) + ;
			[+] + ALLTRIM(lcOnKey) + [ do "] + ThisProgramName + ["]
		&lcOnKeyCmd
	ENDIF
ENDPROC


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DEFINE CLASS fcform AS FORM


	HEIGHT = 434
	WIDTH = 485
	DOCREATE = .T.
	SHOWTIPS = .T.
	AUTOCENTER = .T.
	BORDERSTYLE = 2
	CAPTION = "Add IntelliSense Code"
	MAXBUTTON = .F.
	MINBUTTON = .F.
	ALWAYSONTOP = .T.
	NAME = "fcform"
	callingprgpath = .F.
	DIMENSION akeyarray[48]
	DIMENSION afkeyarray[12]


	ADD OBJECT shape3 AS SHAPE WITH ;
		TOP = 386, ;
		LEFT = 6, ;
		HEIGHT = 46, ;
		WIDTH = 302, ;
		SPECIALEFFECT = 0, ;
		NAME = "Shape3"


	ADD OBJECT shape1 AS SHAPE WITH ;
		TOP = 46, ;
		LEFT = 2, ;
		HEIGHT = 295, ;
		WIDTH = 481, ;
		SPECIALEFFECT = 0, ;
		NAME = "Shape1"


	ADD OBJECT shape2 AS SHAPE WITH ;
		TOP = 61, ;
		LEFT = 344, ;
		HEIGHT = 99, ;
		WIDTH = 132, ;
		SPECIALEFFECT = 0, ;
		NAME = "Shape2"


	ADD OBJECT edtcode AS EDITBOX WITH ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		HEIGHT = 168, ;
		LEFT = 10, ;
		SPECIALEFFECT = 0, ;
		TABINDEX = 3, ;
		TOP = 166, ;
		WIDTH = 466, ;
		NAME = "edtCODE"


	ADD OBJECT label2 AS LABEL WITH ;
		AUTOSIZE = .T., ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		CAPTION = "Code:", ;
		HEIGHT = 15, ;
		LEFT = 10, ;
		TOP = 147, ;
		WIDTH = 31, ;
		TABINDEX = 13, ;
		NAME = "Label2"


	ADD OBJECT label4 AS LABEL WITH ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		WORDWRAP = .T., ;
		CAPTION = ['Customize the code/command to be added to the Intellisense table (for instance, surround text to be highlighted with the ~ character). When ready, click the "Add to IntelliSense" button.'], ;
		HEIGHT = 30, ;
		LEFT = 6, ;
		TOP = 8, ;
		WIDTH = 472, ;
		TABINDEX = 15, ;
		NAME = "Label4"


	ADD OBJECT cmdinsert AS COMMANDBUTTON WITH ;
		TOP = 346, ;
		LEFT = 281, ;
		HEIGHT = 23, ;
		WIDTH = 126, ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		CAPTION = "\<Add to IntelliSense", ;
		DEFAULT = .T., ;
		ENABLED = .F., ;
		TABINDEX = 9, ;
		NAME = "cmdINSERT"


	ADD OBJECT cmdcancel AS COMMANDBUTTON WITH ;
		TOP = 346, ;
		LEFT = 410, ;
		HEIGHT = 23, ;
		WIDTH = 72, ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		CANCEL = .T., ;
		CAPTION = "\<Cancel", ;
		TABINDEX = 10, ;
		NAME = "cmdCANCEL"


	ADD OBJECT txtabbrev AS TEXTBOX WITH ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		HEIGHT = 23, ;
		LEFT = 100, ;
		MAXLENGTH = 24, ;
		SPECIALEFFECT = 0, ;
		TABINDEX = 1, ;
		TOP = 77, ;
		WIDTH = 180, ;
		NAME = "txtABBREV"


	ADD OBJECT txtexpanded AS TEXTBOX WITH ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		HEIGHT = 23, ;
		LEFT = 100, ;
		MAXLENGTH = 26, ;
		SPECIALEFFECT = 0, ;
		TABINDEX = 2, ;
		TOP = 113, ;
		WIDTH = 220, ;
		NAME = "txtEXPANDED"


	ADD OBJECT label1 AS LABEL WITH ;
		AUTOSIZE = .T., ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		CAPTION = "Abbreviation:", ;
		HEIGHT = 15, ;
		LEFT = 32, ;
		TOP = 80, ;
		WIDTH = 67, ;
		TABINDEX = 11, ;
		NAME = "Label1"


	ADD OBJECT label3 AS LABEL WITH ;
		AUTOSIZE = .T., ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		CAPTION = "Expanded:", ;
		HEIGHT = 15, ;
		LEFT = 32, ;
		TOP = 116, ;
		WIDTH = 54, ;
		TABINDEX = 14, ;
		NAME = "Label3"


	ADD OBJECT chkcmdwin AS chkbase WITH ;
		TAG = "0", ;
		TOP = 72, ;
		LEFT = 357, ;
		HEIGHT = 15, ;
		WIDTH = 106, ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		AUTOSIZE = .T., ;
		CAPTION = "Command Window", ;
		VALUE = .F., ;
		TABINDEX = 4, ;
		NAME = "chkCmdWin"


	ADD OBJECT chkcodesnip AS chkbase WITH ;
		TAG = "10", ;
		TOP = 122, ;
		LEFT = 357, ;
		HEIGHT = 15, ;
		WIDTH = 82, ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		AUTOSIZE = .T., ;
		CAPTION = "Code Snippet", ;
		VALUE = .F., ;
		TABINDEX = 7, ;
		NAME = "chkCodeSnip"


	ADD OBJECT chkprogram AS chkbase WITH ;
		TAG = "1", ;
		TOP = 89, ;
		LEFT = 357, ;
		HEIGHT = 15, ;
		WIDTH = 58, ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		AUTOSIZE = .T., ;
		CAPTION = "Program", ;
		VALUE = .F., ;
		TABINDEX = 5, ;
		NAME = "chkProgram"


	ADD OBJECT chkmenusnip AS chkbase WITH ;
		TAG = "8", ;
		TOP = 106, ;
		LEFT = 357, ;
		HEIGHT = 15, ;
		WIDTH = 82, ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		AUTOSIZE = .T., ;
		CAPTION = "Menu snippet", ;
		VALUE = .F., ;
		TABINDEX = 6, ;
		NAME = "chkMenuSnip"


	ADD OBJECT chkstoredproc AS chkbase WITH ;
		TAG = "12", ;
		TOP = 139, ;
		LEFT = 357, ;
		HEIGHT = 15, ;
		WIDTH = 102, ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		AUTOSIZE = .T., ;
		CAPTION = "Stored Procedure", ;
		VALUE = .F., ;
		TABINDEX = 8, ;
		NAME = "chkStoredProc"


	ADD OBJECT label5 AS LABEL WITH ;
		AUTOSIZE = .F., ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		ALIGNMENT = 2, ;
		CAPTION = "Code can be used in:", ;
		HEIGHT = 15, ;
		LEFT = 354, ;
		TOP = 55, ;
		WIDTH = 112, ;
		TABINDEX = 12, ;
		NAME = "Label5"


	ADD OBJECT chkonkey AS chkbase WITH ;
		TOP = 379, ;
		LEFT = 18, ;
		HEIGHT = 15, ;
		WIDTH = 153, ;
		AUTOSIZE = .F., ;
		ALIGNMENT = 0, ;
		CAPTION = "Activate with ON KEY LABEL", ;
		VALUE = .F., ;
		TOOLTIPTEXT = "Check this box and select a key stroke to activate this form.", ;
		NAME = "chkONKEY"


	ADD OBJECT cbomodifer AS COMBOBOX WITH ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		COLUMNCOUNT = 0, ;
		COLUMNWIDTHS = "", ;
		ROWSOURCETYPE = 1, ;
		ROWSOURCE = "CTRL,SHIFT,ALT,SHIFT+CTRL,SHIFT+ALT,CTRL+ALT,CTRL+SHIFT+ALT,(none)", ;
		ENABLED = .F., ;
		FIRSTELEMENT = 1, ;
		HEIGHT = 24, ;
		LEFT = 71, ;
		NUMBEROFELEMENTS = 0, ;
		STYLE = 2, ;
		TOP = 398, ;
		WIDTH = 115, ;
		NAME = "cboModifer"


	ADD OBJECT command1 AS COMMANDBUTTON WITH ;
		TAG = "UP", ;
		TOP = 346, ;
		LEFT = 4, ;
		HEIGHT = 23, ;
		WIDTH = 72, ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		CAPTION = "\<Options  »", ;
		TABINDEX = 10, ;
		NAME = "Command1"


	ADD OBJECT label6 AS LABEL WITH ;
		AUTOSIZE = .T., ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		CAPTION = "Key:", ;
		HEIGHT = 15, ;
		LEFT = 200, ;
		TOP = 403, ;
		WIDTH = 24, ;
		TABINDEX = 11, ;
		NAME = "Label6"


	ADD OBJECT label7 AS LABEL WITH ;
		AUTOSIZE = .T., ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		CAPTION = "Modifer:", ;
		HEIGHT = 15, ;
		LEFT = 21, ;
		TOP = 403, ;
		WIDTH = 42, ;
		TABINDEX = 11, ;
		NAME = "Label7"


	ADD OBJECT cbokeylabel AS COMBOBOX WITH ;
		FONTNAME = "Tahoma", ;
		FONTSIZE = 8, ;
		COLUMNCOUNT = 0, ;
		COLUMNWIDTHS = "", ;
		ROWSOURCETYPE = 5, ;
		ROWSOURCE = "thisform.aKeyArray", ;
		ENABLED = .F., ;
		FIRSTELEMENT = 1, ;
		HEIGHT = 24, ;
		LEFT = 226, ;
		NUMBEROFELEMENTS = 0, ;
		STYLE = 2, ;
		TOP = 398, ;
		WIDTH = 66, ;
		NAME = "cboKEYLABEL"


*-- Called from the CLICK and INTERACTIVECHANGE of the checkboxes to enable/diable the cmdINSERT button.
	PROCEDURE chklocation_check
		IF THIS.chkcmdwin.VALUE OR THIS.chkcodesnip.VALUE OR ;
				THIS.chkmenusnip.VALUE OR THIS.chkprogram.VALUE OR ;
				THIS.chkstoredproc.VALUE
			THIS.cmdinsert.ENABLED= .T.
		ELSE
			THIS.cmdinsert.ENABLED= .F.
		ENDIF
	ENDPROC


	PROCEDURE DESTROY
		IF THIS.chkonkey.VALUE
			LOCAL lcOnKeyCmd AS STRING
			WRITE_REG_SZ(HKEY_CURRENT_USER, REG_VFP7, REG_MODIFER, ALLTRIM(THIS.cbomodifer.DISPLAYVALUE))
			WRITE_REG_SZ(HKEY_CURRENT_USER, REG_VFP7, REG_ONKEY, ALLTRIM(THIS.cbokeylabel.DISPLAYVALUE))
			lcOnKeyCmd = [ON KEY LABEL ] + ALLTRIM(THIS.cbomodifer.DISPLAYVALUE) + ;
				[+] + ALLTRIM(THIS.cbokeylabel.DISPLAYVALUE) + [ do "] + THIS.callingprgpath + ["]
			&lcOnKeyCmd
		ENDIF
	ENDPROC


	PROCEDURE INIT
		LPARAMETERS lcFC_Code, lcCallingPRGPath
		THIS.callingprgpath = lcCallingPRGPath

		LOCAL loFormObj AS OBJECT, lcModifer as String, ;
			lcOnKey as String

		IF CHR(13) $ lcFC_Code OR LEN(lcFC_Code) > 26
			THIS.edtcode.VALUE=lcFC_Code
			THIS.txtexpanded.ENABLED= .F.
		ELSE
			THIS.edtcode.ENABLED= .F.
			THIS.txtexpanded.VALUE=lcFC_Code
			FOR EACH loFormObj IN THIS.CONTROLS
				IF UPPER(loFormObj.BASECLASS) = [CHECKBOX] AND !EMPTY(loFormObj.TAG)
					loFormObj.VALUE = .T.
					loFormObj.ENABLED = .F.
				ENDIF
			ENDFOR
		ENDIF

		lcModifer = READ_REG_SZ(HKEY_CURRENT_USER, REG_VFP7, REG_MODIFER)
		lcOnKey = READ_REG_SZ(HKEY_CURRENT_USER, REG_VFP7, REG_ONKEY)
		THIS.HEIGHT = 375

		IF EMPTY(lcModifer)
			THIS.chkonkey.VALUE=.F.
			THIS.cbomodifer.ENABLED = .F.
			THIS.cbokeylabel.ENABLED=.F.
		ELSE
			THIS.chkonkey.VALUE=.T.
			THIS.cbomodifer.ENABLED = .T.
			THIS.cbokeylabel.ENABLED=.T.
			THIS.cbomodifer.VALUE = ALLTRIM(lcModifer)
			THIS.cbokeylabel.VALUE = ALLTRIM(lcOnKey)
		ENDIF

		FOR i = 65 TO 90
			STORE CHR(i) TO THIS.akeyarray(i-64)
		ENDFOR

		FOR i = 48 TO 57
			STORE CHR(i) TO THIS.akeyarray(i-21)
		ENDFOR

		FOR i = 1 TO 12
			STORE [F] + TRANSFORM(i) TO THIS.akeyarray(i+36)
			STORE [F] + TRANSFORM(i) TO THIS.afkeyarray(i)
		ENDFOR
	ENDPROC


	PROCEDURE edtcode.INTERACTIVECHANGE
		THISFORM.cmdinsert.ENABLED = !EMPTY(THIS.VALUE)
	ENDPROC


	PROCEDURE cmdinsert.CLICK
		LOCAL loFormObj AS OBJECT, lcFC_LocationBlock AS STRING

		SELECT FC
		GO TOP
		LOCATE FOR UPPER(ALLTRIM(FC.ABBREV)) = UPPER(ALLTRIM(THISFORM.txtabbrev.VALUE))
		IF !EOF() AND !DELETED()
			MESSAGEBOX("That abbreviation already exists in the FoxCode table.",0+64,"Whoops!")
			THISFORM.txtabbrev.SETFOCUS()
			RETURN .F.
		ENDIF


		lcFC_LocationBlock = []
		FOR EACH loFormObj IN THISFORM.CONTROLS
			IF UPPER(loFormObj.BASECLASS) = [CHECKBOX] AND !EMPTY(loFormObj.TAG)
				IF loFormObj.VALUE = .T.
					lcFC_LocationBlock = lcFC_LocationBlock + ;
						IIF(EMPTY(lcFC_LocationBlock),[],[,]) + loFormObj.TAG
				ENDIF
			ENDIF
		ENDFOR

		gcFC_LocationBlock = IIF(LEN(lcFC_LocationBlock) = 11, ;
			[],lcFC_LocationBlock)

		gbCancel = .F.
		gcFC_Abrev = ALLTRIM(THISFORM.txtabbrev.VALUE)
		gcFC_Expanded = ALLTRIM(THISFORM.txtexpanded.VALUE)
		gcFC_CODE = ALLTRIM(THISFORM.edtcode.VALUE)

		THISFORM.RELEASE
	ENDPROC


	PROCEDURE cmdcancel.CLICK
		gbCancel = .T.
		THISFORM.RELEASE
	ENDPROC


	PROCEDURE txtabbrev.INTERACTIVECHANGE
		THISFORM.cmdinsert.ENABLED = !EMPTY(THIS.VALUE)
	ENDPROC


	PROCEDURE txtexpanded.INTERACTIVECHANGE
		THISFORM.cmdinsert.ENABLED = !EMPTY(THIS.VALUE)
	ENDPROC


	PROCEDURE chkonkey.INTERACTIVECHANGE
		NODEFAULT
		THISFORM.cbomodifer.ENABLED=THIS.VALUE
		THISFORM.cbokeylabel.ENABLED=THIS.VALUE
	ENDPROC


	PROCEDURE chkonkey.CLICK
		NODEFAULT
		THISFORM.cbomodifer.ENABLED=THIS.VALUE
		THISFORM.cbokeylabel.ENABLED=THIS.VALUE
	ENDPROC


	PROCEDURE cbomodifer.INTERACTIVECHANGE
		IF THIS.VALUE == [SHIFT] OR THIS.VALUE == [(none)]
			THISFORM.cbokeylabel.ROWSOURCE=[THISFORM.afkeyarray]
		ELSE
			THISFORM.cbokeylabel.ROWSOURCE=[THISFORM.akeyarray]
		ENDIF
		THISFORM.cbokeylabel.REQUERY()
	ENDPROC


	PROCEDURE cbomodifer.INIT
		THIS.VALUE=THIS.LIST(1)
	ENDPROC


	PROCEDURE command1.CLICK
		IF THIS.CAPTION = [\<Options  »]
			THIS.CAPTION = [\<Options  «]
			THISFORM.HEIGHT = 434
		ELSE
			THIS.CAPTION = [\<Options  »]
			THISFORM.HEIGHT = 375
		ENDIF
	ENDPROC


	PROCEDURE cbokeylabel.INIT
		THIS.VALUE=THIS.LIST(1)
	ENDPROC
ENDDEFINE

*~~~~~~~~~~~~~~~~~~~~~~~~~~
DEFINE CLASS chkbase AS CHECKBOX
	HEIGHT = 15
	WIDTH = 53
	FONTNAME = "Tahoma"
	FONTSIZE = 8
	AUTOSIZE = .T.
	CAPTION = "Check1"
	NAME = "chkbase"


	PROCEDURE INTERACTIVECHANGE
		THISFORM.chklocation_check()
	ENDPROC


	PROCEDURE CLICK
		THISFORM.chklocation_check()
	ENDPROC
ENDDEFINE
