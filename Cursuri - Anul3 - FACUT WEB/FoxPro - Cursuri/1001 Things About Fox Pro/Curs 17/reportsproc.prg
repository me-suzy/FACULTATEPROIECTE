#DEFINE ccRTFFILE   "temp.rtf"

* This procedure will save code in RTF Memo Field to an 
* RTF Document file on disk, then append it to a temporary 
* cursor in the a General Field
PROCEDURE AppendGenRTF
LPARAMETER tcMemoFieldName

LOCAL lcRTFTempDirectory
LOCAL lcRTFTempFile
LOCAL lcOldSelect
LOCAL lcOldSafety

lcRTFTempDirectory = ADDBS(SYS(2023))
lcRTFTempFile      = lcRTFTempDirectory + ccRTFFILE
lcOldSelect        = SELECT()
lcOldSafety        = SET("SAFETY")

* Copy the current RTF memo to a file
SET SAFETY OFF
COPY MEMO (tcMemoFieldName) TO (lcRTFTempFile)

* Append to the temp cursor
IF !USED("curRTFGeneral")
   CREATE CURSOR curRTFGeneral (gRTF g)
ENDIF

SELECT curRTFGeneral
APPEND BLANK
APPEND GENERAL gRTF FROM (lcRTFTempFile) CLASS WORD.DOCUMENT LINK

SELECT (lcOldSelect)

RETURN .T.

ENDPROC


* This procedure will Blank out (remove) the RTF General Field
* and erase the temporary RTF file
PROCEDURE BlankGenRTF

LOCAL lcRTFTempDirectory
LOCAL lcRTFTempFile
LOCAL lcOldSelect
LOCAL lcOldSafety

IF !USED("curRTFGeneral")
   * Nothing to do
ELSE
   lcRTFTempDirectory = ADDBS(SYS(2023))
   lcRTFTempFile      = lcRTFTempDirectory + ccRTFFILE
   lcOldSelect        = SELECT()
   lcOldSafety        = SET("SAFETY")
   
   SELECT curRTFGeneral
   
   SET SAFETY OFF
   BLANK FIELDS gRTF
   ERASE (lcRTFTempFile)
   
   SELECT (lcOldSelect)
   SET SAFETY &lcOldSafety
ENDIF

RETURN .T.

ENDPROC

*: EOF :*