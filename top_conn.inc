<!-- #include file="data.inc"-->
<%
 If Session("loggedin") Then
 	loggedin = true
 Else loggedin = false
 End If

 Dim oConnection
 Dim oCommand
 Dim oRecordset

 Set oCommand = Server.CreateObject ("ADODB.Command")
 Set oConnection = Server.CreateObject ("ADODB.Connection")
 Set oRecordset = Server.CreateObject ("ADODB.Recordset")
 oConnection.mode = 3 ' adModeReadWrite
 oConnection.Open strConnect
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="shortcut icon" href="favicon.ico" />
<link rel="stylesheet" type="text/css" href="style.css" />
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>MSIT Swim Team</title>
<script type='text/javascript' src="scripts.js"></script>
<script type='text/javascript' src="loginscript.asp"></script>
<script src="javascript/prototype.js" type="text/javascript"></script>
<script src="javascript/scriptaculous.js" type="text/javascript"></script>
</head>
<body <%If Request.Querystring("log") = "yes" Then%> onload="showlogin()"<%End If%>>
<div id="login"><script type="text/javascript">new Draggable('login');</script></div>
<div id="content">
<div class="header rc"><a href="default.asp" class="head">MSIT Swim Team</a></div>
<!-- #include file="menus.inc"-->
<div class="main rc">