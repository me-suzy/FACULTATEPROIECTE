****************************************************************************
*
*  PROGRAM NAME: RASPrintCX.prg (formerly FormWalkThru.prg)
*
*  AUTHOR: Richard A. Schummer, December 1996
*
*  COPYRIGHT © 1996-2002   All Rights Reserved.
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
*     This program creates a listing of properties, methods and other settingd
*     from a VFP Form file (.SCX) or Visual Class Library file (.VCX) for a 
*     code walk through.  Since the code for the different objects are stored
*     in a VFP metadata table it is difficult to review the code.  This is an 
*     alternative to the VFP Class Browser which outputs the same information
*     in object order.  This program reports the object information by container,
*     then in object name order.
*
*     For instance:
*       	Form Level                                  Dataenvironment 
*       	Form Level                                  Frmbase1 
*       	Dataenvironment                             Cursor1  
*       	Frmbase1                                    pgfAddress  
*       	Frmbase1.pgfAddress.Page1                   Shpbase1 
*       	Frmbase1.pgfAddress.Page1                   cboCphonecat 
*       	Frmbase1.pgfAddress.Page1                   chkLchristmas 
*       	Frmbase1.pgfAddress.Page1                   chkLfamily 
*       	Frmbase1.pgfAddress.Page1                   chkLroadrally 
*       	Frmbase1.pgfAddress.Page1                   edtMcomment
*       	Frmbase1.pgfAddress.Page1                   lblCaddress1  
*       	Frmbase1.pgfAddress.Page1                   lblCaddress2 
*       	Frmbase1.pgfAddress.Page1                   txtCaddress1 
*       	Frmbase1.pgfAddress.Page1                   txtCaddress2
*       	Frmbase1.pgfAddress.Page1                   txtCcity 
*       	Frmbase1.pgfAddress.Page1                   txtCcountry  
*       	Frmbase1.pgfAddress.Page1                   txtCfirstname
*       	Frmbase1.pgfAddress.Page1                   txtTupdated 
*       	Frmbase1.pgfAddress.Page2                   Grid1 
*       	Frmbase1.pgfAddress.Page2.Grid1.Column1     Header1 
*       	Frmbase1.pgfAddress.Page2.Grid1.Column1     Text1 
*       	Frmbase1.pgfAddress.Page2.Grid1.Column2     Header1 
*       	Frmbase1.pgfAddress.Page2.Grid1.Column2     Text1 
*
*     Enhancement made June 2000 allows developers to select a class
*     from a library and just print out that code.
*
*  CALLED BY: 
*     DO RASPrintCX.prg
*
*  SAMPLE CALL:
*     DO RASPrintCX.prg
*
*  INPUT PARAMETERS: 
*     None
*
*  OUTPUT PARAMETERS:
*     None
* 
*  TABLES ACCESSED: 
*     Only the metadata table represented by the lcScxVcxFilename variable (selected)
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
*     Visual FoxPro 6.0 or higher
*        (If running prior versions, include FoxTools for JUSTEXT(),
*         and write code to work around the new ALINE() calls) 
* 
****************************************************************************
*
*                           C H A N G E    L O G                            
*
*   Date                SE            System           Description
* ----------  ----------------------  -------  ----------------------------- 
* 12/17/1996  Richard A. Schummer     Utils    Created program 
* -------------------------------------------------------------------------- 
* 05/14/1997  Richard A. Schummer     Utils    Changed name of program 
* -------------------------------------------------------------------------- 
* 05/27/1997  Richard A. Schummer     Utils    Added the timestamp decoder 
* -------------------------------------------------------------------------- 
* 06/10/2000  Richard A. Schummer     Utils    Select specific class, tab to
*                                              space conversion, line
*                                              numbers in properties/code,
*                                              added metadata record number,
*                                              renamed from FormWalkThru
* -------------------------------------------------------------------------- 
*
****************************************************************************
 
#INCLUDE FoxPro.h

