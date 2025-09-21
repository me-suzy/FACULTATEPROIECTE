#DEFINE DETAIL_BAND 4
#DEFINE BOLD_ITALIC 1+2
#DEFINE UNDERLINE_STRIKETHROUGH 4 + 128
ox = CREATEOBJECT("rl")
ox.listenertype = 1

REPORT FORM (GETFILE("frx")) PREVIEW OBJECT ox

DEFINE CLASS rl AS ReportListener

	DetailInstance = 0
	IsDetail = .F.

	PROC BeforeBand(nBandObjCode, nFRXRecno)
		IF nBandObjCode = DETAIL_BAND
			THIS.DetailInstance = THIS.DetailInstance + 1
			THIS.IsDetail = .T.
		ELSE
			THIS.IsDetail = .F.
		ENDIF
	ENDPROC


	PROC EvaluateContents(nFRXRecno, oProps)

		IF THIS.IsDetail
			DO CASE
				CASE THIS.DetailInstance % 3  = 0
					oProps.PenRed = 0
					oProps.PenGreen = 0
					oProps.PenBlue = 255
				CASE THIS.DetailInstance % 3  = 1
					oProps.PenRed = 0
					oProps.PenGreen = 255
					oProps.PenBlue = 0
				OTHERWISE
					oProps.PenRed = 255
					oProps.PenGreen = 0
					oProps.PenBlue = 0
			ENDCASE
			IF THIS.DetailInstance % 2 = 0
				oProps.FontStyle = BOLD_ITALIC
			ENDIF
		ELSE
			oProps.FontStyle = UNDERLINE_STRIKETHROUGH
		ENDIF
		oProps.Reload = .T.
	ENDPROC


ENDDEFINE
