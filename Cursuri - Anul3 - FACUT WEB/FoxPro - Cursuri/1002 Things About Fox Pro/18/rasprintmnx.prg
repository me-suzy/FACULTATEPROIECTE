****************************************************************************
*
*  PROGRAM NAME: RASPrintMNX.prg (formerly called MenuWalkThru.prg)
*
*  AUTHOR: Richard A. Schummer, November 1998
*
*  COPYRIGHT © 1998-2000   All Rights Reserved.
*     Richard A. Schummer
*     42759 Flis Dr.  
*     Sterling Heights, MI  48314-2850
*
*     rick@rickschummer.com
*     http://rickschummer.com
*
*     Free for the use by all FoxPro developers around the world!
*
*  SYSTEM: Common Utilities
*
*  PROGRAM DESCRIPTION: 
*     This program lists off the details about a menu.
* 
*     Images that cause OLE Exception errors will not be displayed (when 
*     running reports on menus after VFP 6.
*
*  CALLED BY: 
*     DO RASPrintMNX.prg
*
*  SAMPLE CALL:
*     DO RASPrintMNX.prg
*
*  INPUT PARAMETERS: 
*     None
*
*  OUTPUT PARAMETERS:
*     None
* 
*  TABLES ACCESSED: 
*     Only the metadata table represented by the lcMnxFilename variable (selected)
*     from Open File dialog).
* 
*  GLOBAL VARIABLES REQUIRED:
*     None
*
*  GLOBAL PROCEDURES REQUIRED:
*     None
* 
*  DEVELOPMENT STANDARDS:
*     Version 3.0 compliant
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
*     Visual FoxPro 5.0 or higher
* 
****************************************************************************
*
*                           C H A N G E    L O G
*
*   Date                SE            System           Description
* ----------  ----------------------  -------  ----------------------------- 
* 11/07/1997  Richard A. Schummer     Utils    Created program 
* -------------------------------------------------------------------------- 
* 06/10/2000  Richard A. Schummer     Utils    Cleanup and documentation,
*                                              name changes, added metadata
*                                              record number
* -------------------------------------------------------------------------- 
* 10/04/2001  Richard A. Schummer     Utils    Added support for VFP 7 
*                                              icon and resources
* -------------------------------------------------------------------------- 
*
****************************************************************************
 
#INCLUDE FoxPro.h

#DEFINE  ccOUTPUT_REPORT  "RASPrintMNX02.frx"

PRIVATE pcVersion                      && Application version number
PRIVATE lcMnxFilename                  && Menu metadata table, PRIVATE so on form
LOCAL   lcSelectedCursor               && Previously selected cursor
LOCAL   lcOldClassLib                  && Retain the classlib SETting for reset
LOCAL   lcOldOnError                   && Track the old ON("ERROR")
LOCAL   lnAddedRows                    && Number of fields to add via the CREATE CURSOR
LOCAL   llVFP6                         && Determines if it needs to add dummy columns for VFP 7 compatibility
LOCAL   lnFields                       && Number of fields returned from AFIELDS()
LOCAL   lnColumns                      && Number of columns returned by AFIELDS()
LOCAL   lcImageToGeneral               && Image name used to APPEND GENERAL

pcVersion        = "2.1.1"
lcMnxFilename    = GETFILE("MNX")
lcSelectedCursor = SELECT()
lcOldOnError     = ON("error")

ON ERROR do ErrorHandler WITH LINENO()

IF EMPTY(lcMnxFilename)  OR  'Untitled' $ lcMnxFilename
   ON ERROR (lcOldOnError)
   RETURN .F.                          && Canceled out, do not run prog
ELSE
   IF USED("MnxData")
      USE IN MnxData
   ENDIF
   
   *< RAS 4-Oct-2001, Allow the menu to be open in designer 
   *< and by this developer tool.
   *< USE (lcMnxFilename) EXCLUSIVE IN 0 ALIAS MnxData
   USE (lcMnxFilename) SHARED IN 0 ALIAS MnxData
   SELECT MnxData

   lcMnxFilename = ALLTRIM(LOWER(FULLPATH(DBF())))
ENDIF

lnCounter = 1

GO BOTTOM

lnFields  = AFIELDS(aMenuMeta)
lnColumns = ALEN(aMenuMeta,2)

* RAS 04-Oct-2001, Added support to work with VFP 7 icon/resources
IF lnFields = 23                       && VFP 6 has 23, VFP 7 has 25
   lnAddedRows = lnFields + 6
   llVFP6      = .T.
