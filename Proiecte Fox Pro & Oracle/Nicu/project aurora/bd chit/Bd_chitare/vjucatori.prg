						*** CREAREA TABELEI DERIVATE vJucatori
						
#include foxpro.h

IF !DBUSED('campionat')
	OPEN DATABASE DATABASE campionat
ENDIF
SET DATABASE TO CAMPIONAT

IF USED('vJucatori')
	SELECT vJucatori
	USE
ENDIF

***Fraza SQL de creare a tabelei virtuale

CREATE SQL VIEW vJucatori AS;
	SELECT lf.codjuc,f.nume,lf.codc,sumac;
	from contract lf inner join jucatori f on lf.codjuc=f.codjuc;
	ORDER BY lf.codjuc,nume
	
	DBSETPROP('vjucatori','view','tables','contract')
	
	DBSETPROP('vjucatori.codjuc','field','keyfield',.t.)
	DBSETPROP('vjucatori.codc','field','keyfield',.t.)
	
	DBSETPROP('vjucatori.codjuc','field','updatable',.t.)
	DBSETPROP('vjucatori.codc','field','updatable',.t.)
	
	DBSETPROP('vjucatori.codjuc','field','defaultvalue','def_codjuc_jucatori()')
	DBSETPROP('vjucatori.codc','field','defaultvalue','def_codc_contract()')
	
	dbsetprop('vjucatori','view','updatetype',db_update)

	dbsetprop('vjucatori','view','wheretype',db_keyandupdatable)

	dbsetprop('vjucatori','view','sendupdates',.t.)
	
	
	
	
	