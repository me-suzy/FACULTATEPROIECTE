							***View Echipe
							
create sql view vechipe as ;
select idech,numeech,culori,telefon,nrjuc,codpost,coddiv from echipe

dbsetprop('vechipe','view','tables','echipe')

dbsetprop('vechipe.idech','field','keyfield',.t.)

dbsetprop('vechipe.idech','field','updatename','echipe.idech')
dbsetprop('vechipe.numeech','field','updatename','echipe.numeech')
dbsetprop('vechipe.telefon','field','updatename','echipe.telefon')
dbsetprop('vechipe.nrjuc','field','updatename','echipe.nrjuc')
dbsetprop('vechipe.codpost','field','updatename','echipe.codpost')
dbsetprop('vechipe.coddiv','field','updatename','echipe.coddiv')

dbsetprop('vechipe.idech','field','defaultvalue','def_idech_echipe()')

dbsetprop('vechipe.idech','field','updatable',.t.)
dbsetprop('vechipe.numeech','field','updatable',.t.)
dbsetprop('vechipe.telefon','field','updatable',.t.)
dbsetprop('vechipe.nrjuc','field','updatable',.t.)
dbsetprop('vechipe.codpost','field','updatable',.t.)
dbsetprop('vechipe.coddiv','field','updatable',.t.)

dbsetprop('vechipe','view','sendupdates',.t.)