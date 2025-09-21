PARAMETER pmenu
DEFINE POPUP shortcut SHORTCUT RELATIVE FROM MROW(),MCOL()
DO CASE
CASE pmenu = 1
DEFINE BAR 1 OF shortcut PROMPT "clienti"
DEFINE BAR 2 OF shortcut PROMPT "contracte_agenti"
DEFINE BAR 3 OF shortcut PROMPT "imobile"
ON SELECTION BAR bar 1 OF shortcut do menuoption with 11
ON SELECTION BAR bar 2 OF shortcut do menuoption with 12

CASE pmenu = 2
DEFINE BAR 1 OF shortcut PROMPT "raport_contracte"
DEFINE BAR 2 OF shortcut PROMPT "raport_incasari"
DEFINE BAR 3 OF shortcut PROMPT "raport_agenti"
DEFINE BAR 4 OF shortcut PROMPT "raport_clienti"
ON SELECTION BAR bar 1 OF shortcut do menuoption with 21
ON SELECTION BAR bar 2 OF shortcut do menuoption with 22
ON SELECTION BAR bar 3 OF shortcut do menuoption with 23

ENDCASE

ACTIVATE POPUP shortcut

PROCEDURE menuoption
PARAMETERS opt_
DO hide_menubar
DO case
CASE opt_ = 11 && Formular clienti
DO FORM clienti
CASE opt_ = 12 && Formular contracte
DO FORM contracte_agenti
CASE opt_ = 13 && Formular imobile
DO FORM imobile
CASE opt_ = 21 && Raport contracte
REPORT FORM raport_complex_contracte preview
CASE opt_ = 22 && Raport incasari
REPORT FORM raport_complex_incasari preview
CASE opt_ = 23 && Raport agenti
REPORT FORM raport_simplu_agenti preview
CASE opt_ = 24 && Raport clienti
REPORT FORM raport_simplu_clienti preview
ENDCASE

DO activate_menu

PROCEDURE hide_menubar
FOR k=1 to_screen.formcount
IF LOWER(_screen.forms(k).name)='menubar'
EXIT
ENDIF
ENDFOR
_screen.forms(k).hide

PROCEDURE activate_menu
FOR k=1 to_screen.formcount
IF LOWER(_screen.forms(k).name)='statusbar'
EXIT
ENDIF
ENDFOR
_screen.forms(k).cmdMenu.enabled=.T.