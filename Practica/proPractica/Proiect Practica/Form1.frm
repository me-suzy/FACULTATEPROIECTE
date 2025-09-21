VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form FormAutentificare 
   BackColor       =   &H00000080&
   Caption         =   "            "
   ClientHeight    =   2925
   ClientLeft      =   4425
   ClientTop       =   4125
   ClientWidth     =   5610
   LinkTopic       =   "Form1"
   ScaleHeight     =   2925
   ScaleWidth      =   5610
   Begin MSAdodcLib.Adodc Adouseri 
      Height          =   495
      Left            =   240
      Top             =   2040
      Visible         =   0   'False
      Width           =   2895
      _ExtentX        =   5106
      _ExtentY        =   873
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   30
      CursorType      =   3
      LockType        =   3
      CommandType     =   2
      CursorOptions   =   0
      CacheSize       =   50
      MaxRecords      =   0
      BOFAction       =   0
      EOFAction       =   0
      ConnectStringType=   1
      Appearance      =   1
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Orientation     =   0
      Enabled         =   -1
      Connect         =   "Provider=MSDAORA.1;Password=tiger;User ID=scott;Data Source=Oracle;Persist Security Info=True"
      OLEDBString     =   "Provider=MSDAORA.1;Password=tiger;User ID=scott;Data Source=Oracle;Persist Security Info=True"
      OLEDBFile       =   ""
      DataSourceName  =   ""
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "USERI"
      Caption         =   "Adodc1"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _Version        =   393216
   End
   Begin VB.CommandButton cmdabandon 
      Caption         =   "&Cancel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4440
      TabIndex        =   3
      Top             =   1680
      Width           =   855
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "&OK"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3360
      TabIndex        =   2
      Top             =   1680
      Width           =   855
   End
   Begin VB.TextBox txtparola 
      Height          =   375
      IMEMode         =   3  'DISABLE
      Left            =   3600
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   960
      Width           =   1815
   End
   Begin MSDataListLib.DataCombo cboid 
      Bindings        =   "Form1.frx":0000
      Height          =   315
      Left            =   3600
      TabIndex        =   5
      Top             =   600
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "USERNAME"
      Text            =   ""
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Parola"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   1080
      TabIndex        =   4
      Top             =   1200
      Width           =   855
   End
   Begin VB.Label Identificator 
      BackStyle       =   0  'Transparent
      Caption         =   "Identificator"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   840
      TabIndex        =   0
      Top             =   600
      Width           =   1335
   End
End
Attribute VB_Name = "FormAutentificare"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cboid_Change()
'cod = cboid.BoundText
'AdoUseri.CommandType = adCmdText
'AdoUseri.RecordSource = "select * from useri where username=" & cod
cod = cboid.BoundText
AdoUseri.Recordset.Find "username = '" & cod & "'", , adSearchForward, 1
'AdoUseri.Recordset.Requery
'AdoUseri.Refresh
End Sub



Private Sub cmdabandon_Click()
If MsgBox("Parasiti aplicatia", vbYes, "Atentie") = vbNo Then
AdoUseri.Recordset.CancelBatch
End If
Unload Me
End Sub

Private Sub cmdOK_Click()
' in caz ca nu se introduce user-ul si parola
If cboid.Text = "" Or txtparola.Text = "" Then
    MsgBox ("Introduceti username-ul si parola")
    Exit Sub
Else
    Module1.username_ = FormAutentificare.cboid.Text
    parola = FormAutentificare.txtparola.Text
    vparola = AdoUseri.Recordset![Password]
If AdoUseri.Recordset.BOF Or AdoUseri.Recordset.EOF Then
    MsgBox "Contul Utilizatorului este gresit!"
    Exit Sub
Else
    If parola <> vparola Then
        MsgBox "Parola Gresita!"
        Exit Sub
    End If
End If
        FormDatePersonale.Show
End If
    Unload Me
End Sub

Private Sub cmdutilizatornou_Click()
FormUtilizatorNou.Show
Unload Me
End Sub

Private Function gresit()
On Error Resume Next
Timer1.Enabled = True
Static parola As Variant
        If txtparola <> txtparola2.Text Then
            parola = parola + 1
        End If
                If parola = 1 Then
                    txtparola.Text = ""
                    txtparola.SetFocus
                    lblincercari = "1"
                    lblnrincerc.Visible = True
                End If
                If parola = 2 Then
                      txtparola.Text = ""
                      txtparola.SetFocus
                      lblincercari = "2"
                       lblnrincerc.Visible = True
                End If
                If parola = 3 Then
                     MsgBox "Ati gresit parola de 3 ori. La revedere !", vbOKOnly + vbCritical, "Ne pare rau ..."
                     End
                End If
End Function



Private Sub txtparola_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
KeyAscii = 0
cmdOK_Click
End If
End Sub
