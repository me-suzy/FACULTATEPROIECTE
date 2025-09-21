LPARAMETERS tlEmail

LOCAL lcOldExclusive, ;
      lcOldDeleted, ;
      lcOldProcedure, ;
      lnResult, ;
      ltNow, ;
      loIPMail, ;
      loPDF, ;
      lcFileName, ;
      lcOutputFile, ;
      lcSentMsg, ;
      llResult

#INCLUDE foxpro.h

lcOldExclusive = SET("Exclusive")
lcOldDeleted   = SET("Deleted")
lcOldProcedure = SET("Procedure")

SET EXCLUSIVE OFF
SET DELETED ON 

IF NOT tlEmail
   lnResult = MESSAGEBOX("Email option was not selected, is this ok?", ;
                         MB_YESNO + MB_ICONQUESTION, ;
                         _screen.Caption)
   
   IF lnResult = IDNO
      RETURN .F.
   ENDIF
ENDIF

SET PROCEDURE TO wwPDF ADDITIVE
SET PROCEDURE TO wwAPI ADDITIVE
SET PROCEDURE TO wwUtils ADDITIVE
SET PROCEDURE TO wwEval ADDITIVE
SET CLASSLIB  TO wwIPStuff ADDITIVE

OPEN DATABASE pdfsample
SET DATABASE TO pdfsample

IF NOT USED("curMailing")
   USE pdfsample!v_geekscontactlist IN 0 AGAIN ALIAS curMailing
ELSE
   REQUERY("curMailing")
ENDIF

IF NOT USED("curList")
   USE pdfsample!v_geekscontactlist IN 0 AGAIN ALIAS curList
ELSE
   REQUERY("curMailing")
ENDIF

IF NOT USED("EmailInfo")
   USE pdfsample!EmailInfo IN 0 AGAIN ALIAS EmailInfo
ENDIF

IF NOT USED("EmailHistory")
   USE pdfsample!EmailHistory IN 0 AGAIN ALIAS EmailHistory
ENDIF

ltNow    = DATETIME()
loIPMail = CREATEOBJECT('wwIPStuff')
loPDF    = CREATEOBJECT('wwPDF40')

SELECT curMailing

SCAN
   lcFileName   = ALLTRIM(curMailing.First_Name) + ;
                  ALLTRIM(curMailing.Last_Name) + ;
                  ALLTRIM(STR(curMailing.Contact_Id)) + ".pdf"
   lcOutputFile = ADDBS(SYS(2023)) + lcFileName

   * Generate the PDF file
   SELECT curList
   loPDF.PrintReport("ContactListing", lcOutputFile)

   loIPMail.cMailServer  = ALLTRIM(emailinfo.cMailServe)
   loIPMail.cSenderEmail = ALLTRIM(emailinfo.cSender)
   loIPMail.cSenderName  = ALLTRIM(emailinfo.cSenderName)

   loIPMail.cRecipient   = ALLTRIM(curMailing.Email_Name)
   loIPMail.cCCList      = ALLTRIM(emailinfo.cCcList)
   loIPMail.cBCCList     = ALLTRIM(emailinfo.cBccList)
   loIPMail.cSubject     = ALLTRIM(emailinfo.cSubject)
   loIPMail.cMessage     = ALLTRIM(emailinfo.cMessage) + ;
                           ALLTRIM(emailinfo.cSignature)

   * Here is where we attach the PDF file
   IF FILE(lcOutputFile)
      loIPMail.cAttachment  = lcOutputFile
   ENDIF

   * Set the content type to optional HTML (table driven)
   loIPMail.cContentType = ALLTRIM(emailinfo.cContentType)

   lcSentMsg = "To: " + loIPMail.cRecipient + ;
               CHR(13) + "From: " + loIPMail.cSenderEmail + ;
               IIF(EMPTY(loIPMail.cCCList), SPACE(0), CHR(13) + "CC: " + loIPMail.cCCList) + ;
               IIF(EMPTY(loIPMail.cBCCList), SPACE(0), CHR(13) + "BCC: " + loIPMail.cBCCList) + ;
               CHR(13) + "Subject: " + loIPMail.cSubject + ;
               CHR(13) + loIPMail.cMessage

   llResult = .T.

   * Only send the list of produced
   IF FILE(lcOutputFile)
      * Send only if passing parameter, allows testing
      * without sending the email
      IF tlEmail
            llResult = loIPMail.SendMail()
      ELSE
         llResult = .F.
      ENDIF
   ELSE
      llResult = .F.
   ENDIF

   IF !llResult
      WAIT WINDOW "No email message to " + loIPMail.cRecipient + " (" + loIPMail.cErrorMsg + ")" NOWAIT
      lcSentMsg = lcSentMsg + CHR(13) + CHR(13) + ;
                  IIF(tlEmail, "Intended to email", "Not intended to email") + CHR(13) + ;
                  "ERROR: " + loIPMail.cErrorMsg

      INSERT INTO emailhistory (tTimeStamp, lSentEmail, mMessage, cRecipient) ;
         VALUES (DATETIME(), .F., lcSentMsg, curMailing.Email_Name)
   ELSE
      WAIT WINDOW "Sent message to " + loIPMail.cRecipient NOWAIT
      lcSentMsg = lcSentMsg + CHR(13) + CHR(13) + "Message sent successfully"
      
      INSERT INTO emailhistory (tTimeStamp, lSentEmail, mMessage, cRecipient) ;
         VALUES (DATETIME(), .T., lcSentMsg, curMailing.Email_Name)
   ENDIF
ENDSCAN

loPDF    = .NULL.
loIPMail = .NULL.

USE IN (SELECT("curMailing"))
USE IN (SELECT("curList"))
USE IN (SELECT("emailhistory"))
USE IN (SELECT("emailinfo"))
USE IN (SELECT("contacts"))

WAIT WINDOW "Contact Lists were sent..." NOWAIT

SET EXCLUSIVE &lcOldExclusive
SET DELETED &lcOldDeleted

* Parse procedures out of memvar because it fails on reset
IF EMPTY(lcOldProcedure)
   lnProcCount = 0
ELSE
   lnProcCount = ALINES(laProc, lcOldProcedure, .T., ",")
ENDIF

SET PROCEDURE TO

FOR lnCount = 1 TO lnProcCount
   lcProcedure = laProc[lnCount]
   SET PROCEDURE TO &lcProcedure ADDITIVE
ENDFOR

RETURN

*: EOF :*