ELSE
   lnAddedRows = lnFields + 4
   llVFP6      = .F.
ENDIF

DIMENSION aMenuMeta[lnAddedRows, lnColumns]

* Key field to break report on the Menu Pad
aMenuMeta[lnFields+1, 01] = "cRptGroup"
aMenuMeta[lnFields+1, 02] = "C"
aMenuMeta[lnFields+1, 03] = 20
aMenuMeta[lnFields+1, 04] = 0
aMenuMeta[lnFields+1, 05] = .F.
aMenuMeta[lnFields+1, 06] = .F.
aMenuMeta[lnFields+1, 07] = ""
aMenuMeta[lnFields+1, 08] = ""
aMenuMeta[lnFields+1, 09] = ""
aMenuMeta[lnFields+1, 10] = ""
aMenuMeta[lnFields+1, 11] = ""
aMenuMeta[lnFields+1, 12] = ""
aMenuMeta[lnFields+1, 13] = ""
aMenuMeta[lnFields+1, 14] = ""
aMenuMeta[lnFields+1, 15] = ""
aMenuMeta[lnFields+1, 16] = ""

aMenuMeta[lnFields+2, 01] = "nCounter"
aMenuMeta[lnFields+2, 02] = "N"
aMenuMeta[lnFields+2, 03] = 10
aMenuMeta[lnFields+2, 04] = 0
aMenuMeta[lnFields+2, 05] = .F.
aMenuMeta[lnFields+2, 06] = .F.
aMenuMeta[lnFields+2, 07] = ""
aMenuMeta[lnFields+2, 08] = ""
aMenuMeta[lnFields+2, 09] = ""
aMenuMeta[lnFields+2, 10] = ""
aMenuMeta[lnFields+2, 11] = ""
aMenuMeta[lnFields+2, 12] = ""
aMenuMeta[lnFields+2, 13] = ""
aMenuMeta[lnFields+2, 14] = ""
aMenuMeta[lnFields+2, 15] = ""
aMenuMeta[lnFields+2, 16] = ""

aMenuMeta[lnFields+3, 01] = "nRecNo"
aMenuMeta[lnFields+3, 02] = "N"
aMenuMeta[lnFields+3, 03] = 10
aMenuMeta[lnFields+3, 04] = 0
aMenuMeta[lnFields+3, 05] = .F.
aMenuMeta[lnFields+3, 06] = .F.
aMenuMeta[lnFields+3, 07] = ""
aMenuMeta[lnFields+3, 08] = ""
aMenuMeta[lnFields+3, 09] = ""
aMenuMeta[lnFields+3, 10] = ""
aMenuMeta[lnFields+3, 11] = ""
aMenuMeta[lnFields+3, 12] = ""
aMenuMeta[lnFields+3, 13] = ""
aMenuMeta[lnFields+3, 14] = ""
aMenuMeta[lnFields+3, 15] = ""
aMenuMeta[lnFields+3, 16] = ""

aMenuMeta[lnFields+4, 01] = "gImage"
aMenuMeta[lnFields+4, 02] = "g"
aMenuMeta[lnFields+4, 03] = 4
aMenuMeta[lnFields+4, 04] = 0
aMenuMeta[lnFields+4, 05] = .F.
aMenuMeta[lnFields+4, 06] = .F.
aMenuMeta[lnFields+4, 07] = ""
aMenuMeta[lnFields+4, 08] = ""
aMenuMeta[lnFields+4, 09] = ""
aMenuMeta[lnFields+4, 10] = ""
aMenuMeta[lnFields+4, 11] = ""
aMenuMeta[lnFields+4, 12] = ""
aMenuMeta[lnFields+4, 13] = ""
aMenuMeta[lnFields+4, 14] = ""
aMenuMeta[lnFields+4, 15] = ""
aMenuMeta[lnFields+4, 16] = ""

