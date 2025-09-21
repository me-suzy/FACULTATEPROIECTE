#DEFINE EXPLICIT_IE "C:\Program Files\Internet Explorer\IEXPLORE.EXE"
#DEFINE XMLLISTENER_TYPE 4

LPARAMETERS tlQuietMode

IF EMPTY(_REPORTOUTPUT)
	MESSAGEBOX("need _REPORTOUTPUT for this demo")
	RETURN
ENDIF

SET REPORTBEHAVIOR 80 && JIC

LOCAL x, ox, cx
CD (JUSTPATH(SYS(16)))
ox = NULL

_SCREEN.WINDOWSTATE = 2
CLEAR

IF NOT tlQuietMode

	MESSAGEBOX("First, we'll show how reports USED to look, " + CHR(13) + ;
		"with no FontCharSet awareness." + CHR(13) + CHR(13) + ;
		"Point out the 4th and 7th letters of the first Czech word, along with the Russian.")

ENDIF

USE intl.FRX
REPLACE ALL DOUBLE WITH .F.
LOCATE FOR Objtype = 5
SKIP
IF Objtype = 5
	cx = EXPR
	REPLACE EXPR WITH "   First, without FontCharset..."
ENDIF
USE
REPORT FORM intl PREVIEW
USE intl.FRX
REPLACE ALL DOUBLE WITH .T. FOR objcode = 53 OR INLIST(Objtype,5,8)
IF NOT EMPTY(cx)
	LOCATE FOR Objtype = 5
	SKIP
	REPLACE EXPR WITH cx
ENDIF
USE

IF NOT tlQuietMode

	MESSAGEBOX("Europa's Report Designer lets you specify regional scripts for each object." + CHR(13) +CHR(13)+ ;
		"If using Report Builder: " + CHR(13) + ;
		"Check the Style tab for the two textboxes in this report, and " + CHR(13) + ;
		"notice the Font properties." + CHR(13) + CHR(13) + ;
		"If not using Report Builder: " +CHR(13) + ;
		"Use Format-> Font or "+CHR(13) + ;
		"the *NEW* Font button on the Report Design Toolbar." )

ENDIF


MODI REPO intl

IF NOT tlQuietMode

	MESSAGEBOX("Now we'll show how Europa uses this information... " + CHR(13) + CHR(13) + ;
		"Notice the 4th and 7th letters of the first Czech word, along with the Russian.")

ENDIF

REPORT FORM intl PREVIEW

IF (NOT tlQuietMode) AND (NOT EMPTY(_REPORTPREVIEW))

	MESSAGEBOX("Let's try that with new-style preview, shall we?" )

ENDIF

IF (NOT EMPTY(_REPORTPREVIEW))

	REPORT FORM intl PREVIEW OBJECT TYPE 1

ENDIF

DO (_REPORTOUTPUT) WITH XMLLISTENER_TYPE, ox
ox.xmlmode = 0
ox.targetfilename = "test.xml"
ox.QuietMode = tlQuietMode

IF NOT tlQuietMode
	MESSAGEBOX("A ReportListener can also see, and use, the script values.")
ENDIF

DEFINE WINDOW x FROM 1,1 TO 20,20
ACTI WINDOW x NOSHOW
REPORT FORM intl OBJECT ox
RELEASE WINDOW x

IF FILE(ox.targetfilename)
	#IF NOT EMPTY(EXPLICIT_IE)
		x = ox.targetfilename && will be fully pathed
		RUN /n1 EXPLICIT_IE &x.
	#ELSE
		DECLARE INTEGER ShellExecute ;
			IN SHELL32.DLL ;
			INTEGER nWinHandle,;
			STRING cOperation,;
			STRING cFileName,;
			STRING cParameters,;
			STRING cDirectory,;
			INTEGER nShowWindow
		ShellExecute(0,"Open",ox.targetfilename,"","",1)
		CLEAR DLLS ShellExecute
	#ENDIF
ENDIF


