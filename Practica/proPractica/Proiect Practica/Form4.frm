VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Begin VB.Form FormLimbi 
   BackColor       =   &H00000080&
   Caption         =   "Limbi straine"
   ClientHeight    =   7695
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9495
   LinkTopic       =   "Form1"
   ScaleHeight     =   7695
   ScaleWidth      =   9495
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text2 
      DataField       =   "ALTELIMBI"
      DataSource      =   "Adolimbi"
      Height          =   4455
      Left            =   4080
      TabIndex        =   19
      Top             =   2040
      Width           =   1575
   End
   Begin VB.TextBox Text14 
      DataField       =   "ENGLEZA"
      DataSource      =   "Adolimbi"
      Height          =   375
      HideSelection   =   0   'False
      Left            =   1800
      MaxLength       =   9
      TabIndex        =   17
      ToolTipText     =   "avansat, mediu sau incepator"
      Top             =   2040
      Width           =   1815
   End
   Begin VB.TextBox Text13 
      DataField       =   "FRANCEZA"
      DataSource      =   "Adolimbi"
      Height          =   495
      Left            =   1800
      MaxLength       =   9
      TabIndex        =   16
      ToolTipText     =   "avansat, mediu sau incepator"
      Top             =   2640
      Width           =   1815
   End
   Begin VB.TextBox Text12 
      DataField       =   "GERMANA"
      DataSource      =   "Adolimbi"
      Height          =   375
      Left            =   1800
      MaxLength       =   9
      TabIndex        =   15
      ToolTipText     =   "avansat, mediu sau incepator"
      Top             =   3600
      Width           =   1695
   End
   Begin VB.TextBox Text11 
      DataField       =   "SPANIOLA"
      DataSource      =   "Adolimbi"
      Height          =   375
      Left            =   1800
      MaxLength       =   9
      TabIndex        =   14
      ToolTipText     =   "avansat, mediu sau incepator"
      Top             =   4320
      Width           =   1695
   End
   Begin VB.TextBox Text10 
      DataField       =   "RUSA"
      DataSource      =   "Adolimbi"
      Height          =   375
      Left            =   1800
      MaxLength       =   9
      TabIndex        =   13
      ToolTipText     =   "avansat, mediu sau incepator"
      Top             =   5040
      Width           =   1695
   End
   Begin VB.TextBox Text9 
      DataField       =   "PORTUGHEZA"
      DataSource      =   "Adolimbi"
      Height          =   405
      Left            =   1800
      MaxLength       =   9
      TabIndex        =   12
      ToolTipText     =   "avansat, mediu sau incepator"
      Top             =   5520
      Width           =   1695
   End
   Begin VB.TextBox Text1 
      DataField       =   "ITALIANA"
      DataSource      =   "Adolimbi"
      Height          =   375
      Left            =   1800
      MaxLength       =   9
      TabIndex        =   11
      ToolTipText     =   "avansat, mediu sau incepator"
      Top             =   6120
      Width           =   1695
   End
   Begin MSAdodcLib.Adodc Adolimbi 
      Height          =   375
      Left            =   4200
      Top             =   6960
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
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
      RecordSource    =   "STUD_LB_STRAINE"
      Caption         =   "Adolimbi"
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
      Left            =   7200
      TabIndex        =   3
      Top             =   6960
      Width           =   1695
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000005&
      X1              =   5880
      X2              =   5880
      Y1              =   1320
      Y2              =   6600
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "Alte limbi cunoscute"
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
      Index           =   2
      Left            =   3960
      TabIndex        =   18
      Top             =   1440
      Width           =   1815
   End
   Begin VB.Line Line5 
      BorderColor     =   &H80000005&
      X1              =   360
      X2              =   5880
      Y1              =   1320
      Y2              =   1320
   End
   Begin VB.Line Line4 
      BorderColor     =   &H8000000E&
      X1              =   1560
      X2              =   1560
      Y1              =   1320
      Y2              =   6600
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Engleza"
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
      Index           =   1
      Left            =   480
      TabIndex        =   10
      Top             =   2040
      Width           =   735
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "Franceza"
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
      Index           =   1
      Left            =   480
      TabIndex        =   9
      Top             =   2760
      Width           =   975
   End
   Begin VB.Line Line10 
      BorderColor     =   &H80000005&
      X1              =   360
      X2              =   5880
      Y1              =   1800
      Y2              =   1800
   End
   Begin VB.Line Line3 
      BorderColor     =   &H80000005&
      X1              =   3840
      X2              =   3840
      Y1              =   1320
      Y2              =   6600
   End
   Begin VB.Label Label8 
      BackStyle       =   0  'Transparent
      Caption         =   "Germana"
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
      Left            =   480
      TabIndex        =   8
      Top             =   3600
      Width           =   855
   End
   Begin VB.Label Label9 
      BackStyle       =   0  'Transparent
      Caption         =   "Spaniola"
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
      Left            =   480
      TabIndex        =   7
      Top             =   4440
      Width           =   855
   End
   Begin VB.Label Label11 
      BackStyle       =   0  'Transparent
      Caption         =   "Rusa"
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
      Left            =   600
      TabIndex        =   6
      Top             =   5160
      Width           =   615
   End
   Begin VB.Label Label12 
      BackStyle       =   0  'Transparent
      Caption         =   "Portugheza"
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
      Left            =   480
      TabIndex        =   5
      Top             =   5640
      Width           =   1095
   End
   Begin VB.Label Label13 
      BackStyle       =   0  'Transparent
      Caption         =   "Italiana"
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
      Left            =   600
      TabIndex        =   4
      Top             =   6240
      Width           =   735
   End
   Begin VB.Line Line6 
      BorderColor     =   &H8000000E&
      X1              =   360
      X2              =   5880
      Y1              =   6600
      Y2              =   6600
   End
   Begin VB.Line Line8 
      BorderColor     =   &H8000000E&
      X1              =   360
      X2              =   360
      Y1              =   1320
      Y2              =   6600
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Alegeti limba si nivelul de cunostinte."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   375
      Left            =   720
      TabIndex        =   2
      Top             =   960
      Width           =   4815
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Limba"
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
      Index           =   1
      Left            =   720
      TabIndex        =   1
      Top             =   1440
      Width           =   495
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "Nivel"
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
      Index           =   0
      Left            =   2280
      TabIndex        =   0
      Top             =   1440
      Width           =   735
   End
End
Attribute VB_Name = "FormLimbi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Adolimbi.Recordset.Update
Adolimbi.Recordset.UpdateBatch
FormStudii.Show
Unload Me
End Sub
