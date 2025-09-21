update reparatii;
set pretreparatie=0

select liniifact
scan
select reparatii
seek liniifact.codchitara order tag codrepar 
replace pretreparatie with liniifact.pretunit
endscan
