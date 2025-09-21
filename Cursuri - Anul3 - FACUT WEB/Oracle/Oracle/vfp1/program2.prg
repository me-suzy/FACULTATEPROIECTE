drop table salarii

create table salarii (;
marca number(5), ;
an number(4);
check (an>=2000) error "anul nui poate fi anterior 2000!";
default year(date()),;
luna number(2) check (between(luna,1,12));
error "luna trebuie sa se gaseasca in intervalul 1-12" default month(date()),;
orelucrate number(3), oreco number(3), venitbaza number(16,2),;
sporuri number(16,2), impozit number(16,2), retineri number(16,2),;
primary key str(marca,5)+str(an,4)+str(luna,2) tag pk_salarii,;
foreign key marca tag fk_marca;
references personal tag pk_pers)