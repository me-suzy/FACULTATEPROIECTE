*<>{858AE14C-5154-46E9-B3B3-533131137419}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrate CursorAdaptor Auto-Refresh capabilities
*<>************************************************************************
#INCLUDE sqltests.h
CLOSE DATABASES ALL
SQLDISCONNECT(0)
CLEAR
SET MULTILOCKS ON

PUBLIC nAutoRefreshConn AS INTEGER
PUBLIC oca AS CURSORADAPTER
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir) 

* Change connection string to connect to a different SQL Server
nAutoRefreshConn=SQLSTRINGCONNECT(C_SQLCONSTR)
IF (nAutoRefreshConn <1)
	? "Failed to connect!!!"
	AERROR(aerrs)
	DISPLAY MEMORY LIKE aerrs
	RETURN
ENDIF

TEXT TO cSQL NOSHOW
	CREATE TABLE #CAAutoRefreshDemo
	(
		f_identity int NOT NULL IDENTITY PRIMARY KEY,
		f_int_unique int NOT NULL UNIQUE,
		f_varchar varchar(10) NULL DEFAULT '00000',
		f_timestamp timestamp
	)
ENDTEXT

IF SQLEXEC(nAutoRefreshConn ,cSQL)!=1
	? "Failed to create demo table!!!"
	AERROR(aerrs)
	DISPLAY MEMORY LIKE aerrs
ENDIF

SQLEXEC(nAutoRefreshConn ,"INSERT INTO #CAAutoRefreshDemo (f_int_unique,f_varchar) VALUES (1,'demo1')")

SET PROCEDURE TO (PROGRAM()+".PRG")

* use this code to create the cursor
oca=CREATEOBJECT("CAAutoRefreshDemo")
IF NOT oca.AUTOOPEN()
	=AERROR(AERR)
	LIST MEMORY LIKE AERR*
ENDIF

BROWSE
CLEAR ALL


DEFINE CLASS CAAutoRefreshDemo AS CURSORADAPTER
	ALIAS = "CATest"
	DATASOURCE= nAutoRefreshConn
	DATASOURCETYPE="ODBC"
	MapBinary= .T.
	MapVarchar= .T.
	SELECTCMD="select * from #CAAutoRefreshDemo"
	FETCHMEMO= .T.
	TABLES="#CAAutoRefreshDemo"
	KEYFIELDLIST="f_identity"
	UPDATABLEFIELDLIST="f_int_unique,f_varchar"
	UPDATENAMELIST="f_int_unique #CAAutoRefreshDemo.f_int_unique, " + ;
		"f_varchar #CAAutoRefreshDemo.f_varchar, " + ;
		"f_timestamp #CAAutoRefreshDemo.f_timestamp, " + ;
		"f_identity #CAAutoRefreshDemo.f_identity"
	TimestampFieldList="f_timestamp"
&& automatically refresh Timestamp field after each Insert/Update
	RefreshTimestamp= .T.
&& automatically refresh IDENTITY field and f2 field after Insert
	InsertCmdRefreshFieldList="f_identity,f_int_unique"
&& use alternative key to refresh fields after Insert as we don't know
&& the value for f0 (IDENTITY)
	InsertCmdRefreshKeyFieldList="f_int_unique"
	WHERETYPE=4 && DB_KEYANDTIMESTAMP
	ConflictCheckType= 3
ENDDEFINE
