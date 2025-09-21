DEFINE CLASS PgBase AS Page

lRefreshOnActivate = .T.
lReadOnly = .F.
cPrimaryTable = ''

FUNCTION Activate
WITH This
	.SetAll( 'Enabled', !.lReadOnly )
ENDWITH			
		
FUNCTION RefreshPage
*** This is a template method akin to RefreshForm
*** If you need to refresh this page, put code here instead of in Refresh
WITH This
	.SetAll( 'Enabled', !.lReadOnly )
ENDWITH		
ENDFUNC

ENDDEFINE