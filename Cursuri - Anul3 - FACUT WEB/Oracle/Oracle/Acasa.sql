 set pagesize 400
 set linesize 400
 set echo on
 set serveroutput on
------------------------------------------------------------------------------
drop table transe_sv;
drop table salarii;
drop table retineri;
drop table sporuri;
drop table pontaje;
drop table personal;


CREATE TABLE Personal(
Marca INTEGER
CONSTRAINT pk_personal PRIMARY KEY
CONSTRAINT nn_personal_marca NOT NULL
CONSTRAINT ck_personal_marca check (marca>1000),
numepren varchar(40)
constraint nn_personal_numepren not null
constraint un_personal_numepren unique
constraint ck_personal_numepren check(numepren=ltrim(initcap(numepren))),
compart varchar2(5) default 'prod'
constraint ck_personal_compart check (compart in ('conta','fin','prod','it','mark','pers')),
datasv date default sysdate
constraint nn_personal_data not null,
salorar numeric(16,2) default 45000,
salorarco numeric(16,2) default 40000,
colaborator char(1) default 'N'
constraint ck_personal_colaborator check (colaborator in ('D','N'))
 );

create table pontaje(
marca integer
constraint nn_pontaje_marca not null
constraint fk_pontaje_personal references personal(marca),
data date default sysdate
constraint nn_pontaje_data not null,
orelucrate number(2) default 8 
constraint ck_pontaje_orelucrate check(orelucrate between 0 and 12),
oreco number(2) default 0 
constraint ck_pontaje_oreco check(oreco between 0 and 8),
orenoapte number(2) default 0,
oreabsnem number(2) default 0,
constraint pk_pontaje PRIMARY KEY(marca,data),
constraint ck_pontaje1 check((orelucrate=0 and oreco>=0)or(orelucrate>=0 and oreco=0)),
constraint ck_pontaje2 check(orelucrate>=orenoapte),
constraint ck_pontaje3 check(orelucrate>=oreabsnem)
);

create table sporuri (
marca integer
constraint nn_sporuri_marca not null
constraint fk_sporuri_personal references personal(marca),
an number(4)
constraint nn_sporuri_an not null
constraint ck_sporuri_an check(an between 2003 and 2010),
luna number(2)
constraint nn_sporuri_luna not null
constraint ck_sporuri_luna check(luna between 1 and 12),
spvech number(16,2),
orenoapte number(3),
spnoapte number(16,2),
altesp number(16,2),
constraint pk_sporuri PRIMARY KEY (marca,an,luna)
);

create table retineri (
marca integer
constraint nn_retineri_marca not null
constraint fk_retineri_marca references personal(marca),
an number(4)
constraint nn_retineri_an not null
constraint ck_retineri_an check(an between 2001 and 2012),
luna number(2)
constraint nn_retineri_luna not null
constraint ck_retineri_luna check(luna between 1 and 12),
popriri number(16,2),
CAR number(16,2),
alteret number(16,2),
constraint pk_retineri PRIMARY KEY(marca,an,luna)
);

create table salarii (
marca integer
constraint nn_salarii_marca not null
constraint fk_salarii_personal references personal(marca),
an number(4)
constraint nn_salarii_an not null
constraint ck_salarii_an check(an between 2001 and 2012),
luna number(2)
constraint nn_salarii_luna not null
constraint ck_salarii_luna check(luna between 1 and 12),
orelucrate number(3),
oreco number(3),
venitbaza number(16,2),
sporuri number(16,2),
impozit number(16,2),
retineri number(16,2),
constraint pk_salarii primary key(marca,an,luna)
);

create table transe_sv (
ani_limita_inf integer,
ani_limita_sup integer,
procent_sv number(4,2)
);
---------------------------------------------------------------------------------------------
insert into personal values(1001,'Angajat1','IT',to_date('12/10/1980','dd/mm/yyyy'),56000,55000,'N');
insert into personal values(1002,'Angajat2','CONTA',to_date('12/11/1978','dd/mm/yyyy'),57500,56000,'N');
insert into personal values(1003,'Angajat3','IT',to_date('2/07/1976','dd/mm/yyyy'),67500,66000,'N');
insert into personal values(1004,'Angajat4','PROD',to_date('5/01/1985','dd/mm/yyyy'),56500,55500,'N');
insert into personal values(1005,'Angajat5','IT',to_date('12/11/1977','dd/mm/yyyy'),62500,62000,'N');
insert into personal values(1006,'Angajat6','CONTA',to_date('11/01/1984','dd/mm/yyyy'),71500,70000,'N');
insert into personal values(1007,'Angajat7','PROD',to_date('30/10/1990','dd/mm/yyyy'),50000,45000,'N');
insert into personal values(1008,'Angajat8','PROD',to_date('20/12/1994','dd/mm/yyyy'),49000,45000,'N');
insert into personal values(1009,'Angajat9','PROD',to_date('18/08/1996','dd/mm/yyyy'),39000,35000,'N');
insert into personal values(1010,'Angajat10','PROD',to_date('23/05/1992','dd/mm/yyyy'),51000,48000,'N');
--------------------------------------------------------------------------------------------
 insert into pontaje
    select marca, date'2003-07-08', case when marca=1003 then 0 else 8 end as orelucru,
    case when marca=1003 then 8 else 0 end as oreco,
    case marca when 1004 then 2 else 0 end as orenoapte,
   case marca when 1005 then 1 else 0 end as oreabsente 
    from personal;
