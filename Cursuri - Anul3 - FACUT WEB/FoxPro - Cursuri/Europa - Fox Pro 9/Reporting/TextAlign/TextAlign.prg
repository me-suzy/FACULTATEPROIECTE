CLEAR
LOCAL oListener AS ReportListener
LOCAL cPath
cPath = CURDIR()
CD (JUSTPATH(SYS(16)))

OldRB = SET("ReportBehavior")

MESSAGEBOX("Preview using old GDI routines.")
SET REPORTBEHAVIOR 80
REPORT FORM "qr_60frx.frx" PREVIEW

MESSAGEBOX("Preview using new GDI+ routines.")
SET REPORTBEHAVIOR 90
oListener = NEWOBJECT("ReportListener")
oListener.ListenerType=1	&& Preview
oListener.DynamicLineHeight=.T.		&& controls line spacing - switch to see difference

REPORT FORM "qr_60frx.frx" OBJECT oListener PREVIEW
MODIFY REPORT "qr_60frx.frx" NOWAIT
CD (cPath)

SET REPORTBEHAVIOR OldRB
