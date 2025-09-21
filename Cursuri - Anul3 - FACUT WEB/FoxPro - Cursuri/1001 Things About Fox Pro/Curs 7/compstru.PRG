**********************************************************************
* Program....: CompStru
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Compares the structure of two tables
**********************************************************************
LPARAMETERS tcFile1, tcFile2
LOCAL ARRAY laFields[1]
LOCAL lnSelect, lnCnt, lcFile, llRetVal 
*** Did we get two parameters
IF NOT ( ( VARTYPE( tcFile1 ) = "C" AND ! EMPTY( tcFile1 ) ) ;
            AND ( VARTYPE( tcFile2 ) = "C" AND ! EMPTY( tcFile2 ) ) )
    ERROR "9000: Must pass two valid file names to CompStru()"
    RETURN .F.
ENDIF
*** Check Parameters to see if the files specified exist
IF NOT ( FILE( tcFile1 ) AND FILE ( tcFile2 ) )
    ERROR "9000: Must pass two valid file names to CompStru()"
    RETURN .F.
ENDIF
*** Now make sure they are both usable tables
*** (ISDBF() is a function in this program)
IF ! ISDBF( tcFile1 )
    ERROR "9000: File " + tcFile1 + " is not a usable FoxPro Table"
    RETURN .F.
ENDIF
IF ! ISDBF( tcFile2 )
    ERROR "9000: File " + tcFile2 + " is not a usable FoxPro Table"
    RETURN .F.
ENDIF
*** Save current work area
lnSelect = SELECT()
SELECT 0
*** Create a temporary cursor for comparing structures
CREATE CURSOR tmpstru ( ;
    fname C(10), ftype C(1), flen N(3,0), fdec N(3,0), fnul L(1) )
*** Open the files to compare and get their structures into the cursor
FOR lnCnt = 1 TO 2
    lcFile = ("tcFile" + PADL(lnCnt,1))
    USE (&lcFile) AGAIN IN 0 SHARED ALIAS TestFile
    AFIELDS( laFields, 'TestFile' )
    APPEND FROM ARRAY laFields
    USE IN TestFile
NEXT
*** Now see if the fields are identical
SELECT *, COUNT(*) cnt ;
  FROM tmpstru ;
  GROUP BY fname, ftype, flen, fdec, fnul ;
  HAVING cnt # 2 ;
  INTO ARRAY junk
*** Tidy up and Return Logical T/F if structure is identical
llRetVal = (_TALLY = 0)
SELECT (lnSelect)
USE IN tmpstru
RETURN llRetVal

********************************************************************
***  Check to see if a file can be opened as a table
********************************************************************
FUNCTION ISDBF( tcFile )
LOCAL lcErrWas, llRetVal
*** Disable Error handling temporarily
lcErrWas = ON("ERROR")
ON ERROR *
*** Open the specified file as a DBF
USE (tcFile) IN 0 AGAIN ALIAS testopen
*** If successful it WAS a valid table
IF USED( 'TestOpen' )
    llRetVal = .T.
    USE IN TestOpen
ENDIF
*** Restore Error Handling and Work
ON ERROR &lcErrWas
RETURN llRetVal
