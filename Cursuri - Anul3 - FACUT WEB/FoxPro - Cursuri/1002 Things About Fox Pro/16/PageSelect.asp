<% @ Language=VBScript %>
<%  
'	Title:		PageSelect.asp		
'	Subtitle:	This is the process for instantiating the VFP com object and generating the page
%>
<%
cPageID = Request.Form( "cmdSubmit" )
Set oPageGen = CreateObject( "GenHTML.SesGenPage" )
IF cPageID = "Display Client List" Then
	cHTML = oPageGen.GenPage( "Clients" )
Else
  ''' Check to make sure that the most recent version of the office web components is installed
  ''' make sure we do not get an error if the key doesn't exist
 	cHTML = oPageGen.GenGraph( "MonthlySales" )
End If
Response.Write( cHTML )

%>