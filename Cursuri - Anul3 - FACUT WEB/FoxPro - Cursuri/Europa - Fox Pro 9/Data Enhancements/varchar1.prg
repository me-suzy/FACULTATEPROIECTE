*<>{31409BE2-BEC2-42B2-9191-142519973637}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrate table and CDX size comparisons.
*<>************************************************************************
CLOSE DATABASES ALL
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir)
ERASE myTable*.*
CLEAR

CREATE TABLE myTable (f1 v(100))

FOR x=1 TO 10000
	INSERT INTO myTable (f1) VALUES ('a')
ENDFOR
INDEX ON f1 TAG f1

CREATE TABLE MyTable2 (f1 c(100))
FOR x=1 TO 10000
	INSERT INTO MyTable2 (f1) VALUES ('a')
ENDFOR
INDEX ON f1 TAG f1

CLOSE TABLES ALL
ADIR(aFiles,"MyTable*.*")
ASORT(aFiles,1,ALEN(aFiles),1)
FOR nCount = 1 TO ALEN(aFiles,1)
	IF "MYTABLE.DBF" $ UPPER(aFiles(nCount,1))
		? "Size of Varchar Table"
		? aFiles(nCount,2)
	ENDIF
	IF "MYTABLE.CDX" $ UPPER(aFiles(nCount,1))
		? "Size of Varchar Index"
		? aFiles(nCount,2)
	ENDIF
	IF "MYTABLE2.DBF" $ UPPER(aFiles(nCount,1))
		? "Size of Character Table"
		? aFiles(nCount,2)
	ENDIF
	IF "MYTABLE2.CDX" $ UPPER(aFiles(nCount,1))
		? "Size of Character Index"
		? aFiles(nCount,2)
	ENDIF
ENDFOR
