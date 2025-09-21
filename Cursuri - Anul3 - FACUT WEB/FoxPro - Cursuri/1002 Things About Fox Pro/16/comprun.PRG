***********************************************************************
* Program....: COMPRUN.PRG
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Running Web Service Vs DLL
***********************************************************************

***********************************************************************
*** NOTE: This declaraion is specific to how the web service was 
*** registered on your machine - it may not work as posted here!!! 
*** Delete this block of code, and re-create after registering 
*** the web service (wszip.dll) on your own machine

*** Create the web service
LOCAL loSvce AS ZipCode Web Svce
LOCAL loWS
loWS = NEWOBJECT("Wsclient",HOME()+"ffc\_webservices.vcx")
loWS.cWSName = "ZipCode Web Svce"
loSvce = loWS.SetupClient("http://ACS-SERVER/CH16/xZipCodes.WSDL", "xZipCodes", "xZipCodesSoapPort")
***********************************************************************

? "****************************"
? "*** CALL THE WEB SERVICE"
? "****************************"
? loSvce.GetZipLine( 44309  )    && "Akron, OH, 44309"
? loSvce.GetZipLine( "44309" )   && "Akron, OH, 44309"
? loSvce.GetZipLine( .F.  )      && Empty String
? loSvce.GetZipLine( DATE()  )   && Empty String
? loSvce.GetErrors()             && No errors
?

***********************************************************************
*** Now use the SAME DLL Directly
***********************************************************************
LOCAL oDL
oDL = CREATEOBJECT( 'wszip.xzipcodes' )
? "************************"
? "*** NOW CALL THE DLL"
? "************************"
? oDL.GetZipLine( 44309  )      && Empty String + Error
? oDL.GetZipLine( "44309" )     && "Akron, OH, 44309"
? oDL.GetZipLine( .F.  )        && Empty String + Error
? oDL.GetZipLine( DATE()  )     && Empty String + Error
? oDL.GetErrors()               && Three "Invalid Parameter" Errors
