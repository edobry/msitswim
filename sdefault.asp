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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="favicon.ico" />
<link href="sstyle.css" rel="stylesheet" type="text/css" />
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>MSIT Swim Team</title>
<script type='text/javascript' src="scripts.js"></script>
<script type='text/javascript' src="loginscript.asp"></script>
<script src="javascript/prototype.js" type="text/javascript"></script>
<script src="javascript/scriptaculous.js" type="text/javascript"></script>
</head>
<body <%If Request.Querystring("log") = "yes" Then%> onload="showlogin()"<%End If%>
    <div id="login"><script type="text/javascript">new Draggable('login');</script></div>
	<!-- header -->
    <div id="logo"><a href="default.asp" class="head">MSIT Swim Team</a></div>
    <div id="header">
    	<div id="left_header"></div>
        <div id="right_header"></div>
  </div> 
  <div id="menu">
        	<ul>
              <li><a href="default.asp" class="menut">Home</a></li>
              <li><a href="posts.asp" class="menut">Posts</a></li>
              <li><a href="calendar.asp" class="menut">Calendar</a></li>
              <%If loggedin Then%>
                <li><a href="members.asp" class="menut">Members Page</a></li>
              <%End If%>
              <li><a href="contact.asp" class="menut">Contact</a></li>
          </ul>
      </div>
    <!--end header -->
    <!-- main -->
    <div id="content">
    	<div id="content_top">
        	<div id="content_top_left"></div>
            <div id="content_top_right"></div>
        </div>
      <div id="content_body">
       	  <div id="sidebar">
            <div id="sidebar_top"></div>
            <div id="sidebar_body">
            <h1>Recent Posts</h1>
              <ul>
                <%
                 oRecordset.Open "SELECT * FROM Posts INNER JOIN People ON Posts.Poster = People.ID ORDER BY PostID DESC",oConnection,0,3
                 While Not oRecordset.EOF
                    Response.Write "<li><span class='rposts'><a href='posts.asp#" & oRecordset("PostID") & "'>" & oRecordset("Title") &_
                         "</a></span><span class='dpost'> - by " & oRecordset("First") & "</span></li>"
                    oRecordset.MoveNext
                 Wend
                 oRecordset.Close
                %>
              </ul>
              <h1>Upcoming Events</h1>
              <ul>
                <%
                    oRecordset.Open "SELECT * FROM Calendar ORDER BY EventID DESC",oConnection,0,3
                    While Not oRecordset.EOF
                        Response.Write "<li><span class='uevents'><a href='calendar.asp?event=" & oRecordset("EventID") & "'>" & oRecordset("Title") &_
                            "</a></span><span class='devent'> - on " & oRecordset("EDate") & "</span></li>"
                            oRecordset.MoveNext
                    Wend
                %>
              </ul>
              </div>
                <div id="sidebar_bottom"></div>
          </div>
          <div id="text">
            <div id="text_top">
            	<div id="text_top_left"></div>
                <div id="text_top_right"></div>
            </div>
            <div id="text_body">
              <h1><span>Welcome</span></h1>
                <p>The MSIT Swim Team competes in PSAL, along with teams from other Staten Island schools. It is comprised of students from <a href="http://www.siths.org/">Staten Island Technical High School</a> and <a href="http://www.mckeecths.org/">Mckee Career &amp; Technical High School</a>. Our coach is Ms. Ann Boylan.</p>
                <ul>
                  <li>Lorem ipsum dolor sit amet.</li>
                  <li>Consectetuer adipiscing elit.</li>
                  <li>Maecenas ac lacus. Etiam quis ante.</li>
                  <li>Nullam accumsan metus sit amet est.</li>
                  <li>Nullam diam. Nunc ac ipsum at nisl pretium congue.</li>
                </ul>
                <h1><span>Lorem ipsum dolor</span></h1>
              <p><strong>Lorem ipsum</strong> dolor sit amet, consectetuer adipiscing elit. Phasellus ornare condimentum sem. Nullam a eros. Vivamus vestibulum hendrerit arcu. Integer a orci. Morbi nonummy semper est. Donec at risus sed velit porta dictum. Maecenas condimentum orci aliquam nunc. Morbi nonummy tellus in nibh. Suspendisse orci eros, dapibus at, ultrices at, egestas ac, tortor. Suspendisse fringilla est id erat. Praesent et libero. Proin nisi felis, euismod a, tempus varius, elementum vel, nisl. Fusce non magna sit amet enim suscipit feugiat. Fusce et leo. Morbi nonummy tellus in nibh. Suspendisse orci eros, dapibus at, ultrices at, egestas ac, tortor. Suspendisse fringilla est id erat. Praesent et libero. Proin nisi felis, euismod a, tempus varius, elementum vel, nisl. Fusce non magna sit amet enim suscipit feugiat. Fusce et leo.</p>
                            <div id="foot_text" style="display:none;">Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nunc nec mi quis felis ullamcorper adipiscing. Integer elementum tellus id purus. Vestibulum diam. 
Cras congue nulla ac turpis ultrices ullamcorper. Mauris lobortis. Quisque consectetuer massa eu enim tristique accumsan. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nunc nec mi quis felis ullamcorper adipiscing. Integer elementum tellus id purus. Vestibulum diam.</div>
            </div>
                <div id="text_bottom">
                	<div id="text_bottom_left"></div>
                    <div id="text_bottom_right"></div>
                </div>
          </div>
      </div>
        <div id="content_bottom">
        	<div id="content_bottom_left"></div>
            <div id="content_bottom_right"></div>
        </div>
    </div>
    <!-- end main -->
    <!-- footer -->
    <div id="footer">
    <div id="left_footer">&copy; Copyright 2008 <b>Eugene Dobry</b></div>
    <div id="right_footer">

<!-- Please do not change or delete this link. Read the license! Thanks. :-) -->
Design by <a href="http://www.realitysoftware.ca" title="Website Design">Reality Software</a>

    </div>
    </div>
    <!-- end footer -->
</body>
</html>
<%
	'oRecordset.Close
	oConnection.Close
	Set oRecordset = Nothing
	Set oConnection = Nothing
%>