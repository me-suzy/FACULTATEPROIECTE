DEFINE CLASS ExportXml AS Session 
cVersion = 'MSXML2.DOMDOCUMENT.4.0'
cProcName = ''
oXml = .NULL.
cCondition = ''
cXmlFile = 'Orders.Xml'
DIMENSION aCursors[ 1, 5 ]

************************************************************************************
FUNCTION cProcName_Assign( tcProcName )
************************************************************************************
LOCAL lnLen, lnCnt, lcAlias, lcTag
	This.cProcName = UPPER( ALLTRIM( tcProcName ) )
	*** Get the names of the cursor to use
	*** to generate the Xml into the array property
	SELECT cAlias, cPKField, cFkField, cTag, iLevel ;
		FROM XmlCursors WHERE UPPER( ALLTRIM( cProcName ) ) == This.cProcName ;
	ORDER BY iLevel INTO ARRAY This.aCursors
	**** Now open the metadata
	IF NOT USED( 'XmlMap' )
		USE XmlMap IN 0
		SELECT XmlMap
		SET ORDER TO cProcName
	ENDIF
	*** And the tables to be used to generate the Xml
	lnLen = ALEN( This.aCursors, 1 )
	FOR lnCnt = 1 TO lnLen
		lcAlias = ALLTRIM( This.aCursors[ lnCnt, 1 ] )
		lcTag = ALLTRIM( This.aCursors[ lnCnt, 4 ] )
		IF NOT USED( lcAlias )
			USE ( lcAlias ) AGAIN IN 0
		ENDIF
		SELECT ( lcAlias )
		IF NOT EMPTY( lcTag )
			SET ORDER TO ( lcTag )
		ENDIF
	ENDFOR
	*** Instantiate the parser
	This.oXml = CreateObject( This.cVersion )
	This.oXml.async = .F.
ENDFUNC

***********************************************************************************	
FUNCTION GenerateXml
***********************************************************************************	
LOCAL loRoot, lcAlias, lcpkField, loNode, lcStr
	**** create the root element
	*** this is represented in the metadata by the
	*** record for the process that has no parent record
	SELECT XmlMap
	LOCATE FOR UPPER( ALLTRIM( XmlMap.cProcName ) ) == This.cProcName AND EMPTY( XmlMap.cParent )
	IF NOT FOUND()
		ASSERT .F. MESSAGE 'Unable to find XML information in metadata'
		RETURN .F.
	ENDIF
	
	WITH This.oXml
		loRoot = .CreateElement( ALLTRIM( XmlMap.cNodeName ) )

		*** Now add the root element to the document
		.AppendChild( loRoot )

		*** Process the first level
		lcAlias = UPPER( ALLTRIM( This.aCursors[ 1, 1 ] ) )
		lcpkField = UPPER( ALLTRIM( This.aCursors[ 1, 2 ] ) )
		SELECT ( lcAlias )
		
		*** See if we are processing for some condition
		IF NOT EMPTY( This.cCondition )
			SCAN FOR EVAL( This.cCondition )
				*** Add the child nodes for this level
				SELECT * FROM XmlMap WHERE ;
					UPPER( ALLTRIM( cProcName ) ) == This.cProcName AND ;
					UPPER( ALLTRIM( cAlias ) ) = lcAlias ;
					ORDER BY cParent, iSeq INTO CURSOR csrKids NOFILTER
				**** create the nodes in the document
				**** according to the metadata
				loNode = This.AddChildren( loRoot )
			  *** See if we have kids to process
			  IF ALEN( This.aCursors, 1 ) > 1
					This.ProcessCursors( 2, loNode )
				ENDIF
			ENDSCAN
		ELSE
			SCAN 
				*** Add the child nodes for this level
				SELECT * FROM XmlMap WHERE ;
					UPPER( ALLTRIM( cProcName ) ) == This.cProcName AND ;
					UPPER( ALLTRIM( cAlias ) ) = lcAlias ;
					ORDER BY cParent, iSeq INTO CURSOR csrKids NOFILTER
				**** create the nodes in the document
				**** according to the metadata
				loNode = This.AddChildren( loRoot )
			  *** See if we have kids to process
			  IF ALEN( This.aCursors, 1 ) > 1
					This.ProcessCursors( 2, loNode )
				ENDIF
			ENDSCAN
		ENDIF
		*** Now save the Xml as a file
		lcStr = '<?xml version="1.0" encoding="WINDOWS-1252"?>' + .Xml
		STRTOFILE( lcStr, This.cXmlFile )
		*** Finished...so release the parser
		This.oXml = .NULL.
	ENDWITH
