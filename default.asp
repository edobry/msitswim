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
</div>
<div class="main rc">

<p>
    The MSIT Swim Team competes in PSAL, along with teams from other Staten Island schools.
    It is comprised of students from <a href="http://www.siths.org/">Staten Island Technical High School</a> and <a href="http://www.mckeecths.org/">Mckee Career
    &amp; Technical High School</a>. Our coach is Ms. Ann Boylan.</p>

</div>

<div class="sbox rc">
<h1>Recent Posts</h1>
<br/>
<%
 oRecordset.Open "SELECT * FROM Posts INNER JOIN People ON Posts.Poster = People.ID ORDER BY PostID DESC",oConnection,0,3
 While Not oRecordset.EOF
    Response.Write "<span class='rposts'><a href='posts.asp#" & oRecordset("PostID") & "'>" & oRecordset("Title") &_
         "</a></span><span class='dpost'> - by " & oRecordset("First") & "</span><br/>"
    oRecordset.MoveNext
 Wend
 oRecordset.Close
%>
</div>

<div class="sbox rc">
<h1>Upcoming Events</h1>
<br/>
<%
 oRecordset.Open "SELECT * FROM Calendar ORDER BY EventID DESC",oConnection,0,3
 While Not oRecordset.EOF
    Response.Write "<span class='uevents'><a href='calendar.asp?event=" & oRecordset("EventID") & "'>" & oRecordset("Title") &_
         "</a></span><span class='devent'> - on " & oRecordset("EDate") & "</span><br/>"
    oRecordset.MoveNext
 Wend
%>
</div>

<%
	oRecordset.Close
	oConnection.Close
	Set oRecordset = Nothing
	Set oConnection = Nothing
%>

<div class="footer"><!-- #include file="footer.inc"--></div>
</div>
</body>
</html>