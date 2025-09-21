LPARAMETER tcFileName

#DEFINE ccHTMLTEMPLATEHEAD  [TemplateHead.htm]

LOCAL lnResponse                       && Overwrite answer
LOCAL lnOldSelect                      && Save to reset at end

IF VARTYPE(tcFileName) != "C"
   MESSAGEBOX("File name passed is not valid data type!", ;
              0+48, ;
              _screen.Caption)
   
   RETURN
ENDIF

IF FILE(tcFileName)
   lnResponse = MESSAGEBOX("File already exists, overwrite?", ;
                           4+32, ;
                           _screen.Caption)
   
   * No?
   IF lnResponse = 7
      RETURN
   ENDIF
ENDIF

lcOldSafety = SET("SAFETY")
lnOldSelect = SELECT()

SET SAFETY OFF

* Need data
OPEN DATABASE ch17
SET DATABASE TO ch17
USE v_ShortContactList IN 0 SHARED 
SELECT v_ShortContactList

IF RECCOUNT() > 0
   * Copy template to the new file we are creating
   COPY FILE ccHTMLTEMPLATEHEAD TO (tcFileName)

   * Open new file and merge rest of text
   SET TEXTMERGE ON
   SET TEXTMERGE TO (tcFileName) ADDITIVE NOSHOW

   * Heading
   \<p align="center"><font face="Tahoma"><b>1001 Tips Contact List HTML Sample 
   \\</b></font>
   \<p></p>
   \<table border="0" width="900">

   * Create HTML row for all records in data set
   SCAN
      \  <tr>
      \    <td><font face="Tahoma" size=2> <<ALLTRIM(last_name)+", "+ALLTRIM(first_name)>>
      \\       </font></td>
      \    <td><font face="Tahoma" size=2> <<ALLTRIM(email_name)>> </font></td>
      \    <td><font face="Tahoma" size=2> <<ALLTRIM(company_name)>> 
      \\       </font></td>
      \    <td><font face="Tahoma" size=2> <<ALLTRIM(city)>> </font></td>
      \    <td><font face="Tahoma" size=2> <<state>> </font></td>
      \    <td><font face="Tahoma" size=2> <<postalcode>> </font></td>
      \ </tr>
   ENDSCAN
   
   * Wrap up the report footer
   \</table>
   \<p><font face="Tahoma" size="2">
   \<<DATETIME()>><br>
   \<<tcFileName>>
   
   * Get the number of bytes in the file
   lnFileSize = FSEEK(_text,0,2)       && Determine file size, assign to pnSize
   
   * Get the size of the file using the Low-Level file IO command
   \<br><<"The " + tcFileName + " is " + ALLTRIM(STR(lnFileSize)) + " bytes long.">>
   \</font></p>
   \</body>
   \</html>
  
   
   * Close the file and turn off textmerge
   SET TEXTMERGE TO
   SET TEXTMERGE OFF
ENDIF

USE IN v_ShortContactList

SELECT (lnOldSelect)
SET SAFETY &lcOldSafety

RETURN

*: EOF :*