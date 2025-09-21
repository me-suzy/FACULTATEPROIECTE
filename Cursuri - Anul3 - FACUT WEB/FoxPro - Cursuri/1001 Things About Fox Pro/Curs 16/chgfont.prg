* Change Font code
LPARAMETERS tcReportMetadata, tcFontName

IF PCOUNT() < 1
   MESSAGEBOX("No report name passed to " + PROGRAM() + ".", 0+16, _screen.Caption)
   RETURN
ENDIF

IF PCOUNT() < 2
   tcFontName = GETFONT()
   
   IF EMPTY(tcFontName)
      RETURN
   ELSE
       * Need to parse off the name of the font
       tcFontName = substr(tcFontName, 1, ATC(",", tcFontName)-1)
   ENDIF
ENDIF

IF VARTYPE(tcReportMetadata) != "C"
   MESSAGEBOX("Report name passed to " + PROGRAM() + "is not character.", 0+16, _screen.Caption)
   RETURN
ENDIF

IF VARTYPE(tcFontName) != "C"
   MESSAGEBOX("Font name passed to " + PROGRAM() + "is not character.", 0+16, _screen.Caption)
   RETURN
ENDIF

tcReportMetaData = FORCEEXT(ALLTRIM(tcReportMetaData), "FRX")

IF !FILE(tcReportMetaData)
   MESSAGEBOX("Report passed to " + PROGRAM() + "is not found.", 0+16, _screen.Caption)
   RETURN
ENDIF

DIMENSION laFonts[1]

llFontFound = AFONT(laFonts, tcFontName)

IF !llFontFound
   MESSAGEBOX("Font namr passed to " + PROGRAM() + "is not available on this system.", 0+16, _screen.Caption)
   RETURN
ENDIF

tcFontName = ALLTRIM(tcFontName)

* Now that we checked, rechecked and checked again, lets get to changing the font
USE (tcReportMetadata) EXCLUSIVE IN 0 ALIAS curFontChanger

SELECT curFontChanger

SCAN
   IF !EMPTY(FontFace)
      REPLACE FontFace WITH tcFontName IN curFontChanger
   ENDIF 
ENDSCAN

USE IN curFontChanger

*: EOF :*

