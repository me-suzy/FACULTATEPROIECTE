***********************************************************************
* Program....: FULLTXN.PRG
* Compiler...: Visual FoxPro 07.00.0000.9400 for Windows 
* Purpose....: Controlling Server Transactions explicitly
***********************************************************************
LOCAL ARRAY laErr[1]
LOCAL lnConHandle, lnRes, lcSql
CLEAR

********************************************************************
***  Connect to SQL Server
********************************************************************
lnConHandle = SQLCONNECT( 'SQLPubs', 'sa', 'sa' )
IF lnConHandle < 1
  WAIT WINDOW "Unable to Connect"
  RETURN
ENDIF
*** Ensure connection is synchronous
SQLSETPROP( lnConHandle, "Asynchronous", .F. )
*** Disable ODBC Error Messages
SQLSETPROP( lnConHandle, "DispWarnings", .F. )

********************************************************************
***  Set up the transaction handling
********************************************************************
*** Set Connection's Transactions property to manual
SQLSETPROP( lnConHandle, 'Transactions', 2)
*** Disable SQL Server Implicit transactions
SQLEXEC( lnConHandle, "SET IMPLICIT_TRANSACTIONS OFF" )

********************************************************************
*** Initiate a back end transaction if not already one running
********************************************************************
SQLEXEC( lnConHandle, "SELECT @@TRANCOUNT txncount", "curnumtxn" )
IF curNumTxn.txncount < 1
  *** Start a new transaction
  SQLEXEC( lnConHandle, "BEGIN TRANSACTION" )
ENDIF

********************************************************************
*** Now update a table
********************************************************************
lcSql = "INSERT INTO publishers (pub_id, pub_name, city, state ) VALUES ('9934', 'Krakins Publishing, Inc', 'Akron', 'OH' )"
lnRes = SQLEXEC( lnConHandle, lcSQL )
IF lnRes = 1
  *** Only try the second if the first succeeds. If it has failed
  *** there's no point in trying this one because we'll roll back anyway
  lcSql = "INSERT INTO publishers (pub_id, pub_name, city, state ) VALUES ( '9935', 'G&G Publishing, Inc', 'Detroit', 'MI' )"
  lnRes = SQLEXEC( lnConHandle, lcSQL )
ENDIF

********************************************************************
*** Commit if successful, Rollback if failed
********************************************************************
IF lnRes = 1
  DO WHILE .T.
    SQLEXEC( lnConHandle, "SELECT @@TRANCOUNT txncount", "curnumtxn" )
    IF curNumTxn.txncount > 0
      *** We have an open transaction on this connection
      lnRes = SQLCOMMIT( lnConHandle )
      IF lnRes = 1
        lcStatus = "Update Succeeded"
      ELSE
        *** Commit Failed
        AERROR( laErr )
        lcStatus = laErr[2]
        *** Roll back transaction 
        *** NB: This closes ALL open Transactions
        SQLROLLBACK( lnConHandle )
        EXIT
      ENDIF
    ELSE
      *** All done
      EXIT
    ENDIF
  ENDDO
ELSE
  *** Update Failed
  AERROR( laErr )
  *** Roll back transaction 
  *** NB: This closes ALL open Transactions
  SQLROLLBACK( lnConHandle )
  lcStatus = laErr[2]
ENDIF

*** Display the result
MESSAGEBOX( lcStatus, 64, "Update Status" )

********************************************************************
*** Uncomment this code to delete the test records
********************************************************************
*!*  SQLSETPROP( lnConHandle, 'Transactions', 1)  
*!*  SQLEXEC( lnConHandle, "DELETE publishers WHERE pub_id LIKE '993%'" )
********************************************************************

********************************************************************
*** Disconnect from SQL Server
********************************************************************
lnRes = SQLCANCEL(  lnConHandle )
lnRes = SQLDISCONNECT( lnConHandle )
