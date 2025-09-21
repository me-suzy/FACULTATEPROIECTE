VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form Formdeproba 
   Caption         =   "Form1"
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdFoto 
      Caption         =   "Incarca Poza"
      Height          =   615
      Left            =   720
      TabIndex        =   0
      Top             =   1080
      Width           =   735
   End
   Begin MSComDlg.CommonDialog cdgFoto 
      Left            =   720
      Top             =   2040
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.OLE OLEFoto 
      Class           =   "Paint.Picture"
      Height          =   1695
      Left            =   1920
      OleObjectBlob   =   "Formdeproba.frx":0000
      SizeMode        =   1  'Stretch
      TabIndex        =   1
      Top             =   480
      Width           =   2295
   End
End
Attribute VB_Name = "Formdeproba"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdFoto_Click()
With Formdeproba.cdgFoto
.DialogTitle = "deschide"
.InitDir = App.Path & "\graphics\photo"
.ShowOpen
OLEFoto.CreateLink (.FileName)
End With
End Sub
