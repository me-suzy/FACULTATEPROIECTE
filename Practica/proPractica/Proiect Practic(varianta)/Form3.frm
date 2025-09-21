VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FormDatePersonale 
   BackColor       =   &H00000080&
   Caption         =   "Date Personale"
   ClientHeight    =   6600
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8925
   LinkTopic       =   "Form3"
   ScaleHeight     =   6600
   ScaleWidth      =   8925
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdFoto 
      Caption         =   "Incarca Poza"
      Height          =   615
      Left            =   4080
      TabIndex        =   37
      Top             =   1200
      Width           =   735
   End
   Begin MSComDlg.CommonDialog cdgFoto 
      Left            =   720
      Top             =   1200
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.ComboBox Combo1 
      DataField       =   "ANNASTERE"
      DataSource      =   "Adodc1"
      Height          =   315
      ItemData        =   "Form3.frx":0000
      Left            =   2160
      List            =   "Form3.frx":006D
      Style           =   2  'Dropdown List
      TabIndex        =   35
      Top             =   2400
      Width           =   975
   End
   Begin MSAdodcLib.Adodc Adodc1 
      Height          =   375
      Left            =   6240
      Top             =   5280
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
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
      Connect         =   "Provider=MSDAORA.1;Password=2na-sama;User ID=el010288;Data Source=bdstud;Persist Security Info=True"
      OLEDBString     =   "Provider=MSDAORA.1;Password=2na-sama;User ID=el010288;Data Source=bdstud;Persist Security Info=True"
      OLEDBFile       =   ""
      DataSourceName  =   ""
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "STUDENTI"
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
      Top             =   5520
      Width           =   1815
   End
   Begin VB.TextBox txtpermis 
      DataField       =   "PERMISCAT"
      DataSource      =   "Adodc1"
      Height          =   285
      Left            =   2040
      TabIndex        =   33
      Text            =   "Text1"
      Top             =   4560
      Width           =   2175
   End
   Begin VB.TextBox txtsalariu 
      DataField       =   "SALMINIM"
      DataSource      =   "Adodc1"
      Height          =   285
      Left            =   6360
      TabIndex        =   31
      Text            =   "Text10"
      Top             =   4560
      Width           =   2175
   End
   Begin VB.TextBox txthobby 
      DataField       =   "HOBBY"
      DataSource      =   "Adodc1"
      Height          =   285
      Left            =   6360
      TabIndex        =   30
      Text            =   "Text9"
      Top             =   4200
      Width           =   2175
   End
   Begin VB.TextBox txtemail 
      DataField       =   "E_MAIL"
      DataSource      =   "Adodc1"
      Height          =   285
      Left            =   2040
      TabIndex        =   29
      Text            =   "Text8"
      Top             =   4200
      Width           =   2175
   End
   Begin VB.ComboBox cbostagiu 
      DataField       =   "STAGIUMILITAR"
      DataSource      =   "Adodc1"
      Height          =   315
      ItemData        =   "Form3.frx":0143
      Left            =   6360
      List            =   "Form3.frx":0150
      Style           =   2  'Dropdown List
      TabIndex        =   28
      Top             =   3840
      Width           =   2175
   End
   Begin VB.ComboBox cbostare 
      DataField       =   "STARECIVILA"
      DataSource      =   "Adodc1"
      Height          =   315
      ItemData        =   "Form3.frx":017D
      Left            =   2040
      List            =   "Form3.frx":018A
      Style           =   2  'Dropdown List
      TabIndex        =   27
      Top             =   3840
      Width           =   2175
   End
   Begin VB.ComboBox cbosex 
      DataField       =   "SEX"
      DataSource      =   "Adodc1"
      Height          =   315
      ItemData        =   "Form3.frx":01B0
      Left            =   6360
      List            =   "Form3.frx":01BA
      Style           =   2  'Dropdown List
      TabIndex        =   26
      Top             =   3480
      Width           =   855
   End
   Begin VB.TextBox txtcnp 
      DataField       =   "CNP"
      DataSource      =   "Adodc1"
      Height          =   285
      Left            =   2040
      TabIndex        =   25
      Text            =   "Text7"
      Top             =   3480
      Width           =   2175
   End
   Begin VB.TextBox txttelmob 
      DataField       =   "TELMOBIL"
      DataSource      =   "Adodc1"
      Height          =   285
      Left            =   6360
      TabIndex        =   24
      Text            =   "Text6"
      Top             =   3120
      Width           =   2175
   End
   Begin VB.TextBox txttelfix 
      DataField       =   "TELFIX"
      DataSource      =   "Adodc1"
      Height          =   285
      Left            =   2040
      TabIndex        =   23
      Text            =   "Text5"
      Top             =   3120
      Width           =   2175
   End
   Begin VB.TextBox txtadfl 
      DataField       =   "ADRFLOTANTA"
      DataSource      =   "Adodc1"
      Height          =   285
      Left            =   6360
      TabIndex        =   22
      Text            =   "Text4"
      Top             =   2760
      Width           =   2175
   End
   Begin VB.TextBox txtadst 
      DataField       =   "ADRSTABILA"
      DataSource      =   "Adodc1"
      Height          =   285
      Left            =   2040
      TabIndex        =   21
      Text            =   "Text3"
      Top             =   2760
      Width           =   2175
   End
   Begin VB.ComboBox cboziua 
      DataField       =   "ZINASTERE"
      DataSource      =   "Adodc1"
      Height          =   315
      ItemData        =   "Form3.frx":01C4
      Left            =   7080
      List            =   "Form3.frx":0225
      Style           =   2  'Dropdown List
      TabIndex        =   20
      Top             =   2400
      Width           =   855
   End
   Begin VB.ComboBox cboluna 
      DataField       =   "LUNANASTERE"
      DataSource      =   "Adodc1"
      Height          =   315
      ItemData        =   "Form3.frx":029C
      Left            =   4080
      List            =   "Form3.frx":02C4
      Style           =   2  'Dropdown List
      TabIndex        =   18
      Top             =   2400
      Width           =   1455
   End
   Begin VB.TextBox txtprenume 
      DataField       =   "PRENUME"
      DataSource      =   "Adodc1"
      Height          =   285
      Left            =   2040
      TabIndex        =   15
      Text            =   "Text2"
      Top             =   480
      Width           =   2175
   End
   Begin VB.TextBox txtnume 
      DataField       =   "NUME"
      DataSource      =   "Adodc1"
      Height          =   285
      Left            =   2040
      TabIndex        =   14
      Text            =   "Text1"
      Top             =   120
      Width           =   2175
   End
   Begin VB.OLE OLEFoto 
      Class           =   "Paint.Picture"
      Height          =   1695
      Left            =   5760
      OleObjectBlob   =   "Form3.frx":0336
      SizeMode        =   1  'Stretch
      TabIndex        =   36
      Top             =   360
      Width           =   2295
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
      Top             =   4560
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
      Top             =   2400
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
      Top             =   2400
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
      Top             =   2400
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
      Top             =   4440
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
      Top             =   4200
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
      Top             =   4200
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
      Top             =   3840
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
      Top             =   3840
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
      Top             =   3480
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
      Top             =   3480
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
      Top             =   3120
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
      Top             =   3120
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
      Top             =   2760
      Width           =   1575
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "Adresa stabila"
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
      Top             =   2760
      Width           =   1455
   End
   Begin VB.Label Label3 
      BackColor       =   &H00E0E0E0&
      BackStyle       =   0  'Transparent
      Caption         =   "Data nastere:"
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
      Top             =   2400
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

Private Sub Command6_Click()
If MsgBox("Sunteti de acord?", vbYesNo, "Confirmare") = vbYes Then
Adodc1.Recordset.Update
'Adodc1.Recordset.UpdateBatch
End If
FormLimbi.Show
End Sub

