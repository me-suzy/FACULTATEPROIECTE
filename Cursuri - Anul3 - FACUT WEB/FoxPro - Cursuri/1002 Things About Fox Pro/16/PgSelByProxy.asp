<% @ Language=VBScript %>
<%  
'	Title:		PgSelByProxy.asp		
'	Subtitle:	This is the process for instantiating the VFP proxy object and generating the page
%>
<%
cPageID = Request.Form( "cmdSubmit" )
Set oProxy = Server.CreateObject( "Proxy.VFPProxy" )
IF cPageID = "Display Client List" Then
	cHTML = oProxy.Execute( "PassItOn( [GenPage( 'Clients' )] )", "GenHTMLByProxy.prg" )
Else
 	cHTML = oProxy.Execute( "PassItOn( [GenGraph( 'MonthlySales' )] )", "GenHTMLByProxy.prg" )
End If
Response.Write( cHTML )
set oProxy = Nothing
%>