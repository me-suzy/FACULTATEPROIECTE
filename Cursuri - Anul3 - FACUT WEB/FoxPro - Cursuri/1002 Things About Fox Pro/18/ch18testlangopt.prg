LPARAMETERS toCalling

SET COVERAGE TO ch18TestLangOptCoveraged.txt

RELEASE goApp

PUBLIC  goApp
PRIVATE pnCounter
LOCAL   llReturnResult, ;
        lnOldLanguageOpts, ;
        lcDebugOutSavedFile

lcDebugOutSavedFile = GETFILE("TXT", "DebugOut")

IF EMPTY(lcDebugOutSavedFile)
   ACTIVATE WINDOW "Debug Output"
ELSE
   SET DEBUGOUT TO (lcDebugOutSavedFile)
ENDIF

lnOldLanguageOpts    = _vfp.LanguageOptions
_vfp.LanguageOptions = 1

SET CLASSLIB TO Ch18TestLangOpt.vcx ADDITIVE

DEBUGOUT " "
DEBUGOUT "Class undeclared variables"
loBusinessObject = CREATEOBJECT("cusBusiness")

DEBUGOUT " "
DEBUGOUT "Program undeclared variables"
lcTempPath       = "C:\Temp"
llResult         = .T.

IF .F.
   * Will not show in the list of undeclared variables
   llShouldNotShowInList = .F.
ELSE
   llShouldShowInList    = .T.
ENDIF

DEBUGOUT " "
DEBUGOUT "Stored Procedure undeclared variables"
OPEN DATABASE Ch18TestLangOpt
lcSecondVarOnLine = SPACE(0)
lcRuleReturn      = MyRule(lcSecondVarOnLine)

CREATE CURSOR curCh18LangOptRpt (cName C(30), cCompany C(40))

DEBUGOUT " "
DEBUGOUT "Program undeclared m-dot variables"
m.cName    = "Marcia Akins"
m.cCompany = "Tightline"
INSERT INTO curCh18LangOptRpt FROM MEMVAR

m.cName    = "Andy Kramek"
m.cCompany = "Tightline"
INSERT INTO curCh18LangOptRpt FROM MEMVAR

m.cName    = "Rick Schummer"
m.cCompany = "Geeks and Gurus"
INSERT INTO curCh18LangOptRpt FROM MEMVAR

m.cName    = "Steve Dingle"
m.cCompany = "Steve Dingle Solutions"
INSERT INTO curCh18LangOptRpt FROM MEMVAR

m.cName    = "Whil Hentzen"
m.cCompany = "Hentzenwerke Publishing"
INSERT INTO curCh18LangOptRpt FROM MEMVAR

DEBUGOUT " "
DEBUGOUT "Form undeclared variables"
DO FORM Ch18TestLangOpt.scx TO lcFilename

DEBUGOUT " "
DEBUGOUT "Report and Label undeclared variables"
REPORT FORM Ch18TestLangOpt.frx NOCONSOLE PREVIEW
LABEL FORM  Ch18TestLangOpt.lbx NOCONSOLE PREVIEW

DEBUGOUT " "
DEBUGOUT "Menu undeclared variables"
DO Ch18TestLangOpt.mpr

RELEASE goApp
RELEASE loBusinessObject
SET SYSMENU TO DEFAULT
SET DEBUGOUT TO

USE IN (SELECT("curCH18LangOptRpt"))

_vfp.LanguageOptions = lnOldLanguageOpts

SET COVERAGE TO

RETURN llResult