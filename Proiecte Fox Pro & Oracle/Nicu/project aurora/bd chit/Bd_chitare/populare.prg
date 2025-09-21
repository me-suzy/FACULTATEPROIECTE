if !dbused("vanzrepar")
open database vanzrepar exclusive
endif

delete from clienti 
sele clienti 
zap

delete from judete 
sele judete
zap

delete from localitati 
sele localitati
zap

delete from chitare 
sele chitare
zap

delete from chitare_celebre 
sele chitare_celebre 
zap

delete from comanda 
sele comanda 
zap

delete from componente 
sele componente
zap

delete from facturi 
sele facturi 
zap

delete from grad_defectiune 
sele grad_defectiune 
zap

delete from incasari 
sele incasari 
zap

delete from incasfact
sele incasfact
zap

delete from liniicomanda
sele liniicomanda
zap

delete from liniifact
sele liniifact
zap

delete from premii
sele premii
zap

delete from reparatii
sele reparatii
zap

insert into judete values('BC','Bacau','Moldova')
insert into judete values('IS','Iasi','Moldova')
insert into judete values('TM','Timis','Banat')
insert into judete values('SV','Suceava','Moldova')
insert into judete values('VN','Vrancea','Moldova')
insert into judete values('VS','Vaslui','Moldova')

insert into localitati values('5467','Tg-ocna','BC')
insert into localitati values('6600','Iasi','IS')
insert into localitati values('6500','Vaslui','VS')
insert into localitati values('1900','Timisoara','TM')
insert into localitati values('5300','Focsani','VN')
insert into localitati values('6400','Barlad','VS')

insert into clienti (numepren,adresa,codpost,telefon,email) values('IRIMIA ALECU','Strada Bradului numarul 8','5467',3458965,Null)
insert into clienti (numepren,adresa,codpost,telefon,email) values('STRATULAT DRAGOS','Strada tecuci,Bloc B8,ap.26','6600',3158965,'dragos@yahoo.com')
insert into clienti (numepren,adresa,codpost,telefon,email) values('COSMINA RADU','Strada timofte,nr 56','5467',3459865,'coss2003@yahoo.com')
insert into clienti (numepren,adresa,codpost,telefon,email) values('BUCUR VLAD','Strada c.negri,Bl G2,sc B,ap 20','1900',3415689,'vlad@yahoo.com')
insert into clienti (numepren,adresa,codpost,telefon,email) values('BALAN MHNEA','Strada linistei,nr. 8','5467',3425878,'mihnea_balan@yahoo.com')
insert into clienti (numepren,adresa,codpost,telefon,email) values('STEFAN MORARU','Strada slanic,Bl A1,Ap 66','6400',3465123,'morarust@yahoo.com')
insert into clienti (numepren,adresa,codpost,telefon,email) values('TIMARU ALEX','Str. Libertatii,nr 18','5300',323698,'malmsteen@yahoo.com')
insert into clienti (numepren,adresa,codpost,telefon,email) values('IARU MARINELA','Str Caurea,nr 35','5467',341690,'mary@yahoo.com')

insert into chitare_celebre(codsign,numemuzician,nrconcerte) values('No Sign','No Artist',0)
insert into chitare_celebre values('GaryR4ET','Gary Moore',{^1982/08/07},54)
insert into chitare_celebre values('Malm56721','Yngwie Malmsteen',{^1985/05/09},15)
insert into chitare_celebre values('Steve23PKNG','Steve Vai',{^1993/04/02},20)
insert into chitare_celebre values('Jason4542','Joson Newsteed',{^1992/07/09},88)
insert into chitare_celebre values('HendrixT5ER6','Jimi Hendrix',{^1978/05/05},30)

