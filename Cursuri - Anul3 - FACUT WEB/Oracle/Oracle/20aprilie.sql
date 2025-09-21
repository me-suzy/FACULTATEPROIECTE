 create or replace trigger trg_personal_ins_befo_row
 before insert on personal
 referencing old as old new as new
 for each row
 begin 
 select max(marca)+1 into :new.marca from personal;
 end;
 /
------------------------------------------------------------
insert into personal values(5555,'Sal Nou','conta',sysdate,0,0,'D')
/
-----------------------------------------------------------------
create sequence seq_marca
increment by 1
minvalue 1100
maxvalue 9999
nocycle
nocache
order
/
--------------------------------------------------------------
create or replace trigger trg_personal_ins_befo_row
 before insert on personal
 referencing old as old new as new
 for each row
 begin 
select seq_marca.nextval into :new.marca from dual;
end;
/
------------------------------------------------------------------
insert into personal values(5555,'Sal Nou2','conta',sysdate,0,0,'D');
-----------------------------------------------------------------------
create or replace trigger trg_personal_upd_after_row
after update of marca on personal
for each row
begin
update pontaje set marca=:new.marca where marca=:old.marca;
update sporuri set marca=:new.marca where marca=:old.marca;
update retineri set marca=:new.marca where marca=:old.marca;
update salarii set marca=:new.marca where marca=:old.marca;
end;
/
------------------------------------------------------------------------------
update personal set marca = 1110 where marca = 1001;
-------------------------------------------------------------------------------
 create or replace package pachet_salarizare as
 v_regula_personal_upd char(1) :='R';
 v_regula_personal_del char(1) :='R';
 function f_marca_in_pontaje(p_marca pontaje.marca %type)
 return boolean;
 function f_exista_sal_sp_ret(p_tabela varchar,p_marca salarii.marca %type,
 p_an salarii.an %type, p_luna salarii.luna %type)return boolean;
 function f_procent_sv(p_dstsc date, p_datad date)
 return transe_sv.procent_sv %type;
 end pachet_salarizare;
 /
------------------------------------------------------------------------------------
create or replace body procent_salarizare as
function f_marca_in_pontaje(p_marca pontaje.marca %type)
return boolean is
rezultat number(1);
begin
select disctinct 1 intorezultat from pontaje where marca=p_marca;
return true;
exception
when no_data_found then return false;
end f_marca_in_pontaje;
function f_exista_sal_sp_vech(p_marca pontaje.marca %type) return boolean is
rezultat number(1);
begin
case
when upper(p_table)='salarii' then
select distinct 1 into rezultat from salarii
where marca=p_marca and an=p_an and luna=p_luna;
when sporuri(p_tabela='sporuri' then
select distinct 1 into rezultat from sporuri
when upper(p-tabela)='retineri' then
select distinct 1 into rezultat from  retineri
oterwise