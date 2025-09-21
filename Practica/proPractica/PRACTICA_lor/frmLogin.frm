VERSION 5.00
Begin VB.Form frmLogin 
   BackColor       =   &H00404080&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Login"
   ClientHeight    =   3240
   ClientLeft      =   2835
   ClientTop       =   3480
   ClientWidth     =   5580
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1914.299
   ScaleMode       =   0  'User
   ScaleWidth      =   5239.318
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtUserName 
      Height          =   285
      Left            =   2250
      TabIndex        =   1
      Top             =   960
      Width           =   2325
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   356
      Left            =   1560
      TabIndex        =   4
      Top             =   2040
      Width           =   1140
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   356
      Left            =   2880
      TabIndex        =   5
      Top             =   2040
      Width           =   1140
   End
   Begin VB.TextBox txtPassword 
      Height          =   285
      IMEMode         =   3  'DISABLE
      Left            =   2250
      PasswordChar    =   "*"
      TabIndex        =   3
      Top             =   1365
      Width           =   2325
   End
   Begin VB.Shape Shape1 
      BorderWidth     =   2
      Height          =   2535
      Left            =   360
      Top             =   360
      Width           =   4815
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00404080&
      Caption         =   "&Utilizator:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Index           =   0
      Left            =   840
      TabIndex        =   0
      Top             =   960
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H00404080&
      Caption         =   "&Parola:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Index           =   1
      Left            =   840
      TabIndex        =   2
      Top             =   1440
      Width           =   1080
   End
End
Attribute VB_Name = "frmLogin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public LoginSucceeded As Boolean

Private Sub cmdCancel_Click()
    Me.Hide
End Sub

Private Sub cmdOK_Click()
 On Error GoTo erori:
     'check for correct password
    frmStud.adoStud.UserName = txtUserName.Text
    frmStud.adoStud.Password = txtPassword.Text
    frmStud.adoStud.Refresh
    frmStud.Show
        Me.Hide
Exit Sub
erori:
    If Err.Number = -2147217843 Then
        MsgBox "User sau parola incorecte!", vbApplicationModal, "Eroare la conectare"
    Else
        MsgBox Err.Number & " " & Err.Description
    End If
  txtUserName.SetFocus
  SendKeys "{Home}+{End}"
End Sub

