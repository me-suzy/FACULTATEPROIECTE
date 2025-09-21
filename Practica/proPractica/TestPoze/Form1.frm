VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   4515
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6075
   LinkTopic       =   "Form1"
   ScaleHeight     =   4515
   ScaleWidth      =   6075
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdAdauga 
      Caption         =   "Add in Oracle"
      Height          =   375
      Left            =   840
      TabIndex        =   3
      Top             =   3720
      Width           =   1695
   End
   Begin MSComDlg.CommonDialog cdgFoto 
      Left            =   360
      Top             =   2520
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton cmdFoto 
      Caption         =   "Add"
      Height          =   375
      Left            =   2280
      TabIndex        =   2
      Top             =   2280
      Width           =   735
   End
   Begin VB.TextBox Text1 
      DataField       =   "nume"
      DataSource      =   "Adodc1"
      Height          =   375
      Left            =   360
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   1200
      Width           =   1575
   End
   Begin MSAdodcLib.Adodc Adodc1 
      Height          =   375
      Left            =   120
      Top             =   120
      Width           =   1695
      _ExtentX        =   2990
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
      Connect         =   "Provider=MSDAORA.1;Password=22b7q82;User ID=el011355;Data Source=bdstud;Persist Security Info=True"
      OLEDBString     =   "Provider=MSDAORA.1;Password=22b7q82;User ID=el011355;Data Source=bdstud;Persist Security Info=True"
      OLEDBFile       =   ""
      DataSourceName  =   ""
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "TEST"
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
   Begin VB.OLE oleFoto 
      Class           =   "Paint.Picture"
      Height          =   2175
      Left            =   3120
      OleObjectBlob   =   "Form1.frx":0000
      SizeMode        =   1  'Stretch
      TabIndex        =   1
      Top             =   1440
      Width           =   2415
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdAdauga_Click()

Adodc1.Recordset.Update

End Sub

Private Sub cmdFoto_Click()
With Form1.cdgFoto
.DialogTitle = "deschide"
.InitDir = App.Path & "\graphics\photo"
.ShowOpen
oleFoto.CreateLink (.FileName)
End With
End Sub

