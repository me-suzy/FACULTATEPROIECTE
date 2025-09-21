DROP TABLE puncte;
DROP TABLE meciuri_goluri;
DROP TABLE jucatori_meciuri;
DROP TABLE transferuri ;
DROP TABLE meciuri ;
DROP TABLE contract ;
DROP TABLE jucatori ;
DROP TABLE echipe ;
DROP TABLE divizii ;
DROP TABLE stadioane ;
DROP TABLE localitati ;
DROP TABLE judete ;

		
CREATE TABLE judete (
	jud VARCHAR2(2)
		CONSTRAINT pk_judete PRIMARY KEY 
		CONSTRAINT nn_judete_jud NOT NULL
	,judet VARCHAR2(25)
		CONSTRAINT nn_judete_judet NOT NULL
	,regiune VARCHAR2(15)
		CONSTRAINT nn_regiune_judete NOT NULL
		);

CREATE TABLE localitati (
	codpost NUMBER(4)
		CONSTRAINT pk_localitati PRIMARY KEY
		CONSTRAINT nn_localitati_codpost NOT NULL
		CONSTRAINT ck_localitati_codpost CHECK (codpost=LTRIM(codpost))
	,loc VARCHAR2(25)
		CONSTRAINT nn_localitati_loc NOT NULL
		CONSTRAINT ck_localitati_loc CHECK (loc=LTRIM(loc))
	,jud VARCHAR2(2)
		CONSTRAINT nn_localitati_jud NOT NULL
		CONSTRAINT ck_localitati_jud CHECK (jud=LTRIM(jud))
		CONSTRAINT fk_localitati_judete REFERENCES judete (jud)
		);

CREATE TABLE stadioane (
	codstad NUMBER(5)
		CONSTRAINT pk_stadioane PRIMARY KEY
		CONSTRAINT nn_stadioane_codstad NOT NULL
		CONSTRAINT ck_stadioane_codstad CHECK(codstad BETWEEN 100 AND 900)
	,numestad VARCHAR2(20)
		CONSTRAINT nn_stadioane_numestad NOT NULL	
		CONSTRAINT ck_stadioane_numestad CHECK (numestad=LTRIM(numestad))
	,capacitate NUMBER(10)
		CONSTRAINT un_stadioane_capacitate UNIQUE
	,codpost NUMBER(4)
		CONSTRAINT fk_stadioane_localitati REFERENCES localitati (codpost)
		);
	
CREATE TABLE divizii (
	coddiv VARCHAR2(1)
		CONSTRAINT pk_divizii PRIMARY KEY
		CONSTRAINT nn_divizii_coddiv NOT NULL
	,numediv VARCHAR2(10)
		CONSTRAINT nn_divizii_numediv NOT NULL
		CONSTRAINT ck_divizii_numediv CHECK (numediv=LTRIM(INITCAP(numediv)))
		);

CREATE TABLE echipe (
	idech NUMBER(2)
		CONSTRAINT pk_echipe PRIMARY KEY
		CONSTRAINT nn_echipe_idech NOT NULL
	,numeech VARCHAR2(20)
		CONSTRAINT nn_echipe_numeech NOT NULL
		CONSTRAINT ck_echipe_numeech CHECK (numeech=LTRIM(INITCAP(numeech)))
	,culori VARCHAR2(20)
	,telefon VARCHAR2(10)
	,nrjuc NUMBER(2)
		CONSTRAINT ck_echipe_nrjuc CHECK (nrjuc BETWEEN 1 AND 50)
		CONSTRAINT nn_echipe_nrjuc NOT NULL
	,codpost NUMBER(4)
		CONSTRAINT fk_echipe_localitati REFERENCES localitati (codpost)
		CONSTRAINT nn_echipe_codpost NOT NULL
	,coddiv VARCHAR2(1)
		CONSTRAINT nn_echipe_coddiv NOT NULL
		CONSTRAINT fk_echipe_divizii REFERENCES divizii (coddiv)
		);	

CREATE TABLE puncte (
	Punctaj NUMBER(4)
	CONSTRAINT pk_puncte PRIMARY KEY
	CONSTRAINT nn_puncte_punctaj NOT NULL 
	,Idech NUMBER(2) 
 		CONSTRAINT nn_puncte_idech NOT NULL
		CONSTRAINT fk_puncte_echipe REFERENCES echipe (idech)
	,Sezon VARCHAR2(20)
	,Nr_Mec_Juc NUMBER(4)
	,Nr_Mec_Cast NUMBER(4)
	,Nr_Mec_Pier NUMBER(4)
	,Nr_Mec_Egal NUMBER(4)
		);

	
CREATE TABLE jucatori (
	codjuc VARCHAR2(5)
		CONSTRAINT pk_jucatori PRIMARY KEY
		CONSTRAINT nn_jucatori_codjuc NOT NULL
	,nume VARCHAR2(20)
		CONSTRAINT nn_jucatori_nume NOT NULL
		CONSTRAINT ck_jucatori_nume CHECK (nume=LTRIM(INITCAP(nume)))
	,prenume VARCHAR2(20)
		CONSTRAINT nn_jucatori_prenume NOT NULL
		CONSTRAINT ck_jucatori_prenume CHECK (prenume=LTRIM(INITCAP(prenume)))
	,adresa VARCHAR2(40)
	,idech NUMBER(2)
		CONSTRAINT nn_jucatori_idech NOT NULL
		CONSTRAINT fk_jucatori_echipe REFERENCES echipe (idech)
	,cnp VARCHAR2(14)
	,telmobil VARCHAR2(10)
	,telacasa VARCHAR2(10)
	,email VARCHAR2(20)
		);

