						*** CREAREA TABELEI DERIVATE vDivizii_Echipe
						
#include foxpro.h

IF !DBUSED('campionat')
	OPEN DATABASE DATABASE campionat
ENDIF
SET DATABASE TO CAMPIONAT

IF USED('vDivizii_Echipe')
	SELECT vDivizii_Echipe
	USE
ENDIF

***Fraza SQL de creare a tabelei virtuale

CREATE SQL VIEW vDivizii_Echipe AS;
	SELECT lf.coddiv,f.numediv,lf.idech,numeech,culori,nrjuc;
	from echipe lf inner join divizii f on lf.coddiv=f.coddiv;
	ORDER BY lf.coddiv,numediv
	
	DBSETPROP('vDivizii_Echipe','view','tables','echipe')
	
	DBSETPROP('vDivizii_Echipe.coddiv','field','keyfield',.t.)
	DBSETPROP('vDivizii_Echipe.idech','field','keyfield',.t.)
	
	DBSETPROP('vDivizii_Echipe.coddiv','field','updatable',.t.)
	DBSETPROP('vDivizii_Echipe.idech','field','updatable',.t.)
	
	DBSETPROP('vDivizii_Echipe.coddiv','field','defaultvalue','def_coddiv_divizii()')
	DBSETPROP('vDivizii_Echipe.idech','field','defaultvalue','def_idech_echipe()')
	
	dbsetprop('vDivizii_Echipe','view','updatetype',db_update)

	dbsetprop('vDivizii_Echipe','view','wheretype',db_keyandupdatable)

	dbsetprop('vDivizii_Echipe','view','sendupdates',.t.)
	
	
	
	
	