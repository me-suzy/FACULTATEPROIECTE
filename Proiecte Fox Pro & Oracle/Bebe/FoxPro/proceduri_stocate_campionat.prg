********************************************************************************************************************************	
************************************************** Triggere pentru JUDETE ******************************************************
********************************************************************************************************************************

PROCEDURE trg_del_judete
IF !USED("localitati")
	USE localitati IN 0
ENDIF
set_deleted_=set('delete')
set delete on
IF INDEXSEEK(judete.jud,.F.,"localitati", "jud")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA linii cu judetul "+ judete.jud+ " in tabela Localitati!")
			RETURN .F.
			ENDIF
ENDPROC

PROCEDURE trg_upd_judete
	IF !USED("localitati")
		USE localitati IN 0
	ENDIF
jud_new=judete.jud
jud_old=oldval("jud","judete")
IF jud_old<>jud_new
	UPDATE localitati SET jud=jud_new;
		WHERE jud=jud_old
ENDIF
ENDPROC
******************************************************************************************************************************
**************************************************** Triggere pentru LOCALITATI **********************************************
******************************************************************************************************************************
PROCEDURE trg_ins_localitati
	IF !USED("judete")
		USE judete IN 0
	ENDIF
IF !INDEXSEEK(localitati.jud,.F.,"judete","jud")
	MESSAGEBOX("NU EXISTA inreg parinte cu judetul "+localitati.jud+chr(13)+;
	" in tabela Judete")
RETURN .F.
ENDIF
ENDPROC

PROCEDURE trg_upd_localitati
	IF !USED("judete")
		USE judete IN 0
	ENDIF
		***se verifica restrictia cu tabela parinte judete
jud_new_j=localitati.jud
jud_old_j=OLDVAL("jud","localitati")
	IF jud_new_j<>jud_old_j then
		IF _triggerlevel=1
			IF !INDEXSEEK(jud_new_j,.F.,"judete","jud")
			MESSAGEBOX("NU EXISTA judetul cu indicativul "+jud_new_j +chr(13)+;
			" in tabela Judete")
			RETURN .F.
			ENDIF
		ENDIF
			
	ENDIF
		***modificarile codului postal din tabela localitati se propaga si in 
		***tabelele copii Stadioane si Echipe
codpost_new=localitati.codpost 
codpost_old=oldval("codpost","localitati")
	if codpost_new<>codpost_old
		update stadioane set codpost=codpost_new;
			where  codpost=codpost_old
		update echipe set codpost=codpost_new;
			where  codpost=codpost_old
	endif
ENDPROC

PROCEDURE trg_del_localitati
IF !USED("stadioane")
	USE stadioane IN 0
ENDIF
set_deleted_=set('delete')
set delete on
IF INDEXSEEK(localitati.codpost,.F.,"stadioane", "codpost")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA linii cu localitatea "+ localitati.codpost+ " in tabela stadioane!")
			RETURN .F.
			ENDIF
IF !USED("echipe")
	USE echipe IN 0
ENDIF
set_deleted_=set('delete')
set delete on
IF INDEXSEEK(localitati.codpost,.F.,"echipe", "codpost")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA linii cu localitatea "+ localitati.codpost+ " in tabela echipe!")
			RETURN .F.
			ENDIF
ENDPROC

******************************************************************************************************************************
*********************************************** Triggere pentru STADIOANE ****************************************************
******************************************************************************************************************************

PROCEDURE trg_ins_stadioane
	IF !USED("localitati")
		USE localitati IN 0
	ENDIF
IF !INDEXSEEK(stadioane.codpost,.F.,"localitati","codpost")
	MESSAGEBOX("NU EXISTA inreg parinte cu localitatea "+stadioane.codpost+chr(13)+;
	" in tabela localitati")
RETURN .F.
ENDIF
ENDPROC

PROCEDURE trg_upd_stadioane
	IF !USED("localitati")
		USE localitati IN 0
	ENDIF
		***se verifica restrictia cu tabela parinte localitati
