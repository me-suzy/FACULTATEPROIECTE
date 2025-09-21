Dim oShell, oFSO, cExe, cLocal, cRemote, cSetup, cStem, oRemote, cParmeters

Set oFSO = CreateObject( "Scripting.FileSystemObject" )
Set oShell = CreateObject( "WScript.Shell" )
cParameters = " -cMyApp.Fpw"
cStem = "MyApp"
cExe = cStem & ".exe"
cSetup = cStem & ".sup"
cLocal = "C:\LocalDir\"
cRemote = "F:\MyNet\Homedir\"
If NewerFile( cLocal & cSetup, cRemote & cSetup ) Then
  RunSetup cLocal & cSetup, cRemote & cStem
Else
  If Not IsInstalled() Then
    RunSetup cLocal & cSetup, cRemote & cStem
  Else
    If NewerFile( cLocal & cExe, cRemote & cExe ) Then
      Set oRemote = oFSO.GetFile(cRemote & cExe)
      oRemote.Copy cLocal
    End If
    oShell.Run( cLocal & cExe & cParameters )
  End If
End If

Private Function NewerFile( tcLocalFile, tcRemoteFile )
  Dim oFSO, oLocal, oRemote
  Set oFSO = CreateObject( "Scripting.FileSystemObject" )
  If Not oFSO.FileExists( tcLocalFile ) Then
    NewerFile = True
  Else
    If Not oFSO.FileExists( tcRemoteFile ) Then
      NewerFile = False
    Else
      Set oLocal = oFSO.GetFile( tcLocalFile )
      Set oRemote = oFSO.Getfile( tcRemoteFile )
      NewerFile = ( oRemote.DateLastModified > oLocal.DateLastModified )
    End if
  End If
End Function

Private Sub RunSetup( tcTextFile, tcRemotePath )
  Dim oFSO, oShell, oTest
  Set oFSO = CreateObject( "Scripting.FileSystemObject" )
  Set oShell = CreateObject( "WScript.Shell" )
  Set oText = oFSO.CreateTextFile( tcTextFile, True) 
  oText.Close
  oShell.Run( tcRemotePath & "\Setup.exe /Q" )
End Sub

Private Function IsInstalled
  Dim oShell, cKey, cValue
  Set oShell = CreateObject( "WScript.Shell" )
  cKey = "HKCR\VisualFoxPro.Runtime\CLSID\"
  On Error Resume Next
  cValue = oShell.RegRead( cKey )
  IsInstalled = ( cValue > "" )
End Function
