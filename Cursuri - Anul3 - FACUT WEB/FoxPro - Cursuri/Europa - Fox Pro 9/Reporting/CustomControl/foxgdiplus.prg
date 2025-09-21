? [PROC file. Nothing to run]

DEFINE CLASS GDIPlusBase AS CUSTOM
	nHandle = 0
ENDDEFINE


DEFINE CLASS GPen AS GDIPlusBase
	PROCEDURE INIT()
		DECLARE INTEGER GdipCreatePen1 IN GDIPlus.DLL ;
			INTEGER nColor, SINGLE dWidth,INTEGER nUnit, INTEGER @nPen

		DECLARE INTEGER GdipDeletePen IN GDIPlus.DLL ;
			INTEGER nPen

		DODEFAULT()
	ENDPROC

	PROCEDURE CREATE(nColor, dWidth)
		THIS.DESTROY()
		nHandle = 0
		GdipCreatePen1(nColor, (dWidth), 0, @nHandle)
		THIS.nHandle = nHandle
	ENDPROC

	PROCEDURE DESTROY()
		IF (THIS.nHandle != 0)
			GdipDeletePen(THIS.nHandle)
			THIS.nHandle = 0
		ENDIF
	ENDPROC
ENDDEFINE

DEFINE CLASS GBrush AS GDIPlusBase
	PROCEDURE INIT()
		DECLARE INTEGER GdipCreateSolidFill IN GDIPlus.DLL ;
			INTEGER nColor, INTEGER @nBrush

		DECLARE INTEGER GdipDeleteBrush IN GDIPlus.DLL ;
			INTEGER nBrush

		DODEFAULT()
	ENDPROC

	PROCEDURE CreateSolid(nColor)
		THIS.DESTROY()
		nHandle = 0
		GdipCreateSolidFill(nColor, @nHandle)
		THIS.nHandle = nHandle
	ENDPROC

	PROCEDURE DESTROY()
		IF (THIS.nHandle != 0)
			GdipDeleteBrush(THIS.nHandle)
			THIS.nHandle = 0
		ENDIF
	ENDPROC
ENDDEFINE

DEFINE CLASS GGraphics AS GDIPlusBase
	nSaveState = 0
	PROCEDURE INIT()
		DECLARE INTEGER GdipRotateWorldTransform IN GDIPlus.DLL ;
			INTEGER graphics,SINGLE angle,INTEGER enumMatrixOrder_order
		DECLARE INTEGER GdipSaveGraphics IN GDIPlus.DLL ;
			INTEGER graphics, INTEGER @xx
		DECLARE INTEGER GdipRestoreGraphics IN GDIPlus.DLL ;
			INTEGER graphics, INTEGER xx
		DECLARE INTEGER GdipTranslateWorldTransform IN GDIPlus.DLL ;
			INTEGER graphics,SINGLE dx,SINGLE dy,INTEGER enumMatrixOrder_order

		DECLARE INTEGER GdipDrawPieI IN GDIPlus.DLL ;
			INTEGER graphics, INTEGER PEN,INTEGER x,INTEGER Y, INTEGER w, INTEGER h, SINGLE dStart, SINGLE dAngle

		DECLARE INTEGER GdipFillPieI IN GDIPlus.DLL ;
			INTEGER graphics, INTEGER brush,INTEGER x,INTEGER Y, INTEGER w, INTEGER h, SINGLE dStart, SINGLE dAngle

		DODEFAULT()

	ENDPROC

	PROCEDURE SetGraphicsHandle(GDIPlusGraphics)
		THIS.nHandle = GDIPlusGraphics
	ENDPROC

	PROCEDURE SaveGraphics()
		* save the current state of the graphics handle
		nSave = 0
		GdipSaveGraphics(THIS.nHandle, @nSave)
		THIS.nSaveState = nSave
	ENDPROC

	PROCEDURE RestoreGraphics()
		* put back the state of the graphics handle
		IF (THIS.nSaveState != 0)
			GdipRestoreGraphics(THIS.nHandle, THIS.nSaveState)
			THIS.nSaveState = 0
		ENDIF
	ENDPROC


	PROCEDURE TranslateTransform(dx, dy)
		* now move the 0,0 point to where we'd like it to be
		* so that when we rotate we're rotating around the
		* appropriate point
		GdipTranslateWorldTransform(THIS.nHandle, (dx), (dy),0)
	ENDPROC


	PROCEDURE RotateTransform(dAngle)
		* now change the angle at which the draw will occur
		GdipRotateWorldTransform(THIS.nHandle, (dAngle), 0)
	ENDPROC

	PROCEDURE DrawPie(OPEN, x, Y, w, h, dStart, dAngle)
		GdipDrawPieI(THIS.nHandle, OPEN.nHandle, x, Y, w, h, (dStart), (dAngle))
	ENDPROC

	PROCEDURE FillPie(oBrush, x, Y, w, h, dStart, dAngle)
		GdipFillPieI(THIS.nHandle, oBrush.nHandle, x, Y, w, h, (dStart), (dAngle))
	ENDPROC


	PROCEDURE DESTROY()
	ENDPROC
ENDDEFINE

