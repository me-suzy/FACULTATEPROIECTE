alter table pontaje drop primary key
alter table pontaje drop foreign key tag fk_marca
alter table pontaje alter column data drop check

alter table pontaje alter column data;
set check (year(data) = year(date)())) error "se accepta pontaje numaai pentru anul curent!"
alter column data set default date()

alter table pontaje set check (iif(oreco>, orelucrate+orenoapte+oreabsnem=0, .T.))

alter table pontaje add primary key str(marca,5)+dtoc(data) tag pk_pontaje
alter table pontaje add foreign key marca tag fk_marca;
references personal tag pk_pers