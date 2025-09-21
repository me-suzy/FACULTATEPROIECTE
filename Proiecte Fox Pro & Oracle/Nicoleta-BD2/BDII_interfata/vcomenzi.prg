#include foxpro.h
CREATE SQL VIEW vcomenzi connection connect1;
as select idcom,datacomf,to_char(codcl) as codcl,valcom from comenzif

=DBSETPROP('vcomenzi','View','Tables','comenzif')
=dbsetprop('vcomenzi.idcom','field','keyfield',.t.)
=dbsetprop('vcomenzi.idcom','field','updatable',.t.)
=dbsetprop('vcomenzi.datacomf','field','updatable',.t.)
=dbsetprop('vcomenzi.valcom','field','updatable',.t.)

=DBSETPROP('vcomenzi','View','UpdateType',DB_UPDATE)
=DBSETPROP('vcomenzi','View','WhereType',DB_KEY)
=DBSETPROP('vcomenzi','View','SendUpdates',.t.)