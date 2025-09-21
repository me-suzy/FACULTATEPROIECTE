VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form FormAutentificare 
   BackColor       =   &H00000080&
   Caption         =   "Autentificare"
   ClientHeight    =   4110
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6630
   LinkTopic       =   "Form1"
   ScaleHeight     =   4110
   ScaleWidth      =   6630
   StartUpPosition =   3  'Windows Default
   Begin MSDataListLib.DataCombo cboid 
      Bindings        =   "Form1.frx":0000
      Height          =   315
      Left            =   2280
      TabIndex        =   6
      Top             =   600
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "USERNAME"
      Text            =   ""
   End
   Begin MSAdodcLib.Adodc AdoUseri 
      Height          =   495
      Left            =   360
      Top             =   3120
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
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
      Connect         =   "Provider=MSDAORA.1;Password=2na-sama;User ID=el010288;Data Source=bdstud;Persist Security Info=True"
      OLEDBString     =   "Provider=MSDAORA.1;Password=2na-sama;User ID=el010288;Data Source=bdstud;Persist Security Info=True"
      OLEDBFile       =   ""
      DataSourceName  =   ""
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "USERI"
      Caption         =   "AdoUseri"
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
   Begin VB.CommandButton cmdutilizatornou 
      Caption         =   "&Utilizator nou"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   4440
      TabIndex        =   5
      Top             =   720
      Width           =   1095
   End
   Begin VB.CommandButton cmdabandon 
      Caption         =   "&Abandon"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   2760
      TabIndex        =   4
      Top             =   1920
      Width           =   1335
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
      Height          =   495
      Left            =   1200
      TabIndex        =   3
      Top             =   1920
      Width           =   855
   End
   Begin VB.TextBox txtparola 
      DataField       =   "PASSWORD"
      DataSource      =   "AdoUseri"
      Height          =   375
      IMEMode         =   3  'DISABLE
      Left            =   2280
      PasswordChar    =   "*"
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   1200
      Width           =   1815
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
      TabIndex        =   1
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
cod = cboid.BoundText
AdoUseri.CommandType = adCmdText
AdoUseri.RecordSource = "select * from useri where username=" & cod
'AdoUseri.Recordset.Requery
'AdoUseri.Refresh
End Sub



Private Sub cmdabandon_Click()
If MsgBox("Sunteti de acord?", vbYesNo, "Confirmare") = vbNo Then
AdoUseri.Recordset.CancelBatch
End If
End Sub

Private Sub cmdOK_Click()
If txtCod.Text = "" Or txtparola.Text = "" Then
    MsgBox ("Introduceti contul si parola")
    Exit Sub
Else
    codop = frmLogUser.txtCod.Text
    parola = frmLogUser.txtparola.Text
    codop = Trim(codop)
    MsgBox (codop)
End If
    frmLogUser.AdoLog.Recordset.MoveFirst
    AdoLog.RecordSource = "Select * from operatori where trim(numeoperator)='" & codop & "'"
    'AdoLog.Recordset.Find ("numeoperator= '&codop&'")
If AdoLog.Recordset.BOF Or AdoLog.Recordset.EOF Then
    MsgBox "Contul Utilizatorului este gresit!"
    Exit Sub
Else
    If parola <> AdoLog.Recordset![parola] Then
        MsgBox "Parola Gresita!"
        Exit Sub
    End If
End If
    Editari.coddrept = AdoLog.Recordset![coddrept]
    'MsgBox Editari.coddrept
If coddrept = 2 Then
    Editari.drepturi_operator
    
End If
If coddrept = 3 Then
    Editari.drepturi_student
    
End If

    Me.Visible = False

 
 FrmMeniu.Show



'select adouseri.Password into v_pass from adouseri.Recordset where txtparola.Text



If MsgBox("Sunteti de acord?", vbYesNo, "Confirmare") = vbYes Then
AdoUseri.Recordset.UpdateBatch
AdoUseri.Recordset ("SELECT * FROM useri where cboid.text=username & txtparola.text=password")
End If
FormDatePersonale.Show
End Sub

Private Sub cmdutilizatornou_Click()
FormUtilizatorNou.Show
End Sub

Private Sub Form_Load()
AdoUseri.Recordset.MoveFirst
'cboUseri.BoundText = adoUsei.Recordset!UserName
End Sub

