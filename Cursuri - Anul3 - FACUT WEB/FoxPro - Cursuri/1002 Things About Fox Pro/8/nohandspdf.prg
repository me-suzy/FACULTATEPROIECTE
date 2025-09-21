* NoHandsPDF.prg - Created as an example for
* MegaFox Chapter 8
*
* This code is an example of generating a PDF file
* without any user interaction

LOCAL lcOldDirectory, ;
      lcOldProcedure, ;
      lnOldReprocess, ;
      loPDF, ;
      lcFileName, ;
      lcOutputFile, ;
      lcWebDirectory

lcOldDirectory = CURDIR()
lcOldPath      = SET("Path")

SET PATH TO .\ ; &lcOldPath

OPEN DATABASE PDFSample
USE v_GeeksContactList IN 0 AGAIN SHARED

SELECT * ;
   FROM v_GeeksContactList ;
   ORDER BY Contact_Id ;
   INTO CURSOR curRpt

IF RECCOUNT("curRpt") > 0
   lcOldProcedure = SET("procedure")
   lnOldReprocess = SET("reprocess")
   SET PROCEDURE TO wwPDF ADDITIVE
   SET PROCEDURE TO wwAPI ADDITIVE
   SET PROCEDURE TO wwUtils ADDITIVE
   SET PROCEDURE TO wwEval ADDITIVE
   SET REPROCESS TO 1

   *< RAS 17-Mar-2002, Changed to work with new Acrobat 5 
   *< class from West Wind. Change back if you use Acrobat 4
   *< loPDF     = CREATEOBJECT('wwPDF40')
   loPDF = CREATEOBJECT('wwPDF50')
   lcNow = STRTRAN(STRTRAN(STRTRAN(TTOC(DATETIME()),"/",""),":",""),SPACE(1),SPACE(0))

   lcFileName     = "ContactList" + lcNow + ".pdf"
   lcOutputFile   = ADDBS(SYS(2023)) + lcFileName

   * Use PrintReport() instead of PrintReportToString()
   * IMPORTANT: FRX must have printer specified as PDFWriter
   loPDF.PrintReport("ContactListing", lcOutputFile)

   * Destroy the PDF Object
   loPDF = .NULL.

   * Parse procedures out of memvar because it fails on reset
   IF EMPTY(lcOldProcedure)
      lnProcCount = 0
   ELSE
      lnProcCount = ALINES(laProc, lcOldProcedure, .T., ",")
   ENDIF

   SET PROCEDURE TO

   FOR lnCount = 1 TO lnProcCount
      lcProcedure = laProc[lnCount]
      SET PROCEDURE TO &lcProcedure ADDITIVE
   ENDFOR

   SET REPROCESS TO (lnOldReprocess)
ENDIF

USE IN curRpt
USE IN v_GeeksContactList

CD (lcOldDirectory)

SET PATH TO &lcOldPath

RETURN

*: EOF :*