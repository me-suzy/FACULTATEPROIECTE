create sql view vreparatii as ;
select codrepar,codcl,codchitara,codcompo,datarepar,grad_defect,nr_reparatii,pretreparatie from reparatii

dbsetprop('vreparatii','view','tables','reparatii')

dbsetprop('vreparatii.codrepar','field','keyfield',.t.)

dbsetprop('vreparatii.codrepar','field','updatename','reparatii.codrepar')
dbsetprop('vreparatii.codcl','field','updatename','reparatii.codcl')
dbsetprop('vreparatii.codchitara','field','updatename','reparatii.codchitara')
dbsetprop('vreparatii.codcompo','field','updatename','reparatii.codcompo')
dbsetprop('vreparatii.datarepar','field','updatename','reparatii.datarepar')
dbsetprop('vreparatii.grad_defect','field','updatename','reparatii.grad_defect')
dbsetprop('vreparatii.nr_reparatii','field','updatename','reparatii.nr_reparatii')

dbsetprop('vreparatii.codrepar','field','defaultvalue','def_codrepar_reparatii()')
dbsetprop('vreparatii.nr_reparatii','field','defaultvalue','def_nr()')
dbsetprop('vreparatii.codcompo','field','ruleexpression','pret_vreparatii()')
dbsetprop('vreparatii.grad_defect','field','ruleexpression','pret_vreparatii()')

dbsetprop('vreparatii.codrepar','field','updatable',.t.)
dbsetprop('vreparatii.codcl','field','updatable',.t.)
dbsetprop('vreparatii.codchitara','field','updatable',.t.)
dbsetprop('vreparatii.codcompo','field','updatable',.t.)
dbsetprop('vreparatii.datarepar','field','updatable',.t.)
dbsetprop('vreparatii.grad_defect','field','updatable',.t.)
dbsetprop('vreparatii.nr_reparatii','field','updatable',.t.)
dbsetprop('vreparatii.pretreparatie','field','updatable',.t.)

dbsetprop('vreparatii','view','sendupdates',.t.)
