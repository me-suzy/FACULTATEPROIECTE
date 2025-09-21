VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Begin VB.Form FormStudii 
   BackColor       =   &H00000080&
   Caption         =   "Studii"
   ClientHeight    =   10770
   ClientLeft      =   5175
   ClientTop       =   1500
   ClientWidth     =   9810
   LinkTopic       =   "Form1"
   ScaleHeight     =   10770
   ScaleWidth      =   9810
   Begin VB.TextBox Text8 
      DataField       =   "FRONTNIVEL"
      DataSource      =   "Adosoft"
      Height          =   375
      Left            =   4080
      MaxLength       =   9
      TabIndex        =   26
      ToolTipText     =   "Avansat, Mediu sau Incepator"
      Top             =   8040
      Width           =   1695
   End
   Begin VB.TextBox Text7 
      DataField       =   "FLASHNIVEL"
      DataSource      =   "Adosoft"
      Height          =   405
      Left            =   4080
      MaxLength       =   9
      TabIndex        =   25
      ToolTipText     =   "Avansat, Mediu sau Incepator"
      Top             =   7440
      Width           =   1695
   End
   Begin VB.TextBox Text6 
      DataField       =   "MACRONIVEL"
      DataSource      =   "Adosoft"
      Height          =   375
      Left            =   4080
      MaxLength       =   9
      TabIndex        =   24
      ToolTipText     =   "Avansat, Mediu sau Incepator"
      Top             =   6960
      Width           =   1695
   End
   Begin VB.TextBox Text5 
      DataField       =   "JAVANIVEL"
      DataSource      =   "Adosoft"
      Height          =   375
      Left            =   4080
      MaxLength       =   9
      TabIndex        =   23
      ToolTipText     =   "Avansat, Mediu sau Incepator"
      Top             =   6240
      Width           =   1695
   End
   Begin VB.TextBox Text4 
      DataField       =   "VBNIVEL"
      DataSource      =   "Adosoft"
      Height          =   375
      Left            =   4080
      MaxLength       =   9
      TabIndex        =   22
      ToolTipText     =   "Avansat, Mediu sau Incepator"
      Top             =   5520
      Width           =   1695
   End
   Begin VB.TextBox Text3 
      DataField       =   "VFPNIVEL"
      DataSource      =   "Adosoft"
      Height          =   495
      Left            =   4080
      MaxLength       =   9
      TabIndex        =   21
      ToolTipText     =   "Avansat, Mediu sau Incepator"
      Top             =   4560
      Width           =   1815
   End
   Begin VB.TextBox Text2 
      DataField       =   "ORACLENIVEL"
      DataSource      =   "Adosoft"
      Height          =   375
      HideSelection   =   0   'False
      Left            =   4080
      MaxLength       =   9
      TabIndex        =   20
      ToolTipText     =   "Avansat, Mediu sau Incepator"
      Top             =   3960
      Width           =   1815
   End
   Begin VB.TextBox Text1 
      DataField       =   "ALTESOFTURI"
      DataSource      =   "Adosoft"
      Height          =   1215
      Left            =   1560
      ScrollBars      =   3  'Both
      TabIndex        =   19
      ToolTipText     =   "Cele mai semnificative..."
      Top             =   8760
      Width           =   6735
   End
   Begin MSAdodcLib.Adodc Adosoft 
      Height          =   375
      Left            =   6840
      Top             =   480
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
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
      RecordSource    =   "STUD_SOFT"
      Caption         =   "Adosoft"
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
   Begin MSAdodcLib.Adodc Adostud 
      Height          =   375
      Left            =   6960
      Top             =   1440
      Visible         =   0   'False
      Width           =   2415
      _ExtentX        =   4260
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
   Begin VB.CommandButton Command1 
      Caption         =   "Abandon"
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
      Left            =   7320
      TabIndex        =   7
      Top             =   2280
      Width           =   1095
   End
   Begin VB.CommandButton Command3 
      Caption         =   "&Salvez CV"
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
      Left            =   7320
      TabIndex        =   6
      Top             =   2760
      Width           =   1095
   End
   Begin VB.TextBox txtactivitextrasc 
      DataField       =   "ACTIVITEXTRASC"
      DataSource      =   "Adostud"
      Height          =   855
      Left            =   1560
      TabIndex        =   5
      Top             =   2280
      Width           =   5055
   End
   Begin VB.TextBox txtstagiistrain 
      DataField       =   "STAGIISTRAIN"
      DataSource      =   "Adostud"
      Height          =   855
      Left            =   1560
      TabIndex        =   4
      Top             =   1200
      Width           =   5055
   End
   Begin VB.TextBox txtaltestudii 
      DataField       =   "ALTESTUDII"
      DataSource      =   "Adostud"
      Height          =   735
      Left            =   1560
      TabIndex        =   3
      Top             =   240
      Width           =   5055
   End
   Begin VB.Label Label15 
      BackStyle       =   0  'Transparent
      Caption         =   "Nivel de cunostinte"
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
      Left            =   4200
      TabIndex        =   27
      Top             =   3360
      Width           =   1815
   End
   Begin VB.Line Line8 
      BorderColor     =   &H8000000E&
      X1              =   240
      X2              =   240
      Y1              =   3720
      Y2              =   8520
   End
   Begin VB.Line Line7 
      BorderColor     =   &H8000000E&
      X1              =   6120
      X2              =   6120
      Y1              =   3720
      Y2              =   8520
   End
   Begin VB.Label Label14 
      BackStyle       =   0  'Transparent
      Caption         =   "Alte softuri"
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
      Height          =   375
      Left            =   360
      TabIndex        =   18
      Top             =   8760
      Width           =   1095
   End
   Begin VB.Line Line6 
      BorderColor     =   &H8000000E&
      X1              =   240
      X2              =   6120
      Y1              =   8520
      Y2              =   8520
   End
   Begin VB.Label Label13 
      BackStyle       =   0  'Transparent
      Caption         =   "Front Page"
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
      Height          =   375
      Left            =   1920
      TabIndex        =   17
      Top             =   7920
      Width           =   1575
   End
   Begin VB.Label Label12 
      BackStyle       =   0  'Transparent
      Caption         =   "Macromedia Flash"
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
      Height          =   375
      Left            =   1920
      TabIndex        =   16
      Top             =   7440
      Width           =   1455
   End
   Begin VB.Label Label11 
      BackStyle       =   0  'Transparent
      Caption         =   "Macromedia Dreamwaver"
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
      Height          =   495
      Left            =   1920
      TabIndex        =   15
      Top             =   6960
      Width           =   1455
   End
   Begin VB.Label Label10 
      BackStyle       =   0  'Transparent
      Caption         =   "Aplicatii web"
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
      Height          =   375
      Left            =   360
      TabIndex        =   14
      Top             =   6960
      Width           =   975
   End
   Begin VB.Line Line5 
      BorderColor     =   &H8000000E&
      X1              =   240
      X2              =   6120
      Y1              =   6720
      Y2              =   6720
   End
   Begin VB.Label Label9 
      BackStyle       =   0  'Transparent
      Caption         =   "Java"
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
      Left            =   1920
      TabIndex        =   13
      Top             =   6240
      Width           =   1095
   End
   Begin VB.Label Label8 
      BackStyle       =   0  'Transparent
      Caption         =   "Visual Basic"
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
      Height          =   375
      Left            =   1920
      TabIndex        =   12
      Top             =   5520
      Width           =   1095
   End
   Begin VB.Label Label7 
      BackStyle       =   0  'Transparent
      Caption         =   "Medii de dezvoltare"
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
      Height          =   495
      Left            =   360
      TabIndex        =   11
      Top             =   5640
      Width           =   1095
   End
   Begin VB.Line Line4 
      BorderColor     =   &H80000005&
      X1              =   240
      X2              =   6120
      Y1              =   5400
      Y2              =   5400
   End
   Begin VB.Line Line3 
      BorderColor     =   &H80000005&
      X1              =   3720
      X2              =   3720
      Y1              =   3720
      Y2              =   8520
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000005&
      X1              =   1680
      X2              =   1680
      Y1              =   3720
      Y2              =   8520
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      X1              =   240
      X2              =   6120
      Y1              =   3720
      Y2              =   3720
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "Visual Fox Pro"
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
      Height          =   375
      Left            =   2040
      TabIndex        =   10
      Top             =   4680
      Width           =   1335
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Oracle"
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
      Height          =   375
      Left            =   2040
      TabIndex        =   9
      Top             =   4080
      Width           =   1335
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Baze de date"
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
      Height          =   375
      Left            =   360
      TabIndex        =   8
      Top             =   4080
      Width           =   1095
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "Alte activitati inteprinse pe care le considerati relevante"
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
      Height          =   1095
      Left            =   240
      TabIndex        =   2
      Top             =   2280
      Width           =   1215
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "Stagii de lucru in strainatate"
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
      Height          =   495
      Left            =   120
      TabIndex        =   1
      Top             =   1320
      Width           =   1335
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Studii"
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
      Height          =   375
      Left            =   360
      TabIndex        =   0
      Top             =   240
      Width           =   1335
   End
End
Attribute VB_Name = "FormStudii"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim pusername As String
Dim psoft As String
Dim o1 As Integer
Dim o2 As Integer
Dim o3 As Integer
Private Sub cbosoft_Change()
categ = cbosoft.Text
Adosoft.RecordSource = "select densoft,nivel from stud_soft where categorie ='" & categ & "'"
End Sub

Private Sub Command1_Click()
Adostud.Recordset.CancelBatch
Adosoft.Recordset.CancelBatch
Unload Me
End Sub

Private Sub Command3_Click()
Adostud.Recordset.UpdateBatch
Adosoft.Recordset.UpdateBatch
Unload Me
End Sub

Private Sub Option2_Click()
o1 = 0
o2 = Option2.Value
o3 = 0
pusername = Module1.username_
Adosoft.Recordset.AddNew (o2)
End Sub

Private Sub Option3_Click()
o1 = 0
o2 = 0
o3 = Option3.Value
Adosoft.Recordset.AddNew (o3)
End Sub
