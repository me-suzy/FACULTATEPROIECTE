***********************************************************************
* Program....: PROGRAM1
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Test program that illustrates using a command object and a 
*	parameter object to run a paramterized query and get back an ADO RecordSet
***********************************************************************
LOCAL oCmd, lcstr, oParm, oRs, loFormatter
*** Create a record set containing all the cutomers in Germany
*** Using the command and paramter objects
oCmd = CREATEOBJECT( 'ADODB.Command' )
lcstr = "provider=vfpoledb.1; data source=" + HOME(2) + "data\testdata.dbc"
oCmd.ActiveConnection = lcStr
WITH oCmd
  .CommandText = "SELECT * FROM Customer WHERE Country = ?"
  .CommandType = 1
ENDWITH
oParm = oCmd.CreateParameter()
WITH oParm
	.Name = "oCountryParm"
  .Type = 12      && adVariant
  .Direction = 1  && input parameter only
  .Size = 7
  .Value = 'Germany'
ENDWITH
oCmd.Parameters.Append( oParm )
oRs = oCmd.Execute()
*** Test the formatter using this RecordSet
IF VARTYPE( oRs ) = "O"
   loFormatter = NEWOBJECT( "xFormatter", "CH17.VCX" )
   IF VARTYPE( loFormatter) = "O"
      
      *** Maybe should return number of records
      loFormatter.ADO2Cursor( oRs, "ADOCURSOR" )
      IF USED( "ADOCURSOR" )
         SELECT "ADOCURSOR"
         BROWSE LAST 
      ENDIF      
   ELSE
      MESSAGEBOX( "Unable to create formatter" )
   ENDIF   
ELSE
   MESSAGEBOX( "Unable to create Recordset" )
ENDIF   
loFormatter.Release()
