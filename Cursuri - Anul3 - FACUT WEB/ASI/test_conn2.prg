CLEAR
Public loConn AS ADODB.CONNECTION, ;
   loCommand AS ADODB.COMMAND, ;
   loException AS EXCEPTION, ;
   loCursor AS CURSORADAPTER, ;
   country, ;
   laErrors[1]
set multilocks on
loConn = CREATEOBJECT('ADODB.Connection')
WITH loConn
   .ConnectionString = 'Provider=MSDAORA.1;Password=pass;User ID=user;Data Source=BDSTUD;Persist Security Info=True;'
   TRY
      .OPEN()
   CATCH TO loException
      MESSAGEBOX(loException.MESSAGE)
      CANCEL
   ENDTRY
ENDWITH
loCommand = CREATEOBJECT('ADODB.Command')
loCommand.ActiveConnection = loConn
loCursor = CREATEOBJECT('CursorAdapter')
WITH loCursor
   .ALIAS          = 'user_tables'
   .DATASOURCETYPE = 'ADO'
   .SELECTCMD      = 'select table_name from user_tables'
*   .KeyFieldList   = 'cnp'
*   .UpdateNameList = 'CNP candidat.CNP, NUMEPREN candidat.NUMEPREN'
*   .UpdatableFieldList = 'CNP, NUMEPREN'
*   'select * from customers where country=?lcCountry'
*   lcCountry       = 'Brazil'
   .DATASOURCE = CREATEOBJECT('ADODB.Recordset')
   .DataSource.CursorLocation   = 3  && adUseClient
   .DataSource.LockType         = 3 && adLockOptimistic
   .DATASOURCE.ActiveConnection = loConn
   llReturn = .CURSORFILL(.F., .F., 0, loCommand)
   IF !llReturn
      AERROR(laErrors)
      MESSAGEBOX(laErrors[2])
   ENDIF llReturn
ENDWITH
*The following example that illustrates using CursorRefresh with an already opened ADO Recordset. The connection string settings for SQL Server (localhost) and the Visual FoxPro OLE DB Provider are:
* .ConnectionString = 'provider=SQLOLEDB.1;data source=localhost;' + ;
* 'initial catalog=Northwind;trusted_connection=yes'
*!*	CLEAR
*!*	LOCAL loConn AS ADODB.CONNECTION, ;
*!*	   loCommand AS ADODB.COMMAND, ;
*!*	   loParam AS ADODB.PARAMETER, ;
*!*	   loRs AS ADODB.Recordset,;
*!*	   loException AS EXCEPTION, ;
*!*	   loCursor AS CURSORADAPTER, ;
*!*	   lcCountry, ;
*!*	   laErrors[1]
*!*	loConn = CREATEOBJECT('ADODB.Connection')
*!*	WITH loConn
*!*	   .ConnectionString = 'provider=vfpoledb;data source=' + ;
*!*	      HOME(2)+'northwind\Northwind.dbc'
*!*	   TRY
*!*	      .OPEN()
*!*	   CATCH TO loException
*!*	      MESSAGEBOX(loException.MESSAGE)
*!*	      CANCEL
*!*	   ENDTRY
*!*	ENDWITH
*!*	loCommand = CREATEOBJECT('ADODB.Command')
*!*	loCommand.CommandText = ;
*!*	   "SELECT * FROM customers WHERE Country = ?"
*!*	loParam = loCommand.CreateParameter("Country", 129, 1, 15, "")
*!*	loCommand.PARAMETERS.APPEND(loParam)
*!*	loCommand.PARAMETERS("Country") = "Brazil"
*!*	loCommand.ActiveConnection = loConn
*!*	loRs = loCommand.Execute()
*!*	loCursor = CREATEOBJECT('CursorAdapter')
*!*	WITH loCursor
*!*	   .ALIAS          = 'Customers'
*!*	   .DATASOURCETYPE = 'ADO'
*!*	   llReturn = .CURSORFILL(.F., .F., 0, loRs)
*!*	   IF llReturn
*!*	      BROWSE
*!*	      loRs.ActiveCommand.PARAMETERS("Country") = "Canada"
*!*	      llReturn  = .CURSORREFRESH()
*!*	      IF llReturn
*!*	         BROWSE
*!*	      ENDIF llReturn
*!*	   ELSE
*!*	      AERROR(laErrors)
*!*	      MESSAGEBOX(laErrors[2])
*!*	   ENDIF llReturn
*!*	ENDWITH
