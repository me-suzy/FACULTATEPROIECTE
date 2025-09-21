SET CLASSLIB TO genclass, fmgrtest additive
RELEASE goFrmMgr
PUBLIC goFrmMgr
*** Create the Form Manager Object
goFrmMgr = newobject('xFrmMgr', 'formmgr.prg', NULL)
*** Now run some forms as both Class and SCX
*** With and Without Toolbars
goFrmMgr.Doform('btnbarfm')
_Screen.ActiveForm.Top = 10
_Screen.ActiveForm.Left = 20
goFrmMgr.Doform('btnbarfm',.T.)
_Screen.ActiveForm.Top = 10
_Screen.ActiveForm.Left = 366
goFrmMgr.Doform('cbobarfm')
_Screen.ActiveForm.Top = 53
_Screen.ActiveForm.Left = 94
goFrmMgr.Doform('cbobarfm',.T.)
_Screen.ActiveForm.Top = 53
_Screen.ActiveForm.Left = 440
goFrmMgr.Doform('notbarfm')
_Screen.ActiveForm.Top = 96
_Screen.ActiveForm.Left = 148
goFrmMgr.Doform('notbarfm',.T.)
_Screen.ActiveForm.Top = 96 
_Screen.ActiveForm.Left = 494