--------------------------------------------------------------------------------------------
create table pontaje_2003_februarie as select*from pontaje where 1=2;
create table pontaje_2003_martie as select*from pontaje where 1=2;
create table pontaje_2003_aprilie as select*from pontaje where 1=2;
create table pontaje_2003_mai as select*from pontaje where 1=2;
create table pontaje_2003_iunie as select*from pontaje where 1=2;
create table pontaje_2003_iulie as select*from pontaje where 1=2;
create table pontaje_2003_august as select*from pontaje where 1=2;
create table pontaje_2003_septembrie as select*from pontaje where 1=2;
create table pontaje_2003_octombrie as select*from pontaje where 1=2;
create table pontaje_2003_noiembrie as select*from pontaje where 1=2;
create table pontaje_2003_decembrie as select*from pontaje where 1=2;
create table pontaje_2004_ianuarie as select*from pontaje where 1=2;
create table pontaje_2004_februarie as select*from pontaje where 1=2;
create table pontaje_2004_martie as select*from pontaje where 1=2;
----------------------------------------------------------------------------------
insert all
when extract (year from data)=2003 and extract (month from data)=7 then into pontaje_2003_iulie
when extract (year from data)=2003 and extract (month from data)=8 then into pontaje_2003_augus
when extract (year from data)=2003 and extract (month from data)=9 then into pontaje_2003_septe
when extract (year from data)=2003 and extract (month from data)=10 then into pontaje_2003_octo
select* from pontaje

select count(*) from sporuri;

update personal set salorar=salorar*1.10;

update personal
set salorar=salorar*1.12 where compart='it';
update personal
set salorar=salorar*1.08 where compart='conta';
update personal
set salorar=salorar*1.10 where compart='prod';
-------------------------------------------------------------
update sporuri sp
set spvech =
(
select round((sum(orelucrate*salorar*procent_sv)+
  sum(oreco*salorarco*procent_sv))/100,-3)
from personal pe
inner join pontaje po on pe.marca=po.marca
inner join transe_sv on trunc(months_between (
date'2003-07-01',datasv)/12,0)>=
ani_limita_inf and trunc(months_between(
date'2003-07-01',datasv)/12,0)< ani_limita_sup
group by pe.marca, extract (year from data),
extract (month from data)
having pe.marca=sp.marca and
extract (year from data)=sp.an and
extract (month from data)=sp.luna
),
orenoapte=
(select sum (orenoapte) from pontaje
where marca=sp.marca and
extract (year from data)=sp.an and
extract(month from data)=sp.luna),
spnoapte=
(
select round(sum(orenoapte*salorar*.15),-3)
from personal pe inner join pontaje po
on pe.marca=po.marca
group by pe.marca, extract (year from data),
extract (month from data)
having pe.marca=sp.marca and
extract (year from data)=sp.an and
extract (month from data)=sp.luna
)
/

---------------------------------------------------------------

 merge into salarii  sa using
 (select extract (year from data) as an, extract (month from data) as luna,
 marca, sum(orelucrate) as orelucrate, sum(oreco) as oreco
 from pontaje
 where extract (year from data)=2003 and extract (month from data) =7
 and extract (day from data)>=9
 group by extract(year from data), extract(month from data), marca
 )  po
 on (sa.an=po.an and sa.luna=po.luna and sa.marca=po.marca)
 when matched then
 update set sa.orelucrate=sa.orelucrate+po.orelucrate, sa.oreco=sa.oreco+po.oreco
 when not matched then
 insert (sa.an, sa.luna, sa.marca, sa.orelucrate, sa.oreco)
         values (po.an, po.luna,po.marca,po.orelucrate,po.oreco)
 /

 select marca, orelucrate, oreco from salarii where an=2003 and luna=7;

-----------------------------------------------------------------------------

 update sporuri set spnoapte=.15*
 (select salorar from personal where marca = 2001) *
 (select sum(orenoapte)from pontaje
 where marca=2001 and to_char(data,'mm')=2
 and to_char(data,'yyyy')=2003),
 orenoapte=
 (select sum(orenoapte) from pontaje
 where marca=2001 and to_char(data,'mm')=2
 and to_char(data, 'yyyy')=2003)
 where marca=2001 and luna=2 and an=2003
 /

