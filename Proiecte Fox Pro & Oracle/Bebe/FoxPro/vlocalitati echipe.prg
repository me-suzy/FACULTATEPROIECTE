						*** CREAREA TABELEI DERIVATE vLocalitati_echipe
						
#include foxpro.h

IF !DBUSED('campionat')
	OPEN DATABASE DATABASE campionat
ENDIF
SET DATABASE TO CAMPIONAT

IF USED('vLocalitati')
	SELECT vLocalitati
	USE
ENDIF

***Fraza SQL de creare a tabelei virtuale

CREATE SQL VIEW vLocalitati AS;
	SELECT lf.codpost,f.loc,jud,lf.idech,numeech,culori,nrjuc,coddiv;
	from echipe lf inner join localitati f on lf.codpost=f.codpost;
	ORDER BY lf.codpost,loc
	
	DBSETPROP('vlocalitati','view','tables','echipe')
	
	DBSETPROP('vlocalitati.codpost','field','keyfield',.t.)
	DBSETPROP('vlocalitati.idech','field','keyfield',.t.)
	
	DBSETPROP('vlocalitati.codpost','field','updatable',.t.)
	DBSETPROP('vlocalitati.idech','field','updatable',.t.)
	
	DBSETPROP('vlocalitati.codpost','field','defaultvalue','def_codpost_localitati()')
	DBSETPROP('vlocalitati.idech','field','defaultvalue','def_idech_echipe()')
	
	dbsetprop('vlocalitati','view','updatetype',db_update)

	dbsetprop('vlocalitati','view','wheretype',db_keyandupdatable)

	dbsetprop('vlocalitati','view','sendupdates',.t.)
	
	
	
	
	