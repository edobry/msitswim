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
<!-- #include file="top.inc"-->
<%If loggedin Then%>
<h1><%=Session("First")%>&nbsp;<%=Session("Last")%></h1>
<br/>
<a href="changel.asp">Change Username/Password</a>
<%If Session("Rights") = 1 Then%>
<br/>
<a href="vsuggest.asp">View Suggestions</a>
<%End If %>
<br/>
<div class="mrecent">
<h1>Your Posts</h1>
<br/>
<%
 oRecordset.Open "SELECT * FROM Posts INNER JOIN People ON Posts.Poster = People.ID WHERE Posts.Poster = " & Session("ID") & " ORDER BY PostID DESC",oConnection,0,3
 If Not oRecordset.EOF Then
    While Not oRecordset.EOF
        Response.Write "<span class='rposts'><a href='posts.asp#" & oRecordset("PostID") & "'>" & oRecordset("Title") &_
             "</a></span><span class='dpost'> - by " & oRecordset("First") & "</span><br/>"
        oRecordset.MoveNext
    Wend
 Else
    Response.Write "You have not posted anything."
 End If
 oRecordset.Close
%>
</div>

<div class="mrecent">
<h1>Upcoming Events</h1>
<br/>
<%
 oRecordset.Open "SELECT * FROM Calendar WHERE Poster = " & Session("ID") & " ORDER BY EventID DESC",oConnection,0,3
 If Not oRecordset.EOF Then
    While Not oRecordset.EOF
      Response.Write "<span class='uevents'><a href='calendar.asp?event=" & oRecordset("EventID") & "'>" & oRecordset("Title") &_
           "</a></span><span class='devent'> - on " & oRecordset("EDate") & "</span><br/>"
       oRecordset.MoveNext
    Wend
 Else
    Response.Write "You have not posted anything."
 End If
%>
</div>

<%
	oRecordset.Close
	oConnection.Close
	Set oRecordset = Nothing
	Set oConnection = Nothing
%>

<%Else%>
This page is for members only. You can sign in <a href="#" onclick="showlogin()">here</a>.
<%End If%>
<!-- #include file="bottom.inc"-->