VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Begin VB.Form frmStud 
   Caption         =   "   "
   ClientHeight    =   7230
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12360
   LinkTopic       =   "Form1"
   ScaleHeight     =   7230
   ScaleWidth      =   12360
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   6000
      Top             =   360
   End
   Begin ComctlLib.ProgressBar prbCautare 
      DragMode        =   1  'Automatic
      Height          =   200
      Left            =   7440
      Negotiate       =   -1  'True
      TabIndex        =   6
      Top             =   3000
      Visible         =   0   'False
      Width           =   4335
      _ExtentX        =   7646
      _ExtentY        =   344
      _Version        =   327682
      BorderStyle     =   1
      Appearance      =   0
      Max             =   1
   End
   Begin MSAdodcLib.Adodc adoCautare 
      Height          =   495
      Left            =   720
      Top             =   4920
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   873
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
      ConnectStringType=   3
      Appearance      =   1
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Orientation     =   0
      Enabled         =   -1
      Connect         =   "DSN=oracle"
      OLEDBString     =   ""
      OLEDBFile       =   ""
      DataSourceName  =   "oracle"
      OtherAttributes =   ""
      UserName        =   "JAVA_PROIECT"
      Password        =   "giv"
      RecordSource    =   " select  COLUMN_NAME from user_tab_columns where TABLE_NAME='CAMIN'"
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
   Begin VB.Frame Frame1 
      BackColor       =   &H00004080&
      Caption         =   " CAUTARE "
      ForeColor       =   &H00FFFFFF&
      Height          =   2055
      Left            =   7200
      TabIndex        =   1
      Top             =   1320
      Width           =   4695
      Begin MSDataListLib.DataCombo cboCautare 
         Bindings        =   "frmStud.frx":0000
         DataSource      =   "adoCautare"
         Height          =   315
         Left            =   2160
         TabIndex        =   5
         Top             =   480
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   556
         _Version        =   393216
         Style           =   2
         ListField       =   "COLUMN_NAME"
         Text            =   ""
      End
      Begin VB.TextBox txtValoare 
         Height          =   285
         Left            =   2160
         TabIndex        =   3
         Top             =   1080
         Width           =   2295
      End
      Begin VB.Label Label2 
         BackColor       =   &H00004080&
         Caption         =   "Valoare cautata"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Label Label1 
         BackColor       =   &H00004080&
         Caption         =   "Alegeti campurile "
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Left            =   120
         TabIndex        =   2
         Top             =   480
         Width           =   1935
      End
   End
   Begin MSDataGridLib.DataGrid grdStud 
      Bindings        =   "frmStud.frx":0019
      Height          =   2175
      Left            =   0
      TabIndex        =   0
      Top             =   1320
      Width           =   6495
      _ExtentX        =   11456
      _ExtentY        =   3836
      _Version        =   393216
      HeadLines       =   1
      RowHeight       =   15
      FormatLocked    =   -1  'True
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ColumnCount     =   4
      BeginProperty Column00 
         DataField       =   "DENCAMIN"
         Caption         =   "DENCAMIN"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1048
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   "ADRCAMIN"
         Caption         =   "ADRCAMIN"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1048
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column02 
         DataField       =   "TIPCAMIN"
         Caption         =   "TIPCAMIN"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1048
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column03 
         DataField       =   "NRLOCURI"
         Caption         =   "NRLOCURI"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1048
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         BeginProperty Column00 
            ColumnWidth     =   1739,906
         EndProperty
         BeginProperty Column01 
            ColumnWidth     =   1739,906
         EndProperty
         BeginProperty Column02 
            ColumnWidth     =   1065,26
         EndProperty
         BeginProperty Column03 
            ColumnWidth     =   1739,906
         EndProperty
      EndProperty
   End
   Begin MSAdodcLib.Adodc adoStud 
      Height          =   495
      Left            =   600
      Top             =   4080
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   873
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
      ConnectStringType=   3
      Appearance      =   1
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Orientation     =   0
      Enabled         =   -1
      Connect         =   "DSN=oracle"
      OLEDBString     =   ""
      OLEDBFile       =   ""
      DataSourceName  =   "oracle"
      OtherAttributes =   ""
      UserName        =   "JAVA_PROIECT"
      Password        =   "giv"
      RecordSource    =   "select * from camin"
      Caption         =   "adoStud"
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
End
Attribute VB_Name = "frmStud"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cboCautare_Click(Area As Integer)
txtValoare.Text = ""
End Sub

Private Sub Timer1_Timer()
prbCautare.Max = prbCautare.Max + Timer1.Interval
prbCautare.Value = Timer1.Interval
End Sub

Private Sub txtValoare_Change()
If txtValoare.Text <> "" Then
prbCautare.Visible = True
Timer1.Enabled = True
    adoStud.RecordSource = "select * from camin where " & cboCautare.Text & " like " & "'" & txtValoare.Text & "%'"
    adoStud.Refresh
    grdStud.Refresh
Timer1.Enabled = False
prbCautare.Visible = False
Else
    adoStud.RecordSource = "select * from camin order by dencamin"
    adoStud.Refresh
    grdStud.Refresh
End If
End Sub

