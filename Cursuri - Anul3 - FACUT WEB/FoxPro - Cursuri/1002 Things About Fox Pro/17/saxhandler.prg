***********************************************************************
* Program....: SaxHandler
* Compiler...: Visual FoxPro 07.00.0000.9400 for Windows 
* Purpose....: Class that uses sax reader to import xml into a cursor
***********************************************************************
DEFINE CLASS VFPSAXhandler AS Session OLEPUBLIC

	IMPLEMENTS IVBSAXContentHandler IN "msxml4.dll"
	IMPLEMENTS IVBSAXDTDHandler IN "msxml4.dll"
	IMPLEMENTS IVBSAXErrorHandler IN "msxml4.dll"

	cProcName = ""
	cParent = ""
	cNodeName = ""
	cAlias = ""	
	cNodeText = ""
	DIMENSION aCursors[ 1, 5 ]
	DIMENSION aParents[ 1 ]
	
************************************************************************************
FUNCTION Init
************************************************************************************
	IF DODEFAULT()
		*** Open the Metadata
		IF NOT USED( 'XmlCursors' )
			USE XmlCursors AGAIN SHARED IN 0
		ENDIF
		IF NOT USED( 'XmlMap' )
			USE XmlMap AGAIN SHARED IN 0
		ENDIF
	ENDIF
ENDFUNC

************************************************************************************
FUNCTION cProcName_Assign( tcProcName )
************************************************************************************
LOCAL lnLen, lnCnt, lcAlias, lcTag, laStru[ 1 ]
	This.cProcName = UPPER( ALLTRIM( tcProcName ) )
	*** Get the names of the cursors to create to hold the Xml
	*** Since we assume that these cursors are temporary holding tanks
	*** they will be the table names prefixed with 'cur'
	SELECT cAlias, cPKField, cFkField, cTag, iLevel ;
		FROM XmlCursors WHERE UPPER( ALLTRIM( cProcName ) ) == This.cProcName ;
	ORDER BY iLevel INTO ARRAY This.aCursors
	*** And get the names of all the parent nodes
	SELECT DISTINCT UPPER( cParent ) AS cParent FROM XmlMap INTO ARRAY This.aParents
	lnLen = ALEN( This.aCursors, 1 )
	FOR lnCnt = 1 TO lnLen
		lcAlias = UPPER( ALLTRIM( This.aCursors[ lnCnt, 1 ] ) )
		SELECT DISTINCT cField, cType, iLen, iDecimals FROM XmlMap ;
			WHERE 	UPPER( ALLTRIM( cProcName ) ) == This.cProcName AND ;
								UPPER( ALLTRIM( cAlias ) ) ==  lcAlias AND ;
								NOT EMPTY( cField ) INTO ARRAY laStru
		*** Now see if we need to add a foreign key field to the array
		SELECT XmlCursors
		LOCATE FOR 	UPPER( ALLTRIM( cProcName ) ) == This.cProcName AND ;
										UPPER( ALLTRIM( cAlias ) ) == lcAlias
		IF FOUND() AND NOT EMPTY( XmlCursors.cFkField )
			*** make sure it is not already in the array
			IF ASCAN( laStru, ALLTRIM( XmlCursors.cFkField ), -1, -1, 1, 15 ) = 0
				*** Add the foreign key to the array
				lnArrayLen = ALEN( laStru, 1 ) + 1
				DIMENSION laStru[ lnArrayLen, 4 ]
				laStru[ lnArrayLen, 1 ] = ALLTRIM( XmlCursors.cFkField )
				laStru[ lnArrayLen, 2 ] = ALLTRIM( XmlCursors.cFkType )
				laStru[ lnArrayLen, 3 ] = XmlCursors.iFkLen 
				laStru[ lnArrayLen, 4 ] = 0
			ENDIF
		ENDIF	
		CREATE CURSOR ( 'cur' + lcAlias ) FROM ARRAY laStru
	ENDFOR
ENDFUNC

**************************************************************************************
FUNCTION Str2Exp( tcExp, tcType, tiLen, tlJustify )
**************************************************************************************
*** When passes a length, it means that this is to be right justified
*** to accommodate the retarded pks in the testdata database for Tastrade

*** Convert the passed string to the passed data type
LOCAL luRetVal, lcType

*** Remove double quotes (if any) 
tcExp = STRTRAN( ALLTRIM( tcExp ), CHR( 34 ), "" ) 
*** If no type passed -- display error message
*** the procedure is not clairvoyant
IF TYPE( 'tcType' ) = 'C'
	lcType = UPPER( ALLTRIM( tcType ) )
