						*** CREAREA TABELEI DERIVATE vEchipe_Jucatori
						
#include foxpro.h

IF !DBUSED('campionat')
	OPEN DATABASE DATABASE campionat
ENDIF
SET DATABASE TO CAMPIONAT

IF USED('vEchipe_Jucatori')
	SELECT vEchipe_Jucatori
	USE
ENDIF

***Fraza SQL de creare a tabelei virtuale

CREATE SQL VIEW vEchipe AS;
	SELECT lf.idech,f.numeech,culori,nrjuc,coddiv,lf.codjuc,nume,prenume,adresa,cnp,telmobil,telacasa,email;	
	from Jucatori lf inner join Echipe f on lf.idech=f.idech;
	ORDER BY lf.idech
	
	DBSETPROP('vechipe','view','tables','jucatori')
	
	DBSETPROP('vechipe.idech','field','keyfield',.t.)
	DBSETPROP('vechipe.codjuc','field','keyfield',.t.)
	
	DBSETPROP('vechipe.idech','field','updatable',.t.)
	DBSETPROP('vechipe.codjuc','field','updatable',.t.)
	
	DBSETPROP('vechipe.idech','field','defaultvalue','def_idech_echipe()')
	DBSETPROP('vechipe.codjuc','field','defaultvalue','def_codjuc_jucatori()')
	
	dbsetprop('vechipe','view','updatetype',db_update)

	dbsetprop('vechipe','view','wheretype',db_keyandupdatable)

	dbsetprop('vechipe','view','sendupdates',.t.)
	
	
	
	
	