codpost_new_c=stadioane.codpost
codpost_old_c=OLDVAL("codpost","stadioane")
	IF codpost_new_c<>codpost_old_c then
		IF _triggerlevel=1
			IF !INDEXSEEK(codpost_new_c,.F.,"stadioane","codpost")
			MESSAGEBOX("NU EXISTA localitatea cu indicativul "+codpost_new_c +chr(13)+;
			" in tabela Localitati")
			RETURN .F.
			ENDIF
		ENDIF
			
	ENDIF

	***modificarile codului stadionului din tabela stadioane se propaga si in tabela meciuri
codstad_new=stadioane.codstad 
codstad_old=oldval("codstad","stadioane")
	if codstad_new<>codstad_old
		update meciuri set codstad=codstad_new;
			where  codstad=codstad_old
		ENDIF
ENDPROC

PROCEDURE trg_del_stadioane
	IF !USED("meciuri")
		USE meciuri IN 0
	ENDIF
set_deleted_=set('delete')
set delete on
	IF INDEXSEEK(stadioane.codstad,.F.,"meciuri", "codstad")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA inregistrari cu codul stadionului "+ stadioane.codstad+ chr(13)+;
			 " in tabela copil meciuri!")
			RETURN .F.
	ENDIF
ENDPROC
*******************************************************************************************************************************
************************************************ Triggere pentru DIVIZII ******************************************************
*******************************************************************************************************************************	

PROCEDURE trg_del_divizii
IF !USED("echipe")
	USE echipe IN 0
ENDIF
set_deleted_=set('delete')
set delete on
IF INDEXSEEK(divizii.coddiv,.F.,"echipe", "coddiv")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA linii cu divizia "+ divizii.coddiv+ " in tabela echipe!")
			RETURN .F.
			ENDIF
ENDPROC

PROCEDURE trg_upd_divizii
	IF !USED("echipe")
		USE echipe IN 0
	ENDIF
coddiv_new=divizii.coddiv
coddiv_old=oldval("coddiv","divizii")
IF coddiv_old<>coddiv_new
	UPDATE echipe SET coddiv=coddiv_new;
		WHERE coddiv=coddiv_old
ENDIF
ENDPROC
*******************************************************************************************************************************
************************************************* Triggere pentru ECHIPE ******************************************************
*******************************************************************************************************************************
PROCEDURE trg_ins_echipe
	IF !USED("divizii")
		USE divizii IN 0
	ENDIF
IF !INDEXSEEK(echipe.coddiv,.F.,"divizii","coddiv")
	MESSAGEBOX("NU EXISTA divizia "+divizii.coddiv+chr(13)+;
	" in tabela Divizii")
RETURN .F.
ENDIF

IF !USED("localitati")
		USE localitati IN 0
	ENDIF
IF !INDEXSEEK(echipe.codpost,.F.,"localitati","codpost")
	MESSAGEBOX("NU EXISTA localitatea "+divizii.codpost+chr(13)+;
	" in tabela i")
RETURN .F.
ENDIF

ENDPROC

PROCEDURE trg_upd_echipe
	IF !USED("divizii")
		USE divizii IN 0
	ENDIF
		***se verifica restrictia cu tabela parinte divizii
coddiv_new=echipe.coddiv
coddiv_old=OLDVAL("coddiv","echipe")
	IF coddiv_new<>coddiv_old then
		IF _triggerlevel=1
			IF !INDEXSEEK(coddiv_new,.F.,"divizii","coddiv")
			MESSAGEBOX("NU EXISTA divizia cu indicativul "+coddiv_new +chr(13)+;
			" in tabela Divizii")
			RETURN .F.
			ENDIF
		ENDIF
			
	ENDIF
	
		IF !USED("localitati")
		USE localitati IN 0
	ENDIF
		***se verifica restrictia cu tabela parinte localitati
codpost_new=echipe.codpost
codpost_old=OLDVAL("codpost","echipe")
	IF codpost_new<>codpost_old then
		IF _triggerlevel=1
			IF !INDEXSEEK(codpost_new,.F.,"localitati","codpost")
			MESSAGEBOX("NU EXISTA localitatea cu codul "+codpost_new +chr(13)+;
			" in tabela localitati")
			RETURN .F.
			ENDIF
		ENDIF
			
	ENDIF
	
	IF !USED("jucatori")
		USE jucatori IN 0
	ENDIF
idech_new=echipe.idech
idech_old=oldval("idech","echipe")
IF idech_old<>idech_new
	UPDATE jucatori SET idech=idech_new;
		WHERE idech=idech_old
