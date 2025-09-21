nrcanal=SQLCONNECT('Connect1')
IF nrcanal<0
MESSAGEBOX('conexiune esuata')
RETURN
ENDIF
IF SQLEXEC(nrcanal,'select from clienti','cClienti')>0
SELECT cClienti
BROWSE
Endif