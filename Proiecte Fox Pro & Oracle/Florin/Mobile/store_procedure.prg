


procedure upd_localitati

if !used("judete")
	use localitati in 0
endif

v_jud=localitati.codpost
if _triggerlevel = 1
if v_jud <> oldval("jud","localitati")
	x=seek(v_jud, "judete", "jud")
	if x=.F.
		messagebox ("Jud introdus nu se gaseste in tabela Judete", 16, "Error")
		return .F.
	endif
endif
endif
endproc





*Pocedura update codpost in tabela clienti
procedure upd_clienti

if !used("localitati")
	use localitati in 0
endif

v_codpost=clienti.codpost
if _triggerlevel = 1
if v_codpost <> oldval("codpost","clienti")
	x=seek(v_codpost, "localitati", "codpost")
	if x=.F.
		messagebox ("Codpost introdus nu se gaseste in Localitati", 16, "Error")
		return .F.
	endif
endif
endif

if clienti.codcl <> oldval("codcl", "clienti")
	update contracte set codcl = clienti.codcl;
	where codcl=oldval("codcl","clienti")
endif
endproc






*update Contracte-codcl
procedure upd_contracte
if!used("clienti")
	use clienti in 0
endif



v_codcl = contracte.codcl
if _triggerlevel = 1
if v_codcl <> oldval("codcl","contracte")
	x=seek(v_codcl, "clienti", "codcl")
	if x=.F.
		messagebox (" Codcl introdus nu se gaseste in clienti", 16, "Error")
		return .F.
		endif
endif
endif

if contracte.nrcontr <> oldval("nrcontr", "contracte")
	update incasari set nrcontr =contracte.nrcontr;
	where nrcontr=oldval("nrcontr", "contracte")
endif


if!used("vanzari")
	use vanzari in 0
endif

v_codmobil = contracte.codmobil
if _triggerlevel = 1
if v_codmobil <> oldval("codmobil","contracte")
	x=seek(v_codmobil, "vanzari", "codmobil")
	if x=.F.
		messagebox ("Codmobil introdus nu se gaseste in tabela vanzari", 16, "Error")
		return .F.
		endif
endif
endif
endproc

*update pentru incasari-NrContr
procedure upd_incasari
 
if !used("contracte")
	use contracte in 0
endif

v_nrcontr=incasari.nrcontr
if _triggerlevel=1
if v_nrcontr<>oldval("nrcontr","incasari")
	if !indexseek(v_nrcontr,.f.,"contracte","nrcontr")
	messagebox ("Nrcontract introdus nu se  gaseste in tabela Contracte",16,"Error")
	return .F.
	endif
endif
endif


endproc

*update stoc -
procedure upd_vanzari
 
if !used("stoc" )
use stoc in 0
endif
	
v_codmobil=vanzari.codmobil
if _triggerlevel=1
if v_codmobil<>oldval("codmobil","vanzari")
	if !indexseek(v_codmobil,.f.,"stoc","codmobil")
	messagebox ("Codmobil introdus nu se  gaseste in tabela stoc",16,"Error")
	return .F.
	endif
endif
endif 

if vanzari.codmobil <> oldval("codmobil", "vanzari")
	update contracte set codmobil = vanzari.codmobil;
	where codmobil=oldval("codmobil","vanzari")
endif


endproc 



*!*	v_pretoptiuni=optiuni.pretoptiuni
*!*	if v_pretoptiuni<>oldval("pretoptiuni","optiuni")
*!*	if _triggerlevel=1
*!*	valtot_new=optiuni.pretoptiuni+modele.pretmodele
*!*	valtot_old=oldval('valtot','contracte')
*!*	if valtot_new#valtot_old
*!*	update contracte set valtot=valtot_new where valtot=valtot_old
*!*	endif
*!*	endif
*!*	endif
*!*	endproc

procedure upd_stoc
if !used("modele")
	use modele in 0
endif

v_codmodel=stoc.codmodel
if _triggerlevel=1
if v_codmodel<>oldval("codmodel","stoc")
	if !indexseek(v_codmodel,.f.,"modele","codmodel")
	messagebox ("Codmodel introdus nu se  gaseste in tabela Modele",16,"Error")
	return .F.
	endif
