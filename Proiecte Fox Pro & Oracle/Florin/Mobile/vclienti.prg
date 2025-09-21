#include foxpro.h

if !dbused("mobile")
	open database mobile
endif
set database to mobile


if used('vclienti')
	select	vclienti
		use
endif


create sql view  vclienti as; 
select codcl,DenCl,Adresa,CodPost,TelFix, TelMobil,Email from clienti ;



*ce tabela se actualizeaza
dbsetprop('vclienti','view','tables','clienti')



*cheie primara
dbsetprop('vclienti.codcl','field','keyField',.t.)



*cheia de legatura
dbsetprop('vclienti.codpost','field','updatename','clienti.codpost')
dbsetprop('vclienti.dencl','field','updatename','clienti.dencl')
dbsetprop('vclienti.adresa','field','updatename','clienti.adresa')
dbsetprop('vclienti.telfix','field','updatename','clienti.telfix')
dbsetprop('vclienti.telmobil','field','updatename','clienti.telmobil')
dbsetprop('vclienti.email','field','updatename','clienti.email')


*atributele care se actualizeaza
dbsetprop('vclienti.codpost','field','updatable',.t.)
dbsetprop('vclienti.dencl','field','updatable',.t.)
dbsetprop('vclienti.adresa','field','updatable',.t.)
dbsetprop('vclienti.telfix','field','updatable',.t.)
dbsetprop('vclienti.telmobil','field','updatable',.t.)
dbsetprop('vclienti.email','field','updatable',.t.)


dbsetprop('vclienti.codpost','field','default','def_clienti_codpost()')


*tip modeificare
dbsetprop('vclienti','view','UpdateType',DB_UPDATE)

*se verifica neconcordante-daca au mai fost facute modificari
dbsetprop('vclienti','view','wheretype',DB_KEYANDUPDATABLE)

*pt a se actualiza
dbsetprop('vclienti','view','sendupdates',.t.)
