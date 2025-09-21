****************************************************************************
*  PROGRAM NAME: PDFDirectoryMerger.prg
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
*     This program will merge all the PDF files in a directory 
*     together into a combined PDF file.
*
*     Adapted from Visual Basic Sample JoinAllAcrobatDocsInDir()
*       Author : A Round Table Solution 
*       E-Mail:  info@aroundtablesolution.com 
*
*  CALLED BY: 
*     DO PDFDirectoryMerge with <tcDirectory> [, <tcPDFCombinedFile>]
*
*  INPUT PARAMETERS:
*     tcDirectory   = Character, required, directory. Can be
*                     fully pathed, relatively pathed, or no path.
*     tcPDFCombined = Character, optional, combined PDF file. Can be
*                     fully pathed, relatively pathed, or no path
*                     will default to the current VFP directory. If
*                     no file name is passed, it will default to 
*                     "directorycombined.pdf" and be placed in the 
*                     current VFP directory.
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

LPARAMETERS tcDirectory, tcPDFCombinedFile

* Added this for demonstration purposes only, real apps that would
* use this in a batch process would provide the directory.
#DEFINE clUSER_INTERFACE  .T.

LOCAL lcFileSkeleton, ;
      lnPDFCount, ;
      lcCombinedFile, ;
      lcLastFile, ;
      lcResult

DO CASE
   CASE VARTYPE(tcDirectory) # "C"
      * For demonstration purposes only
      IF clUSER_INTERFACE
         tcDirectory = GETDIR(CURDIR(),SPACE(0), "Select PDF Merge Directory")
         
         IF EMPTY(tcDirectory)
            RETURN "First PDF file parameter not passed as a character"
         ENDIF
      ELSE
         RETURN "First PDF file parameter not passed as a character"
      ENDIF
   CASE VARTYPE(tcPDFCombinedFile) # "C"
      * Default file name
      tcPDFCombinedFile = ADDBS(FULLPATH(CURDIR())) + "DirectoryCombined.pdf"
   OTHERWISE
      * All is well on the parameter checks
ENDCASE

IF DIRECTORY(tcDirectory)
   tcDirectory = ADDBS(tcDirectory)
ELSE
   RETURN tcDirectory + " does not exist"
ENDIF

DIMENSION laPDFFiles[1]

lcFileSkeleton = ADDBS(ALLTRIM(tcDirectory)) + "*.pdf"
lnPDFCount     = ADIR(laPDFFiles, lcFileSkeleton)

DO CASE 
   CASE lnPDFCount > 1
      lcLastFile = tcDirectory + laPDFFiles[1, 1]

      FOR lnCount = 2 TO lnPDFCount
         IF lnCount = lnPDFCount
            * Last one, used the specified combine file
            lcCombinedFile = tcPDFCombinedFile
         ELSE
            * Build a temporary
            lcCombinedFile = FORCEEXT(ADDBS(SYS(2023)) + "Temp" + ALLTRIM(STR(lnCount)), "PDF")
         ENDIF
         
         lcResult   = PdfMerger(lcLastFile, tcDirectory + laPDFFiles[lnCount, 1], lcCombinedFile)
         lcLastFile = lcCombinedFile
      ENDFOR

   CASE lnPDFCount = 1
      COPY FILE laPDFFiles[1, 1] TO tcPDFCombinedFile
    
   OTHERWISE
      * Nothing to do with no files in directory
ENDCASE

RETURN