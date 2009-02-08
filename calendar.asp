<!-- #include file="data.inc"-->
<%
 If Session("loggedin")Then
 	loggedin = true
 Else
 	loggedin = false
 End If
 
 Dim oConnection
 Dim oCommand
 Dim oRecordset

 Set oCommand = Server.CreateObject ("ADODB.Command")
 Set oConnection = Server.CreateObject ("ADODB.Connection")
 Set oRecordset = Server.CreateObject ("ADODB.Recordset")
 oConnection.mode = 3 ' adModeReadWrite
 oConnection.Open strConnect

 oRecordset.Open "SELECT * FROM Calendar INNER JOIN People ON Calendar.Poster = People.ID ORDER BY EventID DESC",oConnection,0,3
 If Request.Querystring("my") = "yes" AND Session("loggedin") Then
 	oRecordset.Filter = "Poster = " & Session("ID")
 	Dim my
 	my = true
 End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="shortcut icon" href="favicon.ico" />
<link rel="stylesheet" type="text/css" href="style.css" />
<link rel="stylesheet" type="text/css" href="JScal/calendar.css"/>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>MSIT Swim Team</title>
<script type="text/javascript">
    var eventid = <%If Request("event") <> "" Then Response.Write Request("event") Else Response.Write "''" End If %>;
    var showeb = <%If Request("event") <> "" Then Response.Write "true" Else Response.Write "false" End If %>;
</script>
<script type='text/javascript' src="scripts.js"></script>
<script type='text/javascript' src="loginscript.asp"></script>
<script src="javascript/prototype.js" type="text/javascript"></script>
<script src="javascript/scriptaculous.js" type="text/javascript"></script>
<script src="JScal/calendar.js" type="text/javascript"></script>
<script src="event.js" type="text/javascript"></script>

</head>
<body <%If Request.Querystring("log") = "yes" Then%> onload="showlogin()"<%End If%> >
<div id="login"><script type="text/javascript">new Draggable('login');</script></div>
<div id="content">
<div class="header rc"><a href="default.asp" class="head">MSIT Swim Team</a></div>
<div class="menu rc"><!-- #include file="menus.inc"--></div>
<div class="main rc">
<script type="text/javascript">
    //<![CDATA[
    xmlHttp.open("GET", "JScal/makecal.asp?" + params, true);
    xmlHttp.send(null);
    //]]>
</script>
<div id="eventbox" style="display:none;">
    <script type="text/javascript">
        new Draggable('eventbox', {handle: 'ehandle'});
    </script>
    <div id="ehandle"></div>
    <div class="xbox" onclick="this.parentNode.fade({ duration: 0.5 });">X</div>
    <div id="ebox" class="rc">
    </div>
    <%If loggedin Then
		If Session("ID") = oRecordset("Poster") OR Session("Rights") < oRecordset("Rights") Then%>
		<div id="eventedit"></div>
	<%	End If
 	  End If%>
</div>
<div id="calendar"><img alt="Loading..." src="images/loading.gif" class="ldgif" /></div>
</div>
</div>
<div class="footer"><!-- #include file="footer.inc"--></div>
<script type="text/javascript" language="javascript">        
        if(showeb){
            showevent(eventid);
        }
</script>
</body>
</html>