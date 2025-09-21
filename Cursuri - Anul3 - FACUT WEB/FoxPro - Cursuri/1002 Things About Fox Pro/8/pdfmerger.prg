****************************************************************************
*  PROGRAM NAME: PDFMerger
*
*  AUTHOR: Richard A. Schummer, January 2002
*
*  COPYRIGHT © 2002   All Rights Reserved.
*     Richard A. Schummer
*     Geeks and Gurus, Inc.
*     42759 Flis Dr.  
*     Sterling Heights, MI  48314-2850
*
*     raschummer@geeksandgurus.com
*     rick@rickschummer.com
*     http://www.rickschummer.com
*
*     Free for the use by all FoxPro developers around the world!
*
*  SYSTEM: Utilities
*
*  PROGRAM DESCRIPTION: 
*     This program will merge two PDF files together into a third
*     PDF file. Files are merged in the order they are sent to 
*     the procedure, see the parameters for the PDF file names.
*
*     Adapted from Visual Basic Sample JoinAllAcrobatDocsInDir()
*       Author : A Round Table Solution 
*       E-Mail:  info@aroundtablesolution.com 
*
*  CALLED BY: 
*     DO PDFMerge with <tcPDFOne>, <tcPDFTwo>, ;
*                      [<tcPDFCombined>, <tlShowAcrobat>]
*
*  INPUT PARAMETERS:
*     tcPDFOne      = Character, required, first PDF file. Can be
*                     fully pathed, relatively pathed, or no path
*                     will default to the current VFP directory.
*     tcPDFTwo      = Character, required, second PDF file. Can be
*                     fully pathed, relatively pathed, or no path
*                     will default to the current VFP directory.
*     tcPDFCombined = Character, optional, combined PDF file. Can be
*                     fully pathed, relatively pathed, or no path
*                     will default to the current VFP directory. If
*                     no file name is passed, it will default to 
*                     "combined.pdf" and be placed in the directory
*                     of the first PDF file passed in (tcPDFOne)
*     tlShowAcrobat = Logical, optional, determines if the Acrobat
*                     utility is displayed on the screen. Defaults 
*                     to not display.
*
*  OUTPUT PARAMETERS:
*     Character string returned with Error message, or null string
*     if the process ran to completion.
*
*  TABLES ACCESSED: 
*     None
* 
*  GLOBAL VARIABLES REQUIRED:
*     None
*
*  GLOBAL PROCEDURES REQUIRED:
*     None
*
*  CODING STANDARDS:
*     Version 3.0 compliant with no exceptions
*  
*  TEST INFORMATION:
*     None
*   
*  SPECIAL REQUIREMENTS/DEVICES:
*     None
*
*  FUTURE ENHANCEMENTS:
*     None
*
*  LANGUAGE/VERSION:
*     Visual FoxPro 6.0 or higher
* 
****************************************************************************
*
*                            C H A N G E    L O G                           
*
*    Date     Dev  Version  Description
* ----------  ---  -------  ------------------------------------------------
* 01/13/2002  RAS  1.0      Created program
* --------------------------------------------------------------------------
*
****************************************************************************

LPARAMETERS tcPDFOne, tcPDFTwo, tcPDFCombined, tlShowAcrobat

#DEFINE  ccSAVEFULL 0x0001

LOCAL loAcrobatExchApp, ;
      loAcrobatExchPDFOne, ;
      loAcrobatExchPDFTwo, ;
      lnLastPage, ;
      lnNumberOfPagesToInsert, ;
      lcOldSafety

DO CASE
   CASE VARTYPE(tcPDFOne) # "C"
      RETURN "First PDF file parameter not passed as a character"
   CASE VARTYPE(tcPDFTwo) # "C"
      RETURN "Second PDF file parameter not passed as a character"
   OTHERWISE
      * All is well on the parameter checks
ENDCASE

tcPDFOne      = FORCEEXT(tcPDFOne, "PDF")
tcPDFTwo      = FORCEEXT(tcPDFTwo, "PDF")

IF FILE(tcPDFOne)
   IF FILE(tcPDFTwo)
      * Nothing to do, both files exist
   ELSE
      RETURN tcPDFTwo + " does not exist"
   ENDIF
ELSE
   RETURN tcPDFOne + " does not exist"
ENDIF

IF VARTYPE(tcPDFCombined) # "C"
   tcPDFCombined = ADDBS(JUSTPATH(tcPDFOne)) + "combined.pdf"
ENDIF

tcPDFCombined = FORCEEXT(tcPDFCombined, "PDF")

WAIT WINDOW "Combining " + tcPDFOne + " with " + tcPDFTwo + ;
            " into " + tcPDFCombined + ", please wait..." NOWAIT NOCLEAR

lcOldSafety = SET("Safety")
SET SAFETY OFF
ERASE tcPDFCombined
SET SAFETY &lcOldSafety

* Get appropriate references to Acrobat objects
loAcrobatExchApp    = CREATEOBJECT("AcroExch.App") 
loAcrobatExchPDFOne = CREATEOBJECT("AcroExch.PDDoc") 
loAcrobatExchPDFTwo = CREATEOBJECT("AcroExch.PDDoc")

* Show the Acrobat Exchange window 
IF tlShowAcrobat
   loAcrobatExchApp.Show()
ENDIF

* Open the first file in the directory 
loAcrobatExchPDFOne.Open(tcPDFOne)

* Get the total pages less one for the last page num (zero based)
lnLastPage = loAcrobatExchPDFOne.GetNumPages() - 1 

* Open the file to insert 
loAcrobatExchPDFTwo.Open(tcPDFTwo)

* Get the number of pages to insert 
lnNumberOfPagesToInsert = loAcrobatExchPDFTwo.GetNumPages()

* Insert the pages:
* InsertPages(nInsertPageAfter As Numeric, iPDDocSource As Object, ;
*             nStartPage As Numeric, nNumPages As Numeric, ;
*             bBookmarks As Numeric) As Numeric
* Inserts pages into a file.
loAcrobatExchPDFOne.InsertPages(lnLastPage, loAcrobatExchPDFTwo, 0, lnNumberOfPagesToInsert, .T.)

* Close the document 
loAcrobatExchPDFTwo.Close()

* Save the entire document, saved as file passed as third 
* parameter to program using SaveFull (0x0001).
loAcrobatExchPDFOne.Save(ccSAVEFULL, tcPDFCombined)

* Close the PDDoc 
loAcrobatExchPDFOne.Close()

* Close Acrobat Exchange 
loAcrobatExchApp.Exit()

* Need to release the objects
RELEASE loAcrobatExchPDFTwo
RELEASE loAcrobatExchPDFOne
RELEASE loAcrobatExchApp

WAIT CLEAR

RETURN SPACE(0)

ENDPROC