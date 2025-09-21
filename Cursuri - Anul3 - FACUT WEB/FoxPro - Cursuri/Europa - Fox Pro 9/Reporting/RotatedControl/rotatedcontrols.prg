CLEAR
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir) 

ox = CREATEOBJECT("rotatetext")
ox.ListenerType = 1
REPORT FORM ? OBJECT ox RANGE 1,1

#DEFINE FRX_OBJCOD_PAGEHEADER 1



DEFINE CLASS rotatetext AS ReportListener

	IsInPageHeader = .F.

	PROCEDURE BeforeBand(nBandObjCode, nFRXRecNo)

		DODEFAULT(nBandObjCode, nFRXRecNo)

		IF (nBandObjCode = FRX_OBJCOD_PAGEHEADER)
			THIS.IsInPageHeader = .T.
		ENDIF

	ENDPROC

	PROCEDURE AfterBand(nBandObjCode, nFRXRecNo)
		IF (nBandObjCode = FRX_OBJCOD_PAGEHEADER)
			THIS.IsInPageHeader = .F.
		ENDIF
		DODEFAULT(nBandObjCode, nFRXRecNo)

	ENDPROC


	*Draws the pie
	PROCEDURE Render(nFRXRecNo, nLeft, nTop, nWidth, nHeight, nContType, cContents, IMAGE)
		LOCAL og AS "GGraphics"

		og = NEWOBJECT("GGraphics", "FoxGDIPlus.prg")
		og.SetGraphicsHandle(THIS.GDIPlusGraphics)


		IF THIS.IsInPageHeader


			* save the current state of the graphics handle
			og.SaveGraphics()

			* now move the 0,0 point to where we'd like it to be
			* so that when we rotate we're rotating around the
			* appropriate point
			og.TranslateTransform(nLeft, nTop)

			* now change the angle at which the draw will occur
			og.RotateTransform(-20)

			* restore the 0,0 point
			og.TranslateTransform(-nLeft, -nTop)
		ENDIF

		* explicitly call the base class behavior when we are ready for it

		DODEFAULT(nFRXRecNo, nLeft, nTop, nWidth, nHeight, nContType, cContents, IMAGE)

		* put back the state of the graphics handle
		IF THIS.IsInPageHeader
			og.RestoreGraphics()
		ENDIF

		* don't let the base class behavior draw
		* when and how it would otherwise do it
		NODEFAULT


	ENDPROC
ENDDEFINE
