VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Begin VB.Form FormDatePersonale 
   BackColor       =   &H00000080&
   Caption         =   "Date Personale"
   ClientHeight    =   4980
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8925
   LinkTopic       =   "Form3"
   ScaleHeight     =   4980
   ScaleWidth      =   8925
   StartUpPosition =   3  'Windows Default
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
      Height          =   375
      Left            =   6120
      TabIndex        =   36
      Top             =   4080
      Width           =   1815
   End
   Begin MSAdodcLib.Adodc Adostud 
      Height          =   375
      Left            =   360
      Top             =   4200
      Visible         =   0   'False
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   661
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
      RecordSource    =   "STUDENTI"
      Caption         =   "Adostud"
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
   Begin VB.ComboBox cboan 
      DataField       =   "ANNASTERE"
      DataSource      =   "Adostud"
      Height          =   315
      ItemData        =   "Form3.frx":0000
      Left            =   2160
      List            =   "Form3.frx":006D
      Style           =   2  'Dropdown List
      TabIndex        =   35
      Top             =   960
      Width           =   975
   End
   Begin VB.CommandButton Command6 
      Caption         =   "&Continuare >>>"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3000
      TabIndex        =   34
      Top             =   4080
      Width           =   1815
   End
   Begin VB.TextBox txtpermis 
      DataField       =   "PERMISCAT"
      DataSource      =   "Adostud"
      Height          =   285
      Left            =   2040
      TabIndex        =   33
      Top             =   3120
      Width           =   2175
   End
   Begin VB.TextBox txtsalariu 
      DataField       =   "SALMINIM"
      DataSource      =   "Adostud"
      Height          =   285
      Left            =   6360
      TabIndex        =   31
      Top             =   3120
      Width           =   2175
   End
   Begin VB.TextBox txthobby 
      DataField       =   "HOBBY"
      DataSource      =   "Adostud"
      Height          =   285
      Left            =   6360
      TabIndex        =   30
      Top             =   2760
      Width           =   2175
   End
   Begin VB.TextBox txtemail 
      DataField       =   "E_MAIL"
      DataSource      =   "Adostud"
      Height          =   285
      Left            =   2040
      TabIndex        =   29
      Top             =   2760
      Width           =   2175
   End
   Begin VB.ComboBox cbostagiu 
      DataField       =   "STAGIUMILITAR"
      DataSource      =   "Adostud"
      Height          =   315
      ItemData        =   "Form3.frx":0143
      Left            =   6360
      List            =   "Form3.frx":0150
      Style           =   2  'Dropdown List
      TabIndex        =   28
      Top             =   2400
      Width           =   2175
   End
   Begin VB.ComboBox cbostare 
      DataField       =   "STARECIVILA"
      DataSource      =   "Adostud"
      Height          =   315
      ItemData        =   "Form3.frx":017D
      Left            =   2040
      List            =   "Form3.frx":018A
      Style           =   2  'Dropdown List
      TabIndex        =   27
      Top             =   2400
      Width           =   2175
   End
   Begin VB.ComboBox cbosex 
      DataField       =   "SEX"
      DataSource      =   "Adostud"
      Height          =   315
      ItemData        =   "Form3.frx":01B0
      Left            =   6360
      List            =   "Form3.frx":01BA
      Style           =   2  'Dropdown List
      TabIndex        =   26
      Top             =   2040
      Width           =   855
   End
   Begin VB.TextBox txtcnp 
      DataField       =   "CNP"
      DataSource      =   "Adostud"
      Height          =   285
      Left            =   2040
      TabIndex        =   25
      Top             =   2040
      Width           =   2175
   End
   Begin VB.TextBox txttelmob 
      DataField       =   "TELMOBIL"
      DataSource      =   "Adostud"
      Height          =   285
      Left            =   6360
      TabIndex        =   24
      Top             =   1680
      Width           =   2175
   End
   Begin VB.TextBox txttelfix 
      DataField       =   "TELFIX"
      DataSource      =   "Adostud"
      Height          =   285
      Left            =   2040
      TabIndex        =   23
      Top             =   1680
      Width           =   2175
   End
   Begin VB.TextBox txtadfl 
      DataField       =   "ADRFLOTANTA"
      DataSource      =   "Adostud"
      Height          =   285
      Left            =   6360
      TabIndex        =   22
      Top             =   1320
      Width           =   2175
   End
   Begin VB.TextBox txtadst 
      DataField       =   "ADRSTABILA"
      DataSource      =   "Adostud"
      Height          =   285
      Left            =   2040
      TabIndex        =   21
      Top             =   1320
      Width           =   2175
   End
   Begin VB.ComboBox cboziua 
      DataField       =   "ZINASTERE"
      DataSource      =   "Adostud"
      Height          =   315
      ItemData        =   "Form3.frx":01C4
      Left            =   7080
      List            =   "Form3.frx":0225
      Style           =   2  'Dropdown List
      TabIndex        =   20
      Top             =   960
      Width           =   855
   End
   Begin VB.ComboBox cboluna 
      DataField       =   "LUNANASTERE"
      DataSource      =   "Adostud"
      Height          =   315
      ItemData        =   "Form3.frx":029C
      Left            =   4080
      List            =   "Form3.frx":02C4
      Style           =   2  'Dropdown List
      TabIndex        =   18
      Top             =   960
      Width           =   1455
   End
   Begin VB.TextBox txtprenume 
      DataField       =   "PRENUME"
      DataSource      =   "Adostud"
      Height          =   285
      Left            =   2040
      TabIndex        =   15
      Top             =   480
      Width           =   2175
   End
   Begin VB.TextBox txtnume 
      DataField       =   "NUME"
      DataSource      =   "Adostud"
      Height          =   285
      Left            =   2040
      TabIndex        =   14
      Top             =   120
      Width           =   2175
   End
   Begin VB.Label Label18 
      BackStyle       =   0  'Transparent
      Caption         =   "Permis conducere"
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
      Left            =   120
      TabIndex        =   32
      Top             =   3120
      Width           =   1695
   End
   Begin VB.Label Label17 
      BackStyle       =   0  'Transparent
      Caption         =   "Ziua"
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
      Left            =   6240
      TabIndex        =   19
      Top             =   960
      Width           =   375
   End
   Begin VB.Label Label16 
      BackStyle       =   0  'Transparent
      Caption         =   "Luna"
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
      TabIndex        =   17
      Top             =   960
      Width           =   495
   End
   Begin VB.Label Label15 
      BackStyle       =   0  'Transparent
      Caption         =   "An"
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
      Left            =   1680
      TabIndex        =   16
      Top             =   960
      Width           =   255
   End
   Begin VB.Label Label14 
      BackStyle       =   0  'Transparent
      Caption         =   "Salariu minim (Euro)"
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
      Height          =   735
      Left            =   4440
      TabIndex        =   13
      Top             =   3000
      Width           =   975
   End
   Begin VB.Label Label13 
      BackStyle       =   0  'Transparent
      Caption         =   "Hobby"
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
      Left            =   4440
      TabIndex        =   12
      Top             =   2760
      Width           =   615
   End
   Begin VB.Label Label12 
      BackStyle       =   0  'Transparent
      Caption         =   "E-mail"
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
      Left            =   120
      TabIndex        =   11
      Top             =   2760
      Width           =   615
   End
   Begin VB.Label Label11 
      BackStyle       =   0  'Transparent
      Caption         =   "Stagiu militar"
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
      Left            =   4440
      TabIndex        =   10
      Top             =   2400
      Width           =   1215
   End
   Begin VB.Label Label10 
      BackStyle       =   0  'Transparent
      Caption         =   "Stare civila"
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
      Left            =   120
      TabIndex        =   9
      Top             =   2400
      Width           =   1215
   End
   Begin VB.Label Label9 
      BackStyle       =   0  'Transparent
      Caption         =   "Sex"
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
      Left            =   4440
      TabIndex        =   8
      Top             =   2040
      Width           =   495
   End
   Begin VB.Label Label8 
      BackStyle       =   0  'Transparent
      Caption         =   "CNP"
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
      Left            =   120
      TabIndex        =   7
      Top             =   2040
      Width           =   495
   End
   Begin VB.Label Label7 
      BackStyle       =   0  'Transparent
      Caption         =   "Telefon mobil"
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
      Left            =   4440
      TabIndex        =   6
      Top             =   1680
      Width           =   1215
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "Telefon fix"
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
      Left            =   120
      TabIndex        =   5
      Top             =   1680
      Width           =   975
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Adresa flotanta"
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
      Left            =   4440
      TabIndex        =   4
      Top             =   1320
      Width           =   1575
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "Adresa stabila"
      DataSource      =   "Adostud"
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
      Left            =   120
      TabIndex        =   3
      Top             =   1320
      Width           =   1455
   End
   Begin VB.Label Label3 
      BackColor       =   &H00E0E0E0&
      BackStyle       =   0  'Transparent
      Caption         =   "Data nastere:"
      DataSource      =   "Adostud"
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
      Left            =   120
      TabIndex        =   2
      Top             =   960
      Width           =   1215
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Prenume"
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
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   735
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Nume"
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
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   615
   End
End
Attribute VB_Name = "FormDatePersonale"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cboan_Change()
'Adodc1.Recordset.MoveFirst
'Adodc1.Recordset.Fields ("annastere")
End Sub



Private Sub cmdFoto_Click()
With FormDatePersonale.cdgFoto
.DialogTitle = "deschide"
.InitDir = App.Path & "\graphics\photo"
.ShowOpen
OLEFoto.CreateLink (.FileName)
End With
End Sub

Private Sub cmdutilizatornou_Click()
FormUtilizatorNou.Show
End Sub

Private Sub Command6_Click()
'Adostud.Recordset.Update
Adostud.Recordset.UpdateBatch
FormLimbi.Show
Unload Me
End Sub

