do form confres NAME confRes1 NOSHOW
WITH confres1
    .Caption = .Caption + " (User 1)"
    .Name = "confres1"
ENDWITH
do form confres NAME confRes2 NOSHOW
WITH confres2
    .Left = .Left + .Width + 10
    .Name = "ConfRes2"
    .Caption = .Caption + " (User 2)"
ENDWITH
confres1.Show()
confres2.Show()
