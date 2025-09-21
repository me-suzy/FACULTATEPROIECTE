*!*	This examples shows how a custom object can be created and
*!*	inserted by the ReportListener.
*!*	All custom objects are represented by rects. These ones are
*!*	defined by having 'PIE' in the user field.
*!*	You can use md_simpleCust.frx which has the custom object
*!*	inserted already

CLEAR
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir) 

ox = CREATEOBJECT("RLCustom")
ox.ListenerType = 1

*Choose a report that has a rect with 'PIE' in the user data field
REPORT FORM md_simpleCust OBJECT ox NOWAIT


DEFINE CLASS RLCustom AS ReportListener
	* Returns true if this object should be drawn as a Pie Chart
	PROCEDURE IsPie(nFRXRecno)
		ThisIsPie = .F.
		nOldSession = SET("DataSession")
		SET DATASESSION TO THIS.FRXDataSession
		GO nFRXRecno IN "FRX"

		IF (objtype == 7 AND USER == "PIE")
			ThisIsPie = .T.
		ENDIF

		SET DATASESSION TO nOldSession
		RETURN ThisIsPie
	ENDPROC


	*Makes the pie chart have the same width as its height
	*Note that this means the height of the object can be dynamic during report run
	PROCEDURE AdjustObjectSize(nFRXRecno, oObjProperties)
		IF (THIS.IsPie(nFRXRecno))
			oObjProperties.HEIGHT = oObjProperties.WIDTH
			oObjProperties.Reload = .T.
		ENDIF
	ENDPROC


	*Draws the pie
	PROCEDURE Render(nFRXRecno, nLeft, nTop, nWidth, nHeight, aa,bb,cc)
		LOCAL og AS "GGraphics"

		IF (THIS.IsPie(nFRXRecno))
			og = NEWOBJECT("GGraphics", "FoxGDIPlus.prg")
			og.SetGraphicsHandle(THIS.GDIPlusGraphics)


			#DEFINE SLICES 5
			DIMENSION pt(SLICES+1)
			DIMENSION COLORS(5)
			pt[1] = 0
			pt[SLICES+1] = 360
			FOR i = 2 TO SLICES
				pt[i] = (72 * i) + INT(72*RAND())
			ENDFOR

			oBrush = NEWOBJECT("GBrush", "FoxGDIPlus.prg")
			OPEN = NEWOBJECT("GPen", "FoxGDIPlus.prg")
			OPEN.CREATE(0x7F000000,1) &&Black

			COLORS[1] = (0xFFFF0000)	&&Blue
			COLORS[2] = (0xFF00FF00)	&&Green
			COLORS[3] = (0xFF0000FF)	&&Red
			COLORS[4] = (0xFFFF00FF)	&&Magenta
			COLORS[5] = (0xFFFFFF00)	&&Yellow

			FOR i = 1 TO SLICES
				oBrush.CreateSolid(COLORS[i])
				og.FillPie(oBrush, nLeft, nTop, nWidth, nHeight, pt[i], pt[i+1] - pt[i])
				og.DrawPie(OPEN, nLeft, nTop, nWidth, nHeight, pt[i], pt[i+1] - pt[i])
			ENDFOR

			NODEFAULT
		ENDIF

	ENDPROC
ENDDEFINE
