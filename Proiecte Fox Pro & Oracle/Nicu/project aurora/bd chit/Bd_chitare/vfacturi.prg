*** crearea tabelei derivate Vfacturi
#include foxpro.h
if !dbused('vanzrepar')
	open database vanzrepar
endif
set database to vanzrepar

if used('vfacturi')
select vfacturi
use 
endif

create sql view vfacturi as;
select lf.nrfact,f.datafact,lf.linie,lf.codchitara;
,cantitate,pretunit,cantitate*pretunit as valfaratva,;
cantitate*pretunit*lf.tva as valcutva,;
cantitate*pretunit*(1+lf.tva) as valtotala;
from liniifact lf inner join facturi f on lf.nrfact=f.nrfact;
inner join chitare ch on lf.codchitara=ch.codchitara;
where month(f.datafact)=?'lu_na';
order by lf.nrfact,lf.linie

dbsetprop('vfacturi','view','tables','liniifact')

dbsetprop('vfacturi.nrfact','field','keyfield',.t.)
dbsetprop('vfacturi.linie','field','keyfield',.t.)

dbsetprop('vfacturi.nrfact','field','updatable',.t.)
dbsetprop('vfacturi.linie','field','updatable',.t.)
dbsetprop('vfacturi.codchitara','field','updatable',.t.)
dbsetprop('vfacturi.cantitate','field','updatable',.t.) 
dbsetprop('vfacturi.pretunit','field','updatable',.t.)

dbsetprop('vfacturi.nrfact','field','defaultvalue','def_nrfact_facturi()')
dbsetprop('vfacturi.linie','field','defaultvalue','def_linie_liniifact()')
dbsetprop('vfacturi.datafact','field','defaultvalue','def_datafact_vfacturi()')
dbsetprop('vfacturi.cantitate','field','ruleexpression','calcul_val_liniifact()')
dbsetprop('vfacturi.pretunit','field','ruleexpression','calcul_val_liniifact()')
dbsetprop('vfacturi.codchitara','field','ruleexpression','seek_codchitara(vfacturi.codchitara)')
*dbsetprop('vfacturi','view','ruleexpression','iif(empty(codchitara) or empty(cantitate) or empty(pretunit),.f.,.t.)')
*dbsetprop('vfacturi','view','ruletext','Linia nu este completata cu datele necesare!!!')




dbsetprop('vfacturi','view','updatetype',db_update)

dbsetprop('vfacturi','view','wheretype',db_keyandupdatable)

dbsetprop('vfacturi','view','sendupdates',.t.)