* Modify these DEFINEs to match your development environment
#DEFINE  cnPADDING        75
#DEFINE  ccOUTPUT_REPORT  "RASPrintCX01.frx"
#DEFINE  ccPROJLIST_LIB   "cMeta.vcx"
#DEFINE  ccSPACES         SPACE(3)

PRIVATE pcVersion                      && Application version number
LOCAL   lnRecordsProcessed             && Number of metadata files PACKed
LOCAL   lcSelectedCursor               && Previously selected cursor
LOCAL   lcProjectFile                  && Project file selected by user
LOCAL   lcScxVcxFilename               && Form or Visual Class Library
LOCAL   loMetaDecode                   && Object reference to Metadata Decoder
LOCAL   lcOldClassLib                  && Retain the classlib SETting for reset
LOCAL   lcOldSafety                    && Retain the SAFTEY SETting for reset
LOCAL   lcSpecificClass                && Specific class in a library to print
LOCAL   lcSQLWhere                     && Additional SQL Where code for the specific class
LOCAL   llCodeLineNumbers              && Indicates if line numbers are printed in the method code
LOCAL   lnLines                        && Number of lines in a given memo field
LOCAL   lnCount                        && Loop counter
LOCAL   lmAlteredMemo                  && Alter contents of a given memo field

pcVersion         = "2.0.1"
lcScxVcxFilename  = GETFILE("VCX;SCX")
lcSelectedCursor  = SELECT()
lcSpecificClass   = SPACE(0)
lcSQLWhere        = SPACE(0)   
llCodeLineNumbers = .T.

DIMENSION laClasses[1]                 && Used for getting a specific class in a library
DIMENSION laMemoContents[1]

IF EMPTY(lcScxVcxFilename)  OR  'Untitled' $ lcScxVcxFilename
   * Canceled out, do not run prog
   RETURN .F.
ELSE
   * Allow developer to select one class if class library
   IF UPPER(JUSTEXT(lcScxVcxFilename)) == "VCX"
      WAIT WINDOW "Just cancel this dialog to get all class in the selected library..." NOWAIT NOCLEAR
      
      IF !AGETCLASS(laClasses, lcScxVcxFilename)
         * Continue on with code and get all classes from a library
      ELSE
         * In case the developer selects another file via GetClass dialog
         lcScxVcxFilename = laClasses[1]
         lcSpecificClass  = LOWER(laClasses[2])
         lcSQLWhere       = [ WHERE LOWER(ObjName) == "] + lcSpecificClass + ["] + ;
                            [ OR LOWER(Parent) == "] + lcSpecificClass + ["] + ;
                            [ OR LOWER(SUBSTR(Parent, 1, AT(".", Parent)-1)) == "] + lcSpecificClass + ["]
      ENDIF
         
      WAIT CLEAR
   ENDIF

   IF USED("ScxVcx")
      USE IN ScxVcx
   ENDIF
      
   USE (lcScxVcxFilename) SHARED IN 0 ALIAS ScxVcx
   SELECT ScxVcx

   lcScxVcxFilename = ALLTRIM(LOWER(FULLPATH(DBF())))
ENDIF

* Save Safety setting so table created can be overwritten
lcOldSafety   = SET("SAFETY")
SET SAFETY OFF

* Save old classlib setting, create reference to the timestamp decoder logic
lcOldClassLib = SET("CLASSLIB")
SET CLASSLIB TO ccPROJLIST_LIB ADDITIVE

loMetaDecode  = CREATEOBJECT("ctrMetaDecode")

* Create a table from the opened Visual Class or Form because the 
* Methods memo will have some carriage returns inserted between
* different methods.
SELECT *, ;
       PADR(Parent, cnPADDING) AS cParent, ;
       PADR(ObjName, cnPADDING) AS cObjectName, ;
       PADR(loMetaDecode.TimeStamp2Date(timestamp),18) AS cTimeStamp, ;
       RECNO() AS nRecNo ;
  FROM ScxVcx ;
  &lcSQLWhere ;
  ORDER BY cParent, cObjectName ;
  INTO TABLE SYS(2023)+"\ScxVcxWt.dbf"
  
