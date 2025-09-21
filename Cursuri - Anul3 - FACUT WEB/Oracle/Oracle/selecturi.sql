 insert into transe_sv values(0,3,0);



 insert into transe_sv values(3,5,5);



 insert into transe_sv values(5,10,10);

w created.

 insert into transe_sv values(10,15,20);

w created.

 insert into transe_sv values(15,20,25);

w created.

 insert into transe_sv values(25,99,30);

w created.

 commit






select procent_sv from transe_sv
where 
trunc(months_between(date'2004-04-01',date'1998-03-19')/12,0)>=ani_limita_inf and
trunc(months_between(date'2004-04-01',date'1998-03-19')/12,0)<ani_limita_sup
/





 select marca,procent_sv from personal p  inner join
 transe_sv t on
 trunc(months_between(date'2004-04-01',p.datasv)/12,0)>=t.ani_limita_inf and
 trunc(months_between(date'2004-04-01',p.datasv)/12,0)<t.ani_limita_sup
 /







 select p.marca, extract(year from po.data), extract(month from po.data),
 sum(po.orelucrate * p.salorar)+sum(po.oreco * p.salorarco)
 from personal p inner join pontaje po on p.marca=po.marca
 group by p.marca, extract(year from po.data),
 extract(month from po.data)





 update sporuri s set s.spvech=(
 select sum(po.orelucrate * p.salorar * t.procent_sv/100)+
 sum(po.oreco * p.salorarco * t.procent_sv/100)
 from
 personal p inner join pontaje po on p.marca=po.marca
 inner join transe_sv t on
 trunc(months_between(to_date('01'||'/'||to_char(po.data,'mm/yyyy'),'dd/mm/yyyy'),p.datasv)/12,0)>=t.ani_limita_inf and
 trunc(months_between(to_date('01'||'/'||to_char(po.data,'mm/yyyy'),'dd/mm/yyyy'),p.datasv)/12,0)<t.ani_limita_sup
 group by p.marca, extract(year from po.data),
 extract(month from po.data)
 having p.marca=s.marca and extract(year from po.data)=s.an
 and extract(month from po.data)=s.luna)
 /




 create or replace function f_procent_sv(
 p_datac date, p_datav date) return transe_sv.procent_sv%type
 is
 v_procent transe_sv.procent_sv%type;
 begin
 select procent_sv into v_procent from transe_sv
 where trunc(months_between(p_datac,p_datav)/12,0)>=ani_limita_inf
 and trunc(months_between(p_datac,p_datav)/12,0)<ani_limita_sup;
 return v_procent;
 exception
 when no_data_found  then return 0;
 end;
 /





select marca, f_procent_sv(date'2004-04-01',datasv)as procent
from personal
/
commit