ENDIF

	IF !USED("meciuri")
		USE meciuri IN 0
	ENDIF
idech_new=echipe.idech
idech_old=oldval("idech","echipe")
IF idech_old<>idech_new
	UPDATE meciuri SET idech1=idech_new;
		WHERE idech1=idech_old
	UPDATE meciuri SET idech2=idech_new;
		WHERE idech2=idech_old
ENDIF
IF !USED("transferuri")
		USE transferuri IN 0
	ENDIF
idech_new=echipe.idech
idech_old=oldval("idech","echipe")
IF idech_old<>idech_new
	UPDATE transferuri SET idechp=idech_new;
		WHERE idechp=idech_old
	UPDATE transferuri SET idechn=idech_new;
		WHERE idechn=idech_old
ENDIF
ENDPROC

PROCEDURE trg_del_echipe
	IF !USED("meciuri")
		USE meciuri IN 0
	ENDIF
set_deleted_=set('delete')
set delete on
	IF INDEXSEEK(echipe.idech,.F.,"meciuri", "idech1")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA inregistrari cu echipa "+ echipe.idech+ chr(13)+;
			 " in tabela copil Meciuri!")
			RETURN .F.
	ENDIF
	IF INDEXSEEK(echipe.idech,.F.,"meciuri", "idech2")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA inregistrari cu echipa "+ echipe.idech+ chr(13)+;
			 " in tabela copil Meciuri!")
			RETURN .F.
	ENDIF
	
	IF !USED("transferuri")
		USE transferuri IN 0
	ENDIF
set_deleted_=set('delete')
set delete on
	IF INDEXSEEK(echipe.idech,.F.,"transferuri", "idechp")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA inregistrari cu echipa "+ echipe.idech+ chr(13)+;
			 " in tabela copil transferuri!")
			RETURN .F.
	ENDIF
	IF INDEXSEEK(echipe.idech,.F.,"transferuri", "idechn")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA inregistrari cu echipa "+ echipe.idech+ chr(13)+;
			 " in tabela copil transferuri!")
			RETURN .F.
	ENDIF
	ENDPROC


**********************************************************************************************************************************
********************************************* Triggere pentru JUCATORI ***********************************************************
**********************************************************************************************************************************	
	
PROCEDURE trg_del_jucatori
IF !USED("contract")
	USE contract IN 0
ENDIF
set_deleted_=set('delete')
set delete on
IF INDEXSEEK(jucatori.codjuc,.F.,"contract", "codjuc")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA linii cu jucatorul "+ jucatori.codjuc+ " in tabela Contract!")
			RETURN .F.
			ENDIF
			
			IF !USED("transferuri")
		USE transferuri IN 0
	ENDIF
set_deleted_=set('delete')
set delete on
	IF INDEXSEEK(jucatori.codjuc,.F.,"transferuri", "codjuc")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA inregistrari cu jucatorul "+jucatori.codjuc+ chr(13)+;
			 " in tabela copil Transferuri!")
			RETURN .F.
	ENDIF
ENDPROC

PROCEDURE trg_upd_jucatori
	IF !USED("contract")
		USE contract IN 0
	ENDIF
codjuc_new=jucatori.codjuc
codjuc_old=oldval("codjuc","jucatori")
IF codjuc_old<>codjuc_new
	UPDATE contract SET codjuc=codjuc_new;
		WHERE codjuc=codjuc_old
		
		update transferuri set codjuc=codjuc_new;
			where  codjuc=codjuc_old
ENDIF
		***se verifica restrictia cu tabela parinte echipe
		IF !USED("echipe")
		USE echipe IN 0
	ENDIF
idech_new=jucatori.idech
idech_old=OLDVAL("idech","jucatori")
	IF idech_new<>idech_old then
		IF _triggerlevel=1
			IF !INDEXSEEK(idech_new,.F.,"echipe","idech")
			MESSAGEBOX("NU EXISTA echipa cu indicativul "+idech_new +chr(13)+;
			" in tabela Echipe")
			RETURN .F.
			ENDIF
		ENDIF
			
	ENDIF

ENDPROC

