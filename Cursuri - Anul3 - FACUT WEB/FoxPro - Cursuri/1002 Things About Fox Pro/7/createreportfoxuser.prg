LOCAL lcOldSafety, ;
      lcOldResource, ;
      lcOriginalResourceFile, ;
      lcReportsResourceFile

lcReportsResourceFile = ADDBS(LOWER(FULLPATH(CURDIR()))) + "ReportsFoxUser.dbf"
lcOldResource         = SET("Resource")
lcOldSafety           = SET("Safety")

* Will used the specified resource file or 
* will create a new one if one is not specified
SET RESOURCE ON
lcOriginalResourceFile = SYS(2005)
SET RESOURCE OFF
SET SAFETY OFF

USE (lcOriginalResourceFile) IN 0 SHARED ALIAS NotPureFoxUser
COPY TO (lcReportsResourceFile) ;
   FOR Id = "TTOOLBAR" AND ;
       INLIST(LOWER(Name), "report designer", "color palette", "layout", ;
                           "print preview", "report controls")

SET SAFETY &lcOldSafety
USE IN (SELECT("NotPureFoxUser"))

SET RESOURCE OFF
SET RESOURCE TO (lcReportsResourceFile)
SET RESOURCE ON

WAIT WINDOW "Modify the Print Preview Toolbar" NOWAIT NOCLEAR
SYS(1500, "_mvi_toolb", "_msm_view")

IF WEXIST("Print Preview")
   HIDE WINDOW "Print Preview"
ENDIF

MESSAGEBOX("Report resource file (" + lcReportsResourceFile + ") generated...", ;
           0 + 64, ;
           _screen.Caption)

WAIT CLEAR
QUIT

RETURN

*: EOF :*