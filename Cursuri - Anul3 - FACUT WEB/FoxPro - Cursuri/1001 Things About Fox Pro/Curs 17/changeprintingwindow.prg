LPARAMETER tcTitle, tcIcon, tcText

* VFP Window name of default printing window
#DEFINE ccWIN_PRINTING "Printing..."

* Define the local variables
LOCAL lcFont
LOCAL lnSize
LOCAL lcStyle
LOCAL lnTitle
LOCAL lnLeftBorder
LOCAL lnTopBorder
LOCAL lnHeight
LOCAL lnWidth

* Only change the window if it exists
IF WEXIST(ccWIN_PRINTING)
   IF EMPTY(WPARENT(ccWIN_PRINTING))
      lcFont       = WFONT( 1, ccWIN_PRINTING )
      lnSize       = WFONT( 2, ccWIN_PRINTING )
      lcStyle      = WFONT( 3, ccWIN_PRINTING )
      lnHeight     = FONTMETRIC(6, lcFont, lnSize, lcStyle)
      lnWidth      = FONTMETRIC(4, lcFont, lnSize, lcStyle) + ;
                     FONTMETRIC(1, lcFont, lnSize, lcStyle)
      lnLeftBorder = SYSMETRIC(3) / lnHeight
      lnTitle      = (SYSMETRIC(9)+2) / lnWidth
      lnTopBorder  = SYSMETRIC(4) / lnWidth
      
      DEFINE WINDOW CustomPrint ;
         FROM WLROW(ccWIN_PRINTING), WLCOL(ccWIN_PRINTING) ;
         SIZE WROWS(ccWIN_PRINTING) - lnTopBorder, ;
         WCOLS(ccWIN_PRINTING) - lnLeftBorder ;
         SYSTEM ;
         TITLE tcTitle ;
         MINIMIZE ZOOM FLOAT CLOSE ;
         ICON FILE (tcIcon) ;
         FONT lcFont, lnSize;
         STYLE lcStyle ;
         COLOR RGB(0, 0, 0, 192, 192, 192)
         
      DEFINE WINDOW CustomPrintReport ;
         FROM 0, 0 ;
         TO (WROWS(ccWIN_PRINTING) - lnTopBorder) / 3, ;
         WCOLS(ccWIN_PRINTING) - lnLeftBorder ;
         NONE ;
         FONT lcFont, lnSize;
         STYLE lcStyle ;
         COLOR RGB(0, 0, 0, 192, 192, 192) ;
         IN WINDOW CustomPrint
         
      ACTIVATE WINDOW CustomPrint
      ACTIVATE WINDOW ccWIN_PRINTING IN CustomPrint
      MOVE WINDOW ccWIN_PRINTING TO - (lnTopBorder + lnTitle), - lnLeftBorder
      ACTIVATE WINDOW CustomPrintReport
      @ 1, 1 SAY PADC(tcText, WCOLS("CustomPrintReport"))
   ENDIF
ENDIF

RETURN ""

*: EOF :*