PROCEDURE trg_ins_jucatori
	IF !USED("echipe")
		USE echipe IN 0
	ENDIF
IF !INDEXSEEK(jucatori.idech,.F.,"echipe","idech")
	MESSAGEBOX("NU EXISTA inreg parinte cu echipa "+jucatori.idech+chr(13)+;
	" in tabela Echipe")
RETURN .F.
ENDIF
ENDPROC
****************************************************************************************************************************
************************************************ Trigere pentru CONTRACT ***************************************************
****************************************************************************************************************************

PROCEDURE trg_ins_contract
	IF !USED("jucatori")
		USE jucatori IN 0
	ENDIF
IF !INDEXSEEK(contract.codjuc,.F.,"jucatori","codjuc")
	MESSAGEBOX("NU EXISTA inreg parinte cu jucatorul "+contract.codjuc+chr(13)+;
	" in tabela Jucatori")
RETURN .F.
ENDIF
ENDPROC

PROCEDURE trg_upd_contract
	IF !USED("jucatori")
		USE jucatori IN 0
	ENDIF
		***se verifica restrictia cu tabela parinte jucatori
codjuc_new=contract.codjuc
codjuc_old=OLDVAL("codjuc","contract")
	IF codjuc_new<>codjuc_old then
		IF _triggerlevel=1
			IF !INDEXSEEK(codjuc_new,.F.,"jucatori","codjuc")
			MESSAGEBOX("NU EXISTA jucatorul cu indicativul "+codjuc_new +chr(13)+;
			" in tabela Jucatori")
			RETURN .F.
			ENDIF
		ENDIF
			
	ENDIF

ENDPROC

PROCEDURE trg_del_contract
IF !USED("jucatori")
	USE jucatori IN 0
ENDIF
set_deleted_=set('delete')
set delete on
IF INDEXSEEK(contract.codjuc,.F.,"contract", "codjuc")
			set delete &set_deleted_
			MESSAGEBOX("EXISTA linii cu jucatorul "+ contract.codjuc+ " in tabela jucatori!")
			RETURN .F.
			ENDIF
ENDPROC
*********************************************************************************************************************************	
*********************************************** Triggere pentru MECIURI *************************************************************
*********************************************************************************************************************************

PROCEDURE trg_upd_meciuri
	IF !USED("stadioane")
		USE stadioane IN 0
	ENDIF
		***se verifica restrictia cu tabela parinte stadioane
codstad_new=meciuri.codstad
codstad_old=OLDVAL("codstad","meciuri")
	IF codstad_new<>codstad_old then
		IF _triggerlevel=1
			IF !INDEXSEEK(codstad_new,.F.,"stadioane","codstad")
			MESSAGEBOX("NU EXISTA stadionul cu indicativul "+codstad_new +chr(13)+;
			" in tabela Stadioane")
			RETURN .F.
			ENDIF
		ENDIF
			
	ENDIF

		***se verifica restrictia cu tabela parinte echipe
	IF !USED("echipe")
		USE echipe IN 0
	ENDIF	
idech1_new=meciuri.idech1
idech1_old=OLDVAL("idech1","meciuri")
	IF idech1_new<>idech1_old then
		IF _triggerlevel=1
			IF !INDEXSEEK(idech1_new,.F.,"echipe","idech1")
			MESSAGEBOX("NU EXISTA echipa cu indicativul "+idech1_new +chr(13)+;
			" in tabela Echipe")
			RETURN .F.
			ENDIF
		ENDIF
			
	ENDIF	

	IF !USED("echipe")
		USE echipe IN 0
	ENDIF
		***se verifica restrictia cu tabela parinte echipe
idech2_new=meciuri.idech2
idech2_old=OLDVAL("idech2","meciuri")
	IF idech2_new<>idech2_old then
		IF _triggerlevel=1
			IF !INDEXSEEK(idech2_new,.F.,"echipe","idech2")
			MESSAGEBOX("NU EXISTA echipa cu indicativul "+idech2_new +chr(13)+;
			" in tabela Echipe")
			RETURN .F.
			ENDIF
		ENDIF
			
	ENDIF	
ENDPROC
	
	
PROCEDURE trg_ins_meciuri
	********
	IF !USED("stadioane")
		USE stadioane IN 0
	ENDIF
