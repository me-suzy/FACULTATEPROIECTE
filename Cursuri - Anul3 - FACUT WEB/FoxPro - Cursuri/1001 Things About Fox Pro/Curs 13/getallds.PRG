**********************************************************************
* Program....: GetAllDS.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Populate array with all open datasessions
* ...........: Pass target array by reference to this function
* ...........:     DIMENSION aDSList[1]
* ...........:     lnNumSess = GetAllDs( @aDSList )
**********************************************************************
LPARAMETERS taSessions
EXTERNAL ARRAY taSessions
LOCAL lnCurDatasession, lnSessions
*** Initialize Counter
lnSessions = 0
*** Loop through Forms Collection
FOR EACH oForm IN _SCREEN.FORMS
    *** Have we got this session already?
    IF ASCAN( taSessions, oForm.DatasessionID) = 0
        *** If not, add it to the array
        lnSessions = lnSessions + 1
        DIMENSION taSessions[lnSessions,2]
        taSessions[lnSessions,1] = oForm.DatasessionID
        taSessions[lnSessions,2] = oForm.Name
    ENDIF
NEXT
*** Return the number of sessions
RETURN lnSessions
