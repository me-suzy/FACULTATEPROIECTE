LPARAMETERS tnLoopCount

LOCAL lcOldSafety, ;
      lcOldTalk, ;
      lcOldTalkWindow, ;
      lcOldExclusive, ;
      loConn AS ADODB.Connection, ;
      loRS, ;
      lcSql

IF VARTYPE(tnLoopCount) # "N"
   tnLoopCount = 1000
ENDIF

lcOldSafety     = SET("Safety")
lcOldTalk       = SET("Talk")
lcOldTalkWindow = SET("Talk", 1)
lcOldExclusive  = SET("Exclusive")

SET EXCLUSIVE ON
SET SAFETY OFF

OPEN DATABASE RandomTesting
SET DATABASE TO RandomTesting

IF INDBC("Random", "TABLE")
   DROP TABLE random 
ENDIF

CREATE TABLE random  ;
   (iKey i, ;
    cCharacter c(30), ;
    cHyperLink c(40), ;
    cMailTo c(40), ;
    yCurrency y, ;
    mMemo m, ;
    lLogical l, ;
    dDate d, ;
    tDateTime t, ;
    nNumeric n(13,3))

INDEX ON cCharacter TAG CharIndex ADDITIVE
INDEX ON yCurrency  TAG CurrIndex ADDITIVE

USE IN (SELECT("Random"))
SET EXCLUSIVE OFF
USE random IN 0 SHARED
SELECT random

SCATTER MEMVAR MEMO

lcTruth      = "VFP Rocks "
m.iKey       = 0

FOR i = 1 TO tnLoopCount
   IF m.iKey > 0 AND MOD(m.iKey, 100) = 0
      WAIT WINDOW "Processed " + TRANSFORM(i) + " of " + ;
                  TRANSFORM(tnLoopCount) + "..." NOWAIT NOCLEAR
   ENDIF
   
   m.iKey       = m.iKey + 1

   DO CASE 
      CASE MOD(m.iKey, 4) = 1
         m.cCharacter = "Geeks and Gurus"
         m.cHyperLink = "http://www.GeeksAndGurus.com"
         m.cMailTo    = "RASchummer@GeeksAndGurus.com"
      CASE MOD(m.iKey, 4) = 2
         m.cCharacter = "Tightline Computers"
         m.cHyperLink = ""
         m.cMailTo    = "AndyKr@CompuServe.com"
      CASE MOD(m.iKey, 4) = 3
         m.cCharacter = "Steve Dingle Solutions"
         m.cHyperLink = "http://www.SteveDingle.com"
         m.cMailTo    = "Steve@CompuServe.com"
      CASE MOD(m.iKey, 4) = 0
         m.cCharacter = "Hentzenwerke Publishing"
         m.cHyperLink = "http://www.hentzenwerke.com"
         m.cMailTo    = "Whil@Hentzenwerke.com"
   ENDCASE

   m.yCurrency  = NTOM(m.iKey * 3 + (INT(RAND()*100)/100))
   m.mMemo      = REPLICATE(lcTruth, RAND()* 10)
   m.lLogical   = IIF(MOD(m.iKey, 2) = 0, .F., .T.)
   m.dDate      = DATE() + m.iKey
   m.tDateTime  = DATETIME() + (RAND() * (100000 + m.iKey))
   m.nNumeric   = m.iKey + RAND()

   INSERT INTO Random FROM MEMVAR
ENDFOR

GO TOP

SET TALK ON 
SET TALK WINDOW 

WAIT WINDOW "Exporting random data to common cursor..." NOWAIT NOCLEAR
SELECT * ;
   FROM random ;
   ORDER BY yCurrency DESC ;
   INTO CURSOR curExport

SET TALK OFF
SET TALK NOWINDOW
USE IN (SELECT("random"))
CLOSE DATABASES

* Test Case #1 - FoxPro free table
WAIT WINDOW "Exporting random data to Fox2x..." NOWAIT NOCLEAR
lnStartSecondsFox2x = SECONDS()
COPY TO RandFox.dbf WITH production TYPE FOX2X
lnEndSecondsFox2x   = SECONDS()

* Test Case #2 - ADO
WAIT WINDOW "Exporting random data to ADO..." NOWAIT NOCLEAR

loConn            = .NULL.
loRS              = .NULL.
lnStartSecondsADO = SECONDS()

loConn = CREATEOBJECT("ADODB.Connection")
loConn.ConnectionString = "provider=vfpoledb.1;data source=.\RandomTesting.dbc"
loConn.Open()

loRS              = loConn.Execute("select * from Random")

lnEndSecondsADO   = SECONDS()

* Test Case #3 - XML
WAIT WINDOW "Exporting random data to XML..." NOWAIT NOCLEAR
lnStartSecondsXML = SECONDS()
CURSORTOXML("curExport", "Random.XML", 1, 1+4+512, 0)
lnEndSecondsXML   = SECONDS()

* Output timings
? " "
? "Test records created is", TRANSFORM(tnLoopCount)
? "FoxPro 2.x table creation in", TRANSFORM(lnEndSecondsFox2x - lnStartSecondsFox2x)
? "ADO recordset creation in", TRANSFORM(lnEndSecondsADO - lnStartSecondsADO)
? "XML file creation in", TRANSFORM(lnEndSecondsXML - lnStartSecondsXML)

SET SAFETY &lcOldSafety
SET TALK &lcOldTalk
SET TALK &lcOldTalkWindow
SET EXCLUSIVE &lcOldExclusive

WAIT CLEAR

RETURN

*: EOF :*