-----------------------------------------------------------------------------------

 savepoint act_pontaje;
---------------------------------------------------------------------------------

 select *
 from personal
 where compart='it'
 order by numepren
 /
---------------------------------------------------------------------------------

select * from dual;
 select sysdate from dual;
---------------------------------------------------------------------------------

 select * 
 from personal
 where salorar between 55000 and 65000
 /

--------------------------------------------------------------------------------

 select * 
 from personal
 where numepren between 'Angajat1' and ' angajat4'
 /
---------------------------------------------------------------------------------

 select *
 from pontaje
 where data between date'2003-07-01' and date'2003-07-06'
 /
--------------------------------------------------------------------------------
 select * from personal
 where compart='prod' or compart='it'
 order by compart, datasv
 /
--------------------------------------------------------------------------------

select *
from personal
where upper(numepren) like '_A%'
/
--------------------------------------------------------------------------------
select numepren || ' lucreaza in compartimentul ' ||
compart as text
from personal
/
---------------------------------------------------------------------------------
select numepren || ' lucreaza din ' ||datasv|| 
 ' si are salariul orar de ' || salorar || ' lei .'
as text 
from personal
/
----------------------------------------------------------------------------------

 select upper(numepren), lower(numepren), initcap(numepren)
 from personal;
--------------------------------------------------------------------------------
select '*' || compart || '*' as compart,
'*' || lpad(compart,15) || '*' as "l_pad_15",
'*' || rpad(compart,15) || '*' as "r_pad_15"
from personal;
---------------------------------------------------------------------------------
select numepren, length(numepren),
instr(numepren,'j'), instr(numepren,'D')
from personal
/
--------------------------------------------------------------------------------
 select marca, salorar, salorar/168,
 ceil(salorar/168) as ceil, floor(salorar/168) as floor,
 round(salorar/168,2) as "round+", round(salorar/168,-2) as "round-",
 trunc(salorar/168,2) as "trunc+"
 from personal
 /
-----------------------------------------------------------------------------------
 select current_date as "data curenta",
 current_timestamp as "data si ora curenta"
 from dual
 /
-------------------------------------------------------------------------------------
 select sysdate as "astazi",
 add_months(sysdate,2) as"peste 2 luni",
 last_day(sysdate) "ultima zi a lunii curente",
 next_day(sysdate,'friday') as "urmatoarea vineri"
 from dual
 /
------------------------------------------------------------------------------------
 select extract(year from sysdate),
 extract(month from sysdate),
 extract(day from sysdate),
 extract(hour from systimestamp),
 extract (minute from systimestamp),
 extract (second from systimestamp)
 from dual
 /
----------------------------------------------------------------------------------- 
 select sysdate+48 as "peste 48 de zile"
 from dual;
----------------------------------------------------------------------------------
 select systimestamp as "acum"
 from dual;
-----------------------------------------------------------------------------------
 select systimestamp  as Ora_exacta,
 systimestamp + interval '71' minute +
 interval '100' second as Peste_71min_100sec
 from dual
 /
--------------------------------------------------------------------------------------
 select sysdate as azi,
 sysdate+interval'2-2'year to month+34,
 sysdate+interval'2-2'year(1)to month+34
 from dual
 /
---------------------------------------------------------------------------------------
 select 'etc',
 current_timestamp+interval'120 12:45:45'
 day(3) to second
 from dual
 /
------------------------------------------------------------------------------------------
alter session set nls_date_format='dd-mm-yyyy hh24:mi:ss'
/
----------------------------------------------------------------------------------------------
select current_date as astazi,
sysdate+interval'2004-03' year(4) to month+
interval'19' day as oale_si_ulcele
from dual
/
-----------------------------------------------------------------------------------------------
 select numepren,datasv,
 months_between(date'2003-12-12',datasv)as Nr_Luni,
 trunc(months_between(date'2003-12-12',datasv)/12,0)as Ani_Intregi
 from personal
 /
-------------------------------------------------------------------------------------------------
 select numepren,datasv,
 months_between(date'2003-05-01',datasv)as nr_luni,
 trunc(months_between(date'2003-05-01',datasv)/12,0)as ani_intregi
 from personal
 /
