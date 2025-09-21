VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Begin VB.Form FormUtilizatorNou 
   BackColor       =   &H00000080&
   Caption         =   "Utilizator Nou"
   ClientHeight    =   3525
   ClientLeft      =   4800
   ClientTop       =   3555
   ClientWidth     =   10020
   LinkTopic       =   "Form1"
   ScaleHeight     =   3525
   ScaleWidth      =   10020
   Begin VB.TextBox txtusername 
      DataField       =   "USERNAME"
      DataSource      =   "AdoUseri"
      Height          =   375
      Left            =   4680
      TabIndex        =   8
      Top             =   960
      Width           =   2175
   End
   Begin MSAdodcLib.Adodc AdoUseri 
      Height          =   615
      Left            =   240
      Top             =   2640
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   1085
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
   Begin VB.CommandButton Command2 
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
      TabIndex        =   7
      Top             =   2880
      Width           =   975
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
      TabIndex        =   6
      Top             =   2880
      Width           =   975
   End
   Begin VB.TextBox txtparola2 
      Height          =   375
      IMEMode         =   3  'DISABLE
      Left            =   4680
      PasswordChar    =   "*"
      TabIndex        =   4
      Top             =   2040
      Width           =   2175
   End
   Begin VB.TextBox txtparola 
      DataField       =   "PASSWORD"
      DataSource      =   "AdoUseri"
      Height          =   375
      IMEMode         =   3  'DISABLE
      Left            =   4680
      PasswordChar    =   "*"
      TabIndex        =   2
      Top             =   1560
      Width           =   2175
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "Reintroduceti parola"
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
      Left            =   2400
      TabIndex        =   5
      Top             =   2040
      Width           =   2295
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "Parola noua"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   3360
      TabIndex        =   3
      Top             =   1560
      Width           =   1335
   End
   Begin VB.Label Label2 
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
      Left            =   3120
      TabIndex        =   1
      Top             =   960
      Width           =   1455
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Va rugam alegeti identificatorul dumneavoastra si introduceti o parola noua."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   285
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   8610
   End
End
Attribute VB_Name = "FormUtilizatorNou"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cboid_Change()
cod = cboid.BoundText
'AdoUseri.CommandType = adCmdText
AdoUseri.RecordSource = "select * from useri where username=" & cod
End Sub

Private Sub cmdOK_Click()
If txtparola.Text = txtparola2.Text Then
    AdoUseri.Recordset.Update
    FormDatePersonale.Show
    Unload Me
End If
End Sub

Private Sub Command2_Click()
    AdoUseri.Recordset.CancelBatch
    FormDatePersonale.Show
    Unload Me
End Sub
