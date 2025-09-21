* localitatile tuturor clientilor
select numepren,loc;
from localitati inner join clienti on localitati.codpost=clienti.codpost		 

* localitatile si judetele tuturor clientilor
select numepren,loc,jud;
from localitati inner join clienti on localitati.codpost=clienti.codpost

*suma valorilor facturilor
sele lf.nrfact, SUM(cantitate*pretunit) as Valoarefaratva;
from facturi f inner join liniifact lf on f.nrfact=lf.nrfact;
group by lf.nrfact

*valoarea totala pt. fiecare factura
sele f.codcl,lf.nrfact, sum((cantitate*pretunit)*(1+1.19)) as Valtotala;
from liniifact lf inner join chitare ch on ch.codchitara=lf.codchitara;
				  inner join facturi f on lf.nrfact=f.nrfact;
into cursor crstemp;
group by lf.nrfact

*valoarea maxima a unei facturi
sele Valtotala,nrfact,numepren ;
from crstemp t inner join clienti c on t.codcl=c.codcl;
where valtotala in ;
	(sele max(valtotala) from crstemp)
	