endif
endif


if stoc.codmobil <> oldval("codmobil", "stoc")
	update vanzari set codmobil = stoc.codmobil;
	where codmobil=oldval("codmobil","stoc")
endif

endproc



procedure upd_modele
v_pretmodele=modele.pretmodele
if v_pretmodele<>oldval("pretmodele","modele")
if _triggerlevel<=1
valtot_new1=modele.pretmodele
valtot_old1=oldval('valtot','contracte')
if valtot_new1#valtot_old1
update contracte set valtot=valtot_new1 where valtot=valtot_old1
endif
endif
endif

if modele.codmodel<> oldval("codmodel", "modele")
	update stoc set codmodel = modele.codmodel;
	where codmodel=oldval("codmodel","modele")
endif
endproc
************************************************************************************8
**************************DELETE***********DELETE**********************************
 *********************************************************************************88

procedure del_modele
if seek (modele.codmodel,"stoc", "codmodel")
	messagebox ("Nu puteti sterge")
return .F.
endif
endproc



procedure del_localitati
 
if !used("localitati" )
use localitati in 0
endif
if !used("clienti" )
use clienti in 0
endif
if seek (localitati.codpost, "clienti", "codpost")
	messagebox ("Nu puteti sterge")
return .F.
endif
endproc


procedure del_clienti
if seek (clienti.codcl, "contracte", "codcl")
	messagebox ("Nu puteti sterge")
return .F.
endif
endproc


procedure del_contracte
if seek (contracte.nrcontr, "incasari", "nrcontr")
	messagebox ("Nu puteti sterge")
return .F.
endif
endproc


procedure del_stoc
if seek (stoc.codmobil, "vanzari", "codmobil")
	messagebox ("Nu puteti sterge")
return .F.
endif
endproc

procedure del_vanzari
if seek (vanzari.codmobil, "contracte", "codmobil")
	messagebox ("Nu puteti sterge")
return .F.
endif
endproc



*************************************************************
**************INSERT*****INSERT********INSERT*********INSERT
procedure del_judete
if seek (judete.jud,"localitati", "jud")
	messagebox ("Nu puteti sterge")
return .F.
endif
endproc


procedure ins_localitati
if !used("judete")
	use judete in 0
endif
if !used("localitati")
	use localitati in 0
endif
*!*	if !indexseek(localitati.jud,.f., "judete", "jud")
*!*			messagebox ("Jud introdus nu se gaseste in tabela Judete", 16, "Error")
*!*			return .F.
*!*		endif
endproc



*Pocedura insert codpost in tabela clienti
procedure ins_clienti
if !used("localitati")
	use localitati in 0
endif
if !indexseek(clienti.codpost,.f., "localitati", "codpost")
		messagebox ("Codpost introdus nu se gaseste in Localitati", 16, "Error")
		return .F.
	endif
endproc


*Insert contracte 
procedure ins_contracte
if !used("vanzari")
	use vanzari in 0
endif

if !indexseek(contracte.codmobil,.f., "vanzari", "codmobil")
		messagebox ("Codmobil introdus nu se gaseste in tabela vanzari", 16, "Error")
		return .f.
endif


if !used("clienti") 
	use clienti in 0
endif
if ! indexseek(contracte.codcl,.f.,"clienti","codcl")
	messagebox(" CodCl  inexistent")
	return .f.
	endif
endproc


procedure ins_incasari
if !used("contracte")
	use contracte in 0
endif
if !indexseek(incasari.nrcontr,.f., "contracte", "nrcontr")
		messagebox ("NrContr inexistent!!", 16, "Error")
		return .F.
	endif
endproc


procedure ins_vanzari
if !used("stoc")
	use stoc in 0
endif
if !indexseek(vanzari.codmobil,.f., "stoc", "codmobil")
		messagebox ("Codmobil inexistent!!", 16, "Error")
		return .F.
	endif
endproc


procedure ins_stoc
if !used("modele")
	use modele in 0
endif
if !indexseek(stoc.codmodel,.f., "modele", "codmodel")
		messagebox ("Codmodel inexistent!!", 16, "Error")
		return .F.
	endif

endproc



**********************************************************************88
**************************** DEFAULT*********************************8

