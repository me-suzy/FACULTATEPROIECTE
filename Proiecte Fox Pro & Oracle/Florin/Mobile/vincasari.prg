#include foxpro.h

if !dbused("mobile")
	open database mobile
endif
set database to mobile

if used('vincasari')
	select	vincasari
	use
endif

if used('contracte')
	select	contracte
	use
endif

if used('incasari')
	select	incasari
	use
endif

	nrcontr_=1111
create sql view  vincasari as; 
select nrcontr,nrratainc, datainc,sumainc ;
from incasari ;
	where nrcontr=nrcontr_



*ce tabela se actualizeaza
dbsetprop('vincasari','view','tables','incasari')


*cheie primara
dbsetprop('vincasari.nrcontr','field','keyField',.t.)
dbsetprop('vincasari.nrratainc','field','keyField',.t.)

*cheia de legatura
dbsetprop('vincasari.nrcontr','field','updatename','incasari.nrcontr')
dbsetprop('vincasari.datainc','field','updatename','incasari.datainc')
dbsetprop('vincasari.sumainc','field','updatename','incasari.sumainc')
dbsetprop('vincasari.nrratainc','field','updatename','incasari.nrratainc')

*atributele care se actualizeaza
dbsetprop('vincasari.nrcontr','field','updatable',.t.)
dbsetprop('vincasari.nrratainc','field','updatable',.t.)
dbsetprop('vincasari.datainc','field','updatable',.t.)
dbsetprop('vincasari.sumainc','field','updatable',.t.)

dbsetprop('vincasari.nrcontr','field','defaultvalue','def_vincasari_nrcontr()')
dbsetprop('vincasari.sumainc','field','defaultvalue','def_incasari_sumainc()')
dbsetprop('vincasari.datainc','field','defaultvalue','date()')
dbsetprop('vincasari.nrratainc','field','defaultvalue','def_vincasari_nrratainc()')

*tip modeificare
dbsetprop('vincasari','view','UpdateType',DB_update)

*se verifica neconcordante-daca au mai fost facute modificari
dbsetprop('vincasari','view','wheretype',DB_KEYANDUPDATABLE)

*pt a se actualiza
dbsetprop('vincasari','view','sendupdates',.t.)









