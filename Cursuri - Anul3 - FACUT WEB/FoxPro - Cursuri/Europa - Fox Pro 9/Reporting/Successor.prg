LPARAMETERS tlQuietMode, tlDeletedOFF, tlIncludeXMLListenerFeedback, tlIncludeXMLListenerRDLOutput
#DEFINE XMLLISTENER_TYPE 4
#DEFINE PRVLISTENER_TYPE 1

IF NOT tlQuietMode
	MESSAGEBOX("This demo shows you two Listeners paired "+ CHR(13)+ ;
		" to do several different things on one report run:"  + CHR(13)+CHR(13)+ ;
		"(1) XMLListener turns off its simple WAIT WINDOW UI " + CHR(13)+ ;
		"and silently generates its XML output. " +CHR(13)+ CHR(13) + ;
		"(2) At the same time, UpdateListener "+ CHR(13)+;
		"responds to reporting events to provide " + CHR(13) + ;
		"a more sophisticated interface." + CHR(13)+ CHR(13) + ;
		"(3) UpdateListener also hosts a report preview."  + CHR(13) + CHR(13) + ;
		"We need to use a LONG report for this demo !" + CHR(13)+CHR(13) + ;
		"You will be able to cancel the report before it's finished if you like.")
ENDIF
LOCAL cDir, aDummy[1], cDeleted, cPath, oListener
cPath = CURDIR()
cDeleted = SET("DELETED")

CD (JUSTPATH(SYS(16)))

IF NOT (FILE(_REPORTOUTPUT) AND FILE(_REPORTPREVIEW))
	MESSAGEBOX("Need _REPORTOUTPUT and _REPORTPREVIEW for this demo!")
	CD (cPath)
	RETURN
ENDIF

IF tlDeletedOFF
	SET DELETED OFF
ELSE
	SET DELETED ON
ENDIF

DO (_REPORTOUTPUT) WITH XMLLISTENER_TYPE, 2
IF FILE(_oReportOutput[TRANSFORM(XMLLISTENER_TYPE)].TargetFileName)
	ERASE (_oReportOutput[TRANSFORM(XMLLISTENER_TYPE)].TargetFileName) NORECYCLE
ENDIF

oListener = NEWOBJECT("UpdateListener","Listener",_REPORTOUTPUT)
oListener.ListenerType = PRVLISTENER_TYPE
oListener.Successor = _oReportOutput[TRANSFORM(XMLLISTENER_TYPE)]

IF tlIncludeXMLListenerFeedback
	_oReportOutput[TRANSFORM(XMLLISTENER_TYPE)].QuietMode = .F.
ELSE
	_oReportOutput[TRANSFORM(XMLLISTENER_TYPE)].QuietMode = .T.
ENDIF

IF tlIncludeXMLListenerRDLOutput
	_oReportOutput[TRANSFORM(XMLLISTENER_TYPE)].XMLMode = 2
ELSE
	_oReportOutput[TRANSFORM(XMLLISTENER_TYPE)].XMLMode = 0
ENDIF

CD (cPath)
REPORT FORM (GETFILE("FRX")) OBJECT oListener

IF  ADIR(aDummy, _oReportOutput[TRANSFORM(XMLLISTENER_TYPE)].TargetFileName) > 0
	IF NOT tlQuietMode
		MESSAGEBOX("Your report XML file is " + CHR(13) + ;
			TRANSF(aDummy[1,2]) + " bytes." + CHR(13)+ ;
			"The printed output for this report "+ CHR(13) + ;
			"is " + TRANS(_PAGENO) + " pages long.")
	ENDIF
	MODI FILE (_oReportOutput[TRANSFORM(XMLLISTENER_TYPE)].TargetFileName) NOWAIT
ENDIF
