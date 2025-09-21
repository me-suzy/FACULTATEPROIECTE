<%@Language="VBScript"%>
<%  
'	Title:		Default.asp		
'	Subtitle:	This is the main screen FOR MegaFox Chapter 16
%>
<%
  Response.Buffer = True
  Response.ExpiresAbsolute = Now() - 1
  Response.Expires = 0
  Response.CacheControl = "no-cache"
%>
<html>
<head>
<title>Select Page To Display</title>
</head>
<body>
<form name="SelectPage" method="POST" action="PageSelect.asp">
<font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>Select A Page To Generate</b></font>
<p align="center">
<input type="submit" value="Display Client List" name="cmdSubmit">
<input type="submit" value="Generate Graphs" name="cmdSubmit">
</p>
</form>
</body>
</html>
