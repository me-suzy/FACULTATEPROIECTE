* NoHandsAmyuniPDF.prg - Created as an example for
* MegaFox Chapter 8
*
* This code is an example of generating a PDF file
* without any user interaction

LOCAL lcOldDirectory, ;
      lcOldProcedure, ;
      loPDF, ;
      lcFileName, ;
      lcOutputFile, ;
      lcWebDirectory, ;
      loPDF

lcOldDirectory = CURDIR()

USE contacts IN 0 AGAIN SHARED

SELECT * ;
   FROM contacts ;
   ORDER BY Contact_Id ;
   INTO CURSOR curRpt

IF RECCOUNT("curRpt") > 0
   lcNow = STRTRAN(STRTRAN(STRTRAN(TTOC(DATETIME()),"/",""),":",""),SPACE(1),SPACE(0))

   lcFileName     = "ContactList" + lcNow + ".pdf"
   lcOutputFile   = ADDBS(SYS(2023)) + lcFileName
   lcWebDirectory = ".\"
   loPDF          = NEWOBJECT("cusAmyuniPdf", "G2Pdf.vcx")

   IF VARTYPE(loPDF) = "O"
      loPDF.Generate("ContactListing", lcOutputFile)
      loPDF = .NULL.
   ENDIF
ENDIF

USE IN contacts
USE IN curRpt

CD (lcOldDirectory)

RETURN

*: EOF :*