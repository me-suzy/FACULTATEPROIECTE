**********************************************************************
* Program....: MC.PRG
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: This program was originally devised and written by Steven Black
* ...........: while we were all working together on a major project in early 1999.
* ...........: We would like to acknowledge this, and all Steven's contributions,
* ...........: and to thank him for his willingness to share his ingenuity
* ...........: and knowledge with the rest of us.
* Syntax.....: MC( <classname>[,<methodname>]) or
* ...........: DO MC WITH <classname>[,<methodname>]
**********************************************************************
LPARAMETERS tcClass, tcMethod
LOCAL lcClass, lnSelect, lcOrigDir, lcOldError, lcLoc, lcMethod

*** Must pass a class name at least!
IF VARTYPE( tcClass ) # "C" OR EMPTY( tcClass )
    RETURN
ELSE
    *** Get the Class name
    lcClass = LOWER( ALLTRIM( tcClass ))
ENDIF

*** Save Current Work Area
lnSelect= SELECT()

*** Open VCXList Table (Note: LOCFILE() adds the chosen location to the
*** Current VFP Search Path - which is useful in this scenario but may give
*** odd results if you have class libraries named the same in different
*** locations!)
IF ! USED("VcxList")
    *** Disable Error handling temporarily
    lcOldError = ON("ERROR")
    ON ERROR *
    lcLoc = ""
    *** Locate the VCXList Table to use
    lcLoc = LOCFILE( "VCXList", "DBF", "Where is" )
    *** Restore Error handling and check result
    ON ERROR &lcOldError
    IF ! EMPTY( lcLoc ) AND 'vcxlist' $ LOWER( lcLoc )
        *** OK - Open the Table
        USE (lcLoc) AGAIN SHARED IN 0
    ELSE
        *** Not located - Abort
        WAIT WINDOW "Cannot locate VCXList.DBF - Aborting"
        RETURN
    ENDIF
ENDIF
*** Select VCXList
SELECT VCXList

*** Make VCXList Location current default because the
*** classlibs are saved with paths which are relative
*** to the project's location (and hence to VCXList)!
lcOrigDir = FULLPATH( CURDIR() )
SET DEFAULT TO JUSTPATH( DBF() )

*** Did we get a method name too?
IF VARTYPE(tcMethod) = "C" AND ! EMPTY( tcMethod)
    lcMethod= " Method " + tcMethod
ELSE
    lcMethod= ''
ENDIF

*** Find the Required Class
LOCATE FOR ALLTRIM(cclasname) == lcClass
IF FOUND()
    *** Show the VCX name
    WAIT WINDOW NOWAIT 'Opening Class Libray: ' + ALLTRIM(cClasLib)
    MODI CLASS (ALLTRIM(cClasName)) of (ALLTRIM(cClasLib)) &lcMethod NOWAIT
ELSE
    WAIT WINDOW "Class " + lcClass + " Not Found" NOWAIT
ENDIF

*** Restore Original Location and Work Area
SET DEFAULT TO (lcOrigDir)
SELECT (lnSelect)
