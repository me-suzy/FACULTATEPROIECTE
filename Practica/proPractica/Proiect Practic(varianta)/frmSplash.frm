VERSION 5.00
Begin VB.Form frmSplash 
   BackColor       =   &H00000080&
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   4560
   ClientLeft      =   255
   ClientTop       =   1410
   ClientWidth     =   6885
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frmSplash.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4560
   ScaleWidth      =   6885
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      BackColor       =   &H00000080&
      Height          =   4050
      Left            =   150
      TabIndex        =   0
      Top             =   240
      Width           =   6225
      Begin VB.Timer Timer1 
         Interval        =   1500
         Left            =   5520
         Top             =   3480
      End
      Begin VB.Image imgLogo 
         Height          =   1785
         Left            =   240
         Picture         =   "frmSplash.frx":000C
         Stretch         =   -1  'True
         Top             =   1440
         Width           =   1695
      End
      Begin VB.Label lblCopyright 
         BackStyle       =   0  'Transparent
         Caption         =   "Copyright 2004"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   4200
         TabIndex        =   2
         Top             =   3240
         Width           =   2415
      End
      Begin VB.Label lblWarning 
         BackStyle       =   0  'Transparent
         Caption         =   "Warning: Nu ne copiati... Cumparati-ne!"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   195
         Left            =   150
         TabIndex        =   1
         Top             =   3660
         Width           =   6855
      End
      Begin VB.Label lblVersion 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Version 1.0"
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
         Left            =   4170
         TabIndex        =   3
         Top             =   2040
         Width           =   1275
      End
      Begin VB.Label lblProductName 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Aplicatia  CV"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   32.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   765
         Left            =   1920
         TabIndex        =   5
         Top             =   1200
         Width           =   5145
      End
      Begin VB.Label lblCompanyProduct 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "sc Practika srl prezinta"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   15.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   360
         Left            =   1560
         TabIndex        =   4
         Top             =   705
         Width           =   3450
      End
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub Form_KeyPress(KeyAscii As Integer)
    Unload Me
End Sub

Private Sub Form_Load()
    lblVersion.Caption = "Version " & App.Major & "." & App.Minor & "." & App.Revision
    lblProductName.Caption = App.Title
End Sub

Private Sub Frame1_Click()
    Unload Me
End Sub

Private Sub Timer1_Timer()
Unload Me
End Sub
