***********************************************************************
* Program....: IMDemo.prg
* Author.....: Andy Kramek
* Date.......: 11 January 2002
* Notice.....: Copyright (c) 2002 Tightline Computers Ltd, All Rights Reserved.
* Compiler...: Visual FoxPro 07.00.0000.9465 for Windows 
* Purpose....: Demnstrate the use of the Winsock Control in UDP mode
***********************************************************************
LOCAL lcLocal, lcRemote
*** Get the local machine name
lcLocal = LEFT( SYS(0), AT( "#", SYS(0)  ) - 1 )
lcRemote = INPUTBOX( "Enter the Computer Name (Leave blank to use Local Host)", "Specify Remote Machine ")
IF EMPTY( lcRemote )
  lcRemote = lcLocal
ENDIF
*** Run the local form, pass the remote machine name
DO FORM frmpLocal NAME loLocal WITH lcRemote
*** Run the remote form, pass the local machine name
DO FORM frmpRemote NAME loRemote WITH lcLocal
loRemote.Left = loRemote.Left + loRemote.Width + 20
