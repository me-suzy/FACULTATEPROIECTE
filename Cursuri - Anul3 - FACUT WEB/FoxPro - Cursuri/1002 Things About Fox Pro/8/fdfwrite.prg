****************************************************************************
*  PROGRAM NAME: FDFWrite.prg
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
*     to write data to an Acrobat file.
*
*  SAMPLE CALL:
*     DO FDFWrite.prg
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

LOCAL loFDF, ;                         && Object reference to the ActiveX Control
      loFDFFile, ;                     && Object reference to the FDF file
      lcFDFField, ;                    && Field name within the FDF/PDF
      lcFDFFieldValue, ;               && Field value in the FDF file
      lcOldEscape                      && Save the Set Escape setting for reset later

lcOldEscape     = SET("escape")

* Just in case there is a problem <g>
SET ESCAPE ON

* Get the reference to the FDF ActiveX control
loFDF          = CREATEOBJECT("fdfApp.FdfApp")

* Create the new file
loFDFFile      = loFDF.FDFCreate()

* Fill in two fields in the FDF
lcFDFField      = "txtStreetAddress"
lcFDFFieldValue = "1002 MegaFox Street"
luFieldValue    = loFDFFile.FDFSetValue(lcFDFField, lcFDFFieldValue, .F.)

lcFDFField      = "txtOwnersName"
lcFDFFieldValue = "Enter your Name Here"
luFieldValue    = loFDFFile.FDFSetValue(lcFDFField, lcFDFFieldValue, .F.)

* Set the name of the PDF associated with the FDF
loFDFFile.FDFSetFile("SHAppBuildPermitForm.pdf")

* Write out the file
loFDFFile.FDFSaveToFile("Chapter08Sample.fdf")

* Close the FDF file
loFDFFile.FDFClose()

* Release the object references as garbage cleanup
RELEASE loFDFFile
RELEASE loFDF

SET ESCAPE &lcOldEscape

MESSAGEBOX("Ran to completion, double click on FDF in Windows Explorer.", ;
           0+48, _screen.Caption)

RETURN

*: EOF :*
