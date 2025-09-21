 insert into sporuri(marca,an,luna)
 select  distinct marca,
 extract(year from data),
 extract(month from data)
 from pontaje
 /
------------------------------------------
 insert into salarii(marca,an,luna,orelucrate)
 select marca,
 extract(year from data),
 extract(month from data),
 sum(p.orelucrate) from pontaje p
 group by marca,
 extract(year from data),
  extract(month from data);
---------------------------------------------
 update sporuri s
 set s.orenoapte=
 (select sum(p.orenoapte)
 from pontaje p
 group by p.marca,
 extract(year from data),
 extract(month from data)
 having p.marca=s.marca and
 s.an=extract(year from data) and
 s.luna=extract(month from data))
 /