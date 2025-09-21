wait window nowait'Asteptati, se transmit date..'
close data
open database vanzari
use vanzari in 0
use agenti in 0
use zone in 0

select a.numeag, z.denzona, v.an, v.valoare;
       from vanzari v inner join zone z on v.codzona=z.codzona;
             inner join agenti a on v.codag=a.codag;
       orde by numeag, denzona, an;
       into cursor cVanzari
       
 iobj=createobject('Excel.Application')
 
 if vartype(iobj)<>'O'
          =messagebox('Eroare!Nu este instalat excel',6+16,'Eroare')
          return
 endif
 
 with iobj
          .SheetsInNewWorkbook=1
          .DisplayAlerts=.f.&& nu afiseaza mesaje de eorare excel
          
          .workbooks.Add
          .worksheets(1).name='Vanzari'
          
          with .worksheets(1).cells
          
          	*titlul tabelei
          	iobj.worksheets(1).range("A1:D1").mergecells=.t.
          	.item(1,1)='Cntralizator vanzari'
          	with .item(1,)
          	      .font.bold=.t.
          	      .font.name='Tahoma'
          	      .font.size=14
          	      .font.color=RGB(0,255,0)
          	      .HorizontalAlignment=3&&centrat
          	 endwith
          	 
          	 
          	 *titluri pe coloane
          	 .item(3,1)='Agent'
          	 .item(3,1).font.bold=.t.
          	 .item(3,2)='Zona'
          	 .item(3,2).font.bold=.t.
          	 .item(3,3)='Anul'
          	 .item(3,3).font.bold=.t.
          	 .item(3,4)='Val Vanzari'
          	 .item(3,4).font.bold=.t.
          	 
          	 *date privind vanzarile
          	 select cVanzari
          	 go top
          	 i=4
          	 scan
          	     .item(i,1)=numeag
          	     .item(i,2)=denzona
          	     .item(i,3)=an
          	     .item(i,4)=valoare
          	     i=i+1
          	 endscan
          	 
          	 *linie de total
          	 .item(i+1,1)='Total general'
          	 .item(i+1,1).font.bold=.t.
          	 .item(i+1,4).formula='=sum(d4:d'+alltrim(str(i-1))+')'
          	 endwith
          	 InTotal= .worksheets(1).cells.item(i+1,4).value&&preluare total in variabila
          	 
          	 .worksheets(1).columns("A:D").columnwidth=25
          	 .activesheet.saveas('c:\test')
          	 .quit
          	 endwith
          	 
          	 release iobj
          	 close data
          	 wait clear
        =messagebox('datele au fost transmise cu succes!')