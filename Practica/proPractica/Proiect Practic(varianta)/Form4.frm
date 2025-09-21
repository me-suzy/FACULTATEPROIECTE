VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Begin VB.Form FormLimbi 
   BackColor       =   &H00000080&
   Caption         =   "Limbi straine"
   ClientHeight    =   5940
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7605
   LinkTopic       =   "Form1"
   ScaleHeight     =   5940
   ScaleWidth      =   7605
   StartUpPosition =   3  'Windows Default
   Begin MSAdodcLib.Adodc adolimbi 
      Height          =   615
      Left            =   600
      Top             =   4800
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
      Connect         =   "Provider=MSDAORA.1;Password=2na-sama;User ID=el010288;Data Source=bdstud;Persist Security Info=True"
      OLEDBString     =   "Provider=MSDAORA.1;Password=2na-sama;User ID=el010288;Data Source=bdstud;Persist Security Info=True"
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
      Left            =   5040
      TabIndex        =   25
      Top             =   4680
      Width           =   1695
   End
   Begin VB.ComboBox Combo12 
      DataField       =   "SCRIS"
      DataSource      =   "adolimbi"
      Height          =   315
      ItemData        =   "Form4.frx":0000
      Left            =   5880
      List            =   "Form4.frx":000D
      Style           =   2  'Dropdown List
      TabIndex        =   23
      Top             =   3960
      Width           =   975
   End
   Begin VB.ComboBox Combo11 
      DataField       =   "VORBIT"
      DataSource      =   "adolimbi"
      Height          =   315
      ItemData        =   "Form4.frx":002C
      Left            =   4440
      List            =   "Form4.frx":0039
      Style           =   2  'Dropdown List
      TabIndex        =   22
      Top             =   3960
      Width           =   975
   End
   Begin VB.ComboBox Combo10 
      DataField       =   "CITIT"
      DataSource      =   "adolimbi"
      Height          =   315
      ItemData        =   "Form4.frx":0058
      Left            =   3000
      List            =   "Form4.frx":0065
      Style           =   2  'Dropdown List
      TabIndex        =   21
      Top             =   3960
      Width           =   1095
   End
   Begin VB.ComboBox Combo9 
      DataField       =   "SCRIS"
      DataSource      =   "adolimbi"
      Height          =   315
      ItemData        =   "Form4.frx":0084
      Left            =   5880
      List            =   "Form4.frx":0091
      Style           =   2  'Dropdown List
      TabIndex        =   20
      Top             =   3120
      Width           =   975
   End
   Begin VB.ComboBox Combo8 
      DataField       =   "VORBIT"
      DataSource      =   "adolimbi"
      Height          =   315
      ItemData        =   "Form4.frx":00B0
      Left            =   4440
      List            =   "Form4.frx":00BD
      Style           =   2  'Dropdown List
      TabIndex        =   19
      Top             =   3120
      Width           =   975
   End
   Begin VB.ComboBox Combo7 
      DataField       =   "CITIT"
      DataSource      =   "adolimbi"
      Height          =   315
      ItemData        =   "Form4.frx":00DC
      Left            =   3000
      List            =   "Form4.frx":00E9
      Style           =   2  'Dropdown List
      TabIndex        =   18
      Top             =   3120
      Width           =   1095
   End
   Begin VB.ComboBox Combo6 
      DataField       =   "SCRIS"
      DataSource      =   "adolimbi"
      Height          =   315
      ItemData        =   "Form4.frx":0108
      Left            =   5880
      List            =   "Form4.frx":0115
      Style           =   2  'Dropdown List
      TabIndex        =   17
      Top             =   2280
      Width           =   975
   End
   Begin VB.ComboBox Combo5 
      DataField       =   "VORBIT"
      DataSource      =   "adolimbi"
      Height          =   315
      ItemData        =   "Form4.frx":0134
      Left            =   4440
      List            =   "Form4.frx":0141
      Style           =   2  'Dropdown List
      TabIndex        =   16
      Top             =   2280
      Width           =   975
   End
   Begin VB.ComboBox cbocitit1 
      DataField       =   "CITIT"
      DataSource      =   "adolimbi"
      Height          =   315
      ItemData        =   "Form4.frx":0160
      Left            =   3000
      List            =   "Form4.frx":016D
      Style           =   2  'Dropdown List
      TabIndex        =   15
      Top             =   2280
      Width           =   1095
   End
   Begin VB.ComboBox cbolimba3 
      DataField       =   "NUMELIMBA"
      DataSource      =   "adolimbi"
      Height          =   315
      Index           =   2
      ItemData        =   "Form4.frx":018C
      Left            =   960
      List            =   "Form4.frx":01A5
      Style           =   2  'Dropdown List
      TabIndex        =   11
      Top             =   3960
      Width           =   1215
   End
   Begin VB.ComboBox cbolimba2 
      DataField       =   "NUMELIMBA"
      DataSource      =   "adolimbi"
      Height          =   315
      Index           =   1
      ItemData        =   "Form4.frx":01EB
      Left            =   960
      List            =   "Form4.frx":0204
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   3120
      Width           =   1215
   End
   Begin VB.ComboBox cbolimba1 
      DataField       =   "NUMELIMBA"
      DataSource      =   "adolimbi"
      Height          =   315
      Index           =   0
      ItemData        =   "Form4.frx":024A
      Left            =   960
      List            =   "Form4.frx":0263
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   2280
      Width           =   1215
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
      TabIndex        =   24
      Top             =   960
      Width           =   4815
   End
   Begin VB.Label Label7 
      BackStyle       =   0  'Transparent
      Caption         =   "Scris"
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
      Left            =   6120
      TabIndex        =   14
      Top             =   3600
      Width           =   495
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "Citit"
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
      Left            =   3360
      TabIndex        =   13
      Top             =   3600
      Width           =   375
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Vorbit"
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
      Left            =   4680
      TabIndex        =   12
      Top             =   3600
      Width           =   495
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
      Index           =   2
      Left            =   240
      TabIndex        =   10
      Top             =   3960
      Width           =   495
   End
   Begin VB.Label Label7 
      BackStyle       =   0  'Transparent
      Caption         =   "Scris"
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
      Left            =   6120
      TabIndex        =   9
      Top             =   2760
      Width           =   495
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "Citit"
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
      Left            =   3360
      TabIndex        =   8
      Top             =   2760
      Width           =   375
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Vorbit"
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
      Left            =   4680
      TabIndex        =   7
      Top             =   2760
      Width           =   495
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
      Left            =   240
      TabIndex        =   5
      Top             =   3120
      Width           =   495
   End
   Begin VB.Label Label7 
      BackStyle       =   0  'Transparent
      Caption         =   "Scris"
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
      Left            =   6120
      TabIndex        =   4
      Top             =   1920
      Width           =   495
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "Citit"
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
      Left            =   3360
      TabIndex        =   3
      Top             =   1920
      Width           =   375
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Vorbit"
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
      Left            =   4680
      TabIndex        =   2
      Top             =   1920
      Width           =   495
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
      Index           =   0
      Left            =   240
      TabIndex        =   0
      Top             =   2280
      Width           =   495
   End
End
Attribute VB_Name = "FormLimbi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cbolimba1_Change(Index As Integer)

End Sub

Private Sub Command1_Click()
If MsgBox("Sunteti de acord?", vbYesNo, "Confirmare") = vbYes Then
'adolimbi.Recordset.Update
adolimbi.Recordset.UpdateBatch
End If
FormStudii.Show
End Sub