procedure def_localitati_jud
local vjud
dimension vjud_(1,2)
vjud_=0
sele top 1 jud, count(*) as nr;
from localitati into array vjud_;
group by jud ;
order by nr desc
return vjud_(1,1)
endproc



procedure def_stoc
dimension H(1)
H(1) = 0
select max(codmobil) from stoc into array H
return H(1)+1
endproc


procedure def_vanzari
dimension H(1)
H(1) = 0
select max(codmobil) from vanzari into array H
update stoc set pestoc=.F.
return H(1)+1
endproc



procedure def_contracte
dimension H(1)
H(1) = 0
select max(nrcontr) from contracte into array H
return H(1)+1
endproc




procedure def_incasari
dimension H(1)
H(1) = 0
select min(nrcontr) from incasari into array H
return H(1)
endproc

procedure def_clienti
dimension H(1)
H(1) = 0
select max(codcl) from clienti into array H;
order by codcl
return H(1)+1
endproc

procedure def_contracte_codcl
dimension A(1)
A(1) = 0
select max(codcl) from clienti into array A
return A(1)
endproc





procedure def_contracte_termenexec
dimension H(1)
H(1) = { / / }
select gomonth(date(),nrrate) from contracte into array H
if empty (H(1))
	return CTOD("1/"+str(month(date()))+"/"+str(year(date())))
endif
if dow(H(1))<>7 
return H(1)+1
else
return H(1)
endif
endproc


procedure def_contracte_codmobil
dimension B(1)
B(1) = 0
select max(codmobil) from vanzari into array B
return B(1)
endproc

procedure def_contracte_valtot
dimension valtot(1)
valtot(1) = 0
select pretmodele from modele into array valtot
valtot(1)=modele.pretmodele
return valtot(1)
endproc


procedure def_contracte_avans
dimension avans(1)
avans(1)=0
select max(nrcontr),valtot from contracte into array avans
avans(1)=valtot*0.25
return avans(1)
endproc


procedure def_contracte_ratalunara
dimension ratalunara(1)
ratalunara(1)=0
select max(nrcontr),avans,nrrate,dobanda,ratalunara from contracte into array ratalunara
plata=(valtot-avans)
ratalunara(1)=(plata*1.3)/nrrate
return ratalunara(1)
endproc



procedure def_clienti_codpost
local vcodpost_
dimension vcodpost_(1,2)
vcodpost_=0
sele top 1 codpost, count(*) as nr;
from clienti into array vcodpost_;
group by codpost ;
order by nr desc
return vcodpost_(1,1)
endproc



*****VContracte*************
procedure upd_vcontracte
if !empty(vcontracte.valtot) and !empty(vcontracte.avans) and !empty(vcontracte.nrrate)
replace vcontracte.ratalunara with ((vcontracte.valtot)-vcontracte.valtot*0.25)*1.3/vcontracte.nrrate
endif
endproc

*!*	procedure def_vincasari_sumainc
*!*	parameter nrcontr_
*!*	messagebox(str(nrcontr_))

*!*	select ratalunara from contracte;
*!*	where contracte.nrcontr=nrcontr_ into array sumainc;

*!*	replace sumainc with sumainc(1)
*!*	endproc
*!*		




procedure def_incasari_nrratainc
dime nrratainc(1)
nrratainc(1)=0
select max(nrratainc) as cate from incasari into array nrratainc
cate=nrratainc
return nrratainc(1)+1 
endproc
	

procedure def_incasari_sumainc

dime sumainc(1)
sumainc(1)=0
select ratalunara from contracte into array sumainc
ratalunara=sumainc
return sumainc(1)
endproc




procedure def_vincasari_nrratainc
dime nrratainc(1)
nrratainc(1)=0
select max(nrratainc) as cate from vincasari into array nrratainc
cate=nrratainc
return nrratainc(1)+1 
endproc


procedure def_vincasari_nrcontr
dime nrcontr(1)
nrcontr(1)=0
select min(nrcontr) from vincasari into array nrcontr
return nrcontr(1)
endproc



procedure def_modele_codmodel
dime codmodel(1)
codmodel(1)=0
select max(codmodel)  from modele into array codmodel
return codmodel(1)+1 
endproc