IF !INDEXSEEK(meciuri.codstad,.F.,"stadioane","codstad")
	MESSAGEBOX("NU EXISTA inreg parinte cu stadionul "+meciuri.codstad+chr(13)+;
	" in tabela Stadioane")
RETURN .F.
ENDIF
	*****
	IF !USED("echipe")
		USE echipe IN 0
	ENDIF
IF !INDEXSEEK(meciuri.idech1,.F.,"echipe","idech1")
	MESSAGEBOX("NU EXISTA inreg parinte cu echipa "+meciuri.idech1+chr(13)+;
	" in tabela Echipe")
RETURN .F.
ENDIF
	*******
	IF !USED("echipe")
		USE echipe IN 0
	ENDIF
IF !INDEXSEEK(meciuri.idech2,.F.,"echipe","idech2")
	MESSAGEBOX("NU EXISTA inreg parinte cu echipa "+meciuri.idech2+chr(13)+;
	" in tabela Echipe")
RETURN .F.
ENDIF
ENDPROC



*********************************************************************************************************************************	
*********************************************** Triggere pentru TRANSFERURI *****************************************************
*********************************************************************************************************************************

PROCEDURE trg_upd_transferuri
	IF !USED("jucatori")
		USE jucatori IN 0
	ENDIF
		***se verifica restrictia cu tabela parinte jucatori
codjuc_new=transferuri.codjuc
codjuc_old=OLDVAL("codjuc","transferuri")
	IF codjuc_new<>codjuc_old then
		IF _triggerlevel=1
			IF !INDEXSEEK(codjuc_new,.F.,"jucatori","codjuc")
			MESSAGEBOX("NU EXISTA jucatorul cu indicativul "+codjuc_new +chr(13)+;
			" in tabela Jucatori")
			RETURN .F.
			ENDIF
		ENDIF		
	ENDIF
	*****
	IF !USED("echipe")
		USE echipe IN 0
	ENDIF
		***se verifica restrictia cu tabela parinte echipe
idechn_new=transferuri.idechn
idechn_old=OLDVAL("idechn","transferuri")
	IF idechn_new<>idechn_old then
		IF _triggerlevel=1
			IF !INDEXSEEK(idechn_new,.F.,"echipe","idechn")
			MESSAGEBOX("NU EXISTA echipa cu indicativul "+idechn_new +chr(13)+;
			" in tabela Echipe")
			RETURN .F.
			ENDIF
		ENDIF
			
	ENDIF
	******
	IF !USED("echipe")
		USE echipe IN 0
	ENDIF
		***se verifica restrictia cu tabela parinte echipe
idechp_new=transferuri.idechp
idechp_old=OLDVAL("idechp","transferuri")
	IF idechp_new<>idechp_old then
		IF _triggerlevel=1
			IF !INDEXSEEK(idechp_new,.F.,"echipe","idechp")
			MESSAGEBOX("NU EXISTA echipa cu indicativul "+idechp_new +chr(13)+;
			" in tabela Echipe")
			RETURN .F.
			ENDIF
		ENDIF
			
	ENDIF
ENDPROC

PROCEDURE trg_ins_transferuri
	IF !USED("jucatori")
		USE jucatori IN 0
	ENDIF
IF !INDEXSEEK(transferuri.codjuc,.F.,"jucatori","codjuc")
	MESSAGEBOX("NU EXISTA inreg parinte cu jucatorul "+transferuri.codjuc+chr(13)+;
	" in tabela Jucatori")
RETURN .F.
ENDIF

	*****
	IF !USED("echipe")
		USE echipe IN 0
	ENDIF
IF !INDEXSEEK(transferuri.idechn,.F.,"echipe","idechn")
	MESSAGEBOX("NU EXISTA inreg parinte cu echipa "+transferuri.idechn+chr(13)+;
	" in tabela Echipe")
RETURN .F.
ENDIF
	*****
	IF !USED("echipe")
		USE echipe IN 0
	ENDIF
IF !INDEXSEEK(transferuri.idechp,.F.,"echipe","idechp")
	MESSAGEBOX("NU EXISTA inreg parinte cu echipa "+transferuri.idechp+chr(13)+;
	" in tabela Echipe")
RETURN .F.
ENDIF
ENDPROC







































	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	