------------------------------------------------------------------------------------------------------
select numepren,datasv,
months_between(date'2003-05-01',datasv)/12 as ani_fractionari,
(date'2003-05-01' - datasv) year(2) to month as ani_si_luni,
extract(year from((date'2003-05-01' - datasv)year(2) to month)) as ani
from personal
/
----------------------------------------------------------------------------------------------------------
select numepren,
to_date('01/05/2003','dd/mm/yyyy') as "1 mai muncitoresc",
to_char(datasv,'dd-mm-yyyy')as "data-sir",
to_char(salorar,'999999')as "numar-sir",
to_number(to_char(datasv,'mm'))as "luna(data-sir-numar)"
from personal
/
------------------------------------------------------------------------------------------------------------
select cast (marca as char(6)) as marca_sir,
cast(current_date as timestamp) as data_timp,
cast(datasv as varchar2(40)) as data_sir
from personal;
---------------------------------------------------------------------------------------------------------
 select marca,numepren,colaborator,
 case
 when colaborator = 'N' then 'angajat cu norma intraga'
 when colaborator = 'D' then 'colaborator'
 end as tipul_angajatului
 from personal;
---------------------------------------------------------------------------------------------------------
 select pontaje.*,
 case to_char(data,'day')
 when 'sunday' then 'duminica'
 when 'saturday' then 'sambata'
 else 'zi lucratoare'
 end as categoria_zilei
 from pontaje
 where to_char(data,'mm/yyyy')='07/2003'
 /
--------------------------------------------------------------------------------------------------------------
 select data
 from pontaje,personal
 where pontaje.marca=personal.marca and
 extract(year from data)=2003 and
 extract(month from data) = 7 and
 numepren='Angajat1'
 /
---------------------------------------------------------------------------------------------------------------
select data
from pontaje inner join personal
on pontaje.marca=personal.marca
where extract(year from data)=2003 and
extract(month from data)=7 and
numepren='Angajat1'
/
-------------------------------------------------------------------------------------------------------------
 select *
 from sporuri, salarii
 where sporuri.marca=salarii.marca and
 sporuri.an=salarii.an and sporuri.luna=salarii.luna
 /
-----------------------------------------------------------------------------------------------------------------------
select p1.numepren
from personal p1, personal p2
where p1.compart=p2.compart and p2.numepren='Angajat2'
/
---------------------------------------------------------------------------------------------------------------------
 select po1.data as ziua
 from(pontaje po1 inner join personal pe1 on
 po1.marca=pe1.marca and numepren = 'Angajat1')
 inner join
 (pontaje po2 inner join personal pe2 on
 po2.marca=pe2.marca and pe2.numepren = 'Angajat4')
 on po1.data=po2.data
 /
-------------------------------------------------------------------------------------------------------------------
select * from personal where compart ='conta'
union
select * from personal where compart = 'it'
/
---------------------------------------------------------------------------------------------------------------------
select data
from pontaje po inner join personal pe
on po.marca=pe.marca
where numepren='Angajat1' and
to_char(data,'mm/yyyy')='07/2003'
union
select data
from pontaje po inner join personal pe
on po.marca=pe.marca
where numepren='Angajat5' and
to_char(data,'mm/yyyy')='07/2003'
/
----------------------------------------------------------------------------------------------------------------
select data as ziua
from pontaje po inner join personal pe on
po.marca=pe.marca and numepren='Angajat1'
intersect
select data
from pontaje po inner join personal pe on
po.marca=pe.marca and numepren='Angajat4'
/
---------------------------------------------------------------------------------------------------------------
 select data as ziua
 from pontaje po inner join personal pe on
 po.marca=pe.marca and
 numepren='Angajat1' and
 to_char(data,'mm/yyyy')='07/2003'
 minus
 select data
 from pontaje po inner join personal pe
 on po.marca=pe.marca
 and numepren='Angajat7'
 /
------------------------------------------------------------------------------------------------------------
 merge into salarii sa using
 (select extract (year from data) as an,
 extract (month from data) as luna,
 marca, sum(orelucrate) as orelucrate,
 sum(oreco) as oreco
 from pontaje
 where extract(year from data)=2003 and
 extract(month from data)=8
 group by extract(year from data), extract(month from data), marca
 ) po
 on (sa.an=po.an and sa.luna=po.luna and
 sa.marca=po.marca)
 when matched then
 update set sa.orelucrate=sa.orelucrate+po.orelucrate,
 sa.oreco=sa.oreco+po.oreco
 when not matched then
 insert (sa.an,sa.luna,sa.marca,sa.orelucrate,
 sa.oreco) values (po.an, po.luna, po.marca,
 po.orelucrate,po.oreco)
/
-------------------------------------------------------------------------------------------------------------------
select p.marca,numepren, compart,orelucrate
as ore_lucr_aug, oreco as ore_co_aug
from personal p inner join salarii s on p.marca=s.marca
and an=2003 and luna=5
/
------------------------------------------------------------------------------------------------------------------
 select p.marca, numepren
 from salarii s right outer join personal p
 on s.marca=p.marca and an = 2003 and luna = 8
 where s.marca is null
 /
------------------------------------------------------------------------------------------------------------------
select object_name, object_id, created,
last_ddl_time, status
from user_objects
where object_type='trigger'
/
---------------------------------------------------------------------------------------------------------------
