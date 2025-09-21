* This listener demo creates multipage TIFFs from the report.
* Product creates compressed TIFF files for performance.
* Note: This process can take a long time, there will be significant optimizations

LOCAL ox AS ReportListener
ox = NEWOBJECT("MPTiffListener")
ox.Filename = "Multi"

WAIT WINDOW "Processing report to TIFF file...." NOWAIT
REPORT FORM ? OBJECT ox RANGE 1,4	&& limit demo to 4 pages
WAIT CLEAR

DECLARE INTEGER ShellExecute ;
	IN SHELL32.DLL ;
	INTEGER nWinHandle,;
	STRING cOperation,;
	STRING cFileName,;
	STRING cParameters,;
	STRING cDirectory,;
	INTEGER nShowWindow
ShellExecute(0,"Open","multi.tif","","",1)
CLEAR DLLS ShellExecute

DEFINE CLASS MPTiffListener AS ReportListener
	#DEFINE OutputNothing -1
	#DEFINE OutputTIFF 101
	#DEFINE OutputTIFFAdditive (OutputTIFF+100)

	PROCEDURE INIT
		THIS.ADDPROPERTY("Filename", "temp")
		THIS.ListenerType = 2
	ENDPROC


	PROCEDURE OutputPage(nPageNo, eDevice, nDeviceType)
		IF (nDeviceType == OutputNothing)
			IF (nPageNo == 1)
				nDeviceType = OutputTIFF
			ELSE
				nDeviceType = OutputTIFFAdditive
			ENDIF
			THIS.OutputPage(nPageNo, THIS.Filename, nDeviceType)
			NODEFAULT
		ENDIF
	ENDPROC

ENDDEFINE
