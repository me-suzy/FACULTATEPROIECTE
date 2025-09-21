***********************************************************************
* Program....: PROGRAM1
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Test program that illustrates using a command object and a 
*	parameter object to run a paramterized query and get back an ADO RecordSet
***********************************************************************
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
SUSPEND