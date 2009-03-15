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
              <li><a href="sdefault.asp" class="menut">Home</a></li>
              <li><a href="sposts.asp" class="menut">Posts</a></li>
              <li><a href="scalendar.asp" class="menut">Calendar</a></li>
              <%If loggedin Then%>
                <li><a href="smembers.asp" class="menut">Members Page</a></li>
              <%End If%>
              <li><a href="scontact.asp" class="menut">Contact</a></li>
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
                <h1><span>Posts</span></h1>
                <%
                    oRecordset.Close
                    oRecordset.Open "SELECT * FROM Posts INNER JOIN People ON Posts.Poster = People.ID ORDER BY PostID DESC",oConnection,0,3
                    If Request.Querystring("my") = "yes" AND Session("loggedin") Then
                    	oRecordset.Filter = "Poster = " & Session("ID")
                    	Dim my
                    	my = true
                     End If
                %>
                <%
                If Not oRecordset.EOF Then
		                While Not oRecordset.EOF
                %>
                
                <div class="post"><a name="<%=oRecordset("PostID")%>"></a>
	                <div class="addthis">
		                <!-- AddThis Button BEGIN -->
		                <script type="text/javascript">addthis_pub  = 'WhiteNdNrdy';</script>
		                <a href="http://www.addthis.com/bookmark.php" onmouseover="return addthis_open(this, '', 'http://localhost/eugenesite/posts.asp#<%=oRecordset("PostID")%>', '<%=oRecordset("Title")%>')" onmouseout="addthis_close()" onclick="return addthis_sendto()"><img src="http://s9.addthis.com/button0-share.gif" width="83" height="16" border="0" alt="" /></a><script type="text/javascript" src="http://s7.addthis.com/js/152/addthis_widget.js"></script>
		                <!-- AddThis Button END -->
	                </div>
	                <span class="title"><%=oRecordset("Title")%></span>
	                <br/>
	                <span class="postinfo">Posted&nbsp;<%=oRecordset("TimePosted")%>&nbsp;by&nbsp;<%=oRecordset("First")%></span>
		                <div class="posttext">
			                <%=oRecordset("Content")%>
		                </div>
	                <%If loggedin Then
		                If Session("ID") = oRecordset("Poster") OR Session("Rights") < oRecordset("Rights") Then%>
		                <br/>
		                <div class="postedit">
			                <a href="makepost.asp?action=1&post=<%=oRecordset("PostID")%>">Edit</a> | <a href="editposts.asp?action=2&post=<%=oRecordset("PostID")%>">Delete</a>
		                </div>
	                <%	End If
 	                  End If%>
                </div>
                <%
 		                oRecordset.MoveNext
	                Wend
	                Else
		                Response.Write "There are no posts to display.<br/><br/>"
	                End If
                %>
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
    <div id="left_footer">&copy; Copyright 2009 <b>Eugene Dobry</b></div>
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