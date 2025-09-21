Attribute VB_Name = "Module2"
Public Sub CopieNumaraRecordset(rsOriginal As ADODB.Recordset, rsCopie As ADODB.Recordset)
'Copierea unui recordset in altul, adaugand o coloana cu numere de ordne
Dim i As Long, j As Long, k As Long, m As Long
'se deschide recordsetul sursa daca era inchis
If rsOriginal.State = adStateClosed Then
'accesez toate inregistrarile pentru a obtine numarul lor in recordCount
rsOriginal.Open
rsOriginal.MoveLast
k = rsOriginal.RecordCount
'ma intorc la prim inregistrare
rsOriginal.MoveFirst
'creez campurile recordsetului destinatie, mai intai un camp pentru nrcrt
rsCopie.Fields.Append "nrcrt", adVarChar, 6
'se adauga campurile recordsetului sursa
For i = 0 To rsOriginal.Fields.Count - 1
    rsCopie.Fields.Append rsOriginal.Fields(i).Name, rsOriginal.Fields(i).Type, rsOriginal.Fields(i).Precision
Next i
'deschid record-setul copie-in mod citire-scriere
rsCopie.Open LockType:=adLockBatchOptimistic
'parcurg originalul si introduc date in recordsetul copie
With rsOriginal
For m = 1 To k
    rsCopie.AddNew
    rsCopie.Fields(0).Value = m & "."
    For j = 1 To rsOriginal.Fields.Count
        rsCopie.Fields(j).Value = rsOriginal.Fields(j - 1).Value
    Next j
    rsCopie.Update
    .MoveNext
Next m
End With
rsOriginal.Close
Set rsOriginal = Nothing
End Sub


Public Sub LegareDinamica()
Dim rslistastudentilor As New ADODB.Recordset
'indic utilizatorului sa stepte...
Screen.MousePointer = vbHourglass
'srdcmStudenti este recordsetul pe care-l creaza obiectul dcmStudenti
CopieNumaraRecordset deGeStud.rsdcmStudenti, rslistastudentilor
'atribuirea dinamica a sursei de date raportului (care e unbound)
Set DataReport1.DataSource = rslistastudentilor
'legarea campurilor raportului la sursa de date,teate fiind in starea "unbound"
With DataReport1.Sections("Detail")
    .Controls("txtusername").DataField = rslistastudentilor.Fields("username").Name
    .Controls("txtnrcrt").DataField = rslistastudentilor.Fields("nrcrt").Name
    .Controls("txtsexul").DataField = rslistastudentilor.Fields("sex").Name
    .Controls("txtcnp").DataField = rslistastudentilor.Fields("cnp").Name
    .Controls("txttelfix").DataField = rslistastudentilor.Fields("telfix").Name
    .Controls("txttelmobil").DataField = rslistastudentilor.Fields("telmobil").Name
    .Controls("txte_mail").DataField = rslistastudentilor.Fields("e_mail").Name
    .Controls("txtadrstabila").DataField = rslistastudentilor.Fields("adrstabila").Name
    .Controls("txtadrflotant").DataField = rslistastudentilor.Fields("adrflotant").Name
    .Controls("txtanstudiu").DataField = rslistastudentilor.Fields("anstudiu").Name
    .Controls("txtsalmin").DataField = rslistastudentilor.Fields("salmin").Name
    .Controls("txtpermiscat").DataField = rslistastudentilor.Fields("permiscat").Name
    .Controls("txtstarecivila").DataField = rslistastudentilor.Fields("starecivila").Name
    .Controls("txtstagiumilitar").DataField = rslistastudentilor.Fields("stagiumilitar").Name
    .Controls("txtzinastere").DataField = rslistastudentilor.Fields("zinastere").Name
    .Controls("txtlunanastere").DataField = rslistastudentilor.Fields("lunanastere").Name
    .Controls("txtannastere").DataField = rslistastudentilor.Fields("annastere").Name
    .Controls("txtactivitextrasc").DataField = rslistastudentilor.Fields("activitextrasc").Name
    .Controls("txtaltestudii").DataField = rslistastudentilor.Fields("altestudii").Name
    .Controls("txthobby").DataField = rslistastudentilor.Fields("hobby").Name
    .Controls("txtstagiistrain").DataField = rslistastudentilor.Fields("stagiistrain").Name
End With
Screen.MousePointer = vbDefault
''''''''''''Secv. pt afisarea studentilor dupa un anumit parametru''''''''''''
With deDBStud.Commands("dcmStudenti")
    .Parameters(0).Value = 0 'devine "1=0" - false
    .Parameters(1).Value = 1 ' anul 1
End With
'dezactivarea campului anstudiu
With DataReport1
    .Sections("Detail").Controls("txtanstudiu").Visible = False
    .Sections("Detail").Controls("lblanstudiu").Visible = False
End With
DataReport1.Show
'revin la valorile initiale
With deDBStud.Commands("dcmStudenti")
    .Parameters(0).Value = 1
    .Parameters(1).Value = 0
End With

End Sub

