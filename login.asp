<!-- #include file="top.inc"-->
<form action="validate.asp" method="post">
<%
If Session("gUser") = "false" Then
	Response.Write "Invalid Username<br/><br/>"
	Session("gUser") = "true"
End If

If Session("gPass") = "false" Then
	Response.Write "Invalid Password<br/><br/>"
	Session("gPass") = "true"
End If
%>
Username:&nbsp; <input type="text" name="username" class="login"/><br/>
Password:&nbsp; <input type="password" name="password" class="login"/><br/>
<input type="submit" value="Login" <%If loggedin Then%>disabled<%End If%>/>
</form>
<!-- #include file="bottom.inc"-->