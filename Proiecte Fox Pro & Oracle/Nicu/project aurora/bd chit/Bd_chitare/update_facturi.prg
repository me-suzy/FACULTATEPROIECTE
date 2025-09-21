***********************************************************************
**Calculul valorilor:Valcutva,Valfaratva,Valtotala,Valincasata,Reduceri
***********************************************************************
update liniifact;
set valfaratva=0,valcutva=0

update facturi;
set valtotala=0,valincasata=0,reduceri=0
***
update liniifact;
set valcutva=cantitate*pretunit*1.19,valfaratva=cantitate*pretunit
***
select liniifact
scan
select facturi
seek liniifact.nrfact order tag nrfact
replace valtotala with valtotala+liniifact.valcutva
endscan
***
*select f.nrfact,sum(transa) as valincasata into array incasat;
*from facturi f inner join incasfact if ;
*on f.nrfact=if.nrfact;
*group by f.nrfact
if !used ('incasfact')
use incasfact in 0
endif

select incasfact
scan
select facturi
seek incasfact.nrfact order tag nrfact
replace valincasata with valincasata+incasfact.transa
endscan
