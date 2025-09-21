  Declare
 a integer:=4;
 b integer:=8;
 c integer:=2;
 delta number(16,2);
 x1 number(16,2);
 x2 number(16,2);
 begin
 if a=0 then
  if b=0 then
   if c=0 then
    DBMS_OUTPUT.PUT_LINE('Nedeterminare!');
     else
    DBMS_OUTPUT.PUT_LINE('Ecuatie invalida!');
   end if;
 else
x1:=-c/b;
 DBMS_OUTPUT.PUT_LINE('Ec. Grd. I x='||x1);
 end if;
else
 delta:=b**2-4*a*c;
 if delta>0 then
 x1:=(-b-sqrt(delta))/(2*a);
x2:=(-b+sqrt(delta))/(2*a);
 DBMS_OUTPUT.PUT_LINE('Ec. grd.2, x1='||x1||',x2='||x2);
else
if delta=0 then
x1:=-b/(2*a);
 DBMS_OUTPUT.PUT_LINE('Ec.grd.2,x1=x2'||x1);
 else
  DBMS_OUTPUT.PUT_LINE('Solutii complexe');
end if;
end if;
end if;
end;
---------------------------------------------------------------------------------------
declare
 an salarii.an %type:=2003;
 luna salarii.luna %type:=3;
 prima_zi date;
 zi date;
 begin
 prima_zi:=to_date('01'||'/'||luna||'/'||an,'dd/mm/yyyy');
 zi:=prima_zi;
 while zi<=last_day(prima_zi) loop
 if to_char(zi,'day') not in ('SATURDAY','SUNDAY') then
 insert into pontaje(marca,data) select marca,zi From Personal;
 end if;
 zi:=zi+1;
 end loop;
 end;
-------------------------------------------------------------------------------------------
SQL> select uc.constraint_name, uc.r_constraint_name, ucc.table_name,ucc_column_name from user_const
raints uc, user_cons_columns ucc where uc.r_constraint_name=ucc.constraint_name;
-----------------------------------------------------------------------------------------------
 declare
 zi, data
 an salarii.an %type :=2003
 luna salarii.luna %type :=3
 prima_zi date;
 begin
 prima_zi:=to_date('1'||'/'||luna||'/'||an,'dd/mm/yyyy');
 zi:=prima_zi;
 while zi<=last_day(prima_zi) loop
 declare
 begin
 insert into pontaje(marca,data) select marca,zi from personal;
 exception
 when dup_val_on_index then
 dbms.output.put_line('Pt reinserare sterg inregistrarile din data'||to_char(zi,'dd/mm/yyyy'));
 delete from pontaje where data=zi;
 insert into pontaje(marca,data) select marca,zi from personal;
 end;
 zi:=zi+1
 end loop

 
 open c_personal;
 fetch c_personal into rec_c_personal;
 where c_personal%found loop
 fetch....
 end loop;
 close c_personal
 

  declare
 an salarii.an%type :=2004
 luna salarii.luna%type;
 prima_zi date;
 zi date;
 cursor c_personal is
 select marca, numepren from personal;
 rec_c_personal c_personal%rowtype;
 begin
 for rec_c_personal in c_personal loop
 for luna in 1..12 loop
 prima_zi:=to_date('01'||'/'||luna||'/'||an,'dd/mm/yyyy');
 for zi in prima_zi..last_day(prima_zi) loop
 if rtrim(ltrim(to_char(zi,'day'))) not in ('saturday','sunday') then
 case
 when rec_c_personal.marca in (1001,1005) and
 rtrim(ltrim(to_char(zi,'day'))) in ('monday','thursday') then
 insert into pontaje (marca,data,oreLucrate,oreNoapte)
 values(rec_c_personal.marca,zi,8,6);
 when rec_c_personal.marca in ('1002','1006') and
 zi between to_date('1/03/2004','dd/mm/yyyy') and to_date('15/03/2004','dd/mm/yyyy') then
 insert into pontaje(marca,data,oreLucrate,oreCo)
 values(rec_c_personal.marca,zi,0,8);
 else
 insert into pontaje(marca,data,orelucrate)
 values(rec_c_personal.marca,zi,8);
 end case;
 end if;
 end loop;
 end loop;
 end loop;
-------------------------------------------------------------------------------------------------
