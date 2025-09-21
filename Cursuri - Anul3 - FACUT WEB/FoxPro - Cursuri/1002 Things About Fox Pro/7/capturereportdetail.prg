LPARAMETERS tlOutput

PRIVATE  poPrinterParameter

OPEN DATABASE musiccollection

IF NOT USED("RecordingArtists")
   USE recordingartists IN 0 SHARED AGAIN
ENDIF

OpenAuditTable("ReportAudit")
CLEAR
SELECT recordingartists

poPrinterParameter = CREATEOBJECT("custom")
WITH poPrinterParameter
   .AddProperty("lStarted", .F.)
   .AddProperty("lPrinted", .F.)
   .AddProperty("cPrinter", SPACE(0))
   .AddProperty("mPrintInfo", SPACE(0))
   .AddProperty("tPreviewStarted", {/:})
   .AddProperty("tPrinterStarted", {/:})
   .AddProperty("tPrinterEnded", {/:})
   .AddProperty("nPages", 0)
   .AddProperty("cAlias", 0)
   .AddProperty("nRecords", 0)
   .AddProperty("tCompleted", {/:})

   IF tlOutput 
      REPORT FORM CaptureReportDetail NOCONSOLE TO PRINTER
   ELSE
      REPORT FORM CaptureReportDetail PREVIEW 
   ENDIF

   .tCompleted = DATETIME()
    GetPrinterInfo(poPrinterParameter)

   INSERT INTO ReportAudit ;
         (lStarted, lPrinted, cPrtr, mPrtrInfo, ;
           tPrwStart, tPrtrStart, tPrtrEnd, ;
           nPages, tCompleted) ;
      VALUES ;
         (.lStarted, .lPrinted, .cPrinter, .mPrintInfo, ;
          .tPreviewStarted, .tPrinterStarted, .tPrinterEnded, ;
          .nPages, .tCompleted)
ENDWITH

USE IN (SELECT("RecordingArtists"))
RETURN


*===========================================
PROCEDURE GetPrinterInfo(toPrinterParameter)

#DEFINE ccCR   CHR(13)

IF VARTYPE(toPrinterParameter) = "O"
   IF VARTYPE(toPrinterParameter.mPrintInfo) # "U"
      FOR lnCounter = 1 TO 13
         toPrinterParameter.mPrintInfo = toPrinterParameter.mPrintInfo + ;
                                         TRANSFORM(lnCounter) + ") " + ;
                                         TRANSFORM(PRTINFO(lnCounter)) + ccCR
      ENDFOR
   ENDIF
ELSE
   * Nothing to provide
ENDIF

RETURN


*===========================================
FUNCTION ReportStats(tcBand)

tcBand = LOWER(tcBand)

?"Band=", tcBand, " ][ ", "Page=", TRANSFORM(_pageno)

DO CASE 
   CASE INLIST(tcBand, "title", "bof")
      WITH poPrinterParameter
         .lStarted        = .T.
         .lPrinted        = WEXIST("Printing...")
         .cPrinter        = SET("Printer", 3)

         IF .lPrinted 
            .tPrinterStarted = IIF(EMPTY(.tPrinterStarted), DATETIME(), .tPrinterStarted)
         ELSE
            .tPreviewStarted = IIF(EMPTY(.tPreviewStarted), DATETIME(), .tPreviewStarted)
         ENDIF

         .cAlias          = ALIAS()
         .nRecords        = RECCOUNT()
      ENDWITH

   CASE INLIST(tcBand, "header")
      WITH poPrinterParameter
         .nPages        = _pageno
      ENDWITH
      
   CASE INLIST(tcBand, "summary", "eof")
      WITH poPrinterParameter
         .lPrinted      = WEXIST("Printing...")
         .tPrinterEnded = IIF(.lPrinted, DATETIME(), {/:})
         .nPages        = _pageno
      ENDWITH
ENDCASE

RETURN SPACE(0)


*===========================================
FUNCTION OpenAuditTable(tcTable)

tcTable = FORCEEXT(tcTable, "dbf")

IF FILE(tcTable)
   IF NOT USED(JUSTSTEM(tcTable))
      USE (tcTable) IN 0 SHARED
   ENDIF
ELSE
   CREATE TABLE (tcTable) FREE ;
      (lStarted L, ;
       lPrinted L, ;
       cPrtr C(50), ;
       mPrtrInfo M, ;
       tPrwStart T, ;
       tPrtrStart T, ;
       tPrtrEnd T, ;
       nPages i, ;
       tCompleted T)
ENDIF

RETURN

*: EOF :*