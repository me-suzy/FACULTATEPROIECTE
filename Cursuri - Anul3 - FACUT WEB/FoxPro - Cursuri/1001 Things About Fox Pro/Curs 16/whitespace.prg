* How to Print the "Continued..." message on bottom of page

RELEASE glNewGroup
PUBLIC  glNewGroup   && Created so "Continued..." message will print

glNewGroup = .F.

REPORT FORM WhiteSpace PREVIEW NOCONSOLE

* RELEASE glNewGroup

RETURN


FUNCTION GroupHeaderOnExit

glNewGroup = .T.

RETURN .T.


FUNCTION GroupFooterOnExit

glNewGroup = .F.

RETURN .T.

*: EOF :*