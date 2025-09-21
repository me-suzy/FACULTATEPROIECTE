LOCAL loParser, loSchemaCache
loParser = CREATEOBJECT( 'MSXML2.DomDocument.4.0' )
loSchemaCache = CREATEOBJECT( 'MSXML2.XmlSchemaCache.4.0' )
loSchemaCache.Add( '', 'OrderSchema.xml' )
loParser.Schemas = loSchemaCache
loParser.Load( 'Orders.xml' )
IF loParser.ParseError.ErrorCode # 0
	MESSAGEBOX( loParser.ParseError.Reason, 16, 'Unable to validate Xml Document' )
ENDIF