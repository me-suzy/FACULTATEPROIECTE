**********************************************************************
* Program....: BackLink.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Sets/Returns Backlink Information from a table
* ...........: Pass both DBF File name (including extension) only to
* ...........: to return backlink, also pass new backlink string to
* ...........: write a new backlink
**********************************************************************
LPARAMETERS tcTable, tcDBCPath 
LOCAL lnParms, lnHnd, lnHdrStart, lnHdrSize, lcBackLink, lcNewLink
lnParms = PCOUNT()
*** Check that the file exists
IF ! FILE( tcTable )
   ERROR "9000: Cannot locate file " + tcTable
   RETURN .F.
ENDIF
*** Open the file at low level - Read Only if just reading info
lnHnd = FOPEN( tcTable, IIF( lnParms > 1, 2, 0) )
*** Check file is open
IF lnHnd > 0
   *** Backlink is last 263 bytes of the header so calculate position
   *** Max header size is (32 + ( 255 * 32 ) + 264) = 8456 Bytes
   lcStr = FREAD( lnHnd, 8456 )
   *** Field records end with 13 NULLS + "CR"
   lcFieldEnd = REPLICATE( CHR(0), 13 ) + CHR(13)
   lnHeaderStart = AT( lcFieldEnd, lcStr ) + 13
   *** Move file pointer to header start position
   FSEEK( lnHnd, lnHeaderStart )
   *** Read backlink
   lcBackLink = UPPER( ALLTRIM( STRTRAN( FGETS( lnHnd, 263 ), CHR(0) ) ) )
   *** If we are writing a new backlink
   IF lnParms > 1
      *** Get the path (max 263 characters!)
      tcDBCPath = LEFT(tcDBCPath,263)
      *** Pad it out to the full length with NULLS
      lcNewLink = PADR( ALLTRIM( LOWER( tcDBCPath ) ), 263, CHR(0) )
      *** Go to start of Backlink
      FSEEK( lnHnd, lnHeaderStart )
      *** Write the new backlink information
      FWRITE( lnHnd, lcNewLink )
      *** Set the new backlink as the return value
      lcBackLink = tcDbcPath
   ENDIF
   *** Close the file
   FCLOSE(lnHnd)
ELSE
   ERROR "9000: Unable to open table file"
   lcBackLink = ""
ENDIF
*** Return the backlink
RETURN lcBackLink
