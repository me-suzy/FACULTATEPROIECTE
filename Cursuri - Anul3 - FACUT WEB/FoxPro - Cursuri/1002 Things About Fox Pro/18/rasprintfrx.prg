****************************************************************************
*
*  PROGRAM NAME: RASPrintFRX.prg (formerly ReportWalkThru.prg)
*
*  AUTHOR: Richard A. Schummer, May 1997
*
*  COPYRIGHT © 1997-2002   All Rights Reserved.
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
*     This program lists off the expressions in a Report Form so that 
*     the developer or others can review the settings, calculations
*     and fields in the report.
*
*  CALLED BY: 
*     DO RASPrintFRX.prg
*
*  SAMPLE CALL:
*     DO RASPrintFRX.prg
*
*  INPUT PARAMETERS: 
*     None
*
*  OUTPUT PARAMETERS:
*     None
* 
*  TABLES ACCESSED: 
*     Only the metadata table represented by the lcFrxFilename variable (selected)
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
* 05/14/1997  Richard A. Schummer     Utils    Created program 
* -------------------------------------------------------------------------- 
* 05/27/1997  Richard A. Schummer     Utils    Added the timestamp decoder 
* -------------------------------------------------------------------------- 
* 06/10/2000  Richard A. Schummer     Utils    Cleanup and documentation,
*                                              name changes, ObjectTypes
*                                              description, added metadata
*                                              record number
* -------------------------------------------------------------------------- 
*
****************************************************************************
 
#INCLUDE FoxPro.h

* Modify these DEFINEs to match your development environment
#DEFINE  ccOUTPUT_REPORT  "RASPrintFRX01.frx"
#DEFINE  ccPROJLIST_LIB   "cMeta.vcx"

PRIVATE pcVersion                      && Application version number
LOCAL   lcSelectedCursor               && Previously selected cursor
LOCAL   lcProjectFile                  && Project file selected by user
LOCAL   lcFrxFilename                  && Report Form metadata table
LOCAL   loMetaDecode                   && Object reference to Metadata Decoder
LOCAL   lcOldClassLib                  && Retain the classlib SETting for reset

pcVersion        = "2.0.1"
lcFrxFilename    = GETFILE("FRX")
lcSelectedCursor = SELECT()

IF EMPTY(lcFrxFilename)  OR  'Untitled' $ lcFrxFilename
   RETURN .F.                          && Canceled out, do not run prog
ELSE
   IF USED("FrxData")
      USE IN FrxData
   ENDIF
     
   USE (lcFrxFilename) EXCLUSIVE IN 0 ALIAS FrxData
   SELECT FrxData
		
   lcFrxFilename = ALLTRIM(LOWER(FULLPATH(DBF())))
ENDIF

* Save old classlib setting, create reference to the timestamp decoder logic
lcOldClassLib = SET("CLASSLIB")
SET CLASSLIB TO ccPROJLIST_LIB ADDITIVE
loMetaDecode  = CREATEOBJECT("ctrMetaDecode")

* Create the cursor of report objects to join to the report metadata
DO ReportObjectCursor

* Create a table from the opened Report Form because the 
* Methods memo will have some carriage returns inserted between
* different methods.
SELECT *, ;
       PADR(loMetaDecode.TimeStamp2Date(timestamp),18) AS cTimeStamp, ;
       curFRXObjects.cDescript AS cDescript2, ;
       RECNO() AS nRecNo ;
   FROM FrxData LEFT OUTER JOIN curFRXObjects ;
        ON  FrxData.ObjType = curFRXObjects.nObjType ;
   WHERE !EMPTY(Expr) ;
   ORDER BY vpos, hpos ;
   INTO CURSOR FrxDataWT

REPORT FORM ccOUTPUT_REPORT NOCONSOLE PREVIEW

* Cannot run the following code because of a bug in the preview mode in VFP 5.0
* (fixed in 5.0a)
* There is an automatic NOWAIT issuesed in the REPORT FORM so the cursor
* is destroyed and the report cannot be viewed past page 1 <g>.
USE IN FrxData
USE IN FrxDataWt
USE IN curFRXObjects

SELECT (lcSelectedCursor)

loMetaDecode.Release()

SET CLASSLIB TO &lcOldClassLib

RETURN


****************************************************************************
*  PROCEDURE NAME: ReportObjectCursor()
*  DEVELOPED BY:   RAS 10-Jun-2000
*
*  PROCEDURE DESCRIPTION: 
*     This method was developed to create a cursor of all the report
*     object types.
* 
*  PARAMETERS:
*     INPUT PARAMETERS:
*        None
*
*     OUTPUT PARAMETERS:
*        None
*
****************************************************************************
PROCEDURE ReportObjectCursor()

* Create a cursor filled with the report object types
* This will need to be modified if Microsoft ever decides
* to improve the Report Designer <g>.
CREATE CURSOR curFRXObjects ;
   (nObjType  N(2), ;
    cDescript C(20))
    
SCATTER MEMVAR

* Populate the cursor with known object types
m.nObjType = 1
m.cDescript = "Report"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 2
m.cDescript = "Workarea"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 3
m.cDescript = "Index"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 4
m.cDescript = "Relation"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 5
m.cDescript = "Text"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 6
m.cDescript = "Line"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 7
m.cDescript = "Box"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 8
m.cDescript = "Report Field"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 9
m.cDescript = "Band Information"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 10
m.cDescript = "Group"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 17
m.cDescript = "Picture"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 18
m.cDescript = "Variable"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 21
m.cDescript = "Printer Driver Setup"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 25
m.cDescript = "Data Environment"
INSERT INTO curFRXObjects FROM MEMVAR

m.nObjType = 28
m.cDescript = "Cursor Object"
INSERT INTO curFRXObjects FROM MEMVAR

RETURN

ENDPROC

*: EOF :*