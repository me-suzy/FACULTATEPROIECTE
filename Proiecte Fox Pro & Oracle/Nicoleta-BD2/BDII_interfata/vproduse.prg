#include foxpro.h
CREATE SQL VIEW vproduse connection connect1;
as select * from produse

=DBSETPROP('vproduse','View','Tables','produse')
=dbsetprop('vproduse.codpr','field','keyfield',.t.)
=dbsetprop('vproduse.codpr','field','updatable',.t.)
=dbsetprop('vproduse.denpr','field','updatable',.t.)

=DBSETPROP('vproduse','View','UpdateType',DB_UPDATE)
=DBSETPROP('vproduse','View','WhereType',DB_KEY)
=DBSETPROP('vproduse','View','SendUpdates',.t.)