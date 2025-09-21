LOCAL lcOldDirectory, ;
      lcReport, ;
      lcPDFPrinter, ;
      lcOldPrinter

lcOldDirectory = FULLPATH(CURDIR())
lcReport       = "ContactListing.frx"

IF FILE(lcReport)
ELSE
   lcReport = GETFILE("FRX")
   
   IF EMPTY(lcReport)
      RETURN .F.
   ENDIF
ENDIF

OPEN DATABASE PdfSample
SET DATABASE TO PdfSample
USE v_GeeksContactList IN 0 AGAIN SHARED

SELECT v_GeeksContactList

* EXAMPLE 1:
* Generic call where VFP prompts the user with the 
* printer dialog each time the report is run
REPORT FORM (lcReport) TO PRINTER PROMPT NOCONSOLE

CD (lcOldDirectory)

* EXAMPLE 2:
* Generic call so user select printer before report is printed,
* but it changes the VFP Printer
SYS(1037)
REPORT FORM (lcReport) TO PRINTER NOCONSOLE

CD (lcOldDirectory)

* EXAMPLE 3:
* Call that has a hardcoded setting to drive the report
* to the Acrobat Printer, yet saves the old printer setting
* for reset later.
lcPDFPrinter = "Acrobat PDFWriter"
lcOldPrinter = SET("PRINTER", 2)

SET PRINTER TO NAME (lcPDFPrinter)

REPORT FORM (lcReport) TO PRINTER NOCONSOLE

SET PRINTER TO NAME (lcOldPrinter)

CD (lcOldDirectory)

USE IN (SELECT("v_GeeksContactList"))

CLOSE DATA ALL

RETURN

*: EOF :*

