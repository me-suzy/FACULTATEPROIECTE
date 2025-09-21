

if !used ('reparatii')
use reparatii in 0
endif

if !used ('componente')
use componente in 0
endif


select componente
scan
select reparatii
seek componente.codcompo order tag codcompo
replace pretreparatie with componente.pretcompo*(15/100);
while reparatii.codcompo=componente.codcompo and reparatii.grad_defect<2 
replace pretreparatie with componente.pretcompo*(35/100);
while reparatii.codcompo=componente.codcompo and reparatii.grad_defect<3 
replace pretreparatie with componente.pretcompo;
while reparatii.codcompo=componente.codcompo and reparatii.grad_defect<4 

endscan
