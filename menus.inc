<a href="default.asp" class="menut">Home</a>
<br/>
<a href="posts.asp" class="menut">Posts</a>
<br/>
<a href="calendar.asp" class="menut">Calendar</a>
<br/>
<%If loggedin Then%>
<a href="members.asp" class="menut">Members Page</a>
<br/>
<a href="logout.asp" class="menut">Logout</a>
<%Else%>
<a onclick="showlogin('<%= "http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("URL") & "?" & Request.Querystring & Request.Form %>')" class="menut">Login</a>
<%End If%>
<br/>
<a href="contact.asp" class="menut">Contact</a>
<br/>
<br/>
<br/>
<br/>