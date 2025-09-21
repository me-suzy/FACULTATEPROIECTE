#include foxpro.h

if !dbused("masini")
	open database masini
endif

if used('clienti')
	select	clienti
		use
endif



create sql view  v_clienti   connection connect1 ; 
 as; 
select * from clienti ;



*ce tabela se actualizeaza
dbsetprop('v_clienti','view','tables','clienti')



*cheie primara
dbsetprop('v_clienti.codcl','field','keyField',.t.)



*cheia de legatura
dbsetprop('v_clienti.codpost','field','updatename','clienti.codpost')
dbsetprop('v_clienti.dencl','field','updatename','clienti.dencl')
dbsetprop('v_clienti.adresa','field','updatename','clienti.adresa')
dbsetprop('v_clienti.telfix','field','updatename','clienti.telfix')
dbsetprop('v_clienti.telmobil','field','updatename','clienti.telmobil')
dbsetprop('v_clienti.email','field','updatename','clienti.email')
dbsetprop('v_clienti.cnpcodfiscal','field','updatename','clienti.cnpcodfiscal')
dbsetprop('v_clienti.tippers','field','updatename','clienti.tippers')
dbsetprop('v_clienti.codcl','field','updatename','clienti.codcl')
dbsetprop('v_clienti.contbanca','field','updatename','clienti.contbanca')

*atributele care se actualizeaza
dbsetprop('v_clienti.codpost','field','updatable',.t.)
dbsetprop('v_clienti.dencl','field','updatable',.t.)
dbsetprop('v_clienti.adresa','field','updatable',.t.)
dbsetprop('v_clienti.telfix','field','updatable',.t.)
dbsetprop('v_clienti.telmobil','field','updatable',.t.)
dbsetprop('v_clienti.email','field','updatable',.t.)
dbsetprop('v_clienti.cnpcodfiscal','field','updatable',.t.)
dbsetprop('v_clienti.tippers','field','updatable',.t.)
dbsetprop('v_clienti.codcl','field','updatable',.t.)
dbsetprop('v_clienti.contbanca','field','updatable',.t.)




*tip modeificare
dbsetprop('v_clienti','view','UpdateType',DB_UPDATE)

*se verifica neconcordante-daca au mai fost facute modificari
dbsetprop('v_clienti','view','wheretype',DB_KEY)

*pt a se actualiza
dbsetprop('v_clienti','view','sendupdates',.t.)
