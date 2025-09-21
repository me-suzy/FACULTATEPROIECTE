VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form FormRapoarte 
   BackColor       =   &H00000080&
   Caption         =   "Formular Rapoarte"
   ClientHeight    =   5490
   ClientLeft      =   6405
   ClientTop       =   4485
   ClientWidth     =   7635
   LinkTopic       =   "Form1"
   ScaleHeight     =   5490
   ScaleWidth      =   7635
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Cancel"
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
      Left            =   2880
      TabIndex        =   1
      Top             =   3480
      Width           =   1455
   End
   Begin MSAdodcLib.Adodc AdostudRap 
      Height          =   375
      Left            =   3240
      Top             =   4920
      Visible         =   0   'False
      Width           =   3015
      _ExtentX        =   5318
      _ExtentY        =   661
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   30
      CursorType      =   3
      LockType        =   3
      CommandType     =   1
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
      RecordSource    =   $"frmRapoarte.frx":0000
      Caption         =   "AdostudRap"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   238
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _Version        =   393216
   End
   Begin VB.CommandButton cmdok 
      Caption         =   "&OK"
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
      Left            =   1320
      TabIndex        =   0
      Top             =   3480
      Width           =   1095
   End
   Begin MSDataListLib.DataCombo cboStarecivila 
      Bindings        =   "frmRapoarte.frx":00DE
      DataSource      =   "AdostudRap"
      Height          =   315
      Left            =   240
      TabIndex        =   2
      Top             =   960
      Width           =   1695
      _ExtentX        =   2990
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "STARECIVILA"
      BoundColumn     =   "STARECIVILA"
      Text            =   "Starecivila"
   End
   Begin MSDataListLib.DataCombo cboStagiumilitar 
      Bindings        =   "frmRapoarte.frx":00F7
      DataSource      =   "AdostudRap"
      Height          =   315
      Left            =   2040
      TabIndex        =   3
      Top             =   960
      Width           =   1695
      _ExtentX        =   2990
      _ExtentY        =   556
      _Version        =   393216
      BoundColumn     =   "STAGIUMILITAR"
      Text            =   "Stagiumilitar"
   End
   Begin MSDataListLib.DataCombo cbosalminim 
      Bindings        =   "frmRapoarte.frx":0110
      DataSource      =   "AdostudRap"
      Height          =   315
      Left            =   3720
      TabIndex        =   4
      Top             =   960
      Width           =   1695
      _ExtentX        =   2990
      _ExtentY        =   556
      _Version        =   393216
      BoundColumn     =   "SALMINIM"
      Text            =   "Salar minim"
   End
   Begin MSDataListLib.DataCombo cboPermiscat 
      Bindings        =   "frmRapoarte.frx":0129
      DataSource      =   "AdostudRap"
      Height          =   315
      Left            =   5520
      TabIndex        =   5
      Top             =   960
      Width           =   1695
      _ExtentX        =   2990
      _ExtentY        =   556
      _Version        =   393216
      BoundColumn     =   "PERMISCAT"
      Text            =   "Permis-categorie"
   End
End
Attribute VB_Name = "FormRapoarte"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command2_Click()
If chktotifurnizorii.Value = 1 Then
    defurnizori.Commands("cmdfurnizori").Parameters(0).Value = 1
Else
    defurnizori.Commands("cmdfurnizori").Parameters(0).Value = 0
    defurnizori.Commands("cmdfurnizori").Parameters(1).Value = dbcfurnizor.BoundText
End If

                         
With defurnizori.rscmdfurnizori

 If .State <> adStateClosed Then

        .Close

    End If
    
End With
    
    
    drfurnizori.Show
End Sub

Private Sub cmdCancel_Click()
Unload Me
End Sub

Private Sub cmdOK_Click()
Set DataReport1.DataSource = deDBStud
DataReport1.Show
End Sub