CREATE TABLE contract (
	codc NUMBER(10)
		CONSTRAINT pk_contract PRIMARY KEY
		CONSTRAINT nn_contract_codc NOT NULL
	,codjuc VARCHAR2(5)
		CONSTRAINT nn_contract_codjuc NOT NULL
		CONSTRAINT fk_contract_jucatori REFERENCES jucatori (codjuc)
	,datainc_c DATE
	,datarez_c DATE
	,sumac NUMBER(7)
	,clauzec VARCHAR2(40)
		);
	
CREATE TABLE meciuri (
	idmeci VARCHAR2(20)
		CONSTRAINT pk_meciuri PRIMARY KEY
		CONSTRAINT nn_meciuri_idmeci NOT NULL
	,datameci DATE
	,codstad NUMBER(4)
		CONSTRAINT nn_meciuri_codstad NOT NULL
		CONSTRAINT fk_meciuri_stadioane REFERENCES stadioane (codstad)
	,etapa NUMBER(2)
	,campionat VARCHAR2(10)
	,nrgolech1 NUMBER(2)
	,nrgolech2 NUMBER(2)
	,orainceput VARCHAR2(5)
	,orasfarsit VARCHAR2(5)
	,nrfault NUMBER(2)
	,cartRosu NUMBER(1)
	,cartGalb NUMBER(1)
	,nreliminari NUMBER(1)
	,nrjucschimb NUMBER(2)
		CONSTRAINT nn_meciuri_nrjucschimb NOT NULL
		CONSTRAINT ck_meciuri_nrjucschimb CHECK (nrjucschimb BETWEEN 0 AND 6)
	,idech1 NUMBER(2)
		CONSTRAINT nn_meciuri_idech1 NOT NULL
		CONSTRAINT fk_meciuri_echipe_idech1 REFERENCES echipe (idech)
	,idech2 NUMBER(2)
		CONSTRAINT nn_meciuri_idech2 NOT NULL
		CONSTRAINT fk_meciuri_echipe_idech2 REFERENCES echipe (idech)
		);

CREATE TABLE transferuri (
	idtran VARCHAR2(15)
		 CONSTRAINT nn_transferuri_idtran NOT NULL
		 CONSTRAINT pk_transferuri PRIMARY KEY
	,codjuc VARCHAR2(5)
		CONSTRAINT nn_transferuri_codjuc NOT NULL
		CONSTRAINT fk_transferuri_jucatori REFERENCES jucatori (codjuc)
	,idechp NUMBER(2)
		CONSTRAINT nn_transferuri_idechp NOT NULL
		CONSTRAINT fk_transferuri_echipe_idechp REFERENCES echipe (idech)
	,idechn NUMBER(2)
		CONSTRAINT nn_transferuri_idechn NOT NULL
		CONSTRAINT fk_transferuri_echipe_idechn REFERENCES echipe (idech)
	,pretachiz NUMBER(7)
	,datatran DATE
		);
	
CREATE TABLE meciuri_goluri (
	idgol NUMBER(2)
		CONSTRAINT nn_meciuri_goluri_idgol NOT NULL
	,idmeci VARCHAR2(20)
		CONSTRAINT nn_meciuri_goluri_idmeci NOT NULL
		CONSTRAINT fk_meciuri_goluri_meciuri REFERENCES meciuri (idmeci)
	,idech NUMBER(2)
		CONSTRAINT nn_meciuri_goluri_idech NOT NULL
		CONSTRAINT fk_meciuri_goluri_echipe REFERENCES echipe (idech)
	,minutgol VARCHAR2(3)
	,codjuc VARCHAR2(5)
		CONSTRAINT nn_meciuri_goluri_codjuc NOT NULL
		CONSTRAINT fk_meciuri_goluri_jucatori REFERENCES jucatori (codjuc)
	,obs VARCHAR2(50)
		,CONSTRAINT pk_meciuri_goluri PRIMARY KEY (idgol,idmeci)
	);



CREATE TABLE jucatori_meciuri (
	idmeci VARCHAR2(20)
		CONSTRAINT nn_jucatori_meciuri_idmeci NOT NULL
		CONSTRAINT fk_jm_meciuri references meciuri(idmeci)
	,idech NUMBER(2)
		CONSTRAINT nn_jucatori_meciuri_idech NOT NULL
		CONSTRAINT fk_jucatori_meciuri_echipe REFERENCES echipe (idech)
	,codjuc VARCHAR2(20)
		CONSTRAINT nn_jucatori_meciuri_codjuc NOT NULL
		CONSTRAINT FK_jm_jucatori REFERENCES jucatori(codjuc)
	,min_cart_rosu VARCHAR2(3)
	,min_cart_galben VARCHAR2(3)
	,oraintrarii VARCHAR2(6)
	,oraiesirii VARCHAR2(6) 
	,nrtricou VARCHAR2(2)
		CONSTRAINT ck_jucatori_meciuri_nrtricou CHECK (nrtricou BETWEEN 0 AND 30)
	,postjuc VARCHAR2(10)
		,CONSTRAINT pk_jucatori_meciuri PRIMARY KEY (idmeci,codjuc)
	);