insert into chitare (codchitara,firma,tip_chitara,tip_poz,rezonanta,nr_doze,model_doza,nr_taste,tip_taste,material,vibrato,greutate_kg,codsign)values('TelecasterRY2X','Fender','Chitara','Dreapta','Electrica',3,'Di Martio',22,'Rotunjite','Pal','Simplu',0.9,'Malm56721')
insert into chitare (codchitara,firma,tip_chitara,tip_poz,rezonanta,nr_doze,model_doza,nr_taste,tip_taste,material,vibrato,greutate_kg,codsign)values('PacificaL28DGX','Yamaha','Chitara','Stanga','Electrica',2,'YamahaYH',21,'Subtiri','Alun','Floyd-Royce',1.00,'No Sign')
insert into chitare (codchitara,firma,tip_chitara,tip_poz,rezonanta,nr_doze,model_doza,nr_taste,tip_taste,material,vibrato,greutate_kg,codsign)values('LesPaulRT2Y','Gibson','Chitara','Dreapta','Electrica',2,'Di Martio',24,'Late','Fibra Carbon',null,1.5,'GaryR4ET')
insert into chitare (codchitara,firma,tip_chitara,tip_poz,rezonanta,nr_doze,model_doza,nr_taste,tip_taste,material,vibrato,greutate_kg,codsign)values('StratocasterL9V','Fender','Bass','Stanga','Semi-acustica',2,'SpecialRGX',21,'Rotunjite','Pal',null,1.5,'No Sign')
insert into chitare (codchitara,firma,tip_chitara,tip_poz,rezonanta,nr_doze,model_doza,nr_taste,tip_taste,material,vibrato,greutate_kg,codsign)values('RGX-L','Ibanez','Chitara','Dreapta','Electrica',5,'Sey Dunken',26,'Rotunjite','Fibra-Carbon','Floyd-Royce',0.5,'Steve23PKNG')
insert into chitare (codchitara,firma,tip_chitara,tip_poz,rezonanta,nr_doze,model_doza,nr_taste,tip_taste,material,vibrato,greutate_kg,codsign)values('6+6 2GRN','Yamaha','Chitara','Dreapta','Acustica',1,'Di Martio',21,'Subtiri','Alun',null,1.15,'No Sign')
insert into chitare (codchitara,firma,tip_chitara,tip_poz,rezonanta,nr_doze,model_doza,nr_taste,tip_taste,material,vibrato,greutate_kg,codsign)values('897BSP','Jackson','Bass','Stanga','Electrica',3,'BSP2X',22,'Subtiri','Aleaj-plastic',null,1.2,'Jason4542')
insert into chitare (codchitara,firma,tip_chitara,tip_poz,rezonanta,nr_doze,model_doza,nr_taste,tip_taste,material,vibrato,greutate_kg,codsign)values('StratocasterT2WQ','Fender','Chitara','Stanga','Electrica',3,'Di Martio',21,'Rotunjite','Alun','Simplu',0.8,'HendrixT5ER6')

select chitare
scan
nume_='figura_'+codchitara+'.jpeg'
if file ((nume_))
append general chitare.imaginech from (nume_)link
endif
endscan




insert into premii values('LesPaulRT2Y','Gold One','Best sound',1991)
insert into premii values('RGX-L','Special','Best design',1988)
insert into premii values('StratocasterL9V','Gold One','Best known',1992)
insert into premii values('StratocasterL9V','Best','Best sound',1992)
insert into premii values('TelecasterRY2X','Blues','Best Sound',1995)
insert into premii values('LesPaulRT2Y','Hard','Best guitar',1999)
insert into premii values('LesPaulRT2Y','Special','Best design',1996)
insert into premii values('6+6 2GRN','Spanish','Studio choice',1997)
insert into premii values('897BSP','Gold One','Best concert',1997)


insert into facturi(datafact,codcl,obs) values ({^2003/05/01},10001,null)
insert into facturi(datafact,codcl,obs) values ({^2003/05/01},10001,null)
insert into facturi(datafact,codcl,obs) values ({^2003/05/01},10002,null)
insert into facturi(datafact,codcl,obs) values ({^2003/05/02},10002,null)
insert into facturi(datafact,codcl,obs) values ({^2003/05/02},10002,null)
insert into facturi(datafact,codcl,obs) values ({^2003/05/03},10001,null)
insert into facturi(datafact,codcl,obs) values ({^2003/05/04},10003,null)
insert into facturi(datafact,codcl,obs) values ({^2003/05/07},10003,null)


insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111111,'TelecasterRY2X',1,14500000)
insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111111,'PacificaL28DGX',1,12200000)
insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111112,'LesPaulRT2Y',1,21000000)
insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111112,'StratocasterL9V',1,16800000)
insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111112,'RGX-L',1,15200000)
insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111113,'6+6 2GRN',1,13450000)
insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111114,'897BSP',3,19000000)
insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111115,'StratocasterT2WQ',2,20000000)
insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111115,'6+6 2GRN',2,13450000)
insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111116,'StratocasterL9V',4,16800000)
insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111117,'TelecasterRY2X',3,14500000)
insert into liniifact(nrfact,codchitara,cantitate,pretunit) values (111118,'PacificaL28DGX',1,12200000)

inser into incasari(datainc,coddoc,nrdoc,datadoc) values ({^2003/05/15},'OP','111',{^2002/05/10})
inser into incasari(datainc,coddoc,nrdoc,datadoc) values ({^2003/05/15},'CHIT','222',{^2002/05/16})
inser into incasari(datainc,coddoc,nrdoc,datadoc) values ({^2003/05/16},'OP','333',{^2002/05/09})
inser into incasari(datainc,coddoc,nrdoc,datadoc) values ({^2003/05/17},'CEC','444',{^2002/05/10})
inser into incasari(datainc,coddoc,nrdoc,datadoc) values ({^2003/05/17},'OP','555',{^2002/05/10})
inser into incasari(datainc,coddoc,nrdoc,datadoc) values ({^2003/05/19},'OP','666',{^2002/05/11})

