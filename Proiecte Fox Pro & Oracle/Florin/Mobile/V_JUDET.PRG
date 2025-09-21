#include foxpro.h
if !dbused('masini')
	open database masini
endif

if used('judete')
	select	judete
	use
endif

create sql view  v_judet  connection connect1 ; 
as select jud,judet,regiune ;
from judete 



*ce tabela se actualizeaza
=dbsetprop('v_judet','view','tables','judete')

*cheie primara
=dbsetprop('v_judet.jud','field','keyField',.t.)

*cheia de legatura
=dbsetprop('v_judet.jud','field','updatename','restplata.jud')
=dbsetprop('v_judet.judet','field','updatename','restplata.judet')
=dbsetprop('v_judet.regiune','field','updatename','restplata.regiune')

*atributele care se actualizeaza
=dbsetprop('v_judet.jud','field','updatable',.t.)
=dbsetprop('v_judet.judet','field','updatable',.t.)
=dbsetprop('v_judet.regiune','field','updatable',.t.)



*tip modeificare
=dbsetprop('v_judet','view','UpdateType',DB_update)

*se verifica neconcordante-daca au mai fost facute modificari
=dbsetprop('v_judet','view','wheretype',DB_KEY)

*pt a se actualiza
=dbsetprop('v_judet','view','sendupdates',.t.)