SELECT ScxVcxWt

* Place a blank line between each of the different methods in the memo field
REPLACE ALL Methods WITH STRTRAN(Methods, "ENDPROC", "ENDPROC"+CHR(13))

* Replace TAB character with spaces (per constant at beginning of program
REPLACE ALL Methods WITH STRTRAN(Methods, CHR(9), ccSPACES)

* Process through key memo fields to handle some formatting issues
SCAN
   *** Method Code ***
   IF !EMPTY(Methods) AND llCodeLineNumbers
      lmAlteredMemo = SPACE(0)
      lnLines       = ALINES(laMemoContents, Methods)
      lnDigits      = LEN(ALLTRIM(STR(lnLines)))
      
      FOR lnCount = 1 to lnLines-1
         lmAlteredMemo = lmAlteredMemo + ;
                         PADL(ALLTRIM(STR(lnCount)), lnDigits, SPACE(1)) + ". " + ;
                         laMemoContents[lnCount] + ;
                         CHR(13)
      ENDFOR

      * Handle extra blank line at the end of code segment if it exists
      IF !EMPTY(laMemoContents[lnLines])
         lmAlteredMemo = lmAlteredMemo + ;
                         PADL(ALLTRIM(STR(lnLines)), lnDigits, SPACE(1)) + ". " + ;
                         laMemoContents[lnLines]
      ENDIF
      
      REPLACE Methods WITH lmAlteredMemo
   ENDIF

   *** Protected Properties/Methods ***
   IF !EMPTY(Protected) AND llCodeLineNumbers
      lmAlteredMemo = SPACE(0)
      lnLines       = ALINES(laMemoContents, Protected)
      lnDigits      = LEN(ALLTRIM(STR(lnLines)))
      
      FOR lnCount = 1 to lnLines
         lmAlteredMemo = lmAlteredMemo + ;
                         PADL(ALLTRIM(STR(lnCount)), lnDigits, SPACE(1)) + ". " + ;
                         laMemoContents[lnCount] + ;
                         IIF(lnCount!=lnLines, CHR(13), "")
      ENDFOR
      
      REPLACE Protected WITH lmAlteredMemo
   ENDIF

   *** Property/Method Descriptions ***
   IF !EMPTY(Reserved3)
      lmAlteredMemo = SPACE(0)
      lnLines       = ALINES(laMemoContents, Reserved3)
      
      FOR lnCount = 1 to lnLines
         lmAlteredMemo = lmAlteredMemo + ;
                         ALLTRIM(STR(lnCount)) + ". " + ;
                         STUFF(laMemoContents[lnCount], AT(SPACE(1), laMemoContents[lnCount]), 1, " -- ") + ;
                         IIF(lnCount!=lnLines, CHR(13), "")
      ENDFOR
      
      REPLACE Reserved3 WITH lmAlteredMemo
   ENDIF
ENDSCAN

* Preview the report
REPORT FORM ccOUTPUT_REPORT NOCONSOLE PREVIEW

* Cannot run the following code because of a bug in the preview mode in VFP 5.0
* There is an automatic NOWAIT issuesed in the REPORT FORM so the cursor
* is destroyed and the report cannot be viewed past page 1 <g>.
*
* Close all the workareas
USE IN ScxVcx
USE IN ScxVcxWt

* Delete temporary tables
DELETE FILE SYS(2023)+"\ScxVcxWt.dbf"
DELETE FILE SYS(2023)+"\ScxVcxWt.fpt"

SELECT (lcSelectedCursor)

loMetaDecode.Release()

SET CLASSLIB TO &lcOldClassLib
SET SAFETY &lcOldSafety

RETURN

*: EOF :*