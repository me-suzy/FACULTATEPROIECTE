create sql view vgrad_defectiune as ;
select grad_defect,decizie,numegrad,proc_defect from grad_defectiune

dbsetprop('vgrad_defectiune','view','tables','grad_defectiune')

dbsetprop('vgrad_defectiune.grad_defect','field','keyfield',.t.)

dbsetprop('vgrad_defectiune.grad_defect','field','updatename','grad_defectiune.grad_defect')
dbsetprop('vgrad_defectiune.numegrad','field','updatename','grad_defectiune.numegrad')
dbsetprop('vgrad_defectiune.proc_defect','field','updatename','grad_defectiune.proc_defect')
dbsetprop('vgrad_defectiune.decizie','field','updatename','grad_defectiune.decizie')

dbsetprop('vgrad_defectiune.grad_defect','field','updatable',.t.)
dbsetprop('vgrad_defectiune.numegrad','field','updatable',.t.)
dbsetprop('vgrad_defectiune.proc_defect','field','updatable',.t.)
dbsetprop('vgrad_defectiune.decizie','field','updatable',.t.)

dbsetprop('vgrad_defectiune','view','sendupdates',.t.)