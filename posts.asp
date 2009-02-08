<!-- #include file="top_conn.inc"-->
<%
 oRecordset.Open "SELECT * FROM Posts INNER JOIN People ON Posts.Poster = People.ID ORDER BY PostID DESC",oConnection,0,3
 If Request.Querystring("my") = "yes" AND Session("loggedin") Then
 	oRecordset.Filter = "Poster = " & Session("ID")
 	Dim my
 	my = true
 End If
%>
<h1><%If my Then%>Your <%End If%>Posts</h1>
<!-- AddThis Feed Button BEGIN -->
<a class="addbtn" href="http://www.addthis.com/feed.php?pub=WhiteNdNrdy&h1=http%3A%2F%2Flocalhost%2Feugenesite%2Frss.asp&t1=" title="Subscribe using any feed reader!"><img class="addbtn" src="http://s9.addthis.com/button0-rss.gif" width="83" height="16" border="0" alt="AddThis Feed Button" /></a>
<!-- AddThis Feed Button END -->
<%If loggedin Then%>
<br/>
<a href="makepost.asp">+ New Post</a>
<%End If%>
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
</div>
<!-- #include file="bottom_conn.inc"-->