* Only need to add these columns if before VFP 7
IF llVFP6
   aMenuMeta[lnFields+5, 01] = "SysRes"
   aMenuMeta[lnFields+5, 02] = "N"
   aMenuMeta[lnFields+5, 03] = 1
   aMenuMeta[lnFields+5, 04] = 0
   aMenuMeta[lnFields+5, 05] = .F.
   aMenuMeta[lnFields+5, 06] = .F.
   aMenuMeta[lnFields+5, 07] = ""
   aMenuMeta[lnFields+5, 08] = ""
   aMenuMeta[lnFields+5, 09] = ""
   aMenuMeta[lnFields+5, 10] = ""
   aMenuMeta[lnFields+5, 11] = ""
   aMenuMeta[lnFields+5, 12] = ""
   aMenuMeta[lnFields+5, 13] = ""
   aMenuMeta[lnFields+5, 14] = ""
   aMenuMeta[lnFields+5, 15] = ""
   aMenuMeta[lnFields+5, 16] = ""

   aMenuMeta[lnFields+6, 01] = "ResName"
   aMenuMeta[lnFields+6, 02] = "M"
   aMenuMeta[lnFields+6, 03] = 4
   aMenuMeta[lnFields+6, 04] = 0
   aMenuMeta[lnFields+6, 05] = .F.
   aMenuMeta[lnFields+6, 06] = .F.
   aMenuMeta[lnFields+6, 07] = ""
   aMenuMeta[lnFields+6, 08] = ""
   aMenuMeta[lnFields+6, 09] = ""
   aMenuMeta[lnFields+6, 10] = ""
   aMenuMeta[lnFields+6, 11] = ""
   aMenuMeta[lnFields+6, 12] = ""
   aMenuMeta[lnFields+6, 13] = ""
   aMenuMeta[lnFields+6, 14] = ""
   aMenuMeta[lnFields+6, 15] = ""
   aMenuMeta[lnFields+6, 16] = ""
ENDIF

CREATE CURSOR curMnxBackward FROM ARRAY aMenuMeta

SELECT MnxData

lcPrevLevelName = "ZZZZZZZZZZZZZZ"

DO WHILE !BOF()
   SCATTER MEMVAR MEMO
   
   IF LevelName != lcPrevLevelName
      IF LevelName == "_msysmenu " AND ObjCode != 1
         m.cRptGroup     = lcPrevLevelName
      ELSE
         m.cRptGroup     = LevelName
         lcPrevLevelName = LevelName
      ENDIF
   ENDIF
   
   IF llVFP6
      m.SysRes  = 0
      m.ResName = SPACE(0)
   ELSE
      lcImageToGeneral = m.ResName
   ENDIF
   
   m.nCounter = lnCounter
   m.nRecNo   = RECNO()
   
   INSERT INTO curMnxBackward FROM MEMVAR

   IF NOT EMPTY(m.ResName)
      lnOldSelect = SELECT()
      SELECT curMnxBackward
      APPEND GENERAL gImage FROM (lcImageToGeneral) LINK CLASS PBrush
      SELECT (lnOldSelect)
   ENDIF

   SKIP -1
   lnCounter = lnCounter + 1
ENDDO

SELECT * ;
   FROM curMnxBackward ;
   ORDER BY nCounter DESCENDING ;
   INTO CURSOR MnxDataWT

REPORT FORM ccOUTPUT_REPORT NOCONSOLE PREVIEW

* Cannot run the following code because of a bug in the preview mode in VFP 5.0
* (fixed in 5.0a)
* There is an automatic NOWAIT issuesed in the REPORT FORM so the cursor
* is destroyed and the report cannot be viewed past page 1 <g>.
USE IN curMnxBackward
USE IN MnxData
USE IN MnxDataWt

SELECT (lcSelectedCursor)
ON ERROR &lcOldOnError

RETURN


FUNCTION ErrorHandler()
LPARAMETERS tnLine 

LOCAL lcSourceCode, ;
      lcErrorMessage, ;
      laErrorDetail[1], ;
      lcOldOnError

lcOldOnError = ON("error")
ON ERROR
lcSourceCode = MESSAGE(1)

AERROR(laErrorDetail)

DO CASE 
   CASE laErrorDetail[1] = 1426
      * Nothing to do, image not handled
   OTHERWISE
      lcErrorMessage = "Error: " + laErrorDetail[2] + ;
                       " (" + ;
                       TRANSFORM(laErrorDetail[1]) + ;
                       ") on line " + ;
                       TRANSFORM(tnLine) + ;
                       IIF(NOT EMPTY(lcSourceCode), CHR(13) + "Source: " + lcSourceCode, "")

      MESSAGEBOX(lcErrorMessage, 16, "Menu Source Printer")
      CANCEL
ENDCASE 

ON ERROR &lcOldOnError

RETURN

*: EOF :*