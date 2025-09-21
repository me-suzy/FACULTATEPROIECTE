#DEFINE DEBUGGING	.F.

CLEAR
LOCAL oListener AS ReportListener
oListener = NEWOBJECT("MyListener")
oListener.ListenerType=1	&& Preview
REPORT FORM (GETFILE("FRX")) OBJECT oListener PREVIEW



DEFINE CLASS myListener AS ReportListener

	PROCEDURE AfterReport()
		ACTIVATE SCREEN
		? PROGRAM()
		? "***Report is done.***"
	ENDPROC

	PROCEDURE BeforeReport
		ACTIVATE SCREEN
		? "***Report is starting.***"
		WAIT WINDOW "Let's see REPORT FORM cmd object now."
		lnCount=AMEMBERS(laCmds,THIS.CommandClauses)
		FOR i = 1 TO lnCount
			? laCmds[m.i], THIS.CommandClauses.&laCmds[m.i]
		ENDFOR
		?
		WAIT WINDOW
	ENDPROC

	PROCEDURE BeforeBand(nBandObjCode,nFRXRecno)
		** Check on Page Footer **
		IF nBandObjCode=7
			? "Before Page "+TRANSFORM(THIS.PageNo)+" is about to print."
		ENDIF
	ENDPROC

	PROCEDURE AfterBand(nBandObjCode,nFRXRecno)
		** Page Footer **
		IF DEBUGGING AND nBandObjCode=7 AND THIS.PageNo=10
			? "Suspending..."
			SUSPEND
			? "Resuming..."
		ENDIF
	ENDPROC

ENDDEFINE
