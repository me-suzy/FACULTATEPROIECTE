VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
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
   Begin MSRDC.MSRDC MSRDC1 
      Height          =   375
      Left            =   360
      Top             =   3120
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   661
      _Version        =   393216
      Options         =   0
      CursorDriver    =   0
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   1
      LockType        =   3
      QueryType       =   0
      Prompt          =   3
      Appearance      =   1
      QueryTimeout    =   30
      RowsetSize      =   100
      LoginTimeout    =   15
      KeysetSize      =   0
      MaxRows         =   0
      ErrorThreshold  =   -1
      BatchSize       =   15
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Enabled         =   -1  'True
      ReadOnly        =   0   'False
      Appearance      =   -1  'True
      DataSourceName  =   "sursatest"
      RecordSource    =   ""
      UserName        =   "cezar"
      Password        =   "asadar"
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "MSRDC1"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   238
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.CommandButton cmdAdauga 
      Caption         =   "Add in Oracle"
      Height          =   375
      Left            =   840
      TabIndex        =   2
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
      TabIndex        =   1
      Top             =   2280
      Width           =   735
   End
   Begin VB.TextBox Text1 
      DataField       =   "nume"
      DataSource      =   "Adodc"
      Height          =   375
      Left            =   360
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   1200
      Width           =   1575
   End
   Begin VB.OLE OLEFoto 
      Class           =   "Paint.Picture"
      DataField       =   "poza"
      DataSource      =   "MSRDC1"
      Height          =   1695
      Left            =   3240
      SizeMode        =   1  'Stretch
      TabIndex        =   3
      Top             =   1200
      Width           =   1815
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
OLEFoto.CreateLink (.FileName)
End With
End Sub

Private Sub ORADC1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)

End Sub

Private Sub oleFotos_Updated(Code As Integer)

End Sub
