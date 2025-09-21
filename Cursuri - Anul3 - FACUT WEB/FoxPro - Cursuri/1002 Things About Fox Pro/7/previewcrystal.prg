local loParameter, ;
      loPreviewForm, ;
      lnSeconds, ;
      lnTestCount

CLOSE ALL
CLEAR ALL
RELEASE ALL

loParameter = CREATEOBJECT("custom")

* In the VFP Frame
lnTestCount = 1

WITH loParameter
   .AddProperty("cCaption", "MegaFox Fox2x Sample (in VFP)")
   .AddProperty("cReportName", "RandExampleFox2x")
   .AddProperty("lStartLastPage", .F.)
   .AddProperty("lShowGroupTree", .F.)
ENDWITH

WAIT WINDOW "Press any key to start test " + TRANSFORM(lnTestCount)
lnSeconds     = SECONDS()
loPreviewForm = NEWOBJECT("frmCrystalPreview", "ch07.vcx", SPACE(0), ;
                          loParameter, lnSeconds)
loPreviewForm.Show(1)


* In the VFP Frame
lnTestCount = lnTestCount + 1

WITH loParameter
   .cCaption       = "MegaFox VFP OLEDB Sample (in VFP)"
   .cReportName    = "RandExampleVFPOLEDB"
   .lStartLastPage = .F.
   .lShowGroupTree = .F.
ENDWITH

WAIT WINDOW "Press any key to start test " + TRANSFORM(lnTestCount)
lnSeconds     = SECONDS()
loPreviewForm = NEWOBJECT("frmCrystalPreview", "ch07.vcx", SPACE(0), ;
                          loParameter, lnSeconds)
loPreviewForm.Show(1)


* In the VFP Frame
lnTestCount = lnTestCount + 1

WITH loParameter
   .cCaption       = "MegaFox VFP ODBC Sample (in VFP)"
   .cReportName    = "RandExampleVFPODBC"
   .lStartLastPage = .F.
   .lShowGroupTree = .F.
ENDWITH

WAIT WINDOW "Press any key to start test " + TRANSFORM(lnTestCount)
lnSeconds     = SECONDS()
loPreviewForm = NEWOBJECT("frmCrystalPreview", "ch07.vcx", SPACE(0), ;
                          loParameter, lnSeconds)
loPreviewForm.Show(1)


* In the VFP Frame
lnTestCount = lnTestCount + 1

WITH loParameter
   .cCaption       = "MegaFox XML Sample (in VFP)"
   .cReportName    = "RandExampleXML"
   .lStartLastPage = .F.
   .lShowGroupTree = .F.
ENDWITH

WAIT WINDOW "Press any key to start test " + TRANSFORM(lnTestCount)
lnSeconds     = SECONDS()
loPreviewForm = NEWOBJECT("frmCrystalPreview", "ch07.vcx", SPACE(0), ;
                          loParameter, lnSeconds)
loPreviewForm.Show(1)


* In the VFP Frame
lnTestCount = lnTestCount + 1

WITH loParameter
   .cCaption       = "MegaFox Drill Down Sample (in VFP)"
   .cReportName    = "DrillDown"
   .lStartLastPage = .F.
   .lShowGroupTree = .F.
ENDWITH

WAIT WINDOW "Press any key to start test " + TRANSFORM(lnTestCount)
lnSeconds     = SECONDS()
loPreviewForm = NEWOBJECT("frmCrystalPreview", "ch07.vcx", SPACE(0), ;
                          loParameter, lnSeconds)
loPreviewForm.Show(1)


* As a Top-Level Form
* Need global variables since Top-Level forms cannot be modal
lnTestCount = lnTestCount + 1

PUBLIC goParameter, ;
       goPreviewForm

goParameter = CREATEOBJECT("relation")

WITH goParameter
   .AddProperty("cCaption", "MegaFox VFP OLEDB Sample (Top-Level)")
   .AddProperty("cReportName", "RandExampleVFPOLEDB")
   .AddProperty("lStartLastPage", .T.)
   .AddProperty("lShowGroupTree", .F.)
ENDWITH

WAIT WINDOW "Press any key to start test " + TRANSFORM(lnTestCount)
lnSeconds     = SECONDS()
goPreviewForm = NEWOBJECT("frmCrystalPreviewTopLevel", "ch07.vcx", SPACE(0), ;
                          goParameter, lnSeconds)
goPreviewForm.Show()


RELEASE loPreviewForm
RELEASE loParameter

RETURN

*: EOF :*