<%If Request.Querystring("action") = 1 Then
	  Dim strConnect
	  strConnect = "Driver={Microsoft Access Driver (*.mdb)};Dbq=" & server.MapPath("Data.mdb")
	  
	  Dim title
	  Dim text
	  
	  Dim action
	  Dim post
	  action = Request.Querystring("action")
	  post = Request.Querystring("post")
	  
	  Dim oConnection
	  Dim oRecordset
	  
	  Set oConnection = Server.CreateObject ("ADODB.Connection")
	  Set oRecordset = Server.CreateObject ("ADODB.Recordset")
	  oConnection.mode = adModeReadWrite
	  oConnection.Open strConnect
	  
	  oRecordset.Open "SELECT * FROM [Posts] WHERE PostID = " & post,oConnection,0,3
	
  End If
%>
<!-- #include file="top.inc"-->
<body>
<%If Session("loggedin") Then%>
<%If Request("action")= 1 Then%>
<h1>Edit Post</h1>
<%Else%>
<h1>Make A New Post</h1>
<%End If%>
<br />
<form action="editposts.asp" method="post">
<%If Request("action")= 1 Then%>
<input type="hidden" name="action" value="1"/>
<input type="hidden" name="post" value="<%=oRecordset("PostID")%>"/>
<%Else%>
<input type="hidden" name="action" value="0"/>
<%End If%>
Title:&nbsp;<input type="text" name="title" size="53" value="<%If Request("action")= 1 Then Response.Write oRecordset("Title")%>" class="makepost"/>
<br/>
<div style="float:left;padding:10px 0px 0px 0px;">Text:&nbsp;</div><div style="padding:10px 0px 0px 0px;"><textarea cols="40" rows="15" name="text" class="makepost"><%If Request("action")= 1 Then Response.Write oRecordset("Content")%></textarea></div>
<br/>
<input type="submit" value="Post" class="btn" style="margin-left:38px;"/><input type="button" value="Cancel" onclick="window.location = 'posts.asp'" class="btn"/>
</form>
<%Else%>
This page is for members only. You can sign in <a href="#" onclick="showlogin()">here</a>.
<%End If%>
<!-- #include file="bottom.inc"-->