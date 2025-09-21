***********************************************************************
* Program....: DOMHANDLER.PRG
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Class that uses MSXML2.domsocument.4.0 to import cml into multiple cursors
***********************************************************************
DEFINE CLASS VFPDomhandler AS Session OLEPUBLIC
	cVersion = 'MSXML2.DOMDOCUMENT.4.0'
	cProcName = ""
	cAlias = ""
	oXml = .NULL.
	DIMENSION aCursors[ 1, 5 ]
	DIMENSION aParents[ 1 ]
	
************************************************************************************
FUNCTION Init
************************************************************************************
	IF DODEFAULT()
		*** instantiate the dom
		This.oXML = CREATEOBJECT( This.cVersion )
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

************************************************************
FUNCTION Parse( tcFile )
************************************************************
WITH This.oXml
	.load( tcFile )
	This.ProcessNode( .DocumentElement )
ENDWITH

************************************************************
FUNCTION processnode( tonode )
************************************************************
	#DEFINE NODE_INVALID	0	
	#DEFINE NODE_ELEMENT	1	
	#DEFINE NODE_ATTRIBUTE	2	
	#DEFINE NODE_TEXT	3	
	#DEFINE NODE_CDATA_SECTION	4	
	#DEFINE NODE_ENTITY_REFERENCE	5	
	#DEFINE NODE_PROCESSING_INSTRUCTION	7	
	#DEFINE NODE_COMMENT	8	
	#DEFINE NODE_DOCUMENT	9	
	#DEFINE NODE_DOCUMENT_TYPE	10	
	#DEFINE NODE_DOCUMENT_FRAGMENT	11	
	#DEFINE NODE_NOTATION	12	
	LOCAL loChild, lcParent
	*** Find the correct record in the mapping table for this node
	*** If this is the root node, we must set its parent to an empty string
	**** otherwise, the parent is the nodename of the parent node
	IF toNode.ParentNode.NodeType = NODE_DOCUMENT
		lcParent = ''
	ELSE
		lcParent = UPPER( toNode.ParentNode.NodeName )
	ENDIF
	*** Now see if we have switched cursors because if we have,
	*** we need to insert a new record into a cursor
	IF toNode.NodeType = NODE_ELEMENT
		SELECT XmlMap
		LOCATE FOR UPPER( ALLTRIM( cProcName ) ) == This.cProcName AND ;
			UPPER( ALLTRIM( cNodeName ) ) == UPPER( ALLTRIM( toNode.NodeName ) ) AND ;
			UPPER( ALLTRIM( cParent ) ) == lcParent
		IF FOUND()
			*** If we have an associated cursor, see if we need to add a record
			IF NOT EMPTY( XmlMap.cAlias )
				IF UPPER( ALLTRIM( XmlMap.cAlias ) ) == This.cAlias
					*** No need to add a record
				ELSE
					This.AddNewRecord()
				ENDIF
			ENDIF	
		ENDIF
	ENDIF
	
	*** Next see if we have any attributes
	This.GetAttributes( toNode )

	*** if this is a text node, use it to update the correct field in the correct cursor
	IF toNode.NodeType = NODE_TEXT
		This.UpdateField( toNode.NodeValue, toNode.ParentNode.NodeName, toNode.ParentNode.ParentNode.NodeName )
	ENDIF
	IF toNode.HasChildNodes
		FOR EACH lochild in toNode.ChildNodes
			This.ProcessNode( loChild )
		ENDFOR
	ENDIF
ENDFUNC

*******************************************************************************
FUNCTION GetAttributes( toNode )
******************************************************************************
	LOCAL loAttributes, lnAttributes, lnAttr
	loAttributes = toNode.Attributes
	IF VARTYPE( loAttributes ) = 'O'
		lnAttributes = loAttributes.Length - 1
		IF lnAttributes >= 0
			FOR lnAttr = 0 TO lnAttributes
				This.UpdateField( loAttributes.Item[ lnAttr ].NodeValue, loAttributes.Item[ lnAttr ].NodeName, toNode.NodeName )
			ENDFOR
		ENDIF
	ENDIF
ENDFUNC

****************************************************************************
FUNCTION UpdateField( tcValue, tcNodeName, tcParent )
****************************************************************************
	*** Get the names of the current node and the parent node
	tcParent = UPPER( tcParent )
	tcNodeName = UPPER( tcNodeName )
	*** Now find the correct record in the mapping table
	SELECT XmlMap
	LOCATE FOR UPPER( ALLTRIM( cProcName ) ) == This.cProcName AND ;
		UPPER( ALLTRIM( cNodeName ) ) == tcNodeName AND ;
		UPPER( ALLTRIM( cParent ) ) == tcParent
	IF FOUND() AND NOT EMPTY( XmlMap.cField )
		*** translate any named entities like apostrophes and quotes
		tcValue = STRTRAN( STRTRAN( tcValue, '&lt;', "<" ), '&gt;', '>' )
		tcValue = STRTRAN( STRTRAN( STRTRAN( tcValue, '&quot;', '"' ), '&apos;', "'" ), '&amp;', "&" )
		luValue = This.Str2Exp( tcValue, XmlMap.cType, XmlMap.iLen, XmlMap.lJustify )
		*** Go ahead and plug in the value
		REPLACE ( ALLTRIM( XmlMap.cField ) ) WITH luValue IN ( 'cur' + This.cAlias )
	ENDIF
ENDFUNC

**********************************************************
FUNCTION AddNewRecord
**********************************************************
	LOCAL lnRow, lcFkField, luValue

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
ENDFUNC

**************************************************************************************
FUNCTION Str2Exp( tcExp, tcType, tiLen, tlJustify )
**************************************************************************************
	*** When tlJustify is true, it means that this is to be right justified
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
ENDFUNC

ENDDEFINE