insert into incasfact values (11,111111,4500000)
insert into incasfact values (11,111113,1200000)
insert into incasfact values (12,111112,2000000)
insert into incasfact values (13,111117,2500000)
insert into incasfact values (13,111118,1500000)
insert into incasfact values (13,111115,900000)
insert into incasfact values (14,111117,500000)
insert into incasfact values (15,111111,2400000)
insert into incasfact values (16,111112,3500000)

insert into comanda(datacomanda,codcl) values({^2003/05/20},10002)
insert into comanda(datacomanda,codcl) values({^2003/05/20},10003)
insert into comanda(datacomanda,codcl) values({^2003/06/15},10008)
insert into comanda(datacomanda,codcl) values({^2003/06/29},10001)
insert into comanda(datacomanda,codcl) values({^2003/07/05},10005)
insert into comanda(datacomanda,codcl) values({^2003/07/10},10005)
insert into comanda(datacomanda,codcl) values({^2003/07/15},10006)
insert into comanda(datacomanda,codcl) values({^2003/08/05},10004)

insert into liniicomanda(codcomanda,codchitara,cantitate,pretunit) values (102,'TelecasterRY2X',2,5000000)
insert into liniicomanda(codcomanda,codchitara,cantitate,pretunit) values (102,'LesPaulRT2Y',3,15000000)
insert into liniicomanda(codcomanda,codchitara,cantitate,pretunit) values (104,'RGX-L',1,30000000)
insert into liniicomanda(codcomanda,codchitara,cantitate,pretunit) values (103,'TelecasterRY2X',4,6000000)
insert into liniicomanda(codcomanda,codchitara,cantitate,pretunit) values (106,'StratocasterL9V',2,8000000)
insert into liniicomanda(codcomanda,codchitara,cantitate,pretunit) values (106,'897BSP',3,1800000)
insert into liniicomanda(codcomanda,codchitara,cantitate,pretunit) values (107,'6+6 2GRN',1,12500000)
insert into liniicomanda(codcomanda,codchitara,cantitate,pretunit) values (101,'PacificaL28DGX',3,7000000)
insert into liniicomanda(codcomanda,codchitara,cantitate,pretunit) values (101,'StratocasterL9V',5,6800000)
insert into liniicomanda(codcomanda,codchitara,cantitate,pretunit) values (108,'TelecasterRY2X',2,25000000)
insert into liniicomanda(codcomanda,codchitara,cantitate,pretunit) values (103,'LesPaulRT2Y',1,9000000)

insert into componente(numecompo,tip_compo,pretcompo) values('Di Martio','Doza',2500000)
insert into componente(numecompo,tip_compo,pretcompo) values('Yamaha YH','Doza',2000000)
insert into componente(numecompo,tip_compo,pretcompo) values('SpecialRGX','Doza',5100000)
insert into componente(numecompo,tip_compo,pretcompo) values('Sey Dunken','Doza',3200000)
insert into componente(numecompo,tip_compo,pretcompo) values('BSP2X','Doza',4000000)
insert into componente(numecompo,tip_compo,pretcompo) values('NGIBP','Grif',6000000)
insert into componente(numecompo,tip_compo,pretcompo) values('NYH','Grif',4800000)
insert into componente(numecompo,tip_compo,pretcompo) values('Floyd-Royce','Vibrato',3800000)
insert into componente(numecompo,tip_compo,pretcompo) values('YH-line','Tasta',200000)

insert into grad_defectiune values (1,'Usor',15,'Reparare')
insert into grad_defectiune values (2,'Mediu',35,'Reparare')
insert into grad_defectiune values (3,'Sever',60,'Inlocuire')

insert into reparatii(codchitara,codcl,codcompo,datarepar,grad_defect) values('TelecasterRY2X',10001,101,{^2003/09/20},1)
insert into reparatii(codchitara,codcl,codcompo,datarepar,grad_defect) values('LesPaulRT2Y',10001,101,{^2003/10/03},2)
insert into reparatii(codchitara,codcl,codcompo,datarepar,grad_defect) values('StratocasterL9V',10003,103,{^2003/05/07},1)
insert into reparatii(codchitara,codcl,codcompo,datarepar,grad_defect) values('StratocasterL9V',10005,103,{^2003/04/25},3)
insert into reparatii(codchitara,codcl,codcompo,datarepar,grad_defect) values('PacificaL28DGX',10006,102,{^2003/03/02},1)
insert into reparatii(codchitara,codcl,codcompo,datarepar,grad_defect) values('6+6 2GRN',10006,107,{^2003/08/09},1)
insert into reparatii(codchitara,codcl,codcompo,datarepar,grad_defect) values('TelecasterRY2X',10004,107,{^2003/07/06},2)
insert into reparatii(codchitara,codcl,codcompo,datarepar,grad_defect) values('PacificaL28DGX',10004,108,{^2003/10/03},2)


