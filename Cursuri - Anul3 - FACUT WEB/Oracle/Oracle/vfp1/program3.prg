local v_luna, v_anul, v_data
dimension lst_co(3), lst_on(2), lst_abs(2)
set century on
set date to brit
set strictdate to 0
v_luna=10
v_anul=2003
lst_co(1)=1003
lst_co(2)=1004
lst_co(3)=1005
lst_on(1)=1002
lst_on(2)=1006
lst_abs(1)=1001
lst_abs(2)=1007

if !used('personal')
use personal in 0
endif

if !used ('pontaje')
use pontaje in 0
endif
select pontaje
delete all
pack
for v_luna=1 to 12
do case
case inlist(v_luna,1,3,5,7,8,10,12)
nrzile=31
case v_luna=2
nrzile=28
otherwise
nrzile=30
endcase
for i=1 to nrzile
v_data=ctod(str(i)+"/"+str(v_luna)+"/"+str(v_anul))
select personal
scan for !inlist(dow(v_data),1,7)
do case
case between (v_data,{17/09/2003},{17/10/2003}) and; 
inlist(personal.marca,lst_co(1),lst_co(2),lst_co(3))
insert into pontaje(marca,data,oreco);
values (personal.marca,v_data,8)
case inlist(dow(v_data),3,5) and;
inlist (personal.marca,lst_on(1),lst_on(2))
insert into pontaje (marca,data,orelucrate,orenoapte);
values(personal.marca,v_data,8,4)
case inlist(v_data,{15/10/2003},{22/10/2003}) and;
inlist (personal.marca,lst_abs(1),lst_abs(2))
insert into pontaje (marca,data,orelucrate,oreabsnem);
values (personal.marca,v_data,6,2)
otherwise
insert into pontaje(marca,data,orelucrate);
values(personal.marca,v_data,8)
endcase
endscan
endfor
endfor