ENDFUNC

*************************************************************************
FUNCTION ProcessCursors( tiLevel, toNode )
*************************************************************************
LOCAL lcAlias, lcpkField, lcChildAlias, lcFkField, luValue, loNode

	*** Get the name of the parent alias and the pk field
	lcAlias = UPPER( ALLTRIM( This.aCursors[ tiLevel - 1, 1 ] ) )
	lcpkField = UPPER( ALLTRIM( This.aCursors[ tiLevel - 1, 2 ] ) )
	*** And the child info
	lcChildAlias = UPPER( ALLTRIM( This.aCursors[ tiLevel, 1 ] ) )
	lcFkField = UPPER( ALLTRIM( This.aCursors[ tiLevel, 3 ] ) )
	luValue = EVALUATE( lcAlias + '.' + lcPkField ) 
	*** And start adding the child nodes
	SELECT ( lcChildAlias )
	SCAN FOR EVALUATE( lcChildAlias + '.' + lcFkField ) == luValue
		SELECT * FROM XmlMap WHERE ;
			UPPER( ALLTRIM( cProcName ) ) == This.cProcName AND ;
			UPPER( ALLTRIM( cAlias ) ) == lcChildAlias ;
			ORDER BY cParent, iSeq INTO CURSOR csrKids NOFILTER
		**** create the nodes in the document
		**** according to the metadata
		loNode = This.AddChildren( toNode )
		*** And see if this node has children
		IF tiLevel < ALEN( This.aCursors, 1 )
			This.ProcessCursors( tiLevel + 1, loNode )
		ENDIF
	ENDSCAN
ENDFUNC

*************************************************************************
FUNCTION AddChildren( toParent )
*************************************************************************
LOCAL loNode, loNodeText, lnRecNo, lcText

	*** Save the current location in the metadata
	lnRecNo = RECNO( 'csrKids' )

	*** See if this node has kids
	SELECT csrKids
	LOCATE FOR UPPER( ALLTRIM( csrKids.cParent ) ) == UPPER( ALLTRIM( toParent.NodeName ) )
	IF FOUND()
		SCAN WHILE UPPER( ALLTRIM( csrKids.cParent ) ) == UPPER( ALLTRIM( toParent.NodeName ) )
			*** See if we are adding an element or an attribute
			IF UPPER( ALLTRIM( csrKids.cNodeType ) ) == 'ATTRIBUTE'
				loNode = This.oXml.CreateAttribute( UPPER( ALLTRIM( csrKids.cNodeName ) ) )
			ELSE
				loNode = This.oXml.CreateElement( UPPER( ALLTRIM( csrKids.cNodeName ) ) )
			ENDIF
			*** Now see if we have some text
			IF NOT EMPTY( csrKids.mNodeText )
				*** Get rid of characters that would be interpreted as markup (like < and >)
				lcText = EVALUATE( ALLTRIM( csrKids.mNodeText ) )
				lcText = STRTRAN( STRTRAN( STRTRAN( lcText, "&", '&amp;'), '"', '&quot;' ), "'", '&apos;' )
				lcText = STRTRAN( STRTRAN( lcText, "<", '&lt;'), '>', '&gt;' )
				loNodeText = This.oXml.CreateTextNode( lcText ) 
				*** And append it to its parent node
				loNode.AppendChild( loNodeText )
			ENDIF
			*** And add it to the document
			IF UPPER( ALLTRIM( csrKids.cNodeType ) ) == 'ATTRIBUTE'		
				toParent.SetAttributeNode( loNode )
			ELSE
				toParent.AppendChild( loNode )
			ENDIF
			*** Now add the children for this node
			This.AddChildren( loNode )
		ENDSCAN
	ENDIF

	*** reposition the record pointer
	GO lnRecNo IN csrKids

	RETURN loNode
ENDFUNC

ENDDEFINE