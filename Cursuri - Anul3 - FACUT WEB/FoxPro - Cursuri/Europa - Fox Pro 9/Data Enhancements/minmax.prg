*<>{77899E1B-FC74-4309-A7A7-894983851431}**********************************
*<> Author:  a-davand
*<> Description:  Demonstrate MIN/MAX use of indexes for RUSHMORE optmization
*<>************************************************************************
#DEFINE C_CRLF CHR(13) + CHR(10)
LOCAL lcThisDir AS STRING
lcThisDir = ADDBS(JUSTPATH(SYS(16)))
CD (lcThisDir)

CLEAR
CLOSE DATABASES ALL
RELEASE WINDOWS showplan
ERASE foo.*
ERASE showplan.txt
CREATE TABLE foo (f1 I)

*!*	FOR i=1 TO 1000
*!*	   INSERT INTO foo VALUES (m.i)
*!*	ENDFOR
*!*	DELETE FROM foo WHERE MOD(f1,5) = 1
*!*	WriteMsg(LTRIM(STR(_TALLY))+ " records deleted")

WriteMsg("*** Brought to you in part by the new SYS(3092) function!")
SYS(3054,2)
SYS(3092,"showplan.txt",.T.)

WriteMsg(C_CRLF+"NO indexes exist")
TestMinMax()

WriteMsg("INDEX ON f1 TAG f1")
INDEX ON f1 TAG f1
TestMinMax()

SELECT foo
IF VERS(5)=900
	WriteMsg("INDEX ON DELETED() TAG DELETED BINARY")
	INDEX ON DELETED() TAG DELETED BINARY
ELSE
	WriteMsg("INDEX ON DELETED() TAG DELETED")
	INDEX ON DELETED() TAG DELETED
ENDIF
TestMinMax()

WriteMsg("DELETE TAG DELETED")
DELETE TAG DELETED

WriteMsg("INDEX ON f1 TAG f1_Del FOR DELETED()")
WriteMsg("INDEX ON f1 TAG f1_NotDel FOR !DELETED()")
INDEX ON f1 TAG f1_Del FOR DELETED()
INDEX ON f1 TAG f1_NotDel FOR !DELETED()
TestMinMax()

IF VERS(5)=900
	WriteMsg("INDEX ON DELETED() TAG DELETED BINARY")
	INDEX ON DELETED() TAG DELETED BINARY
ELSE
	WriteMsg("INDEX ON DELETED() TAG DELETED")
	INDEX ON DELETED() TAG DELETED
ENDIF
TestMinMax()

SET ALTERNATE OFF
SET ALTERNATE TO
SYS(3092,'')

MODIFY FILE showplan.txt NOWAIT

PROCEDURE TestMinMax
	WriteMsg(C_CRLF+PADR("* Results ",60,'*'))
	WriteMsg("SET DELETED OFF")
	SET DELETED OFF
	SELECT MAX(f1) FROM foo INTO CURSOR T
	SELECT MAX(f1) FROM foo WHERE DELETED() INTO CURSOR T
	WriteMsg(C_CRLF+"SET DELETED ON")
	SET DELETED ON
	SELECT MAX(f1) FROM foo INTO CURSOR T
	SELECT MAX(f1) FROM foo WHERE DELETED() INTO CURSOR T
	WriteMsg(C_CRLF+PADR("* END Results ",60,'*')+C_CRLF)
	SELECT foo
ENDPROC

PROCEDURE WriteMsg(tcText)
	SYS(3092,"")
	STRTOFILE(C_CRLF+m.tcText,"showplan.txt",.T.)
	SYS(3092,"showplan.txt",.T.)
ENDPROC
