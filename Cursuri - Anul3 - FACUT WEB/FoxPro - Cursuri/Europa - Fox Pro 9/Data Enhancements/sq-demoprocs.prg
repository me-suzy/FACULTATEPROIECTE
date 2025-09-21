#INCLUDE sqltests.h

CLEAR
? [PROC file. Nothing to run.]

PROCEDURE ShowDif
	* Loop through current alias with GetNextModified
	* display fields that are changed in the buffer.
	LOCAL lnRec
	lnRec = 0
	? 'Tally:',_TALLY
	? PADL('Recno',10),PADL('Old Value',21),PADL('New Value',21)
	DO WHILE .T.
		lnRec = GETNEXTMODIFIED(m.lnRec)
		IF m.lnRec = 0
			EXIT
		ELSE
			GO (m.lnRec)
		ENDIF
		FOR i = 1 TO AFIELDS(laFields)
			lcVal = EVALUATE(laFields[m.i,1])
			IF ISNULL(m.lcVal) OR (CURVAL(laFields[m.i,1])<>m.lcVal)
				? RECNO(), CURVAL(laFields[m.i,1]), EVALUATE(laFields[m.i,1])
			ENDIF
		ENDFOR
	ENDDO
ENDPROC

PROCEDURE SETUP
	SET ALTERNATE TO
	RELEASE WINDOWS ALT.txt
	ERASE ALT.txt
	SET ALTERNATE TO ALT.txt
	SET ALTERNATE ON
	CLEAR
	CLOSE DATABASES ALL
	SET MULTILOCKS ON
	OPEN DATABASE ( C_DIR_NORTHWIND + "northwind")
	USE Products
	CURSORSETPROP("BUFFERING",5,"products")
	_TALLY = 0
ENDPROC

PROCEDURE Cleanup
	SET ALTERNATE TO
	SET ALTERNATE OFF
	MODIFY FILE ALT.txt NOWAIT
	SYS(3054,0)
	CLEAR
ENDPROC
