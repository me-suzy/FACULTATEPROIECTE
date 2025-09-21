*close data all
*close tables all
*close all
*DROP TABLE judete ;
*DROP TABLE localitati ;
*DROP TABLE modele ;
*DROP TABLE clienti;
*DROP TABLE contracte;
*DROP TABLE incasari ;
*DROP TABLE stoc ;
*DROP TABLE vanzari ;



*comanda urmatoare distruge intreg continut al bazei
*delete database mobile deletetables
*set path to "E:\Proiecte\Proiecte - partea IV\Fox\Mobile\"

create database mobile

create table judete  ( jud char(2); 
						primary key ;
						check(jud=ltrim(upper(jud)));
						error 'Indicativul judetului se scrie cu majuscule!',;
						judet char(25);
						unique;
						not null;
						check (judet=ltrim(proper(judet)));
						error 'Prima litera din fiecare cuvant al denumirii judetului este majuscula',;
						regiune char(25);
						default 'Moldova' ;
						check (inlist(regiune,'Banat','Transilvania','Dobrogea','Oltenia' ,'Muntenia','Moldova'));
						error 'regiunea poate avea doar o valoare din lista MOLD,BAN..';
						)

create trigger on judete for delete as del_judete();



create table localitati ( ;
							codpost char(5);
							primary key;
							check (codpost=ltrim(codpost));
							error 'codpost se scrie fara spatii la inceput',;
							loc char(25);
							not null;
							check(loc=ltrim(proper(loc)));
							error 'Prima litera este majuscula iar restul mici',;
							jud char(2);
							default def_localitati_jud(),;
							foreign key jud tag jud references judete tag jud;
							)
							
create trigger on localitati for delete as del_localitati();	

create trigger on localitati for update as upd_localitati();					

create trigger on localitati for insert as ins_localitati();
							
create trigger on localitati for delete as del_localitati();						

create table clienti( ;
						CodCl number (4);
							primary key;
							default def_clienti(),;
						CnpCodFiscal char (8),;
						DenCl char(20);
							check(substr(DenCl,1,1)=upper(substr(DenCl,1,1)));
							error 'prima litera este obligatoriu majuscula',;
						Adresa char(40);
							check(substr(Adresa,1,1)=upper(substr(Adresa,1,1)));
							error 'prima litera este obligatoriu majuscula',;
						CodPost char(4);
							default def_clienti_codpost(),;
						TelFix char(10);
							null,;
						TelMobil char(10);
							null,;
						Email char(30);
							null,;
						TipPers char(12);
							default 'PersFizica';
							check(inlist(TipPers,'PersFizica','PersJuridica'));
							error ' Atributul TipPers poate fi doar PersFizica sau PersJuridica',;
						ContBanca number(15),;
						foreign key CodPost tag CodPost references localitati tag CodPost;
						);

create trigger on clienti for delete as del_clienti();

create trigger on clienti for update as upd_clienti();

create trigger on clienti for insert as ins_clienti();						

	

create table modele ( ;
						CodModel number(4);
							primary key;
							default def_modele_codmodel(),;
						DenModel char (15);
							check(substr(DenModel,1,1)=upper(substr(DenModel,1,1)));
							erro 'prima litera este obligatoriu majuscula',;
						AnFabr n (4);
							check (between(anfabr,2000,year(date())));
							erro'Alegeti unul din anii 2000-...';
							default 2003,;							
						Cap_agenda n(3),;
						Tip_baterie char(15),;
						Display char(15);
					    check(inlist(Display,'2 Culori','Color'));
					    erro 'Alegeti doar 2 Culori sau Color ';
					    default '2 Culori',;
						Tehn_implem char(15),;
					    Standby number(3),;
					    Greutate number(3),;
					    PretModele number(5),;
					    Moneda char(4);
					    	default 'EURO';
					    );
     
create trigger on modele for update as upd_modele();  

create trigger on modele for delete as del_modele(); 
				

									
											
						
						
						
create table contracte ( ;
						NrContr number(5);
							primary key;
							default  def_contracte(),;
						CodCl number(4) ;
							default def_contracte_codcl(),;
						DataContr date;
							default date(),;
						TermenExec date;
							default def_contracte_termenexec(),;
						ValTot number(5);
							default def_contracte_valtot(),;
						Avans number(5,1);
							default def_contracte_avans();
							null,;
						Dobanda number(4,2);
							default 0.3,;
						NrRate number (2);
							default 12;
							check( between (nrrate,1,36));
							erro 'Nu va incadrati in numarul de rate ',;
						RataLunara number(5,1);
							default def_contracte_ratalunara(),;
						TipContr char(8);
							check(inlist(TipContr,'Cash','Leasing'));
							erro 'Tipurile de contract sunt :Cash,Leasing ';
							default 'Leasing',;
						CodMobil number(5);
							unique;
							not null;
							default def_contracte_codmobil(),;
						foreign key  CodMobil tag CodMobil  references vanzari tag CodMobil ,;
						foreign key CodCl tag CodCl references clienti tag CodCl;
						);
						
						
create trigger on contracte for delete as del_contracte();

create trigger on contracte for update as upd_contracte();

create trigger on contracte for insert as ins_contracte();
					
						
create table incasari  (;
						NrContr number(5);
						default  def_incasari(),;
						NrRataInc number (2);
						default def_incasari_nrratainc(),;
						primary key str(NrContr,5)+str(NrRataInc,2) tag primaru,;
						DataInc date;
							default date(),;
						SumaInc number(5);
						default def_incasari_sumainc(),;
						foreign key NrContr tag NrContr references contracte tag NrContr;
							);
						
create trigger on incasari for update as upd_incasari();

create trigger on incasari for insert as ins_incasari();

						
create table vanzari (;
						CodMobil number(5);
							primary key;
							default def_vanzari(),;
						TipVanzare char(8);
							check(inlist(TipVanzare,'Comanda','Stoc'));
							erro 'Introduceti doar Comanda sau Stoc';
							default 'Comanda',;
						Garantie char(15);
							check(inlist(garantie,'3 ani','6000 ore'));
							erro 'Alegeti 3 ani sau 6.000 ore pentru garantie';
							default '3 ani';
								);
								
						
create trigger on vanzari for update as upd_vanzari();

create trigger on vanzari for insert as ins_vanzari();
			
						
create table stoc(;
						CodMobil number(5) primary key;
						default def_stoc(),;
						SerieMobil number(10),;
						SerieBaterie number (10),;
						CodModel number(4);
							default 100,;
						Culoare char(10);
							check(inlist(Culoare,'Alb','Negru','Albastru','Green','Galben','Verde','Rosu'));
							erro 'Culoarea nu corespunde modelelor noastre';
							default 'Alb',;
							check (substr(Culoare,1,1)=upper(substr(Culoare,1,1)));
							erro 'prima litera este obligatoriu majuscula',;
						PeStoc l(1);
							default .T.,;
						foreign key CodMobil tag CodMobil references vanzari tag CodMobil,;
						foreign key CodModel tag CodModel references modele tag CodModel;
						);
						
create trigger on stoc for delete as del_stoc();				
	
create trigger on stoc for update as upd_stoc();
						
create trigger on stoc for insert as ins_stoc();																			
						
							


						
	
		