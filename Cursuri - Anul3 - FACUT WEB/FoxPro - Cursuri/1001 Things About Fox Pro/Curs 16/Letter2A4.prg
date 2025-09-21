LOCAL lcOldSelect                      && Saves of the current workarea
LOCAL lnCounter                        && FOR loop counter
LOCAL laFRX                            && Array of reports

lcOldSelect = SELECT()

SELECT 0
=ADIR( laFRX, '*.FRX')

FOR lnCounter = 1 TO ALEN(laFRX, 1) STEP 1
   USE (laFRX[lnCounter, 1]) IN 0 EXCLUSIVE

   * Change the setting in the first record from Letter to A4
   REPLACE Expr WITH SUBSTR(Expr, 1, AT("PAPERSIZE", Expr) - 2) + ;
                     "PAPERSIZE=9" + ;
                     SUBSTR( Expr, AT("PAPERSIZE", Expr) + 12), ;
                     Width WITH 77433.000

   LOCATE FOR TRIM(Expr) = 'DATE()'

   IF FOUND()
      REPLACE HPos WITH 1562.5, Width WITH 8854.167
   ENDIF

   LOCATE FOR TRIM(Expr) = '"Page "'

   IF FOUND()
      REPLACE HPos WITH 66250.000
   ENDIF

   LOCATE FOR TRIM(Expr) = "_PAGENO"

   IF FOUND()
      REPLACE HPos WITH 70416.667
   ENDIF

   USE
ENDFOR

SELECT (lcOldSelect)

RETURN