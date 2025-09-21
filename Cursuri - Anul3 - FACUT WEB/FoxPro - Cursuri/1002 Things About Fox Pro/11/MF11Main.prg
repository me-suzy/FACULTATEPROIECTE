LOCAL lcOldCaption

lcOldCaption = _screen.Caption

_screen.Icon    = "CDROM02.ico"
_screen.Caption = "MegaFox Chapter 11"

IF TYPE("_screen.imgFoxHead.Baseclass") # "C"
   _screen.AddObject("imgFoxHead", "image")
ENDIF

WITH _screen.imgFoxHead
   .Picture = "FoxBak.gif"
   .Stretch = 1    && Isometric
   .Height  = 300
   .Width   = 420
   .Left    = (_screen.Width/2) - (.Width /2)
   .Top     = (_screen.Height/2) - (.Height /2)
   .Visible = .T.
ENDWITH

MESSAGEBOX("Test project message to demonstrate that _screen.Icon is changed.", ;
           0 + 48, ;
           _screen.Caption)

DO FORM FileVersion

_screen.RemoveObject("imgFoxHead")
_screen.Picture = ""
_screen.Caption = lcOldCaption
_screen.Icon    = ""

return

