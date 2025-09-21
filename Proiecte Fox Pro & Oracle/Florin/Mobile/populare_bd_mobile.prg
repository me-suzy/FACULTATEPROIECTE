if !dbused('mobile')
	open database mobile exclusive
endif

delete from judete
sele judete
zap


delete from localitati
sele localitati
zap

delete from modele
sele modele
zap



delete from clienti
sele clienti
zap

sele contracte
zap

delete from incasari
sele incasari
zap

delete from vanzari
sele vanzari
zap

delete from stoc
sele stoc
zap


*************************************************
insert into judete values ('IS','Iasi','Moldova')
insert into judete values ('VN','Vrancea','Moldova')
insert into judete values ('NT','Neamt','Moldova')
insert into judete values ('SV','Suceava','Moldova')
insert into judete values ('VS','Vaslui','Moldova')
insert into judete values ('TM','Timis','Banat')
insert into judete values ('CT','Constanta','Dobrogea')
insert into judete values ('BV','Brasov','Transilvania')
insert into judete values ('AG','Arges','Oltenia')
insert into judete values ('CJ','Cluj','Oltenia')
insert into judete values ('PH','Prahova','Banat')
insert into judete values ('BC','Bacau','Moldova')
insert into judete values ('BT','Botosani','Moldova')
insert into judete values ('BR','Braila','Dobrogea')

insert into localitati values ('6600','Iasi','IS')
insert into localitati values ('5725','Pascani','IS')
insert into localitati values ('6500','Vaslui','VS')
insert into localitati values ('5300','Focsani','VN')
insert into localitati values ('6400','Barlad','VS')
insert into localitati values ('5800','Suceava','SV')
insert into localitati values ('5550','Roman','NT')
insert into localitati values ('1900','Timisoara','TM')
insert into localitati values ('6800','Botosani','BT')
insert into localitati values ('5600','Piatra Neamt','NT')
insert into localitati values ('6750','Targu Frumos','IS')
insert into localitati values ('2200','Brasov','BV')
insert into localitati values ('3400','Cluj','CJ')
insert into localitati values ('0300','Pitesti','AG')
insert into localitati values ('2000','Ploiesti','PH')
insert into localitati values ('5500','Bacau','BC')
insert into localitati values ('8700','Constanta','CT')
insert into localitati values ('6100','Braila','BR')


***************************************
insert into modele values (100,'Siemens',2000,200,'Li-Ion 600 mAh','2 Culori','Date,SMS',250,800,10044,'EURO')
insert into modele values (101,'Sony',2000,200,'Li-Ion 600 mAh','Color','Date,SMS',250,800,11722,'EURO')
insert into modele values (102,'Ericsson',2000,200,'Li-Ion 600 mAh','Color','Date,SMS',250,500,12370,'EURO')
insert into modele values (103,'Nokia',2000,200,'Li-Ion 600 mAh','2 Culori','Date,SMS',250,500,9541,'EURO')
insert into modele values (104,'Sagem',2000,200,'Li-Ion 600 mAh','2 Culori','Date,SMS',250,800,12920,'EURO')


