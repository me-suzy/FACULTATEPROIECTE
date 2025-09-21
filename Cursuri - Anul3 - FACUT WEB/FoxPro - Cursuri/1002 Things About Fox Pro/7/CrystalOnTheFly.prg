* Generate Crystal Report dynamically

LOCAL loCrystalReports  AS CrystalRuntime.Application, ;
      loReport , ;
      lcConnection, ;
      lcSql, ;
      lnColor, ;
      loReportObjects, ;
      loField, ;
      lcCrystalReportName, ;
      lcMessageCaption

lcConnection         = "Provider=vfpoledb.1;Data Source=.\MusicCollection.dbc"
lcSql                = "select * from recordingartists"
lcCrystalReportName  = "ReportOnTheFly.rpt"
lcMessageCaption     = "Crystal Report on the Fly!"

* Instantiate Crystal Runtime and add the report viewer to the form
loCrystalReports     = CREATEOBJECT("CrystalRuntime.Application")
loReport             = loCrystalReports.NewReport()
loReport.ReportTitle = "Crystal Report on the Fly"

* Add the OLEDB connection and specify table
loReport.Database.AddOLEDBSource(lcConnection, "recordingartists")

IF VARTYPE(loReport) = "O"
   WITH loReport
      
      WITH .Sections
         FOR i = 1 TO .Count
            ? .Item[i].Name

            IF MOD(5,i) = 2
               lnColor = RGB(0,255,0)
            ELSE
               lnColor = RGB(255,255,255)
            ENDIF

            .Item[i].BackColor = lnColor
            .Item[i].AddTextObject(.Item[i].Name, 0, 0)

            * Report Page Header
            IF LOWER(.Item[i].Name) = "section1"
               * Left and Top properties in Twips (~1441 per inch)
               .Item[i].AddSpecialVarFieldObject(10, 0, 200)    && crSVTReportTitle
               .Item[i].AddSpecialVarFieldObject(17, 5584,0)    && crSVTPageNofM
               
               loReportObjects = .Item[i].ReportObjects

               FOR j = 1 TO loReportObjects.Count
                  * Right align the Page N of M object
                  IF LOWER(loReportObjects.Item[j].Name) = "field2"
                     loReportObjects.Item[j].HorAlignment = 3   && crRightAlign
                  ENDIF
               ENDFOR
            ENDIF

            * Report Detail
            IF LOWER(.Item[i].Name) = "section5"
               loField = .Item[i].AddFieldObject("{recordingartists.recordingartistname}", 1441, 0)
               loField = .Item[i].AddFieldObject("{recordingartists.email}", 6000, 0)
            ENDIF
         ENDFOR
      ENDWITH
      
      .SaveAs(lcCrystalReportName, 2048)  && Saves file in v8 format
   ENDWITH
ELSE
   MESSAGEBOX("Crystal Reports could not generate a new report at this time.", ;
              0+16, lcMessageCaption)
ENDIF

* Crystal clean up
loReportObjects  = .NULL.
loField          = .NULL.
loCrystalReports = .NULL.

MESSAGEBOX("Crystal Report " + lcCrystalReportName + " was created.", ;
           0+64, lcMessageCaption)

RETURN

*: EOF :*