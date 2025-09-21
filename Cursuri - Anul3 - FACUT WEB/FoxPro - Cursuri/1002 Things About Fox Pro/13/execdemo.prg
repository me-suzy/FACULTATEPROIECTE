***********************************************************************
* Program....: EXECDEMO.PRG
* Compiler...: Visual FoxPro 07.00.0000.9400 for Windows 
* Purpose....: Illustrate use of SQLEXEC()
***********************************************************************
LOCAL lnConHandle, lnRes, lcSql, lcProc

********************************************************************
***  Connect to SQL Server
********************************************************************
lnConHandle = SQLCONNECT( 'SQLPubs', 'sa', 'sa' )
IF lnConHandle < 1
  WAIT WINDOW "Unable to Connect"
  RETURN
ENDIF
*** Ensure connection is synchronous
lnRes = SQLSETPROP( lnConHandle, "Asynchronous", .F. )
*** Disable ODBC Error Messages
lnRes = SQLSETPROP( lnConHandle, "DispWarnings", .F. )

********************************************************************
*** Execute an SQL Select, return results in cursor "SQLResult"
********************************************************************
lcSql = "SELECT PU.pub_name, PU.city, TI.title " ;
      + "  FROM publishers PU, titles TI " ;
      + " WHERE TI.pub_id = PU.pub_id " ;
      + " ORDER BY PU.city, PU.pub_name, TI.title "
lnRes = SQLEXEC( lnConHandle, lcSql )

********************************************************************
*** Create a simple Stored Procedure 
********************************************************************
lcProc = "CREATE PROCEDURE showsales @FindID char (4) " ;
       +      "AS SELECT * FROM sales WHERE stor_id = @FindID"
lnRes = SQLEXEC( lnConHandle, lcProc )

*** Call Procedure from VFP and return result in cursor "V_Sales"
lnRes = SQLExec( lnConHandle, "execute showsales '7066'", 'v_sales') 

*** Drop the procedure 
lcProc = "drop procedure [dbo].[showsales]"
lnRes = SQLEXEC( lnConHandle, lcProc )

********************************************************************
*** Disconnect from SQL Server
********************************************************************
lnRes = SQLCANCEL(  lnConHandle )
lnRes = SQLDISCONNECT( lnConHandle )
