LPARAMETERS tlQuietMode, tlDeletedOFF, tlIncludeXMLListenerFeedback, tlIncludeXMLListenerRDLOutput
#DEFINE XMLLISTENER_TYPE 4
#DEFINE PRVLISTENER_TYPE 1

LOCAL cDir, aDummy[1], cDeleted, cPath, oListener
cPath = CURDIR()
cDeleted = SET("DELETED")

CD (JUSTPATH(SYS(16)))

oListener = NEWOBJECT("UpdateListener","Listener",_REPORTOUTPUT)
oListener.ListenerType = PRVLISTENER_TYPE

PUBLIC oHost
oHost = CREATEOBJECT("tf")
oHost.SHOW()
REPORT FORM (GETFILE("FRX")) OBJECT oListener NOWAIT
CD (cPath)

SET DELETED &cDeleted
oListener = NULL


DEFINE CLASS tf AS FORM
	CAPTION = "My Custom Application"
	AUTOCENTER = .T.
	SHOWWINDOW = 2
	BACKCOLOR = RGB(196,196,196)
	WIDTH = 800
	HEIGHT = 500

	PROCEDURE INIT
		_SCREEN.VISIBLE=.F.
	ENDPROC
ENDDEFINE
