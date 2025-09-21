***********************************************************************
* Program....: COMIF.PRG
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Define a set of standard COM Interfaces
***********************************************************************
* ...........: xMsgHandler :: Defines Interface for Message Handler
***********************************************************************
DEFINE CLASS xMsgHandler AS session OLEPUBLIC
 *** Property to hold default title for Message Displays
 cDefTitle = ""
 *** Use COMATTRIB to define property characteristics
 DIMENSION cDefTitle_COMATTRIB[ 5 ]
 cDefTitle_COMATTRIB[ 1 ] = 0
 cDefTitle_COMATTRIB[ 2 ] = "Default Title for use when none specified"
 cDefTitle_COMATTRIB[ 3 ] = "cDefTitle"
 cDefTitle_COMATTRIB[ 4 ] = "String"
 cDefTitle_COMATTRIB[ 5 ] = 0
  
 FUNCTION ShoMsg( tcMsgTxt AS String, tnStyle AS Integer, tcTitle AS String ) AS Integer ;
    HELPSTRING "Handles generation of a message in the appropriate format"
 ENDFUNC
  
 FUNCTION GetMsg( tnMsgID AS Integer, tcTable AS String ) AS String ;
   HELPSTRING "Look up a message ID in a message table and returns the associated text"
 ENDFUNC
ENDDEFINE

***********************************************************************
* ...........: xDataFinder :: Defines Interfaces for SEEK() and LOCATE
***********************************************************************
DEFINE CLASS xDataSearch AS session OLEPUBLIC
 FUNCTION IdxSch( tuFindVal AS Variant, tcTable AS String, tcTag AS String ) AS Integer ;
   HELPSTRING "Carry out an index search on the specified table and return Record Number"
 ENDFUNC

 FUNCTION FldSch( tuFindVal AS Variant, tcTable AS String, tcFld AS String ) AS Integer ;
   HELPSTRING "Carry out a search on the table and return a Record Number"
 ENDFUNC
ENDDEFINE