******************************************************************8888
insert into clienti values (1000,'CNP1','Ioan Vasile','I.L.Caragiale,22','6600','123456','094222222',null,'PersFizica',49823245)
insert into clienti values (1001,'CNP2','Vasile Ion','Aleea Nucului,nr3,ap20','6600','234567','094222223','ion@a.ro','PersFizica',76876543)
insert into clienti  values (1002,'CNP3','Popovici Ioana','V.Micle,33,Ap 2','5725','345678','094222224',null,'PersFizica',77657878)
insert into clienti  values (1003,'CNP4','Lazar Caraion','M.Eminescu,nr.42','6500','456789','094222225','caraion@yahoo.com','PersFizica',18298709)
insert into clienti  values (1004,'CNP5','Iurea Simion','I.Creanga,44 bis','6500','567890','090543210',null,'PersFizica',24356544)
insert into clienti  values (1005,'CNP6','Vasc Simona','M.Eminescu,13','5725','432109','094222227','simona@personal.ro','PersFizica',32089245)
insert into clienti  values (1006,'CNP7','Popa Ioanid','I.Ion,sc.C,ap.45','1900',null,null,'joinid@Kappa.ro','PersFizica',67000876)
insert into clienti  values (1007,'CNP8','Simion Dragos','Aleea teilor,3','5500','210987','094222229','rosuili@yahoo.com','PersFizica',97897944)
insert into clienti  values (1008,'CNP9','Florea Marian','Primaverii,32','1900','109876','094222230',null,'PersFizica',05504567)
insert into clienti  values (1009,'CNP10','Tucaliuc Simion','Primaverii,nr.3,ap11','6600','212121',null,'simion@mail.dnts.ro','PersFizica',07875478)
insert into clienti  values (1010,'CNP11','Vasiliu Mihai','Stefan cel mare,34','5800','258952','093555555','mihaiv@assit.ro','PersFizica',06878580)
insert into clienti  values (1011,'CNP12','Ciubotaru Valentin','Carpati,12','5725','245345',null,'aval@hotmail.com','PersFizica',09878585)
insert into clienti  values (1012,'CNP13','Amariei Elena','Pintilie,nr.42','5300','122432','095899676',null,'PersFizica',96954774)
insert into clienti  values (1013,'CNP14','Caslariu Bogdan','Sucevei,nr.3,','6400','153535','094255222','anda@hotmail.com','PersFizica',12478433)
insert into clienti  values (1014,'CNP15','Schipor Razvan','Mihail Kogalniceanu,nr.1,','5800','365522','091232123','numad@personal.ro','PersFizica',54780879)
insert into clienti  values (1015,'CNP16','Florescu Geanina','Bucovina,nr.11','5550','534556',null,'bombon@arcnet.ro','PersFizica',37890086)
insert into clienti  values (1016,'R1000','Client 1 SRL','Tranzitiei,13 bis','6600','523436','093722622','anarh@hotmail.com','PersJuridica',65764657)
insert into clienti  values (1017,'R1001','Client 2 SRL','Stefan Cel Mare,nr.149','5725','523111','094673366',null,'PersJuridica',37689032)
insert into clienti  values (1018,'R1002','Client 3 SRL','Prosperitatii,22','6500','124236','093098789','zndra@net.ro','PersJuridica',10065784)
insert into clienti  values (1019,'R1003','Client 4 SRL','Sapientei,56','1900','129077','091236660','xlos@start.ro','PersJuridica',34632636)
insert into clienti  values (1020,'R1004','Client 5 SRL','Octav Bancila,nr.42','1900','657800','092650156',null,'PersJuridica',77570095)
insert into clienti  values (1021,'R1005','Client 6 SRL','Octav Onicescu,nr.31','5300','433209','090817773',null ,'PersJuridica',12656344)
insert into clienti  values (1022,'R1006','Client 7 SRL','Aleea Cucului,nr.121','6400','342552','095464624',null,'PersJuridica',00983454)
insert into clienti  values (1023,'R1007','Client 8 SRL','Str Independentei,nr.19','5800','565321','095776898','luke@gratismania.ro','PersJuridica',12363444)
insert into clienti  values (1024,'R1008','Client 9 SRL','Luna,nr.2','5550','123999','093435377','bub@hotmail.com','PersJuridica',17447474)


*****************************************************************
insert into stoc values (1000,36646461,14474574,100,'Rosu',.F.)
insert into stoc values (1001,12342134,34141424,103,'Galben',.F.)
insert into stoc values (1002,14574574,95471424,101,'Verde',.F.)
insert into stoc values (1003,14662134,24664424,104,'Negru',.F.)
insert into stoc values (1004,13534134,23453424,102,'Alb',.F.)

***********************************************************************
insert into vanzari values (1000,'Comanda','3 ani')
insert into vanzari values (1001,'Comanda','3 ani')
insert into vanzari values (1002,'Stoc','6000 ore')
insert into vanzari values (1003,'Comanda','6000 ore')
insert into vanzari values (1004,'Stoc','3 ani')


**********************************************************************80,
insert into contracte values (1111,1001,{^2002/08/01},{^2002/08/02},13232,1234,0,12,2342,'Leasing',1000)
insert into contracte values (1112,1002,{^2002/05/07},{^2002/08/02},15670,15670,0,1,0,'Cash',1001)
insert into contracte values (1113,1003,{^2002/03/14},{^2002/08/02},17655,17655,0,1,0,'Cash',1002)
insert into contracte values (1114,1004,{^2002/09/12},{^2002/08/02},21460,21460,0,1,0,'Cash',1003)
insert into contracte values (1115,1005,{^2002/01/22},{^2002/08/02},13232,2132,0.3,24,3207,'Leasing',1004)
insert into contracte values (1116,1003,{^2002/03/14},{^2002/08/02},17655,17655,0,1,0,'Cash',1002)
insert into contracte values (1117,1004,{^2003/01/12},{^2003/01/02},21460,21460,0,1,0,'Cash',1003)
insert into contracte values (1118,1005,{^2003/01/22},{^2003/08/02},13232,2132,0.3,24,3207,'Leasing',1004)


**********************************************************
insert into incasari values(1111,1,{^2002/08/19},1314)
insert into incasari values(1112,1,{^2002/06/15},1231)
insert into incasari values(1113,1,{^2002/03/06},3242)
insert into incasari values(1114,1,{^2003/01/11},4234)
insert into incasari values(1115,1,{^2003/01/23},2341)
insert into incasari values(1116,1,{^2002/03/13},3242)
insert into incasari values(1117,1,{^2003/01/16},4234)
insert into incasari values(1118,1,{^2003/01/15},2341)