ELSE
	*** Type is a required parameter. Let the developer know
	ERROR 'Missing Parameter: Expression type is a required parameter to Str2Exp'
ENDIF
*** Convert from Character to type
DO CASE
  CASE INLIST( lcType, 'I', 'N' ) AND INT( VAL( tcExp ) ) == VAL( tcExp ) && Integer
    luRetVal = INT( VAL( tcExp ) )
  CASE INLIST( lcType, 'N', 'Y')                      && Numeric or Currency
    luRetVal = VAL( tcExp )
  CASE INLIST( lcType, 'C', 'M' )                     && Character or memo
		IF tlJustify
	  		luRetVal = PADL( tcExp, tiLen )
		ELSE
	    luRetVal = tcExp
	  	ENDIF
  CASE lcType = 'L'                                   && Logical
    luRetVal = IIF( !EMPTY( tcExp ), .T., .F. )
  CASE lcType = 'D'                                   && Date 
    luRetVal = CTOD( '^' + tcExp )
  CASE lcType = 'T'                                   && DateTime 
    luRetVal = CTOT( '^' + tcExp )
  OTHERWISE
    *** There is no otherwise unless, of course, Visual FoxPro adds
    *** a new data type. In this case, the function must be modified 
ENDCASE
*** Return value as Data Type
RETURN luRetVal


	PROCEDURE IVBSAXContentHandler_put_documentLocator( oLocator AS Object ) AS VARIANT
	ENDPROC

	PROCEDURE IVBSAXContentHandler_startDocument() AS VOID
	ENDPROC

	PROCEDURE IVBSAXContentHandler_endDocument() AS VOID
	ENDPROC

	PROCEDURE IVBSAXContentHandler_startPrefixMapping( strPrefix AS STRING, strURI AS STRING ) AS VOID
	ENDPROC

	PROCEDURE IVBSAXContentHandler_endPrefixMapping( strPrefix AS STRING ) AS VOID
	ENDPROC

	PROCEDURE IVBSAXContentHandler_startElement( strNamespaceURI AS STRING, strLocalName AS STRING, strQName AS STRING, oAttributes AS VARIANT ) AS VOID
		LOCAL lnCnt, lcAttribute, lcValue, lnRow, lcFkField
		*** Find this node in the XmlMap metadata so we can find the cursor to populate
		This.cNodeName = UPPER( ALLTRIM( strLocalName ) )
		*** See if we need to reset the current parent
		SELECT * from XmlMap WHERE UPPER( ALLTRIM( cProcName ) ) == This.cProcName AND ;
			UPPER( ALLTRIM( cNodeName ) ) == This.cNodeName INTO CURSOR Junk
		IF _TALLY = 1
			This.cParent = UPPER( ALLTRIM( Junk.cParent ) )
		ENDIF
		*** Now find the correct record in the mapping table
		SELECT XmlMap
		LOCATE FOR UPPER( ALLTRIM( cProcName ) ) == This.cProcName AND ;
			UPPER( ALLTRIM( cNodeName ) ) == This.cNodeName AND ;
			UPPER( ALLTRIM( cParent ) ) == This.cParent
		IF FOUND()
			*** See if this node is a parent node and save it as the current parent
			lnRow = ASCAN( This.aParents, This.cNodeName, -1, -1, 1, 15 )
			IF lnRow > 0
				This.cParent = UPPER( ALLTRIM( This.aParents[ lnRow ] ) )
			ENDIF
			*** If we have an associated cursor, see if we need to add a record
			IF NOT EMPTY( XmlMap.cAlias )
				IF UPPER( ALLTRIM( XmlMap.cAlias ) ) == This.cAlias
					*** No need to add a record
				ELSE
					This.cAlias = UPPER( ALLTRIM( XmlMap.cAlias ) )
					APPEND BLANK IN ( 'cur' + This.cAlias )
					*** And see if we need to populate a foreign key field
					lnRow = ASCAN( This.aCursors, This.cAlias, -1, -1, 1, 15 )
					IF lnRow > 0
						*** Get the name of the field
						lcFkField = This.aCursors[ lnRow, 3 ]
						IF NOT EMPTY( lcFkField )
							*** And get the value of the pk from the parent table
							luValue = EVALUATE( 'cur' + This.aCursors[ lnRow - 1, 1 ] + '.' + This.aCursors[ lnRow - 1, 2 ] )
							REPLACE ( lcFkField ) WITH luValue IN ( 'cur' + This.cAlias )
						ENDIF
					ENDIF
				ENDIF
				*** Now see if we have some attributes to use to populate in the cursor
				*** Loop through all attributes in this node process them
				FOR lnCnt = 0 TO oAttributes.Length -1
					lcAttribute = UPPER( ALLTRIM( oAttributes.getQName( lnCnt ) ) )
					lcValue = oAttributes.getValue( lnCnt )
					*** Now see where we need to plug the value in
					SELECT XmlMap
					LOCATE FOR UPPER( ALLTRIM( cProcName ) ) == This.cProcName AND ;
						UPPER( ALLTRIM( cParent ) ) == This.cParent AND ;
						UPPER( ALLTRIM( cNodeName ) ) == lcAttribute AND ;
						UPPER( ALLTRIM( cNodeType ) ) == "ATTRIBUTE"
					IF FOUND() AND NOT EMPTY( XmlMap.cField )
						*** Go ahead and plug in the value
						REPLACE ( ALLTRIM( XmlMap.cField ) ) WITH This.Str2Exp( lcValue, XmlMap.cType, XmlMap.iLen, XmlMap.lJustify ) IN ( 'cur' + This.cAlias )
					ENDIF
				ENDFOR
			ENDIF
		ENDIF
	ENDPROC

	PROCEDURE IVBSAXContentHandler_endElement( strNamespaceURI AS STRING, strLocalName AS STRING, strQName AS STRING ) AS VOID
		LOCAL tcValue
		IF NOT EMPTY( This.cNodeText )
			*** translate any named entities like apostrophes and quotes
			tcValue = STRTRAN( STRTRAN( This.cNodeText, '&lt;', "<" ), '&gt;', '>' )
			tcValue = STRTRAN( STRTRAN( STRTRAN( tcValue, '&quot;', '"' ), '&apos;', "'" ), '&amp;', "&" )

			*** Find the correct record in the metadata
			SELECT XmlMap
			LOCATE FOR UPPER( ALLTRIM( cProcName ) ) == This.cProcName AND ;
				UPPER( ALLTRIM( cAlias ) ) == This.cAlias AND ;
				UPPER( ALLTRIM( cNodeName ) ) == This.cNodeName AND ;
				UPPER( ALLTRIM( cNodeType ) ) == "ELEMENT"
			IF FOUND() AND NOT EMPTY( XmlMap.cField )
				*** Go ahead and plug in the value
				REPLACE ( ALLTRIM( XmlMap.cField ) ) WITH This.Str2Exp( tcValue, XmlMap.cType, XmlMap.iLen ) IN ( 'cur' + This.cAlias )
			ENDIF
		ENDIF

		*** Clear out the cNodeText property
		This.cNodeText = ""

	ENDPROC

	PROCEDURE IVBSAXContentHandler_characters( strChars AS STRING ) AS VOID
		IF NOT EMPTY( strChars )
			This.cNodeText = This.cNodeText + strChars
		ENDIF
	ENDPROC

	PROCEDURE IVBSAXContentHandler_ignorableWhitespace( strChars AS STRING ) AS VOID
	ENDPROC

	PROCEDURE IVBSAXContentHandler_processingInstruction( strTarget AS STRING, strData AS STRING ) AS VOID
	ENDPROC

	PROCEDURE IVBSAXContentHandler_skippedEntity( strName AS STRING ) AS VOID
	ENDPROC

	PROCEDURE IVBSAXDTDHandler_notationDecl( strName AS STRING @, strPublicId AS STRING @, strSystemId AS STRING @ ) AS VOID
	ENDPROC

	PROCEDURE IVBSAXDTDHandler_unparsedEntityDecl( strName AS STRING @, strPublicId AS STRING @, strSystemId AS STRING @, strNotationName AS STRING @ ) AS VOID
	ENDPROC

	PROCEDURE IVBSAXErrorHandler_error( oLocator AS VARIANT, strError AS STRING @, nErrorCode AS Number ) AS VOID
	ENDPROC

	PROCEDURE IVBSAXErrorHandler_fatalError( oLocator AS VARIANT, strError AS STRING @, nErrorCode AS Number ) AS VOID
 		MESSAGEBOX( "Error: " + strError )
	ENDPROC

	PROCEDURE IVBSAXErrorHandler_warning(oLocator AS VARIANT, strError AS STRING @, nErrorCode AS Number ) AS VOID
 		MESSAGEBOX( "Warning: " + strError )
	ENDPROC

	PROCEDURE IVBSAXErrorHandler_IgnorableWarning(oLocator AS VARIANT, strError AS STRING @, nErrorCode AS Number ) AS VOID
 		MESSAGEBOX( "Ignorable Warning: " + strError )
	ENDPROC
ENDDEFINE
