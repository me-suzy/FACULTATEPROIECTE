LOCAL loXslt, loParser, loXslDoc, loXslProc
*** create the XSLTemplate object to cache the compiled XSLT style sheet 
*** and use this object to perform the transformation to reduce overhead. 
loXslt = CREATEOBJECT( 'Msxml2.XSLTemplate.4.0' )
loParser = CREATEOBJECT( 'Msxml2.DOMDocument.4.0' )
loXslDoc = CREATEOBJECT( 'Msxml2.FreeThreadedDOMDocument.4.0' )
loXslDoc.Async = .F.
*** load the style sheet
loXslDoc.Load( "Orders.xsl" )
loXslt.Stylesheet = loXslDoc
loParser.async = .f.
*** load the Xml file
loParser.Load( "Orders.xml" )
*** Create an instance of the XSLT processor
loXslProc = loXslt.CreateProcessor()
loXslProc.Input = loParser
*** apply the transformation
loXslProc.Transform()
*** save the HTML
STRTOFILE( loXslProc.Output, 'Orders.html' )
