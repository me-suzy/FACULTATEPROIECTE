****************************************************************************
*
*  PROGRAM NAME: ReportWalkThru.prg
*
*  AUTHOR: Richard A. Schummer,         May 1997
*
*  COPYRIGHT © 1997   All Rights Reserved.
*     Richard A. Schummer
*     42759 Flis Dr.  
*     Sterling Heights, MI  48314-2850
*     RSchummer@CompuServe.com
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
*     DO ReportWalkThru.prg
*
*  SAMPLE CALL:
*     DO ReportWalkThru.prg
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
*     1) Handle walking up the class hierarchy for objects with inherited 
*        code.
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
*
****************************************************************************

#INCLUDE FoxPro.h

#DEFINE  ccOUTPUT_REPORT  "ReportWalkThru01.frx"
#DEFINE  ccPROJLIST_LIB   "cMeta.vcx"

LOCAL lcSelectedCursor                 && Previously selected cursor
LOCAL lcProjectFile                    && Project file selected by user
LOCAL lcFrxFilename                    && Report Form metadata table
LOCAL loMetaDecode                     && Object reference to Metadata Decoder
LOCAL lcOldClassLib                    && Retain the classlib SETting for reset

lcFrxFilename    = GETFILE("FRX")
lcSelectedCursor = SELECT()

DO CASE
	CASE EMPTY(lcFrxFilename)  OR  'Untitled' $ lcFrxFilename
		RETURN .F.                       && Canceled out, do not run prog
	OTHERWISE
      IF USED("FrxData")
         USE IN FrxData
      ENDIF
      
		USE (lcFrxFilename) EXCLUSIVE IN 0 ALIAS FrxData
		SELECT FrxData
		
		lcFrxFilename = ALLTRIM(LOWER(FULLPATH(DBF())))
ENDCASE

* Save old classlib setting, create reference to the timestamp decoder logic
lcOldClassLib = SET("CLASSLIB")

SET CLASSLIB TO ccPROJLIST_LIB ADDITIVE

loMetaDecode  = CREATEOBJECT("ctrMetaDecode")

* Create a table from the opened Report Form because the 
* Methods memo will have some carriage returns inserted between
* different methods.
SELECT *, ;
       PADR(loMetaDecode.TimeStamp2Date(timestamp),18) AS cTimeStamp ;
   FROM FrxData ;
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

SELECT (lcSelectedCursor)

loMetaDecode.Release()

SET CLASSLIB TO &lcOldClassLib

RETURN

*: EOF :*