****************************************************************************
*  PROGRAM NAME: FDFRead.prg
*
*  AUTHOR: Richard A. Schummer, September 2000
*
*  COPYRIGHT © 2000-2001   All Rights Reserved.
*     Richard A. Schummer
*     Geeks and Gurus, Inc.
*     42759 Flis Dr.
*     Sterling Heights, MI  48314-2850
*
*     rick@rickschummer.com
*     http://www.rickschummer.com
*
*     Free for demo purpose by all FoxPro developers around the world!
*
*  SYSTEM: Common Utilities
*
*  PROGRAM DESCRIPTION:
*     This program demonstrates the use of the Adobe Acrobat FDF Toolkit
*     to extract data from a Acrobat file.
*
*  SAMPLE CALL:
*     DO FDFRead.prg
*
*  INPUT PARAMETERS:
*     None
*
*  OUTPUT PARAMETERS:
*     None
*
*  TABLES ACCESSED:
*     None
*
*  DEVELOPMENT STANDARDS:
*     Version 4.0 compliant
*
*  TEST INFORMATION:
*     None
*
*  SPECIAL REQUIREMENTS/DEVICES:
*     Need the Adobe Acrobat FDF ToolKit installed and the ActiveX control
*     registered. FdfAcX.dll should be installed in some directory that has
*     "execute" permissions. FdfAcX.dll uses FdfTk.dll, which can be placed 
*     either in the same directory as FdfAcX.dll, or in the "System" directory
*     (e.g. c:\WINDOWS\System32).
*     FdfAcX.dll needs to be registered. This can be accomplished by typing
*     at the command prompt (path if necessary):
*          regsvr32 FdfAcX.dll
*
*  FUTURE ENHANCEMENTS:
*     None
*
*  LANGUAGE/VERSION:
*     Visual FoxPro 6.0 or higher
****************************************************************************
*
*                           C H A N G E    L O G
*
*   Date                SE            System           Description
* ----------  ----------------------  -------  -----------------------------
* 09/03/2000  Richard A. Schummer     Utils    Created program for GLGDW 2000
* --------------------------------------------------------------------------
* 11/15/2001  Richard A. Schummer     Utils    Changed a bit for FoxTalk article
* --------------------------------------------------------------------------
*
****************************************************************************

#DEFINE CRLF  CHR(13)+CHR(10)

LOCAL loFDF, ;                         && Object reference to the ActiveX Control
      loFDFFile, ;                     && Object reference to the FDF file
      lcFDFField, ;                    && Field name within the FDF/PDF
      luFieldValue, ;                  && Field value in the FDF file
      lnFieldCounter, ;                && Field counter
      lcOldEscape, ;                   && Save the Set Escape setting for reset later
      lcOldAlternate, ;                && Save the Set Alternate setting for reset later
      lcOldAlternate1                  && Save the Set Alternate file setting for reset later

lcOldEscape     = SET("escape")
lcOldAlternate  = SET("alternate")
lcOldAlternate1 = SET("alternate", 1)

* Just in case there is a problem <g>
SET ESCAPE ON

* Get the reference to the FDF ActiveX control
loFDF          = CREATEOBJECT("fdfApp.FdfApp")

* Open the FDF file (no error logic to handle missing file)
loFDFFile      = loFDF.FDFOpenFromFile("SHAppBuildPermitData.fdf")

* Example of going directly after one file
lcFDFField     = "txtOwnersAddress"
luFieldValue   = loFDFFile.FDFGetValue(lcFDFField)
CLEAR

SET ALTERNATE TO temp.txt
SET ALTERNATE ON
? "Direct Field Access - ", lcFDFField, "(", VARTYPE(luFieldValue), ") ==", luFieldValue, CRLF

IF VARTYPE(loFDFFile) = "O"
   * Get the first field name in the FDF file
   lcFDFField     = loFDFFile.FDFNextFieldName("")
   lnFieldCounter = 1

   CLEAR

   * Loop through the FDF file to get the values
   DO WHILE NOT EMPTY(lcFDFField)
      luFieldValue   = loFDFFile.FDFGetValue(lcFDFField)

      ? STR(lnFieldCounter, 6), lcFDFField, "(", VARTYPE(luFieldValue), ") ==", luFieldValue

      lcFDFField     = loFDFFile.FDFNextFieldName(lcFDFField)
      lnFieldCounter = lnFieldCounter + 1
   ENDDO
ENDIF

* Close the FDF file
loFDFFile.FDFClose()

* Release the object references as garbage cleanup
RELEASE loFDFFile
RELEASE loFDF

SET ESCAPE &lcOldEscape
SET ALTERNATE &lcOldAlternate
SET ALTERNATE TO &lcOldAlternate1

MODIFY FILE temp.txt

RETURN

*: EOF :*
